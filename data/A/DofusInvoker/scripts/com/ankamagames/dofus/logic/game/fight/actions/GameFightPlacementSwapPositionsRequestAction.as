package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementSwapPositionsRequestAction extends AbstractAction implements Action
   {
       
      
      public var cellId:uint;
      
      public var requestedId:Number;
      
      public function GameFightPlacementSwapPositionsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pCellId:uint, pRequestedId:Number) : GameFightPlacementSwapPositionsRequestAction
      {
         var action:GameFightPlacementSwapPositionsRequestAction = new GameFightPlacementSwapPositionsRequestAction(arguments);
         action.cellId = pCellId;
         action.requestedId = pRequestedId;
         return action;
      }
   }
}
