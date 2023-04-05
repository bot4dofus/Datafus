package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public class PrintableString implements IAsn1Type
   {
       
      
      protected var type:uint;
      
      protected var len:uint;
      
      protected var str:String;
      
      public function PrintableString(type:uint, length:uint)
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
      
      public function setString(s:String) : void
      {
         this.str = s;
      }
      
      public function getString() : String
      {
         return this.str;
      }
      
      public function toString() : String
      {
         return DER.indent + this.str;
      }
      
      public function toDER() : ByteArray
      {
         return null;
      }
   }
}
