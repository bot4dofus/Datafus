package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CFBMode extends IVMode implements IMode
   {
       
      
      public function CFBMode(key:ISymmetricKey, padding:IPad = null)
      {
         super(key,null);
      }
      
      public function encrypt(src:ByteArray) : void
      {
         var chunk:uint = 0;
         var j:uint = 0;
         var l:uint = src.length;
         var vector:ByteArray = getIV4e();
         for(var i:uint = 0; i < src.length; i += blockSize)
         {
            key.encrypt(vector);
            chunk = i + blockSize < l ? uint(blockSize) : uint(l - i);
            for(j = 0; j < chunk; j++)
            {
               src[i + j] ^= vector[j];
            }
            vector.position = 0;
            vector.writeBytes(src,i,chunk);
         }
      }
      
      public function decrypt(src:ByteArray) : void
      {
         var chunk:uint = 0;
         var j:uint = 0;
         var l:uint = src.length;
         var vector:ByteArray = getIV4d();
         var tmp:ByteArray = new ByteArray();
         for(var i:uint = 0; i < src.length; i += blockSize)
         {
            key.encrypt(vector);
            chunk = i + blockSize < l ? uint(blockSize) : uint(l - i);
            tmp.position = 0;
            tmp.writeBytes(src,i,chunk);
            for(j = 0; j < chunk; j++)
            {
               src[i + j] ^= vector[j];
            }
            vector.position = 0;
            vector.writeBytes(tmp);
         }
      }
      
      public function toString() : String
      {
         return key.toString() + "-cfb";
      }
   }
}
