package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntGiveUpRequestAction extends AbstractAction implements Action
   {
       
      
      public var questType:int;
      
      public function TreasureHuntGiveUpRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(questType:int) : TreasureHuntGiveUpRequestAction
      {
         var action:TreasureHuntGiveUpRequestAction = new TreasureHuntGiveUpRequestAction(arguments);
         action.questType = questType;
         return action;
      }
   }
}
