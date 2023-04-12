package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleHelpWantedAction extends AbstractAction implements Action
   {
       
      
      public function ToggleHelpWantedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleHelpWantedAction
      {
         return new ToggleHelpWantedAction(arguments);
      }
   }
}
