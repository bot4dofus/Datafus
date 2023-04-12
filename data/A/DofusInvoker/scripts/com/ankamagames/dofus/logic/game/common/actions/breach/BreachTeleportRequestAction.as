package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachTeleportRequestAction extends AbstractAction implements Action
   {
       
      
      public function BreachTeleportRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BreachTeleportRequestAction
      {
         return new BreachTeleportRequestAction(arguments);
      }
   }
}
