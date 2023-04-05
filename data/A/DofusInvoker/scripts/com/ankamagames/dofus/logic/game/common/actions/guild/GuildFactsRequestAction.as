package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFactsRequestAction extends AbstractAction implements Action
   {
       
      
      public var guildId:uint;
      
      public function GuildFactsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(guildId:uint) : GuildFactsRequestAction
      {
         var action:GuildFactsRequestAction = new GuildFactsRequestAction(arguments);
         action.guildId = guildId;
         return action;
      }
   }
}
