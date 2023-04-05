package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ResetGameAction extends AbstractAction implements Action
   {
       
      
      public var messageToShow:String;
      
      public function ResetGameAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pMsg:String = "") : ResetGameAction
      {
         var a:ResetGameAction = new ResetGameAction(arguments);
         a.messageToShow = pMsg;
         return a;
      }
   }
}
