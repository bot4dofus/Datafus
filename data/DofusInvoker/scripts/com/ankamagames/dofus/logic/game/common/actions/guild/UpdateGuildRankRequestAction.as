package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateGuildRankRequestAction extends AbstractAction implements Action
   {
       
      
      public var rank:GuildRankInformation;
      
      public function UpdateGuildRankRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rank:GuildRankInformation) : UpdateGuildRankRequestAction
      {
         var action:UpdateGuildRankRequestAction = new UpdateGuildRankRequestAction(arguments);
         action.rank = rank;
         return action;
      }
   }
}
