package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class NumberOfMountBirthedCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function NumberOfMountBirthedCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = _criterionValueText;
         var mountsBirthedCount:int = parseInt(readableCriterionValue.split(",")[1]) + 1;
         return I18n.getUiText("ui.mount.mountsBirthedCount",[mountsBirthedCount]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new NumberOfMountBirthedCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
