package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeAccountStatus
   {
       
      
      public var status:String = null;
      
      public var type:String = null;
      
      public var value:String = null;
      
      public function ShopReferenceTypeAccountStatus()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeAccountStatus: ";
         str += " (status: " + this.status + ")";
         str += " (type: " + this.type + ")";
         return str + (" (value: " + this.value + ")");
      }
   }
}
