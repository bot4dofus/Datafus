package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementObjectiveValidated extends ItemCriterion implements IDataCenter
   {
       
      
      public function AchievementObjectiveValidated(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var achievementObjective:AchievementObjective = AchievementObjective.getAchievementObjectiveById(_criterionValue);
         return I18n.getUiText("ui.achievement.objectiveValidated",[achievementObjective.name,Achievement.getAchievementById(achievementObjective.achievementId).name]);
      }
      
      override public function clone() : IItemCriterion
      {
         return new AchievementObjectiveValidated(this.basicText);
      }
   }
}
