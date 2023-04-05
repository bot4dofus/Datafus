package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementPointsItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AchievementPointsItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = String(_criterionValue);
         var readableCriterionRef:String = I18n.getUiText("ui.achievement.successPointsText");
         var readableOperator:* = ">";
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableOperator = I18n.getUiText("ui.common.differentFrom") + " >";
         }
         return readableCriterionRef + " " + readableOperator + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new AchievementPointsItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return int(PlayedCharacterManager.getInstance().achievementPoints);
      }
   }
}
