package com.ankama.haapi.client.model
{
   public class CmsBackgroundImage
   {
       
      
      public var url:String = null;
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var lang:String = null;
      
      public var date:String = null;
      
      public var timestamp:Number = 0;
      
      public var date_end:String = null;
      
      public var timestamp_end:Number = 0;
      
      public var canonical_url:String = null;
      
      public var url_topic:String = null;
      
      public function CmsBackgroundImage()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsBackgroundImage: ";
         str += " (url: " + this.url + ")";
         str += " (width: " + this.width + ")";
         str += " (height: " + this.height + ")";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (lang: " + this.lang + ")";
         str += " (date: " + this.date + ")";
         str += " (timestamp: " + this.timestamp + ")";
         str += " (date_end: " + this.date_end + ")";
         str += " (timestamp_end: " + this.timestamp_end + ")";
         str += " (canonical_url: " + this.canonical_url + ")";
         return str + (" (url_topic: " + this.url_topic + ")");
      }
   }
}
