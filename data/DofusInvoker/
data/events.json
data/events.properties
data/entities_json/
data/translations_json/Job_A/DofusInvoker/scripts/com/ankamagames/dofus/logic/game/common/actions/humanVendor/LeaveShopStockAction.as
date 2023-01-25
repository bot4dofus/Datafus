package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveShopStockAction extends AbstractAction implements Action
   {
       
      
      public function LeaveShopStockAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : LeaveShopStockAction
      {
         return new LeaveShopStockAction(arguments);
      }
   }
}
