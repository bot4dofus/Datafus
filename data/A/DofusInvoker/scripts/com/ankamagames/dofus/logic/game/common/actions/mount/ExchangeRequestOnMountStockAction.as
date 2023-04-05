package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnMountStockAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeRequestOnMountStockAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeRequestOnMountStockAction
      {
         return new ExchangeRequestOnMountStockAction(arguments);
      }
   }
}
