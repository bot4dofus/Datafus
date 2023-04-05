package com.hurlant.util.der
{
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class ByteString extends ByteArray implements IAsn1Type
   {
       
      
      private var type:uint;
      
      private var len:uint;
      
      public function ByteString(type:uint = 4, length:uint = 0)
      {
         super();
         this.type = type;
         this.len = length;
      }
      
      public function getLength() : uint
      {
         return this.len;
      }
      
      public function getType() : uint
      {
         return this.type;
      }
      
      public function toDER() : ByteArray
      {
         return DER.wrapDER(this.type,this);
      }
      
      override public function toString() : String
      {
         return DER.indent + "ByteString[" + this.type + "][" + this.len + "][" + Hex.fromArray(this) + "]";
      }
   }
}
