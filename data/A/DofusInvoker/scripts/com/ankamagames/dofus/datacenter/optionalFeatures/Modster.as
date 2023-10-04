package com.ankamagames.dofus.datacenter.optionalFeatures
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class Modster implements IDataCenter
   {
      
      public static const MODULE:String = "Modsters";
      
      private static var _spellIdKromaCache:Dictionary = new Dictionary();
      
      private static var _scrollIdsCache:Dictionary = new Dictionary();
      
      private static var _modsterIdsCache:Dictionary = new Dictionary();
      
      public static var idAccessors:IdAccessors = new IdAccessors(getModsterById,getModsters);
       
      
      public var id:int;
      
      public var spellIdKroma:int;
      
      public var itemId:int;
      
      public var itemIdKroma:int;
      
      public var modsterId:int;
      
      public var order:int;
      
      public var parentsModsterId:Vector.<int>;
      
      public var modsterActiveSpells:Vector.<int>;
      
      public var modsterPassiveSpells:Vector.<int>;
      
      public var modsterHiddenAchievements:Vector.<int>;
      
      public var modsterAchievements:Vector.<int>;
      
      public var kromaHiddenAchievements:Vector.<int>;
      
      public var kromaAchievements:Vector.<int>;
      
      private var _name:String = "";
      
      public function Modster()
      {
         super();
      }
      
      public static function getModsterById(id:int) : Modster
      {
         var m:Modster = null;
         var modster:Modster = GameData.getObject(MODULE,id) as Modster;
         if(modster)
         {
            return modster;
         }
         if(_spellIdKromaCache[id])
         {
            return _spellIdKromaCache[id];
         }
         var modsters:Array = getModsters();
         for each(m in modsters)
         {
            if(m.spellIdKroma == id)
            {
               _spellIdKromaCache[id] = m;
               return m;
            }
         }
         return null;
      }
      
      public static function getModsterByScrollId(scrollId:int) : Modster
      {
         var modster:Modster = null;
         if(_scrollIdsCache[scrollId])
         {
            return _scrollIdsCache[scrollId];
         }
         var modsters:Array = getModsters();
         for each(modster in modsters)
         {
            if(modster.itemId === scrollId || modster.itemIdKroma == scrollId)
            {
               _scrollIdsCache[scrollId] = modster;
               return modster;
            }
         }
         return null;
      }
      
      public static function getModsterByModsterId(modsterId:int) : Modster
      {
         var modster:Modster = null;
         if(_modsterIdsCache[modsterId])
         {
            return _modsterIdsCache[modsterId];
         }
         var modsters:Array = getModsters();
         for each(modster in modsters)
         {
            if(modster.modsterId === modsterId)
            {
               _modsterIdsCache[modsterId] = modster;
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
