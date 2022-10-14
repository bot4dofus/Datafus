package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultAdditionalData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultExperienceData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultMutantListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultPvpData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FightResultEntryWrapper implements IDataCenter
   {
       
      
      private var _item:FightResultListEntry;
      
      public var outcome:int;
      
      public var id:Number;
      
      public var name:String;
      
      public var alive:Boolean;
      
      public var rewards:FightLootWrapper;
      
      public var level:int;
      
      public var type:int;
      
      public var fightInitiator:Boolean;
      
      public var breed:int = 0;
      
      public var gender:int = 0;
      
      public var wave:int;
      
      public var isLastOfHisWave:Boolean = false;
      
      public var rerollXpMultiplicator:int;
      
      public var experience:Number;
      
      public var showExperience:Boolean = false;
      
      public var experienceLevelFloor:Number;
      
      public var showExperienceLevelFloor:Boolean = false;
      
      public var experienceNextLevelFloor:Number;
      
      public var showExperienceNextLevelFloor:Boolean = false;
      
      public var experienceFightDelta:Number;
      
      public var showExperienceFightDelta:Boolean = false;
      
      public var experienceForGuild:Number;
      
      public var showExperienceForGuild:Boolean = false;
      
      public var experienceForRide:Number;
      
      public var showExperienceForRide:Boolean = false;
      
      public var grade:uint;
      
      public var honor:uint;
      
      public var honorDelta:int = -1;
      
      public var maxHonorForGrade:uint;
      
      public var minHonorForGrade:uint;
      
      public var isIncarnationExperience:Boolean;
      
      public function FightResultEntryWrapper(o:FightResultListEntry, infos:GameFightFighterInformations = null, isSpectator:Boolean = false)
      {
         var player:FightResultPlayerListEntry = null;
         var taxCollector:FightResultTaxCollectorListEntry = null;
         var info:GameFightTaxCollectorInformations = null;
         var mutant:FightResultMutantListEntry = null;
         var monsterInfos0:GameFightMonsterInformations = null;
         var monster0:Monster = null;
         var tcInfos:GameFightTaxCollectorInformations = null;
         var addInfo:FightResultAdditionalData = null;
         var monsterInfos:GameFightMonsterInformations = null;
         var monster:Monster = null;
         var breachFrame:BreachFrame = null;
         var companionInfos:GameFightEntityInformation = null;
         var companion:Companion = null;
         super();
         this._item = o;
         this.outcome = o.outcome;
         this.rewards = new FightLootWrapper(o.rewards);
         switch(true)
         {
            case o is FightResultPlayerListEntry:
               player = o as FightResultPlayerListEntry;
               if(!infos)
               {
                  break;
               }
               if(infos is GameFightMonsterInformations)
               {
                  monsterInfos0 = infos as GameFightMonsterInformations;
                  monster0 = Monster.getMonsterById(monsterInfos0.creatureGenericId);
                  this.name = monster0.name;
                  this.level = (infos as GameFightMonsterInformations).creatureLevel;
                  this.id = monster0.id;
                  this.alive = monsterInfos0.spawnInfo.alive;
                  this.type = 1;
               }
               else if(infos is GameFightTaxCollectorInformations)
               {
                  tcInfos = infos as GameFightTaxCollectorInformations;
                  this.name = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcInfos.lastNameId).name;
                  this.level = tcInfos.level;
                  this.id = tcInfos.contextualId;
                  this.alive = tcInfos.spawnInfo.alive;
                  this.type = 2;
               }
               else
               {
                  this.name = (infos as GameFightFighterNamedInformations).name;
                  this.level = player.level;
                  this.id = player.id;
                  this.alive = player.alive;
                  if(infos is GameFightCharacterInformations)
                  {
                     this.breed = (infos as GameFightCharacterInformations).breed;
                     this.gender = int((infos as GameFightCharacterInformations).sex);
                  }
                  this.type = 0;
                  if(player.additional.length == 0)
                  {
                     break;
                  }
                  for each(addInfo in player.additional)
                  {
                     switch(true)
                     {
                        case addInfo is FightResultExperienceData:
                           this.rerollXpMultiplicator = (addInfo as FightResultExperienceData).rerollExperienceMul;
                           this.experience = (addInfo as FightResultExperienceData).experience;
                           this.showExperience = (addInfo as FightResultExperienceData).showExperience;
                           this.experienceLevelFloor = (addInfo as FightResultExperienceData).experienceLevelFloor;
                           this.showExperienceLevelFloor = (addInfo as FightResultExperienceData).showExperienceLevelFloor;
                           this.experienceNextLevelFloor = (addInfo as FightResultExperienceData).experienceNextLevelFloor;
                           this.showExperienceNextLevelFloor = (addInfo as FightResultExperienceData).showExperienceNextLevelFloor;
                           this.experienceFightDelta = (addInfo as FightResultExperienceData).experienceFightDelta;
                           this.showExperienceFightDelta = (addInfo as FightResultExperienceData).showExperienceFightDelta;
                           this.experienceForGuild = (addInfo as FightResultExperienceData).experienceForGuild;
                           this.showExperienceForGuild = (addInfo as FightResultExperienceData).showExperienceForGuild;
                           this.experienceForRide = (addInfo as FightResultExperienceData).experienceForMount;
                           this.showExperienceForRide = (addInfo as FightResultExperienceData).showExperienceForMount;
                           this.isIncarnationExperience = (addInfo as FightResultExperienceData).isIncarnationExperience;
                           this.honorDelta = -1;
                           break;
                        case addInfo is FightResultPvpData:
                           this.grade = (addInfo as FightResultPvpData).grade;
                           this.honor = (addInfo as FightResultPvpData).honor;
                           this.honorDelta = (addInfo as FightResultPvpData).honorDelta;
                           this.maxHonorForGrade = (addInfo as FightResultPvpData).maxHonorForGrade;
                           this.minHonorForGrade = (addInfo as FightResultPvpData).minHonorForGrade;
                           break;
                     }
                  }
               }
               break;
            case o is FightResultTaxCollectorListEntry:
               taxCollector = o as FightResultTaxCollectorListEntry;
               info = infos as GameFightTaxCollectorInformations;
               if(info)
               {
                  this.name = TaxCollectorFirstname.getTaxCollectorFirstnameById(info.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(info.lastNameId).name;
               }
               else
               {
                  this.name = taxCollector.guildInfo.guildName;
               }
               this.level = taxCollector.level;
               this.experienceForGuild = taxCollector.experienceForGuild;
               this.id = taxCollector.id;
               this.alive = taxCollector.alive;
               this.type = 2;
               break;
            case o is FightResultMutantListEntry:
               mutant = o as FightResultMutantListEntry;
               this.name = (infos as GameFightFighterNamedInformations).name;
               this.level = mutant.level;
               this.id = mutant.id;
               this.alive = mutant.alive;
               this.type = 0;
               break;
            case o is FightResultFighterListEntry:
               if(infos is GameFightMonsterInformations)
               {
                  monsterInfos = infos as GameFightMonsterInformations;
                  monster = Monster.getMonsterById(monsterInfos.creatureGenericId);
                  this.name = monster.name;
                  breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
                  if(PlayedCharacterManager.getInstance().isInBreach && breachFrame && !isSpectator)
                  {
                     this.level = breachFrame.floor;
                  }
                  else
                  {
                     this.level = monsterInfos.creatureLevel;
                  }
                  this.id = monster.id;
                  this.alive = monsterInfos.spawnInfo.alive;
                  this.type = 1;
               }
               else if(infos is GameFightEntityInformation)
               {
                  companionInfos = infos as GameFightEntityInformation;
                  companion = Companion.getCompanionById(companionInfos.entityModelId);
                  this.name = companion.name;
                  this.level = companionInfos.level;
                  this.id = companion.id;
                  this.alive = companionInfos.spawnInfo.alive;
                  this.type = 1;
               }
               break;
            case o is FightResultListEntry:
         }
      }
   }
}
