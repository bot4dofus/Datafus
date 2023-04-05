package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAnswerAction extends AbstractAction implements Action
   {
       
      
      public var accept:Boolean;
      
      public function GuildInvitationAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pAccept:Boolean) : GuildInvitationAnswerAction
      {
         var action:GuildInvitationAnswerAction = new GuildInvitationAnswerAction(arguments);
         action.accept = pAccept;
         return action;
      }
   }
}
