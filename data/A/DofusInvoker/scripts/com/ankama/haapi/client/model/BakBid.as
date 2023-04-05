package com.ankama.haapi.client.model
{
   public class BakBid
   {
       
      
      public var id:Number = 0;
      
      public var heading_id:Number = 0;
      
      public var account_id:Number = 0;
      
      public var sale_article_id:Number = 0;
      
      public var sale_quantity:Number = 0;
      
      public var sale_remaining:Number = 0;
      
      public var exchange_article_id:Number = 0;
      
      public var exchange_quantity:Number = 0;
      
      public var rate:Number = 0;
      
      public var seller_params:String = null;
      
      public var added_date:String = null;
      
      public var added_ip:String = null;
      
      public var current_status:String = null;
      
      public var current_status_date:String = null;
      
      public var current_status_account_id:Number = 0;
      
      public function BakBid()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "BakBid: ";
         str += " (id: " + this.id + ")";
         str += " (heading_id: " + this.heading_id + ")";
         str += " (account_id: " + this.account_id + ")";
         str += " (sale_article_id: " + this.sale_article_id + ")";
         str += " (sale_quantity: " + this.sale_quantity + ")";
         str += " (sale_remaining: " + this.sale_remaining + ")";
         str += " (exchange_article_id: " + this.exchange_article_id + ")";
         str += " (exchange_quantity: " + this.exchange_quantity + ")";
         str += " (rate: " + this.rate + ")";
         str += " (seller_params: " + this.seller_params + ")";
         str += " (added_date: " + this.added_date + ")";
         str += " (added_ip: " + this.added_ip + ")";
         str += " (current_status: " + this.current_status + ")";
         str += " (current_status_date: " + this.current_status_date + ")";
         return str + (" (current_status_account_id: " + this.current_status_account_id + ")");
      }
   }
}
