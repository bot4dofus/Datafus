package com.ankama.haapi.client.model
{
   public class GameActionsActionsTypeMeta
   {
       
      
      public var destination_account_id:Number = 0;
      
      public var type:String = null;
      
      public var quantity:Number = 0;
      
      public var context:GameActionsActionsContext = null;
      
      public var theme_id:Number = 0;
      
      public var item_id:Number = 0;
      
      public var effect:String = null;
      
      public var bond:Number = 0;
      
      public var distribution:String = null;
      
      public var character_id:Number = 0;
      
      public var kard_id:Number = 0;
      
      public var booster_guid:String = null;
      
      public var server_id:Number = 0;
      
      public var tradingcard_id:String = null;
      
      public var customisation_id:Number = 0;
      
      public var god_id:Number = 0;
      
      public var account_id:Number = 0;
      
      public var figure_id:Number = 0;
      
      public var pedestral_id:Number = 0;
      
      public var bind_type:String = null;
      
      public var consume_type:String = null;
      
      public var companion_xp:Number = 0;
      
      public var pet_xp:Number = 0;
      
      public var gems:GameActionsGems = null;
      
      public var shards:GameActionsShards = null;
      
      public var item_type_id:Number = 0;
      
      public function GameActionsActionsTypeMeta()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsActionsTypeMeta: ";
         str += " (destination_account_id: " + this.destination_account_id + ")";
         str += " (type: " + this.type + ")";
         str += " (quantity: " + this.quantity + ")";
         str += " (context: " + this.context + ")";
         str += " (theme_id: " + this.theme_id + ")";
         str += " (item_id: " + this.item_id + ")";
         str += " (effect: " + this.effect + ")";
         str += " (bond: " + this.bond + ")";
         str += " (distribution: " + this.distribution + ")";
         str += " (character_id: " + this.character_id + ")";
         str += " (kard_id: " + this.kard_id + ")";
         str += " (booster_guid: " + this.booster_guid + ")";
         str += " (server_id: " + this.server_id + ")";
         str += " (tradingcard_id: " + this.tradingcard_id + ")";
         str += " (customisation_id: " + this.customisation_id + ")";
         str += " (god_id: " + this.god_id + ")";
         str += " (account_id: " + this.account_id + ")";
         str += " (figure_id: " + this.figure_id + ")";
         str += " (pedestral_id: " + this.pedestral_id + ")";
         str += " (bind_type: " + this.bind_type + ")";
         str += " (consume_type: " + this.consume_type + ")";
         str += " (companion_xp: " + this.companion_xp + ")";
         str += " (pet_xp: " + this.pet_xp + ")";
         str += " (gems: " + this.gems + ")";
         str += " (shards: " + this.shards + ")";
         return str + (" (item_type_id: " + this.item_type_id + ")");
      }
   }
}
