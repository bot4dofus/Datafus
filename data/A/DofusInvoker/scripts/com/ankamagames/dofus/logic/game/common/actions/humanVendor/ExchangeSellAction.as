package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeSellAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public function ExchangeSellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint) : ExchangeSellAction
      {
         var a:ExchangeSellAction = new ExchangeSellAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         return a;
      }
   }
}
