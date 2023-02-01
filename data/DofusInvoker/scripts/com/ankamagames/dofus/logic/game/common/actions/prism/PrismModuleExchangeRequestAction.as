package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismModuleExchangeRequestAction extends AbstractAction implements Action
   {
       
      
      public function PrismModuleExchangeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PrismModuleExchangeRequestAction
      {
         return new PrismModuleExchangeRequestAction(arguments);
      }
   }
}
