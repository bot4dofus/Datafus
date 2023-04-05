package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyFollowMemberAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var partyId:int;
      
      public function PartyFollowMemberAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, pPlayerId:Number) : PartyFollowMemberAction
      {
         var a:PartyFollowMemberAction = new PartyFollowMemberAction(arguments);
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
   }
}
