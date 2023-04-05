package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightKillStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _killerId:Number;
      
      private var _fighterId:Number;
      
      public function FightKillStep(fighterId:Number, killerId:Number)
      {
         super();
         this._killerId = killerId;
         this._fighterId = fighterId;
      }
      
      public function get stepType() : String
      {
         return "kill";
      }
      
      override public function start() : void
      {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_KILLED,[this._killerId,this._fighterId],this._fighterId,castingSpellId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
