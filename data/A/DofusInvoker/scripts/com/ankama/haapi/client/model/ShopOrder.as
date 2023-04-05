package com.ankama.haapi.client.model
{
   public class ShopOrder
   {
       
      
      public var id:Number = 0;
      
      public var status:String = null;
      
      private var _articles_obj_class:Array = null;
      
      public var articles:Vector.<ShopOrderArticle>;
      
      public function ShopOrder()
      {
         this.articles = new Vector.<ShopOrderArticle>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopOrder: ";
         str += " (id: " + this.id + ")";
         str += " (status: " + this.status + ")";
         return str + (" (articles: " + this.articles + ")");
      }
   }
}
