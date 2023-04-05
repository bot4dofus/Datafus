package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsCancelAction extends AbstractAction implements Action
   {
       
      
      public var requestId:uint;
      
      public function GameFightPlacementSwapPositionsCancelAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pRequestId:uint) : GameFightPlacementSwapPositionsCancelAction
      {
         var action:GameFightPlacementSwapPositionsCancelAction = new GameFightPlacementSwapPositionsCancelAction(arguments);
         action.requestId = pRequestId;
         return action;
      }
   }
}
