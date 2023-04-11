package com.ankama.haapi.client.model
{
   public class ShopOrderArticle
   {
       
      
      public var article_id:Number = 0;
      
      public var article_key:String = null;
      
      public function ShopOrderArticle()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopOrderArticle: ";
         str += " (article_id: " + this.article_id + ")";
         return str + (" (article_key: " + this.article_key + ")");
      }
   }
}
