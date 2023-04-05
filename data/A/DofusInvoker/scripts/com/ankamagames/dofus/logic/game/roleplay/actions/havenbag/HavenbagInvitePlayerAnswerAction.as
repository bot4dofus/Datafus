package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagInvitePlayerAnswerAction extends AbstractAction implements Action
   {
       
      
      public var hostId:Number;
      
      public var accept:Boolean;
      
      public function HavenbagInvitePlayerAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(hostId:Number, accept:Boolean) : HavenbagInvitePlayerAnswerAction
      {
         var a:HavenbagInvitePlayerAnswerAction = new HavenbagInvitePlayerAnswerAction(arguments);
         a.hostId = hostId;
         a.accept = accept;
         return a;
      }
   }
}
