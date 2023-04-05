package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightDispellSpellStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _spellId:int;
      
      private var _verboseCast:Boolean;
      
      public function FightDispellSpellStep(fighterId:Number, spellId:int, verboseCast:Boolean)
      {
         super();
         this._fighterId = fighterId;
         this._spellId = spellId;
         this._verboseCast = verboseCast;
      }
      
      public function get stepType() : String
      {
         return "dispellSpell";
      }
      
      override public function start() : void
      {
         var buff:BasicBuff = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var fighterInfos:GameFightFighterInformations = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         if(this._verboseCast)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SPELL_DISPELLED,[this._fighterId,this._spellId],this._fighterId,castingSpellId);
         }
         var buffs:Array = BuffManager.getInstance().getAllBuff(this._fighterId);
         var refreshEntityLook:Boolean = false;
         for each(buff in buffs)
         {
            if(buff.castingSpell.spell.id == this._spellId && buff.actionId == ActionIds.ACTION_CHARACTER_ADD_APPEARANCE)
            {
               refreshEntityLook = true;
               break;
            }
         }
         BuffManager.getInstance().dispellSpell(this._fighterId,this._spellId,true);
         if(refreshEntityLook)
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            fighterInfos = entitiesFrame.getEntityInfos(this._fighterId) as GameFightFighterInformations;
            gcrelmsg = new GameContextRefreshEntityLookMessage();
            gcrelmsg.initGameContextRefreshEntityLookMessage(this._fighterId,fighterInfos.look);
            Kernel.getWorker().getFrame(FightEntitiesFrame).process(gcrelmsg);
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
