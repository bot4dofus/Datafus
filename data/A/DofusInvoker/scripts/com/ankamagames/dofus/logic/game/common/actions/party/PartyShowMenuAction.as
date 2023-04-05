package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyShowMenuAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var partyId:int;
      
      public function PartyShowMenuAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pPlayerId:Number, pPartyId:int) : PartyShowMenuAction
      {
         var a:PartyShowMenuAction = new PartyShowMenuAction(arguments);
         a.playerId = pPlayerId;
         a.partyId = pPartyId;
         return a;
      }
   }
}
