package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.AbstractItemFilterManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractItemFilterApi implements IApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractItemFilterApi));
       
      
      protected var _currentUi:UiRootContainer;
      
      protected var _currentItemFilter:AbstractItemFilterManager;
      
      public function AbstractItemFilterApi()
      {
         super();
      }
      
      [ApiData(name="currentUi")]
      public function set currentUi(value:UiRootContainer) : void
      {
         if(!this._currentUi)
         {
            this._currentUi = value;
         }
      }
      
      public function destroy() : void
      {
         this._currentUi = null;
      }
      
      public function setOpenedCategories(value:Array) : void
      {
         this._currentItemFilter.openedCategories = value;
      }
      
      public function getOpenedCategories() : Array
      {
         return this._currentItemFilter.openedCategories;
      }
      
      public function setCharacterInfos(characterInfos:*) : void
      {
         this._currentItemFilter.characterInfos = characterInfos;
      }
      
      public function getCharacterInfos() : *
      {
         return this._currentItemFilter.characterInfos;
      }
      
      public function setMinLevelInputValue(value:uint) : void
      {
         this._currentItemFilter.minLevelInputValue = value;
      }
      
      public function getMinLevelInputValue() : uint
      {
         return this._currentItemFilter.minLevelInputValue;
      }
      
      public function setMaxLevelInputValue(value:uint) : void
      {
         this._currentItemFilter.maxLevelInputValue = value;
      }
      
      public function getMaxLevelInputValue() : uint
      {
         return this._currentItemFilter.maxLevelInputValue;
      }
      
      public function getMinLevel() : uint
      {
         return this._currentItemFilter.minLevel;
      }
      
      public function getMaxLevel() : uint
      {
         return this._currentItemFilter.maxLevel;
      }
      
      public function setMaxLevel(value:uint) : void
      {
         this._currentItemFilter.maxLevel = value;
      }
      
      public function getCurrentTypeInfos() : Dictionary
      {
         return this._currentItemFilter.currentTypeInfos;
      }
      
      public function dataMatrix() : Array
      {
         return this._currentItemFilter.dataMatrix;
      }
      
      public function currentFilteredIds() : Array
      {
         return this._currentItemFilter.currentFilteredIds;
      }
      
      public function currentSubIds() : Array
      {
         return this._currentItemFilter.currentSubIds;
      }
      
      public function subFilteredTypes() : Array
      {
         return this._currentItemFilter.subFilteredTypes;
      }
      
      public function currentCharacIds() : Array
      {
         return this._currentItemFilter.currentCharacIds;
      }
      
      public function currentSkinTargetIds() : Array
      {
         return this._currentItemFilter.currentSkinTargetIds;
      }
      
      public function currentWeaponEffectIds() : Array
      {
         return this._currentItemFilter.currentWeaponEffectIds;
      }
      
      public function currentConsumableEffectIds() : Array
      {
         return this._currentItemFilter.currentConsumableEffectIds;
      }
      
      public function obtainingMethod() : Array
      {
         return this._currentItemFilter.obtainingMethod;
      }
      
      public function currentBreedingItemEffectIds() : Array
      {
         return this._currentItemFilter.currentBreedingItemEffectIds;
      }
      
      public function initFilters(defaultTab:uint, characterInfos:*, currentTypeInfos:Dictionary, openedCategories:Array, filterList:Grid, itemList:Grid, specificType:Vector.<uint> = null, specificParams:Object = null) : void
      {
         this._currentItemFilter.currentUi = this._currentUi;
         this._currentItemFilter.gdFilterList = filterList;
         this._currentItemFilter.gdItemList = itemList;
         this._currentItemFilter.characterInfos = characterInfos;
         this._currentItemFilter.openedCategories = openedCategories;
         if(!this._currentItemFilter.openedCategories)
         {
            this._currentItemFilter.openedCategories = new Array();
         }
         this._currentItemFilter.specificTypes = null;
         if(specificType)
         {
            this._currentItemFilter.specificTypes = specificType;
         }
         this._currentItemFilter.setCurrentTypeInfos(defaultTab,currentTypeInfos);
         this._currentItemFilter.resetAllIds();
         if(specificParams != null && specificParams.hasOwnProperty("specificSearchData") && specificParams.specificSearchData)
         {
            this.resetFilters(specificParams.specificSearchData.levelRange.x,specificParams.specificSearchData.levelRange.y);
            this._currentItemFilter.specificMonsterId = specificParams.specificSearchData.monsterId;
            this.addObtainingMethod(4);
         }
      }
      
      public function setCurrentTypeInfos(tabIndex:uint, currentTypeInfos:Dictionary) : void
      {
         this._currentItemFilter.setCurrentTypeInfos(tabIndex,currentTypeInfos);
      }
      
      public function getCurrentTypeInfosKeyByValue(value:uint) : uint
      {
         return this._currentItemFilter.getCurrentTypeInfosKeyByValue(value);
      }
      
      public function dataInit() : void
      {
         this._currentItemFilter.dataInit();
      }
      
      public function updateInputLevel(input:Input) : void
      {
         this._currentItemFilter.updateInputLevel(input);
      }
      
      public function addTypeFilterId(typeId:int = -1) : void
      {
         var index:int = this._currentItemFilter.currentFilteredIds.indexOf(typeId);
         if(typeId > 0)
         {
            if(index == -1)
            {
               this._currentItemFilter.currentFilteredIds.push(typeId);
            }
            else
            {
               this._currentItemFilter.currentFilteredIds.splice(index,1);
            }
         }
         this._currentItemFilter.dataInit();
         this._currentItemFilter.displayCategories();
         if(this._currentUi.uiClass.hasOwnProperty("filterItems"))
         {
            this._currentUi.uiClass.filterItems();
         }
      }
      
      public function displayCategories(selectedCategory:Object = null) : Array
      {
         return this._currentItemFilter.displayCategories(selectedCategory);
      }
      
      public function addCharacFilterId(characId:uint) : void
      {
         var index:int = this._currentItemFilter.currentCharacIds.indexOf(characId);
         if(index == -1)
         {
            this._currentItemFilter.currentCharacIds.push(characId);
         }
         else
         {
            this._currentItemFilter.currentCharacIds.splice(index,1);
         }
      }
      
      public function addSkinTargetFilterId(targetId:uint) : void
      {
         var index:int = this._currentItemFilter.currentSkinTargetIds.indexOf(targetId);
         if(index == -1)
         {
            this._currentItemFilter.currentSkinTargetIds.push(targetId);
         }
         else
         {
            this._currentItemFilter.currentSkinTargetIds.splice(index,1);
         }
      }
      
      public function addWeaponEffect(id:uint) : void
      {
         var index:int = this._currentItemFilter.currentWeaponEffectIds.indexOf(id);
         if(index == -1)
         {
            this._currentItemFilter.currentWeaponEffectIds.push(id);
         }
         else
         {
            this._currentItemFilter.currentWeaponEffectIds.splice(index,1);
         }
      }
      
      public function addObtainingMethod(id:uint) : void
      {
         var index:int = this._currentItemFilter.obtainingMethod.indexOf(id);
         if(index == -1)
         {
            this._currentItemFilter.obtainingMethod.push(id);
         }
         else
         {
            this._currentItemFilter.obtainingMethod.splice(index,1);
         }
      }
      
      public function addBreedingItemEffect(id:uint) : void
      {
         var index:int = this._currentItemFilter.currentBreedingItemEffectIds.indexOf(id);
         if(index == -1)
         {
            this._currentItemFilter.currentBreedingItemEffectIds.push(id);
         }
         else
         {
            this._currentItemFilter.currentBreedingItemEffectIds.splice(index,1);
         }
      }
      
      public function addConsumableEffect(id:uint) : void
      {
         var index:int = this._currentItemFilter.currentConsumableEffectIds.indexOf(id);
         if(index == -1)
         {
            this._currentItemFilter.currentConsumableEffectIds.push(id);
         }
         else
         {
            this._currentItemFilter.currentConsumableEffectIds.splice(index,1);
         }
      }
      
      public function filterItems(searchCriteria:String) : Array
      {
         return this._currentItemFilter.filterItems(searchCriteria);
      }
      
      public function filterIsSelected(data:Object) : Boolean
      {
         if(this._currentItemFilter.currentWeaponEffectIds.indexOf(data.cId) != -1 && data.id == "weaponEffect")
         {
            return true;
         }
         if(this._currentItemFilter.currentConsumableEffectIds.indexOf(data.cId) != -1 && data.id == "consumableEffect")
         {
            return true;
         }
         if(this._currentItemFilter.currentSubIds.indexOf(data.cId) != -1 && data.id == "subCategory")
         {
            return true;
         }
         if(this._currentItemFilter.obtainingMethod.indexOf(data.cId) != -1 && data.id == "obtaining")
         {
            return true;
         }
         if(this._currentItemFilter.currentBreedingItemEffectIds.indexOf(data.cId) != -1 && data.id == "breedingItem")
         {
            return true;
         }
         if(this._currentItemFilter.currentSkinTargetIds.indexOf(data.cId) != -1 && (data.id == "targetWeapon" || data.id == "targetEquipment"))
         {
            return true;
         }
         if(this._currentItemFilter.currentCharacIds.indexOf(data.cId) != -1 && data.id != "subCategory" && data.id != "weaponEffect" && data.id != "consumableEffect" && data.id != "obtaining" && data.id != "targetWeapon" && data.id != "targetEquipment" && data.id != "breedingItem")
         {
            return true;
         }
         return false;
      }
      
      public function filterRunesFromItemEffects(effectsIdList:Vector.<uint> = null) : Vector.<uint>
      {
         return this._currentItemFilter.filterRunesFromItemEffects(effectsIdList);
      }
      
      public function checkSubFilters(superTypeId:uint) : Boolean
      {
         return this._currentItemFilter.checkSubFilters(superTypeId);
      }
      
      public function checkAllSubFilters(superTypeId:uint) : Boolean
      {
         return this._currentItemFilter.checkAllSubFilters(superTypeId);
      }
      
      public function resetFilters(levelMin:int = -1, levelMax:int = -1) : void
      {
         this._currentItemFilter.specificMonsterId = 0;
         this._currentItemFilter.resetFilters(levelMin,levelMax);
      }
   }
}
