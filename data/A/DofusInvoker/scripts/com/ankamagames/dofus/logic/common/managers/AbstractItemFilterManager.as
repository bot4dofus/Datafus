package com.ankamagames.dofus.logic.common.managers
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.SeasonCriterion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterDrop;
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class AbstractItemFilterManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractItemFilterManager));
       
      
      protected const EQUIPMENT_CATEGORY:String = "equipment";
      
      protected const CONSUMABLE_CATEGORY:String = "consumable";
      
      protected const RESOURCE_CATEGORY:String = "resource";
      
      protected const SKIN_CATEGORY:String = "skin";
      
      protected const RUNE_CATEGORY:String = "rune";
      
      protected const SOUL_CATEGORY:String = "soul";
      
      protected const CREATURE_CATEGORY:String = "creature";
      
      protected const COSMETIC_CATEGORY:String = "cosmetic";
      
      protected const SEARCHBAR_CAT_ID:uint = 0;
      
      protected const ITEMTYPE_CAT_ID:uint = 1;
      
      protected const LEVELFILTER_CAT_ID:uint = 2;
      
      protected const FIRST_SUBFILTER_CAT_ID:uint = 3;
      
      protected const SECOND_SUBFILTER_CAT_ID:uint = 4;
      
      protected const THIRD_SUBFILTER_CAT_ID:uint = 5;
      
      protected const ITEM_COMPONENT_CAT_ID:uint = 0;
      
      protected const ITEM_CRAFTABLE_CAT_ID:uint = 1;
      
      protected const ITEM_DROPABLE_CAT_ID:uint = 2;
      
      protected const ITEM_HARVESTABLE_CAT_ID:uint = 3;
      
      protected const ITEM_TEMPORIS_CAT_ID:uint = 4;
      
      private const CHARACID_BOOST_DEALT_DAMAGE_DISTANCE:uint = 120;
      
      private const CHARACID_DEBOOST_DEALT_DAMAGE_DISTANCE:uint = 121;
      
      private const CHARACID_BOOST_DEALT_DAMAGE_WEAPON:uint = 122;
      
      private const CHARACID_BOOST_DEALT_DAMAGE_SPELLS:uint = 123;
      
      private const CHARACID_BOOST_DEALT_DAMAGE_MELEE:uint = 124;
      
      private const CHARACID_DEBOOST_DEALT_DAMAGE_MELEE:uint = 125;
      
      private const FORGETTABLE_SCROLL_SPELL_TYPE_ID:uint = 223;
      
      private const ENCYCLOPEDIA_LIST_UI_NAME:String = "encyclopediaList";
      
      private const AUCTION_HOUSE_BUY_UI_NAME:String = "auctionHouseBuy";
      
      protected var _currentUi:UiRootContainer;
      
      protected var _lastUi:UiRootContainer;
      
      protected var _dataApi:DataApi;
      
      protected var _uiApi:UiApi;
      
      protected var _sysApi:SystemApi;
      
      protected var _openedCategories:Array;
      
      protected var _characterInfos;
      
      protected var _minLevelInputValue:uint = 0;
      
      protected var _maxLevelInputValue:uint = 0;
      
      protected var _minLevel:uint = 1;
      
      protected var _maxLevel:uint = 200;
      
      protected var _lastMinLevelValue:uint = 0;
      
      protected var _lastMaxLevelValue:uint = 201;
      
      protected var _currentTypeInfos:Dictionary;
      
      protected var _typeIcons:Dictionary = null;
      
      protected var _currentItemIds:Array;
      
      protected var _allItemsWithCurrentTypeIds:Object;
      
      protected var _searchCriteria:String = null;
      
      protected var _currentItemWithSearchCriteria:Object;
      
      protected var _currentCategory:String = "equipment";
      
      protected var _dataMatrix:Array;
      
      protected var _catNumber:uint = 0;
      
      protected var _arrayOfSubFilters:Array;
      
      protected var _currentFilteredIds:Array;
      
      protected var _specificTypes:Vector.<uint> = null;
      
      protected var _specificMonsterId:uint;
      
      protected var _subFilteredTypes:Array;
      
      protected var _currentSubIds:Array;
      
      protected var _currentCharacIds:Array;
      
      protected var _currentWeaponEffectIds:Array;
      
      protected var _currentConsumableEffectIds:Array;
      
      protected var _currentSkinTargetIds:Array;
      
      protected var _currentBreedingItemEffectIds:Array;
      
      protected var _weaponEffects:Array;
      
      protected var _targetEquipment:Array;
      
      protected var _targetWeapon:Array;
      
      protected var _consumableEffects:Array;
      
      protected var _obtainingMethod:Array;
      
      protected var _itemsHarvestable:Array;
      
      protected var _breedingItemType:Array;
      
      protected var _gd_filterList:Grid;
      
      protected var _gd_itemList:Grid;
      
      public function AbstractItemFilterManager()
      {
         this._currentItemWithSearchCriteria = new Object();
         this._arrayOfSubFilters = [];
         this._currentFilteredIds = [];
         this._subFilteredTypes = [];
         this._currentSubIds = [];
         this._currentCharacIds = [];
         this._currentWeaponEffectIds = [];
         this._currentConsumableEffectIds = [];
         this._currentSkinTargetIds = [];
         this._currentBreedingItemEffectIds = [];
         this._weaponEffects = [];
         this._targetEquipment = [];
         this._targetWeapon = [];
         this._consumableEffects = [];
         this._obtainingMethod = [];
         this._itemsHarvestable = [];
         this._breedingItemType = [];
         super();
      }
      
      public function set currentUi(value:UiRootContainer) : void
      {
         this._lastUi = this._currentUi;
         this._currentUi = value;
         if(!this._lastUi || this._lastUi.uiData.name != this._currentUi.uiData.name)
         {
            this._arrayOfSubFilters = [];
         }
         this._dataApi = this._currentUi.uiClass.dataApi;
         this._uiApi = this._currentUi.uiClass.uiApi;
         this._sysApi = this._currentUi.uiClass.sysApi;
      }
      
      public function get typeIcons() : Dictionary
      {
         return this._typeIcons;
      }
      
      public function set openedCategories(value:Array) : void
      {
         this._openedCategories = value;
      }
      
      public function get openedCategories() : Array
      {
         return this._openedCategories;
      }
      
      public function get characterInfos() : *
      {
         return this._characterInfos;
      }
      
      public function set characterInfos(value:*) : void
      {
         this._characterInfos = value;
      }
      
      public function get minLevelInputValue() : uint
      {
         return this._minLevelInputValue;
      }
      
      public function set minLevelInputValue(value:uint) : void
      {
         this._minLevelInputValue = value;
      }
      
      public function get maxLevelInputValue() : uint
      {
         return this._maxLevelInputValue;
      }
      
      public function set maxLevelInputValue(value:uint) : void
      {
         this._maxLevelInputValue = value;
      }
      
      public function get minLevel() : uint
      {
         return this._minLevel;
      }
      
      public function get maxLevel() : uint
      {
         return this._maxLevel;
      }
      
      public function set maxLevel(value:uint) : void
      {
         this._maxLevel = value;
      }
      
      public function get currentTypeInfos() : Dictionary
      {
         return this._currentTypeInfos;
      }
      
      public function get dataMatrix() : Array
      {
         return this._dataMatrix;
      }
      
      public function get currentFilteredIds() : Array
      {
         return this._currentFilteredIds;
      }
      
      public function set specificTypes(value:Vector.<uint>) : void
      {
         this._specificTypes = value;
      }
      
      public function set specificMonsterId(value:uint) : void
      {
         this._specificMonsterId = value;
      }
      
      public function get currentSubIds() : Array
      {
         return this._currentSubIds;
      }
      
      public function get subFilteredTypes() : Array
      {
         return this._subFilteredTypes;
      }
      
      public function get currentCharacIds() : Array
      {
         return this._currentCharacIds;
      }
      
      public function get currentSkinTargetIds() : Array
      {
         return this._currentSkinTargetIds;
      }
      
      public function get currentWeaponEffectIds() : Array
      {
         return this._currentWeaponEffectIds;
      }
      
      public function get currentConsumableEffectIds() : Array
      {
         return this._currentConsumableEffectIds;
      }
      
      public function get currentBreedingItemEffectIds() : Array
      {
         return this._currentBreedingItemEffectIds;
      }
      
      public function get obtainingMethod() : Array
      {
         return this._obtainingMethod;
      }
      
      public function set gdFilterList(value:Grid) : void
      {
         this._gd_filterList = value;
      }
      
      public function set gdItemList(value:Grid) : void
      {
         this._gd_itemList = value;
      }
      
      public function initTypeIcons() : void
      {
         if(this._typeIcons == null)
         {
            this._typeIcons = new Dictionary();
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_COLLAR] = "collar";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_WEAPON] = "weapon";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_RING] = "ring";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_BELT] = "belt";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_SHOES] = "shoe";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_CONSUMABLE] = "consumable";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_SHIELD] = "shield";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_RESOURCES] = "resource";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_HELMET] = "helmet";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_CAPE] = "cape";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_PET] = "pet";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY] = "dofus";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_MOUNTS] = "pet";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS] = "costume";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_COMPANION] = "companon";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT] = "pet";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_COSTUME] = "costume";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_CERTIFICATE] = "pet";
            this._typeIcons[DataEnum.ITEM_SUPERTYPE_TAX_COLLECTOR_EQUIPMENT] = "horseshoe";
         }
      }
      
      public function setCurrentTypeInfos(tabIndex:uint, currentTypeInfos:Dictionary) : void
      {
      }
      
      public function getCurrentTypeInfosKeyByValue(value:uint) : int
      {
         var key:* = undefined;
         for(key in this._currentTypeInfos)
         {
            if(this._currentTypeInfos[key] && this._currentTypeInfos[key].indexOf(value) != -1)
            {
               return key;
            }
         }
         return -1;
      }
      
      protected function setItemsWithCurrentTypes() : void
      {
         var key:* = undefined;
         var tmpSpecificIds:Object = null;
         var superTypeId:* = undefined;
         this._currentItemIds = [];
         this._allItemsWithCurrentTypeIds = new Object();
         var tmpCurrentTypeInfos:Array = [];
         for(key in this._currentTypeInfos)
         {
            tmpCurrentTypeInfos = tmpCurrentTypeInfos.concat(this._currentTypeInfos[key]);
         }
         tmpSpecificIds = null;
         for each(superTypeId in tmpCurrentTypeInfos)
         {
            this._currentItemIds.push(superTypeId);
            if(superTypeId != DataEnum.ITEM_SUPERTYPE_CERTIFICATE)
            {
               this._allItemsWithCurrentTypeIds = this._dataApi.queryUnion(this._allItemsWithCurrentTypeIds,this._dataApi.queryEquals(Item,"typeId",this._dataApi.queryEquals(ItemType,"superTypeId",superTypeId)));
               this._allItemsWithCurrentTypeIds = this._dataApi.queryIntersection(this._allItemsWithCurrentTypeIds,this._dataApi.queryEquals(Item,"etheral",false));
            }
            else
            {
               tmpSpecificIds = this._dataApi.queryEquals(Item,"typeId",this._dataApi.queryEquals(ItemType,"superTypeId",superTypeId));
            }
         }
         if(tmpSpecificIds)
         {
            this._allItemsWithCurrentTypeIds = this._dataApi.queryUnion(this._allItemsWithCurrentTypeIds,tmpSpecificIds);
         }
         this._allItemsWithCurrentTypeIds = this._dataApi.queryIntersection(this._allItemsWithCurrentTypeIds,this._dataApi.queryEquals(Item,"isSaleable",true));
      }
      
      protected function setLevelRange(minValue:uint, maxValue:uint) : void
      {
         this._minLevelInputValue = minValue;
         this._maxLevelInputValue = maxValue;
      }
      
      public function updateInputLevel(input:Input) : void
      {
         if(input.text == null || input.text == "" || input.text == "0")
         {
            input.text = "1";
         }
         var levelValue:int = int(input.text);
         if(levelValue > this._maxLevel)
         {
            levelValue = this._maxLevel;
         }
         else if(levelValue < this._minLevel)
         {
            levelValue = this._minLevel;
         }
         if(input.name.indexOf("inp_minLevel") != -1 && this._minLevelInputValue != levelValue)
         {
            this._minLevelInputValue = Math.min(levelValue,this._maxLevelInputValue);
            this._lastMinLevelValue = this._minLevelInputValue;
            input.text = this._minLevelInputValue.toString();
         }
         else if(input.name.indexOf("inp_maxLevel") != -1 && this._maxLevelInputValue != levelValue)
         {
            this._maxLevelInputValue = Math.max(levelValue,this._minLevelInputValue);
            this._lastMaxLevelValue = this._maxLevelInputValue;
            input.text = this._maxLevelInputValue.toString();
         }
         if((levelValue != this._lastMinLevelValue || levelValue != this._lastMaxLevelValue) && this._currentItemIds)
         {
            this._currentUi.uiClass.filterItems();
         }
      }
      
      protected function getWeaponEffects() : void
      {
         var id:uint = 0;
         var effectsId:Array = [ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL,ActionIds.ACTION_CHARACTER_ACTION_POINTS_LOST,ActionIds.ACTION_CHARACTER_MOVEMENT_POINTS_LOST,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_NEUTRAL,ActionIds.ACTION_CHARACTER_LIFE_POINTS_WIN_FROM_BEST_ELEMENT,ActionIds.ACTION_HUNT_TOOL];
         this._weaponEffects = [];
         for each(id in effectsId)
         {
            this._weaponEffects.push(this._dataApi.getEffect(id));
         }
      }
      
      protected function getTargetEquipment() : void
      {
         var id:uint = 0;
         var itemType:ItemType = null;
         var effectsId:Array = [DataEnum.ITEM_TYPE_COLLAR,DataEnum.ITEM_TYPE_RING,DataEnum.ITEM_TYPE_BELT,DataEnum.ITEM_TYPE_SHOES,DataEnum.ITEM_TYPE_SHIELD,DataEnum.ITEM_TYPE_HAT,DataEnum.ITEM_TYPE_CLOAK,DataEnum.ITEM_TYPE_PET,DataEnum.ITEM_TYPE_PETSMOUNT];
         this._targetEquipment = [];
         for each(id in effectsId)
         {
            itemType = this._dataApi.getItemType(id);
            if(itemType === null)
            {
               _log.error("Unknown item type requested. ID is " + id + ".");
            }
            else
            {
               this._targetEquipment.push(this._dataApi.getItemType(id));
            }
         }
      }
      
      protected function getTargetWeapon() : void
      {
         var id:uint = 0;
         var itemType:ItemType = null;
         var effectsId:Array = [DataEnum.ITEM_TYPE_BOW,DataEnum.ITEM_TYPE_HAMMER,DataEnum.ITEM_TYPE_MAGIC_WEAPON,DataEnum.ITEM_TYPE_ROD,DataEnum.ITEM_TYPE_STAFF,DataEnum.ITEM_TYPE_DAGGER,DataEnum.ITEM_TYPE_SCYTHE,DataEnum.ITEM_TYPE_AXE,DataEnum.ITEM_TYPE_SHOVEL,DataEnum.ITEM_TYPE_PICKAXE,DataEnum.ITEM_TYPE_SWORD];
         this._targetWeapon = [];
         for each(id in effectsId)
         {
            itemType = this._dataApi.getItemType(id);
            if(itemType === null)
            {
               _log.error("Unknown item type requested. ID is " + id + ".");
            }
            else
            {
               this._targetWeapon.push(itemType);
            }
         }
      }
      
      protected function getConsumableEffects() : void
      {
         var id:uint = 0;
         var effectsId:Array = [ActionIds.ACTION_CHARACTER_GAIN_WISDOM,ActionIds.ACTION_CHARACTER_GAIN_STRENGTH,ActionIds.ACTION_CHARACTER_GAIN_CHANCE,ActionIds.ACTION_CHARACTER_GAIN_AGILITY,ActionIds.ACTION_CHARACTER_GAIN_INTELLIGENCE,ActionIds.ACTION_CHARACTER_GAIN_VITALITY,ActionIds.ACTION_CHARACTER_BOOST_LIFE_POINTS,ActionIds.ACTION_CHARACTER_ENERGY_POINTS_WIN];
         this._consumableEffects = [];
         for each(id in effectsId)
         {
            this._consumableEffects.push(this._dataApi.getEffect(id));
         }
      }
      
      protected function getBreedingItemTypeEffects() : void
      {
         this._breedingItemType = [{
            "name":this._uiApi.getText("ui.bidhouse.drinkingTrough"),
            "effectId":DataEnum.BREEDING_ITEM_MATURY_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.slapper"),
            "effectId":DataEnum.BREEDING_ITEM_AGGRO_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.patter"),
            "effectId":DataEnum.BREEDING_ITEM_SERENITY_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.dragobutt"),
            "effectId":DataEnum.BREEDING_ITEM_LOVE_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.lightningThrower"),
            "effectId":DataEnum.BREEDING_ITEM_STAMINA_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.manger"),
            "effectId":DataEnum.BREEDING_ITEM_ENERGY_BASE_SPELL_ID
         },{
            "name":this._uiApi.getText("ui.bidhouse.miscellaneousObject"),
            "effectId":DataEnum.BREEDING_ITEM_REMOVE_OBJECT_BASE_SPELL_ID
         }];
         this._breedingItemType.sortOn("name");
      }
      
      public function dataInit(specificFilters:Array = null) : void
      {
         if(!this._currentTypeInfos)
         {
            return;
         }
         this._catNumber = 0;
         this._dataMatrix = new Array();
         this._dataMatrix.push({
            "isCat":false,
            "cat":this._catNumber,
            "id":"search"
         });
         ++this._catNumber;
         if(this._currentCategory == this.EQUIPMENT_CATEGORY)
         {
            this._dataMatrix.push({
               "name":this._uiApi.getText("ui.common.categories"),
               "id":this._catNumber,
               "isCat":true
            });
            this._dataMatrix.push({
               "isCat":false,
               "cat":this._catNumber,
               "itemType":this.currentTypeInfos
            });
         }
         ++this._catNumber;
         this._dataMatrix.push({
            "name":this._uiApi.getText("ui.common.levels"),
            "id":this._catNumber,
            "isCat":true
         });
         this._dataMatrix.push({
            "isCat":false,
            "cat":this._catNumber,
            "id":"level"
         });
         ++this._catNumber;
      }
      
      protected function filterGridItem(gCid:int, gId:String, gText:String, gGfxId:String, gSelected:Boolean, gCat:int, typeId:int = -1) : FilterGridItem
      {
         return new FilterGridItem(gCid,gId,gText,gGfxId,gSelected,gCat,typeId);
      }
      
      protected function setSubFilters(typeId:uint, currentTypeInfoId:uint, catText:String) : void
      {
         if(this._arrayOfSubFilters[typeId + "_" + this._currentCategory] == null)
         {
            this._arrayOfSubFilters[typeId + "_" + this._currentCategory] = this.addSubCategory(this.currentTypeInfos[currentTypeInfoId],catText,this._specificTypes);
         }
         else
         {
            ++this._catNumber;
         }
         this._dataMatrix = this._dataMatrix.concat(this._arrayOfSubFilters[typeId + "_" + this._currentCategory]);
      }
      
      protected function canDisplayCharacFilters(element:*, index:int, arr:Array) : Boolean
      {
         return element != DataEnum.ITEM_SUPERTYPE_COMPANION && element != DataEnum.ITEM_SUPERTYPE_COSTUME && element != DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS;
      }
      
      public function addSubCategory(superTypeId:Array, filterCatText:String = "", specificTypes:Vector.<uint> = null) : Array
      {
         var typeId:uint = 0;
         var tmpDataMatrix:Array = null;
         var subTypeId:uint = 0;
         var itemType:ItemType = null;
         var tmp:Object = null;
         var isSelected:Boolean = false;
         var timer2:uint = getTimer();
         var subTypeIds:Object = new Object();
         for each(typeId in superTypeId)
         {
            subTypeIds = this._dataApi.queryUnion(subTypeIds,this._dataApi.queryEquals(ItemType,"superTypeId",typeId));
         }
         if(specificTypes)
         {
            subTypeIds = this._dataApi.queryIntersection(subTypeIds,specificTypes);
         }
         this._sysApi.log(1,"add sub filters " + filterCatText + " before all Ids : " + (getTimer() - timer2));
         if(Vector.<uint>(subTypeIds).length > 0)
         {
            tmpDataMatrix = [];
            for each(subTypeId in subTypeIds)
            {
               if(!(!FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.FORGETTABLE_SPELLS) && subTypeId == this.FORGETTABLE_SCROLL_SPELL_TYPE_ID || !FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.MODSTERS) && subTypeId == DataEnum.ITEM_TYPE_MODSTER || FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.MODSTERS) && this._currentUi.uiData.name == this.ENCYCLOPEDIA_LIST_UI_NAME && subTypeId == DataEnum.ITEM_TYPE_MODSTER))
               {
                  itemType = this._dataApi.getItemType(subTypeId);
                  if(itemType != null)
                  {
                     tmp = this._dataApi.queryIntersection(this._allItemsWithCurrentTypeIds,this._dataApi.queryEquals(Item,"typeId",subTypeId));
                     if(tmp.length > 0)
                     {
                        isSelected = this._subFilteredTypes.indexOf(itemType.superTypeId) != -1 && this._currentSubIds.indexOf(subTypeId) != -1;
                        tmpDataMatrix.push(new FilterGridItem(subTypeId,"subCategory",itemType.name,null,isSelected,this._catNumber,subTypeId));
                     }
                  }
               }
            }
            this._currentUi.uiClass.utilApi.sortOnString(tmpDataMatrix,"text");
            tmpDataMatrix.unshift({
               "name":filterCatText,
               "id":this._catNumber,
               "isCat":true
            });
            ++this._catNumber;
            this._sysApi.log(1,"add sub filters " + filterCatText + " : " + (getTimer() - timer2));
            return tmpDataMatrix;
         }
         this._sysApi.log(1,"add sub filters " + filterCatText + " : " + (getTimer() - timer2));
         return [];
      }
      
      protected function addCustomSubEffectCategory(effects:Array, subCatName:String, id:String) : void
      {
         var startIndex:int = 0;
         var endIndex:int = 0;
         var effect:Effect = null;
         var effectName:String = null;
         this._dataMatrix.push({
            "name":subCatName,
            "id":this._catNumber,
            "isCat":true
         });
         for each(effect in effects)
         {
            effectName = effect.description;
            startIndex = effectName.indexOf("#1");
            endIndex = effectName.indexOf("#2");
            if(startIndex != -1 && endIndex != -1)
            {
               effectName = effectName.replace(effectName.substring(startIndex,endIndex + 2),"");
            }
            else if(startIndex != -1)
            {
               effectName = effectName.replace("#1","");
            }
            else if(endIndex != -1)
            {
               effectName = effectName.replace("#2","");
            }
            effectName = effectName.replace("(","");
            effectName = effectName.replace(")","");
            effectName = effectName.replace("#5","");
            this._dataMatrix.push(new FilterGridItem(effect.id,id,effectName,null,false,this._catNumber));
         }
         ++this._catNumber;
      }
      
      public function checkSubFilters(superTypeId:uint) : Boolean
      {
         var subId:uint = 0;
         var tmpSuperTypeId:uint = 0;
         for each(subId in this._currentSubIds)
         {
            tmpSuperTypeId = this._dataApi.getItemType(subId).superTypeId;
            if(superTypeId == tmpSuperTypeId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkAllSubFilters(superTypeId:uint) : Boolean
      {
         var subId:uint = 0;
         for each(subId in this._currentSubIds)
         {
            if(this.getCurrentTypeInfosKeyByValue(superTypeId) > 1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function displayCategories(selectedCategory:Object = null) : Array
      {
         var myIndex:int = 0;
         var entry:Object = null;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedCategories.indexOf(selecCatId) != -1)
            {
               this._openedCategories.splice(this._openedCategories.indexOf(selecCatId),1);
            }
            else
            {
               this._openedCategories.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = new Array();
         for each(entry in this._dataMatrix)
         {
            if(entry.isCat)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            else if(this._openedCategories.indexOf(entry.cat) != -1)
            {
               if(entry.cat == this.SEARCHBAR_CAT_ID)
               {
                  tempCats = tempCats.concat(this.addSearchFilter());
               }
               else if(entry.cat == this.ITEMTYPE_CAT_ID)
               {
                  tempCats = tempCats.concat(this.addItemTypeList(entry.itemType));
               }
               else if(entry.cat == this.LEVELFILTER_CAT_ID && (entry.id && entry.id == "level"))
               {
                  tempCats = tempCats.concat(this.addLevelFilter());
               }
               else
               {
                  tempCats.push(entry);
               }
               index++;
            }
         }
         this._sysApi.setData("openedFilterCat",this._openedCategories);
         scrollValue = this._gd_filterList.verticalScrollValue;
         this._gd_filterList.dataProvider = tempCats;
         this._gd_filterList.verticalScrollValue = scrollValue;
         if(Object(this._currentUi.uiClass).hasOwnProperty("updateBgFilter"))
         {
            this._currentUi.uiClass.updateBgFilter();
         }
         return tempCats;
      }
      
      private function addItemTypeList(itemType:Dictionary) : Array
      {
         var key:* = undefined;
         var result:Array = [];
         var tmpItemType:Array = [];
         for(key in itemType)
         {
            tmpItemType.push(key);
         }
         tmpItemType.sort(Array.NUMERIC);
         result.push({"itemType":tmpItemType});
         if(this._currentUi.uiData.name == this.AUCTION_HOUSE_BUY_UI_NAME)
         {
            result = this.addEmptyLine(result,Math.ceil(tmpItemType.length / 4) + 2);
         }
         else
         {
            result = this.addEmptyLine(result,Math.ceil(tmpItemType.length / 5) + 2);
         }
         return result;
      }
      
      private function addLevelFilter() : Array
      {
         var result:Array = [];
         result.push({"currentLevel":this._characterInfos.level});
         return this.addEmptyLine(result,1);
      }
      
      private function addSearchFilter() : Array
      {
         var result:Array = [];
         result.push({"id":"search"});
         return this.addEmptyLine(result,1);
      }
      
      private function addEmptyLine(array:Array, nb:uint) : Array
      {
         for(var i:int = 0; i < nb; i++)
         {
            array.push(null);
         }
         return array;
      }
      
      public function filterItems(searchCriteria:String) : Array
      {
         var obtainingId:uint = 0;
         var id:* = undefined;
         var ids:Vector.<uint> = this.filterLevel();
         if(this._currentCategory == this.SKIN_CATEGORY)
         {
            ids = this.filterTargetEquipment(this.filterType(Vector.<uint>(ids)));
         }
         else
         {
            ids = this.filterCharac(this.filterType(Vector.<uint>(ids)));
         }
         if(this._currentCategory == this.EQUIPMENT_CATEGORY)
         {
            ids = this.filterTargetEquipment(Vector.<uint>(ids));
         }
         if(this._currentCategory == this.CREATURE_CATEGORY)
         {
            ids = this.filterBreedingItem(Vector.<uint>(ids));
         }
         for each(obtainingId in this._obtainingMethod)
         {
            if(obtainingId == this.ITEM_COMPONENT_CAT_ID)
            {
               ids = this._dataApi.queryIntersection(ids,this._dataApi.queryGreaterThan(Item,"recipeIds",0));
            }
            else if(obtainingId == this.ITEM_CRAFTABLE_CAT_ID)
            {
               ids = this._dataApi.queryIntersection(ids,this._dataApi.queryGreaterThan(Item,"recipeSlots",0));
            }
            else if(obtainingId == this.ITEM_DROPABLE_CAT_ID)
            {
               ids = this._dataApi.queryIntersection(ids,this._dataApi.queryGreaterThan(Item,"dropMonsterIds",0));
            }
            else if(obtainingId == this.ITEM_HARVESTABLE_CAT_ID)
            {
               ids = this._dataApi.queryIntersection(ids,Vector.<uint>(this._itemsHarvestable));
            }
            else if(obtainingId == this.ITEM_TEMPORIS_CAT_ID)
            {
               ids = this._dataApi.queryIntersection(ids,this.getAllTemporisItems(ids));
            }
         }
         if(searchCriteria && searchCriteria != this._searchCriteria)
         {
            this.filterName(StringUtils.noAccent(searchCriteria));
         }
         else if(!searchCriteria)
         {
            this._searchCriteria = searchCriteria;
            this._currentItemWithSearchCriteria = Vector.<uint>(this._allItemsWithCurrentTypeIds);
         }
         ids = this._dataApi.queryIntersection(ids,this._dataApi.queryIntersection(this._allItemsWithCurrentTypeIds,this._currentItemWithSearchCriteria));
         var tmpIds:Array = [];
         for each(id in ids)
         {
            tmpIds.push(id);
         }
         return tmpIds;
      }
      
      protected function getAllTemporisItems(ids:Object) : Vector.<uint>
      {
         var drop:MonsterDrop = null;
         var criteria:ItemCriterion = null;
         var temporisItemIds:Vector.<uint> = new Vector.<uint>();
         if(this._specificMonsterId == 0)
         {
            return Vector.<uint>(ids);
         }
         var monster:Monster = this._dataApi.getMonsterFromId(this._specificMonsterId);
         for each(drop in monster.temporisDrops)
         {
            if(drop.conditions)
            {
               for each(criteria in drop.conditions.inlineCriteria)
               {
                  if(criteria is SeasonCriterion)
                  {
                     if(criteria.isRespected)
                     {
                        temporisItemIds.push(drop.objectId);
                        break;
                     }
                  }
               }
            }
         }
         return temporisItemIds;
      }
      
      protected function getAllItemsHarvestable() : void
      {
         var subArea:* = undefined;
         var harvestableId:* = undefined;
         this._itemsHarvestable = [];
         for each(subArea in this._dataApi.getAllSubAreas())
         {
            for each(harvestableId in subArea.harvestables)
            {
               if(this._itemsHarvestable.indexOf(harvestableId) == -1)
               {
                  this._itemsHarvestable.push(harvestableId);
               }
            }
         }
      }
      
      private function filterName(searchCriteria:String) : void
      {
         this._searchCriteria = searchCriteria;
         if(searchCriteria && searchCriteria != "")
         {
            this._currentItemWithSearchCriteria = this._dataApi.queryString(Item,"name",searchCriteria);
         }
         else
         {
            this._currentItemWithSearchCriteria = Vector.<uint>(this._allItemsWithCurrentTypeIds);
         }
      }
      
      private function filterType(currentFilteredItemIds:Vector.<uint> = null) : Vector.<uint>
      {
         var subId:uint = 0;
         var id:uint = 0;
         if(this._currentFilteredIds.length <= 0)
         {
            if(!currentFilteredItemIds)
            {
               return Vector.<uint>(this._allItemsWithCurrentTypeIds);
            }
            return currentFilteredItemIds;
         }
         var typeResult:Object = new Object();
         var itemIdsToCheck:Vector.<uint> = !!currentFilteredItemIds ? currentFilteredItemIds : Vector.<uint>(this._allItemsWithCurrentTypeIds);
         var tmpSpecificIds:Object = new Object();
         for each(subId in this._currentSubIds)
         {
            if(this._dataApi.getItemType(subId).superTypeId == DataEnum.ITEM_SUPERTYPE_CERTIFICATE || subId == DataEnum.ITEM_TYPE_SOULSTONE)
            {
               tmpSpecificIds = this._dataApi.queryUnion(tmpSpecificIds,this._dataApi.queryEquals(Item,"typeId",subId));
            }
            else
            {
               typeResult = this._dataApi.queryIntersection(itemIdsToCheck,this._dataApi.queryUnion(typeResult,this._dataApi.queryEquals(Item,"typeId",subId)));
            }
         }
         for each(id in this._currentFilteredIds)
         {
            if(this._subFilteredTypes.indexOf(id) == -1)
            {
               if(id == DataEnum.ITEM_SUPERTYPE_CERTIFICATE || id == DataEnum.ITEM_TYPE_SOULSTONE)
               {
                  tmpSpecificIds = this._dataApi.queryUnion(tmpSpecificIds,this._dataApi.queryEquals(Item,"typeId",this._dataApi.queryEquals(ItemType,"superTypeId",id)));
               }
               else
               {
                  typeResult = this._dataApi.queryIntersection(itemIdsToCheck,this._dataApi.queryUnion(typeResult,this._dataApi.queryEquals(Item,"typeId",this._dataApi.queryEquals(ItemType,"superTypeId",id))));
               }
            }
         }
         if(tmpSpecificIds.length > 0)
         {
            typeResult = this._dataApi.queryUnion(tmpSpecificIds,typeResult);
         }
         return Vector.<uint>(typeResult);
      }
      
      public function filterCharac(currentFilteredItemIds:Vector.<uint>) : Vector.<uint>
      {
         var characId:uint = 0;
         var mountWithEffect:Vector.<uint> = null;
         var effectId:uint = 0;
         var weaponEffectId:uint = 0;
         var consumableEffect:uint = 0;
         var effectIds:Vector.<uint> = null;
         var mountWithCurrentEffect:Array = null;
         var id:uint = 0;
         var mount:Mount = null;
         if(!this._allItemsWithCurrentTypeIds)
         {
            return new Vector.<uint>();
         }
         var resultEffectId:Object = new Object();
         var resultItemWithEffect:Object = !!currentFilteredItemIds ? currentFilteredItemIds : this._allItemsWithCurrentTypeIds;
         if(this._currentCategory == this.EQUIPMENT_CATEGORY)
         {
            if(this._currentCharacIds.length <= 0 && this._currentWeaponEffectIds.length <= 0)
            {
               return Vector.<uint>(resultItemWithEffect);
            }
            for each(weaponEffectId in this._currentWeaponEffectIds)
            {
               resultEffectId = this._dataApi.queryUnion(resultEffectId,this._dataApi.queryEquals(Effect,"id",weaponEffectId));
            }
         }
         else if(this._currentCategory == this.CONSUMABLE_CATEGORY)
         {
            if(this._currentCharacIds.length <= 0 && this._currentConsumableEffectIds.length <= 0)
            {
               return Vector.<uint>(resultItemWithEffect);
            }
            for each(consumableEffect in this._currentConsumableEffectIds)
            {
               resultEffectId = this._dataApi.queryUnion(resultEffectId,this._dataApi.queryEquals(Effect,"id",consumableEffect));
            }
         }
         else if(this._currentCategory == this.RESOURCE_CATEGORY)
         {
            if(this._currentCharacIds.length <= 0)
            {
               return Vector.<uint>(resultItemWithEffect);
            }
         }
         for each(characId in this._currentCharacIds)
         {
            effectIds = new Vector.<uint>();
            switch(characId)
            {
               case this.CHARACID_BOOST_DEALT_DAMAGE_DISTANCE:
                  effectIds.push(ActionIds.ACTION_CHARACTER_BOOST_DEALT_DAMAGE_PERCENT_MULTIPLIER_DISTANCE);
                  break;
               case this.CHARACID_DEBOOST_DEALT_DAMAGE_DISTANCE:
                  effectIds.push(ActionIds.ACTION_CHARACTER_DEBOOST_RECEIVED_DAMAGE_PERCENT_MULTIPLIER_DISTANCE);
                  break;
               case this.CHARACID_BOOST_DEALT_DAMAGE_WEAPON:
                  effectIds.push(ActionIds.ACTION_CHARACTER_BOOST_DEALT_DAMAGE_PERCENT_MULTIPLIER_WEAPON);
                  break;
               case this.CHARACID_BOOST_DEALT_DAMAGE_SPELLS:
                  effectIds.push(ActionIds.ACTION_CHARACTER_BOOST_DEALT_DAMAGE_PERCENT_MULTIPLIER_SPELLS);
                  break;
               case this.CHARACID_BOOST_DEALT_DAMAGE_MELEE:
                  effectIds.push(ActionIds.ACTION_CHARACTER_DEBOOST_RECEIVED_DAMAGE_PERCENT_MULTIPLIER_MELEE);
                  break;
               case this.CHARACID_DEBOOST_DEALT_DAMAGE_MELEE:
                  effectIds.push(ActionIds.ACTION_CHARACTER_BOOST_DEALT_DAMAGE_PERCENT_MULTIPLIER_MELEE);
                  break;
               default:
                  effectIds = Vector.<uint>(this._dataApi.queryEquals(Effect,"characteristic",characId));
                  break;
            }
            resultEffectId = this._dataApi.queryUnion(resultEffectId,this._dataApi.queryIntersection(this._dataApi.queryEquals(Effect,"bonusType",1),effectIds));
         }
         mountWithEffect = new Vector.<uint>();
         if(this._currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CERTIFICATE) != -1)
         {
            if(this._currentSubIds.length <= 0)
            {
               mountWithEffect = this._dataApi.queryUnion(this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE),this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_MULDO_CERTIFICATE),this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_FLYHORN_CERTIFICATE));
            }
            else
            {
               if(this._currentSubIds.indexOf(DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE) != -1)
               {
                  mountWithEffect = this._dataApi.queryUnion(mountWithEffect,this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE));
               }
               if(this._currentSubIds.indexOf(DataEnum.ITEM_TYPE_MULDO_CERTIFICATE) != -1)
               {
                  mountWithEffect = this._dataApi.queryUnion(mountWithEffect,this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_MULDO_CERTIFICATE));
               }
               if(this._currentSubIds.indexOf(DataEnum.ITEM_TYPE_FLYHORN_CERTIFICATE) != -1)
               {
                  mountWithEffect = this._dataApi.queryUnion(mountWithEffect,this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_FLYHORN_CERTIFICATE));
               }
            }
         }
         for each(effectId in resultEffectId)
         {
            resultItemWithEffect = this._dataApi.queryIntersection(Vector.<uint>(resultItemWithEffect),this._dataApi.queryEquals(Item,"possibleEffects.effectId",effectId));
            mountWithCurrentEffect = [];
            for each(id in this._dataApi.queryEquals(Mount,"effects.effectId",effectId))
            {
               mount = this._dataApi.getMountById(id);
               mountWithCurrentEffect.push(mount.certificateId);
            }
            mountWithEffect = this._dataApi.queryIntersection(mountWithEffect,Vector.<uint>(mountWithCurrentEffect));
         }
         resultItemWithEffect = this._dataApi.queryUnion(resultItemWithEffect,mountWithEffect);
         return Vector.<uint>(resultItemWithEffect);
      }
      
      public function filterTargetEquipment(filteredItemIds:Vector.<uint> = null) : Vector.<uint>
      {
         var itemId:uint = 0;
         var item:Item = null;
         var targetEquipment:uint = 0;
         var effect:EffectInstance = null;
         if(!this._allItemsWithCurrentTypeIds)
         {
            return new Vector.<uint>();
         }
         if(this._currentSkinTargetIds.length <= 0)
         {
            if(!filteredItemIds)
            {
               return Vector.<uint>(this._allItemsWithCurrentTypeIds);
            }
            return filteredItemIds;
         }
         var resultItems:Vector.<uint> = new Vector.<uint>();
         var itemsIdsToCheck:Vector.<uint> = !!filteredItemIds ? filteredItemIds : Vector.<uint>(this._allItemsWithCurrentTypeIds);
         var effectIds:Array = [ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE,ActionIds.ACTION_ITEM_LIVING_CATEGORY];
         itemsIdsToCheck = this._dataApi.queryIntersection(Vector.<uint>(itemsIdsToCheck),this._dataApi.queryEquals(Item,"possibleEffects.effectId",ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE));
         itemsIdsToCheck = this._dataApi.queryUnion(itemsIdsToCheck,this._dataApi.queryEquals(Item,"possibleEffects.effectId",ActionIds.ACTION_ITEM_LIVING_CATEGORY));
         for each(targetEquipment in this._currentSkinTargetIds)
         {
            for each(itemId in itemsIdsToCheck)
            {
               item = this._dataApi.getItem(itemId);
               for each(effect in item.possibleEffects)
               {
                  if((effect.effectId == ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE || effect.effectId == ActionIds.ACTION_ITEM_LIVING_CATEGORY) && effect.parameter2 == targetEquipment)
                  {
                     resultItems.push(item.id);
                  }
               }
            }
         }
         return resultItems;
      }
      
      private function filterLevel() : Vector.<uint>
      {
         var levelResult:Object = this._dataApi.queryIntersection(this._dataApi.queryGreaterThan(Item,"level",this._minLevelInputValue - 1),this._dataApi.querySmallerThan(Item,"level",this._maxLevelInputValue + 1));
         return Vector.<uint>(levelResult);
      }
      
      private function filterBreedingItem(filteredItemIds:Vector.<uint>) : Vector.<uint>
      {
         var id:uint = 0;
         var breedingItemEffect:uint = 0;
         var tmp:Vector.<uint> = null;
         if(this._currentBreedingItemEffectIds.length <= 0)
         {
            return filteredItemIds;
         }
         var allBreedingItemIds:Vector.<uint> = this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_BREEDING_ITEM);
         var breedingItemId:Vector.<uint> = new Vector.<uint>();
         for each(breedingItemEffect in this._currentBreedingItemEffectIds)
         {
            if(breedingItemEffect == DataEnum.BREEDING_ITEM_REMOVE_OBJECT_BASE_SPELL_ID)
            {
               tmp = this._dataApi.queryGreaterThan(Item,"possibleEffects.baseEffectId",0);
               for each(id in allBreedingItemIds)
               {
                  if(tmp.indexOf(id) == -1)
                  {
                     breedingItemId.push(id);
                  }
               }
               breedingItemId = this._dataApi.queryUnion(breedingItemId,this._dataApi.queryEquals(Item,"possibleEffects.baseEffectId",breedingItemEffect));
            }
            else
            {
               breedingItemId = this._dataApi.queryUnion(breedingItemId,this._dataApi.queryEquals(Item,"possibleEffects.baseEffectId",breedingItemEffect));
            }
         }
         for each(id in breedingItemId)
         {
            if(allBreedingItemIds.indexOf(id) != -1)
            {
               allBreedingItemIds.splice(allBreedingItemIds.indexOf(id),1);
            }
         }
         for each(id in allBreedingItemIds)
         {
            if(filteredItemIds.indexOf(id) != -1)
            {
               filteredItemIds.splice(filteredItemIds.indexOf(id),1);
            }
         }
         return filteredItemIds;
      }
      
      public function filterRunesFromItemEffects(characsIdList:Vector.<uint> = null) : Vector.<uint>
      {
         var characId:uint = 0;
         var resultItemWithEffect:Vector.<uint> = null;
         var effectId:uint = 0;
         var result:Vector.<uint> = this._dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE);
         var tmpEffectsResult:Vector.<uint> = new Vector.<uint>();
         for each(characId in characsIdList)
         {
            tmpEffectsResult = this._dataApi.queryUnion(tmpEffectsResult,this._dataApi.queryEquals(Effect,"characteristic",characId));
         }
         tmpEffectsResult = this._dataApi.queryIntersection(this._dataApi.queryEquals(Effect,"bonusType",1),tmpEffectsResult);
         resultItemWithEffect = new Vector.<uint>();
         for each(effectId in tmpEffectsResult)
         {
            resultItemWithEffect = this._dataApi.queryUnion(resultItemWithEffect,this._dataApi.queryEquals(Item,"possibleEffects.effectId",effectId));
         }
         return this._dataApi.queryIntersection(result,resultItemWithEffect);
      }
      
      public function resetFilters(levelMin:int = -1, levelMax:int = -1) : void
      {
         this.resetLevel(levelMin,levelMax);
         this.resetAllIds();
      }
      
      public function resetAllIds() : void
      {
         this._searchCriteria = null;
         this._currentFilteredIds = [];
         this._currentSubIds = [];
         this._subFilteredTypes = [];
         this._currentCharacIds = [];
         this._currentWeaponEffectIds = [];
         this._currentConsumableEffectIds = [];
         this._currentSkinTargetIds = [];
         this._obtainingMethod = [];
         this._currentBreedingItemEffectIds = [];
         if(this._currentUi && this._lastUi && this._currentUi.uiData.name != this._lastUi.uiData.name)
         {
            this.resetLevel();
         }
         if(Object(this._currentUi.uiClass).hasOwnProperty("resetFilters"))
         {
            this._currentUi.uiClass.resetFilters();
         }
         this.dataInit();
         this.displayCategories();
         if(Object(this._currentUi.uiClass).hasOwnProperty("filterItems") && !(Object(this._currentUi.uiClass).hasOwnProperty("forceOpen") && this._currentUi.uiClass.forceOpen))
         {
            this._currentUi.uiClass.filterItems();
         }
      }
      
      public function resetLevel(levelMin:int = -1, levelMax:int = -1) : void
      {
         this.setLevelRange(levelMin > 0 ? uint(levelMin) : uint(this._minLevel),levelMax > 0 ? uint(levelMax) : uint(this._maxLevel));
      }
   }
}

class FilterGridItem
{
    
   
   public var cId:int = 0;
   
   public var id:String;
   
   public var text:String;
   
   public var gfxId:String;
   
   public var cat:int;
   
   public var selected:Boolean = false;
   
   public var isCat:Boolean = false;
   
   public var itemTypeId:int = -1;
   
   function FilterGridItem(gCid:int, gId:String, gText:String, gGfxId:String, gSelected:Boolean, gCat:int, typeId:int = -1)
   {
      super();
      this.cId = gCid;
      this.id = gId;
      this.text = gText;
      this.gfxId = gGfxId;
      this.selected = gSelected;
      this.cat = gCat;
      this.itemTypeId = typeId;
      this.isCat = false;
   }
}
