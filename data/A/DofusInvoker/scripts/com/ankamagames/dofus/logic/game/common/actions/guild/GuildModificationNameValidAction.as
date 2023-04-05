package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationNameValidAction extends AbstractAction implements Action
   {
       
      
      public var guildName:String;
      
      public function GuildModificationNameValidAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pGuildName:String) : GuildModificationNameValidAction
      {
         var action:GuildModificationNameValidAction = new GuildModificationNameValidAction(arguments);
         action.guildName = pGuildName;
         return action;
      }
   }
}
