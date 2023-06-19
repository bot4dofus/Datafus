package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.internalDatacenter.social.GuildDirectoryFiltersWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSubmitApplicationAction extends AbstractAction implements Action
   {
       
      
      public var applyText:String;
      
      public var guildId:uint;
      
      public var filters:GuildDirectoryFiltersWrapper;
      
      public var timeSpent:int;
      
      public function GuildSubmitApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(applyText:String, guildId:uint, timeSpent:int, filters:GuildDirectoryFiltersWrapper = null) : GuildSubmitApplicationAction
      {
         var action:GuildSubmitApplicationAction = new GuildSubmitApplicationAction(arguments);
         action.applyText = applyText;
         action.guildId = guildId;
         action.timeSpent = timeSpent;
         action.filters = filters;
         return action;
      }
   }
}
