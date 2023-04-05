package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopToListenRunningFightAction extends AbstractAction implements Action
   {
       
      
      public function StopToListenRunningFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopToListenRunningFightAction
      {
         return new StopToListenRunningFightAction(arguments);
      }
   }
}
