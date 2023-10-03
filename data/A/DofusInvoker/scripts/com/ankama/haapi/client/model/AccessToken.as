package com.ankama.haapi.client.model
{
   public class AccessToken
   {
       
      
      public var token:String = null;
      
      public function AccessToken()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "AccessToken: ";
         return str + (" (token: " + this.token + ")");
      }
   }
}
