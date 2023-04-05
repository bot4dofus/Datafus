package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FollowQuestAction extends AbstractAction implements Action
   {
       
      
      public var questId:uint;
      
      public var objectiveId:int;
      
      public var follow:Boolean;
      
      public function FollowQuestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questId:uint, objectiveId:int, follow:Boolean) : FollowQuestAction
      {
         var action:FollowQuestAction = new FollowQuestAction(arguments);
         action.questId = questId;
         action.objectiveId = objectiveId;
         action.follow = follow;
         return action;
      }
   }
}
