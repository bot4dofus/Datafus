package com.ankama.haapi.client.model
{
   public class CmsArticleMeta
   {
       
      
      public var body:String = null;
      
      public var content:String = null;
      
      public var previousArticleUrl:String = null;
      
      public var previousArticleId:Number = 0;
      
      public var nextArticleUrl:String = null;
      
      public var nextArticleId:Number = 0;
      
      public var forumTopicId:Number = 0;
      
      public var forumPostCount:Number = 0;
      
      public var image_url:String = null;
      
      public var image_background:String = null;
      
      public var background:CmsBackground = null;
      
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
      
      public var detail:String = null;
      
      public function CmsArticleMeta()
      {
         this.sites = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsArticleMeta: ";
         str += " (body: " + this.body + ")";
         str += " (content: " + this.content + ")";
         str += " (previousArticleUrl: " + this.previousArticleUrl + ")";
         str += " (previousArticleId: " + this.previousArticleId + ")";
         str += " (nextArticleUrl: " + this.nextArticleUrl + ")";
         str += " (nextArticleId: " + this.nextArticleId + ")";
         str += " (forumTopicId: " + this.forumTopicId + ")";
         str += " (forumPostCount: " + this.forumPostCount + ")";
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
         str += " (url_topic: " + this.url_topic + ")";
         return str + (" (detail: " + this.detail + ")");
      }
   }
}
