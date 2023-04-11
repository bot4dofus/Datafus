package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightAIInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.tools.Const;
   import tools.ActionIdHelper;
   
   public class FighterTranslator extends HaxeFighter
   {
      
      private static const BOMBS_TYPE_ID:int = 95;
      
      private static const UPDATED_STATS:Vector.<String> = new <String>[Const.PUSH_DAMAGE_BONUS,Const.PUSH_DAMAGE_REDUCTION,Const.WATER_ELEMENT_RESIST_PERCENT,Const.EARTH_ELEMENT_RESIST_PERCENT,Const.FIRE_ELEMENT_RESIST_PERCENT,Const.AIR_ELEMENT_RESIST_PERCENT,Const.NEUTRAL_ELEMENT_RESIST_PERCENT,Const.RECEIVED_DAMAGE_MULTIPLIER_DISTANCE];
       
      
      private var _fighterInfos:GameFightFighterInformations;
      
      public function FighterTranslator(fighterInfos:GameFightFighterInformations, fighterId:Number, isSummondCastPreviewed:Boolean = false)
      {
         this._fighterInfos = fighterInfos;
         var buffs:Array = this.initializeBuffs(fighterId);
         var level:Number = Math.min((Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).getFighterLevel(fighterId),200);
         var data:FighterDataTranslator = new FighterDataTranslator(this._fighterInfos,fighterId);
         super(fighterId,level,this.getBreed(),this.getPlayerType(),this._fighterInfos.spawnInfo.teamId,this.isAStaticElement(fighterId),buffs,data,isSummondCastPreviewed);
      }
      
      override public function isBomb() : Boolean
      {
         var infos:Monster = null;
         if(this._fighterInfos is GameFightMonsterInformations)
         {
            infos = Monster.getMonsterById((this._fighterInfos as GameFightMonsterInformations).creatureGenericId);
            if(infos != null && infos.type.id == BOMBS_TYPE_ID)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function getModelId() : uint
      {
         var gameFightEntityInfo:GameFightEntityInformation = this._fighterInfos as GameFightEntityInformation;
         return gameFightEntityInfo == null ? uint(0) : uint(gameFightEntityInfo.entityModelId);
      }
      
      private function initializeBuffs(fighterId:Number) : Array
      {
         var buff:BasicBuff = null;
         var stack:BasicBuff = null;
         var unknownBaseStats:* = !(CurrentPlayedFighterManager.getInstance().currentFighterId == fighterId || PlayedCharacterManager.getInstance().id == fighterId || this._fighterInfos is GameFightMonsterInformations);
         var buffs:Array = [];
         for each(buff in BuffManager.getInstance().getAllBuff(fighterId))
         {
            if(!(buff is StatBuff && !(buff as StatBuff).isRecent && unknownBaseStats))
            {
               if(!((unknownBaseStats || this._fighterInfos is GameFightMonsterInformations) && UPDATED_STATS.indexOf(ActionIdHelper.getActionIdStatName(buff.actionId)) != -1))
               {
                  if(buff.stack != null)
                  {
                     for each(stack in buff.stack)
                     {
                        if(stack.effect.delay == 0 && (!(buff is StateBuff) || FightersStateManager.getInstance().hasState(fighterId,(buff as StateBuff).stateId)))
                        {
                           buffs.push(DamagePreview.createHaxeBuff(stack));
                        }
                     }
                  }
                  else if(buff.effect.delay == 0 && (!(buff is StateBuff) || FightersStateManager.getInstance().hasState(fighterId,(buff as StateBuff).stateId)))
                  {
                     buffs.push(DamagePreview.createHaxeBuff(buff));
                  }
               }
            }
         }
         return buffs;
      }
      
      private function getBreed() : int
      {
         if(this._fighterInfos is GameFightCharacterInformations)
         {
            return (this._fighterInfos as GameFightCharacterInformations).breed;
         }
         if(this._fighterInfos is GameFightMonsterInformations)
         {
            return (this._fighterInfos as GameFightMonsterInformations).creatureGenericId;
         }
         return -1;
      }
      
      private function getPlayerType() : PlayerTypeEnum
      {
         if(this._fighterInfos is GameFightFighterNamedInformations)
         {
            return PlayerTypeEnum.HUMAN;
         }
         if(this._fighterInfos is GameFightEntityInformation)
         {
            return PlayerTypeEnum.SIDEKICK;
         }
         if(this._fighterInfos is GameFightAIInformations)
         {
            return PlayerTypeEnum.MONSTER;
         }
         return PlayerTypeEnum.UNKNOWN;
      }
      
      private function isAStaticElement(id:Number) : Boolean
      {
         var monsterInfo:GameFightMonsterInformations = null;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(fef)
         {
            monsterInfo = fef.getEntityInfos(id) as GameFightMonsterInformations;
            if(monsterInfo != null && Monster.getMonsterById(monsterInfo.creatureGenericId).canPlay == false)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function isAlive() : Boolean
      {
         return this._fighterInfos.spawnInfo.alive && super.isAlive();
      }
   }
}
