package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatCommandAction extends AbstractAction implements Action
   {
       
      
      public var command:String;
      
      public function ChatCommandAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(command:String) : ChatCommandAction
      {
         var a:ChatCommandAction = new ChatCommandAction(arguments);
         a.command = command;
         return a;
      }
   }
}
