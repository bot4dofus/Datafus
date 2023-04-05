package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   
   public class FightCloseCombatStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _weaponId:uint;
      
      private var _critical:uint;
      
      private var _verboseCast:Boolean;
      
      public function FightCloseCombatStep(fighterId:Number, weaponId:uint, critical:uint, verboseCast:Boolean)
      {
         super();
         this._fighterId = fighterId;
         this._weaponId = weaponId;
         this._critical = critical;
         this._verboseCast = verboseCast;
      }
      
      public function get stepType() : String
      {
         return "closeCombat";
      }
      
      override public function start() : void
      {
         var fighterInfos:GameFightFighterInformations = null;
         var seq:SerialSequencer = null;
         if(this._verboseCast)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CLOSE_COMBAT,[this._fighterId,this._weaponId,this._critical],this._fighterId,castingSpellId,true);
         }
         if(this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            if(fighterInfos)
            {
               seq = new SerialSequencer();
               seq.addStep(new AddGfxEntityStep(1062,fighterInfos.disposition.cellId));
               seq.start();
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
