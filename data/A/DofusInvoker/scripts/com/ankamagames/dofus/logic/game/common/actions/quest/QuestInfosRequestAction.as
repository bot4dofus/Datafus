package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestInfosRequestAction extends AbstractAction implements Action
   {
       
      
      public var questId:int;
      
      public function QuestInfosRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questId:int) : QuestInfosRequestAction
      {
         var a:QuestInfosRequestAction = new QuestInfosRequestAction(arguments);
         a.questId = questId;
         return a;
      }
   }
}
