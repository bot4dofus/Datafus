package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AlignmentWarEffortProgressionRequestAction extends AbstractAction implements Action
   {
       
      
      public function AlignmentWarEffortProgressionRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AlignmentWarEffortProgressionRequestAction
      {
         return new AlignmentWarEffortProgressionRequestAction(arguments);
      }
   }
}
