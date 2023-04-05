package com.ankamagames.jerakine.utils.crypto
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.util.der.PEM;
   import flash.utils.ByteArray;
   
   public class RSA
   {
       
      
      public function RSA()
      {
         super();
      }
      
      public static function publicEncrypt(key:String, baIn:ByteArray) : ByteArray
      {
         var baOut:ByteArray = new ByteArray();
         var publicKey:RSAKey = PEM.readRSAPublicKey(key);
         publicKey.encrypt(baIn,baOut,baIn.length);
         return baOut;
      }
   }
}
