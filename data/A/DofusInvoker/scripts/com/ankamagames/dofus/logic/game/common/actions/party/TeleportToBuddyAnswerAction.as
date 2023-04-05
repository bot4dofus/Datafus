package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportToBuddyAnswerAction extends AbstractAction implements Action
   {
       
      
      public var dungeonId:int;
      
      public var buddyId:Number;
      
      public var accept:Boolean;
      
      public function TeleportToBuddyAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(dungeonId:int, buddyId:Number, accept:Boolean) : TeleportToBuddyAnswerAction
      {
         var a:TeleportToBuddyAnswerAction = new TeleportToBuddyAnswerAction(arguments);
         a.dungeonId = dungeonId;
         a.buddyId = buddyId;
         a.accept = accept;
         return a;
      }
   }
}
