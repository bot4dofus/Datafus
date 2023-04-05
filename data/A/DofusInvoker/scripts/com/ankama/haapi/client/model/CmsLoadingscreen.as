package com.ankama.haapi.client.model
{
   public class CmsLoadingscreen
   {
       
      
      public var id:Number = 0;
      
      public var background:String = null;
      
      public var foreground:String = null;
      
      public var url:String = null;
      
      public var count:Number = 0;
      
      public var screen:Number = 0;
      
      public var begin:Date = null;
      
      public var end:Date = null;
      
      public function CmsLoadingscreen()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsLoadingscreen: ";
         str += " (id: " + this.id + ")";
         str += " (background: " + this.background + ")";
         str += " (foreground: " + this.foreground + ")";
         str += " (url: " + this.url + ")";
         str += " (count: " + this.count + ")";
         str += " (screen: " + this.screen + ")";
         str += " (begin: " + this.begin + ")";
         return str + (" (end: " + this.end + ")");
      }
   }
}
