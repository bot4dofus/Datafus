package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildKickRequestAction extends AbstractAction implements Action
   {
       
      
      public var targetId:Number;
      
      public function GuildKickRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTargetId:Number) : GuildKickRequestAction
      {
         var action:GuildKickRequestAction = new GuildKickRequestAction(arguments);
         action.targetId = pTargetId;
         return action;
      }
   }
}
