package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickIndoorMerchantAction extends AbstractAction implements Action
   {
       
      
      public var cellId:uint;
      
      public function HouseKickIndoorMerchantAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(cellId:uint) : HouseKickIndoorMerchantAction
      {
         var action:HouseKickIndoorMerchantAction = new HouseKickIndoorMerchantAction(arguments);
         action.cellId = cellId;
         return action;
      }
   }
}
