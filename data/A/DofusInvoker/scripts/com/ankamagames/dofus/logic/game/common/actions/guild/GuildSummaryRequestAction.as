package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.internalDatacenter.social.GuildDirectoryFiltersWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSummaryRequestAction extends AbstractAction implements Action
   {
       
      
      public var filters:GuildDirectoryFiltersWrapper;
      
      public var offset:uint;
      
      public var count:uint;
      
      public function GuildSummaryRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(filters:GuildDirectoryFiltersWrapper, offset:uint, count:uint) : GuildSummaryRequestAction
      {
         var action:GuildSummaryRequestAction = new GuildSummaryRequestAction(arguments);
         action.filters = filters;
         action.offset = offset;
         action.count = count;
         return action;
      }
   }
}
