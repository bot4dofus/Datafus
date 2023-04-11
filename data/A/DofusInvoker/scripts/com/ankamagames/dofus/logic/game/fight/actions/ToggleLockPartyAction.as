package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleLockPartyAction extends AbstractAction implements Action
   {
       
      
      public function ToggleLockPartyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleLockPartyAction
      {
         return new ToggleLockPartyAction(arguments);
      }
   }
}
