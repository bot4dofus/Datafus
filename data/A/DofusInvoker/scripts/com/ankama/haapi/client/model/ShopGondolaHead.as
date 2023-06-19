package com.ankama.haapi.client.model
{
   public class ShopGondolaHead
   {
       
      
      private var _image_obj_class:Array = null;
      
      public var image:Vector.<ShopImage>;
      
      public var home:Boolean = false;
      
      public var main:Boolean = false;
      
      public var link:String = null;
      
      public var name:String = null;
      
      public var id:Number = 0;
      
      public function ShopGondolaHead()
      {
         this.image = new Vector.<ShopImage>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopGondolaHead: ";
         str += " (image: " + this.image + ")";
         str += " (home: " + this.home + ")";
         str += " (main: " + this.main + ")";
         str += " (link: " + this.link + ")";
         str += " (name: " + this.name + ")";
         return str + (" (id: " + this.id + ")");
      }
   }
}
