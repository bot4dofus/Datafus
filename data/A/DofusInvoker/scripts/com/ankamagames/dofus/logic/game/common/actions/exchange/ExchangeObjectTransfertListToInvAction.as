package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertListToInvAction extends AbstractAction implements Action
   {
       
      
      public var ids:Vector.<uint>;
      
      public function ExchangeObjectTransfertListToInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIds:Vector.<uint>) : ExchangeObjectTransfertListToInvAction
      {
         var a:ExchangeObjectTransfertListToInvAction = new ExchangeObjectTransfertListToInvAction(arguments);
         a.ids = pIds;
         return a;
      }
   }
}
