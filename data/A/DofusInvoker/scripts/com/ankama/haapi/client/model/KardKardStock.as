package com.ankama.haapi.client.model
{
   public class KardKardStock
   {
       
      
      public var id:Number = 0;
      
      public var kard:KardKard = null;
      
      public function KardKardStock()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardKardStock: ";
         str += " (id: " + this.id + ")";
         return str + (" (kard: " + this.kard + ")");
      }
   }
}
