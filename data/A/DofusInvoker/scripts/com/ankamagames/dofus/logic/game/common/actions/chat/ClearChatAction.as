package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ClearChatAction extends AbstractAction implements Action
   {
       
      
      public var channel:Array;
      
      public function ClearChatAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(channel:Array) : ClearChatAction
      {
         var a:ClearChatAction = new ClearChatAction(arguments);
         a.channel = channel;
         return a;
      }
   }
}
