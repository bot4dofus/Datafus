package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidSwitchToSellerModeAction extends AbstractAction implements Action
   {
       
      
      public function BidSwitchToSellerModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BidSwitchToSellerModeAction
      {
         return new BidSwitchToSellerModeAction(arguments);
      }
   }
}
