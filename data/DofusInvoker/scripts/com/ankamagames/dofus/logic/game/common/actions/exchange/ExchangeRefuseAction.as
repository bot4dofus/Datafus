package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRefuseAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeRefuseAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeRefuseAction
      {
         return new ExchangeRefuseAction(arguments);
      }
   }
}
