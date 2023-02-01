package com.ankama.haapi.client.model
{
   public class KardTypeVirtualSubscriptionLevel
   {
       
      
      public var game:Number = 0;
      
      public var quantity:Number = 0;
      
      public var level:Number = 0;
      
      public var server:Number = 0;
      
      public function KardTypeVirtualSubscriptionLevel()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeVirtualSubscriptionLevel: ";
         str += " (game: " + this.game + ")";
         str += " (quantity: " + this.quantity + ")";
         str += " (level: " + this.level + ")";
         return str + (" (server: " + this.server + ")");
      }
   }
}
