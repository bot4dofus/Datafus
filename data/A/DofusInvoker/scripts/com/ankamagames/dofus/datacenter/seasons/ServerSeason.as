package com.ankamagames.dofus.datacenter.seasons
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ServerSeason extends Season implements IDataCenter
   {
      
      public static const MODULE:String = "ServerSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSeasonById,getAllSeason);
       
      
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
         var allSeasons:Array = ServerSeason.getAllSeason();
         return currentSeason(allSeasons) as ServerSeason;
      }
   }
}
