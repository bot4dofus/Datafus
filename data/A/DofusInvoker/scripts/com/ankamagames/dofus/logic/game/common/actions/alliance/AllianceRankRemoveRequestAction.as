package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceRankRemoveRequestAction extends AbstractAction implements Action
   {
       
      
      public var rankId:uint;
      
      public var newRankId:uint;
      
      public function AllianceRankRemoveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rankId:uint, newRankId:uint) : AllianceRankRemoveRequestAction
      {
         var action:AllianceRankRemoveRequestAction = new AllianceRankRemoveRequestAction(arguments);
         action.rankId = rankId;
         action.newRankId = newRankId;
         return action;
      }
   }
}
