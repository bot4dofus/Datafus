package com.ankama.haapi.client.model
{
   import flash.utils.Dictionary;
   
   public class ShopReferenceTypeNothing
   {
       
      
      private var _data_obj_class:Dictionary = null;
      
      public var data:Vector.<String>;
      
      public function ShopReferenceTypeNothing()
      {
         this.data = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeNothing: ";
         return str + (" (data: " + this.data + ")");
      }
   }
}
