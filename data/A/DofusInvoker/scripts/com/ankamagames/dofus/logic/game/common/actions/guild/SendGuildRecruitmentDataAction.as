package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.internalDatacenter.social.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SendGuildRecruitmentDataAction extends AbstractAction implements Action
   {
       
      
      public var recruitmentData:GuildRecruitmentDataWrapper = null;
      
      public function SendGuildRecruitmentDataAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(recruitmentData:GuildRecruitmentDataWrapper) : SendGuildRecruitmentDataAction
      {
         var action:SendGuildRecruitmentDataAction = new SendGuildRecruitmentDataAction(arguments);
         action.recruitmentData = recruitmentData;
         return action;
      }
   }
}
