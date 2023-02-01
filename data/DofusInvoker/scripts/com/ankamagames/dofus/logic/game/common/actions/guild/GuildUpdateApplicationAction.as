package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildUpdateApplicationAction extends AbstractAction implements Action
   {
       
      
      public var applyText:String;
      
      public var guildId:uint;
      
      public function GuildUpdateApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(applyText:String, guildId:uint) : GuildUpdateApplicationAction
      {
         var action:GuildUpdateApplicationAction = new GuildUpdateApplicationAction(arguments);
         action.applyText = applyText;
         action.guildId = guildId;
         return action;
      }
   }
}
