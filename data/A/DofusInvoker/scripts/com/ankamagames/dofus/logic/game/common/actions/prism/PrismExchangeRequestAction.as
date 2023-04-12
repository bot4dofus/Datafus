package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismExchangeRequestAction extends AbstractAction implements Action
   {
       
      
      public function PrismExchangeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PrismExchangeRequestAction
      {
         return new PrismExchangeRequestAction(arguments);
      }
   }
}
