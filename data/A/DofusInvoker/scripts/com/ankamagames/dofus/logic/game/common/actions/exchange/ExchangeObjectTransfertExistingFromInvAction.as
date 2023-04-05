package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertExistingFromInvAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeObjectTransfertExistingFromInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeObjectTransfertExistingFromInvAction
      {
         return new ExchangeObjectTransfertExistingFromInvAction(arguments);
      }
   }
}
