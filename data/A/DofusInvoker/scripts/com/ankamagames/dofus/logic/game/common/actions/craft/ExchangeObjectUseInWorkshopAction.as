package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectUseInWorkshopAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public function ExchangeObjectUseInWorkshopAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint) : ExchangeObjectUseInWorkshopAction
      {
         var action:ExchangeObjectUseInWorkshopAction = new ExchangeObjectUseInWorkshopAction(arguments);
         action.objectUID = pObjectUID;
         action.quantity = pQuantity;
         return action;
      }
   }
}
