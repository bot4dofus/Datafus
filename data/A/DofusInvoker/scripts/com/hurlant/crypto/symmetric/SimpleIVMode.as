package com.hurlant.crypto.symmetric
{
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class SimpleIVMode implements IMode, ICipher
   {
       
      
      protected var mode:IVMode;
      
      protected var cipher:ICipher;
      
      public function SimpleIVMode(mode:IVMode)
      {
         super();
         this.mode = mode;
         this.cipher = mode as ICipher;
      }
      
      public function getBlockSize() : uint
      {
         return this.mode.getBlockSize();
      }
      
      public function dispose() : void
      {
         this.mode.dispose();
         this.mode = null;
         this.cipher = null;
         Memory.gc();
      }
      
      public function encrypt(src:ByteArray) : void
      {
         this.cipher.encrypt(src);
         var tmp:ByteArray = new ByteArray();
         tmp.writeBytes(this.mode.IV);
         tmp.writeBytes(src);
         src.position = 0;
         src.writeBytes(tmp);
      }
      
      public function decrypt(src:ByteArray) : void
      {
         var tmp:ByteArray = new ByteArray();
         tmp.writeBytes(src,0,this.getBlockSize());
         this.mode.IV = tmp;
         tmp = new ByteArray();
         tmp.writeBytes(src,this.getBlockSize());
         this.cipher.decrypt(tmp);
         src.length = 0;
         src.writeBytes(tmp);
      }
      
      public function toString() : String
      {
         return "simple-" + this.cipher.toString();
      }
   }
}
