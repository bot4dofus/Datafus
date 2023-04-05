package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildApplicationReplyAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number = 0;
      
      public var isAccepted:Boolean = false;
      
      public function GuildApplicationReplyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number, isAccepted:Boolean) : GuildApplicationReplyAction
      {
         var action:GuildApplicationReplyAction = new GuildApplicationReplyAction(arguments);
         action.isAccepted = isAccepted;
         action.playerId = playerId;
         return action;
      }
   }
}
