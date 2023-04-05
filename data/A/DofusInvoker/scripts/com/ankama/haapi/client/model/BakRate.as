package com.ankama.haapi.client.model
{
   public class BakRate
   {
      
      public static const TypeEnum_OGRINES_FOR_KAMAS:String = "OGRINES_FOR_KAMAS";
      
      public static const TypeEnum_KAMAS_FOR_OGRINES:String = "KAMAS_FOR_OGRINES";
       
      
      public var type:String = null;
      
      public var rate:Number = 0;
      
      public function BakRate()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "BakRate: ";
         str += " (type: " + this.type + ")";
         return str + (" (rate: " + this.rate + ")");
      }
   }
}
