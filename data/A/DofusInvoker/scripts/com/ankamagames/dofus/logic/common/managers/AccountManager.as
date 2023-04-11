package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AccountManager
   {
      
      private static var _singleton:AccountManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AccountManager));
       
      
      private var _accounts:Dictionary;
      
      public var achievementPoints:int = 0;
      
      public var achievementPercent:int = 0;
      
      public function AccountManager()
      {
         super();
         this._accounts = new Dictionary();
      }
      
      public static function getInstance() : AccountManager
      {
         if(!_singleton)
         {
            _singleton = new AccountManager();
         }
         return _singleton;
      }
      
      public function getIsKnowAccount(playerName:String) : Boolean
      {
         return this._accounts.hasOwnProperty(playerName);
      }
      
      public function getAccountId(playerName:String) : int
      {
         if(this._accounts[playerName])
         {
            return this._accounts[playerName].id;
         }
         return 0;
      }
      
      public function getAccountName(playerName:String) : String
      {
         if(this._accounts[playerName])
         {
            return this._accounts[playerName].name;
         }
         return "";
      }
      
      public function setAccount(playerName:String, accountId:int, accountName:String = null, accountTag:String = null) : void
      {
         this._accounts[playerName] = {
            "id":accountId,
            "name":accountName,
            "tag":accountTag
         };
      }
      
      public function setAccountFromId(playerId:Number, accountId:int, accountName:String = null) : void
      {
         var entityInfo:GameRolePlayNamedActorInformations = null;
         var _fightEntityFrame:FightEntitiesFrame = null;
         var fightInfo:GameFightFighterNamedInformations = null;
         var _roleplayEntityFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_roleplayEntityFrame)
         {
            entityInfo = _roleplayEntityFrame.getEntityInfos(playerId) as GameRolePlayNamedActorInformations;
            if(entityInfo)
            {
               this._accounts[entityInfo.name] = {
                  "id":accountId,
                  "name":accountName
               };
            }
         }
         else
         {
            _fightEntityFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(_fightEntityFrame)
            {
               fightInfo = _fightEntityFrame.getEntityInfos(playerId) as GameFightFighterNamedInformations;
               if(fightInfo)
               {
                  this._accounts[fightInfo.name] = {
                     "id":accountId,
                     "name":accountName
                  };
               }
            }
         }
      }
   }
}
