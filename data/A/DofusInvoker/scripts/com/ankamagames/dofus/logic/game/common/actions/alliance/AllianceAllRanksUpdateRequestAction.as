package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceAllRanksUpdateRequestAction extends AbstractAction implements Action
   {
       
      
      public var ranks:Vector.<RankInformation>;
      
      public function AllianceAllRanksUpdateRequestAction(params:Array = null)
      {
         this.ranks = new Vector.<RankInformation>();
         super(params);
      }
      
      public static function create(ranks:Vector.<RankInformation>) : AllianceAllRanksUpdateRequestAction
      {
         var action:AllianceAllRanksUpdateRequestAction = new AllianceAllRanksUpdateRequestAction(arguments);
         action.ranks = ranks;
         return action;
      }
   }
}