package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FinishMoveSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var enabledFinishedMoves:Vector.<int>;
      
      public var disabledFinishedMoves:Vector.<int>;
      
      public function FinishMoveSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enabledFinishedMoves:Vector.<int>, disabledFinishedMoves:Vector.<int>) : FinishMoveSetRequestAction
      {
         var action:FinishMoveSetRequestAction = new FinishMoveSetRequestAction(arguments);
         action.enabledFinishedMoves = enabledFinishedMoves;
         action.disabledFinishedMoves = disabledFinishedMoves;
         return action;
      }
   }
}
