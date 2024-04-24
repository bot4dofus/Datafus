package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementsPioneerRanksRequestAction extends AbstractAction implements Action
   {
       
      
      public function AchievementsPioneerRanksRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AchievementsPioneerRanksRequestAction
      {
         return new AchievementsPioneerRanksRequestAction(arguments);
      }
   }
}
