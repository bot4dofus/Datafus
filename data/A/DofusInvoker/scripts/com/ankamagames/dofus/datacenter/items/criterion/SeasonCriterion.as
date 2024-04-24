package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.seasons.ArenaLeagueSeason;
   import com.ankamagames.dofus.datacenter.seasons.ExpeditionSeason;
   import com.ankamagames.dofus.datacenter.seasons.Season;
   import com.ankamagames.dofus.datacenter.seasons.ServerSeason;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SeasonCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function SeasonCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new SeasonCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var season:Season = ServerSeason.getCurrentSeason();
         if(!season)
         {
            season = ExpeditionSeason.getCurrentSeason();
            if(!season)
            {
               season = ArenaLeagueSeason.getCurrentSeason();
            }
         }
         return season && !season.isFinished() ? int(season.uid) : 0;
      }
      
      override public function get isRespected() : Boolean
      {
         return _operator.compare(this.getCriterion(),_criterionValue);
      }
   }
}
