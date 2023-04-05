package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PartyNameSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var partyId:int;
      
      public var partyName:String;
      
      public function PartyNameSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(partyId:int, partyName:String) : PartyNameSetRequestAction
      {
         var a:PartyNameSetRequestAction = new PartyNameSetRequestAction(arguments);
         a.partyId = partyId;
         a.partyName = partyName;
         return a;
      }
   }
}
