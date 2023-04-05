package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class RuneByBreakingItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function RuneByBreakingItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = _criterionValueText;
         var runeBybreakingItem:int = parseInt(readableCriterionValue.split(",")[1]) + 1;
         return I18n.getUiText("ui.smithmagic.runeByBreakingItemCriterion",[runeBybreakingItem]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new MonsterGroupChallengeCriterion(this.basicText);
      }
   }
}
