package com.ankamagames.dofus.datacenter.optionalFeatures
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Modster implements IDataCenter
   {
      
      public static const MODULE:String = "Modsters";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getModsterById,getModsters);
       
      
      public var id:int;
      
      public var itemId:int;
      
      public var modsterId:int;
      
      public var order:int;
      
      public var parentsModsterId:Vector.<int>;
      
      public var modsterActiveSpells:Vector.<int>;
      
      public var modsterPassiveSpells:Vector.<int>;
      
      public var modsterHiddenAchievements:Vector.<int>;
      
      public var modsterAchievements:Vector.<int>;
      
      private var _name:String = "";
      
      public function Modster()
      {
         super();
      }
      
      public static function getModsterById(id:int) : Modster
      {
         return GameData.getObject(MODULE,id) as Modster;
      }
      
      public static function getModsterByScrollId(scrollId:int) : Modster
      {
         var modster:Modster = null;
         var modsters:Array = getModsters();
         for each(modster in modsters)
         {
            if(modster.itemId === scrollId)
            {
               return modster;
            }
         }
         return null;
      }
      
      public static function getModsterByModsterId(modsterId:int) : Modster
      {
         var modster:Modster = null;
         var modsters:Array = getModsters();
         for each(modster in modsters)
         {
            if(modster.modsterId === modsterId)
            {
               return modster;
            }
         }
         return null;
      }
      
      public static function getModsters() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         var monster:Monster = null;
         if(this._name == "")
         {
            monster = Monster.getMonsterById(this.modsterId);
            if(monster)
            {
               this._name = monster.name;
            }
         }
         return this._name;
      }
   }
}
