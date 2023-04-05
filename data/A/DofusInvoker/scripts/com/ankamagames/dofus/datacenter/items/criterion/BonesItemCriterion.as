package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BonesItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function BonesItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         if(_criterionValue == 0 && _criterionValueText == "B")
         {
            return I18n.getUiText("ui.criterion.initialBones");
         }
         return I18n.getUiText("ui.criterion.bones") + " " + _operator.text + " " + _criterionValue.toString();
      }
      
      override public function get isRespected() : Boolean
      {
         if(_criterionValue == 0 && _criterionValueText == "B")
         {
            return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == 1;
         }
         return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == _criterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new BonesItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return PlayedCharacterManager.getInstance().infos.entityLook.bonesId;
      }
   }
}
