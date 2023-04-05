package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsAcceptAction extends AbstractAction implements Action
   {
       
      
      public var requestId:uint;
      
      public function GameFightPlacementSwapPositionsAcceptAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pRequestId:uint) : GameFightPlacementSwapPositionsAcceptAction
      {
         var action:GameFightPlacementSwapPositionsAcceptAction = new GameFightPlacementSwapPositionsAcceptAction(arguments);
         action.requestId = pRequestId;
         return action;
      }
   }
}
