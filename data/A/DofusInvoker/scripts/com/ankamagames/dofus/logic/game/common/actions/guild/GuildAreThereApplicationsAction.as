package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildAreThereApplicationsAction extends AbstractAction implements Action
   {
       
      
      public function GuildAreThereApplicationsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildAreThereApplicationsAction
      {
         return new GuildAreThereApplicationsAction(arguments);
      }
   }
}
