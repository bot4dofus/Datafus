package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NpcDialogReplyAction extends AbstractAction implements Action
   {
       
      
      public var replyId:uint;
      
      public function NpcDialogReplyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(replyId:int) : NpcDialogReplyAction
      {
         var a:NpcDialogReplyAction = new NpcDialogReplyAction(arguments);
         a.replyId = replyId;
         return a;
      }
   }
}
