package com.ankamagames.dofus.datacenter.collection
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Collectable implements IDataCenter
   {
      
      public static const MODULE:String = "Collectables";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCollectableById,getCollectables);
       
      
      public var entityId:int;
      
      public var name:int;
      
      public var typeId:int;
      
      public var gfxId:int;
      
      public var order:int;
      
      public var rarity:int;
      
      private var _entityName:String = "";
      
      public function Collectable()
      {
         super();
      }
      
      public static function getCollectableById(id:int) : Collectable
      {
         return GameData.getObject(MODULE,id) as Collectable;
      }
      
      public static function getCollectables() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get entityName() : String
      {
         var monster:Monster = null;
         if(this._entityName == "")
         {
            switch(this.typeId)
            {
               case 1:
                  monster = Monster.getMonsterById(this.entityId);
                  if(monster)
                  {
                     this._entityName = monster.name;
                  }
            }
         }
         return this._entityName;
      }
   }
}
