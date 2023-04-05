package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class NullPad implements IPad
   {
       
      
      public function NullPad()
      {
         super();
      }
      
      public function unpad(a:ByteArray) : void
      {
      }
      
      public function pad(a:ByteArray) : void
      {
      }
      
      public function setBlockSize(bs:uint) : void
      {
      }
   }
}
