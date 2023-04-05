package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightPlacementPositionRequestAction extends AbstractAction implements Action
   {
       
      
      public var cellId:int;
      
      public function GameFightPlacementPositionRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:int) : GameFightPlacementPositionRequestAction
      {
         var a:GameFightPlacementPositionRequestAction = new GameFightPlacementPositionRequestAction(arguments);
         a.cellId = id;
         return a;
      }
   }
}
