package com.ankamagames.berilia.managers
{
   import by.blooddy.crypto.MD5;
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.ECBMode;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   
   public class ThemeInstallerSecurity
   {
      
      private static const ONE_KILOBYTES:uint = 1024;
      
      private static const ONE_MEGABYTES:uint = 1024 * 1024;
       
      
      public function ThemeInstallerSecurity()
      {
         super();
      }
      
      public static function checkSecurity(folderFile:File) : Boolean
      {
         return new File(folderFile.url + File.separator + getKey(folderFile.url) + ".txt").exists;
      }
      
      public static function createSecurity(folderFile:File) : void
      {
         var writeStream:FileStream = new FileStream();
         writeStream.open(new File(folderFile.url + File.separator + getKey(folderFile.url) + ".txt"),FileMode.WRITE);
         writeStream.close();
      }
      
      private static function getKey(token:String) : String
      {
         var dataToEncrypt:ByteArray = new ByteArray();
         dataToEncrypt.writeUTF(token);
         dataToEncrypt.position = 0;
         var key:ByteArray = new ByteArray();
         key.writeByte(123);
         key.writeByte(174);
         key.writeByte(87);
         key.writeByte(35);
         key.writeByte(78);
         key.writeByte(45);
         key.writeByte(94);
         key.writeByte(243);
         key.writeByte(78);
         key.writeByte(222);
         key.writeByte(147);
         key.writeByte(12);
         key.writeByte(47);
         key.writeByte(171);
         key.writeByte(251);
         key.writeByte(87);
         var aesKey:AESKey = new AESKey(key);
         var ecb:ECBMode = new ECBMode(aesKey);
         ecb.encrypt(dataToEncrypt);
         dataToEncrypt.position = 0;
         return MD5.hashBytes(dataToEncrypt);
      }
      
      public static function isValidFile(extension:String, data:ByteArray) : Boolean
      {
         var startPosition:uint = data.position;
         var isValid:* = false;
         switch(extension.toLowerCase())
         {
            case "png":
               if(data.length < 3 * ONE_MEGABYTES)
               {
                  isValid = Boolean(isValidPNG(data));
                  if(!isValid)
                  {
                     data.position = startPosition;
                     isValid = Boolean(isValidJPEG(data));
                  }
               }
               break;
            case "jpg":
            case "jpeg":
               if(data.length < 2 * ONE_MEGABYTES)
               {
                  isValid = Boolean(isValidJPEG(data));
                  if(!isValid)
                  {
                     data.position = startPosition;
                     isValid = Boolean(isValidPNG(data));
                  }
               }
               break;
            case "swf":
               isValid = Boolean(isValidSWF(data) && data.length < 3 * ONE_MEGABYTES);
               break;
            case "txt":
            case "xml":
            case "xmls":
            case "dt":
               isValid = data.length < 100 * ONE_KILOBYTES;
               break;
            default:
               isValid = data.length < ONE_MEGABYTES;
         }
         data.position = startPosition;
         return isValid;
      }
      
      private static function isValidSWF(data:ByteArray) : Boolean
      {
         var header:String = null;
         try
         {
            header = data.readUTFBytes(3);
         }
         catch(e:Error)
         {
            return false;
         }
         return header == "CWS" || header == "FWS" || header == "ZWS";
      }
      
      public static function isValidPNG(data:ByteArray) : Boolean
      {
         var b1:uint = 0;
         var b2:uint = 0;
         try
         {
            b1 = data.readInt();
            b2 = data.readInt();
            if(b1 == 2303741511 && b2 == 218765834)
            {
               return true;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      public static function isValidJPEG(data:ByteArray) : Boolean
      {
         var b1:uint = 0;
         var b2:uint = 0;
         try
         {
            b1 = data.readByte();
            b2 = data.readByte();
            if((b1 & 255) != 255 || (b2 & 255) != 216)
            {
               return false;
            }
            data.position = data.length - 2;
            b1 = data.readByte();
            b2 = data.readByte();
            if((b1 & 255) != 255 || (b2 & 255) != 217)
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
   }
}
