package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaUnregisterAction extends AbstractAction implements Action
   {
       
      
      public function ArenaUnregisterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ArenaUnregisterAction
      {
         return new ArenaUnregisterAction(arguments);
      }
   }
}
