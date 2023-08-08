package com.ankama.haapi.client.model
{
   public class SessionAnonymous
   {
       
      
      public var id:String = null;
      
      public var game_id:Number = 0;
      
      public var date:Date = null;
      
      public function SessionAnonymous()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "SessionAnonymous: ";
         str += " (id: " + this.id + ")";
         str += " (game_id: " + this.game_id + ")";
         return str + (" (date: " + this.date + ")");
      }
   }
}
