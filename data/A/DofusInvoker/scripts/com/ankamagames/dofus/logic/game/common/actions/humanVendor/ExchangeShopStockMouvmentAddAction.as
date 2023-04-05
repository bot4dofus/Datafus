package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShopStockMouvmentAddAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public var price:Number = 0;
      
      public function ExchangeShopStockMouvmentAddAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint, pPrice:Number) : ExchangeShopStockMouvmentAddAction
      {
         var a:ExchangeShopStockMouvmentAddAction = new ExchangeShopStockMouvmentAddAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         a.price = pPrice;
         return a;
      }
   }
}
