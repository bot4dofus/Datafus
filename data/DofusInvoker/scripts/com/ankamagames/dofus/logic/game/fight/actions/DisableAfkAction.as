package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DisableAfkAction extends AbstractAction implements Action
   {
       
      
      public function DisableAfkAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : DisableAfkAction
      {
         return new DisableAfkAction(arguments);
      }
   }
}
