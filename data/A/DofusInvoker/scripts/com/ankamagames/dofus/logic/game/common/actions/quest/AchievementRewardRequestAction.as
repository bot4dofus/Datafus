package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementRewardRequestAction extends AbstractAction implements Action
   {
       
      
      public var achievementId:int;
      
      public function AchievementRewardRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(achievementId:int) : AchievementRewardRequestAction
      {
         var action:AchievementRewardRequestAction = new AchievementRewardRequestAction(arguments);
         action.achievementId = achievementId;
         return action;
      }
   }
}
