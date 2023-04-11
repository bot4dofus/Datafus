package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TogglePointCellAction extends AbstractAction implements Action
   {
       
      
      public function TogglePointCellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : TogglePointCellAction
      {
         return new TogglePointCellAction(arguments);
      }
   }
}
