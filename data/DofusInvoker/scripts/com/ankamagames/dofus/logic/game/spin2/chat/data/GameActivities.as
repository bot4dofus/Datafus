package com.ankamagames.dofus.logic.game.spin2.chat.data
{
   import flash.utils.Dictionary;
   
   public class GameActivities
   {
       
      
      private var _gameId:uint;
      
      private var _gameActivities:Dictionary;
      
      public function GameActivities(gameId:uint, map:Dictionary)
      {
         super();
         this._gameId = gameId;
         this._gameActivities = map;
      }
      
      public function toString() : String
      {
         var key:* = null;
         var debugMap:String = "";
         for(key in this._gameActivities)
         {
            debugMap += key + ":" + this._gameActivities[key] + "\n";
         }
         return "Game ID : " + this._gameId + "\n" + debugMap;
      }
      
      public function getGameId() : uint
      {
         return this._gameId;
      }
      
      public function getGameActivities() : Dictionary
      {
         return this._gameActivities;
      }
      
      public function getActivityValue(key:String) : String
      {
         return this._gameActivities[key];
      }
      
      public function getActivityKey(value:String) : String
      {
         var key:* = null;
         for(key in this._gameActivities)
         {
            if(this._gameActivities[key] == value)
            {
               return key;
            }
         }
         return "";
      }
   }
}
