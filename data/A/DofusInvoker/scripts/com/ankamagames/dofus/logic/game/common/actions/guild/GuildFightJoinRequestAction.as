package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightJoinRequestAction extends AbstractAction implements Action
   {
       
      
      public var taxCollectorId:Number;
      
      public function GuildFightJoinRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTaxCollectorId:Number) : GuildFightJoinRequestAction
      {
         var action:GuildFightJoinRequestAction = new GuildFightJoinRequestAction(arguments);
         action.taxCollectorId = pTaxCollectorId;
         return action;
      }
   }
}
