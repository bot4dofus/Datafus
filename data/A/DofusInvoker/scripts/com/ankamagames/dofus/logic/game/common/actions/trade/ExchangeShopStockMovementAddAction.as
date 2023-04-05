package com.ankamagames.dofus.logic.game.common.actions.trade
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMovementAddAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public var price:Number = 0;
      
      public function ExchangeShopStockMovementAddAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint, pPrice:Number) : ExchangeShopStockMovementAddAction
      {
         var a:ExchangeShopStockMovementAddAction = new ExchangeShopStockMovementAddAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         a.price = pPrice;
         return a;
      }
   }
}
