package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubscribeItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function SubscribeItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         if(_criterionValue == 1 && _operator.text == ItemCriterionOperator.EQUAL || _criterionValue == 0 && _operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return I18n.getUiText("ui.tooltip.beSubscirber");
         }
         return I18n.getUiText("ui.tooltip.dontBeSubscriber");
      }
      
      override public function clone() : IItemCriterion
      {
         return new SubscribeItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var timeRemaining:Number = PlayerManager.getInstance().subscriptionEndDate;
         if(timeRemaining > 0 || PlayerManager.getInstance().hasRights)
         {
            return 1;
         }
         return 0;
      }
   }
}
