package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeOnHumanVendorRequestAction extends AbstractAction implements Action
   {
       
      
      public var humanVendorId:Number;
      
      public var humanVendorCell:int;
      
      public function ExchangeOnHumanVendorRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pHumanVendorId:Number, pHumanVendorCell:uint) : ExchangeOnHumanVendorRequestAction
      {
         var a:ExchangeOnHumanVendorRequestAction = new ExchangeOnHumanVendorRequestAction(arguments);
         a.humanVendorId = pHumanVendorId;
         a.humanVendorCell = pHumanVendorCell;
         return a;
      }
   }
}
