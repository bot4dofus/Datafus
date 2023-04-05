package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class NumberOfItemMadeCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function NumberOfItemMadeCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = _criterionValueText;
         var itemsMadeCount:int = parseInt(readableCriterionValue.split(",")[1]) + 1;
         return I18n.getUiText("ui.smithmagic.itemsMadeCount",[itemsMadeCount]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new NumberOfItemMadeCriterion(this.basicText);
      }
   }
}
