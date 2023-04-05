package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceRanksRequestAction extends AbstractAction implements Action
   {
       
      
      public function AllianceRanksRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceRanksRequestAction
      {
         return new AllianceRanksRequestAction(arguments);
      }
   }
}
