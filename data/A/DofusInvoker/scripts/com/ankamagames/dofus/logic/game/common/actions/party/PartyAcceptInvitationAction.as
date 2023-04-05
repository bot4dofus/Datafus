package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAcceptInvitationAction extends AbstractAction implements Action
   {
       
      
      public var partyId:int;
      
      public function PartyAcceptInvitationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int) : PartyAcceptInvitationAction
      {
         var a:PartyAcceptInvitationAction = new PartyAcceptInvitationAction(arguments);
         a.partyId = partyId;
         return a;
      }
   }
}
