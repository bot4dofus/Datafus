package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class OFBMode extends IVMode implements IMode
   {
       
      
      public function OFBMode(key:ISymmetricKey, padding:IPad = null)
      {
         super(key,null);
      }
      
      public function encrypt(src:ByteArray) : void
      {
         var vector:ByteArray = getIV4e();
         this.core(src,vector);
      }
      
      public function decrypt(src:ByteArray) : void
      {
         var vector:ByteArray = getIV4d();
         this.core(src,vector);
      }
      
      private function core(src:ByteArray, iv:ByteArray) : void
      {
         var chunk:uint = 0;
         var j:uint = 0;
         var l:uint = src.length;
         var tmp:ByteArray = new ByteArray();
         for(var i:uint = 0; i < src.length; i += blockSize)
         {
            key.encrypt(iv);
            tmp.position = 0;
            tmp.writeBytes(iv);
            chunk = i + blockSize < l ? uint(blockSize) : uint(l - i);
            for(j = 0; j < chunk; j++)
            {
               src[i + j] ^= iv[j];
            }
            iv.position = 0;
            iv.writeBytes(tmp);
         }
      }
      
      public function toString() : String
      {
         return key.toString() + "-ofb";
      }
   }
}
