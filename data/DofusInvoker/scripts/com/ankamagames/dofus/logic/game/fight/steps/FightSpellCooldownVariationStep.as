package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightSpellCooldownVariationStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _spellId:int;
      
      private var _actionId:int;
      
      private var _value:int;
      
      private var _isGlobal:Boolean;
      
      public function FightSpellCooldownVariationStep(fighterId:Number, actionId:int, spellId:int, value:int, isGlobal:Boolean = false)
      {
         super();
         this._fighterId = fighterId;
         this._spellId = spellId;
         this._actionId = actionId;
         this._value = value;
         this._isGlobal = isGlobal;
      }
      
      public function get stepType() : String
      {
         return "spellCooldownVariation";
      }
      
      override public function start() : void
      {
         var spellCastManager:SpellCastInFightManager = null;
         var simf:SpellInventoryManagementFrame = null;
         var spellList:Array = null;
         var spellLvl:uint = 0;
         var spellKnown:SpellWrapper = null;
         var spellManager:SpellManager = null;
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var entityIds:Vector.<Number> = null;
         var spellWrapper:SpellWrapper = null;
         var entityId:Number = NaN;
         if(this._fighterId == CurrentPlayedFighterManager.getInstance().currentFighterId || this._fighterId == PlayedCharacterManager.getInstance().id)
         {
            spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this._fighterId);
            simf = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
            spellList = simf.getFullSpellListByOwnerId(this._fighterId);
            for each(spellKnown in spellList)
            {
               if(spellKnown.id == this._spellId)
               {
                  spellLvl = spellKnown.spellLevel;
                  break;
               }
            }
            if(spellCastManager && spellLvl > 0)
            {
               if(!spellCastManager.getSpellManagerBySpellId(this._spellId))
               {
                  spellCastManager.castSpell(this._spellId,spellLvl,[],false);
               }
               spellManager = spellCastManager.getSpellManagerBySpellId(this._spellId);
               spellManager.forceCooldown(this._value,true);
            }
         }
         if(this._isGlobal)
         {
            fightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
            if(fightEntitiesFrame !== null)
            {
               entityIds = fightEntitiesFrame.getEntityIdsWithTeamId(fightEntitiesFrame.getEntityTeamId(this._fighterId));
               spellWrapper = null;
               for each(entityId in entityIds)
               {
                  if(this._fighterId == entityId)
                  {
                     spellCastManager = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(entityId);
                     if(spellCastManager !== null)
                     {
                        spellWrapper = SpellWrapper.getSpellWrapperById(this._spellId,entityId);
                        if(spellWrapper !== null)
                        {
                           spellManager = spellCastManager.getSpellManagerBySpellId(this._spellId,true,spellWrapper.spellLevel);
                           spellManager.forceCooldown(this._value);
                        }
                     }
                  }
               }
            }
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
