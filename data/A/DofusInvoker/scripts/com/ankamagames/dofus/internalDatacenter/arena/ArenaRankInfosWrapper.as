package com.ankamagames.dofus.internalDatacenter.arena
{
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaRankInfosWrapper implements IDataCenter
   {
       
      
      public const LEAGUE_DEFAULT_ICON_ID:String = "icon_kolizeum01.png";
      
      public var rating:int = 0;
      
      public var arenaType:uint = 1;
      
      public var maxRating:int = 0;
      
      public var dailyFightCount:int = 0;
      
      public var dailyVictoryCount:int = 0;
      
      public var seasonFightCount:int = 0;
      
      public var seasonVictoryCount:int = 0;
      
      public var leagueId:int = -1;
      
      public var bestLeagueId:int = -1;
      
      public var leagueName:String = "";
      
      public var bestLeagueName:String = "";
      
      public var inLastLeague:Boolean = false;
      
      public var ladderPosition:int = -1;
      
      public var numFightNeededForLadder:int = 0;
      
      public var leagueIconId:String = "icon_kolizeum01.png";
      
      public var bestLeagueIconId:String = "icon_kolizeum01.png";
      
      public function ArenaRankInfosWrapper()
      {
         super();
      }
      
      public static function create(informations:ArenaRankInfos) : ArenaRankInfosWrapper
      {
         var bestLeague:ArenaLeague = null;
         var league:ArenaLeague = null;
         var obj:ArenaRankInfosWrapper = new ArenaRankInfosWrapper();
         obj.arenaType = informations.arenaType;
         if(informations.dailyFightcount)
         {
            obj.dailyFightCount = informations.dailyFightcount;
         }
         if(informations.dailyVictoryCount)
         {
            obj.dailyVictoryCount = informations.dailyVictoryCount;
         }
         if(informations.seasonFightcount)
         {
            obj.seasonFightCount = informations.seasonFightcount;
         }
         if(informations.seasonVictoryCount)
         {
            obj.seasonVictoryCount = informations.seasonVictoryCount;
         }
         if(informations.numFightNeededForLadder)
         {
            obj.numFightNeededForLadder = informations.numFightNeededForLadder;
         }
         if(informations.bestRating)
         {
            obj.maxRating = informations.bestRating;
         }
         if(informations.bestLeagueId)
         {
            obj.bestLeagueId = informations.bestLeagueId;
            bestLeague = ArenaLeague.getArenaLeagueById(obj.bestLeagueId);
            if(bestLeague)
            {
               obj.bestLeagueIconId = bestLeague.iconWithExtension;
               obj.bestLeagueName = bestLeague.name;
            }
         }
         if(informations.leagueRanking)
         {
            obj.rating = informations.leagueRanking.rating;
            obj.leagueId = informations.leagueRanking.leagueId;
            obj.ladderPosition = informations.leagueRanking.ladderPosition;
            league = ArenaLeague.getArenaLeagueById(obj.leagueId);
            if(league != null)
            {
               obj.leagueName = league.name;
               obj.inLastLeague = league.isLastLeague;
               obj.leagueIconId = league.iconWithExtension;
            }
         }
         return obj;
      }
   }
}
