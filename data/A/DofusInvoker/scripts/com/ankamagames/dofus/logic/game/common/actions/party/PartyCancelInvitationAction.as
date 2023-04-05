package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyCancelInvitationAction extends AbstractAction implements Action
   {
       
      
      public var guestId:Number;
      
      public var partyId:int;
      
      public function PartyCancelInvitationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, guestId:Number) : PartyCancelInvitationAction
      {
         var a:PartyCancelInvitationAction = new PartyCancelInvitationAction(arguments);
         a.partyId = partyId;
         a.guestId = guestId;
         return a;
      }
   }
}
