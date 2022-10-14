package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeKrosmaster
   {
       
      
      public var pedestal:Number = 0;
      
      public var id:Number = 0;
      
      public function ShopReferenceTypeKrosmaster()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeKrosmaster: ";
         str += " (pedestal: " + this.pedestal + ")";
         return str + (" (id: " + this.id + ")");
      }
   }
}
