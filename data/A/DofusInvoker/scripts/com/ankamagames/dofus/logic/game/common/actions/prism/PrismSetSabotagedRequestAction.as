package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSetSabotagedRequestAction extends AbstractAction implements Action
   {
       
      
      public var subAreaId:uint;
      
      public function PrismSetSabotagedRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(subAreaId:uint) : PrismSetSabotagedRequestAction
      {
         var action:PrismSetSabotagedRequestAction = new PrismSetSabotagedRequestAction(arguments);
         action.subAreaId = subAreaId;
         return action;
      }
   }
}
