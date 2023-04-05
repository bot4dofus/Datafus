package com.ankama.haapi.client.model
{
   public class CmsFeed
   {
       
      
      public var message:String = null;
      
      private var _server_id_obj_class:Array = null;
      
      public var server_id:Vector.<String>;
      
      public var message_apparition_date:Date = null;
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var lang:String = null;
      
      public var date:String = null;
      
      public var timestamp:Number = 0;
      
      public var date_end:String = null;
      
      public var timestamp_end:Number = 0;
      
      public var url:String = null;
      
      public var canonical_url:String = null;
      
      public var url_topic:String = null;
      
      public function CmsFeed()
      {
         this.server_id = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsFeed: ";
         str += " (message: " + this.message + ")";
         str += " (server_id: " + this.server_id + ")";
         str += " (message_apparition_date: " + this.message_apparition_date + ")";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (lang: " + this.lang + ")";
         str += " (date: " + this.date + ")";
         str += " (timestamp: " + this.timestamp + ")";
         str += " (date_end: " + this.date_end + ")";
         str += " (timestamp_end: " + this.timestamp_end + ")";
         str += " (url: " + this.url + ")";
         str += " (canonical_url: " + this.canonical_url + ")";
         return str + (" (url_topic: " + this.url_topic + ")");
      }
   }
}
