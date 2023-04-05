package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameContextKickAction extends AbstractAction implements Action
   {
       
      
      public var targetId:Number;
      
      public function GameContextKickAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(targetId:Number) : GameContextKickAction
      {
         var a:GameContextKickAction = new GameContextKickAction(arguments);
         a.targetId = targetId;
         return a;
      }
   }
}
