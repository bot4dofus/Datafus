package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:int;
      
      public function ExchangeObjectMoveAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:int) : ExchangeObjectMoveAction
      {
         var a:ExchangeObjectMoveAction = new ExchangeObjectMoveAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         return a;
      }
   }
}
