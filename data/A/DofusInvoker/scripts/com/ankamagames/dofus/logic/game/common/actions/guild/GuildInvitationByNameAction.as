package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildInvitationByNameAction extends AbstractAction implements Action
   {
       
      
      public var target:String;
      
      public function GuildInvitationByNameAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTarget:String) : GuildInvitationByNameAction
      {
         var action:GuildInvitationByNameAction = new GuildInvitationByNameAction(arguments);
         action.target = pTarget;
         return action;
      }
   }
}
