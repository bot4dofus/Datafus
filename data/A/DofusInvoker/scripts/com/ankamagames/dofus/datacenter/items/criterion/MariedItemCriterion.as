package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MariedItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function MariedItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = "";
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               if(_criterionValue == 1)
               {
                  readableCriterion = I18n.getUiText("ui.tooltip.beMaried");
               }
               else
               {
                  readableCriterion = I18n.getUiText("ui.tooltip.beSingle");
               }
               break;
            case ItemCriterionOperator.DIFFERENT:
               if(_criterionValue == 2)
               {
                  readableCriterion = I18n.getUiText("ui.tooltip.beMaried");
               }
               else
               {
                  readableCriterion = I18n.getUiText("ui.tooltip.beSingle");
               }
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new MariedItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
