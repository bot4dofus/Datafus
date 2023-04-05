package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFarmTeleportRequestAction extends AbstractAction implements Action
   {
       
      
      public var farmId:Number;
      
      public function GuildFarmTeleportRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pFarmId:Number) : GuildFarmTeleportRequestAction
      {
         var action:GuildFarmTeleportRequestAction = new GuildFarmTeleportRequestAction(arguments);
         action.farmId = pFarmId;
         return action;
      }
   }
}
