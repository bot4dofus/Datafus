package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceRankUpdateRequestAction extends AbstractAction implements Action
   {
       
      
      public var rank:RankInformation;
      
      public function AllianceRankUpdateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rank:RankInformation) : AllianceRankUpdateRequestAction
      {
         var action:AllianceRankUpdateRequestAction = new AllianceRankUpdateRequestAction(arguments);
         action.rank = rank;
         return action;
      }
   }
}
