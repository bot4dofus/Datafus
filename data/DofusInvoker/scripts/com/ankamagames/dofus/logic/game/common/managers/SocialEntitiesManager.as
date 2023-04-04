package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.TaxCollectorWrapper;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.BreedEnum;
   import com.ankamagames.dofus.network.enums.SocialFightTypeEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFight;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SocialEntitiesManager implements IDestroyable
   {
      
      private static var _self:SocialEntitiesManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialEntitiesManager));
       
      
      private var _taxCollectors:Dictionary;
      
      private var _taxCollectorsInFight:Dictionary;
      
      private var _collectedTaxCollectors:Dictionary;
      
      private var _prisms:Dictionary;
      
      private var _prismsInFight:Dictionary;
      
      public function SocialEntitiesManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("SocialEntitiesManager is a singleton and should not be instanciated directly.");
         }
         this._taxCollectors = new Dictionary();
         this._taxCollectorsInFight = new Dictionary();
         this._collectedTaxCollectors = new Dictionary();
         this._prisms = new Dictionary();
         this._prismsInFight = new Dictionary();
      }
      
      public static function getInstance() : SocialEntitiesManager
      {
         if(_self == null)
         {
            _self = new SocialEntitiesManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         this._taxCollectors = new Dictionary();
         this._taxCollectorsInFight = new Dictionary();
         this._collectedTaxCollectors = new Dictionary();
         this._prisms = new Dictionary();
         this._prismsInFight = new Dictionary();
         _self = null;
      }
      
      public function cleanTaxCollectorsInfos() : void
      {
         this._taxCollectors = new Dictionary();
         this._taxCollectorsInFight = new Dictionary();
         this._collectedTaxCollectors = new Dictionary();
      }
      
      public function get taxCollectors() : Dictionary
      {
         return this._taxCollectors;
      }
      
      public function get taxCollectorsInFight() : Dictionary
      {
         return this._taxCollectorsInFight;
      }
      
      public function get collectedTaxCollectors() : Dictionary
      {
         return this._collectedTaxCollectors;
      }
      
      public function get prisms() : Dictionary
      {
         return this._prisms;
      }
      
      public function get prismsInFight() : Dictionary
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
      
      public function addTaxCollector(taxCollector:TaxCollectorInformations) : Boolean
      {
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
         if(taxCollector.state == TaxCollectorStateEnum.STATE_COLLECTING)
         {
            if(this._taxCollectorsInFight[taxCollector.uniqueId])
            {
               delete this._taxCollectorsInFight[taxCollector.uniqueId];
            }
         }
         return newTC;
      }
      
      public function removeTaxCollector(tcId:uint) : void
      {
         delete this._taxCollectors[tcId];
      }
      
      public function addOrUpdatePrism(prismInfo:PrismGeolocalizedInformation) : void
      {
         var ind:int = 0;
         var prism:PrismSubAreaWrapper = this._prisms[prismInfo.subAreaId];
         if(prism && prism.alliance)
         {
            ind = prism.alliance.prismIds.indexOf(prismInfo.subAreaId);
            if(ind != -1)
            {
               prism.alliance.prismIds.splice(ind,1);
            }
         }
         prism = PrismSubAreaWrapper.create(prismInfo);
         if(prism.alliance)
         {
            prism.alliance.prismIds.push(prismInfo.subAreaId);
         }
         this._prisms[prism.subAreaId] = prism;
      }
      
      public function removePrism(prismSubareaId:uint) : void
      {
         var ind:int = 0;
         var prism:PrismSubAreaWrapper = this._prisms[prismSubareaId];
         if(prism && prism.alliance)
         {
            ind = prism.alliance.prismIds.indexOf(prismSubareaId);
            if(ind != -1)
            {
               prism.alliance.prismIds.splice(ind,1);
            }
         }
         delete this._prisms[prismSubareaId];
      }
      
      public function setFightingEntities(entities:Vector.<SocialFight>) : void
      {
         var character:CharacterMinimalPlusLookInformations = null;
         var data:Dictionary = null;
         var sf:SocialFight = null;
         var firstNameId:Number = NaN;
         var lastNameId:Number = NaN;
         var allies:Array = [];
         var enemies:Array = [];
         this._prismsInFight = new Dictionary();
         this._taxCollectorsInFight = new Dictionary();
         for each(sf in entities)
         {
            allies = [];
            enemies = [];
            data = this.getFightingList(sf.socialFightInfo.fightType);
            for each(character in sf.attackers)
            {
               enemies.push(character);
            }
            for each(character in sf.defenders)
            {
               if(character.breed == BreedEnum.TAX_COLLECTOR)
               {
                  firstNameId = this.getTaxCollectorNameId(character.name,0);
                  lastNameId = this.getTaxCollectorNameId(character.name,1);
                  character.name = TaxCollectorFirstname.getTaxCollectorFirstnameById(firstNameId).firstname;
                  character.name += " " + TaxCollectorName.getTaxCollectorNameById(lastNameId).name;
               }
               allies.push(character);
            }
            if(data[sf.socialFightInfo.mapId])
            {
               data[sf.socialFightInfo.mapId].update(sf.socialFightInfo.fightType,sf.socialFightInfo.mapId,allies,enemies,sf.phase.phase,sf.phase.phaseEndTimeStamp);
            }
            else
            {
               data[sf.socialFightInfo.mapId] = SocialEntityInFightWrapper.create(sf.socialFightInfo.fightType,sf.socialFightInfo.mapId,sf.socialFightInfo.fightId,allies,enemies,sf.phase.phase,sf.phase.phaseEndTimeStamp);
            }
            data[sf.socialFightInfo.mapId].updateEntityLook(sf.defenders[0]);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightsUpdate);
      }
      
      public function addFightingEntity(pMapId:uint, pFightId:uint, pFightType:uint, pPhaseFight:uint, pNextPhaseTime:Number) : void
      {
         var data:Dictionary = this.getFightingList(pFightType);
         if(!data[pMapId])
         {
            data[pMapId] = SocialEntityInFightWrapper.create(pFightType,pMapId,pFightId,[],[],pPhaseFight,pNextPhaseTime);
         }
         else
         {
            data[pMapId].update(pFightType,pMapId,pFightId,[],[],pPhaseFight,pNextPhaseTime);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightAdded,pMapId,pFightType);
      }
      
      public function removeFightingEntity(pFightId:uint, pFightType:uint) : void
      {
         var fight:SocialEntityInFightWrapper = this.getFightingEntityById(pFightId,pFightType);
         var data:Dictionary = this.getFightingList(pFightType);
         if(fight)
         {
            delete data[fight.mapId];
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightRemoved,pFightId);
      }
      
      public function addFighter(pFightId:uint, pFightType:uint, pPlayerInfo:CharacterMinimalPlusLookInformations, pTeam:uint) : void
      {
         var fighters:Array = null;
         var alreadyFighting:SocialFightersWrapper = null;
         var fighter:SocialFightersWrapper = SocialFightersWrapper.create(pTeam,pPlayerInfo);
         var fight:SocialEntityInFightWrapper = this.getFightingEntityById(pFightId,pFightType);
         if(pTeam == TeamEnum.TEAM_CHALLENGER)
         {
            fighters = fight.enemyCharactersInformations;
         }
         else if(pTeam == TeamEnum.TEAM_DEFENDER)
         {
            fighters = fight.allyCharactersInformations;
         }
         if(!fighters)
         {
            fighters = [];
         }
         for each(alreadyFighting in fighters)
         {
            if(alreadyFighting.playerCharactersInformations.id == fighter.playerCharactersInformations.id)
            {
               return;
            }
         }
         fighters.push(fighter);
         if(pTeam == TeamEnum.TEAM_DEFENDER && fighters.length == 1)
         {
            fight.updateEntityLook(fighter.playerCharactersInformations);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightMemberUpdated,pFightId,pFightType);
      }
      
      public function removeFighter(pFightId:uint, pFightType:uint, pPlayerId:uint) : void
      {
         var fighter:SocialFightersWrapper = null;
         var fight:SocialEntityInFightWrapper = this.getFightingEntityById(pFightId,pFightType);
         for each(fighter in fight.allyCharactersInformations)
         {
            if(fighter.playerCharactersInformations.id == pPlayerId)
            {
               fight.allyCharactersInformations.removeAt(fight.allyCharactersInformations.indexOf(fighter));
            }
         }
         for each(fighter in fight.enemyCharactersInformations)
         {
            if(fighter.playerCharactersInformations.id == pPlayerId)
            {
               fight.enemyCharactersInformations.removeAt(fight.enemyCharactersInformations.indexOf(fighter));
            }
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightMemberUpdated,pFightId,pFightType);
      }
      
      public function updatePhase(pFightId:uint, pFightType:uint, pFightPhase:uint, pTimeNextPhase:uint = 0) : void
      {
         var fight:SocialEntityInFightWrapper = this.getFightingEntityById(pFightId,pFightType);
         fight.update(fight.typeId,fight.mapId,fight.fightId,fight.allyCharactersInformations,fight.enemyCharactersInformations,pFightPhase,pTimeNextPhase);
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceFightStateUpdate,pFightId,pFightType);
      }
      
      public function getFightingEntityById(fightId:uint, fightType:uint) : SocialEntityInFightWrapper
      {
         var fight:SocialEntityInFightWrapper = null;
         var data:Dictionary = this.getFightingList(fightType);
         for each(fight in data)
         {
            if(fight.fightId == fightId)
            {
               return fight;
            }
         }
         return null;
      }
      
      public function getFightingList(fightType:uint) : Dictionary
      {
         if(fightType == SocialFightTypeEnum.PrismFight)
         {
            return this._prismsInFight;
         }
         if(fightType == SocialFightTypeEnum.TaxCollectorFight)
         {
            return this._taxCollectorsInFight;
         }
         return null;
      }
      
      public function toSocialFightInfo(fightInfo:SocialEntityInFightWrapper) : SocialFightInfo
      {
         var info:SocialFightInfo = new SocialFightInfo();
         info.initSocialFightInfo(fightInfo.fightId,fightInfo.typeId,fightInfo.mapId);
         return info;
      }
      
      public function getTaxCollectorNameId(idString:String, index:int) : Number
      {
         return parseInt(idString.split(",")[index],36);
      }
   }
}
