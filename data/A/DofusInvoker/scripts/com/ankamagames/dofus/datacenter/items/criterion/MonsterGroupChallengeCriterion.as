package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterGroupChallengeCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function MonsterGroupChallengeCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = String(_criterionValue + 1);
         return I18n.getUiText("ui.breachReward.groupChallengCriterion",[readableCriterionValue]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new MonsterGroupChallengeCriterion(this.basicText);
      }
   }
}
