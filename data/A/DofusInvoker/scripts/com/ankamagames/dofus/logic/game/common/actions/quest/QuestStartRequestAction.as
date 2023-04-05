package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestStartRequestAction extends AbstractAction implements Action
   {
       
      
      public var questId:int;
      
      public function QuestStartRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questId:int) : QuestStartRequestAction
      {
         var a:QuestStartRequestAction = new QuestStartRequestAction(arguments);
         a.questId = questId;
         return a;
      }
   }
}
