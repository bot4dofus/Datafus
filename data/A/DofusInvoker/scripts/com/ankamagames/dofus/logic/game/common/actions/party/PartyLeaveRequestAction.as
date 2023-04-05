package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyLeaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var partyId:int;
      
      public function PartyLeaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int) : PartyLeaveRequestAction
      {
         var a:PartyLeaveRequestAction = new PartyLeaveRequestAction(arguments);
         a.partyId = partyId;
         return a;
      }
   }
}
