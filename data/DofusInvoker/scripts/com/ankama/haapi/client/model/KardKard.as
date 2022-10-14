package com.ankama.haapi.client.model
{
   public class KardKard
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var image:String = null;
      
      public var description:String = null;
      
      public var type:String = null;
      
      private var _kards_obj_class:Array = null;
      
      public var kards:Vector.<KardKardProba>;
      
      private var _kard_multiple_obj_class:Array = null;
      
      public var kard_multiple:Vector.<KardKard>;
      
      public var kard_krosmaster:KardTypeKrosmaster = null;
      
      public var kard_game_action:KardTypeAction = null;
      
      public var kard_action:KardTypeAction = null;
      
      public var kard_virtual_subscription_level:KardTypeVirtualSubscriptionLevel = null;
      
      public var kard_virtual_subscription:KardTypeVirtualSubscription = null;
      
      public function KardKard()
      {
         this.kards = new Vector.<KardKardProba>();
         this.kard_multiple = new Vector.<KardKard>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardKard: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (image: " + this.image + ")";
         str += " (description: " + this.description + ")";
         str += " (type: " + this.type + ")";
         str += " (kards: " + this.kards + ")";
         str += " (kard_multiple: " + this.kard_multiple + ")";
         str += " (kard_krosmaster: " + this.kard_krosmaster + ")";
         str += " (kard_game_action: " + this.kard_game_action + ")";
         str += " (kard_action: " + this.kard_action + ")";
         str += " (kard_virtual_subscription_level: " + this.kard_virtual_subscription_level + ")";
         return str + (" (kard_virtual_subscription: " + this.kard_virtual_subscription + ")");
      }
   }
}
