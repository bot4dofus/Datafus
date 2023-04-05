package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightStealingKamasStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _robberId:Number;
      
      private var _victimId:Number;
      
      private var _amount:Number = 0;
      
      public function FightStealingKamasStep(robberId:Number, victimId:Number, amount:Number)
      {
         super();
         this._robberId = robberId;
         this._victimId = victimId;
         this._amount = amount;
      }
      
      public function get stepType() : String
      {
         return "stealingKamas";
      }
      
      override public function start() : void
      {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_STEALING_KAMAS,[this._robberId,this._victimId,this._amount],this._victimId,castingSpellId,false,3,2);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._victimId];
      }
   }
}
