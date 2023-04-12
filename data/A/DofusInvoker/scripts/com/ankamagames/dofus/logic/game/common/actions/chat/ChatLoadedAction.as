package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatLoadedAction extends AbstractAction implements Action
   {
       
      
      public function ChatLoadedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ChatLoadedAction
      {
         return new ChatLoadedAction(arguments);
      }
   }
}
