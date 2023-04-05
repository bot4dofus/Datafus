package com.ankama.haapi.client.model
{
   public class GameActionsSlot
   {
       
      
      public var position:Number = 0;
      
      public var item_id:Number = 0;
      
      public var color:Number = 0;
      
      public var shards_amount:Number = 0;
      
      public function GameActionsSlot()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsSlot: ";
         str += " (position: " + this.position + ")";
         str += " (item_id: " + this.item_id + ")";
         str += " (color: " + this.color + ")";
         return str + (" (shards_amount: " + this.shards_amount + ")");
      }
   }
}
