package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveDialogRequestAction extends AbstractAction implements Action
   {
       
      
      public function LeaveDialogRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : LeaveDialogRequestAction
      {
         return new LeaveDialogRequestAction(arguments);
      }
   }
}
