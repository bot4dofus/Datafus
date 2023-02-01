package com.ankama.haapi.client.model
{
   public class ShopHighlight
   {
       
      
      public var id:Number = 0;
      
      private var _image_obj_class:Array = null;
      
      public var image:Vector.<ShopImage>;
      
      public var mode:String = null;
      
      public var type:String = null;
      
      public var link:String = null;
      
      public var description:String = null;
      
      public var name:String = null;
      
      public var external_category:ShopCategory = null;
      
      public var external_article:ShopArticle = null;
      
      public var external_gondolahead:ShopGondolaHead = null;
      
      public var external_direct:String = null;
      
      public function ShopHighlight()
      {
         this.image = new Vector.<ShopImage>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopHighlight: ";
         str += " (id: " + this.id + ")";
         str += " (image: " + this.image + ")";
         str += " (mode: " + this.mode + ")";
         str += " (type: " + this.type + ")";
         str += " (link: " + this.link + ")";
         str += " (description: " + this.description + ")";
         str += " (name: " + this.name + ")";
         str += " (external_category: " + this.external_category + ")";
         str += " (external_article: " + this.external_article + ")";
         str += " (external_gondolahead: " + this.external_gondolahead + ")";
         return str + (" (external_direct: " + this.external_direct + ")");
      }
   }
}
