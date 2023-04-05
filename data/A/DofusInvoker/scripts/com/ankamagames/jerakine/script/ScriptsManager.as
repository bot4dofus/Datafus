package com.ankamagames.jerakine.script
{
   import com.ankamagames.jerakine.interfaces.IScriptsPlayer;
   import flash.utils.Dictionary;
   
   public class ScriptsManager
   {
      
      private static var _self:ScriptsManager;
      
      public static const LUA_PLAYER:String = "LUA_PLAYER";
       
      
      private var _players:Dictionary;
      
      private var _apis:Dictionary;
      
      public function ScriptsManager()
      {
         this._players = new Dictionary();
         this._apis = new Dictionary();
         super();
      }
      
      public static function getInstance() : ScriptsManager
      {
         if(!_self)
         {
            _self = new ScriptsManager();
         }
         return _self;
      }
      
      public function addPlayer(pPlayerType:String, pPlayer:IScriptsPlayer) : void
      {
         this._players[pPlayerType] = pPlayer;
      }
      
      public function getPlayer(pPlayerType:String) : IScriptsPlayer
      {
         return this._players[pPlayerType];
      }
      
      public function addPlayerApi(pPlayer:IScriptsPlayer, pApiId:String, pApi:*) : void
      {
         if(!this._apis[pPlayer])
         {
            this._apis[pPlayer] = new Dictionary();
         }
         this._apis[pPlayer][pApiId] = pApi;
         pPlayer.addApi(pApiId,pApi);
      }
      
      public function getPlayerApi(pPlayer:IScriptsPlayer, pApiId:String) : *
      {
         var api:* = undefined;
         if(this._apis[pPlayer])
         {
            api = this._apis[pPlayer][pApiId];
         }
         return api;
      }
      
      public function playScript(pPlayerType:String, pScript:String) : void
      {
         this._players[pPlayerType].playScript(pScript);
      }
      
      public function playFile(pPlayerType:String, pScriptUri:String) : void
      {
         this._players[pPlayerType].playFile(pScriptUri);
      }
   }
}
