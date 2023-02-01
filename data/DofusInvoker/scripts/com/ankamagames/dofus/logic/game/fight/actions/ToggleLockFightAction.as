package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleLockFightAction extends AbstractAction implements Action
   {
       
      
      public function ToggleLockFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleLockFightAction
      {
         return new ToggleLockFightAction(arguments);
      }
   }
}
