package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMouvmentRemoveAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public function ExchangeShopStockMouvmentRemoveAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:int) : ExchangeShopStockMouvmentRemoveAction
      {
         var a:ExchangeShopStockMouvmentRemoveAction = new ExchangeShopStockMouvmentRemoveAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = -Math.abs(pQuantity);
         return a;
      }
   }
}
