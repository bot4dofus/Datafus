package com.ankamagames.dofus.datacenter.seasons
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ExpeditionSeason extends Season implements IDataCenter
   {
      
      public static const MODULE:String = "ExpeditionSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getExpeditionSeasonById,getExpeditionSeasons);
       
      
      public function ExpeditionSeason()
      {
         super();
      }
      
      public static function getExpeditionSeasonById(id:int) : ExpeditionSeason
      {
         return GameData.getObject(MODULE,id) as ExpeditionSeason;
      }
      
      public static function getExpeditionSeasons() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getCurrentSeason() : ExpeditionSeason
      {
         var allSeasons:Array = ExpeditionSeason.getExpeditionSeasons();
         return currentSeason(allSeasons) as ExpeditionSeason;
      }
   }
}
