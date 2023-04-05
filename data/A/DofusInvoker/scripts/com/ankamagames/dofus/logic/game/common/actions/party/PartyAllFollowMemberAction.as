package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyAllFollowMemberAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var partyId:int;
      
      public function PartyAllFollowMemberAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, pPlayerId:Number) : PartyAllFollowMemberAction
      {
         var a:PartyAllFollowMemberAction = new PartyAllFollowMemberAction(arguments);
         a.partyId = partyId;
         a.playerId = pPlayerId;
         return a;
      }
   }
}
