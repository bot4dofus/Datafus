package com.ankama.haapi.client.model
{
   public class ShopMedia
   {
       
      
      public var id:Number = 0;
      
      public var key:String = null;
      
      public var lang:String = null;
      
      public var type:String = null;
      
      public var param:String = null;
      
      public var order:Number = 0;
      
      public var url:String = null;
      
      public function ShopMedia()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopMedia: ";
         str += " (id: " + this.id + ")";
         str += " (key: " + this.key + ")";
         str += " (lang: " + this.lang + ")";
         str += " (type: " + this.type + ")";
         str += " (param: " + this.param + ")";
         str += " (order: " + this.order + ")";
         return str + (" (url: " + this.url + ")");
      }
   }
}
