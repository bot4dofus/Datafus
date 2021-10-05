package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeOgrine
   {
       
      
      private var _forbiddens_obj_class:Array = null;
      
      public var forbiddens:Vector.<String>;
      
      public function ShopReferenceTypeOgrine()
      {
         this.forbiddens = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeOgrine: ";
         return str + (" (forbiddens: " + this.forbiddens + ")");
      }
   }
}
