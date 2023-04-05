package com.ankama.haapi.client.model
{
   public class GameActionsDefinition
   {
       
      
      public var id:Number = 0;
      
      public var category_id:Number = 0;
      
      public var name:String = null;
      
      public var restriction_id:Number = 0;
      
      private var _actions_obj_class:Array = null;
      
      public var actions:Vector.<GameActionsActionsTypeMeta>;
      
      public var online_date:Date = null;
      
      public var offline_date:Date = null;
      
      public var added_date:Date = null;
      
      public var added_account_id:Number = 0;
      
      public var modified_date:Date = null;
      
      public var modified_account_id:Number = 0;
      
      public var available_date:Date = null;
      
      private var _definition_lang_obj_class:Array = null;
      
      public var definition_lang:Vector.<String>;
      
      private var _definition_title_obj_class:Array = null;
      
      public var definition_title:Vector.<String>;
      
      private var _definition_description_obj_class:Array = null;
      
      public var definition_description:Vector.<String>;
      
      public function GameActionsDefinition()
      {
         this.actions = new Vector.<GameActionsActionsTypeMeta>();
         this.definition_lang = new Vector.<String>();
         this.definition_title = new Vector.<String>();
         this.definition_description = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsDefinition: ";
         str += " (id: " + this.id + ")";
         str += " (category_id: " + this.category_id + ")";
         str += " (name: " + this.name + ")";
         str += " (restriction_id: " + this.restriction_id + ")";
         str += " (actions: " + this.actions + ")";
         str += " (online_date: " + this.online_date + ")";
         str += " (offline_date: " + this.offline_date + ")";
         str += " (added_date: " + this.added_date + ")";
         str += " (added_account_id: " + this.added_account_id + ")";
         str += " (modified_date: " + this.modified_date + ")";
         str += " (modified_account_id: " + this.modified_account_id + ")";
         str += " (available_date: " + this.available_date + ")";
         str += " (definition_lang: " + this.definition_lang + ")";
         str += " (definition_title: " + this.definition_title + ")";
         return str + (" (definition_description: " + this.definition_description + ")");
      }
   }
}
