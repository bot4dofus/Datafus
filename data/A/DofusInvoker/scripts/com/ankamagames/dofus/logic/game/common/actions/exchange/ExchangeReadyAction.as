package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReadyAction extends AbstractAction implements Action
   {
       
      
      public var isReady:Boolean;
      
      public function ExchangeReadyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIsReady:Boolean) : ExchangeReadyAction
      {
         var a:ExchangeReadyAction = new ExchangeReadyAction(arguments);
         a.isReady = pIsReady;
         return a;
      }
   }
}
