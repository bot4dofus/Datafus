package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildRanksRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuildRanksRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildRanksRequestAction
      {
         return new GuildRanksRequestAction(arguments);
      }
   }
}
