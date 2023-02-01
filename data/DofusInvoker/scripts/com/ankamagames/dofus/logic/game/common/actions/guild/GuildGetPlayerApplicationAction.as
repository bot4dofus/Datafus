package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildGetPlayerApplicationAction extends AbstractAction implements Action
   {
       
      
      public function GuildGetPlayerApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildGetPlayerApplicationAction
      {
         return new GuildGetPlayerApplicationAction(arguments);
      }
   }
}
