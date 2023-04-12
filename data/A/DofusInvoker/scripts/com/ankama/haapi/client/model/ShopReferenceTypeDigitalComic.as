package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeDigitalComic
   {
       
      
      public var viewer_id:Number = 0;
      
      public function ShopReferenceTypeDigitalComic()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeDigitalComic: ";
         return str + (" (viewer_id: " + this.viewer_id + ")");
      }
   }
}
