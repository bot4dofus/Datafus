package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NotificationUpdateFlagAction extends AbstractAction implements Action
   {
       
      
      public var index:uint;
      
      public function NotificationUpdateFlagAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(index:uint) : NotificationUpdateFlagAction
      {
         var action:NotificationUpdateFlagAction = new NotificationUpdateFlagAction(arguments);
         action.index = index;
         return action;
      }
   }
}
