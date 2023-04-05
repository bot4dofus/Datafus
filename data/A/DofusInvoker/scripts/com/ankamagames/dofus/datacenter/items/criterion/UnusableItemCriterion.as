package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class UnusableItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function UnusableItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return I18n.getUiText("ui.criterion.unusableItem");
      }
      
      override public function get isRespected() : Boolean
      {
         return true;
      }
      
      override public function clone() : IItemCriterion
      {
         return new UnusableItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
