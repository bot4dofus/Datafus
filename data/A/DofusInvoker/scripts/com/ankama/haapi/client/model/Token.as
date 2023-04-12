package com.ankama.haapi.client.model
{
   public class Token
   {
       
      
      public var token:String = null;
      
      public function Token()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Token: ";
         return str + (" (token: " + this.token + ")");
      }
   }
}
