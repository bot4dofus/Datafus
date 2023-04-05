package com.ankamagames.dofus.datacenter.arena
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaLeagueReward implements IDataCenter
   {
      
      public static const MODULE:String = "ArenaLeagueRewards";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getArenaLeagueRewardById,getArenaLeagueRewards);
       
      
      public var id:int;
      
      public var seasonId:uint;
      
      public var leagueId:uint;
      
      public var titlesRewards:Vector.<uint>;
      
      public var endSeasonRewards:Boolean;
      
      public function ArenaLeagueReward()
      {
         super();
      }
      
      public static function getArenaLeagueRewardById(id:int) : ArenaLeagueReward
      {
         return GameData.getObject(MODULE,id) as ArenaLeagueReward;
      }
      
      public static function getArenaLeagueRewards() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
