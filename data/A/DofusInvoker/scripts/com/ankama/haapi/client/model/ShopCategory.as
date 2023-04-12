package com.ankama.haapi.client.model
{
   public class ShopCategory
   {
       
      
      public var id:Number = 0;
      
      public var key:String = null;
      
      public var name:String = null;
      
      public var displaymode:String = null;
      
      public var description:String = null;
      
      public var url:String = null;
      
      private var _child_obj_class:Array = null;
      
      public var child:Vector.<ShopCategory>;
      
      public function ShopCategory()
      {
         this.child = new Vector.<ShopCategory>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopCategory: ";
         str += " (id: " + this.id + ")";
         str += " (key: " + this.key + ")";
         str += " (name: " + this.name + ")";
         str += " (displaymode: " + this.displaymode + ")";
         str += " (description: " + this.description + ")";
         str += " (url: " + this.url + ")";
         return str + (" (child: " + this.child + ")");
      }
   }
}
