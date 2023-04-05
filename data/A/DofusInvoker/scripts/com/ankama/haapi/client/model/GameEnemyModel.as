package com.ankama.haapi.client.model
{
   public class GameEnemyModel
   {
       
      
      public var game:Number = 0;
      
      public var from_account:Number = 0;
      
      public var to_account:Number = 0;
      
      public function GameEnemyModel()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameEnemyModel: ";
         str += " (game: " + this.game + ")";
         str += " (from_account: " + this.from_account + ")";
         return str + (" (to_account: " + this.to_account + ")");
      }
   }
}
