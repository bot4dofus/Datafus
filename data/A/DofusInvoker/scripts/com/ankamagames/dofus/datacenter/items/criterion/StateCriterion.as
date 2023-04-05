package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class StateCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function StateCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var states:Array = FightersStateManager.getInstance().getStates(CurrentPlayedFighterManager.getInstance().currentFighterId);
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return states.indexOf(criterionValue) != -1;
            case ItemCriterionOperator.DIFFERENT:
               return states.indexOf(criterionValue) == -1;
            default:
               return false;
         }
      }
      
      override public function clone() : IItemCriterion
      {
         return new StateCriterion(this.basicText);
      }
   }
}
