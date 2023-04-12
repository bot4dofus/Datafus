package com.ankamagames.jerakine.utils.crypto
{
   import by.blooddy.crypto.MD5;
   import by.blooddy.crypto.SHA256;
   import com.ankamagames.jerakine.utils.errors.SignatureError;
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   
   public class Signature
   {
      
      public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
      
      public static const SIGNATURE_HEADER:String = "AKSD";
       
      
      private var _key:SignatureKey;
      
      private var _keyV2:RSAKey;
      
      public function Signature(... keys)
      {
         var key:* = undefined;
         super();
         if(keys.length == 0)
         {
            throw new ArgumentError("You must provide at least one key");
         }
         for each(key in keys)
         {
            if(key is SignatureKey)
            {
               this._key = key;
            }
            else
            {
               if(!(key is RSAKey))
               {
                  throw new ArgumentError("Invalid key type");
               }
               this._keyV2 = key;
            }
         }
      }
      
      public function sign(data:IDataInput, includeData:Boolean = true) : ByteArray
      {
         var adaptedData:ByteArray = null;
         if(!this._key.canSign)
         {
            throw new Error("La clef fournit ne permet pas de signer des données");
         }
         if(data is ByteArray)
         {
            adaptedData = data as ByteArray;
         }
         else
         {
            adaptedData = new ByteArray();
            data.readBytes(adaptedData);
            adaptedData.position = 0;
         }
         var startPos:uint = adaptedData["position"];
         var hash:ByteArray = new ByteArray();
         var random:uint = Math.random() * 255;
         hash.writeByte(random);
         hash.writeUnsignedInt(adaptedData.bytesAvailable);
         var tH:Number = getTimer();
         hash.writeUTFBytes(MD5.hash(adaptedData.readUTFBytes(adaptedData.bytesAvailable)));
         for(var i:uint = 2; i < hash.length; i++)
         {
            hash[i] ^= random;
         }
         var output:ByteArray = new ByteArray();
         hash.position = 0;
         this._key.sign(hash,output,hash.length);
         var result:ByteArray = new ByteArray();
         result.writeUTF(ANKAMA_SIGNED_FILE_HEADER);
         result.writeShort(1);
         result.writeInt(output.length);
         output.position = 0;
         result.writeBytes(output);
         if(includeData)
         {
            adaptedData.position = startPos;
            result.writeBytes(adaptedData);
         }
         return result;
      }
      
      public function verify(input:IDataInput, output:ByteArray) : Boolean
      {
         var headerSize:uint = 0;
         var header:String = null;
         var headerPosition:int = 0;
         headerSize = input.readUnsignedShort();
         if(headerSize != ANKAMA_SIGNED_FILE_HEADER.length)
         {
            input["position"] = 0;
            headerPosition = input.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length;
            input["position"] = headerPosition;
            header = input.readUTFBytes(ANKAMA_SIGNED_FILE_HEADER.length);
            if(header == ANKAMA_SIGNED_FILE_HEADER)
            {
               return this.verifyV2Signature(input,output,headerPosition);
            }
         }
         else
         {
            header = input.readUTFBytes(ANKAMA_SIGNED_FILE_HEADER.length);
            if(header == ANKAMA_SIGNED_FILE_HEADER)
            {
               return this.verifyV1Signature(input,output);
            }
         }
         throw new SignatureError("Invalid header",SignatureError.INVALID_HEADER);
      }
      
      private function verifyV1Signature(input:IDataInput, output:ByteArray) : Boolean
      {
         var len:uint = 0;
         var formatVersion:uint = input.readShort();
         var sigData:ByteArray = new ByteArray();
         var decryptedHash:ByteArray = new ByteArray();
         try
         {
            len = input.readInt();
            input.readBytes(sigData,0,len);
         }
         catch(e:Error)
         {
            throw new SignatureError("Invalid signature format, not enough data.",SignatureError.INVALID_SIGNATURE);
         }
         try
         {
            this._key.verify(sigData,decryptedHash,sigData.length);
         }
         catch(e:Error)
         {
            return false;
         }
         decryptedHash.position = 0;
         var ramdomPart:int = decryptedHash.readByte();
         var hash:ByteArray = new ByteArray();
         for(var i:uint = 2; i < decryptedHash.length; i++)
         {
            decryptedHash[i] ^= ramdomPart;
         }
         var contentLen:int = decryptedHash.readUnsignedInt();
         var testedContentLen:int = input.bytesAvailable;
         var signHash:String = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
         input.readBytes(output);
         var tH:Number = getTimer();
         var contentHash:String = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
         output.position = 0;
         var result:Boolean = signHash && signHash == contentHash && contentLen == testedContentLen;
         return result;
      }
      
      private function verifyV2Signature(input:IDataInput, output:ByteArray, headerPosition:int) : Boolean
      {
         var signedDataLenght:int = 0;
         var cryptedData:ByteArray = null;
         var sigData:ByteArray = null;
         var tsDecrypt:uint = 0;
         var sigHeader:String = null;
         var sigVersion:uint = 0;
         var sigFileLenght:uint = 0;
         var hashType:uint = 0;
         var sigHash:String = null;
         var tsHash:uint = 0;
         var contentHash:String = null;
         var sigDate:Date = null;
         if(!this._keyV2)
         {
            throw new SignatureError("No key for this signature version");
         }
         try
         {
            input["position"] = headerPosition - 4;
            signedDataLenght = input.readShort();
            input["position"] = headerPosition - 4 - signedDataLenght;
            cryptedData = new ByteArray();
            input.readBytes(cryptedData,0,signedDataLenght);
            sigData = new ByteArray();
            tsDecrypt = getTimer();
            this._keyV2.verify(cryptedData,sigData,cryptedData.length);
            sigData.position = 0;
            sigHeader = sigData.readUTF();
            if(sigHeader != SIGNATURE_HEADER)
            {
               return false;
            }
            sigVersion = sigData.readByte();
            sigData.readInt();
            sigData.readInt();
            sigFileLenght = sigData.readInt();
            if(sigFileLenght != headerPosition - 4 - signedDataLenght)
            {
               return false;
            }
            hashType = sigData.readByte();
            sigHash = sigData.readUTF();
            input["position"] = 0;
            input.readBytes(output,0,headerPosition - 4 - signedDataLenght);
            tsHash = getTimer();
            switch(hashType)
            {
               case 0:
                  contentHash = MD5.hashBytes(output);
                  break;
               case 1:
                  contentHash = SHA256.hashBytes(output);
                  break;
               default:
                  return false;
            }
            output.position = 0;
            sigDate = new Date();
            sigDate.setTime(sigData.readDouble());
            if(sigHash != contentHash)
            {
               return false;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function verifySeparatedSignature(swfContent:IDataInput, signatureFile:ByteArray, output:ByteArray) : Boolean
      {
         var headerPosition:int = 0;
         var header:String = null;
         var signedDataLenght:int = 0;
         var cryptedData:ByteArray = null;
         var sigData:ByteArray = null;
         var tsDecrypt:uint = 0;
         var f:File = null;
         var fs:FileStream = null;
         var sigHeader:String = null;
         var sigVersion:uint = 0;
         var sigFileLenght:uint = 0;
         var hashType:uint = 0;
         var sigHash:String = null;
         var tsHash:uint = 0;
         var contentHash:String = null;
         var sigDate:Date = null;
         if(!this._keyV2)
         {
            throw new SignatureError("No key for this signature version");
         }
         try
         {
            headerPosition = signatureFile.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length;
            signatureFile["position"] = headerPosition;
            header = signatureFile.readUTFBytes(4);
            if(header != ANKAMA_SIGNED_FILE_HEADER)
            {
               return false;
            }
            signatureFile["position"] = headerPosition - 4;
            signedDataLenght = signatureFile.readShort();
            signatureFile["position"] = headerPosition - 4 - signedDataLenght;
            cryptedData = new ByteArray();
            signatureFile.readBytes(cryptedData,0,signedDataLenght);
            sigData = new ByteArray();
            tsDecrypt = getTimer();
            this._keyV2.verify(cryptedData,sigData,cryptedData.length);
            f = new File(File.applicationDirectory.resolvePath("log.bin").nativePath);
            fs = new FileStream();
            fs.open(f,FileMode.WRITE);
            fs.writeBytes(sigData);
            fs.close();
            sigData.position = 0;
            sigHeader = sigData.readUTF();
            if(sigHeader != SIGNATURE_HEADER)
            {
               return false;
            }
            sigVersion = sigData.readByte();
            sigData.readInt();
            sigData.readInt();
            sigFileLenght = sigData.readInt();
            if(sigFileLenght != (swfContent as ByteArray).length)
            {
               return false;
            }
            hashType = sigData.readByte();
            sigHash = sigData.readUTF();
            swfContent["position"] = 0;
            swfContent.readBytes(output,0,swfContent.bytesAvailable);
            tsHash = getTimer();
            switch(hashType)
            {
               case 0:
                  contentHash = MD5.hashBytes(output);
                  break;
               case 1:
                  contentHash = SHA256.hashBytes(output);
                  break;
               default:
                  return false;
            }
            output.position = 0;
            sigDate = new Date();
            sigDate.setTime(sigData.readDouble());
            if(sigHash != contentHash)
            {
               return false;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      private function traceData(d:ByteArray) : void
      {
         var tmp:Array = [];
         for(var i:uint = 0; i < d.length; i++)
         {
            tmp[i] = d[i];
         }
      }
   }
}
