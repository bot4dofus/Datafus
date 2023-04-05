package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpectatePlayerRequestAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public function GameFightSpectatePlayerRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number) : GameFightSpectatePlayerRequestAction
      {
         var a:GameFightSpectatePlayerRequestAction = new GameFightSpectatePlayerRequestAction(arguments);
         a.playerId = playerId;
         return a;
      }
   }
}
