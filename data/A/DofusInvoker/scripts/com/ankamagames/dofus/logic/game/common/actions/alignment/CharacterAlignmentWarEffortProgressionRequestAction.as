package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterAlignmentWarEffortProgressionRequestAction extends AbstractAction implements Action
   {
       
      
      public function CharacterAlignmentWarEffortProgressionRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CharacterAlignmentWarEffortProgressionRequestAction
      {
         return new CharacterAlignmentWarEffortProgressionRequestAction(arguments);
      }
   }
}
