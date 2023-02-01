package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildListRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuildListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildListRequestAction
      {
         return new GuildListRequestAction(arguments);
      }
   }
}
