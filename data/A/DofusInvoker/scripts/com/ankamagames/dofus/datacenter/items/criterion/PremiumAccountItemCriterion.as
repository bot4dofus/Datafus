package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PremiumAccountItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function PremiumAccountItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = I18n.getUiText("ui.tooltip.possessPremiumAccount");
         if(_criterionValue == 0)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontPossessPremiumAccount");
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new PremiumAccountItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
