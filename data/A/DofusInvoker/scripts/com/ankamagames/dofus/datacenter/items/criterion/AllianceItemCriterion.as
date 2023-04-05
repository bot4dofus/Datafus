package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AllianceItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AllianceItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         if(_criterionValue == 0)
         {
            return I18n.getUiText("ui.criterion.noAlliance");
         }
         return I18n.getUiText("ui.criterion.hasAlliance");
      }
      
      override public function clone() : IItemCriterion
      {
         return new AllianceItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var alliance:AllianceWrapper = SocialFrame.getInstance().alliance;
         if(alliance)
         {
            return 1;
         }
         return 0;
      }
   }
}
