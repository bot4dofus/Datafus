package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementPioneerItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AchievementPioneerItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new AchievementPioneerItemCriterion(this.basicText);
      }
      
      override public function get isRespected() : Boolean
      {
         var pioneerRank:int = 0;
         var achievementId:int = parseInt(_criterionValueText.split(",")[0]);
         var criterionValue:int = parseInt(_criterionValueText.split(",")[1]);
         var questFrame:QuestFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         if(achievementId in questFrame.finishedCharacterAchievementByIds)
         {
            pioneerRank = (questFrame.finishedCharacterAchievementByIds[achievementId] as AchievementAchieved).achievedPioneerRank;
         }
         else
         {
            pioneerRank = questFrame.achievementPioneerRanks[achievementId];
            if(pioneerRank == 0)
            {
               pioneerRank = 1;
            }
         }
         return _operator.compare(pioneerRank,criterionValue);
      }
   }
}
