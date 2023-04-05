package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertListFromInvAction extends AbstractAction implements Action
   {
       
      
      public var ids:Vector.<uint>;
      
      public function ExchangeObjectTransfertListFromInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIds:Vector.<uint>) : ExchangeObjectTransfertListFromInvAction
      {
         var a:ExchangeObjectTransfertListFromInvAction = new ExchangeObjectTransfertListFromInvAction(arguments);
         a.ids = pIds;
         return a;
      }
   }
}
