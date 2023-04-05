package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightTurnFinishAction extends AbstractAction implements Action
   {
       
      
      public function GameFightTurnFinishAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GameFightTurnFinishAction
      {
         return new GameFightTurnFinishAction(arguments);
      }
   }
}
