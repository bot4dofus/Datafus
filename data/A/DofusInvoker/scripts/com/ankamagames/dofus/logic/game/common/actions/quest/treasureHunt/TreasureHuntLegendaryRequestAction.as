package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntLegendaryRequestAction extends AbstractAction implements Action
   {
       
      
      public var legendaryId:int;
      
      public function TreasureHuntLegendaryRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(legendaryId:int) : TreasureHuntLegendaryRequestAction
      {
         var action:TreasureHuntLegendaryRequestAction = new TreasureHuntLegendaryRequestAction(arguments);
         action.legendaryId = legendaryId;
         return action;
      }
   }
}
