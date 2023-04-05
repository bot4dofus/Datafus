package com.hurlant.util.der
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   
   public class PEM
   {
      
      private static const RSA_PRIVATE_KEY_HEADER:String = "-----BEGIN RSA PRIVATE KEY-----";
      
      private static const RSA_PRIVATE_KEY_FOOTER:String = "-----END RSA PRIVATE KEY-----";
      
      private static const RSA_PUBLIC_KEY_HEADER:String = "-----BEGIN PUBLIC KEY-----";
      
      private static const RSA_PUBLIC_KEY_FOOTER:String = "-----END PUBLIC KEY-----";
      
      private static const CERTIFICATE_HEADER:String = "-----BEGIN CERTIFICATE-----";
      
      private static const CERTIFICATE_FOOTER:String = "-----END CERTIFICATE-----";
       
      
      public function PEM()
      {
         super();
      }
      
      public static function readRSAPrivateKey(str:String) : RSAKey
      {
         var arr:Array = null;
         var der:ByteArray = extractBinary(RSA_PRIVATE_KEY_HEADER,RSA_PRIVATE_KEY_FOOTER,str);
         if(der == null)
         {
            return null;
         }
         var obj:* = DER.parse(der);
         if(obj is Array)
         {
            arr = obj as Array;
            return new RSAKey(arr[1],arr[2].valueOf(),arr[3],arr[4],arr[5],arr[6],arr[7],arr[8]);
         }
         return null;
      }
      
      public static function readRSAPublicKey(str:String) : RSAKey
      {
         var arr:Array = null;
         var der:ByteArray = extractBinary(RSA_PUBLIC_KEY_HEADER,RSA_PUBLIC_KEY_FOOTER,str);
         if(der == null)
         {
            return null;
         }
         var obj:* = DER.parse(der);
         if(obj is Array)
         {
            arr = obj as Array;
            if(arr[0][0].toString() != OID.RSA_ENCRYPTION)
            {
               return null;
            }
            arr[1].position = 0;
            obj = DER.parse(arr[1]);
            if(obj is Array)
            {
               arr = obj as Array;
               return new RSAKey(arr[0],arr[1]);
            }
            return null;
         }
         return null;
      }
      
      public static function readCertIntoArray(str:String) : ByteArray
      {
         return extractBinary(CERTIFICATE_HEADER,CERTIFICATE_FOOTER,str);
      }
      
      private static function extractBinary(header:String, footer:String, str:String) : ByteArray
      {
         var i:int = str.indexOf(header);
         if(i == -1)
         {
            return null;
         }
         i += header.length;
         var j:int = str.indexOf(footer);
         if(j == -1)
         {
            return null;
         }
         var b64:String = str.substring(i,j);
         b64 = b64.replace(/\s/mg,"");
         return Base64.decodeToByteArray(b64);
      }
   }
}
