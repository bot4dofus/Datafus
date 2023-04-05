package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RefreshFollowedQuestsOrderAction extends AbstractAction implements Action
   {
       
      
      public var questsIds:Vector.<uint>;
      
      public function RefreshFollowedQuestsOrderAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questsIds:Vector.<uint>) : RefreshFollowedQuestsOrderAction
      {
         var action:RefreshFollowedQuestsOrderAction = new RefreshFollowedQuestsOrderAction(arguments);
         action.questsIds = questsIds;
         return action;
      }
   }
}
