package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.mounts.MountFamily;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MountFamilyItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function MountFamilyItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = null;
         var mountFamily:MountFamily = MountFamily.getMountFamilyById(Number(_criterionValue));
         if(!mountFamily)
         {
            readableCriterionRef = "???";
         }
         else
         {
            readableCriterionRef = mountFamily.name;
         }
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            return I18n.getUiText("ui.tooltip.mountEquipedFamily",[readableCriterionRef]);
         }
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return I18n.getUiText("ui.tooltip.mountNonEquipedFamily",[readableCriterionRef]);
         }
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new MountFamilyItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var mount:MountData = PlayedCharacterManager.getInstance().mount;
         if(!mount || !PlayedCharacterManager.getInstance().isRidding)
         {
            return -1;
         }
         return mount.model.familyId;
      }
   }
}
