package com.ankama.haapi.client.model
{
   public class KardTypeVirtualSubscription
   {
       
      
      public var game:Number = 0;
      
      public var quantity:Number = 0;
      
      public function KardTypeVirtualSubscription()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeVirtualSubscription: ";
         str += " (game: " + this.game + ")";
         return str + (" (quantity: " + this.quantity + ")");
      }
   }
}
