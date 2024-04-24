package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AchievementItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var id:int = 0;
         var questFrame:QuestFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         if(!questFrame)
         {
            return false;
         }
         var achievementFinishedList:Array = questFrame.finishedAccountAchievementIds;
         for each(id in achievementFinishedList)
         {
            if(id == _criterionValue)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function get text() : String
      {
         var readableValue:* = " \'" + Achievement.getAchievementById(_criterionValue).name + "\'";
         var readableCriterion:String = I18n.getUiText("ui.tooltip.unlockAchievement",[readableValue]);
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontUnlockAchievement",[readableValue]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new AchievementItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var id:int = 0;
         var achievementFinishedList:Array = (Kernel.getWorker().getFrame(QuestFrame) as QuestFrame).finishedAccountAchievementIds;
         for each(id in achievementFinishedList)
         {
            if(id == _criterionValue)
            {
               return 1;
            }
         }
         return 0;
      }
   }
}
