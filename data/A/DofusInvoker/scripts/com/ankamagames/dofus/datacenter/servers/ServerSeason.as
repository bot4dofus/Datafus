package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ServerSeason implements IDataCenter
   {
      
      public static const MODULE:String = "ServerSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSeasonById,getAllSeason);
       
      
      public var uid:int;
      
      public var seasonNumber:uint;
      
      public var information:String;
      
      public var beginning:Number;
      
      public var closure:Number;
      
      public var resetDate:Number;
      
      public var flagObjectId:uint;
      
      public function ServerSeason()
      {
         super();
      }
      
      public static function getSeasonById(id:int) : ServerSeason
      {
         return GameData.getObject(MODULE,id) as ServerSeason;
      }
      
      public static function getAllSeason() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getCurrentSeason() : ServerSeason
      {
         var season:ServerSeason = null;
         var allSeason:Array = ServerSeason.getAllSeason();
         var timeManager:TimeManager = TimeManager.getInstance();
         if(allSeason === null || timeManager === null)
         {
            return null;
         }
         var currentDate:Number = timeManager.getTimestamp();
         for each(season in allSeason)
         {
            if(season.resetDate <= season.closure)
            {
               if(currentDate >= season.beginning && currentDate <= season.closure)
               {
                  return season;
               }
            }
            else if(currentDate >= season.beginning && currentDate <= season.resetDate)
            {
               return season;
            }
         }
         return null;
      }
      
      public function isFinished() : Boolean
      {
         var timeManager:TimeManager = TimeManager.getInstance();
         var currentDate:Number = timeManager.getTimestamp();
         return currentDate > this.closure;
      }
   }
}
