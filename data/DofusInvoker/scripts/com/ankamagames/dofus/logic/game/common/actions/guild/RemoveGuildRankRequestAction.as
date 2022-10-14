package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveGuildRankRequestAction extends AbstractAction implements Action
   {
       
      
      public var rankId:uint;
      
      public var newRankId:uint;
      
      public function RemoveGuildRankRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rankId:uint, newRankId:uint) : RemoveGuildRankRequestAction
      {
         var action:RemoveGuildRankRequestAction = new RemoveGuildRankRequestAction(arguments);
         action.rankId = rankId;
         action.newRankId = newRankId;
         return action;
      }
   }
}
