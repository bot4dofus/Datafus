package com.ankamagames.dofus.datacenter.arena
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaLeagueSeason implements IDataCenter
   {
      
      public static const MODULE:String = "ArenaLeagueSeasons";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getArenaLeagueSeasonById,getArenaLeagueSeasons);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
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
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
