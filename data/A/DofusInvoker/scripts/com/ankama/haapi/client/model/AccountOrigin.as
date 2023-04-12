package com.ankama.haapi.client.model
{
   public class AccountOrigin
   {
      
      public static const TypeEnum_game:String = "game";
       
      
      public var type:String = null;
      
      public var value:String = null;
      
      public function AccountOrigin()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "AccountOrigin: ";
         str += " (type: " + this.type + ")";
         return str + (" (value: " + this.value + ")");
      }
   }
}
