package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.internalDatacenter.social.AllianceRecruitmentDataWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SendAllianceRecruitmentDataAction extends AbstractAction implements Action
   {
       
      
      public var recruitmentData:AllianceRecruitmentDataWrapper = null;
      
      public function SendAllianceRecruitmentDataAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(recruitmentData:AllianceRecruitmentDataWrapper) : SendAllianceRecruitmentDataAction
      {
         var action:SendAllianceRecruitmentDataAction = new SendAllianceRecruitmentDataAction(arguments);
         action.recruitmentData = recruitmentData;
         return action;
      }
   }
}
