package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementAlmostFinishedDetailedListRequestAction extends AbstractAction implements Action
   {
       
      
      public function AchievementAlmostFinishedDetailedListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AchievementAlmostFinishedDetailedListRequestAction
      {
         return new AchievementAlmostFinishedDetailedListRequestAction(arguments);
      }
   }
}
