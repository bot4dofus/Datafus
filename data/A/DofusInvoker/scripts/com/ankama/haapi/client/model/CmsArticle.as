package com.ankama.haapi.client.model
{
   public class CmsArticle
   {
       
      
      public var image_url:String = null;
      
      public var image_background:String = null;
      
      public var background:String = null;
      
      public var subtitle:String = null;
      
      public var baseline:String = null;
      
      public var baseline_raw:String = null;
      
      public var type:String = null;
      
      public var category:String = null;
      
      public var highlighted:Boolean = false;
      
      public var highlighted_zaap:Boolean = false;
      
      public var template_key:String = null;
      
      private var _sites_obj_class:Array = null;
      
      public var sites:Vector.<String>;
      
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
      
      public function CmsArticle()
      {
         this.sites = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsArticle: ";
         str += " (image_url: " + this.image_url + ")";
         str += " (image_background: " + this.image_background + ")";
         str += " (background: " + this.background + ")";
         str += " (subtitle: " + this.subtitle + ")";
         str += " (baseline: " + this.baseline + ")";
         str += " (baseline_raw: " + this.baseline_raw + ")";
         str += " (type: " + this.type + ")";
         str += " (category: " + this.category + ")";
         str += " (highlighted: " + this.highlighted + ")";
         str += " (highlighted_zaap: " + this.highlighted_zaap + ")";
         str += " (template_key: " + this.template_key + ")";
         str += " (sites: " + this.sites + ")";
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
