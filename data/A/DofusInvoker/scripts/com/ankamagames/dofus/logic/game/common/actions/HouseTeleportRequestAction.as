package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseTeleportRequestAction extends AbstractAction implements Action
   {
       
      
      public var houseId:uint;
      
      public var houseInstanceId:int;
      
      public function HouseTeleportRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pHouseId:uint, houseInstanceId:int) : HouseTeleportRequestAction
      {
         var action:HouseTeleportRequestAction = new HouseTeleportRequestAction(arguments);
         action.houseId = pHouseId;
         action.houseInstanceId = houseInstanceId;
         return action;
      }
   }
}
