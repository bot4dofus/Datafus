package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntFlagRemoveRequestAction extends AbstractAction implements Action
   {
       
      
      public var questType:int;
      
      public var index:int;
      
      public function TreasureHuntFlagRemoveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questType:int, index:int) : TreasureHuntFlagRemoveRequestAction
      {
         var action:TreasureHuntFlagRemoveRequestAction = new TreasureHuntFlagRemoveRequestAction(arguments);
         action.questType = questType;
         action.index = index;
         return action;
      }
   }
}
