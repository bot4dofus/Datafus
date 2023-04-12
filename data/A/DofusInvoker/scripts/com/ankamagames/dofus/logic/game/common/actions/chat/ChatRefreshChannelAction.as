package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatRefreshChannelAction extends AbstractAction implements Action
   {
       
      
      public function ChatRefreshChannelAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ChatRefreshChannelAction
      {
         return new ChatRefreshChannelAction(arguments);
      }
   }
}
