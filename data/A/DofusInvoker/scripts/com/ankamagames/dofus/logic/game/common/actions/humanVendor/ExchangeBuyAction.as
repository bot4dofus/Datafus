package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBuyAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public function ExchangeBuyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint) : ExchangeBuyAction
      {
         var a:ExchangeBuyAction = new ExchangeBuyAction(arguments);
         a.objectUID = pObjectUID;
         a.quantity = pQuantity;
         return a;
      }
   }
}
