package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnTaxCollectorAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeRequestOnTaxCollectorAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeRequestOnTaxCollectorAction
      {
         return new ExchangeRequestOnTaxCollectorAction(arguments);
      }
   }
}
