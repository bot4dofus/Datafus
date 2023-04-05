package com.ankama.haapi.client.model
{
   public class ShopMarketingDisplay
   {
       
      
      public var flag:ShopFlag = null;
      
      public var discount_percent:Number = 0;
      
      public var countdown:String = null;
      
      public function ShopMarketingDisplay()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopMarketingDisplay: ";
         str += " (flag: " + this.flag + ")";
         str += " (discount_percent: " + this.discount_percent + ")";
         return str + (" (countdown: " + this.countdown + ")");
      }
   }
}
