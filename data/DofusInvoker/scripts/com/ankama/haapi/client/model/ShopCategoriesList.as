package com.ankama.haapi.client.model
{
   public class ShopCategoriesList
   {
       
      
      public var total_count:Number = 0;
      
      private var _categories_obj_class:Array = null;
      
      public var categories:Vector.<ShopCategory>;
      
      public function ShopCategoriesList()
      {
         this.categories = new Vector.<ShopCategory>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopCategoriesList: ";
         str += " (total_count: " + this.total_count + ")";
         return str + (" (categories: " + this.categories + ")");
      }
   }
}
