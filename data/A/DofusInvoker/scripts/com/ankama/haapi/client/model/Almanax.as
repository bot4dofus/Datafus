package com.ankama.haapi.client.model
{
   public class Almanax
   {
       
      
      public var event:AlmanaxEvent = null;
      
      public var zodiac:AlmanaxZodiac = null;
      
      public var month:AlmanaxMonth = null;
      
      public function Almanax()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Almanax: ";
         str += " (event: " + this.event + ")";
         str += " (zodiac: " + this.zodiac + ")";
         return str + (" (month: " + this.month + ")");
      }
   }
}
