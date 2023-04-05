package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceChangeMemberRankAction extends AbstractAction implements Action
   {
       
      
      public var memberId:Number;
      
      public var rankId:uint;
      
      public function AllianceChangeMemberRankAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pMemberId:Number, pRankId:uint) : AllianceChangeMemberRankAction
      {
         var action:AllianceChangeMemberRankAction = new AllianceChangeMemberRankAction(arguments);
         action.memberId = pMemberId;
         action.rankId = pRankId;
         return action;
      }
   }
}
