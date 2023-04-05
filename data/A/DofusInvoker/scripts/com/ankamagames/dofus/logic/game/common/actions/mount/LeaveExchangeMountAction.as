package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveExchangeMountAction extends AbstractAction implements Action
   {
       
      
      public function LeaveExchangeMountAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : LeaveExchangeMountAction
      {
         return new LeaveExchangeMountAction(arguments);
      }
   }
}
