package com.ankama.haapi.client.model
{
   import flash.utils.Dictionary;
   
   public class Character
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var experience:Number = 0;
      
      public var level:Number = 0;
      
      public var breed_id:Number = 0;
      
      public var sex_id:Number = 0;
      
      public var face_id:Number = 0;
      
      private var _images_obj_class:Dictionary = null;
      
      public var images:Vector.<String>;
      
      private var _colors_obj_class:Dictionary = null;
      
      public var colors:Vector.<Number>;
      
      public var guild:Guild = null;
      
      public function Character()
      {
         this.images = new Vector.<String>();
         this.colors = new Vector.<Number>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Character: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (experience: " + this.experience + ")";
         str += " (level: " + this.level + ")";
         str += " (breed_id: " + this.breed_id + ")";
         str += " (sex_id: " + this.sex_id + ")";
         str += " (face_id: " + this.face_id + ")";
         str += " (images: " + this.images + ")";
         str += " (colors: " + this.colors + ")";
         return str + (" (guild: " + this.guild + ")");
      }
   }
}
