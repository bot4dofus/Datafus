package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleWitnessForbiddenAction extends AbstractAction implements Action
   {
       
      
      public function ToggleWitnessForbiddenAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleWitnessForbiddenAction
      {
         return new ToggleWitnessForbiddenAction(arguments);
      }
   }
}
