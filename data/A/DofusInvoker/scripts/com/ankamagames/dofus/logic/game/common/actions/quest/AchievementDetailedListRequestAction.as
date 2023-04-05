package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementDetailedListRequestAction extends AbstractAction implements Action
   {
       
      
      public var categoryId:int;
      
      public function AchievementDetailedListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(categoryId:int) : AchievementDetailedListRequestAction
      {
         var action:AchievementDetailedListRequestAction = new AchievementDetailedListRequestAction(arguments);
         action.categoryId = categoryId;
         return action;
      }
   }
}
