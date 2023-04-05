package com.ankamagames.dofus.datacenter.optionalFeatures
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class CustomModeBreedSpell implements IDataCenter
   {
      
      public static const MODULE:String = "CustomModeBreedSpells";
      
      private static var _allSpellsId:Array = null;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCustomModeBreedSpellById,getCustomModeBreedSpells);
       
      
      public var id:int;
      
      public var pairId:int;
      
      public var breedId:int;
      
      public var isInitialSpell:Boolean;
      
      public var isHidden:Boolean;
      
      public function CustomModeBreedSpell()
      {
         super();
      }
      
      public static function getCustomModeBreedSpellById(id:int) : CustomModeBreedSpell
      {
         return GameData.getObject(MODULE,id) as CustomModeBreedSpell;
      }
      
      public static function getCustomModeBreedSpells() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getAllCustomModeBreedSpellIds() : Array
      {
         var customModeBreedSpells:Array = null;
         var index:uint = 0;
         if(_allSpellsId === null)
         {
            _allSpellsId = [];
            customModeBreedSpells = getCustomModeBreedSpells();
            for(index = 0; index < customModeBreedSpells.length; index++)
            {
               _allSpellsId.push(customModeBreedSpells[index].id);
            }
         }
         return _allSpellsId;
      }
      
      public static function getCustomModeBreedSpellIds(breedId:int) : Array
      {
         var index:uint = 0;
         var toReturn:Array = [];
         var customModeBreedSpells:Array = getCustomModeBreedSpells();
         var currentCustomModeBreedSpell:CustomModeBreedSpell = null;
         for(index = 0; index < customModeBreedSpells.length; index++)
         {
            currentCustomModeBreedSpell = customModeBreedSpells[index];
            if(currentCustomModeBreedSpell.breedId === breedId)
            {
               toReturn.push(currentCustomModeBreedSpell.id);
            }
         }
         return toReturn;
      }
      
      public static function getCustomModeBreedSpellList(breedId:int) : Array
      {
         var index:uint = 0;
         var toReturn:Array = [];
         var customModeBreedSpells:Array = getCustomModeBreedSpells();
         var currentCustomModeBreedSpell:CustomModeBreedSpell = null;
         for(index = 0; index < customModeBreedSpells.length; index++)
         {
            currentCustomModeBreedSpell = customModeBreedSpells[index];
            if(currentCustomModeBreedSpell.breedId === breedId)
            {
               toReturn.push(currentCustomModeBreedSpell);
            }
         }
         return toReturn;
      }
   }
}
