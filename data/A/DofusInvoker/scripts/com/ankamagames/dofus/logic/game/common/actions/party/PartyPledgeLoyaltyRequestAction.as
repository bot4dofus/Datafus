package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyPledgeLoyaltyRequestAction extends AbstractAction implements Action
   {
       
      
      public var loyal:Boolean;
      
      public var partyId:int;
      
      public function PartyPledgeLoyaltyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, loyal:Boolean) : PartyPledgeLoyaltyRequestAction
      {
         var a:PartyPledgeLoyaltyRequestAction = new PartyPledgeLoyaltyRequestAction(arguments);
         a.partyId = partyId;
         a.loyal = loyal;
         return a;
      }
   }
}
