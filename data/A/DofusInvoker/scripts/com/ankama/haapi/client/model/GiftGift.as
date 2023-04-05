package com.ankama.haapi.client.model
{
   public class GiftGift
   {
       
      
      public var id:Number = 0;
      
      public var action_id:Number = 0;
      
      public var game_id:Number = 0;
      
      public var type:Number = 0;
      
      public var params:String = null;
      
      public var description:String = null;
      
      public var text:String = null;
      
      public var title:String = null;
      
      public var version_restriction:String = null;
      
      private var _server_limitation_obj_class:Array = null;
      
      public var server_limitation:Vector.<Number>;
      
      public var distribution:String = null;
      
      private var _pictures_obj_class:Array = null;
      
      public var pictures:Vector.<String>;
      
      public function GiftGift()
      {
         this.server_limitation = new Vector.<Number>();
         this.pictures = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GiftGift: ";
         str += " (id: " + this.id + ")";
         str += " (action_id: " + this.action_id + ")";
         str += " (game_id: " + this.game_id + ")";
         str += " (type: " + this.type + ")";
         str += " (params: " + this.params + ")";
         str += " (description: " + this.description + ")";
         str += " (text: " + this.text + ")";
         str += " (title: " + this.title + ")";
         str += " (version_restriction: " + this.version_restriction + ")";
         str += " (server_limitation: " + this.server_limitation + ")";
         str += " (distribution: " + this.distribution + ")";
         return str + (" (pictures: " + this.pictures + ")");
      }
   }
}
