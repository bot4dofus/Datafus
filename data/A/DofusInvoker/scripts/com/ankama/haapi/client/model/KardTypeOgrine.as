package com.ankama.haapi.client.model
{
   public class KardTypeOgrine
   {
       
      
      public var quantity:Number = 0;
      
      public var forbidden:Number = 0;
      
      public function KardTypeOgrine()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeOgrine: ";
         str += " (quantity: " + this.quantity + ")";
         return str + (" (forbidden: " + this.forbidden + ")");
      }
   }
}
