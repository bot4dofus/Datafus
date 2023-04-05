package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightLeaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var taxCollectorId:Number;
      
      public var characterId:Number;
      
      public var warning:Boolean;
      
      public function GuildFightLeaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTaxCollectorId:Number, pCharacterId:Number, pWarning:Boolean = false) : GuildFightLeaveRequestAction
      {
         var action:GuildFightLeaveRequestAction = new GuildFightLeaveRequestAction(arguments);
         action.taxCollectorId = pTaxCollectorId;
         action.characterId = pCharacterId;
         action.warning = pWarning;
         return action;
      }
   }
}
