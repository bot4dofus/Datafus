package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerRequestAction extends AbstractAction implements Action
   {
       
      
      public var exchangeType:int;
      
      public var target:Number;
      
      public function ExchangePlayerRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(exchangeType:int, target:Number) : ExchangePlayerRequestAction
      {
         var a:ExchangePlayerRequestAction = new ExchangePlayerRequestAction(arguments);
         a.exchangeType = exchangeType;
         a.target = target;
         return a;
      }
   }
}
