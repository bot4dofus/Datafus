package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopGuildChestContributionAction extends AbstractAction implements Action
   {
       
      
      public function StopGuildChestContributionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopGuildChestContributionAction
      {
         return new StopGuildChestContributionAction(arguments);
      }
   }
}
