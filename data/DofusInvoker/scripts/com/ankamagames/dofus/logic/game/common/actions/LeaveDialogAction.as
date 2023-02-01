package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveDialogAction extends AbstractAction implements Action
   {
       
      
      public function LeaveDialogAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : LeaveDialogAction
      {
         return new LeaveDialogAction(arguments);
      }
   }
}
