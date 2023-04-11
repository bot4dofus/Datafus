package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeCharTransfer
   {
       
      
      public var game:Number = 0;
      
      public var server_to:Number = 0;
      
      public function ShopReferenceTypeCharTransfer()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeCharTransfer: ";
         str += " (game: " + this.game + ")";
         return str + (" (server_to: " + this.server_to + ")");
      }
   }
}
