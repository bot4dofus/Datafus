package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockBuyRequestAction extends AbstractAction implements Action
   {
       
      
      public var proposedPrice:Number = 0;
      
      public function PaddockBuyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(proposedPrice:Number) : PaddockBuyRequestAction
      {
         var action:PaddockBuyRequestAction = new PaddockBuyRequestAction(arguments);
         action.proposedPrice = proposedPrice;
         return action;
      }
   }
}
