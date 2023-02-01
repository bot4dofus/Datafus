package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidSwitchToBuyerModeAction extends AbstractAction implements Action
   {
       
      
      public function BidSwitchToBuyerModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BidSwitchToBuyerModeAction
      {
         return new BidSwitchToBuyerModeAction(arguments);
      }
   }
}
