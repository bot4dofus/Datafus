package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyInvitationDetailsRequestAction extends AbstractAction implements Action
   {
       
      
      public var partyId:int;
      
      public function PartyInvitationDetailsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int) : PartyInvitationDetailsRequestAction
      {
         var a:PartyInvitationDetailsRequestAction = new PartyInvitationDetailsRequestAction(arguments);
         a.partyId = partyId;
         return a;
      }
   }
}
