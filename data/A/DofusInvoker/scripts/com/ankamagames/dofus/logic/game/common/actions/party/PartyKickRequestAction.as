package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyKickRequestAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var partyId:int;
      
      public function PartyKickRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, playerId:Number) : PartyKickRequestAction
      {
         var a:PartyKickRequestAction = new PartyKickRequestAction(arguments);
         a.partyId = partyId;
         a.playerId = playerId;
         return a;
      }
   }
}
