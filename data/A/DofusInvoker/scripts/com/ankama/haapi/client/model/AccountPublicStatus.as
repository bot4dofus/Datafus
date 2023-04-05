package com.ankama.haapi.client.model
{
   public class AccountPublicStatus
   {
       
      
      public var id:String = null;
      
      public var value:String = null;
      
      public function AccountPublicStatus()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "AccountPublicStatus: ";
         str += " (id: " + this.id + ")";
         return str + (" (value: " + this.value + ")");
      }
   }
}
