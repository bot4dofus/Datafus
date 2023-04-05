package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseBuyAction extends AbstractAction implements Action
   {
       
      
      public var uid:uint;
      
      public var qty:uint;
      
      public var price:Number = 0;
      
      public function ExchangeBidHouseBuyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pUid:uint, pQty:uint, pPrice:Number) : ExchangeBidHouseBuyAction
      {
         var a:ExchangeBidHouseBuyAction = new ExchangeBidHouseBuyAction(arguments);
         a.uid = pUid;
         a.qty = pQty;
         a.price = pPrice;
         return a;
      }
   }
}
