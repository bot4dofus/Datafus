package com.ankama.haapi.client.model
{
   public class CmsBackground
   {
       
      
      public var link:String = null;
      
      public var title:String = null;
      
      public var sub_title:String = null;
      
      public var position:String = null;
      
      public var color:String = null;
      
      public var countdown_timestamp:Number = 0;
      
      public var countdown_accuracy:String = null;
      
      public var background_image:CmsBackgroundImage = null;
      
      public var background_banner:CmsBackgroundImage = null;
      
      public var background_mobile:CmsBackgroundImage = null;
      
      public var background_internal:CmsBackgroundImage = null;
      
      public var video_mp4:CmsBackgroundVideo = null;
      
      public var video_webm:CmsBackgroundVideo = null;
      
      public var video_ogg:CmsBackgroundVideo = null;
      
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
      
      public function CmsBackground()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsBackground: ";
         str += " (link: " + this.link + ")";
         str += " (title: " + this.title + ")";
         str += " (sub_title: " + this.sub_title + ")";
         str += " (position: " + this.position + ")";
         str += " (color: " + this.color + ")";
         str += " (countdown_timestamp: " + this.countdown_timestamp + ")";
         str += " (countdown_accuracy: " + this.countdown_accuracy + ")";
         str += " (background_image: " + this.background_image + ")";
         str += " (background_banner: " + this.background_banner + ")";
         str += " (background_mobile: " + this.background_mobile + ")";
         str += " (background_internal: " + this.background_internal + ")";
         str += " (video_mp4: " + this.video_mp4 + ")";
         str += " (video_webm: " + this.video_webm + ")";
         str += " (video_ogg: " + this.video_ogg + ")";
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
