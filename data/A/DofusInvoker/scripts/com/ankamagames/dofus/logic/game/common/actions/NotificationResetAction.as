package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NotificationResetAction extends AbstractAction implements Action
   {
       
      
      public function NotificationResetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : NotificationResetAction
      {
         return new NotificationResetAction(arguments);
      }
   }
}
