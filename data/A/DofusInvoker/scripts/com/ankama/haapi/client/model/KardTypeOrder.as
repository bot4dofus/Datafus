package com.ankama.haapi.client.model
{
   public class KardTypeOrder
   {
       
      
      public var id:Number = 0;
      
      private var _articles_obj_class:Array = null;
      
      public var articles:Vector.<KardTypeArticle>;
      
      public function KardTypeOrder()
      {
         this.articles = new Vector.<KardTypeArticle>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeOrder: ";
         str += " (id: " + this.id + ")";
         return str + (" (articles: " + this.articles + ")");
      }
   }
}
