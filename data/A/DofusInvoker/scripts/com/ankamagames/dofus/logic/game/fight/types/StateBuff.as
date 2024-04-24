package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.types.enums.SpellStateIconVisibilityMaskEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import tools.ActionIdHelper;
   
   public class StateBuff extends BasicBuff
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StateBuff));
       
      
      private var _statName:String;
      
      private var _isSilent:Boolean = true;
      
      private var _isDisplayTurnRemaining:Boolean = false;
      
      private var _isVisibleInFightLog:Boolean = false;
      
      public var stateId:int;
      
      public var delta:int;
      
      public function StateBuff(effect:FightTemporaryBoostStateEffect = null, castingSpell:SpellCastSequenceContext = null, actionId:uint = 0)
      {
         var spellState:SpellState = null;
         if(effect)
         {
            spellState = SpellState.getSpellStateById(effect.stateId);
            super(effect,castingSpell,actionId,null,null,effect.stateId);
            this._statName = ActionIdHelper.getActionIdStatName(actionId);
            this.stateId = effect.stateId;
            this.delta = effect.delta;
            this._isSilent = spellState.isSilent;
            this._isDisplayTurnRemaining = spellState.displayTurnRemaining;
            this._isVisibleInFightLog = this.effect.visibleInFightLog;
         }
      }
      
      override public function get type() : String
      {
         return "StateBuff";
      }
      
      public function get statName() : String
      {
         return this._statName;
      }
      
      public function get isSilent() : Boolean
      {
         return this._isSilent;
      }
      
      public function get isDisplayTurnRemaining() : Boolean
      {
         return this._isDisplayTurnRemaining;
      }
      
      public function get isVisibleInFightLog() : Boolean
      {
         return this._isVisibleInFightLog;
      }
      
      override public function onApplied() : void
      {
         this.addBuffState();
         SpellWrapper.refreshAllPlayerSpellHolder(targetId);
         super.onApplied();
      }
      
      override public function onRemoved() : void
      {
         this.removeBuffState();
         SpellWrapper.refreshAllPlayerSpellHolder(targetId);
         super.onRemoved();
      }
      
      override public function clone(id:int = 0) : BasicBuff
      {
         var sb:StateBuff = new StateBuff();
         sb._statName = this._statName;
         sb.stateId = this.stateId;
         sb.id = uid;
         sb.uid = uid;
         sb.dataUid = dataUid;
         sb.actionId = actionId;
         sb.targetId = targetId;
         sb.castingSpell = castingSpell;
         sb.duration = duration;
         sb.dispelable = dispelable;
         sb.source = source;
         sb.aliveSource = aliveSource;
         sb.sourceJustReaffected = sourceJustReaffected;
         sb.parentBoostUid = parentBoostUid;
         sb.initParam(param1,param2,param3);
         return sb;
      }
      
      private function addBuffState() : void
      {
         var statePreviouslyActivated:Boolean = FightersStateManager.getInstance().hasState(targetId,this.stateId);
         FightersStateManager.getInstance().addStateOnTarget(targetId,this.stateId,this.delta);
         var stateActivated:Boolean = FightersStateManager.getInstance().hasState(targetId,this.stateId);
         if(!statePreviouslyActivated && stateActivated)
         {
            this.addStateIcon();
         }
         else if(statePreviouslyActivated && !stateActivated)
         {
            this.removeStateIcon();
         }
      }
      
      private function removeBuffState() : void
      {
         var statePreviouslyActivated:Boolean = FightersStateManager.getInstance().hasState(targetId,this.stateId);
         FightersStateManager.getInstance().removeStateOnTarget(targetId,this.stateId,this.delta);
         var stateActivated:Boolean = FightersStateManager.getInstance().hasState(targetId,this.stateId);
         var chatLog:Boolean = false;
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fbf && !fbf.executingSequence && fbf.deadFightersList.indexOf(targetId) == -1 && !this.isSilent)
         {
            chatLog = true;
         }
         if(!stateActivated)
         {
            this.removeStateIcon();
            if(statePreviouslyActivated && chatLog && this._isVisibleInFightLog)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE,[targetId,this.stateId],targetId,-1,false,2);
            }
         }
         else if(!statePreviouslyActivated && stateActivated)
         {
            this.addStateIcon();
            if(chatLog && this._isVisibleInFightLog)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE,[targetId,this.stateId],targetId,-1,false,2);
            }
         }
      }
      
      private function addStateIcon() : void
      {
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var spellState:SpellState = SpellState.getSpellStateById(this.stateId);
         var icon:String = spellState.icon;
         if(!icon || icon == "")
         {
            return;
         }
         var displayIcon:Boolean = this.displayIconForThisPlayer(spellState.iconVisibilityMask);
         if(displayIcon)
         {
            fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
            if(this._isDisplayTurnRemaining)
            {
               fightEntitiesFrame.addEntityIcon(targetId,icon,EntityIconEnum.FIGHT_STATE_CATEGORY,0,0,this.duration);
            }
            else
            {
               fightEntitiesFrame.addEntityIcon(targetId,icon,EntityIconEnum.FIGHT_STATE_CATEGORY);
            }
            fightEntitiesFrame.forceIconUpdate(targetId);
         }
      }
      
      public function updateTurnRemaining() : void
      {
         var spellState:SpellState = null;
         var icon:String = null;
         if(this._isDisplayTurnRemaining)
         {
            spellState = SpellState.getSpellStateById(this.stateId);
            icon = spellState.icon;
            if(!icon || icon == "")
            {
               return;
            }
            if(this.displayIconForThisPlayer(spellState.iconVisibilityMask))
            {
               FightEntitiesFrame.getCurrentInstance().updateTurnRemaining(this.targetId,icon,this.duration);
            }
         }
      }
      
      private function removeStateIcon() : void
      {
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var spellState:SpellState = SpellState.getSpellStateById(this.stateId);
         var icon:String = spellState.icon;
         if(!icon || icon == "")
         {
            return;
         }
         var displayIcon:Boolean = this.displayIconForThisPlayer(spellState.iconVisibilityMask);
         if(displayIcon)
         {
            fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
            fightEntitiesFrame.removeIcon(targetId,icon);
         }
      }
      
      private function displayIconForThisPlayer(iconVisibility:int) : Boolean
      {
         var playerInfos:GameFightFighterInformations = null;
         var casterInfos:GameFightFighterInformations = null;
         var playerBreed:int = 0;
         var summonerInfos:GameFightFighterInformations = null;
         var casterInfos2:GameFightFighterInformations = null;
         var displayIcon:Boolean = false;
         var playerId:Number = PlayedCharacterManager.getInstance().id;
         switch(iconVisibility)
         {
            case SpellStateIconVisibilityMaskEnum.ALL_VISIBILITY:
               displayIcon = true;
               break;
            case SpellStateIconVisibilityMaskEnum.TARGET_VISIBILITY:
               if(targetId == playerId)
               {
                  displayIcon = true;
               }
               break;
            case SpellStateIconVisibilityMaskEnum.CASTER_VISIBILITY:
               if(!castingSpell)
               {
                  break;
               }
               if(castingSpell.casterId == playerId)
               {
                  displayIcon = true;
               }
               else
               {
                  casterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(castingSpell.casterId) as GameFightFighterInformations;
                  if(!casterInfos)
                  {
                     break;
                  }
                  if(casterInfos.stats.summoner == playerId)
                  {
                     displayIcon = true;
                     break;
                  }
                  playerBreed = PlayedCharacterManager.getInstance().infos.breed;
                  playerInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(playerId) as GameFightFighterInformations;
                  if(!playerInfos)
                  {
                     break;
                  }
                  if(casterInfos is GameFightCharacterInformations)
                  {
                     if(casterInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId && (casterInfos as GameFightCharacterInformations).breed == playerBreed)
                     {
                        displayIcon = true;
                        break;
                     }
                  }
                  else
                  {
                     summonerInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(casterInfos.stats.summoner) as GameFightFighterInformations;
                     if(summonerInfos is GameFightCharacterInformations)
                     {
                        if(summonerInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId && (summonerInfos as GameFightCharacterInformations).breed == playerBreed)
                        {
                           displayIcon = true;
                           break;
                        }
                     }
                  }
               }
               break;
            case SpellStateIconVisibilityMaskEnum.CASTER_ALLIES_VISIBILITY:
               if(!castingSpell)
               {
                  break;
               }
               if(castingSpell.casterId == playerId)
               {
                  displayIcon = true;
               }
               else
               {
                  casterInfos2 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(castingSpell.casterId) as GameFightFighterInformations;
                  if(casterInfos2 && casterInfos2.stats.summoner == playerId)
                  {
                     displayIcon = true;
                     break;
                  }
                  playerInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(playerId) as GameFightFighterInformations;
                  if(!playerInfos)
                  {
                     break;
                  }
                  if(casterInfos2.spawnInfo.teamId == playerInfos.spawnInfo.teamId)
                  {
                     displayIcon = true;
                  }
               }
               break;
         }
         return displayIcon;
      }
   }
}
