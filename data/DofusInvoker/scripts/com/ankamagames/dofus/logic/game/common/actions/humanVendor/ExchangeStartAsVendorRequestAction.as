package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeStartAsVendorRequestAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeStartAsVendorRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeStartAsVendorRequestAction
      {
         return new ExchangeStartAsVendorRequestAction(arguments);
      }
   }
}
