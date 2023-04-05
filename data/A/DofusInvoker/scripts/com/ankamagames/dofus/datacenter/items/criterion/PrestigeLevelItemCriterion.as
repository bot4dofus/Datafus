package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PrestigeLevelItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function PrestigeLevelItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = _criterionValue.toString();
         var readableCriterionRef:String = I18n.getUiText("ui.common.prestige");
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new PrestigeLevelItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var prestige:int = 0;
         if(PlayedCharacterManager.getInstance().infos.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            prestige = PlayedCharacterManager.getInstance().infos.level - ProtocolConstantsEnum.MAX_LEVEL;
         }
         return prestige;
      }
   }
}
