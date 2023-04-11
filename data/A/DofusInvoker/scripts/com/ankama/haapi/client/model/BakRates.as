package com.ankama.haapi.client.model
{
   public class BakRates
   {
       
      
      private var _rates_obj_class:Array = null;
      
      public var rates:Vector.<BakRate>;
      
      public function BakRates()
      {
         this.rates = new Vector.<BakRate>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "BakRates: ";
         return str + (" (rates: " + this.rates + ")");
      }
   }
}
