package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateAllGuildRankRequestAction extends AbstractAction implements Action
   {
       
      
      public var ranks:Vector.<GuildRankInformation>;
      
      public function UpdateAllGuildRankRequestAction(params:Array = null)
      {
         this.ranks = new Vector.<GuildRankInformation>();
         super(params);
      }
      
      public static function create(ranks:Vector.<GuildRankInformation>) : UpdateAllGuildRankRequestAction
      {
         var action:UpdateAllGuildRankRequestAction = new UpdateAllGuildRankRequestAction(arguments);
         action.ranks = ranks;
         return action;
      }
   }
}
