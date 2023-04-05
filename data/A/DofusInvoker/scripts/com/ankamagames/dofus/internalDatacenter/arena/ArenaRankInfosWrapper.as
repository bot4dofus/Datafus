package com.ankamagames.dofus.internalDatacenter.arena
{
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaRankInfosWrapper implements IDataCenter
   {
       
      
      public const LEAGUE_DEFAULT_ICON_ID:String = "icon_kolizeum01.png";
      
      public var rank:int = 0;
      
      public var maxRank:int = 0;
      
      public var todayFightCount:int = 0;
      
      public var todayVictoryCount:int = 0;
      
      public var leagueId:int = -1;
      
      public var leagueName:String = "";
      
      public var inLastLeague:Boolean = false;
      
      public var leagueProgression:int = -1;
      
      public var ladderPosition:int = -1;
      
      public var totalLeaguePoint:int = -1;
      
      public var numFightNeededForLadder:int = 0;
      
      public var leagueIconId:String = "icon_kolizeum01.png";
      
      public function ArenaRankInfosWrapper()
      {
         super();
      }
      
      public static function create(informations:ArenaRankInfos) : ArenaRankInfosWrapper
      {
         var league:ArenaLeague = null;
         var obj:ArenaRankInfosWrapper = new ArenaRankInfosWrapper();
         if(informations.fightcount)
         {
            obj.todayFightCount = informations.fightcount;
         }
         if(informations.victoryCount)
         {
            obj.todayVictoryCount = informations.victoryCount;
         }
         if(informations.numFightNeededForLadder)
         {
            obj.numFightNeededForLadder = informations.numFightNeededForLadder;
         }
         if(informations.leagueRanking)
         {
            obj.rank = informations.leagueRanking.rank;
            obj.leagueId = informations.leagueRanking.leagueId;
            obj.leagueProgression = informations.leagueRanking.leaguePoints;
            obj.ladderPosition = informations.leagueRanking.ladderPosition;
            obj.totalLeaguePoint = informations.leagueRanking.totalLeaguePoints;
            league = ArenaLeague.getArenaLeagueById(obj.leagueId);
            if(league != null)
            {
               obj.leagueName = league.name;
               obj.inLastLeague = league.isLastLeague;
               obj.leagueIconId = league.iconWithExtension;
            }
         }
         else if(informations.ranking)
         {
            obj.rank = informations.ranking.rank;
            obj.maxRank = informations.ranking.bestRank;
         }
         return obj;
      }
   }
}
