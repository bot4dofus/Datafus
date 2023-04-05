package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyRefuseInvitationAction extends AbstractAction implements Action
   {
       
      
      public var partyId:int;
      
      public function PartyRefuseInvitationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int) : PartyRefuseInvitationAction
      {
         var a:PartyRefuseInvitationAction = new PartyRefuseInvitationAction(arguments);
         a.partyId = partyId;
         return a;
      }
   }
}
