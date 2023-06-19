package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleDematerializationAction extends AbstractAction implements Action
   {
       
      
      public function ToggleDematerializationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleDematerializationAction
      {
         return new ToggleDematerializationAction(arguments);
      }
   }
}
