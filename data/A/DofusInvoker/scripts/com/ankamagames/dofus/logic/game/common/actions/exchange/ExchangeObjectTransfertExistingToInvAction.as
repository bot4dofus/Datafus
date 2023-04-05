package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertExistingToInvAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeObjectTransfertExistingToInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeObjectTransfertExistingToInvAction
      {
         return new ExchangeObjectTransfertExistingToInvAction(arguments);
      }
   }
}
