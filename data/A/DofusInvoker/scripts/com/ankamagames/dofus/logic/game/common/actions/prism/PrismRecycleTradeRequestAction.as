package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismRecycleTradeRequestAction extends AbstractAction implements Action
   {
       
      
      public function PrismRecycleTradeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PrismRecycleTradeRequestAction
      {
         return new PrismRecycleTradeRequestAction(arguments);
      }
   }
}
