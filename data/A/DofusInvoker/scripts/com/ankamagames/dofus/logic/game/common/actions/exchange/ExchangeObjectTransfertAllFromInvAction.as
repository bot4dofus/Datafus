package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertAllFromInvAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeObjectTransfertAllFromInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeObjectTransfertAllFromInvAction
      {
         return new ExchangeObjectTransfertAllFromInvAction(arguments);
      }
   }
}
