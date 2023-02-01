package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartGuildChestContributionAction extends AbstractAction implements Action
   {
       
      
      public function StartGuildChestContributionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StartGuildChestContributionAction
      {
         return new StartGuildChestContributionAction(arguments);
      }
   }
}
