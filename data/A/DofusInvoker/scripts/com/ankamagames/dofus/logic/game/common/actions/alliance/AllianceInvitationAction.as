package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInvitationAction extends AbstractAction implements Action
   {
       
      
      public var targetId:Number;
      
      public function AllianceInvitationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTargetId:Number) : AllianceInvitationAction
      {
         var action:AllianceInvitationAction = new AllianceInvitationAction(arguments);
         action.targetId = pTargetId;
         return action;
      }
   }
}
