package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertListWithQuantityToInvAction extends AbstractAction implements Action
   {
       
      
      public var ids:Vector.<uint>;
      
      public var qtys:Vector.<uint>;
      
      public function ExchangeObjectTransfertListWithQuantityToInvAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIds:Vector.<uint>, pQtys:Vector.<uint>) : ExchangeObjectTransfertListWithQuantityToInvAction
      {
         var a:ExchangeObjectTransfertListWithQuantityToInvAction = new ExchangeObjectTransfertListWithQuantityToInvAction(arguments);
         a.ids = pIds;
         a.qtys = pQtys;
         return a;
      }
   }
}
