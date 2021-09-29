package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.spells.EffectsListWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.EffectsWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class FightApi implements IApi
   {
      
      private static var UNKNOWN_FIGHTER_NAME:String = "???";
      
      public static var slaveContext:Boolean;
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function FightApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(FightApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function isSlaveContext() : Boolean
      {
         return slaveContext;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getFighterInformations(fighterId:Number) : FighterInformations
      {
         return new FighterInformations(fighterId);
      }
      
      public function getFighterName(fighterId:Number) : String
      {
         try
         {
            return this.getFightFrame().getFighterName(fighterId);
         }
         catch(apiErr:ApiError)
         {
            return UNKNOWN_FIGHTER_NAME;
         }
      }
      
      public function getFighterLevel(fighterId:Number) : uint
      {
         return this.getFightFrame().getFighterLevel(fighterId);
      }
      
      public function getFighters() : Vector.<Number>
      {
         if(Kernel.getWorker().getFrame(FightBattleFrame) && !Kernel.getWorker().getFrame(FightPreparationFrame))
         {
            return this.getFightFrame().battleFrame.fightersList;
         }
         return this.getFightFrame().entitiesFrame.getOrdonnedPreFighters();
      }
      
      public function getMonsterId(id:Number) : int
      {
         var gffi:GameFightFighterInformations = this.getFighterInfos(id);
         if(gffi is GameFightMonsterInformations)
         {
            return GameFightMonsterInformations(gffi).creatureGenericId;
         }
         return -1;
      }
      
      public function getDeadFighters() : Vector.<Number>
      {
         if(Kernel.getWorker().getFrame(FightBattleFrame))
         {
            return this.getFightFrame().battleFrame.deadFightersList;
         }
         return new Vector.<Number>();
      }
      
      public function getFightType() : uint
      {
         return this.getFightFrame().fightType;
      }
      
      public function getBuffList(targetId:Number) : Array
      {
         return BuffManager.getInstance().getAllBuff(targetId);
      }
      
      public function getBuffById(buffId:uint, playerId:Number) : BasicBuff
      {
         return BuffManager.getInstance().getBuff(buffId,playerId);
      }
      
      public function createEffectsWrapper(spell:Spell, effects:Array, name:String, fromBuff:Boolean) : EffectsWrapper
      {
         return new EffectsWrapper(effects,spell,name,fromBuff);
      }
      
      public function getAllBuffEffects(targetId:Number) : EffectsListWrapper
      {
         return new EffectsListWrapper(BuffManager.getInstance().getAllBuff(targetId));
      }
      
      public function isCastingSpell() : Boolean
      {
         return Kernel.getWorker().contains(FightSpellCastFrame);
      }
      
      public function cancelSpell() : void
      {
         if(Kernel.getWorker().contains(FightSpellCastFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
         }
      }
      
      public function getChallengeList() : Array
      {
         return this.getFightFrame().challengesList;
      }
      
      public function getCurrentPlayedFighterId() : Number
      {
         return CurrentPlayedFighterManager.getInstance().currentFighterId;
      }
      
      public function getPlayingFighterId() : Number
      {
         return this.getFightFrame().battleFrame.currentPlayerId;
      }
      
      public function isCompanion(pFighterId:Number) : Boolean
      {
         return this.getFightFrame().entitiesFrame.getEntityInfos(pFighterId) is GameFightEntityInformation;
      }
      
      public function getCurrentPlayedCharacteristicsInformations() : CharacterCharacteristicsInformations
      {
         return CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
      }
      
      public function preFightIsActive() : Boolean
      {
         return FightContextFrame.preFightIsActive;
      }
      
      public function isWaitingBeforeFight() : Boolean
      {
         if(this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvMA || this.getFightFrame().fightType == FightTypeEnum.FIGHT_TYPE_PvT)
         {
            return true;
         }
         return false;
      }
      
      public function isFightLeader() : Boolean
      {
         return this.getFightFrame().isFightLeader;
      }
      
      public function isSpectator() : Boolean
      {
         return PlayedCharacterManager.getInstance().isSpectator;
      }
      
      public function isDematerializated() : Boolean
      {
         return this.getFightFrame().entitiesFrame.dematerialization;
      }
      
      public function getTurnsCount() : int
      {
         return this.getFightFrame().battleFrame.turnsCount;
      }
      
      public function getFighterStatus(fighterId:Number) : int
      {
         var frame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var fightersStatus:Dictionary = !!frame ? frame.lastKnownPlayerStatus : null;
         if(fightersStatus && fightersStatus[fighterId])
         {
            return fightersStatus[fighterId];
         }
         return -1;
      }
      
      public function isMouseOverFighter(fighterId:Number) : Boolean
      {
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!fcf || !fcf.entitiesFrame.getEntityInfos(fighterId))
         {
            return false;
         }
         var fighterInfo:GameFightFighterInformations = this.getFighterInfos(fighterId);
         return fighterInfo.disposition.cellId == FightContextFrame.currentCell || fcf.timelineOverEntity && fighterId == fcf.timelineOverEntityId;
      }
      
      public function updateSwapPositionRequestsIcons() : void
      {
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.updateSwapPositionRequestsIcons();
         }
      }
      
      public function setSwapPositionRequestsIconsVisibility(pVisible:Boolean) : void
      {
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.setSwapPositionRequestsIconsVisibility(pVisible);
         }
      }
      
      private function getFighterInfos(fighterId:Number) : GameFightFighterInformations
      {
         return this.getFightFrame().entitiesFrame.getEntityInfos(fighterId) as GameFightFighterInformations;
      }
      
      private function getFightFrame() : FightContextFrame
      {
         var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         if(!frame)
         {
            throw new ApiError("Unallowed call of FightApi method while not fighting.");
         }
         return frame as FightContextFrame;
      }
   }
}
