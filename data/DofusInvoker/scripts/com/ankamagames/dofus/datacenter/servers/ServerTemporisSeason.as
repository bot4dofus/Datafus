package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ServerTemporisSeason implements IDataCenter
   {
      
      public static const MODULE:String = "ServerTemporisSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSeasonById,getAllSeason);
       
      
      public var uid:int;
      
      public var seasonNumber:uint;
      
      public var information:String;
      
      public var beginning:Number;
      
      public var closure:Number;
      
      public function ServerTemporisSeason()
      {
         super();
      }
      
      public static function getSeasonById(id:int) : ServerTemporisSeason
      {
         return GameData.getObject(MODULE,id) as ServerTemporisSeason;
      }
      
      public static function getAllSeason() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getCurrentSeason() : ServerTemporisSeason
      {
         var season:ServerTemporisSeason = null;
         var allSeason:Array = ServerTemporisSeason.getAllSeason();
         var timeManager:TimeManager = TimeManager.getInstance();
         if(allSeason === null || timeManager === null)
         {
            return null;
         }
         var currentDate:Number = timeManager.getTimestamp();
         for each(season in allSeason)
         {
            if(currentDate >= season.beginning && currentDate <= season.closure)
            {
               return season;
            }
         }
         return null;
      }
   }
}
