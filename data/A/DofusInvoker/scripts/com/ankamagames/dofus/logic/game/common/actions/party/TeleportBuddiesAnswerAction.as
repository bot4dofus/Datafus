package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportBuddiesAnswerAction extends AbstractAction implements Action
   {
       
      
      public var accept:Boolean;
      
      public function TeleportBuddiesAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accept:Boolean) : TeleportBuddiesAnswerAction
      {
         var a:TeleportBuddiesAnswerAction = new TeleportBuddiesAnswerAction(arguments);
         a.accept = accept;
         return a;
      }
   }
}
