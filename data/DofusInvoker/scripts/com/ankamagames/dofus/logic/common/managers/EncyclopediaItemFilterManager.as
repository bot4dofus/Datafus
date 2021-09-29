package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   
   public class EncyclopediaItemFilterManager extends AbstractItemFilterManager
   {
      
      private static var _self:EncyclopediaItemFilterManager;
       
      
      public function EncyclopediaItemFilterManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("AbstractItemFilterManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : EncyclopediaItemFilterManager
      {
         if(_self == null)
         {
            _self = new EncyclopediaItemFilterManager();
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
               _currentCategory = SKIN_CATEGORY;
               setLevelRange(_minLevel,_maxLevel);
               getTargetEquipment();
               getTargetWeapon();
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
         switch(_currentCategory)
         {
            case EQUIPMENT_CATEGORY:
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_WEAPON) != -1)
               {
                  addCustomSubEffectCategory(_weaponEffects,_uiApi.getText("ui.encyclopedia.weaponEffect"),"weaponEffect");
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_WEAPON,DataEnum.ITEM_SUPERTYPE_WEAPON,_uiApi.getText("ui.encyclopedia.weaponCategory"));
               }
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CAPE) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_CAPE,DataEnum.ITEM_SUPERTYPE_CAPE,_uiApi.getText("ui.encyclopedia.capeCategory"));
               }
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_PET) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CERTIFICATE) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_PET_GHOST) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_PET,DataEnum.ITEM_SUPERTYPE_PET,_uiApi.getText("ui.encyclopedia.petCategory"));
               }
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY,DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY,_uiApi.getText("ui.encyclopedia.dofusCategory"));
               }
               this.addObtainingMethodCategory(_uiApi.getText("ui.encyclopedia.obtainingTitle"),"obtaining");
               break;
            case CONSUMABLE_CATEGORY:
               addCustomSubEffectCategory(_consumableEffects,_uiApi.getText("ui.effects"),"consumableEffect");
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_CONSUMABLE) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_CONSUMABLE,DataEnum.ITEM_SUPERTYPE_CONSUMABLE,_uiApi.getText("ui.encyclopedia.consumableCategory"));
               }
               this.addObtainingMethodCategory(_uiApi.getText("ui.encyclopedia.obtainingTitle"),"obtaining");
               break;
            case RESOURCE_CATEGORY:
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_RESOURCES) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_RESOURCES,DataEnum.ITEM_SUPERTYPE_RESOURCES,_uiApi.getText("ui.encyclopedia.resourceCategory"));
               }
               this.addObtainingMethodCategory(_uiApi.getText("ui.encyclopedia.obtainingTitle"),"obtaining");
               break;
            case SKIN_CATEGORY:
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS) != -1 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_COSTUME) != -1)
               {
                  setSubFilters(DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS,DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS,_uiApi.getText("ui.encyclopedia.cosmeticCategory"));
               }
               if(_currentFilteredIds.length == 0 || _currentFilteredIds.indexOf(DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS) != -1)
               {
                  this.addTargetCategory(_targetEquipment,_uiApi.getText("ui.encyclopedia.targetEquipment"),"targetEquipment");
                  this.addTargetCategory(_targetWeapon,_uiApi.getText("ui.encyclopedia.targetWeapon"),"targetWeapon");
               }
               this.addObtainingMethodCategory(_uiApi.getText("ui.encyclopedia.obtainingTitle"),"obtaining");
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
      
      protected function addObtainingMethodCategory(subCatName:String, id:String) : void
      {
         _dataMatrix.push({
            "name":subCatName,
            "id":_catNumber,
            "isCat":true
         });
         _dataMatrix.push(filterGridItem(ITEM_COMPONENT_CAT_ID,id,_uiApi.getText("ui.encyclopedia.filterComponent"),"icon_recipe_grey.png",false,_catNumber));
         _dataMatrix.push(filterGridItem(ITEM_CRAFTABLE_CAT_ID,id,_uiApi.getText("ui.encyclopedia.filterCraftable"),"icon_hammer_grey.png",false,_catNumber));
         _dataMatrix.push(filterGridItem(ITEM_DROPABLE_CAT_ID,id,_uiApi.getText("ui.encyclopedia.filterDropable"),"icon_monster_grey.png",false,_catNumber));
         if(_currentCategory == RESOURCE_CATEGORY)
         {
            _dataMatrix.push(filterGridItem(ITEM_HARVESTABLE_CAT_ID,id,_uiApi.getText("ui.encyclopedia.filterHarvestable"),"icon_scythe_grey.png",false,_catNumber));
         }
         if(_currentUi.uiClass.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && _currentCategory == EQUIPMENT_CATEGORY)
         {
            _openedCategories.push(_catNumber);
         }
         ++_catNumber;
      }
   }
}
