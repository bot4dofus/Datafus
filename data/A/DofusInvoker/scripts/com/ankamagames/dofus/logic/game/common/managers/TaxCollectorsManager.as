package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorComplementaryInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorWaitingForHelpInformations;
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class TaxCollectorsManager implements IDestroyable
   {
      
      private static const TYPE_TAX_COLLECTOR:int = 0;
      
      private static const TYPE_PRISM:int = 1;
      
      private static var _self:TaxCollectorsManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorsManager));
       
      
      private var _taxCollectors:Dictionary;
      
      private var _guildTaxCollectorsInFight:Dictionary;
      
      private var _allTaxCollectorsInFight:Dictionary;
      
      private var _collectedTaxCollectors:Dictionary;
      
      private var _prismsInFight:Dictionary;
      
      public var maxTaxCollectorsCount:int;
      
      public var taxCollectorsCount:int;
      
      public var taxCollectorLifePoints:int;
      
      public var taxCollectorDamagesBonuses:int;
      
      public var taxCollectorPods:int;
      
      public var taxCollectorProspecting:int;
      
      public var taxCollectorWisdom:int;
      
      public function TaxCollectorsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("TaxCollectorsManager is a singleton and should not be instanciated directly.");
         }
         this._taxCollectors = new Dictionary();
         this._guildTaxCollectorsInFight = new Dictionary();
         this._allTaxCollectorsInFight = new Dictionary();
         this._collectedTaxCollectors = new Dictionary();
         this._prismsInFight = new Dictionary();
      }
      
      public static function getInstance() : TaxCollectorsManager
      {
         if(_self == null)
         {
            _self = new TaxCollectorsManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         this._taxCollectors = new Dictionary();
         this._guildTaxCollectorsInFight = new Dictionary();
         this._allTaxCollectorsInFight = new Dictionary();
         this._collectedTaxCollectors = new Dictionary();
         this._prismsInFight = new Dictionary();
         _self = null;
      }
      
      public function get taxCollectors() : Dictionary
      {
         return this._taxCollectors;
      }
      
      public function get guildTaxCollectorsFighters() : Dictionary
      {
         return this._guildTaxCollectorsInFight;
      }
      
      public function get allTaxCollectorsInFight() : Dictionary
      {
         return this._allTaxCollectorsInFight;
      }
      
      public function get collectedTaxCollectors() : Dictionary
      {
         return this._collectedTaxCollectors;
      }
      
      public function get prismsFighters() : Dictionary
      {
         return this._prismsInFight;
      }
      
      public function setTaxCollectors(tcList:Vector.<TaxCollectorInformations>) : void
      {
         var tc:TaxCollectorInformations = null;
         this._taxCollectors = new Dictionary();
         for each(tc in tcList)
         {
            this._taxCollectors[tc.uniqueId] = TaxCollectorWrapper.create(tc);
         }
      }
      
      public function setTaxCollectorsFighters(tcList:Vector.<TaxCollectorFightersInformation>) : void
      {
         var fightTime:int = 0;
         var waitTime:Number = NaN;
         var char:Object = null;
         var tc:TaxCollectorFightersInformation = null;
         var tcWrapper:TaxCollectorWrapper = null;
         var allies:Array = new Array();
         var enemies:Array = new Array();
         var myGuildId:int = SocialFrame.getInstance().guild.guildId;
         this._guildTaxCollectorsInFight = new Dictionary();
         this._allTaxCollectorsInFight = new Dictionary();
         for each(tc in tcList)
         {
            tcWrapper = this._taxCollectors[tc.collectorId];
            if(!tcWrapper)
            {
               _log.error("Tax collector " + tc.collectorId + " doesn\'t exist IS PROBLEM");
            }
            else
            {
               fightTime = tcWrapper.fightTime;
               waitTime = tcWrapper.waitTimeForPlacement;
               allies = new Array();
               enemies = new Array();
               for each(char in tc.allyCharactersInformations)
               {
                  allies.push(char);
               }
               for each(char in tc.enemyCharactersInformations)
               {
                  enemies.push(char);
               }
               if(!tcWrapper.guild || tcWrapper.guild.guildId == myGuildId)
               {
                  if(this._guildTaxCollectorsInFight[tc.collectorId])
                  {
                     this._guildTaxCollectorsInFight[tc.collectorId].update(TYPE_TAX_COLLECTOR,tc.collectorId,allies,enemies,fightTime,waitTime,tcWrapper.nbPositionPerTeam);
                  }
                  else
                  {
                     this._guildTaxCollectorsInFight[tc.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,tc.collectorId,allies,enemies,fightTime,waitTime,tcWrapper.nbPositionPerTeam);
                  }
                  this._guildTaxCollectorsInFight[tc.collectorId].addPonyFighter(tcWrapper);
               }
               if(this._allTaxCollectorsInFight[tc.collectorId])
               {
                  this._allTaxCollectorsInFight[tc.collectorId].update(TYPE_TAX_COLLECTOR,tc.collectorId,allies,enemies,fightTime,waitTime,tcWrapper.nbPositionPerTeam);
               }
               else
               {
                  this._allTaxCollectorsInFight[tc.collectorId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,tc.collectorId,allies,enemies,fightTime,waitTime,tcWrapper.nbPositionPerTeam);
               }
               this._allTaxCollectorsInFight[tc.collectorId].addPonyFighter(tcWrapper);
            }
         }
      }
      
      public function setPrismsInFight(pList:Vector.<PrismFightersInformation>) : void
      {
         var allies:Array = null;
         var enemies:Array = null;
         var char:Object = null;
         var fightTime:int = 0;
         var pfi:PrismFightersInformation = null;
         this._prismsInFight = new Dictionary();
         for each(pfi in pList)
         {
            allies = new Array();
            enemies = new Array();
            for each(char in pfi.allyCharactersInformations)
            {
               allies.push(char);
            }
            for each(char in pfi.enemyCharactersInformations)
            {
               enemies.push(char);
            }
            fightTime = pfi.waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
            if(this._prismsInFight[pfi.subAreaId])
            {
               this._prismsInFight[pfi.subAreaId].update(TYPE_PRISM,pfi.subAreaId,allies,enemies,fightTime,pfi.waitingForHelpInfo.waitTimeForPlacement * 100,pfi.waitingForHelpInfo.nbPositionForDefensors);
            }
            else
            {
               this._prismsInFight[pfi.subAreaId] = SocialEntityInFightWrapper.create(TYPE_PRISM,pfi.subAreaId,allies,enemies,fightTime,pfi.waitingForHelpInfo.waitTimeForPlacement * 100,pfi.waitingForHelpInfo.nbPositionForDefensors);
            }
         }
      }
      
      public function updateGuild(pMaxTaxCollectorsCount:int, pTaxCollectorsCount:int, pTaxCollectorLifePoints:int, pTaxCollectorDamagesBonuses:int, pTaxCollectorPods:int, pTaxCollectorProspecting:int, pTaxCollectorWisdom:int) : void
      {
         this.maxTaxCollectorsCount = pMaxTaxCollectorsCount;
         this.taxCollectorsCount = pTaxCollectorsCount;
         this.taxCollectorLifePoints = pTaxCollectorLifePoints;
         this.taxCollectorDamagesBonuses = pTaxCollectorDamagesBonuses;
         this.taxCollectorPods = pTaxCollectorPods;
         this.taxCollectorProspecting = pTaxCollectorProspecting;
         this.taxCollectorWisdom = pTaxCollectorWisdom;
      }
      
      public function addTaxCollector(taxCollector:TaxCollectorInformations) : Boolean
      {
         var timeLeftBeforeFight:int = 0;
         var waitTimeForPlacement:int = 0;
         var complementaryInfo:TaxCollectorComplementaryInformations = null;
         var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo = null;
         var newTC:Boolean = false;
         if(this._taxCollectors[taxCollector.uniqueId])
         {
            this._taxCollectors[taxCollector.uniqueId].update(taxCollector);
         }
         else
         {
            this._taxCollectors[taxCollector.uniqueId] = TaxCollectorWrapper.create(taxCollector);
            newTC = true;
         }
         var belongsToMyGuild:Boolean = this._taxCollectors[taxCollector.uniqueId].guild == null || this._taxCollectors[taxCollector.uniqueId].guild.guildId == SocialFrame.getInstance().guild.guildId;
         if(belongsToMyGuild)
         {
            if(taxCollector.state == TaxCollectorStateEnum.STATE_COLLECTING)
            {
               delete this._guildTaxCollectorsInFight[taxCollector.uniqueId];
            }
            else
            {
               if(this._guildTaxCollectorsInFight[taxCollector.uniqueId])
               {
                  this._guildTaxCollectorsInFight[taxCollector.uniqueId].update(TYPE_TAX_COLLECTOR,taxCollector.uniqueId,new Array(),new Array());
               }
               else
               {
                  this._guildTaxCollectorsInFight[taxCollector.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,taxCollector.uniqueId);
               }
               if(taxCollector.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
               {
                  this._guildTaxCollectorsInFight[taxCollector.uniqueId].addPonyFighter(this._taxCollectors[taxCollector.uniqueId]);
               }
            }
         }
         if(taxCollector.state == TaxCollectorStateEnum.STATE_COLLECTING)
         {
            if(this._allTaxCollectorsInFight[taxCollector.uniqueId])
            {
               delete this._allTaxCollectorsInFight[taxCollector.uniqueId];
            }
         }
         else
         {
            timeLeftBeforeFight = 0;
            waitTimeForPlacement = 0;
            if(taxCollector.complements.length > 0)
            {
               for each(complementaryInfo in taxCollector.complements)
               {
                  if(complementaryInfo is TaxCollectorWaitingForHelpInformations)
                  {
                     waitingForHelpInfo = (complementaryInfo as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo;
                     if(waitingForHelpInfo == null)
                     {
                        break;
                     }
                     timeLeftBeforeFight = waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
                     waitTimeForPlacement = waitingForHelpInfo.waitTimeForPlacement * 100;
                  }
               }
            }
            if(this._allTaxCollectorsInFight[taxCollector.uniqueId])
            {
               this._allTaxCollectorsInFight[taxCollector.uniqueId].update(TYPE_TAX_COLLECTOR,taxCollector.uniqueId,new Array(),new Array(),timeLeftBeforeFight,waitTimeForPlacement);
            }
            else
            {
               this._allTaxCollectorsInFight[taxCollector.uniqueId] = SocialEntityInFightWrapper.create(TYPE_TAX_COLLECTOR,taxCollector.uniqueId,new Array(),new Array(),timeLeftBeforeFight,waitTimeForPlacement);
            }
            if(taxCollector.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
            {
               this._allTaxCollectorsInFight[taxCollector.uniqueId].addPonyFighter(this._taxCollectors[taxCollector.uniqueId]);
            }
         }
         return newTC;
      }
      
      public function addPrism(prism:PrismFightersInformation) : void
      {
         var char:Object = null;
         var fightTime:int = 0;
         var allies:Array = new Array();
         var enemies:Array = new Array();
         for each(char in prism.allyCharactersInformations)
         {
            allies.push(char);
         }
         for each(char in prism.enemyCharactersInformations)
         {
            enemies.push(char);
         }
         fightTime = prism.waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
         this._prismsInFight[prism.subAreaId] = SocialEntityInFightWrapper.create(TYPE_PRISM,prism.subAreaId,allies,enemies,fightTime,prism.waitingForHelpInfo.waitTimeForPlacement * 100,prism.waitingForHelpInfo.nbPositionForDefensors);
      }
      
      public function addFighter(pType:int, pFightId:Number, pPlayerInfo:CharacterMinimalPlusLookInformations, ally:Boolean, pDispatchHook:Boolean = true) : void
      {
         var socialEntityFight:SocialEntityInFightWrapper = null;
         var entitiesToUpdate:Array = new Array();
         if(pType == TYPE_PRISM)
         {
            entitiesToUpdate.push(this._prismsInFight[pFightId]);
         }
         else if(pType == TYPE_TAX_COLLECTOR)
         {
            if(this._guildTaxCollectorsInFight[pFightId])
            {
               entitiesToUpdate.push(this._guildTaxCollectorsInFight[pFightId]);
            }
            if(this._allTaxCollectorsInFight[pFightId])
            {
               entitiesToUpdate.push(this._allTaxCollectorsInFight[pFightId]);
            }
         }
         for each(socialEntityFight in entitiesToUpdate)
         {
            if(ally)
            {
               if(socialEntityFight.allyCharactersInformations == null)
               {
                  socialEntityFight.allyCharactersInformations = new Array();
               }
               socialEntityFight.allyCharactersInformations.push(SocialFightersWrapper.create(0,pPlayerInfo));
            }
            else
            {
               if(socialEntityFight.enemyCharactersInformations == null)
               {
                  socialEntityFight.enemyCharactersInformations = new Array();
               }
               socialEntityFight.enemyCharactersInformations.push(SocialFightersWrapper.create(1,pPlayerInfo));
            }
         }
         if(pDispatchHook)
         {
            if(ally)
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,pType,pFightId);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,pType,pFightId);
            }
         }
      }
      
      public function removeFighter(pType:int, pFightId:Number, pPlayerId:Number, ally:Boolean, pDispatchHook:Boolean = true) : void
      {
         var index:uint = 0;
         var entity:SocialEntityInFightWrapper = null;
         var allyFighter:SocialFightersWrapper = null;
         var enemyFighter:SocialFightersWrapper = null;
         var entitiesToUpdate:Array = new Array();
         if(pType == TYPE_PRISM)
         {
            entitiesToUpdate.push(this._prismsInFight[pFightId]);
         }
         else if(pType == TYPE_TAX_COLLECTOR)
         {
            if(this._guildTaxCollectorsInFight[pFightId])
            {
               entitiesToUpdate.push(this._guildTaxCollectorsInFight[pFightId]);
            }
            if(this._allTaxCollectorsInFight[pFightId])
            {
               entitiesToUpdate.push(this._allTaxCollectorsInFight[pFightId]);
            }
         }
         if(entitiesToUpdate.length == 0)
         {
            _log.error("Error ! Fighter " + pPlayerId + " cannot be removed from unknown fight " + pFightId + ".");
            return;
         }
         for each(entity in entitiesToUpdate)
         {
            index = 0;
            if(ally)
            {
               for each(allyFighter in entity.allyCharactersInformations)
               {
                  if(allyFighter.playerCharactersInformations.id == pPlayerId)
                  {
                     break;
                  }
                  index++;
               }
               entity.allyCharactersInformations.splice(index,1);
            }
            else
            {
               for each(enemyFighter in entity.enemyCharactersInformations)
               {
                  if(enemyFighter.playerCharactersInformations.id == pPlayerId)
                  {
                     break;
                  }
                  index++;
               }
               entity.enemyCharactersInformations.splice(index,1);
            }
         }
         if(pDispatchHook)
         {
            if(ally)
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightAlliesListUpdate,pType,pFightId);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,pType,pFightId);
            }
         }
      }
   }
}
