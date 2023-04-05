package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AccountRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AccountRightsItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = null;
         var readableCriterionRef:String = null;
         if(PlayerManager.getInstance().hasRights)
         {
            readableCriterionValue = _criterionValue.toString();
            readableCriterionRef = I18n.getUiText("ui.social.guildHouseRights");
            return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
         }
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new AccountRightsItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}
