package com.ankama.haapi.client.model
{
   public class ShopHome
   {
       
      
      private var _categories_obj_class:Array = null;
      
      public var categories:Vector.<ShopCategory>;
      
      private var _gondolahead_main_obj_class:Array = null;
      
      public var gondolahead_main:Vector.<ShopGondolaHead>;
      
      private var _gondolahead_article_obj_class:Array = null;
      
      public var gondolahead_article:Vector.<ShopArticle>;
      
      private var _hightlight_carousel_obj_class:Array = null;
      
      public var hightlight_carousel:Vector.<ShopHighlight>;
      
      private var _hightlight_image_obj_class:Array = null;
      
      public var hightlight_image:Vector.<ShopHighlight>;
      
      private var _hightlight_popup_obj_class:Array = null;
      
      public var hightlight_popup:Vector.<ShopHighlight>;
      
      public function ShopHome()
      {
         this.categories = new Vector.<ShopCategory>();
         this.gondolahead_main = new Vector.<ShopGondolaHead>();
         this.gondolahead_article = new Vector.<ShopArticle>();
         this.hightlight_carousel = new Vector.<ShopHighlight>();
         this.hightlight_image = new Vector.<ShopHighlight>();
         this.hightlight_popup = new Vector.<ShopHighlight>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopHome: ";
         str += " (categories: " + this.categories + ")";
         str += " (gondolahead_main: " + this.gondolahead_main + ")";
         str += " (gondolahead_article: " + this.gondolahead_article + ")";
         str += " (hightlight_carousel: " + this.hightlight_carousel + ")";
         str += " (hightlight_image: " + this.hightlight_image + ")";
         return str + (" (hightlight_popup: " + this.hightlight_popup + ")");
      }
   }
}
