package com.ankama.haapi.client.model
{
   public class AlmanaxEvent
   {
       
      
      public var id:Number = 0;
      
      public var type:String = null;
      
      public var mobile_info:String = null;
      
      public var color:String = null;
      
      public var date:Date = null;
      
      public var color_date:String = null;
      
      public var recurring:Boolean = false;
      
      public var background:Boolean = false;
      
      public var background_url:String = null;
      
      public var day_background_url:String = null;
      
      public var border_background_url:String = null;
      
      public var image_url:String = null;
      
      public var name:String = null;
      
      public var boss_image_url:String = null;
      
      public var boss_name:String = null;
      
      public var boss_text:String = null;
      
      public var ephemeris:String = null;
      
      public var rubrikabrax:String = null;
      
      public var show_fest:Boolean = false;
      
      public var fest_text:String = null;
      
      public var weight:Number = 0;
      
      public function AlmanaxEvent()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "AlmanaxEvent: ";
         str += " (id: " + this.id + ")";
         str += " (type: " + this.type + ")";
         str += " (mobile_info: " + this.mobile_info + ")";
         str += " (color: " + this.color + ")";
         str += " (date: " + this.date + ")";
         str += " (color_date: " + this.color_date + ")";
         str += " (recurring: " + this.recurring + ")";
         str += " (background: " + this.background + ")";
         str += " (background_url: " + this.background_url + ")";
         str += " (day_background_url: " + this.day_background_url + ")";
         str += " (border_background_url: " + this.border_background_url + ")";
         str += " (image_url: " + this.image_url + ")";
         str += " (name: " + this.name + ")";
         str += " (boss_image_url: " + this.boss_image_url + ")";
         str += " (boss_name: " + this.boss_name + ")";
         str += " (boss_text: " + this.boss_text + ")";
         str += " (ephemeris: " + this.ephemeris + ")";
         str += " (rubrikabrax: " + this.rubrikabrax + ")";
         str += " (show_fest: " + this.show_fest + ")";
         str += " (fest_text: " + this.fest_text + ")";
         return str + (" (weight: " + this.weight + ")");
      }
   }
}
