package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachExitRequestAction extends AbstractAction implements Action
   {
       
      
      public function BreachExitRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BreachExitRequestAction
      {
         return new BreachExitRequestAction(arguments);
      }
   }
}
