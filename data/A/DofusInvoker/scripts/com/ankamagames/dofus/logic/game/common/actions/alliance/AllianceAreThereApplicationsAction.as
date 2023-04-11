package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceAreThereApplicationsAction extends AbstractAction implements Action
   {
       
      
      public function AllianceAreThereApplicationsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceAreThereApplicationsAction
      {
         return new AllianceAreThereApplicationsAction(arguments);
      }
   }
}
