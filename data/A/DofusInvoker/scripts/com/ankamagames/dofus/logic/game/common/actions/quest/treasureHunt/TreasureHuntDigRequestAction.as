package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntDigRequestAction extends AbstractAction implements Action
   {
       
      
      public var questType:int;
      
      public function TreasureHuntDigRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questType:int) : TreasureHuntDigRequestAction
      {
         var action:TreasureHuntDigRequestAction = new TreasureHuntDigRequestAction(arguments);
         action.questType = questType;
         return action;
      }
   }
}
