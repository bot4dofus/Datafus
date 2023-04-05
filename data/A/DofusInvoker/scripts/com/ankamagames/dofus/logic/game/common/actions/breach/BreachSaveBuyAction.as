package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachSaveBuyAction extends AbstractAction implements Action
   {
       
      
      public function BreachSaveBuyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BreachSaveBuyAction
      {
         return new BreachSaveBuyAction(arguments);
      }
   }
}
