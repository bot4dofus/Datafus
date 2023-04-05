package com.ankama.haapi.client.model
{
   public class ShopDiscount
   {
       
      
      public var key:String = null;
      
      public var compare:String = null;
      
      private var _values_obj_class:Array = null;
      
      public var values:Vector.<String>;
      
      public function ShopDiscount()
      {
         this.values = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopDiscount: ";
         str += " (key: " + this.key + ")";
         str += " (compare: " + this.compare + ")";
         return str + (" (values: " + this.values + ")");
      }
   }
}
