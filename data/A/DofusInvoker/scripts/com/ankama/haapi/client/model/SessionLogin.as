package com.ankama.haapi.client.model
{
   public class SessionLogin
   {
       
      
      public var id:Number = 0;
      
      public var id_string:String = null;
      
      public var account:Account = null;
      
      public var game:GameAccount = null;
      
      public function SessionLogin()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "SessionLogin: ";
         str += " (id: " + this.id + ")";
         str += " (id_string: " + this.id_string + ")";
         str += " (account: " + this.account + ")";
         return str + (" (game: " + this.game + ")");
      }
   }
}
