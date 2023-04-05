package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractDodgePointLossStep;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightMovementPointsLossDodgeStep extends AbstractDodgePointLossStep implements IFightStep
   {
       
      
      public function FightMovementPointsLossDodgeStep(fighterId:Number, amount:int)
      {
         super(fighterId,amount);
      }
      
      public function get stepType() : String
      {
         return "movementPointsLossDodge";
      }
      
      override public function start() : void
      {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_MP_LOSS_DODGED,[_fighterId,_amount],_fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
