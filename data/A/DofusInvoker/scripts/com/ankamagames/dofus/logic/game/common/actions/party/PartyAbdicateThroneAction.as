package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAbdicateThroneAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var partyId:int;
      
      public function PartyAbdicateThroneAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, pPlayerId:Number) : PartyAbdicateThroneAction
      {
         var a:PartyAbdicateThroneAction = new PartyAbdicateThroneAction(arguments);
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
   }
}
