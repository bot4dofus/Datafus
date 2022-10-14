package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PopupWarningCloseRequestAction extends AbstractAction implements Action
   {
       
      
      public function PopupWarningCloseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PopupWarningCloseRequestAction
      {
         return new PopupWarningCloseRequestAction(arguments);
      }
   }
}
