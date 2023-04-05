package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeCraftPaymentModificationAction extends AbstractAction implements Action
   {
       
      
      public var kamas:Number = 0;
      
      public function ExchangeCraftPaymentModificationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pKamas:Number) : ExchangeCraftPaymentModificationAction
      {
         var action:ExchangeCraftPaymentModificationAction = new ExchangeCraftPaymentModificationAction(arguments);
         action.kamas = pKamas;
         return action;
      }
   }
}
