package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatSmileyRequestAction extends AbstractAction implements Action
   {
       
      
      public var smileyId:int;
      
      public function ChatSmileyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:int) : ChatSmileyRequestAction
      {
         var a:ChatSmileyRequestAction = new ChatSmileyRequestAction(arguments);
         a.smileyId = id;
         return a;
      }
   }
}
