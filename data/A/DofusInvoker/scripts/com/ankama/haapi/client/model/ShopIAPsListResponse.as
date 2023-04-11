package com.ankama.haapi.client.model
{
   public class ShopIAPsListResponse
   {
       
      
      public var key:String = null;
      
      public var type:String = null;
      
      public function ShopIAPsListResponse()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopIAPsListResponse: ";
         str += " (key: " + this.key + ")";
         return str + (" (type: " + this.type + ")");
      }
   }
}
