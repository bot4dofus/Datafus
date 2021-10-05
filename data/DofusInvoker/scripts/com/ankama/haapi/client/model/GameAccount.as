package com.ankama.haapi.client.model
{
   public class GameAccount
   {
       
      
      public var game_id:Number = 0;
      
      public var total_time_elapsed:Number = 0;
      
      public var subscribed:Boolean = false;
      
      public var first_subscription_date:Date = null;
      
      public var expiration_date:Date = null;
      
      public var free_expiration_date:Date = null;
      
      public var ban_end_date:Date = null;
      
      public var added_date:Date = null;
      
      public var login_date:Date = null;
      
      public var login_ip:String = null;
      
      public function GameAccount()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameAccount: ";
         str += " (game_id: " + this.game_id + ")";
         str += " (total_time_elapsed: " + this.total_time_elapsed + ")";
         str += " (subscribed: " + this.subscribed + ")";
         str += " (first_subscription_date: " + this.first_subscription_date + ")";
         str += " (expiration_date: " + this.expiration_date + ")";
         str += " (free_expiration_date: " + this.free_expiration_date + ")";
         str += " (ban_end_date: " + this.ban_end_date + ")";
         str += " (added_date: " + this.added_date + ")";
         str += " (login_date: " + this.login_date + ")";
         return str + (" (login_ip: " + this.login_ip + ")");
      }
   }
}
