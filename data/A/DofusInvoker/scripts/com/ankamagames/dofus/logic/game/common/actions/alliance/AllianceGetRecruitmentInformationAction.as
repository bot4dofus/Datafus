package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceGetRecruitmentInformationAction extends AbstractAction implements Action
   {
       
      
      public function AllianceGetRecruitmentInformationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceGetRecruitmentInformationAction
      {
         return new AllianceGetRecruitmentInformationAction();
      }
   }
}
