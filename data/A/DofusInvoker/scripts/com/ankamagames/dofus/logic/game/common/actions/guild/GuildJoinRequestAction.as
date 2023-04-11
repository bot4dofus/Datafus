package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildJoinRequestAction extends AbstractAction implements Action
   {
       
      
      public var guildId:uint;
      
      public function GuildJoinRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTargetId:Number) : GuildJoinRequestAction
      {
         var action:GuildJoinRequestAction = new GuildJoinRequestAction(arguments);
         action.guildId = pTargetId;
         return action;
      }
   }
}
