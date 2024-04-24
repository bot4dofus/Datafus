package com.ankamagames.dofus.datacenter.seasons
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaLeagueSeason extends Season implements IDataCenter
   {
      
      public static const MODULE:String = "ArenaLeagueSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getArenaLeagueSeasonById,getArenaLeagueSeasons);
       
      
      public function ArenaLeagueSeason()
      {
         super();
      }
      
      public static function getArenaLeagueSeasonById(id:int) : ArenaLeagueSeason
      {
         return GameData.getObject(MODULE,id) as ArenaLeagueSeason;
      }
      
      public static function getArenaLeagueSeasons() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getCurrentSeason() : ArenaLeagueSeason
      {
         var allSeasons:Array = ArenaLeagueSeason.getArenaLeagueSeasons();
         return currentSeason(allSeasons) as ArenaLeagueSeason;
      }
   }
}
