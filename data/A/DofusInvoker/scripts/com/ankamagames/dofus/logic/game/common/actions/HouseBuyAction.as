package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseBuyAction extends AbstractAction implements Action
   {
       
      
      public var proposedPrice:Number = 0;
      
      public function HouseBuyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(proposedPrice:Number) : HouseBuyAction
      {
         var action:HouseBuyAction = new HouseBuyAction(arguments);
         action.proposedPrice = proposedPrice;
         return action;
      }
   }
}
