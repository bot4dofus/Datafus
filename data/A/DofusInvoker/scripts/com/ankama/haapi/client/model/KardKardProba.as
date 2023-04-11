package com.ankama.haapi.client.model
{
   public class KardKardProba
   {
       
      
      public var kard:KardKard = null;
      
      public var probability:Number = 0.0;
      
      public var rarity:String = null;
      
      public function KardKardProba()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardKardProba: ";
         str += " (kard: " + this.kard + ")";
         str += " (probability: " + this.probability + ")";
         return str + (" (rarity: " + this.rarity + ")");
      }
   }
}
