package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractDodgePointLossStep;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightActionPointsLossDodgeStep extends AbstractDodgePointLossStep implements IFightStep
   {
       
      
      public function FightActionPointsLossDodgeStep(fighterId:Number, amount:int)
      {
         super(fighterId,amount);
      }
      
      public function get stepType() : String
      {
         return "actionPointsLossDodge";
      }
      
      override public function start() : void
      {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_LOSS_DODGED,[_fighterId,_amount],_fighterId,castingSpellId);
         executeCallbacks();
      }
   }
}
