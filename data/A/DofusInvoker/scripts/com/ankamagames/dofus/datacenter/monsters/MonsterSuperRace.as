package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterSuperRace implements IDataCenter
   {
      
      public static const MODULE:String = "MonsterSuperRaces";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMonsterSuperRaceById,getMonsterSuperRaces);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function MonsterSuperRace()
      {
         super();
      }
      
      public static function getMonsterSuperRaceById(id:uint) : MonsterSuperRace
      {
         return GameData.getObject(MODULE,id) as MonsterSuperRace;
      }
      
      public static function getMonsterSuperRaces() : Array
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
