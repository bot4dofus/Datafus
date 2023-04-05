package com.hurlant.util.der
{
   public dynamic class Set extends Sequence implements IAsn1Type
   {
       
      
      public function Set(type:uint = 49, length:uint = 0)
      {
         super(type,length);
      }
      
      override public function toString() : String
      {
         var s:String = null;
         s = DER.indent;
         DER.indent += "    ";
         var t:String = join("\n");
         DER.indent = s;
         return DER.indent + "Set[" + type + "][" + len + "][\n" + t + "\n" + s + "]";
      }
   }
}
