package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildChangeMemberParametersAction extends AbstractAction implements Action
   {
       
      
      public var memberId:Number;
      
      public var rankId:uint;
      
      public var experienceGivenPercent:uint;
      
      public function GuildChangeMemberParametersAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pMemberId:Number, pRankId:uint, pExperienceGivenPercent:uint) : GuildChangeMemberParametersAction
      {
         var action:GuildChangeMemberParametersAction = new GuildChangeMemberParametersAction(arguments);
         action.memberId = pMemberId;
         action.rankId = pRankId;
         action.experienceGivenPercent = pExperienceGivenPercent;
         return action;
      }
   }
}
