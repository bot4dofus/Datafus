package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveToTabAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public var tabNumber:uint;
      
      public function ExchangeObjectMoveToTabAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:int, pTabNumber:uint) : ExchangeObjectMoveToTabAction
      {
         var a:ExchangeObjectMoveToTabAction = new ExchangeObjectMoveToTabAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         a.tabNumber = pTabNumber;
         return a;
      }
   }
}
