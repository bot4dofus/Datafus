package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMainMenuAction extends AbstractAction implements Action
   {
       
      
      public function OpenMainMenuAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenMainMenuAction
      {
         return new OpenMainMenuAction(arguments);
      }
   }
}
