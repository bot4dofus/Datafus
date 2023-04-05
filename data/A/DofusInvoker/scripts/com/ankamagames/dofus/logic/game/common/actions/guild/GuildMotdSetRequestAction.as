package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildMotdSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public function GuildMotdSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(content:String) : GuildMotdSetRequestAction
      {
         var action:GuildMotdSetRequestAction = new GuildMotdSetRequestAction(arguments);
         action.content = content;
         return action;
      }
   }
}
