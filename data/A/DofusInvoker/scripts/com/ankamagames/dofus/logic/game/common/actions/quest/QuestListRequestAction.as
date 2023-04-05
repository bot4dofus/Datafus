package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestListRequestAction extends AbstractAction implements Action
   {
       
      
      public function QuestListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : QuestListRequestAction
      {
         return new QuestListRequestAction(arguments);
      }
   }
}
