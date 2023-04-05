package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismFightJoinLeaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var subAreaId:uint;
      
      public var join:Boolean;
      
      public function PrismFightJoinLeaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(subAreaId:uint, join:Boolean) : PrismFightJoinLeaveRequestAction
      {
         var action:PrismFightJoinLeaveRequestAction = new PrismFightJoinLeaveRequestAction(arguments);
         action.subAreaId = subAreaId;
         action.join = join;
         return action;
      }
   }
}
