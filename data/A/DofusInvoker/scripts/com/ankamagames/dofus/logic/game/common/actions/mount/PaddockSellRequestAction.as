package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockSellRequestAction extends AbstractAction implements Action
   {
       
      
      public var price:Number = 0;
      
      public var forSale:Boolean;
      
      public function PaddockSellRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(price:Number, forSale:Boolean = true) : PaddockSellRequestAction
      {
         var o:PaddockSellRequestAction = new PaddockSellRequestAction(arguments);
         o.price = price;
         o.forSale = forSale;
         return o;
      }
   }
}
