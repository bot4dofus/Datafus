package Ankama_Grimoire.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.EncyclopediaItemFilterApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class EncyclopediaList
   {
      
      private static const CTR_SEARCH:String = "ctr_searchBar";
      
      private static const CTR_FILTER_CAT:String = "ctr_filterCategory";
      
      private static const CTR_FILTER_ITEM:String = "ctr_filterItem";
      
      private static const CTR_ITEM_TYPE:String = "ctr_ItemType";
      
      private static const CTR_FILTER_LEVEL:String = "ctr_filterLevel";
      
      public static const ITEM_COMPONENT_CAT_ID:uint = 0;
      
      public static const ITEM_CRAFTABLE_CAT_ID:uint = 1;
      
      public static const ITEM_DROPABLE_CAT_ID:uint = 2;
      
      public static const ITEM_HARVESTABLE_CAT_ID:uint = 3;
      
      private static const TYPE_ICON:Array = [null,"collar","weapon","ring","belt","shoe","consumable","shield",null,"resource","helmet","cape","pet","dofus",null,null,null,null,null,null,null,"pet","costume","companon","pet","costume",null,"pet"];
      
      private static var _allItemsCached:Array;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="EncyclopediaItemFilterApi")]
      public var itemFilterApi:EncyclopediaItemFilterApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      private var ANIMAL_TYPES:Array;
      
      private var _params:Object;
      
      private var _characterInfos;
      
      private var _componentList:Dictionary;
      
      private var _characteristicsCategoriesData:Object;
      
      private var _currentScrollValue:int;
      
      private var _lastFilterCategorySelected:Object;
      
      private var _allItems:Array;
      
      private var _sortCriteria:String = "name";
      
      private var _ascendingSort:Boolean = true;
      
      private var _catAutoSelected:Array;
      
      private var _currentInputLevel:Input;
      
      private var _levelTimer:BenchmarkTimer;
      
      private var _lockSearchTimer:BenchmarkTimer;
      
      private var _searchCriteria:String = "";
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _mapPopup:String;
      
      private var _allTypes:Dictionary;
      
      public var forceOpen:Boolean = false;
      
      public var gd_list:Grid;
      
      public var gd_filters:Grid;
      
      public var nbOfItems:Label;
      
      public var inp_minLevel:Input;
      
      public var inp_maxLevel:Input;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabBonus:ButtonContainer;
      
      public var btn_tabType:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabPrice:ButtonContainer;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_itemType:ButtonContainer;
      
      public var btn_resetFilters:ButtonContainer;
      
      public var lbl_resetFilters:Label;
      
      public function EncyclopediaList()
      {
         this.ANIMAL_TYPES = [DataEnum.ITEM_SUPERTYPE_PET,DataEnum.ITEM_SUPERTYPE_CERTIFICATE,DataEnum.ITEM_SUPERTYPE_PET_GHOST,DataEnum.ITEM_SUPERTYPE_COMPANION];
         this._params = {};
         this._componentList = new Dictionary(true);
         this._catAutoSelected = [];
         this._allTypes = new Dictionary(true);
         super();
      }
      
      public function main(params:Object) : void
      {
         this._params = params;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(HookList.DisplayPinnedItemTooltip,this.onDisplayPinnedTooltip);
         this.uiApi.addComponentHook(this.gd_filters,ComponentHookList.ON_SELECT_ITEM);
         this.forceOpen = this._params.forceOpenResourceTab || this._params.forceOpenConsumableTab || this._params.forceOpenEquipmentTab;
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         this._characteristicsCategoriesData = this.dataApi.getCharacteristicCategories();
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.bidhouse.searchInAuctionHouse");
         if(!this._levelTimer)
         {
            this._levelTimer = new BenchmarkTimer(200,1,"EncyclopediaList._levelTimer");
            this._levelTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLevelTimerComplete);
         }
         this.btn_resetFilters.disabled = true;
         this.lbl_resetFilters.cssClass = "lightgreycenter";
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == this.uiApi.me().name)
         {
            if(!_allItemsCached)
            {
               this._allItems = _allItemsCached = [];
            }
            else
            {
               this._allItems = _allItemsCached;
            }
            this._lockSearchTimer = new BenchmarkTimer(500,1,"EncyclopediaList._lockSearchTimer");
            this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
            this._allTypes = this.setCurrentTypeInfos(this._params.currentTab);
            this.itemFilterApi.setMaxLevel(200);
            this.itemFilterApi.initFilters(this._params.currentTab,this.playerApi.getPlayedCharacterInfo(),this._allTypes,this.sysApi.getData("openedFilterCat"),this.gd_filters,this.gd_list,null,this._params);
            if(this.inp_minLevel)
            {
               this.inp_minLevel.restrictChars = "0-9";
            }
            if(this.inp_maxLevel)
            {
               this.inp_maxLevel.restrictChars = "0-9";
            }
            if(this._params.hasOwnProperty("specificSearchData") && this._params.specificSearchData)
            {
               this.filterItems();
            }
            else if(this._params.hasOwnProperty("forceOpenResourceTab") && this._params.forceOpenResourceTab)
            {
               this.inp_search.text = this._params.resourceSearch.toLowerCase();
               this.gd_list.dataProvider = [this.parseItem(this._params.resourceId)];
            }
            else if(this._params.hasOwnProperty("forceOpenConsumableTab") && this._params.forceOpenConsumableTab)
            {
               this.inp_search.text = this._params.resourceSearch.toLowerCase();
               this.gd_list.dataProvider = [this.parseItem(this._params.resourceId)];
            }
            else if(this._params.hasOwnProperty("forceOpenEquipmentTab") && this._params.forceOpenEquipmentTab)
            {
               this.inp_search.text = this._params.resourceSearch.toLowerCase();
               this.gd_list.dataProvider = [this.parseItem(this._params.resourceId)];
            }
         }
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi(this._mapPopup);
         if(this._levelTimer)
         {
            this._levelTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onLevelTimerComplete);
            this._levelTimer = null;
         }
         if(this._lockSearchTimer)
         {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
            this._lockSearchTimer = null;
         }
      }
      
      public function updateItemLine(data:*, components:*, selected:Boolean) : void
      {
         var timer:uint = 0;
         var i:uint = 0;
         if(data)
         {
            timer = getTimer();
            if(!this._componentList[components.itemCtr.name])
            {
               this.uiApi.addComponentHook(components.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(components.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(components.lbl_name,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.lbl_name,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(components.lbl_name,ComponentHookList.ON_RIGHT_CLICK);
               this.uiApi.addComponentHook(components.tx_itemBg,ComponentHookList.ON_RIGHT_CLICK);
               this.uiApi.addComponentHook(components.tx_itemIcon,ComponentHookList.ON_RIGHT_CLICK);
            }
            this._componentList[components.tx_itemBg.name] = data;
            this._componentList[components.tx_itemIcon.name] = data;
            this._componentList[components.lbl_name.name] = data;
            components.tx_itemBg.visible = true;
            components.tx_itemIcon.uri = data.iconUri;
            if(!components.tx_itemIcon.uri)
            {
               components.tx_itemIcon.visible = false;
            }
            else
            {
               components.tx_itemIcon.visible = true;
            }
            if(data.itemWrapper.itemSetId != -1)
            {
               components.lbl_name.cssClass = "orangebold";
               components.lbl_name.text = "{encyclopediaPinItem," + data.id + ",0," + this.uiApi.me().name + ",linkColor:0xEBC304,hoverColor:0xF2FABD::" + data.name + "}";
            }
            else
            {
               components.lbl_name.cssClass = "greenleft";
               components.lbl_name.text = "{encyclopediaPinItem," + data.id + ",0," + this.uiApi.me().name + ",linkColor:0xDEFF00,hoverColor:0xF2FABD::" + data.name + "}";
            }
            for(i = 0; i < 4; i++)
            {
               if(data.obtaining[i])
               {
                  if(!this._componentList[components["tx_obtaining_" + i].name])
                  {
                     this.uiApi.addComponentHook(components["tx_obtaining_" + i],ComponentHookList.ON_RELEASE);
                     this.uiApi.addComponentHook(components["tx_obtaining_" + i],ComponentHookList.ON_ROLL_OVER);
                     this.uiApi.addComponentHook(components["tx_obtaining_" + i],ComponentHookList.ON_ROLL_OUT);
                  }
                  this._componentList[components["tx_obtaining_" + i].name] = data.obtaining[i];
                  components["tx_obtaining_" + i].uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.obtaining[i].iconGreyPath);
                  components["tx_obtaining_" + i].visible = true;
               }
               else
               {
                  components["tx_obtaining_" + i].visible = false;
               }
            }
            components.lbl_type.text = data.typeName;
            components.lbl_level.text = data.level;
            if(data.price <= 0)
            {
               components.lbl_price.text = "--------";
               components.iconKama.visible = false;
            }
            else
            {
               components.lbl_price.text = this.utilApi.kamasToString(data.price,"");
               components.iconKama.visible = true;
            }
         }
         else
         {
            components.tx_itemBg.visible = false;
            components.tx_itemIcon.uri = null;
            components.tx_itemIcon.visible = false;
            components.lbl_name.text = "";
            components.tx_obtaining_0.visible = false;
            components.tx_obtaining_1.visible = false;
            components.tx_obtaining_2.visible = false;
            components.tx_obtaining_3.visible = false;
            components.lbl_type.text = "";
            components.lbl_level.text = "";
            components.lbl_price.text = "";
            components.iconKama.visible = false;
         }
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getCatLineType(data,line))
         {
            case CTR_SEARCH:
               this.inp_search = componentsRef.inp_search;
               this.btn_resetSearch = componentsRef.btn_resetSearch;
               if(this._searchCriteria)
               {
                  this.btn_resetSearch.visible = true;
                  this.inp_search.text = this._searchCriteria;
               }
               else if(!this._searchCriteria && this.inp_search.text == "" && !this.inp_search.haveFocus || this.inp_search.text == this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                  this.btn_resetSearch.visible = false;
               }
               break;
            case CTR_FILTER_CAT:
               componentsRef.lbl_catName.text = data.name;
               componentsRef.btn_cat.selected = selected;
               if(this.itemFilterApi.getOpenedCategories().indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               break;
            case CTR_FILTER_ITEM:
               if(!this._componentList[componentsRef.btn_selectFilter.name])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_selectFilter,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.btn_selectFilter.name] = data;
               if(data.itemTypeId != -1)
               {
                  componentsRef.tx_picto.uri = null;
                  componentsRef.btn_selectFilter.selected = this.itemFilterApi.filterIsSelected(data);
                  componentsRef.btn_label_btn_selectFilter.text = data.text;
               }
               else
               {
                  if(data.gfxId && data.gfxId != "null")
                  {
                     componentsRef.tx_picto.visible = true;
                     if(data.gfxId.indexOf("icon_") != -1)
                     {
                        componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.gfxId);
                     }
                     else
                     {
                        componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + data.gfxId);
                     }
                  }
                  else
                  {
                     componentsRef.tx_picto.uri = null;
                  }
                  componentsRef.btn_selectFilter.selected = this.itemFilterApi.filterIsSelected(data);
                  componentsRef.btn_label_btn_selectFilter.text = data.text;
               }
               break;
            case CTR_ITEM_TYPE:
               componentsRef.gd_itemType.dataProvider = data.itemType;
               break;
            case CTR_FILTER_LEVEL:
               if(!this.inp_minLevel)
               {
                  this.inp_minLevel = componentsRef.inp_minLevel;
               }
               if(!this.inp_maxLevel)
               {
                  this.inp_maxLevel = componentsRef.inp_maxLevel;
               }
               componentsRef.inp_minLevel.text = this.itemFilterApi.getMinLevelInputValue().toString();
               componentsRef.inp_maxLevel.text = this.itemFilterApi.getMaxLevelInputValue().toString();
         }
      }
      
      public function updateItemType(data:*, componentsRef:*, selected:Boolean) : void
      {
         var typeId:uint = 0;
         if(data)
         {
            if(!this._componentList[componentsRef.btn_itemType.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[componentsRef.btn_itemType.name] = data;
            if(TYPE_ICON[data])
            {
               componentsRef.iconTexturebtn_itemType.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/icon_slot_" + TYPE_ICON[data] + "_inventory.png");
            }
            else
            {
               componentsRef.iconTexturebtn_itemType.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/emptySlot.png");
            }
            for each(typeId in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(data)])
            {
               if(this.itemFilterApi.currentFilteredIds().indexOf(typeId) != -1)
               {
                  componentsRef.btn_itemType.selected = true;
                  break;
               }
               componentsRef.btn_itemType.selected = false;
            }
            componentsRef.btn_itemType.visible = true;
         }
         else
         {
            componentsRef.iconTexturebtn_itemType.uri = null;
            componentsRef.btn_itemType.selected = false;
            componentsRef.btn_itemType.visible = false;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data.isCat)
         {
            return CTR_FILTER_CAT;
         }
         if(data.hasOwnProperty("id") && data.id == "search")
         {
            return CTR_SEARCH;
         }
         if(data.hasOwnProperty("itemType"))
         {
            return CTR_ITEM_TYPE;
         }
         if(data.hasOwnProperty("currentLevel"))
         {
            return CTR_FILTER_LEVEL;
         }
         return CTR_FILTER_ITEM;
      }
      
      private function setCurrentTypeInfos(tabIndex:uint) : Dictionary
      {
         var i:uint = 0;
         var supertype:int = 0;
         var typesAvailable:Array = this.dataApi.getItemTypes();
         switch(tabIndex)
         {
            case 0:
               break;
            case 1:
               for(i = 0; i < typesAvailable.length; i++)
               {
                  if(!(tabIndex == 1 && typesAvailable[i].categoryId != ItemCategoryEnum.EQUIPMENT_CATEGORY || !typesAvailable[i].isInEncyclopedia || typesAvailable[i].superTypeId == DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS || typesAvailable[i].superTypeId == DataEnum.ITEM_SUPERTYPE_COSTUME || typesAvailable[i].superTypeId == DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT))
                  {
                     supertype = typesAvailable[i].superTypeId;
                     if(this.ANIMAL_TYPES.indexOf(typesAvailable[i].superTypeId) != -1)
                     {
                        this.fillTypesArray(supertype,this.ANIMAL_TYPES[0]);
                     }
                     else
                     {
                        this.fillTypesArray(supertype);
                     }
                  }
               }
               break;
            case 2:
               for(i = 0; i < typesAvailable.length; i++)
               {
                  if(!(typesAvailable[i].categoryId != ItemCategoryEnum.CONSUMABLES_CATEGORY || !typesAvailable[i].isInEncyclopedia))
                  {
                     supertype = typesAvailable[i].superTypeId;
                     this.fillTypesArray(supertype);
                  }
               }
               break;
            case 3:
               for(i = 0; i < typesAvailable.length; i++)
               {
                  if(!(typesAvailable[i].categoryId != ItemCategoryEnum.RESOURCES_CATEGORY || !typesAvailable[i].isInEncyclopedia))
                  {
                     supertype = typesAvailable[i].superTypeId;
                     this.fillTypesArray(supertype);
                  }
               }
               break;
            case 4:
               for(i = 0; i < typesAvailable.length; i++)
               {
                  if(!(typesAvailable[i].superTypeId != DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS && typesAvailable[i].superTypeId != DataEnum.ITEM_SUPERTYPE_COSTUME && typesAvailable[i].superTypeId != DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT || !typesAvailable[i].isInEncyclopedia))
                  {
                     supertype = typesAvailable[i].superTypeId;
                     this.fillTypesArray(DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS);
                  }
               }
         }
         return this._allTypes;
      }
      
      private function fillTypesArray(supertype:int, customSupertype:int = -1) : void
      {
         if(customSupertype == -1)
         {
            customSupertype = supertype;
         }
         if(this._allTypes[customSupertype] == null)
         {
            this._allTypes[customSupertype] = [];
         }
         if(this._allTypes[customSupertype].indexOf(supertype) == -1)
         {
            this._allTypes[customSupertype].push(supertype);
         }
         if(supertype == DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS)
         {
            if(this._allTypes[customSupertype].indexOf(DataEnum.ITEM_SUPERTYPE_COSTUME) == -1)
            {
               this._allTypes[customSupertype].push(DataEnum.ITEM_SUPERTYPE_COSTUME);
            }
            if(this._allTypes[customSupertype].indexOf(DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT) == -1)
            {
               this._allTypes[customSupertype].push(DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT);
            }
         }
      }
      
      private function parseItem(itemId:uint) : Object
      {
         var tmpItem:ItemWrapper = null;
         var item:Object = null;
         if(this._allItems[itemId] != null)
         {
            return this._allItems[itemId];
         }
         tmpItem = this.dataApi.getItemWrapper(itemId);
         if((!tmpItem.hasOwnProperty("etheral") || !tmpItem.etheral) && tmpItem.visible)
         {
            if(tmpItem.typeId == DataEnum.ITEM_TYPE_COMPANION && this.etheralCompanion(tmpItem) || tmpItem.typeId == DataEnum.ITEM_TYPE_MODSTER)
            {
               return null;
            }
            if(tmpItem.type.id == DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE || tmpItem.type.id == DataEnum.ITEM_TYPE_MULDO_CERTIFICATE || tmpItem.type.id == DataEnum.ITEM_TYPE_FLYHORN_CERTIFICATE)
            {
               item = this.parseMount(tmpItem);
            }
            else if(tmpItem.type.id == DataEnum.ITEM_TYPE_COMPANION && this.sysApi.getCurrentServer().gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
            {
               item = this.parseCompanion(tmpItem);
            }
            else
            {
               item = {};
               item.iconUri = tmpItem.iconUri;
               item.name = tmpItem.name;
               item.itemWrapper = tmpItem;
            }
            item.id = tmpItem.id;
            item.superTypeId = tmpItem.type.superTypeId;
            item.typeName = tmpItem.type.name;
            item.typeId = tmpItem.type.id;
            item.level = tmpItem.level;
            item.price = this.averagePricesApi.getItemAveragePrice(tmpItem.id);
            item.obtaining = [];
            if(tmpItem.recipes.length > 0)
            {
               item.obtaining.push({
                  "id":0,
                  "item":item.itemWrapper,
                  "iconGreyPath":"icon_recipe_grey.png",
                  "iconOverPath":"icon_recipe_over.png"
               });
            }
            if(tmpItem.recipeSlots != 0 && !tmpItem.secretRecipe && (!tmpItem.craftVisibleConditions || tmpItem.craftVisibleConditions.isRespected))
            {
               item.obtaining.push({
                  "id":1,
                  "item":item.itemWrapper,
                  "iconGreyPath":"icon_hammer_grey.png",
                  "iconOverPath":"icon_hammer_over.png"
               });
            }
            if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_DROPS) && (tmpItem.dropMonsterIds.length > 0 || tmpItem.dropTemporisMonsterIds && tmpItem.dropTemporisMonsterIds.length > 0))
            {
               item.obtaining.push({
                  "id":2,
                  "item":item.itemWrapper,
                  "iconGreyPath":"icon_monster_grey.png",
                  "iconOverPath":"icon_monster_over.png"
               });
            }
            else if(tmpItem.dropMonsterIds.length > 0)
            {
               item.obtaining.push({
                  "id":2,
                  "item":item.itemWrapper,
                  "iconGreyPath":"icon_monster_grey.png",
                  "iconOverPath":"icon_monster_over.png"
               });
            }
            if(tmpItem.resourcesBySubarea.length > 0)
            {
               item.obtaining.push({
                  "id":3,
                  "item":item.itemWrapper,
                  "iconGreyPath":"icon_scythe_grey.png",
                  "iconOverPath":"icon_scythe_over.png"
               });
            }
            this._allItems[item.id] = _allItemsCached[item.id] = item;
            return item;
         }
         return null;
      }
      
      private function parseMount(item:ItemWrapper) : Object
      {
         var currentItem:Object = {};
         var currentMount:Vector.<uint> = this.dataApi.queryEquals(Mount,"certificateId",item.id);
         if(currentMount.length <= 0)
         {
            currentItem.iconUri = item.iconUri;
            currentItem.itemWrapper = item;
            currentItem.name = item.name;
            return currentItem;
         }
         var mount:Mount = this.dataApi.getMountById(currentMount[0]);
         currentItem.iconUri = item.iconUri;
         currentItem.name = mount.name;
         item.effects = mount.effects.concat();
         currentItem.itemWrapper = item;
         return currentItem;
      }
      
      private function etheralCompanion(item:ItemWrapper) : Boolean
      {
         var ei:EffectInstance = null;
         for each(ei in item.possibleEffects)
         {
            if(ei.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
            {
               return true;
            }
         }
         return false;
      }
      
      private function parseCompanion(item:ItemWrapper) : Object
      {
         var compId:int = 0;
         var ei:EffectInstance = null;
         var companion:Companion = null;
         var currentItem:Object = {};
         currentItem.iconUri = item.iconUri;
         if(item.typeId == DataEnum.ITEM_TYPE_COMPANION)
         {
            for each(ei in item.possibleEffects)
            {
               if(ei.effectId == ActionIds.ACTION_SET_COMPANION)
               {
                  compId = int(ei.parameter2);
                  break;
               }
            }
         }
         if(compId > 0)
         {
            companion = this.dataApi.getCompanion(compId);
            currentItem.iconUri = this.uiApi.createUri(XmlConfig.getInstance().getEntry("config.gfx.path") + "companions/square_" + companion.assetId + ".png");
            currentItem.name = companion.name;
         }
         else
         {
            currentItem.name = item.name;
         }
         currentItem.itemWrapper = item;
         return currentItem;
      }
      
      private function addTypeFilterId(typeId:int = -1, autoSelect:Boolean = false) : void
      {
         var timer:uint = 0;
         var typeIdToAdd:uint = 0;
         var typeIdToRemove:uint = 0;
         var index:int = this.itemFilterApi.currentFilteredIds().indexOf(typeId);
         if(typeId > 0)
         {
            if(index == -1)
            {
               timer = getTimer();
               for each(typeIdToAdd in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
               {
                  this.itemFilterApi.currentFilteredIds().push(typeIdToAdd);
                  if(autoSelect && this._catAutoSelected.indexOf(typeIdToAdd) == -1)
                  {
                     this._catAutoSelected.push(typeIdToAdd);
                  }
               }
               this.sysApi.log(1,"add type : " + (getTimer() - timer));
            }
            else
            {
               for each(typeIdToRemove in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
               {
                  this.removeAllSubFilterIds(typeIdToRemove);
                  if(this.itemFilterApi.currentFilteredIds().indexOf(typeIdToRemove) != -1)
                  {
                     this.itemFilterApi.currentFilteredIds().splice(this.itemFilterApi.currentFilteredIds().indexOf(typeIdToRemove),1);
                  }
                  if(this._catAutoSelected.indexOf(typeIdToRemove) != -1)
                  {
                     this._catAutoSelected.splice(this._catAutoSelected.indexOf(typeIdToRemove),1);
                  }
               }
            }
         }
         this.itemFilterApi.dataInit();
         this.itemFilterApi.displayCategories();
      }
      
      private function removeAllSubFilterIds(superTypeId:uint) : void
      {
         var typeId:uint = 0;
         var ids:Vector.<uint> = this.dataApi.queryEquals(ItemType,"superTypeId",superTypeId);
         if(this.itemFilterApi.subFilteredTypes().indexOf(superTypeId) != -1)
         {
            this.itemFilterApi.subFilteredTypes().splice(this.itemFilterApi.subFilteredTypes().indexOf(superTypeId),1);
         }
         for each(typeId in ids)
         {
            if(this.itemFilterApi.currentSubIds().indexOf(typeId) != -1)
            {
               this.itemFilterApi.currentSubIds().splice(this.itemFilterApi.currentSubIds().indexOf(typeId),1);
            }
         }
      }
      
      private function addSubTypeFilterId(typeId:int = -1) : void
      {
         var superTypeIdToAdd:uint = 0;
         var superTypeIdToRemove:uint = 0;
         var index:int = this.itemFilterApi.currentSubIds().indexOf(typeId);
         var itemType:ItemType = this.dataApi.getItemType(typeId);
         if(typeId > 0)
         {
            if(index == -1)
            {
               this.itemFilterApi.currentSubIds().push(typeId);
               for each(superTypeIdToAdd in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(itemType.superTypeId)])
               {
                  if(this.itemFilterApi.subFilteredTypes().indexOf(superTypeIdToAdd) == -1)
                  {
                     this.itemFilterApi.subFilteredTypes().push(superTypeIdToAdd);
                  }
                  if(this.itemFilterApi.currentFilteredIds().indexOf(superTypeIdToAdd) == -1)
                  {
                     this.itemFilterApi.currentFilteredIds().push(superTypeIdToAdd);
                  }
               }
            }
            else
            {
               this.itemFilterApi.currentSubIds().splice(index,1);
               for each(superTypeIdToRemove in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(itemType.superTypeId)])
               {
                  if(!this.itemFilterApi.checkSubFilters(superTypeIdToRemove) && !this.itemFilterApi.checkAllSubFilters(superTypeIdToRemove))
                  {
                     this._allItems[superTypeIdToRemove] = [];
                     if(this.itemFilterApi.subFilteredTypes().indexOf(superTypeIdToRemove) != -1)
                     {
                        this.itemFilterApi.subFilteredTypes().splice(this.itemFilterApi.subFilteredTypes().indexOf(superTypeIdToRemove),1);
                     }
                     if(this.itemFilterApi.currentFilteredIds().indexOf(superTypeIdToRemove) != -1 && this._catAutoSelected.indexOf(superTypeIdToRemove) != -1)
                     {
                        this.itemFilterApi.currentFilteredIds().splice(this.itemFilterApi.currentFilteredIds().indexOf(superTypeIdToRemove),1);
                        this._catAutoSelected.splice(this._catAutoSelected.indexOf(superTypeIdToRemove),1);
                     }
                  }
               }
            }
         }
         this.itemFilterApi.dataInit();
         this.itemFilterApi.displayCategories();
      }
      
      public function filterItems() : void
      {
         var timer:uint = getTimer();
         var ids:Array = this.itemFilterApi.filterItems(this._searchCriteria);
         this.sysApi.log(0,"encyclopedia : item filter completed in " + (getTimer() - timer) + " ms");
         this.gd_list.dataProvider = this.sortItemList(ids,this._sortCriteria);
         this.nbOfItems.htmlText = "<b><font color=\'#e0e0de\'>" + this.gd_list.dataProvider.length + "</font></b>" + "<font color=\'#9b9b9b\'> " + this.uiApi.getText("ui.encyclopedia.searchCriteria") + "</font>";
      }
      
      private function sortItemList(arrayToSort:Array, sortField:String) : Array
      {
         var sortedIds:Vector.<uint> = null;
         var id:uint = 0;
         var j:uint = 0;
         var itemTypesSorted:Vector.<uint> = null;
         var typeId:uint = 0;
         var allTypeIds:Array = null;
         var itemId:uint = 0;
         var key:* = undefined;
         var currentType:uint = 0;
         var tempItem:Object = null;
         this._sortCriteria = sortField;
         var dataProvider:Array = arrayToSort;
         var tmpArrayOfSortedIds:Array = [];
         var timer:uint = getTimer();
         switch(sortField)
         {
            case "name":
               sortedIds = this.dataApi.querySort(Item,Vector.<uint>(dataProvider),"name",this._ascendingSort);
               for each(id in sortedIds)
               {
                  tmpArrayOfSortedIds.push(id);
               }
               dataProvider = tmpArrayOfSortedIds;
               this.sysApi.log(1,"encyclopedia : sort by " + sortField + " in " + (getTimer() - timer) + " ms");
               break;
            case "type":
               itemTypesSorted = new Vector.<uint>();
               allTypeIds = [];
               if(this.itemFilterApi.currentFilteredIds().length == 0)
               {
                  for(key in this.itemFilterApi.getCurrentTypeInfos())
                  {
                     for each(currentType in this.itemFilterApi.getCurrentTypeInfos()[key])
                     {
                        allTypeIds.push(currentType);
                     }
                  }
               }
               else
               {
                  allTypeIds = this.itemFilterApi.currentFilteredIds();
               }
               for each(typeId in allTypeIds)
               {
                  itemTypesSorted = this.dataApi.queryUnion(itemTypesSorted,this.dataApi.queryEquals(ItemType,"superTypeId",typeId));
               }
               itemTypesSorted = this.dataApi.querySort(ItemType,itemTypesSorted,"name",this._ascendingSort);
               for each(typeId in itemTypesSorted)
               {
                  sortedIds = this.dataApi.queryUnion(sortedIds,this.dataApi.queryEquals(Item,"typeId",typeId));
               }
               for each(itemId in sortedIds)
               {
                  if(dataProvider.indexOf(itemId) != -1)
                  {
                     tmpArrayOfSortedIds.push(itemId);
                  }
                  if(tmpArrayOfSortedIds.length == dataProvider.length)
                  {
                     break;
                  }
               }
               dataProvider = tmpArrayOfSortedIds;
               break;
            case "level":
               sortedIds = this.dataApi.querySort(Item,Vector.<uint>(dataProvider),"level",this._ascendingSort);
               for each(id in sortedIds)
               {
                  tmpArrayOfSortedIds.push(id);
               }
               dataProvider = tmpArrayOfSortedIds;
               break;
            case "price":
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByPrice);
               }
               else
               {
                  dataProvider.sort(this.sortByPrice,Array.DESCENDING);
               }
         }
         var result:Array = [];
         for each(j in dataProvider)
         {
            tempItem = this.parseItem(j);
            if(tempItem && tempItem.itemWrapper.visible)
            {
               result.push(tempItem);
            }
         }
         this.sysApi.log(1,"encyclopedia : sort by " + sortField + " in " + (getTimer() - timer) + " ms");
         return result;
      }
      
      private function dataToIds(data:Array) : Array
      {
         var tempItem:Object = null;
         var result:Array = [];
         for each(tempItem in data)
         {
            result.push(tempItem.id);
         }
         return result;
      }
      
      private function sortByPrice(firstItem:int, secondItem:int) : int
      {
         var firstValue:uint = this.averagePricesApi.getItemAveragePrice(firstItem);
         var secondValue:uint = this.averagePricesApi.getItemAveragePrice(secondItem);
         return firstValue - secondValue;
      }
      
      private function displayItemTooltip(target:Object, item:Object) : void
      {
         var setting:String = null;
         var settings:Object = {};
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:* = this.sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         settings["showEffects"] = true;
         this.uiApi.showTooltip(item.itemWrapper,target,false,"standard",8,0,3,null,null,settings);
      }
      
      private function displayMapPopup(item:ItemWrapper) : void
      {
         var subArea:SubArea = null;
         var subAreaId:Vector.<int> = null;
         var subAreaWithMaxItem:uint = 0;
         var subAreaMaxItemCount:uint = 0;
         var text:String = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas",item.resourcesBySubarea.length),"m",item.resourcesBySubarea.length == 1,item.resourcesBySubarea.length == 0);
         var itemSubAreas:Vector.<uint> = new Vector.<uint>(0);
         for each(subAreaId in item.resourcesBySubarea)
         {
            subArea = this.dataApi.getSubArea(subAreaId[0]);
            if(subArea.hasCustomWorldMap || subArea.area.superArea.hasWorldMap)
            {
               itemSubAreas.push(subAreaId[0]);
               if(subAreaId[1] > subAreaMaxItemCount)
               {
                  subAreaWithMaxItem = subAreaId[0];
               }
            }
         }
         this._mapPopup = this.modCartography.openCartographyPopup(item.name,subAreaWithMaxItem,itemSubAreas,text);
      }
      
      private function displayTypeTooltipText(target:Object, id:uint) : void
      {
         var tooltipText:String = this.uiApi.getText("ui.encyclopedia.encyclopediaType" + id);
         if(id == DataEnum.ITEM_SUPERTYPE_DOFUS_TROPHY)
         {
            tooltipText = this.uiApi.getText("ui.encyclopedia.encyclopediaType" + id + "_withDofus");
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_filters)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO && this.gd_filters.selectedItem && this.gd_filters.selectedItem.isCat)
            {
               this._lastFilterCategorySelected = this.gd_filters.selectedItem;
               this.itemFilterApi.displayCategories(this.gd_filters.selectedItem);
            }
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.name.indexOf("lbl_name") != -1 || target.name.indexOf("tx_itemIcon") != -1 || target.name.indexOf("tx_itemBg") != -1)
         {
            data = this._componentList[target.name];
            contextMenu = this.menuApi.create(data.itemWrapper);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var tmpSuperTypeId:uint = 0;
         var typeData:uint = 0;
         var obtainigData:Object = null;
         var itemData:Object = null;
         switch(target)
         {
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
               this.filterItems();
               break;
            case this.btn_resetFilters:
               this._searchCriteria = null;
               this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
               this._catAutoSelected = [];
               this.btn_resetFilters.disabled = true;
               this.lbl_resetFilters.cssClass = "lightgreycenter";
               this.itemFilterApi.resetFilters(this.itemFilterApi.getMinLevel(),this.itemFilterApi.getMaxLevel());
               break;
            case this.btn_tabName:
               if(this._sortCriteria == "name")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_list.dataProvider = this.sortItemList(this.dataToIds(this.gd_list.dataProvider),"name");
               break;
            case this.btn_tabBonus:
               if(this._sortCriteria == "bonus")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_list.dataProvider = this.sortItemList(this.dataToIds(this.gd_list.dataProvider),"bonus");
               break;
            case this.btn_tabType:
               if(this._sortCriteria == "type")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_list.dataProvider = this.sortItemList(this.dataToIds(this.gd_list.dataProvider),"type");
               break;
            case this.btn_tabLevel:
               if(this._sortCriteria == "level")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_list.dataProvider = this.sortItemList(this.dataToIds(this.gd_list.dataProvider),"level");
               break;
            case this.btn_tabPrice:
               if(this._sortCriteria == "price")
               {
                  this._ascendingSort = !this._ascendingSort;
                  this.gd_list.dataProvider = this.gd_list.dataProvider.reverse();
               }
               else
               {
                  this.gd_list.dataProvider = this.sortItemList(this.dataToIds(this.gd_list.dataProvider),"price");
               }
               break;
            default:
               if(target.name.indexOf("btn_selectFilter") != -1)
               {
                  data = this._componentList[target.name];
                  data.selected = !data.selected;
                  if(data.itemTypeId != -1)
                  {
                     tmpSuperTypeId = this.dataApi.getItemType(data.itemTypeId).superTypeId;
                     if(!this.itemFilterApi.checkSubFilters(tmpSuperTypeId) && this.itemFilterApi.currentFilteredIds().indexOf(tmpSuperTypeId) == -1)
                     {
                        this.addTypeFilterId(tmpSuperTypeId,true);
                     }
                     this.addSubTypeFilterId(data.itemTypeId);
                  }
                  else if(data.id == "weaponEffect")
                  {
                     this.itemFilterApi.addWeaponEffect(data.cId);
                  }
                  else if(data.id == "consumableEffect")
                  {
                     this.itemFilterApi.addConsumableEffect(data.cId);
                  }
                  else if(data.id == "obtaining")
                  {
                     this.itemFilterApi.addObtainingMethod(data.cId);
                  }
                  else if(data.id == "targetEquipment" || data.id == "targetWeapon")
                  {
                     this.itemFilterApi.addSkinTargetFilterId(data.cId);
                  }
                  else
                  {
                     this.itemFilterApi.addCharacFilterId(data.cId);
                  }
                  this.btn_resetFilters.disabled = this.itemFilterApi.currentSubIds().length == 0 && this.itemFilterApi.currentFilteredIds().length == 0 && this.itemFilterApi.currentCharacIds().length == 0 && this.itemFilterApi.currentConsumableEffectIds().length == 0 && this.itemFilterApi.currentWeaponEffectIds().length == 0 && this.itemFilterApi.obtainingMethod().length == 0 && this.itemFilterApi.currentSkinTargetIds().length == 0 && !this._searchCriteria;
                  this.lbl_resetFilters.cssClass = !!this.btn_resetFilters.disabled ? "lightgreycenter" : "greencenter";
                  this.filterItems();
                  this.gd_filters.updateItem(this.gd_filters.selectedIndex);
               }
               else if(target.name.indexOf("btn_itemType") != -1)
               {
                  typeData = this._componentList[target.name];
                  this.addTypeFilterId(typeData,false);
                  this.filterItems();
                  this.btn_resetFilters.disabled = this.itemFilterApi.currentSubIds().length == 0 && this.itemFilterApi.currentFilteredIds().length == 0 && this.itemFilterApi.currentCharacIds().length == 0 && this.itemFilterApi.currentConsumableEffectIds().length == 0 && this.itemFilterApi.currentWeaponEffectIds().length == 0 && this.itemFilterApi.obtainingMethod().length == 0 && this.itemFilterApi.currentSkinTargetIds().length == 0 && !this._searchCriteria;
                  this.lbl_resetFilters.cssClass = !!this.btn_resetFilters.disabled ? "lightgreycenter" : "greencenter";
                  (target as ButtonContainer).selected = this.itemFilterApi.currentFilteredIds().indexOf(typeData) != -1;
               }
               else if(target.name.indexOf("tx_obtaining") != -1)
               {
                  obtainigData = this._componentList[target.name];
                  if(obtainigData.id == ITEM_COMPONENT_CAT_ID || obtainigData.id == ITEM_CRAFTABLE_CAT_ID)
                  {
                     this.sysApi.dispatchHook(HookList.OpenRecipe,obtainigData.item);
                  }
                  else if(obtainigData.id == ITEM_DROPABLE_CAT_ID)
                  {
                     itemData = {};
                     itemData.monsterId = 0;
                     itemData.monsterSearch = obtainigData.item.name;
                     if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_DROPS) && obtainigData.item.dropTemporisMonsterIds)
                     {
                        itemData.monsterIdsList = obtainigData.item.dropMonsterIds.concat(obtainigData.item.dropTemporisMonsterIds);
                     }
                     else
                     {
                        itemData.monsterIdsList = obtainigData.item.dropMonsterIds;
                     }
                     itemData.forceOpen = true;
                     this.sysApi.dispatchHook(HookList.OpenEncyclopedia,"bestiaryTab",itemData);
                  }
                  else if(obtainigData.id == ITEM_HARVESTABLE_CAT_ID)
                  {
                     this.displayMapPopup(obtainigData.item);
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tmpItem:Object = null;
         var btnData:Object = null;
         var tooltipText:String = null;
         if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
         {
            tmpItem = this._componentList[target.name];
            this.displayItemTooltip(target,tmpItem);
         }
         else if(target.name.indexOf("tx_obtaining") != -1)
         {
            btnData = this._componentList[target.name];
            (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + btnData.iconOverPath);
            switch(btnData.id)
            {
               case ITEM_COMPONENT_CAT_ID:
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterComponent");
                  break;
               case ITEM_CRAFTABLE_CAT_ID:
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterCraftable");
                  break;
               case ITEM_DROPABLE_CAT_ID:
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterDropable");
                  break;
               case ITEM_HARVESTABLE_CAT_ID:
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterHarvestable");
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("btn_itemType") != -1)
         {
            this.displayTypeTooltipText(target,this._componentList[target.name]);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         var btnData:Object = null;
         if(target.name.indexOf("tx_obtaining") != -1)
         {
            btnData = this._componentList[target.name];
            (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + btnData.iconGreyPath);
         }
         this.uiApi.hideTooltip("tooltip_standard");
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_minLevel && this.inp_minLevel.haveFocus)
         {
            this._levelTimer.reset();
            this._levelTimer.start();
            this._currentInputLevel = this.inp_minLevel;
         }
         else if(this.inp_maxLevel && this.inp_maxLevel.haveFocus)
         {
            this._levelTimer.reset();
            this._levelTimer.start();
            this._currentInputLevel = this.inp_maxLevel;
         }
         if(this.inp_search.haveFocus && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            this._lockSearchTimer.reset();
            this._lockSearchTimer.start();
         }
      }
      
      public function onTimeOut(e:TimerEvent) : void
      {
         if(!this.inp_search)
         {
            return;
         }
         if(this.inp_search.text.length > 1 && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            this._searchCriteria = this.inp_search.text.toLowerCase();
            this._currentScrollValue = 0;
            this.btn_resetSearch.visible = true;
            this.btn_resetFilters.disabled = false;
            this.lbl_resetFilters.cssClass = "greencenter";
            this.filterItems();
         }
         else
         {
            if(this._searchCriteria)
            {
               this._searchCriteria = null;
            }
            this.btn_resetSearch.visible = false;
            if(this.inp_search.text.length == 0)
            {
               this.filterItems();
            }
         }
      }
      
      protected function onLevelTimerComplete(e:TimerEvent) : void
      {
         this._levelTimer.reset();
         this.itemFilterApi.updateInputLevel(this._currentInputLevel);
         this._currentInputLevel = null;
      }
      
      public function onDisplayPinnedTooltip(uiName:String, objectGID:uint, objectUID:uint = 0) : void
      {
         var setting:String = null;
         if(uiName != this.uiApi.me().name)
         {
            return;
         }
         var settings:Object = {};
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:* = this.sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         settings["showEffects"] = true;
         settings.pinnable = true;
         this.uiApi.showTooltip(this.parseItem(objectGID).itemWrapper,new Rectangle(20,20,0,0),false,"standard",0,0,0,null,null,settings,null,true,4,1,"storage");
      }
   }
}
