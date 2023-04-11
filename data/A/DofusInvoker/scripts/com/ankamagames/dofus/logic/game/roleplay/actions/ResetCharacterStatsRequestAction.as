package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ResetCharacterStatsRequestAction extends AbstractAction implements Action
   {
       
      
      public function ResetCharacterStatsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ResetCharacterStatsRequestAction
      {
         return new ResetCharacterStatsRequestAction(arguments);
      }
   }
}
