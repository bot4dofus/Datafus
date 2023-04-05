package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismFightSwapRequestAction extends AbstractAction implements Action
   {
       
      
      public var subAreaId:uint;
      
      public var targetId:Number;
      
      public function PrismFightSwapRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(subAreaId:uint, targetId:Number) : PrismFightSwapRequestAction
      {
         var action:PrismFightSwapRequestAction = new PrismFightSwapRequestAction(arguments);
         action.targetId = targetId;
         action.subAreaId = subAreaId;
         return action;
      }
   }
}
