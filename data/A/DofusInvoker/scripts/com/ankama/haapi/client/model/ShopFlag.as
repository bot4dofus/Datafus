package com.ankama.haapi.client.model
{
   public class ShopFlag
   {
       
      
      public var key:String = null;
      
      public var value:String = null;
      
      public function ShopFlag()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopFlag: ";
         str += " (key: " + this.key + ")";
         return str + (" (value: " + this.value + ")");
      }
   }
}
