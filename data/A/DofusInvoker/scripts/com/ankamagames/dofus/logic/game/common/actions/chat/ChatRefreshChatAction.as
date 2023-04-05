package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatRefreshChatAction extends AbstractAction implements Action
   {
       
      
      public var currentTab:uint;
      
      public function ChatRefreshChatAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(currentTab:uint) : ChatRefreshChatAction
      {
         var a:ChatRefreshChatAction = new ChatRefreshChatAction(arguments);
         a.currentTab = currentTab;
         return a;
      }
   }
}
