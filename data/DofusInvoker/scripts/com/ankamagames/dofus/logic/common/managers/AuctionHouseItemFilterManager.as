package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   
   public class AuctionHouseItemFilterManager extends AbstractItemFilterManager
   {
      
      private static var _self:AuctionHouseItemFilterManager;
       
      
      public function AuctionHouseItemFilterManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("AbstractItemFilterManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : AuctionHouseItemFilterManager
      {
         if(_self == null)
         {
            _self = new AuctionHouseItemFilterManager();
         }
         return _self;
      }
      
      override public function setCurrentTypeInfos(tabIndex:uint, currentTypeInfos:Dictionary) : void
      {
         _currentTypeInfos = new Dictionary(true);
         _openedCategories = [];
         switch(tabIndex)
         {
            case 1:
               _currentCategory = EQUIPMENT_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               getWeaponEffects();
               getTargetEquipment();
               getTargetWeapon();
               _openedCategories = [SEARCHBAR_CAT_ID,ITEMTYPE_CAT_ID,LEVELFILTER_CAT_ID];
               break;
            case 2:
               _currentCategory = CONSUMABLE_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               getConsumableEffects();
               _openedCategories = [SEARCHBAR_CAT_ID,LEVELFILTER_CAT_ID,FIRST_SUBFILTER_CAT_ID,SECOND_SUBFILTER_CAT_ID];
               break;
            case 3:
               _currentCategory = RESOURCE_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               getAllItemsHarvestable();
               _openedCategories = [SEARCHBAR_CAT_ID,LEVELFILTER_CAT_ID,FIRST_SUBFILTER_CAT_ID];
               break;
            case 4:
               _currentCategory = RUNE_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               _openedCategories = [SEARCHBAR_CAT_ID,LEVELFILTER_CAT_ID,FIRST_SUBFILTER_CAT_ID];
               break;
            case 5:
               _currentCategory = SOUL_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               _openedCategories = [SEARCHBAR_CAT_ID,LEVELFILTER_CAT_ID,FIRST_SUBFILTER_CAT_ID];
               break;
            case 6:
               _currentCategory = CREATURE_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               getBreedingItemTypeEffects();
               _openedCategories = [SEARCHBAR_CAT_ID,LEVELFILTER_CAT_ID,FIRST_SUBFILTER_CAT_ID];
         }
         _currentTypeInfos = currentTypeInfos;
         setItemsWithCurrentTypes();
      }
      
      override public function dataInit(specificFilters:Array = null) : void
      {
         var cat:CharacteristicCategory = null;
         var cId:int = 0;
         var charac:Characteristic = null;
         super.dataInit(specificFilters);
         var characteristicsCategoriesData:Object = _dataApi.getCharacteristicCategories();
         if(_currentFilteredIds.length > 0 && _currentFilteredIds.some(canDisplayCharacFilters))
         {
            if(_currentCategory == EQUIPMENT_CATEGORY)
            {
               for each(cat in characteristicsCategoriesData)
               {
                  _dataMatrix.push({
                     "name":_dataApi.getCharacteristicCategory(cat.id).name,
                     "id":_catNumber,
                     "isCat":true
                  });
                  for each(cId in cat.characteristicIds)
                  {
                     charac = _dataApi.getCharacteristic(cId);
                     if(charac)
                     {
                        _dataMatrix.push(filterGridItem(cId,charac.keyword,charac.name,charac.asset,false,_catNumber));
                     }
                  }
                  if(cat.id == 3)
                  {
                     charac = _dataApi.getCharacteristic(40);
                     if(charac)
                     {
                        _dataMatrix.push(filterGridItem(40,charac.keyword,charac.name,charac.asset,false,_catNumber));
                     }
                  }
                  ++_catNumber;
               }
            }
         }
         switch(_currentCategory)
         {
            case EQUIPMENT_CATEGORY:
               if(_currentFilteredIds.length > 0)
               {
                  if(_currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_WEAPON) != -1)
                  {
                     addCustomSubEffectCategory(_weaponEffects,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.weaponEffect"),"weaponEffect");
                     setSubFilters(DataEnum.ITEM_SUPERTYPE_WEAPON,DataEnum.ITEM_SUPERTYPE_WEAPON,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.weaponCategory"));
                  }
                  if(_currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CAPE) != -1)
                  {
                     setSubFilters(DataEnum.ITEM_SUPERTYPE_CAPE,DataEnum.ITEM_SUPERTYPE_CAPE,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.capeCategory"));
                  }
                  if(_currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_COSTUME) != -1)
                  {
                     this.addTargetCategory(_targetEquipment,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.targetEquipment"),"targetEquipment");
                     this.addTargetCategory(_targetWeapon,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.targetWeapon"),"targetWeapon");
                     setSubFilters(DataEnum.ITEM_SUPERTYPE_COSTUME,DataEnum.ITEM_SUPERTYPE_COSTUME,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.encyclopediaType25"));
                  }
                  if(_currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY) != -1)
                  {
                     setSubFilters(DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY,DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.trophyCategory"));
                  }
               }
               break;
            case CONSUMABLE_CATEGORY:
               addCustomSubEffectCategory(_consumableEffects,_currentUi.uiClass.uiApi.getText("ui.effects"),"consumableEffect");
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CONSUMABLE) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_CONSUMABLE,DataEnum.ITEM_SUPERTYPE_CONSUMABLE,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.consumableCategory"));
               }
               break;
            case RESOURCE_CATEGORY:
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_RESOURCES) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_RESOURCES,DataEnum.ITEM_SUPERTYPE_RESOURCES,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.resourceCategory"));
               }
               break;
            case RUNE_CATEGORY:
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_RESOURCES) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_RESOURCES,DataEnum.ITEM_SUPERTYPE_RESOURCES,_currentUi.uiClass.uiApi.getText("ui.common.category"));
               }
               break;
            case SOUL_CATEGORY:
               setSubFilters(DataEnum.ITEM_TYPE_SOULSTONE,DataEnum.ITEM_SUPERTYPE_CONSUMABLE,_currentUi.uiClass.uiApi.getText("ui.common.category"));
               break;
            case CREATURE_CATEGORY:
               setSubFilters(DataEnum.ITEM_SUPERTYPE_PET,DataEnum.ITEM_SUPERTYPE_PET,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.petCategory"));
               setSubFilters(DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS,DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS,_currentUi.uiClass.uiApi.getText("ui.common.equipments"));
               setSubFilters(DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT,DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.petEquipmentCategory"));
               setSubFilters(DataEnum.ITEM_SUPERTYPE_PET_GHOST,DataEnum.ITEM_SUPERTYPE_PET_GHOST,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.petResourceCategory"));
               setSubFilters(DataEnum.ITEM_TYPE_PET_EGG,DataEnum.ITEM_SUPERTYPE_CONSUMABLE,_currentUi.uiClass.uiApi.getText("ui.encyclopedia.petConsumableCategory"));
               if(_currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_PET) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CERTIFICATE) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS) != -1)
               {
                  for each(cat in characteristicsCategoriesData)
                  {
                     _dataMatrix.push({
                        "name":_dataApi.getCharacteristicCategory(cat.id).name,
                        "id":_catNumber,
                        "isCat":true
                     });
                     for each(cId in cat.characteristicIds)
                     {
                        charac = _dataApi.getCharacteristic(cId);
                        if(charac)
                        {
                           _dataMatrix.push(filterGridItem(cId,charac.keyword,charac.name,charac.asset,false,_catNumber));
                        }
                     }
                     ++_catNumber;
                  }
               }
               if(_currentSubIds.indexOf(DataEnum.ITEM_TYPE_BREEDING_ITEM) != -1)
               {
                  this.addBreedingItemType(_breedingItemType,_uiApi.getText("ui.encyclopedia.breedingItemCategory"),"breedingItem");
               }
         }
      }
      
      protected function addTargetCategory(itemTypes:Array, subCatName:String, id:String) : void
      {
         var itemType:ItemType = null;
         _dataMatrix.push({
            "name":subCatName,
            "id":_catNumber,
            "isCat":true
         });
         for each(itemType in itemTypes)
         {
            _dataMatrix.push(filterGridItem(itemType.id,id,itemType.name,null,false,_catNumber));
         }
         ++_catNumber;
      }
      
      protected function addBreedingItemType(breeddingItemType:Array, subCatName:String, id:String) : void
      {
         var breedingItemType:Object = null;
         _dataMatrix.push({
            "name":subCatName,
            "id":_catNumber,
            "isCat":true
         });
         for each(breedingItemType in breeddingItemType)
         {
            _dataMatrix.push(filterGridItem(breedingItemType.effectId,id,breedingItemType.name,null,false,_catNumber));
         }
         ++_catNumber;
      }
   }
}
