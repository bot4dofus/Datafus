package com.ankama.haapi.client.model
{
   public class ShopImage
   {
       
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public var url:String = null;
      
      public function ShopImage()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopImage: ";
         str += " (width: " + this.width + ")";
         str += " (height: " + this.height + ")";
         return str + (" (url: " + this.url + ")");
      }
   }
}
