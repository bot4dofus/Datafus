package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachInvitationAnswerAction extends AbstractAction implements Action
   {
       
      
      public var answer:Boolean;
      
      public function BreachInvitationAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(answer:Boolean) : BreachInvitationAnswerAction
      {
         var a:BreachInvitationAnswerAction = new BreachInvitationAnswerAction(arguments);
         a.answer = answer;
         return a;
      }
   }
}
