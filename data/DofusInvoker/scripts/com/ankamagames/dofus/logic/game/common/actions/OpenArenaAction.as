package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenArenaAction extends AbstractAction implements Action
   {
       
      
      public function OpenArenaAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenArenaAction
      {
         return new OpenArenaAction(arguments);
      }
   }
}
