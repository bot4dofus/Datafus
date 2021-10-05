package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WatchQuestInfosRequestAction extends AbstractAction implements Action
   {
       
      
      public var questId:int;
      
      public var playerId:int;
      
      public function WatchQuestInfosRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questId:int, playerId:int) : WatchQuestInfosRequestAction
      {
         var a:WatchQuestInfosRequestAction = new WatchQuestInfosRequestAction(arguments);
         a.questId = questId;
         a.playerId = playerId;
         return a;
      }
   }
}
