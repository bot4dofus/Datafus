package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntFlagRequestAction extends AbstractAction implements Action
   {
       
      
      public var questType:int;
      
      public var index:int;
      
      public function TreasureHuntFlagRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questType:int, index:int) : TreasureHuntFlagRequestAction
      {
         var action:TreasureHuntFlagRequestAction = new TreasureHuntFlagRequestAction(arguments);
         action.questType = questType;
         action.index = index;
         return action;
      }
   }
}
