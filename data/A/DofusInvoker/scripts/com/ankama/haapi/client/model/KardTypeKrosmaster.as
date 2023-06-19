package com.ankama.haapi.client.model
{
   public class KardTypeKrosmaster
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var pedestal_id:Number = 0;
      
      public var pedestal_name:String = null;
      
      public function KardTypeKrosmaster()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeKrosmaster: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (pedestal_id: " + this.pedestal_id + ")";
         return str + (" (pedestal_name: " + this.pedestal_name + ")");
      }
   }
}
