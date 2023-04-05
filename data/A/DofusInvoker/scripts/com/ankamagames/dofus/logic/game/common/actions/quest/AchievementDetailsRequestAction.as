package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementDetailsRequestAction extends AbstractAction implements Action
   {
       
      
      public var achievementId:int;
      
      public function AchievementDetailsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(achievementId:int) : AchievementDetailsRequestAction
      {
         var action:AchievementDetailsRequestAction = new AchievementDetailsRequestAction(arguments);
         action.achievementId = achievementId;
         return action;
      }
   }
}
