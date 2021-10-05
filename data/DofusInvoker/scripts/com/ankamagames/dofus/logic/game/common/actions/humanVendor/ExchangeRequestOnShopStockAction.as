package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnShopStockAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeRequestOnShopStockAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeRequestOnShopStockAction
      {
         return new ExchangeRequestOnShopStockAction(arguments);
      }
   }
}
