package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSetApplicationUpdatesRequestAction extends AbstractAction implements Action
   {
       
      
      public var areEnabled:Boolean = false;
      
      public function GuildSetApplicationUpdatesRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(areEnabled:Boolean) : GuildSetApplicationUpdatesRequestAction
      {
         var action:GuildSetApplicationUpdatesRequestAction = new GuildSetApplicationUpdatesRequestAction(arguments);
         action.areEnabled = areEnabled;
         return action;
      }
   }
}
