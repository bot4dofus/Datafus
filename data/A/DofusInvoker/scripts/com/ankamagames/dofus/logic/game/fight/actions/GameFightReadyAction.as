package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightReadyAction extends AbstractAction implements Action
   {
       
      
      public var isReady:Boolean;
      
      public function GameFightReadyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(isReady:Boolean) : GameFightReadyAction
      {
         var a:GameFightReadyAction = new GameFightReadyAction(arguments);
         a.isReady = isReady;
         return a;
      }
   }
}
