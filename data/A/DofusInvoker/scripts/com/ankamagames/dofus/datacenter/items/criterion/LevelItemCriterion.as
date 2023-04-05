package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class LevelItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function LevelItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = _criterionValue.toString();
         var readableCriterionRef:String = I18n.getUiText("ui.common.level");
         if(_operator.text === ItemCriterionOperator.SUPERIOR)
         {
            return I18n.getUiText("ui.common.minimumLevelCondition",[(_criterionValue + 1).toString()]);
         }
         if(_operator.text === ItemCriterionOperator.INFERIOR)
         {
            return I18n.getUiText("ui.common.maximumLevelCondition",[(_criterionValue - 1).toString()]);
         }
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new LevelItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return PlayedCharacterManager.getInstance().limitedLevel;
      }
   }
}
