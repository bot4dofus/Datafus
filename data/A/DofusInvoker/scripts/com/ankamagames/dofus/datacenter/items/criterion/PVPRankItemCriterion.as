package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PVPRankItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function PVPRankItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return I18n.getUiText("ui.pvp.rank") + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new PVPRankItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
