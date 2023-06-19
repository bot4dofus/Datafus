package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildGetChestTabContributionsRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuildGetChestTabContributionsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildGetChestTabContributionsRequestAction
      {
         return new GuildGetChestTabContributionsRequestAction(arguments);
      }
   }
}
