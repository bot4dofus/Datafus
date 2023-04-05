package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenPopupAction extends AbstractAction implements Action
   {
       
      
      public var messageToShow:String;
      
      public function OpenPopupAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pMsg:String = "") : OpenPopupAction
      {
         var s:OpenPopupAction = new OpenPopupAction(arguments);
         s.messageToShow = pMsg;
         return s;
      }
   }
}
