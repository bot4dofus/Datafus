package com.ankama.haapi.client.model
{
   public class ShopArticlesList
   {
       
      
      public var total_count:Number = 0;
      
      private var _articles_obj_class:Array = null;
      
      public var articles:Vector.<ShopArticle>;
      
      public function ShopArticlesList()
      {
         this.articles = new Vector.<ShopArticle>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopArticlesList: ";
         str += " (total_count: " + this.total_count + ")";
         return str + (" (articles: " + this.articles + ")");
      }
   }
}
