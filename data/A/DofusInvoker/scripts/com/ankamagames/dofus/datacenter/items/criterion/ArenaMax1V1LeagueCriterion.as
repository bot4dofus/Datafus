package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaMax1V1LeagueCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function ArenaMax1V1LeagueCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = ArenaLeague.getArenaLeagueById(_criterionValue).name;
         var readableCriterionRef:String = I18n.getUiText("ui.common.pvp1v1MaxLeague");
         var readableOperator:* = ">";
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableOperator = I18n.getUiText("ui.common.differentFrom") + " >";
         }
         return readableCriterionRef + " " + readableOperator + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new ArenaMax1V1LeagueCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var frame:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         return !!frame.arenaRank1V1Infos ? int(frame.arenaRank1V1Infos.bestLeagueId) : 0;
      }
   }
}
