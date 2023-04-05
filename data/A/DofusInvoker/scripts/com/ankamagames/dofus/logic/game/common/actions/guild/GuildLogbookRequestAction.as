package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildLogbookRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuildLogbookRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildLogbookRequestAction
      {
         return new GuildLogbookRequestAction(arguments);
      }
   }
}
