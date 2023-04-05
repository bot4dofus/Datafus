package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuidedModeQuitRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuidedModeQuitRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuidedModeQuitRequestAction
      {
         return new GuidedModeQuitRequestAction(arguments);
      }
   }
}
