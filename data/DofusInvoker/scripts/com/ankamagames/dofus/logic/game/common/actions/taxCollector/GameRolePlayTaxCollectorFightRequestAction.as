package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameRolePlayTaxCollectorFightRequestAction extends AbstractAction implements Action
   {
       
      
      public function GameRolePlayTaxCollectorFightRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GameRolePlayTaxCollectorFightRequestAction
      {
         return new GameRolePlayTaxCollectorFightRequestAction(arguments);
      }
   }
}
