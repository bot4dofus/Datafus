package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeShowVendorTaxAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeShowVendorTaxAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeShowVendorTaxAction
      {
         return new ExchangeShowVendorTaxAction(arguments);
      }
   }
}
