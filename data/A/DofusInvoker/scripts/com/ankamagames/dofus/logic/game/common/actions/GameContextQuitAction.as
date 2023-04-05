package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameContextQuitAction extends AbstractAction implements Action
   {
       
      
      public function GameContextQuitAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GameContextQuitAction
      {
         return new GameContextQuitAction(arguments);
      }
   }
}
