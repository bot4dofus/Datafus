package com.ankama.haapi.client.model
{
   public class GameActionsShards
   {
       
      
      public var sublimation_item_id:Number = 0;
      
      public var special_sublimation_item_id:Number = 0;
      
      private var _slots_obj_class:Array = null;
      
      public var slots:Vector.<GameActionsSlot>;
      
      public function GameActionsShards()
      {
         this.slots = new Vector.<GameActionsSlot>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsShards: ";
         str += " (sublimation_item_id: " + this.sublimation_item_id + ")";
         str += " (special_sublimation_item_id: " + this.special_sublimation_item_id + ")";
         return str + (" (slots: " + this.slots + ")");
      }
   }
}
