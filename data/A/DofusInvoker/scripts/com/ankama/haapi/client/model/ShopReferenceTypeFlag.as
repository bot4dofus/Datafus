package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeFlag
   {
       
      
      public var flag_id:Number = 0;
      
      public function ShopReferenceTypeFlag()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeFlag: ";
         return str + (" (flag_id: " + this.flag_id + ")");
      }
   }
}
