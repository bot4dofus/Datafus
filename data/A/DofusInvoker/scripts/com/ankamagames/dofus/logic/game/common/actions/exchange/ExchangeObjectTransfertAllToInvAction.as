package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertAllToInvAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeObjectTransfertAllToInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeObjectTransfertAllToInvAction
      {
         return new ExchangeObjectTransfertAllToInvAction(arguments);
      }
   }
}
