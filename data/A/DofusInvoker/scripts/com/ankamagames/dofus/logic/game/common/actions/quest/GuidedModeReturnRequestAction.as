package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuidedModeReturnRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuidedModeReturnRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuidedModeReturnRequestAction
      {
         return new GuidedModeReturnRequestAction(arguments);
      }
   }
}
