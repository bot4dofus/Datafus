package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveKamaAction extends AbstractAction implements Action
   {
       
      
      public var kamas:Number = 0;
      
      public function ExchangeObjectMoveKamaAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pKamas:Number) : ExchangeObjectMoveKamaAction
      {
         var a:ExchangeObjectMoveKamaAction = new ExchangeObjectMoveKamaAction(arguments);
         a.kamas = pKamas;
         return a;
      }
   }
}
