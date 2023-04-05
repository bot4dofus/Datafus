package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightTakePlaceRequestAction extends AbstractAction implements Action
   {
       
      
      public var taxCollectorId:Number;
      
      public var replacedCharacterId:Number;
      
      public function GuildFightTakePlaceRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTaxCollectorId:Number, replacedCharacterId:Number) : GuildFightTakePlaceRequestAction
      {
         var action:GuildFightTakePlaceRequestAction = new GuildFightTakePlaceRequestAction(arguments);
         action.taxCollectorId = pTaxCollectorId;
         action.replacedCharacterId = replacedCharacterId;
         return action;
      }
   }
}
