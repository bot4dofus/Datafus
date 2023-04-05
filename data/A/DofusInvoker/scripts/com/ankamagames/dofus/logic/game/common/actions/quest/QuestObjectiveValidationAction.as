package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestObjectiveValidationAction extends AbstractAction implements Action
   {
       
      
      public var questId:int;
      
      public var objectiveId:int;
      
      public function QuestObjectiveValidationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questId:int, objectiveId:int) : QuestObjectiveValidationAction
      {
         var a:QuestObjectiveValidationAction = new QuestObjectiveValidationAction(arguments);
         a.questId = questId;
         a.objectiveId = objectiveId;
         return a;
      }
   }
}
