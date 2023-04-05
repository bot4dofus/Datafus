package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinAsSpectatorRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightId:uint;
      
      public function JoinAsSpectatorRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightId:uint) : JoinAsSpectatorRequestAction
      {
         var a:JoinAsSpectatorRequestAction = new JoinAsSpectatorRequestAction(arguments);
         a.fightId = fightId;
         return a;
      }
   }
}
