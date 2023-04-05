package com.hurlant.util.der
{
   import com.hurlant.math.BigInteger;
   import flash.utils.ByteArray;
   
   public class Integer extends BigInteger implements IAsn1Type
   {
       
      
      private var type:uint;
      
      private var len:uint;
      
      public function Integer(type:uint, length:uint, b:ByteArray)
      {
         this.type = type;
         this.len = length;
         super(b);
      }
      
      public function getLength() : uint
      {
         return this.len;
      }
      
      public function getType() : uint
      {
         return this.type;
      }
      
      override public function toString(radix:Number = 0) : String
      {
         return DER.indent + "Integer[" + this.type + "][" + this.len + "][" + super.toString(16) + "]";
      }
      
      public function toDER() : ByteArray
      {
         return null;
      }
   }
}
