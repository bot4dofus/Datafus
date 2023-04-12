package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenTeamSearchAction extends AbstractAction implements Action
   {
       
      
      public function OpenTeamSearchAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenTeamSearchAction
      {
         return new OpenTeamSearchAction(arguments);
      }
   }
}
