package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildRightsViewAction extends AbstractAction implements Action
   {
       
      
      public var houseId:int;
      
      public var instanceId:int;
      
      public function HouseGuildRightsViewAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(houseId:int, instanceId:int) : HouseGuildRightsViewAction
      {
         var action:HouseGuildRightsViewAction = new HouseGuildRightsViewAction(arguments);
         action.houseId = houseId;
         action.instanceId = instanceId;
         return action;
      }
   }
}
