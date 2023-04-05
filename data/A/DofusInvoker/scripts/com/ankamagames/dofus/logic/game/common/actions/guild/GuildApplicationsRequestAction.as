package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildApplicationsRequestAction extends AbstractAction implements Action
   {
      
      public static const DEFAULT_LIMIT:uint = 10;
       
      
      public var timestamp:Number = 0;
      
      public var limit:uint = 10;
      
      public function GuildApplicationsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(timestamp:Number, limit:uint = 10) : GuildApplicationsRequestAction
      {
         var action:GuildApplicationsRequestAction = new GuildApplicationsRequestAction(arguments);
         action.timestamp = timestamp;
         action.limit = limit;
         return action;
      }
   }
}
