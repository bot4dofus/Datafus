package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameRolePlayFreeSoulRequestAction extends AbstractAction implements Action
   {
       
      
      public function GameRolePlayFreeSoulRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GameRolePlayFreeSoulRequestAction
      {
         return new GameRolePlayFreeSoulRequestAction(arguments);
      }
   }
}
