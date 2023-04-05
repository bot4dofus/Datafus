package com.ankama.haapi.client.model
{
   public class ShopPrice
   {
       
      
      public var id:Number = 0;
      
      public var original_price:Number = 0.0;
      
      public var price:Number = 0.0;
      
      public var currency:String = null;
      
      public var country:String = null;
      
      public var paymentmode:String = null;
      
      public function ShopPrice()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopPrice: ";
         str += " (id: " + this.id + ")";
         str += " (original_price: " + this.original_price + ")";
         str += " (price: " + this.price + ")";
         str += " (currency: " + this.currency + ")";
         str += " (country: " + this.country + ")";
         return str + (" (paymentmode: " + this.paymentmode + ")");
      }
   }
}
