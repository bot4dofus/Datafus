package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInvitationAnswerAction extends AbstractAction implements Action
   {
       
      
      public var accept:Boolean;
      
      public function AllianceInvitationAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pAccept:Boolean) : AllianceInvitationAnswerAction
      {
         var action:AllianceInvitationAnswerAction = new AllianceInvitationAnswerAction(arguments);
         action.accept = pAccept;
         return action;
      }
   }
}
