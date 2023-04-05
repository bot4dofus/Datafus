package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationAction extends AbstractAction implements Action
   {
       
      
      public var targetId:Number;
      
      public function GuildInvitationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTargetId:Number) : GuildInvitationAction
      {
         var action:GuildInvitationAction = new GuildInvitationAction(arguments);
         action.targetId = pTargetId;
         return action;
      }
   }
}
