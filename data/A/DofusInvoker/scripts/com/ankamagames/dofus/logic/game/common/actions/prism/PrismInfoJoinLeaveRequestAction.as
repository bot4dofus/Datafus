package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismInfoJoinLeaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var join:Boolean;
      
      public function PrismInfoJoinLeaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(join:Boolean) : PrismInfoJoinLeaveRequestAction
      {
         var action:PrismInfoJoinLeaveRequestAction = new PrismInfoJoinLeaveRequestAction(arguments);
         action.join = join;
         return action;
      }
   }
}
