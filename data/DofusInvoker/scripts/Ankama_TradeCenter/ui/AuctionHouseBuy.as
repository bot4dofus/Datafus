package Ankama_TradeCenter.ui
{
   import Ankama_TradeCenter.TradeCenter;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.AuctionHouseItemFilterApi;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AuctionHouseBuy extends Stock
   {
      
      private static const CTR_SEARCH:String = "ctr_searchBar";
      
      private static const CTR_FILTER_CAT:String = "ctr_filterCategory";
      
      private static const CTR_FILTER_ITEM:String = "ctr_filterItem";
      
      private static const CTR_ITEM_TYPE:String = "ctr_ItemType";
      
      private static const CTR_FILTER_LEVEL:String = "ctr_filterLevel";
      
      private static const CTR_ITEM:String = "ctr_item";
      
      private static const CTR_ITEM_DETAILS:String = "ctr_itemDetails";
      
      private static const CTR_ITEM_EMPTY:String = "ctr_itemEmpty";
      
      private static const EQUIPMENT_CATEGORY:uint = 1;
      
      private static const CONSUMABLE_CATEGORY:uint = 2;
      
      private static const RESOURCE_CATEGORY:uint = 3;
      
      private static const RUNE_CATEGORY:uint = 4;
      
      private static const SOUL_CATEGORY:uint = 5;
      
      private static const CREATURE_CATEGORY:uint = 6;
      
      private static const SORT_CACHE_NAME_PREFIX:String = "HV_BUY_SORTING_";
      
      private static const RELATION_MINI_FOR_WARNING_POPUP:Number = 1.5;
      
      private static const TYPE_ICON:Array = [null,"collar","weapon","ring","belt","shoe","consumable","shield",null,"resource","helmet","cape","pet","trophy",null,null,null,null,null,null,null,"pet","costume","companon","pet","costume",null,"pet"];
      
      private static var _self:AuctionHouseBuy;
       
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="AuctionHouseItemFilterApi")]
      public var itemFilterApi:AuctionHouseItemFilterApi;
      
      [Module(name="Ankama_TradeCenter")]
      public var modTradeCenter:TradeCenter;
      
      public var sellerDescriptor:Object;
      
      public var currentType:uint = 0;
      
      private var _componentList:Dictionary;
      
      private var _allItems:Dictionary;
      
      private var characsIdList:Vector.<uint>;
      
      private var _areRunesAssociatedWithWeapon:Boolean = false;
      
      private var _lastItemSelected:Object;
      
      private var _dataMatrixItems:Array;
      
      private var _lastItemDetails:Array;
      
      private var _lastItemDetailsId:uint;
      
      private var _currentInputLevel:Input;
      
      private var _levelTimer:BenchmarkTimer;
      
      private var _currentManualLevelValueMin:int = -1;
      
      private var _currentManualLevelValueMax:int = -1;
      
      private var _selectedItem:Object;
      
      private var _lastRequestTypeId:uint;
      
      private var _lastRequestTypeData:Array;
      
      private var _currentTypesRequested:Array;
      
      private var _sortCriteria:String = "name";
      
      private var _ascendingSort:Boolean = true;
      
      private var _specificSearchTimer:BenchmarkTimer;
      
      private var _specificSearchCriteria:String;
      
      private var INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT:String;
      
      private var displayingAllItems:Boolean = false;
      
      private var _currentObjectGID:uint;
      
      private var _currentSubArea:SubArea;
      
      private var _buyPopupName:String;
      
      private var _neededFollowedTypes:Dictionary;
      
      private var _followedTypes:Dictionary;
      
      private var _neededFollowedObjects:Dictionary;
      
      private var _followedObjects:Dictionary;
      
      private var _itemsToRefresh:Array;
      
      private var _searchAll:Boolean = false;
      
      private var currentRollOver:Object;
      
      private var currentRollOverDetails:Object;
      
      private var lastBuyItem:Object;
      
      private var _openedItemsDetails:Array;
      
      private var _openedItemDetailsToRemove:Object;
      
      private var _maxOpenedItem:uint = 3;
      
      private var _itemToBuy:Vector.<ItemWrapper>;
      
      private var _selectedBuyItem:Object;
      
      private var _selectInventory:Boolean = false;
      
      private var _canBuy:Boolean = true;
      
      public var gd_filters:Grid;
      
      public var gd_itemList:Grid;
      
      public var lbl_selectCategory:Label;
      
      public var lbl_resetFilters:Label;
      
      public var inp_minLevel:Input;
      
      public var inp_maxLevel:Input;
      
      public var btn_resetFilters:ButtonContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_resetSpecificSearch:ButtonContainer;
      
      public var inp_specificSearch:Input;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabCat:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabPrice:ButtonContainer;
      
      public var blk_filters:GraphicContainer;
      
      public var ctr_bgDark:GraphicContainer;
      
      public var btn_displayAllItems:ButtonContainer;
      
      public var btn_label_btn_displayAllItems:Label;
      
      public var tx_sortNameDown:Texture;
      
      public var tx_sortCatDown:Texture;
      
      public var tx_sortLevelDown:Texture;
      
      public var tx_sortPriceDown:Texture;
      
      public var tx_sortNameUp:Texture;
      
      public var tx_sortCatUp:Texture;
      
      public var tx_sortLevelUp:Texture;
      
      public var tx_sortPriceUp:Texture;
      
      public var lbl_tabPrice:Label;
      
      public var lbl_tabName:Label;
      
      public var lbl_tabLevel:Label;
      
      public var lbl_tabCat:Label;
      
      public function AuctionHouseBuy()
      {
         this._componentList = new Dictionary(true);
         this._allItems = new Dictionary(true);
         this.characsIdList = new Vector.<uint>();
         this._lastItemDetails = [];
         this._lastRequestTypeData = [];
         this._currentTypesRequested = [];
         this._neededFollowedTypes = new Dictionary(true);
         this._followedTypes = new Dictionary(true);
         this._neededFollowedObjects = new Dictionary(true);
         this._followedObjects = new Dictionary(true);
         this._itemsToRefresh = [];
         this._openedItemsDetails = [];
         this._itemToBuy = new Vector.<ItemWrapper>();
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         _self = this;
         this.sellerDescriptor = params.sellerBuyerDescriptor;
         this._currentSubArea = this.playerApi.currentSubArea();
         sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         sysApi.addHook(ExchangeHookList.BidObjectTypeListUpdate,this.onBidObjectTypeListUpdate);
         sysApi.addHook(ExchangeHookList.BidObjectListUpdate,this.onBidObjectListUpdate);
         sysApi.addHook(ExchangeHookList.BidHouseBuyResult,this.onBidHouseBuyResult);
         sysApi.addHook(InventoryHookList.ObjectModified,this.onSelectItemFromInventory);
         sysApi.addHook(ExchangeHookList.BidHouseSelectItemFromRecipe,this.onSelectItemFromRecipe);
         uiApi.addComponentHook(this.gd_filters,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.gd_itemList,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.gd_itemList,ComponentHookList.ON_ITEM_ROLL_OVER);
         uiApi.addComponentHook(this.gd_itemList,ComponentHookList.ON_ITEM_ROLL_OUT);
         uiApi.addComponentHook(this.btn_displayAllItems,ComponentHookList.ON_RELEASE);
         uiApi.addShortcutHook("validUi",this.onValidUi);
         this.lbl_tabName.fullWidth();
         this.lbl_tabCat.fullWidth();
         this.lbl_tabLevel.fullWidth();
         this.lbl_tabPrice.fullWidth();
         this.btn_displayAllItems.selected = !sysApi.getData("displayAllItemsAuctionHouse");
         this.displayingAllItems = !this.btn_displayAllItems.selected;
         INPUT_SEARCH_DEFAULT_TEXT = uiApi.getText("ui.bidhouse.searchInAuctionHouse");
         this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT = uiApi.getText("ui.search.soulStone");
         this._levelTimer = new BenchmarkTimer(700,1,"AuctionHouseBuy._levelTimer");
         this._levelTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLevelTimerComplete);
         this._neededFollowedTypes = new Dictionary(true);
         this._neededFollowedObjects = new Dictionary(true);
         TradeCenter.SEARCH_MODE = false;
         if(!_searchTimer)
         {
            _searchTimer = new BenchmarkTimer(500,1,"AuctionHouseBuy._searchTimer");
            _searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSearchTimerComplete);
         }
         if(!this._specificSearchTimer)
         {
            this._specificSearchTimer = new BenchmarkTimer(500,1,"AuctionHouseBuy._specificSearchTimer");
            this._specificSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSpecificSearchTimerComplete);
         }
         this._allItems = new Dictionary(true);
         if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_COLLAR) != -1)
         {
            this.currentType = EQUIPMENT_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.equipments").toLowerCase());
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRINK) != -1)
         {
            this.currentType = CONSUMABLE_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.consumables").toLowerCase());
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_WING) != -1)
         {
            this.currentType = RESOURCE_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.ressources").toLowerCase());
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE) != -1)
         {
            this.currentType = RUNE_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.objects").toLowerCase());
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_EMPTY_SOULSTONE) != -1)
         {
            this.currentType = SOUL_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.soulStones").toLowerCase());
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE) != -1)
         {
            this.currentType = CREATURE_CATEGORY;
            this.btn_label_btn_displayAllItems.text = uiApi.getText("ui.bidhouse.displayAvailable",uiApi.getText("ui.common.objects").toLowerCase());
         }
         var sortInfos:Object = sysApi.getData(SORT_CACHE_NAME_PREFIX + this.currentType,DataStoreEnum.BIND_ACCOUNT);
         if(sortInfos)
         {
            this._sortCriteria = sortInfos.sort;
            this._ascendingSort = sortInfos.ascending;
         }
         this.gd_itemList.selectWithArrows = false;
         this.itemFilterApi.setMaxLevel(this.sellerDescriptor.maxItemLevel);
         this.itemFilterApi.initFilters(this.currentType,this.playerApi.getPlayedCharacterInfo(),this.setCurrentTypeInfos(),sysApi.getData("openedFilterCat"),this.gd_filters,this.gd_itemList,this.sellerDescriptor.types);
         this.btn_resetFilters.disabled = true;
         this.lbl_resetFilters.cssClass = "lightgreycenter";
         if(this.currentType == SOUL_CATEGORY)
         {
            this._maxOpenedItem = 1;
         }
         this.reloadFilters();
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == uiApi.me().name)
         {
            this.updateBgFilter();
         }
      }
      
      public function onUiUnloaded(uiName:String) : void
      {
         if(uiName == this._buyPopupName)
         {
            this._buyPopupName = null;
         }
      }
      
      override public function unload() : void
      {
         _self = null;
         sysApi.setData(SORT_CACHE_NAME_PREFIX + this.currentType,{
            "sort":this._sortCriteria,
            "ascending":this._ascendingSort
         },DataStoreEnum.BIND_ACCOUNT);
         if(uiApi.getUi(this._buyPopupName))
         {
            uiApi.unloadUi(this._buyPopupName);
            this._buyPopupName = null;
         }
         if(_searchTimer)
         {
            _searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSearchTimerComplete);
            _searchTimer = null;
         }
         if(this._levelTimer)
         {
            this._levelTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onLevelTimerComplete);
            this._levelTimer = null;
         }
         if(this._specificSearchTimer)
         {
            this._specificSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSpecificSearchTimerComplete);
            this._specificSearchTimer = null;
         }
         TradeCenter.getInstance().filtersCache[this.currentType] = {
            "filteredIds":this.itemFilterApi.currentFilteredIds(),
            "weaponEffectIds":this.itemFilterApi.currentWeaponEffectIds(),
            "consumableEffectIds":this.itemFilterApi.currentConsumableEffectIds(),
            "subIds":this.itemFilterApi.currentSubIds(),
            "skinTargetIds":this.itemFilterApi.currentSkinTargetIds(),
            "characIds":this.itemFilterApi.currentCharacIds(),
            "minLevel":this.itemFilterApi.getMinLevelInputValue(),
            "minLevelManual":this._currentManualLevelValueMin,
            "maxLevel":this.itemFilterApi.getMaxLevelInputValue(),
            "maxLevelManual":this._currentManualLevelValueMax,
            "openedCat":this.itemFilterApi.getOpenedCategories()
         };
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getCatLineType(data,line))
         {
            case CTR_SEARCH:
               inp_search = componentsRef.inp_search;
               this.btn_resetSearch = componentsRef.btn_resetSearch;
               if(_searchCriteria)
               {
                  this.btn_resetSearch.visible = true;
                  inp_search.text = _searchCriteria;
               }
               else if(!_searchCriteria && !inp_search.haveFocus || inp_search.text == INPUT_SEARCH_DEFAULT_TEXT)
               {
                  inp_search.placeholderText = INPUT_SEARCH_DEFAULT_TEXT;
                  this.btn_resetSearch.visible = false;
               }
               break;
            case CTR_FILTER_CAT:
               componentsRef.lbl_catName.text = data.name.replace(" / ","/");
               componentsRef.btn_cat.selected = selected;
               if(this.itemFilterApi.getOpenedCategories().indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               break;
            case CTR_FILTER_ITEM:
               if(!this._componentList[componentsRef.btn_selectFilter.name])
               {
                  uiApi.addComponentHook(componentsRef.btn_selectFilter,ComponentHookList.ON_RELEASE);
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
                     componentsRef.tx_picto.uri = uiApi.createUri(uiApi.me().getConstant("picto_uri") + data.gfxId);
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
               if(this.sellerDescriptor.maxItemLevel < 200)
               {
                  componentsRef.tx_helpLevel.visible = true;
                  if(!this._componentList[componentsRef.tx_helpLevel.name])
                  {
                     uiApi.addComponentHook(componentsRef.tx_helpLevel,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.tx_helpLevel,ComponentHookList.ON_ROLL_OUT);
                  }
                  this._componentList[componentsRef.tx_helpLevel.name] = data;
               }
               else
               {
                  componentsRef.tx_helpLevel.visible = false;
               }
               this.inp_minLevel = componentsRef.inp_minLevel;
               this.inp_maxLevel = componentsRef.inp_maxLevel;
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
               uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_RELEASE);
               uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.btn_itemType,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[componentsRef.btn_itemType.name] = data;
            if(TYPE_ICON[data])
            {
               componentsRef.iconTexturebtn_itemType.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "slot/icon_slot_" + TYPE_ICON[data] + "_inventory.png");
            }
            else
            {
               componentsRef.iconTexturebtn_itemType.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "slot/emptySlot.png");
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
      
      public function updateItem(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var averagePrice:Number = NaN;
         switch(this.getItemLineType(data,line))
         {
            case CTR_ITEM:
               if(data)
               {
                  if(!this._componentList[componentsRef.tx_itemBg.name])
                  {
                     uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
                     uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_RIGHT_CLICK);
                  }
                  if(!this._componentList[componentsRef.tx_itemIcon.name])
                  {
                     uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
                     uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_RIGHT_CLICK);
                  }
                  if(!this._componentList[componentsRef.btn_gridItem.name])
                  {
                     uiApi.addComponentHook(componentsRef.btn_gridItem,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.btn_gridItem,ComponentHookList.ON_ROLL_OUT);
                  }
                  if(!this._componentList[componentsRef.lbl_name])
                  {
                     uiApi.addComponentHook(componentsRef.lbl_name,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.lbl_name,ComponentHookList.ON_ROLL_OUT);
                  }
                  this._componentList[componentsRef.btn_gridItem.name] = data;
                  this._componentList[componentsRef.tx_itemBg.name] = data;
                  this._componentList[componentsRef.tx_itemIcon.name] = data;
                  this._componentList[componentsRef.lbl_name] = data;
                  if(data.itemWrapper.itemSetId != -1)
                  {
                     componentsRef.lbl_name.cssClass = "orangeleftlight";
                     componentsRef.lbl_name.text = "{HDVItem," + data.itemWrapper.id + "::" + data.itemWrapper.name + "}";
                     if(!data.available)
                     {
                        componentsRef.lbl_name.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
                     }
                     else
                     {
                        componentsRef.lbl_name.transform.colorTransform = new ColorTransform(1,1,1,1);
                     }
                  }
                  else
                  {
                     componentsRef.lbl_name.cssClass = "greenleftlight";
                     componentsRef.lbl_name.text = "{HDVItem," + data.itemWrapper.id + "::" + data.itemWrapper.name + "}";
                     if(!data.available)
                     {
                        componentsRef.lbl_name.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
                     }
                     else
                     {
                        componentsRef.lbl_name.transform.colorTransform = new ColorTransform(1,1,1,1);
                     }
                  }
                  componentsRef.btn_gridItem.handCursor = false;
                  componentsRef.tx_itemBg.visible = true;
                  componentsRef.tx_itemIcon.uri = data.itemWrapper.iconUri;
                  componentsRef.lbl_cat.text = data.itemWrapper.type.name;
                  componentsRef.lbl_level.text = data.itemWrapper.level;
                  averagePrice = data.averagePrice;
                  if(averagePrice <= 0)
                  {
                     componentsRef.lbl_averagePrice.text = "--------";
                     componentsRef.iconKama.visible = false;
                  }
                  else
                  {
                     componentsRef.lbl_averagePrice.text = utilApi.kamasToString(averagePrice,"");
                     componentsRef.iconKama.visible = true;
                  }
               }
               else
               {
                  componentsRef.ctr_item.softDisabled = false;
                  componentsRef.lbl_name.softDisabled = false;
                  componentsRef.tx_itemBg.visible = false;
                  componentsRef.tx_itemIcon.uri = null;
                  componentsRef.lbl_name.text = "";
                  componentsRef.lbl_cat.text = "";
                  componentsRef.lbl_level.text = "";
                  componentsRef.lbl_averagePrice.text = "";
                  componentsRef.iconKama.visible = false;
               }
               componentsRef.btn_gridItem.selected = selected;
               break;
            case CTR_ITEM_DETAILS:
               if(data)
               {
                  if(!this._componentList[componentsRef.btn_buy.name])
                  {
                     uiApi.addComponentHook(componentsRef.btn_buy,ComponentHookList.ON_ROLL_OVER);
                     uiApi.addComponentHook(componentsRef.btn_buy,ComponentHookList.ON_ROLL_OUT);
                  }
                  this._componentList[componentsRef.btn_buy.name] = data;
                  if(data.hasOwnProperty("searchInput"))
                  {
                     componentsRef.ctr_specificSearch.visible = true;
                     if(!this._specificSearchCriteria)
                     {
                        componentsRef.inp_search.text = "";
                     }
                     this.inp_specificSearch = componentsRef.inp_search;
                     this.btn_resetSpecificSearch = componentsRef.btn_resetSpecificSearch;
                     if(this._specificSearchCriteria)
                     {
                        this.btn_resetSpecificSearch.visible = true;
                        this.inp_specificSearch.text = this._specificSearchCriteria;
                     }
                     else if(!this._specificSearchCriteria && this.inp_specificSearch.text == "" && !this.inp_specificSearch.haveFocus || this.inp_specificSearch.text == this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT)
                     {
                        this.inp_specificSearch.placeholderText = this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT;
                        this.btn_resetSpecificSearch.visible = false;
                     }
                     componentsRef.tx_itemBgDetails.visible = false;
                     componentsRef.tx_itemIconDetails.uri = null;
                     componentsRef.lbl_itemDetailedName.text = "";
                     componentsRef.lbl_price.text = "";
                     componentsRef.lbl_stack.text = "";
                     componentsRef.lbl_loot.text = "";
                     componentsRef.iconKamaDetails.visible = false;
                     componentsRef.btn_buy.visible = false;
                  }
                  else
                  {
                     if(!this._componentList[componentsRef.btn_gridItemDetails.name])
                     {
                        uiApi.addComponentHook(componentsRef.btn_gridItemDetails,ComponentHookList.ON_ROLL_OVER);
                        uiApi.addComponentHook(componentsRef.btn_gridItemDetails,ComponentHookList.ON_ROLL_OUT);
                        uiApi.addComponentHook(componentsRef.btn_gridItemDetails,ComponentHookList.ON_RIGHT_CLICK);
                     }
                     if(!this._componentList[componentsRef.ctr_empty.name])
                     {
                        uiApi.addComponentHook(componentsRef.ctr_empty,ComponentHookList.ON_ROLL_OVER);
                        uiApi.addComponentHook(componentsRef.ctr_empty,ComponentHookList.ON_ROLL_OUT);
                     }
                     if(!this._componentList[componentsRef.btn_moveToGlobalItemArrow.name])
                     {
                        uiApi.addComponentHook(componentsRef.btn_moveToGlobalItemArrow,ComponentHookList.ON_ROLL_OVER);
                        uiApi.addComponentHook(componentsRef.btn_moveToGlobalItemArrow,ComponentHookList.ON_ROLL_OUT);
                     }
                     this._componentList[componentsRef.btn_moveToGlobalItemArrow.name] = data;
                     this._componentList[componentsRef.btn_gridItemDetails.name] = {
                        "data":data,
                        "arrow":componentsRef.btn_moveToGlobalItemArrow
                     };
                     this._componentList[componentsRef.ctr_empty.name] = data;
                     componentsRef.btn_gridItemDetails.handCursor = false;
                     componentsRef.ctr_empty.handCursor = false;
                     componentsRef.ctr_specificSearch.visible = false;
                     componentsRef.tx_itemBgDetails.visible = true;
                     componentsRef.tx_itemIconDetails.uri = data.itemWrapper.iconUri;
                     componentsRef.lbl_price.text = utilApi.kamasToString(data.prices,"");
                     componentsRef.lbl_itemDetailedName.text = data.itemWrapper.shortName;
                     if(data.size != -1)
                     {
                        componentsRef.lbl_stack.text = "";
                        componentsRef.lbl_loot.text = uiApi.getText("ui.bidhouse.loot",data.size);
                     }
                     else
                     {
                        componentsRef.lbl_stack.text = uiApi.getText("ui.bidhouse.stack",data.stack);
                        componentsRef.lbl_loot.text = "";
                     }
                     componentsRef.iconKamaDetails.visible = true;
                     componentsRef.btn_buy.visible = true;
                     componentsRef.btn_buy.disabled = this.playerApi.hasDebt();
                  }
               }
               else
               {
                  componentsRef.tx_itemBgDetails.visible = false;
                  componentsRef.tx_itemIconDetails.uri = null;
                  componentsRef.lbl_price.text = "";
                  componentsRef.lbl_stack.text = "";
                  componentsRef.iconKamaDetails.visible = false;
                  componentsRef.btn_buy.visible = false;
               }
               componentsRef.btn_gridItemDetails.selected = selected;
               componentsRef.btn_gridItemDetails.visible = data && !data.hasOwnProperty("searchInput");
               break;
            case CTR_ITEM_EMPTY:
               if(!data.itemWrapper)
               {
                  componentsRef.lbl_itemEmpty.text = uiApi.getText("ui.common.noSearchResult");
                  break;
               }
               if(this.sellerDescriptor.maxItemLevel < data.itemWrapper.level)
               {
                  componentsRef.lbl_itemEmpty.text = uiApi.getText("ui.bidhouse.maximumLevelWarn",this.sellerDescriptor.maxItemLevel);
               }
               else
               {
                  componentsRef.lbl_itemEmpty.text = uiApi.getText("ui.bidhouse.currentlyNotAvailable");
               }
               break;
         }
      }
      
      public function getItemLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(!data.isItemDetails)
         {
            return CTR_ITEM;
         }
         if(data.hasOwnProperty("empty"))
         {
            return CTR_ITEM_EMPTY;
         }
         return CTR_ITEM_DETAILS;
      }
      
      public function resetFilters() : void
      {
         this._allItems = new Dictionary(true);
         this.characsIdList = new Vector.<uint>();
         this._areRunesAssociatedWithWeapon = false;
      }
      
      public function updateBgFilter() : void
      {
         this.ctr_bgDark.height = Math.max(30,this.blk_filters.height - this.gd_filters.dataProvider.length * this.gd_filters.slotHeight - 25 + (16 - this.gd_filters.dataProvider.length));
         this.ctr_bgDark.y = this.blk_filters.y + this.blk_filters.height - this.ctr_bgDark.height - 70;
      }
      
      public function addTypeFilterId(typeId:int = -1, addAllSubTypes:Boolean = false) : void
      {
         var typeIdToAdd:uint = 0;
         var currentSuperTypeId:uint = 0;
         var typeIdToRemove:uint = 0;
         var index:int = this.itemFilterApi.currentFilteredIds().indexOf(typeId);
         if(typeId > 0)
         {
            if(index == -1)
            {
               for each(typeIdToAdd in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
               {
                  this.itemFilterApi.currentFilteredIds().push(typeIdToAdd);
               }
               if(addAllSubTypes)
               {
                  for each(currentSuperTypeId in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
                  {
                     this.addAllSubFilterIds(currentSuperTypeId);
                  }
               }
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
               }
               if(this.currentType == EQUIPMENT_CATEGORY && this.itemFilterApi.currentFilteredIds().length <= 0)
               {
                  this.itemFilterApi.currentWeaponEffectIds().splice(0,this.itemFilterApi.currentWeaponEffectIds().length);
                  this.itemFilterApi.currentConsumableEffectIds().splice(0,this.itemFilterApi.currentConsumableEffectIds().length);
                  this.itemFilterApi.currentCharacIds().splice(0,this.itemFilterApi.currentCharacIds().length);
               }
               if(this.currentType == EQUIPMENT_CATEGORY && typeId == DataEnum.ITEM_SUPERTYPE_COSTUME)
               {
                  this.itemFilterApi.currentSkinTargetIds().splice(0,this.itemFilterApi.currentSkinTargetIds().length);
               }
               this.filterItems();
            }
         }
         this.itemFilterApi.dataInit();
         this.itemFilterApi.displayCategories();
      }
      
      public function filterItems() : void
      {
         var tmpAllItems:Array = null;
         var tmpIds:Array = null;
         var key:* = undefined;
         var i:uint = 0;
         var currentKey:* = undefined;
         var ids:Array = this.itemFilterApi.filterItems(_searchCriteria);
         if(this.displayingAllItems)
         {
            this.updateItemList(ids);
         }
         else
         {
            tmpAllItems = [];
            tmpIds = [];
            if(this.itemFilterApi.currentFilteredIds().length > 0 || this.itemFilterApi.currentSubIds().length > 0 || this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0 || _searchCriteria)
            {
               for(key in this._allItems)
               {
                  tmpAllItems = tmpAllItems.concat(this._allItems[key]);
               }
               for(i = 0; i < tmpAllItems.length; i++)
               {
                  if(ids.indexOf(tmpAllItems[i].itemWrapper.objectGID) != -1)
                  {
                     tmpIds.push(tmpAllItems[i]);
                  }
                  if(tmpIds.length == ids.length)
                  {
                     break;
                  }
               }
            }
            else
            {
               for(currentKey in this._allItems)
               {
                  this._allItems[currentKey] = [];
               }
            }
            this._dataMatrixItems = this.sortItemList(tmpIds,this._sortCriteria);
            this.displayItemDetails(this._lastItemSelected,this._dataMatrixItems);
         }
      }
      
      private function reloadFilters() : void
      {
         var id:uint = 0;
         var reloadInfos:Object = TradeCenter.getInstance().filtersCache[this.currentType];
         if(!reloadInfos)
         {
            return;
         }
         var filteredIds:Array = reloadInfos.filteredIds;
         this.initFilterTabs(reloadInfos);
         this._currentManualLevelValueMin = reloadInfos.minLevelManual;
         this._currentManualLevelValueMax = reloadInfos.maxLevelManual;
         this.inp_minLevel.text = reloadInfos.minLevelManual > 0 ? reloadInfos.minLevelManual : reloadInfos.minLevel;
         this.inp_maxLevel.text = reloadInfos.maxLevelManual > 0 ? reloadInfos.maxLevelManual : this.sellerDescriptor.maxItemLevel;
         this.itemFilterApi.updateInputLevel(this.inp_maxLevel);
         this.itemFilterApi.updateInputLevel(this.inp_minLevel);
         this.itemFilterApi.setOpenedCategories(reloadInfos.openedCat);
         for each(id in filteredIds)
         {
            if(this.itemFilterApi.currentFilteredIds().indexOf(id) == -1)
            {
               this.addTypeFilterId(id,this.currentType != EQUIPMENT_CATEGORY ? false : !this.itemFilterApi.checkSubFilters(id));
            }
            if(this.currentType == SOUL_CATEGORY || this.currentType == CREATURE_CATEGORY)
            {
               break;
            }
         }
         for each(id in this.itemFilterApi.currentSubIds())
         {
            this.addFollowedType(id,true);
         }
         if(this.itemFilterApi.currentFilteredIds().length > 0 || this.itemFilterApi.currentSubIds().length > 0 || this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0 || _searchCriteria || this.itemFilterApi.getMinLevelInputValue() != 1 || this.itemFilterApi.getMaxLevelInputValue() != 200)
         {
            this.filterItems();
         }
         this.itemFilterApi.displayCategories();
         this.updateResetFilterButton();
      }
      
      private function initFilterTabs(reloadInfos:Object) : void
      {
         var weaponEffectIds:Array = reloadInfos.weaponEffectIds;
         var consumableIds:Array = reloadInfos.consumableEffectIds;
         var subIds:Array = reloadInfos.subIds;
         var skinTargetIds:Array = reloadInfos.skinTargetIds;
         var characIds:Array = reloadInfos.characIds;
         var maxIndex:int = Math.max(weaponEffectIds.length,consumableIds.length,subIds.length,skinTargetIds.length,characIds.length);
         var i:int = 0;
         while(i < maxIndex)
         {
            if(weaponEffectIds.length > i)
            {
               this.itemFilterApi.currentWeaponEffectIds()[i] = weaponEffectIds[i];
            }
            if(subIds.length > i)
            {
               this.itemFilterApi.currentSubIds()[i] = subIds[i];
            }
            if(characIds.length > i)
            {
               this.itemFilterApi.currentCharacIds()[i] = characIds[i];
            }
            if(consumableIds.length > i)
            {
               this.itemFilterApi.currentConsumableEffectIds()[i] = consumableIds[i];
            }
            if(skinTargetIds.length > i)
            {
               this.itemFilterApi.currentSkinTargetIds()[i] = skinTargetIds[i];
            }
            i++;
         }
      }
      
      private function setCurrentTypeInfos() : Dictionary
      {
         var itemType:ItemType = null;
         var typeId:uint = 0;
         var superTypeId:uint = 0;
         var allTypes:Dictionary = new Dictionary(true);
         for each(typeId in this.sellerDescriptor.types)
         {
            itemType = dataApi.getItemType(typeId);
            superTypeId = itemType.superTypeId;
            if(superTypeId == DataEnum.ITEM_SUPERTYPE_CERTIFICATE || typeId == DataEnum.ITEM_TYPE_LIVING_OBJECT)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_PET])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_PET] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_PET].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_PET].push(superTypeId);
               }
            }
            else if(superTypeId == DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT].push(superTypeId);
               }
            }
            else if(typeId == DataEnum.ITEM_TYPE_CATCHING_NET)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS].push(superTypeId);
               }
            }
            else if(superTypeId == DataEnum.ITEM_SUPERTYPE_PET_GHOST || typeId == DataEnum.ITEM_TYPE_RECEIPT)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_PET_GHOST])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_PET_GHOST] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_PET_GHOST].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_PET_GHOST].push(superTypeId);
               }
            }
            else if(typeId == DataEnum.ITEM_TYPE_PET_POTION || typeId == DataEnum.ITEM_TYPE_PETSMOUNT_POTION || typeId == DataEnum.ITEM_TYPE_MOUNT_POTION || typeId == DataEnum.ITEM_TYPE_PET_EGG || typeId == DataEnum.ITEM_TYPE_BREEDING_ITEM)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE].push(superTypeId);
               }
            }
            else if(typeId == DataEnum.ITEM_TYPE_CEREMONIAL_ITEMS)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_COSTUME])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_COSTUME] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_COSTUME].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_COSTUME].push(superTypeId);
               }
            }
            else if(typeId == DataEnum.ITEM_TYPE_SOULSTONE || typeId == DataEnum.ITEM_TYPE_EMPTY_SOULSTONE)
            {
               if(!allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE])
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE] = [];
               }
               if(allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE].indexOf(superTypeId) == -1)
               {
                  allTypes[DataEnum.ITEM_SUPERTYPE_CONSUMABLE].push(superTypeId);
               }
            }
            else
            {
               if(!allTypes[superTypeId])
               {
                  allTypes[superTypeId] = [];
               }
               if(allTypes[superTypeId].indexOf(superTypeId) == -1)
               {
                  allTypes[superTypeId].push(superTypeId);
               }
            }
         }
         return allTypes;
      }
      
      private function addFollowedType(typeId:uint, follow:Boolean) : void
      {
         if(follow)
         {
            if(!this._neededFollowedTypes[typeId])
            {
               this._neededFollowedTypes[typeId] = follow;
               this.clearOpenedItemsDetails();
               if(this._currentTypesRequested.indexOf(typeId) == -1)
               {
                  this._currentTypesRequested.push(typeId);
               }
               sysApi.sendAction(new ExchangeBidHouseTypeAction([typeId,follow]));
            }
         }
         else if(this._neededFollowedTypes[typeId])
         {
            this._neededFollowedTypes[typeId] = follow;
            this._followedTypes[typeId] = false;
            this.clearOpenedItemsDetails();
            sysApi.sendAction(new ExchangeBidHouseTypeAction([typeId,follow]));
         }
      }
      
      private function addAllSubFilterIds(superTypeId:uint) : void
      {
         var typeId:uint = 0;
         var ids:Vector.<uint> = dataApi.queryEquals(ItemType,"superTypeId",superTypeId);
         for each(typeId in ids)
         {
            if(this.sellerDescriptor.types.indexOf(typeId) != -1)
            {
               this._allItems[typeId] = [];
               this._lastRequestTypeId = typeId;
               this.addFollowedType(typeId,true);
            }
         }
      }
      
      private function removeAllSubFilterIds(superTypeId:uint) : void
      {
         var typeId:uint = 0;
         var ids:Object = dataApi.queryEquals(ItemType,"superTypeId",superTypeId);
         if(this.itemFilterApi.subFilteredTypes().indexOf(superTypeId) != -1)
         {
            this.itemFilterApi.subFilteredTypes().splice(this.itemFilterApi.subFilteredTypes().indexOf(superTypeId),1);
         }
         for each(typeId in ids)
         {
            this._allItems[typeId] = [];
            this.addFollowedType(typeId,false);
            if(this.itemFilterApi.currentSubIds().indexOf(typeId) != -1)
            {
               this.itemFilterApi.currentSubIds().splice(this.itemFilterApi.currentSubIds().indexOf(typeId),1);
            }
         }
         this.filterItems();
      }
      
      private function addSubTypeFilterId(typeId:int = -1) : void
      {
         var timer:uint = 0;
         var superTypeIdToAdd:uint = 0;
         var subTypeId:uint = 0;
         var superTypeIdToRemove:uint = 0;
         var indexHDVType:int = this.sellerDescriptor.types.indexOf(typeId);
         if(indexHDVType == -1)
         {
            return;
         }
         var index:int = this.itemFilterApi.currentSubIds().indexOf(typeId);
         var itemType:ItemType = dataApi.getItemType(typeId);
         if(typeId > 0)
         {
            if(index == -1)
            {
               timer = getTimer();
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
               for each(subTypeId in dataApi.queryEquals(ItemType,"superTypeId",itemType.superTypeId))
               {
                  if(this.itemFilterApi.currentSubIds().indexOf(subTypeId) == -1)
                  {
                     this._allItems[subTypeId] = [];
                     this.addFollowedType(subTypeId,false);
                  }
               }
               this._lastRequestTypeId = typeId;
               this.addFollowedType(typeId,true);
               sysApi.log(1,"add subtype : " + (getTimer() - timer));
            }
            else
            {
               this.itemFilterApi.currentSubIds().splice(index,1);
               this._allItems[typeId] = [];
               this.addFollowedType(typeId,false);
               for each(superTypeIdToRemove in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(itemType.superTypeId)])
               {
                  if(!this.itemFilterApi.checkSubFilters(superTypeIdToRemove))
                  {
                     this._allItems[superTypeIdToRemove] = [];
                     if(this.itemFilterApi.subFilteredTypes().indexOf(superTypeIdToRemove) != -1)
                     {
                        this.itemFilterApi.subFilteredTypes().splice(this.itemFilterApi.subFilteredTypes().indexOf(superTypeIdToRemove),1);
                     }
                     if(superTypeIdToRemove == DataEnum.ITEM_SUPERTYPE_CONSUMABLE || superTypeIdToRemove == DataEnum.ITEM_SUPERTYPE_RESOURCES || this.currentType == SOUL_CATEGORY || this.currentType == CREATURE_CATEGORY)
                     {
                        if(this.itemFilterApi.currentFilteredIds().indexOf(superTypeIdToRemove) != -1)
                        {
                           this.itemFilterApi.currentFilteredIds().splice(this.itemFilterApi.currentFilteredIds().indexOf(superTypeIdToRemove),1);
                        }
                        if(this.itemFilterApi.currentFilteredIds().length <= 0 && (this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0))
                        {
                           this.filterItems();
                        }
                     }
                     else if(!this.containAssociateTypes(superTypeIdToRemove) || !this.containAssociateSubTypes(superTypeIdToRemove))
                     {
                        this.addAllSubFilterIds(superTypeIdToRemove);
                     }
                     else
                     {
                        this.removeAllSubFilterIds(superTypeIdToRemove);
                     }
                  }
               }
               if(this.currentType == EQUIPMENT_CATEGORY && this.itemFilterApi.currentFilteredIds().length <= 0)
               {
                  this.itemFilterApi.currentWeaponEffectIds().splice(0,this.itemFilterApi.currentWeaponEffectIds().length);
                  this.itemFilterApi.currentConsumableEffectIds().splice(0,this.itemFilterApi.currentWeaponEffectIds().length);
                  this.itemFilterApi.currentCharacIds().splice(0,this.itemFilterApi.currentWeaponEffectIds().length);
               }
               if(this.currentType == CREATURE_CATEGORY && this.itemFilterApi.currentSubIds().indexOf(DataEnum.ITEM_TYPE_BREEDING_ITEM) == -1)
               {
                  this.itemFilterApi.currentBreedingItemEffectIds().splice(0,this.itemFilterApi.currentBreedingItemEffectIds().length);
               }
            }
            this.filterItems();
         }
         this.itemFilterApi.dataInit();
         this.itemFilterApi.displayCategories();
      }
      
      private function containAssociateTypes(typeId:uint) : Boolean
      {
         var id:uint = 0;
         for each(id in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
         {
            if(this.itemFilterApi.currentFilteredIds().indexOf(id) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function containAssociateSubTypes(typeId:uint) : Boolean
      {
         var id:uint = 0;
         for each(id in this.itemFilterApi.getCurrentTypeInfos()[this.itemFilterApi.getCurrentTypeInfosKeyByValue(typeId)])
         {
            if(this.itemFilterApi.checkSubFilters(id))
            {
               return true;
            }
         }
         return false;
      }
      
      private function displayItemDetails(selectedItem:Object, itemList:Array) : void
      {
         var myIndex:int = 0;
         var myIndexDetails:int = 0;
         var entry:Object = null;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         var selectedGid:int = -1;
         var selectedUid:int = -1;
         this._openedItemDetailsToRemove = null;
         if(selectedItem)
         {
            if(!selectedItem.isItemDetails)
            {
               selectedGid = selectedItem.itemWrapper.objectGID;
            }
            else
            {
               selectedUid = selectedItem.itemWrapper.objectUID;
            }
            selecCatId = selectedItem.itemWrapper.objectGID;
         }
         var index:int = -1;
         var tempCats:Array = [];
         for each(entry in itemList)
         {
            if(!entry.isItemDetails)
            {
               tempCats.push(entry);
               index++;
               if(entry.itemWrapper.objectGID == selectedGid)
               {
                  myIndex = index;
               }
            }
            if(entry.isItemDetails && entry.itemWrapper)
            {
               tempCats.push(entry);
               index++;
               if(entry.itemWrapper.objectUID == selectedUid)
               {
                  myIndexDetails = index;
               }
            }
            else if(entry.isItemDetails && entry.hasOwnProperty("empty"))
            {
               tempCats.push(entry);
               index++;
            }
            else if(entry.isItemDetails && entry.searchInput)
            {
               tempCats.push(entry);
               index++;
            }
         }
         scrollValue = this.gd_itemList.verticalScrollValue;
         this.gd_itemList.dataProvider = tempCats;
         if(this.gd_itemList.dataProvider.length > 0)
         {
            this.gd_itemList.visible = true;
            this.lbl_selectCategory.visible = !this.gd_itemList.visible;
         }
         else
         {
            this.gd_itemList.visible = false;
            this.lbl_selectCategory.visible = !this.gd_itemList.visible;
            if(this.itemFilterApi.currentFilteredIds().length <= 0 && this.itemFilterApi.currentCharacIds().length <= 0 && this.itemFilterApi.currentWeaponEffectIds().length <= 0 && this.itemFilterApi.currentConsumableEffectIds().length <= 0 && !TradeCenter.SEARCH_MODE && !this._selectInventory)
            {
               if(this.currentType == CONSUMABLE_CATEGORY)
               {
                  this.lbl_selectCategory.text = uiApi.getText("ui.common.selectCategoryOrEffect");
               }
               else
               {
                  this.lbl_selectCategory.text = uiApi.getText("ui.common.selectCategory");
               }
            }
            else
            {
               this.lbl_selectCategory.text = uiApi.getText("ui.common.noSearchResult");
            }
         }
         this.gd_itemList.verticalScrollValue = scrollValue;
         if(this._selectedBuyItem && this._selectedBuyItem.gridSize == tempCats.length)
         {
            this.gd_itemList.silent = true;
            this.gd_itemList.selectedIndex = this._selectedBuyItem.index;
            this.gd_itemList.silent = false;
            this._selectedBuyItem = null;
         }
         else if(this.gd_itemList.selectedIndex != myIndex && selectedGid != -1 && selectedItem != null)
         {
            this.gd_itemList.silent = true;
            this.gd_itemList.selectedIndex = myIndex;
            this.gd_itemList.silent = false;
         }
         else if(this.gd_itemList.selectedIndex != myIndexDetails && selectedUid != -1 && myIndexDetails != 0 && selectedItem != null)
         {
            this.gd_itemList.silent = true;
            this.gd_itemList.selectedIndex = myIndexDetails;
            this.gd_itemList.silent = false;
         }
      }
      
      private function updateItemList(objectIds:Array) : void
      {
         var item:uint = 0;
         var key:* = undefined;
         var i:uint = 0;
         var itemWrapper:ItemWrapper = null;
         var tmpSuperTypeId:uint = 0;
         var itemAvailable:Boolean = false;
         var _allItemsSearch:Dictionary = new Dictionary(true);
         var tmpAllItems:Array = [];
         var tmpIds:Array = [];
         if(this._selectInventory || TradeCenter.SEARCH_MODE || this.itemFilterApi.currentFilteredIds().length > 0 || this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0)
         {
            for each(item in objectIds)
            {
               itemWrapper = dataApi.getItemWrapper(item);
               if(itemWrapper)
               {
                  tmpSuperTypeId = dataApi.getItemType(itemWrapper.typeId).superTypeId;
                  if(this.itemFilterApi.currentFilteredIds().indexOf(tmpSuperTypeId) != -1 && !this.itemFilterApi.checkSubFilters(tmpSuperTypeId) && !this.containAssociateSubTypes(tmpSuperTypeId) || this.itemFilterApi.currentSubIds().indexOf(itemWrapper.typeId) != -1 || this.itemFilterApi.currentFilteredIds().length <= 0)
                  {
                     if(!_allItemsSearch[itemWrapper.typeId])
                     {
                        _allItemsSearch[itemWrapper.typeId] = [];
                     }
                     this._currentObjectGID = itemWrapper.objectGID;
                     itemAvailable = this._allItems[itemWrapper.typeId] && this._allItems[itemWrapper.typeId].some(this.isAvailable);
                     this._currentObjectGID = 0;
                     _allItemsSearch[itemWrapper.typeId].push({
                        "isItemDetails":false,
                        "itemWrapper":itemWrapper,
                        "averagePrice":this.averagePricesApi.getItemAveragePrice(itemWrapper.id),
                        "available":itemAvailable
                     });
                  }
               }
            }
            for(key in _allItemsSearch)
            {
               tmpAllItems = tmpAllItems.concat(_allItemsSearch[key]);
            }
            for(i = 0; i < tmpAllItems.length; i++)
            {
               if(this.sellerDescriptor.types.indexOf(tmpAllItems[i].itemWrapper.typeId) != -1)
               {
                  tmpIds.push(tmpAllItems[i]);
               }
            }
         }
         this._dataMatrixItems = [];
         this._dataMatrixItems = this.sortItemList(tmpIds,this._sortCriteria);
         this.displayItemDetails(null,this._dataMatrixItems);
      }
      
      private function isAvailable(element:*, index:int, arr:Array) : Boolean
      {
         return element.itemWrapper.objectGID == this._currentObjectGID;
      }
      
      private function updateItemListWithSpecificSearchCriteria(specificSearchCriteria:String) : void
      {
         var tmpDataProvider:Array = this._dataMatrixItems.concat();
         var index:int = tmpDataProvider.indexOf(this._lastItemSelected);
         var itemsWithCriteria:Array = this.specificSearchName(specificSearchCriteria);
         if(itemsWithCriteria.length <= 1 && specificSearchCriteria)
         {
            itemsWithCriteria.push({
               "isItemDetails":true,
               "empty":true,
               "itemWrapper":null
            });
         }
         else if(!specificSearchCriteria)
         {
            itemsWithCriteria = this._lastItemDetails;
         }
         for(var k:uint = 0; k < itemsWithCriteria.length; k++)
         {
            tmpDataProvider.splice(index + k + 1,0,itemsWithCriteria[k]);
         }
         this.displayItemDetails(null,tmpDataProvider);
      }
      
      private function specificSearchName(specificSearchCriteria:String) : Array
      {
         var item:Object = null;
         var effect:EffectInstance = null;
         var monster:Monster = null;
         var itemsWithCriteria:Array = [];
         for each(item in this._lastItemDetails)
         {
            if(item.searchInput || utilApi.noAccent(item.itemWrapper.name.toLowerCase()).indexOf(specificSearchCriteria) != -1)
            {
               itemsWithCriteria.push(item);
            }
            else
            {
               for each(effect in item.itemWrapper.effects)
               {
                  switch(effect.effectId)
                  {
                     case ActionIds.ACTION_CHARACTER_SUMMON_MONSTER_GROUP:
                     case ActionIds.ACTION_CHARACTER_SUMMON_MONSTER_GROUP_DYNAMIC:
                        monster = dataApi.getMonsterFromId(int(effect.parameter2));
                        if(monster && monster.name && utilApi.noAccent(monster.name.toLowerCase()).indexOf(specificSearchCriteria) != -1 && itemsWithCriteria.indexOf(item) == -1)
                        {
                           itemsWithCriteria.push(item);
                        }
                        break;
                  }
               }
            }
         }
         return itemsWithCriteria;
      }
      
      private function displayItemTooltip(target:Object, item:Object) : void
      {
         var setting:String = null;
         var settings:Object = new Object();
         var itemTooltipSettings:ItemTooltipSettings = sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = tooltipApi.createItemSettings();
            sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:* = sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         if(!item.itemWrapper.objectUID)
         {
            settings.showEffects = true;
         }
         if(!TradeCenter.BID_HOUSE_BUY_MODE || uiApi.me().name.toLowerCase().indexOf("myself") != -1)
         {
            itemTooltipSettings.showEffects = false;
         }
         uiApi.showTooltip(item.itemWrapper,this.gd_itemList,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,3,null,null,settings);
      }
      
      private function displayTypeTooltipText(target:Object, id:uint) : void
      {
         var tooltipText:String = uiApi.getText("ui.encyclopedia.encyclopediaType" + id);
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      private function sortItemList(arrayToSort:Array, sortField:String) : Array
      {
         var tempItem:Object = null;
         this._sortCriteria = sortField;
         var dataProvider:Array = arrayToSort;
         switch(sortField)
         {
            case "name":
               this.displaySortArrows(true,false,false,false);
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByName);
               }
               else
               {
                  dataProvider.sort(this.sortByName,Array.DESCENDING);
               }
               break;
            case "type":
               this.displaySortArrows(false,true,false,false);
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByCategory);
               }
               else
               {
                  dataProvider.sort(this.sortByCategory,Array.DESCENDING);
               }
               break;
            case "level":
               this.displaySortArrows(false,false,true,false);
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByLevel);
               }
               else
               {
                  dataProvider.sort(this.sortByLevel,Array.DESCENDING);
               }
               break;
            case "price":
               this.displaySortArrows(false,false,false,true);
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
         for each(tempItem in dataProvider)
         {
            if(tempItem.itemWrapper && tempItem.itemWrapper.visible)
            {
               result.push(tempItem);
            }
         }
         return result;
      }
      
      private function displaySortArrows(name:Boolean, cat:Boolean, level:Boolean, price:Boolean) : void
      {
         this.tx_sortNameDown.visible = name && this._ascendingSort;
         this.tx_sortNameUp.visible = name && !this._ascendingSort;
         this.tx_sortCatDown.visible = cat && this._ascendingSort;
         this.tx_sortCatUp.visible = cat && !this._ascendingSort;
         this.tx_sortLevelDown.visible = level && this._ascendingSort;
         this.tx_sortLevelUp.visible = level && !this._ascendingSort;
         this.tx_sortPriceDown.visible = price && this._ascendingSort;
         this.tx_sortPriceUp.visible = price && !this._ascendingSort;
      }
      
      private function sortByName(firstItem:Object, secondItem:Object, forceAscending:Boolean = false) : int
      {
         var firstValue:String = firstItem.itemWrapper.nameWithoutAccent;
         var secondValue:String = secondItem.itemWrapper.nameWithoutAccent;
         if(firstValue > secondValue)
         {
            return forceAscending && !this._ascendingSort ? -1 : 1;
         }
         if(firstValue < secondValue)
         {
            return forceAscending && !this._ascendingSort ? 1 : -1;
         }
         return 0;
      }
      
      private function sortByCategory(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:String = utilApi.noAccent(firstItem.itemWrapper.type.name);
         var secondValue:String = utilApi.noAccent(secondItem.itemWrapper.type.name);
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByName(firstItem,secondItem,true);
      }
      
      private function sortByLevel(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:uint = firstItem.itemWrapper.level;
         var secondValue:uint = secondItem.itemWrapper.level;
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByName(firstItem,secondItem,true);
      }
      
      private function sortByPrice(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:uint = this.averagePricesApi.getItemAveragePrice(int(firstItem.itemWrapper.id));
         var secondValue:uint = this.averagePricesApi.getItemAveragePrice(int(secondItem.itemWrapper.id));
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByName(firstItem,secondItem,true);
      }
      
      private function buyItem() : void
      {
         var quantityIndex:int = 0;
         var price:Number = NaN;
         var params:Object = null;
         var blocking:* = false;
         var option:String = null;
         if(this.gd_itemList.selectedItem != null)
         {
            this._selectedItem = this.gd_itemList.selectedItem;
            quantityIndex = this._selectedItem.currentCase;
            price = this._selectedItem.prices;
            if(this._buyPopupName == null && price > 0)
            {
               params = new Object();
               params.item = this._selectedItem.itemWrapper;
               params.stack = this.sellerDescriptor.quantities[quantityIndex];
               params.unityPrice = utilApi.kamasToString(Math.round(price / int(this.sellerDescriptor.quantities[quantityIndex])),"");
               params.price = utilApi.kamasToString(price,"");
               if(this.lastBuyItem && this.lastBuyItem.price == params.price && this.lastBuyItem.item == params.item && params.stack == this.lastBuyItem.stack)
               {
                  this.onConfirmBuyObject();
               }
               else
               {
                  blocking = false;
                  option = sysApi.getOption("hdvBlockPopupType","dofus");
                  if(option == "Always")
                  {
                     blocking = this.lastBuyItem != null;
                  }
                  else if(option == "Sometimes")
                  {
                     blocking = Boolean(this.lastBuyItem && utilApi.stringToKamas(this.lastBuyItem.price) * RELATION_MINI_FOR_WARNING_POPUP < utilApi.stringToKamas(params.price));
                  }
                  this._buyPopupName = this.modTradeCenter.openAuctionHouseBuyPopup(uiApi.getText("ui.bidhouse.confirmBuy") + uiApi.getText("ui.common.colon"),params,[this.onConfirmBuyObject,this.onCancelBuyObject],this.onConfirmBuyObject,this.onCancelBuyObject,blocking);
               }
               this.lastBuyItem = params;
            }
         }
         this.gd_itemList.focus();
      }
      
      private function clearFollows() : void
      {
         var follow:* = null;
         this._searchAll = false;
         this.characsIdList = new Vector.<uint>();
         this._areRunesAssociatedWithWeapon = false;
         for(follow in this._neededFollowedTypes)
         {
            this.addFollowedType(parseInt(follow),false);
         }
      }
      
      private function noFollow() : Boolean
      {
         var follow:Boolean = false;
         for each(follow in this._neededFollowedTypes)
         {
            if(follow)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getSearchAllTypeId() : void
      {
         var id:uint = 0;
         var item:ItemWrapper = null;
         this._searchAll = true;
         var ids:Array = this.itemFilterApi.filterItems(_searchCriteria);
         for each(id in ids)
         {
            item = dataApi.getItemWrapper(id);
            if(this.sellerDescriptor.types.indexOf(item.typeId) != -1)
            {
               this._allItems[item.typeId] = [];
               this._lastRequestTypeId = item.typeId;
               this.addFollowedType(item.typeId,true);
            }
         }
      }
      
      private function createItemDetails(items:Object) : Array
      {
         var item:Object = null;
         var i:uint = 0;
         var info:Object = null;
         var groupSize:int = 0;
         var ei:EffectInstance = null;
         var itemDetails:Array = [];
         var searchInput:Boolean = false;
         for each(item in items)
         {
            for(i = 0; i < item.prices.length; i++)
            {
               if(item.prices[i] > 0)
               {
                  if(item.itemWrapper.typeId == DataEnum.ITEM_TYPE_SOULSTONE && (item.itemWrapper.objectGID == DataEnum.ITEM_GID_SOULSTONE || item.itemWrapper.objectGID == DataEnum.ITEM_GID_SOULSTONE_BOSS || item.itemWrapper.objectGID == DataEnum.ITEM_GID_SOULSTONE_MINIBOSS))
                  {
                     groupSize = 8;
                     if(item.itemWrapper && item.itemWrapper.effects)
                     {
                        for each(ei in item.itemWrapper.effects)
                        {
                           if(ei.effectId == ActionIds.ACTION_ITEM_SUMMON_MONSTER_GROUP_MAX_LOOT_SHARES)
                           {
                              groupSize = int(ei.parameter0);
                           }
                        }
                     }
                     searchInput = true;
                     info = {
                        "isItemDetails":true,
                        "itemWrapper":item.itemWrapper,
                        "prices":item.prices[i],
                        "stack":1 * Math.pow(10,i),
                        "size":groupSize,
                        "currentCase":i
                     };
                     this.inp_specificSearch = null;
                  }
                  else
                  {
                     info = {
                        "isItemDetails":true,
                        "itemWrapper":item.itemWrapper,
                        "prices":item.prices[i],
                        "stack":1 * Math.pow(10,i),
                        "size":-1,
                        "currentCase":i
                     };
                  }
                  itemDetails.push(info);
               }
            }
         }
         itemDetails.sortOn(["stack","prices"],[Array.NUMERIC,Array.NUMERIC]);
         if(searchInput)
         {
            itemDetails.unshift({
               "isItemDetails":true,
               "searchInput":searchInput
            });
         }
         return itemDetails;
      }
      
      private function updateOpenedItemIndex(startIndex:uint, delta:int) : void
      {
         var openedItem:OpenedItemDetails = null;
         for each(openedItem in this._openedItemsDetails)
         {
            if(openedItem.currentIndex > startIndex)
            {
               openedItem.currentIndex += delta;
            }
         }
      }
      
      private function isOpened(item:Object) : Boolean
      {
         var openedItem:OpenedItemDetails = null;
         for each(openedItem in this._openedItemsDetails)
         {
            if(openedItem.item == item)
            {
               return true;
            }
         }
         return false;
      }
      
      private function clearOpenedItemsDetails() : void
      {
         var openedItem:OpenedItemDetails = null;
         for each(openedItem in this._openedItemsDetails)
         {
            if(this._followedObjects[openedItem.item.itemWrapper.objectGID])
            {
               this.followItem(openedItem.item.itemWrapper.typeId,openedItem.item.itemWrapper.objectGID,false);
            }
         }
         this._openedItemsDetails = [];
      }
      
      private function objectIsFollowed(items:Object, itemGID:int) : Boolean
      {
         var itemToRefresh:OpenedItemDetails = null;
         var openedItem:OpenedItemDetails = null;
         if((!items || items.length <= 0) && itemGID < 0)
         {
            return false;
         }
         if(this._neededFollowedObjects[itemGID] && !this._followedObjects[itemGID])
         {
            this._followedObjects[itemGID] = true;
            return false;
         }
         if(!this._neededFollowedObjects[itemGID] && this._followedObjects[itemGID])
         {
            this._followedObjects[itemGID] = false;
            if(this._itemsToRefresh.indexOf(itemGID) != -1)
            {
               this._itemsToRefresh.splice(this._itemsToRefresh.indexOf(itemGID),1);
               for each(openedItem in this._openedItemsDetails)
               {
                  if(openedItem.item.itemWrapper.objectGID == itemGID)
                  {
                     itemToRefresh = openedItem;
                     this._lastItemSelected = openedItem.item;
                  }
               }
               if(itemToRefresh)
               {
                  this._openedItemsDetails.splice(this._openedItemsDetails.indexOf(itemToRefresh),1);
                  this.updateOpenedItemIndex(itemToRefresh.currentIndex,-itemToRefresh.data.length);
               }
               this.followItem(itemGID < 0 || !items[0] ? uint(dataApi.getItemWrapper(itemGID).typeId) : uint(items[0].itemWrapper.typeId),itemGID,true);
               return true;
            }
            return false;
         }
         return this._followedObjects[itemGID];
      }
      
      private function followItem(itemTypeID:uint, itemGID:uint, follow:Boolean) : void
      {
         this._neededFollowedObjects[itemGID] = follow;
         sysApi.sendAction(new ExchangeBidHouseSearchAction([itemTypeID,itemGID,follow]));
      }
      
      private function showArrow() : void
      {
         var openedItem:OpenedItemDetails = null;
         var parentObject:OpenedItemDetails = null;
         var tmpItem:Object = this._componentList[this.currentRollOverDetails.name].data;
         var arrowButton:ButtonContainer = this._componentList[this.currentRollOverDetails.name].arrow;
         for each(openedItem in this._openedItemsDetails)
         {
            if(openedItem.item.itemWrapper.objectGID == tmpItem.itemWrapper.objectGID)
            {
               parentObject = openedItem;
            }
         }
         if(parentObject)
         {
            if(this.gd_itemList.indexIsInvisibleSlot(parentObject.currentIndex))
            {
               arrowButton.visible = true;
            }
         }
      }
      
      private function unshowArrow() : void
      {
         var arrowButton:ButtonContainer = this._componentList[this.currentRollOverDetails.name].arrow;
         arrowButton.visible = false;
      }
      
      private function moveToGlobalItem() : void
      {
         var openedItem:OpenedItemDetails = null;
         var parentObject:OpenedItemDetails = null;
         var tmpItem:Object = this._componentList[this.currentRollOverDetails.name].data;
         for each(openedItem in this._openedItemsDetails)
         {
            if(openedItem.item.itemWrapper.objectGID == tmpItem.itemWrapper.objectGID)
            {
               parentObject = openedItem;
            }
         }
         if(parentObject)
         {
            this.gd_itemList.moveTo(parentObject.currentIndex,true);
         }
      }
      
      private function updateResetFilterButton() : void
      {
         this.btn_resetFilters.disabled = this.itemFilterApi.currentSubIds().length == 0 && this.itemFilterApi.currentFilteredIds().length == 0 && this.itemFilterApi.currentCharacIds().length == 0 && this.itemFilterApi.currentConsumableEffectIds().length == 0 && this.itemFilterApi.currentWeaponEffectIds().length == 0 && this.itemFilterApi.currentSkinTargetIds().length == 0 && !_searchCriteria && this.itemFilterApi.getMinLevelInputValue() == 1 && this.itemFilterApi.getMaxLevelInputValue() == 200;
         this.lbl_resetFilters.cssClass = !!this.btn_resetFilters.disabled ? "lightgreycenter" : "greencenter";
      }
      
      public function onBidObjectTypeListUpdate(objects:Array, typeId:uint) : void
      {
         var item:Object = null;
         var itemWrapper:ItemWrapper = null;
         var averagePrice:Number = NaN;
         if(this._followedTypes[typeId])
         {
            return;
         }
         if(this._neededFollowedTypes[typeId] && !this._followedTypes[typeId])
         {
            this._followedTypes[typeId] = true;
         }
         this._lastRequestTypeData = objects;
         this._allItems[typeId] = [];
         this._currentTypesRequested.splice(this._currentTypesRequested.indexOf(typeId),1);
         for each(item in this._lastRequestTypeData)
         {
            itemWrapper = dataApi.getItemWrapper(item.GIDObject);
            if(itemWrapper)
            {
               averagePrice = this.averagePricesApi.getItemAveragePrice(itemWrapper.id);
               this._allItems[itemWrapper.typeId].push({
                  "isItemDetails":false,
                  "itemWrapper":itemWrapper,
                  "averagePrice":averagePrice,
                  "available":true
               });
            }
         }
         if(this.characsIdList.length > 0)
         {
            this.getAllRunesFromItemEffects(true);
         }
         else if(this._currentTypesRequested.length <= 0)
         {
            this.filterItems();
         }
      }
      
      private function getAllRunesFromItemEffects(onlyAvailableRunes:Boolean) : void
      {
         var tmpAllItems:Array = null;
         var i:uint = 0;
         var id:int = 0;
         var itemWrapper:ItemWrapper = null;
         var averagePrice:Number = NaN;
         var tmpIds:Vector.<uint> = this.itemFilterApi.filterRunesFromItemEffects(this.characsIdList);
         var ids:Array = [];
         if(!this._areRunesAssociatedWithWeapon && tmpIds.indexOf(DataEnum.ITEM_GID_HUNTING_RUNE) != -1)
         {
            tmpIds.removeAt(tmpIds.indexOf(DataEnum.ITEM_GID_HUNTING_RUNE));
         }
         if(onlyAvailableRunes)
         {
            tmpAllItems = this._allItems[DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE];
            for(i = 0; i < tmpAllItems.length; i++)
            {
               if(tmpIds.indexOf(tmpAllItems[i].itemWrapper.objectGID) != -1)
               {
                  ids.push(tmpAllItems[i]);
               }
               if(tmpIds.length == ids.length)
               {
                  break;
               }
            }
         }
         else
         {
            for each(id in tmpIds)
            {
               itemWrapper = dataApi.getItemWrapper(id);
               if(itemWrapper)
               {
                  averagePrice = this.averagePricesApi.getItemAveragePrice(itemWrapper.id);
                  ids.push({
                     "isItemDetails":false,
                     "itemWrapper":itemWrapper,
                     "averagePrice":averagePrice,
                     "available":true
                  });
               }
            }
         }
         this._dataMatrixItems = this.sortItemList(ids,this._sortCriteria);
         this.displayItemDetails(this._lastItemSelected,this._dataMatrixItems);
      }
      
      public function onBidObjectListUpdate(items:Object, itemGID:int, update:Boolean = false, newObjectType:Boolean = false) : void
      {
         var openedItem:OpenedItemDetails = null;
         var openedItemDetails:OpenedItemDetails = null;
         var removedItem:OpenedItemDetails = null;
         var newIndex:uint = 0;
         var itemAlreadyOpen:OpenedItemDetails = null;
         var delta:uint = 0;
         var info:Object = null;
         var l:uint = 0;
         if(this.objectIsFollowed(items,itemGID))
         {
            return;
         }
         var tmpDataProvider:Array = this._dataMatrixItems.concat();
         var item:Object = !!this._openedItemDetailsToRemove ? this._openedItemDetailsToRemove : this._lastItemSelected;
         var index:int = tmpDataProvider.indexOf(item);
         if(index == -1)
         {
            return;
         }
         if(items && items.length > 0)
         {
            this._lastItemDetails = this.createItemDetails(items);
            newIndex = index;
            itemAlreadyOpen = null;
            if(this._openedItemsDetails.length > 0)
            {
               delta = 0;
               for each(openedItem in this._openedItemsDetails)
               {
                  if(openedItem.item == item)
                  {
                     itemAlreadyOpen = openedItem;
                  }
                  if(index > openedItem.initialIndex)
                  {
                     delta += openedItem.data.length;
                  }
               }
               newIndex += delta;
            }
            if(!itemAlreadyOpen)
            {
               if(this._followedObjects[item.itemWrapper.objectGID])
               {
                  openedItemDetails = new OpenedItemDetails(this._lastItemSelected,this._lastItemDetails,index,newIndex);
                  if(this._openedItemsDetails.length < this._maxOpenedItem)
                  {
                     this._openedItemsDetails.push(openedItemDetails);
                  }
                  else
                  {
                     removedItem = this._openedItemsDetails.shift();
                     this._openedItemsDetails.push(openedItemDetails);
                     this.updateOpenedItemIndex(removedItem.currentIndex,-removedItem.data.length);
                  }
                  this.updateOpenedItemIndex(openedItemDetails.currentIndex,openedItemDetails.data.length);
                  this._canBuy = true;
               }
            }
            else
            {
               this._openedItemsDetails.splice(this._openedItemsDetails.indexOf(itemAlreadyOpen),1);
               this.updateOpenedItemIndex(itemAlreadyOpen.currentIndex,-itemAlreadyOpen.data.length);
            }
         }
         else if(items)
         {
            this._lastItemDetails = [];
            info = {
               "isItemDetails":true,
               "empty":true,
               "itemWrapper":item.itemWrapper
            };
            this._lastItemDetails.push(info);
            newIndex = index;
            itemAlreadyOpen = null;
            if(this._openedItemsDetails.length > 0)
            {
               delta = 0;
               for each(openedItem in this._openedItemsDetails)
               {
                  if(openedItem.item == item)
                  {
                     itemAlreadyOpen = openedItem;
                  }
                  if(index > openedItem.initialIndex)
                  {
                     delta += openedItem.data.length;
                  }
               }
               newIndex += delta;
            }
            if(this._openedItemDetailsToRemove)
            {
               this._openedItemsDetails.splice(this._openedItemsDetails.indexOf(itemAlreadyOpen),1);
               this.updateOpenedItemIndex(itemAlreadyOpen.currentIndex,-itemAlreadyOpen.data.length);
            }
            else if(!itemAlreadyOpen)
            {
               if(this._itemsToRefresh.indexOf(item.itemWrapper.objectGID) == -1)
               {
                  openedItemDetails = new OpenedItemDetails(item,this._lastItemDetails,index,newIndex);
                  if(this._openedItemsDetails.length < this._maxOpenedItem)
                  {
                     this._openedItemsDetails.push(openedItemDetails);
                  }
                  else
                  {
                     removedItem = this._openedItemsDetails.shift();
                     this._openedItemsDetails.push(openedItemDetails);
                     this.updateOpenedItemIndex(removedItem.currentIndex,-removedItem.data.length);
                  }
                  this.updateOpenedItemIndex(openedItemDetails.currentIndex,openedItemDetails.data.length);
               }
               else
               {
                  this._itemsToRefresh.splice(this._itemsToRefresh.indexOf(item.itemWrapper.objectGID),1);
                  this._neededFollowedObjects[item.itemWrapper.objectGID] = false;
                  this._followedObjects[item.itemWrapper.objectGID] = false;
               }
            }
            else
            {
               this._openedItemsDetails.splice(this._openedItemsDetails.indexOf(itemAlreadyOpen),1);
               this.updateOpenedItemIndex(itemAlreadyOpen.currentIndex,-itemAlreadyOpen.data.length);
            }
         }
         for(var k:uint = 0; k < this._openedItemsDetails.length; k++)
         {
            for(l = 0; l < this._openedItemsDetails[k].data.length; l++)
            {
               tmpDataProvider.splice(tmpDataProvider.indexOf(this._openedItemsDetails[k].item) + l + 1,0,this._openedItemsDetails[k].data[l]);
            }
         }
         this.displayItemDetails(!!items ? item : null,tmpDataProvider);
      }
      
      override public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.gd_filters:
               if(selectMethod != GridItemSelectMethodEnum.AUTO && (target as Grid).selectedItem && (target as Grid).selectedItem.isCat)
               {
                  this.itemFilterApi.displayCategories((target as Grid).selectedItem);
                  if(this.noFollow() && !this.btn_displayAllItems.selected && _searchCriteria == null)
                  {
                     this.getSearchAllTypeId();
                  }
               }
               break;
            case this.gd_itemList:
               if(selectMethod != GridItemSelectMethodEnum.AUTO && (target as Grid).selectedItem && !(target as Grid).selectedItem.isItemDetails && !uiApi.keyIsDown(Keyboard.SHIFT))
               {
                  if(!this.isOpened((target as Grid).selectedItem))
                  {
                     this.lastBuyItem = null;
                     if(this._specificSearchCriteria && this.inp_specificSearch)
                     {
                        this._specificSearchCriteria = null;
                        this.inp_specificSearch.placeholderText = this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT;
                        this.btn_resetSpecificSearch.visible = false;
                     }
                     if(this._openedItemsDetails.length >= this._maxOpenedItem)
                     {
                        this._openedItemDetailsToRemove = this._openedItemsDetails[0].item;
                        this.followItem(this._openedItemsDetails[0].item.itemWrapper.typeId,this._openedItemsDetails[0].item.itemWrapper.objectGID,false);
                     }
                     this._lastItemSelected = (target as Grid).selectedItem;
                     this._lastItemDetailsId = this._lastItemSelected.itemWrapper.objectGID;
                     this.followItem(this._lastItemSelected.itemWrapper.typeId,this._lastItemSelected.itemWrapper.objectGID,true);
                  }
                  else
                  {
                     this.followItem((target as Grid).selectedItem.itemWrapper.typeId,(target as Grid).selectedItem.itemWrapper.objectGID,false);
                     this._lastItemSelected = (target as Grid).selectedItem;
                     if(this._specificSearchCriteria && this.inp_specificSearch)
                     {
                        this._specificSearchCriteria = null;
                        this.inp_specificSearch.placeholderText = this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT;
                        this.btn_resetSpecificSearch.visible = false;
                     }
                  }
               }
         }
      }
      
      public function onSelectItemFromRecipe(selectedItem:Object) : void
      {
         this.onSelectItemFromInventory(selectedItem,false,true);
      }
      
      public function onSelectItemFromInventory(selectedItem:Object, autoSelect:Boolean = false, selectFromAuctionHouse:Boolean = false) : void
      {
         var effect:EffectInstance = null;
         var charac:uint = 0;
         if(!selectFromAuctionHouse)
         {
            return;
         }
         _searchCriteria = null;
         this._selectInventory = false;
         this.btn_resetFilters.disabled = false;
         this.lbl_resetFilters.cssClass = "greencenter";
         TradeCenter.SEARCH_MODE = false;
         this.clearOpenedItemsDetails();
         this.clearFollows();
         this.itemFilterApi.resetFilters(this.itemFilterApi.getMinLevel(),this.itemFilterApi.getMaxLevel());
         this.resetFilters();
         this._selectInventory = true;
         inp_search.text = selectedItem.name;
         this.btn_resetSearch.visible = true;
         if(this.currentType == RUNE_CATEGORY && selectedItem.isEquipment && selectedItem.enhanceable)
         {
            this.characsIdList = new Vector.<uint>();
            this._areRunesAssociatedWithWeapon = false;
            for each(effect in selectedItem.effects)
            {
               charac = dataApi.getEffect(effect.effectId).characteristic;
               this.characsIdList.push(charac);
            }
            for each(effect in selectedItem.possibleEffects)
            {
               charac = dataApi.getEffect(effect.effectId).characteristic;
               if(this.characsIdList.indexOf(charac) == -1)
               {
                  this.characsIdList.push(charac);
               }
            }
            this._areRunesAssociatedWithWeapon = selectedItem.isWeapon;
            this.addFollowedType(DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE,true);
         }
         else
         {
            this.updateItemList([selectedItem.objectGID]);
            this.displayItemDetails(this.gd_itemList.dataProvider.length > 0 ? this.gd_itemList.dataProvider[0] : this._lastItemSelected,this._dataMatrixItems);
         }
         _searchCriteria = selectedItem.name;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var tmpSuperTypeId:uint = 0;
         var key:* = undefined;
         var typeData:uint = 0;
         switch(target)
         {
            case this.btn_tabName:
               this._ascendingSort = this._sortCriteria == "name" ? !this._ascendingSort : true;
               this.clearOpenedItemsDetails();
               this._dataMatrixItems = this.sortItemList(this._dataMatrixItems,"name");
               this.displayItemDetails(null,this._dataMatrixItems);
               break;
            case this.btn_tabCat:
               this._ascendingSort = this._sortCriteria == "type" ? !this._ascendingSort : true;
               this.clearOpenedItemsDetails();
               this._dataMatrixItems = this.sortItemList(this._dataMatrixItems,"type");
               this.displayItemDetails(null,this._dataMatrixItems);
               break;
            case this.btn_tabLevel:
               this._ascendingSort = this._sortCriteria == "level" ? !this._ascendingSort : true;
               this.clearOpenedItemsDetails();
               this._dataMatrixItems = this.sortItemList(this._dataMatrixItems,"level");
               this.displayItemDetails(null,this._dataMatrixItems);
               break;
            case this.btn_tabPrice:
               this._ascendingSort = this._sortCriteria == "price" ? !this._ascendingSort : true;
               this.clearOpenedItemsDetails();
               this._dataMatrixItems = this.sortItemList(this._dataMatrixItems,"price");
               this.displayItemDetails(null,this._dataMatrixItems);
               break;
            case this.btn_resetFilters:
               _searchCriteria = null;
               inp_search.placeholderText = INPUT_SEARCH_DEFAULT_TEXT;
               this.btn_resetSearch.visible = false;
               this.btn_resetFilters.disabled = true;
               this.lbl_resetFilters.cssClass = "lightgreycenter";
               TradeCenter.SEARCH_MODE = false;
               this._selectInventory = false;
               this.clearFollows();
               this._currentManualLevelValueMin = -1;
               this._currentManualLevelValueMax = -1;
               this.characsIdList = new Vector.<uint>();
               this._areRunesAssociatedWithWeapon = false;
               this.itemFilterApi.resetFilters(this.itemFilterApi.getMinLevel(),this.itemFilterApi.getMaxLevel());
               break;
            case this.btn_resetSearch:
               this.clearOpenedItemsDetails();
               if(this._searchAll)
               {
                  this.clearFollows();
               }
               _searchCriteria = null;
               this.characsIdList = new Vector.<uint>();
               this._areRunesAssociatedWithWeapon = false;
               inp_search.placeholderText = INPUT_SEARCH_DEFAULT_TEXT;
               this.btn_resetSearch.visible = false;
               TradeCenter.SEARCH_MODE = false;
               this._selectInventory = false;
               this.filterItems();
               break;
            case this.btn_resetSpecificSearch:
               this._specificSearchCriteria = null;
               this.characsIdList = new Vector.<uint>();
               this._areRunesAssociatedWithWeapon = false;
               this.inp_specificSearch.placeholderText = this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT;
               this.btn_resetSpecificSearch.visible = false;
               this.onBidObjectListUpdate(null,-1);
               break;
            case this.btn_displayAllItems:
               this.clearOpenedItemsDetails();
               if(this._searchAll)
               {
                  this.clearFollows();
               }
               this.displayingAllItems = !this.btn_displayAllItems.selected;
               sysApi.setData("displayAllItemsAuctionHouse",this.displayingAllItems);
               if(this.characsIdList.length > 0)
               {
                  this.getAllRunesFromItemEffects(!this.displayingAllItems);
               }
               else
               {
                  if(this.itemFilterApi.currentFilteredIds().length > 0 || this.itemFilterApi.currentSubIds().length > 0 || this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0 || _searchCriteria)
                  {
                     this.filterItems();
                  }
                  if(this.noFollow() && _searchCriteria != null && this.btn_displayAllItems.selected)
                  {
                     this.getSearchAllTypeId();
                  }
               }
               break;
            default:
               if(target.name.indexOf("btn_buy") != -1)
               {
                  this.buyItem();
               }
               else if(target.name.indexOf("btn_moveToGlobalItemArrow") != -1)
               {
                  this.unshowArrow();
                  this.moveToGlobalItem();
               }
               else if(target.name.indexOf("btn_selectFilter") != -1)
               {
                  if(this.characsIdList.length > 0)
                  {
                     this.characsIdList = new Vector.<uint>();
                     this._areRunesAssociatedWithWeapon = false;
                     this.clearFollows();
                  }
                  data = this._componentList[target.name];
                  if(data.itemTypeId != -1)
                  {
                     tmpSuperTypeId = dataApi.getItemType(data.itemTypeId).superTypeId;
                     if(!this.itemFilterApi.checkSubFilters(tmpSuperTypeId) && this.itemFilterApi.currentFilteredIds().indexOf(tmpSuperTypeId) == -1)
                     {
                        this.addTypeFilterId(tmpSuperTypeId,false);
                     }
                     this.addSubTypeFilterId(data.itemTypeId);
                  }
                  else
                  {
                     this.clearOpenedItemsDetails();
                     if(data.id == "weaponEffect")
                     {
                        this.itemFilterApi.addWeaponEffect(data.cId);
                     }
                     else if(data.id == "consumableEffect")
                     {
                        this.itemFilterApi.addConsumableEffect(data.cId);
                     }
                     else if(data.id == "targetEquipment" || data.id == "targetWeapon")
                     {
                        this.itemFilterApi.addSkinTargetFilterId(data.cId);
                     }
                     else if(data.id == "breedingItem")
                     {
                        this.itemFilterApi.addBreedingItemEffect(data.cId);
                     }
                     else
                     {
                        this.itemFilterApi.addCharacFilterId(data.cId);
                     }
                     if(this.itemFilterApi.currentFilteredIds().length > 0 || this.itemFilterApi.currentFilteredIds().length <= 0 && this.itemFilterApi.currentCharacIds().length <= 0 && this.itemFilterApi.currentWeaponEffectIds().length <= 0 && this.itemFilterApi.currentConsumableEffectIds().length <= 0 && this.itemFilterApi.currentSkinTargetIds().length <= 0 && this.itemFilterApi.currentBreedingItemEffectIds().length <= 0)
                     {
                        if(this.itemFilterApi.currentFilteredIds().length <= 0)
                        {
                           for(key in this._allItems)
                           {
                              this._allItems[key] = [];
                           }
                        }
                        this.filterItems();
                     }
                     else if(this.itemFilterApi.currentCharacIds().length > 0 || this.itemFilterApi.currentWeaponEffectIds().length > 0 || this.itemFilterApi.currentConsumableEffectIds().length > 0 || this.itemFilterApi.currentSkinTargetIds().length > 0)
                     {
                        this.filterItems();
                     }
                  }
                  this.gd_filters.updateItem(this.gd_filters.selectedIndex);
               }
               else if(target.name.indexOf("btn_itemType") != -1)
               {
                  if(this._searchAll)
                  {
                     this.clearFollows();
                  }
                  typeData = this._componentList[target.name];
                  this.addTypeFilterId(typeData,true);
                  (target as ButtonContainer).selected = this.itemFilterApi.currentFilteredIds().indexOf(typeData) != -1;
                  if(this.noFollow() && _searchCriteria != null && this.btn_displayAllItems.selected)
                  {
                     this.getSearchAllTypeId();
                  }
               }
               else if(target.name.indexOf("btn_gridItemDetails") != -1 && uiApi.keyIsDown(Keyboard.SHIFT))
               {
                  sysApi.dispatchHook(CustomUiHookList.InsertHyperlink,this._componentList[target.name].data.itemWrapper);
               }
               this.updateResetFilterButton();
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tmpItem:Object = null;
         if(this.currentRollOverDetails)
         {
            this.unshowArrow();
         }
         if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
         {
            tmpItem = this._componentList[target.name];
            if(this.currentRollOver)
            {
               this.currentRollOver.state = !!this.currentRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
            }
            this.displayItemTooltip(target,tmpItem);
         }
         else if(target.name.indexOf("btn_itemType") != -1)
         {
            this.displayTypeTooltipText(target,this._componentList[target.name]);
         }
         else if(target.name.indexOf("tx_helpLevel") != -1)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.maxLevelInfo",this._currentSubArea.area.name,this.sellerDescriptor.maxItemLevel),null,null,500),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("lbl_name") != -1)
         {
            if(this.currentRollOver)
            {
               this.currentRollOver.state = !!this.currentRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
            }
         }
         else if(target.name.indexOf("btn_buy") != -1)
         {
            if(this.currentRollOverDetails)
            {
               this.currentRollOverDetails.state = !!this.currentRollOverDetails.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
            }
         }
         else if(target.name.indexOf("btn_moveToGlobalItemArrow") != -1)
         {
            if(this.currentRollOverDetails)
            {
               this.currentRollOverDetails.state = !!this.currentRollOverDetails.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
            }
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.moveToGlobalItem")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("btn_gridItemDetails") != -1)
         {
            this.currentRollOverDetails = target;
            if(this.currentType != RESOURCE_CATEGORY && this.currentType != RUNE_CATEGORY && this.currentType != CONSUMABLE_CATEGORY || this.currentType == CONSUMABLE_CATEGORY && this._componentList[target.name].data.itemWrapper.typeId == DataEnum.ITEM_TYPE_BREEDING_ITEM)
            {
               tmpItem = this._componentList[target.name].data;
               this.displayItemTooltip(target,tmpItem);
            }
         }
         else if(target.name.indexOf("btn_gridItem") != -1)
         {
            this.currentRollOver = target;
         }
         else if(target.name.indexOf("ctr_empty") != -1)
         {
            this.currentRollOverDetails = target.getParent();
         }
         if(this.currentRollOverDetails)
         {
            this.showArrow();
         }
      }
      
      override public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         super.onItemRollOver(target,item);
      }
      
      override public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         super.onItemRollOut(target,item);
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip("tooltip_standard");
         if(this.currentRollOver && (this.currentRollOver.state != StatesEnum.STATE_SELECTED_CLICKED && this.currentRollOver.state != StatesEnum.STATE_SELECTED))
         {
            this.currentRollOver.state = StatesEnum.STATE_NORMAL;
         }
         if(this.currentRollOverDetails && (this.currentRollOverDetails.state != StatesEnum.STATE_SELECTED_CLICKED && this.currentRollOverDetails.state != StatesEnum.STATE_SELECTED))
         {
            this.currentRollOverDetails.state = StatesEnum.STATE_NORMAL;
         }
      }
      
      override public function onRightClick(target:GraphicContainer) : void
      {
         var tmpItem:Object = null;
         var contextMenu:Object = null;
         if(target.name.indexOf("tx_itemBgDetails") != -1 || target.name.indexOf("tx_itemIconDetails") != -1 || target.name.indexOf("btn_gridItemDetails") != -1)
         {
            tmpItem = this._componentList[target.name].data;
            contextMenu = menuApi.create(tmpItem.itemWrapper);
            if(contextMenu.content.length > 0)
            {
               modContextMenu.createContextMenu(contextMenu);
            }
         }
         else if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
         {
            tmpItem = this._componentList[target.name];
            contextMenu = menuApi.create(tmpItem.itemWrapper);
            if(contextMenu.content.length > 0)
            {
               modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      private function onConfirmBuyObject() : void
      {
         var openedItem:OpenedItemDetails = null;
         var quantity:int = 0;
         var price:Number = NaN;
         this._buyPopupName = null;
         if(this._selectedItem.currentCase > -1)
         {
            this._selectedBuyItem = {
               "index":this.gd_itemList.selectedIndex,
               "gridSize":this.gd_itemList.dataProvider.length
            };
            this._itemToBuy.push(this._selectedItem.itemWrapper);
            for each(openedItem in this._openedItemsDetails)
            {
               if(openedItem.item.itemWrapper.objectGID == this._selectedItem.itemWrapper.objectGID)
               {
                  this._lastItemSelected = openedItem.item;
                  break;
               }
            }
            quantity = this.sellerDescriptor.quantities[this._selectedItem.currentCase];
            price = this._selectedItem.prices;
            sysApi.sendAction(new ExchangeBidHouseBuyAction([this._selectedItem.itemWrapper.objectUID,quantity,price]));
         }
         else
         {
            modCommon.openPopup(uiApi.getText("ui.bidhouse.bigStore"),uiApi.getText("ui.bidhouse.itemNotInBigStore"),[uiApi.getText("ui.common.ok")]);
            this.lastBuyItem = null;
         }
      }
      
      private function onCancelBuyObject() : void
      {
         this._buyPopupName = null;
         this.lastBuyItem = null;
      }
      
      override public function onKeyUp(target:DisplayObject, keyCode:uint) : void
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
         if(inp_search.haveFocus && inp_search.text != INPUT_SEARCH_DEFAULT_TEXT)
         {
            _searchTimer.reset();
            _searchTimer.start();
         }
         else if(this.inp_specificSearch && this.inp_specificSearch.text != this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT)
         {
            this._specificSearchTimer.reset();
            this._specificSearchTimer.start();
         }
      }
      
      protected function onLevelTimerComplete(e:TimerEvent) : void
      {
         this._levelTimer.reset();
         this.clearOpenedItemsDetails();
         this.itemFilterApi.updateInputLevel(this._currentInputLevel);
         if(this._currentInputLevel == this.inp_minLevel)
         {
            this._currentManualLevelValueMin = int(this._currentInputLevel.text);
         }
         else if(this._currentInputLevel == this.inp_maxLevel)
         {
            this._currentManualLevelValueMax = int(this._currentInputLevel.text);
         }
         this._currentInputLevel = null;
         this.updateResetFilterButton();
      }
      
      override protected function onSearchTimerComplete(e:TimerEvent) : void
      {
         _searchTimer.reset();
         this.characsIdList = new Vector.<uint>();
         this._areRunesAssociatedWithWeapon = false;
         if(this._searchAll)
         {
            this.clearFollows();
         }
         TradeCenter.SEARCH_MODE = true;
         if(inp_search.text.length > 1 && _searchCriteria != INPUT_SEARCH_DEFAULT_TEXT)
         {
            if(!this._searchAll)
            {
               this.clearOpenedItemsDetails();
            }
            this._specificSearchCriteria = null;
            _searchCriteria = utilApi.noAccent(inp_search.text).toLowerCase();
            this.btn_resetSearch.visible = true;
            this.btn_resetFilters.disabled = false;
            this.lbl_resetFilters.cssClass = "greencenter";
            if(this.noFollow() && this.btn_displayAllItems.selected)
            {
               this.getSearchAllTypeId();
            }
            else
            {
               this.filterItems();
            }
         }
         else if(inp_search.text.length == 0)
         {
            this.btn_resetSearch.visible = false;
            this._specificSearchCriteria = null;
            _searchCriteria = null;
            TradeCenter.SEARCH_MODE = false;
            this.onRelease(this.btn_resetSearch);
         }
         else
         {
            this.btn_resetSearch.visible = true;
         }
      }
      
      private function onSpecificSearchTimerComplete(e:TimerEvent) : void
      {
         if(this.inp_specificSearch.text.length > 1 && this.inp_specificSearch.text != this.INPUT_SPECIFIC_SEARCH_DEFAULT_TEXT)
         {
            this._specificSearchCriteria = utilApi.noAccent(this.inp_specificSearch.text).toLowerCase();
            this.btn_resetSpecificSearch.visible = true;
            this.updateItemListWithSpecificSearchCriteria(this._specificSearchCriteria);
         }
         else if(this.inp_specificSearch.text.length == 0)
         {
            if(this._specificSearchCriteria)
            {
               this._specificSearchCriteria = null;
            }
            this.btn_resetSpecificSearch.visible = false;
            this.onBidObjectListUpdate(null,-1);
         }
      }
      
      private function onBidHouseBuyResult(bought:Boolean, objectUID:uint) : void
      {
         var item:ItemWrapper = this._itemToBuy.shift();
         if(item && item.objectUID == objectUID)
         {
            this._itemsToRefresh.push(item.objectGID);
            this.followItem(item.typeId,item.objectGID,false);
         }
      }
      
      private function onValidUi(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this.gd_itemList.selectedItem && this.gd_itemList.selectedItem.hasOwnProperty("prices") && this._canBuy && !inp_search.haveFocus)
               {
                  this._canBuy = false;
                  this.buyItem();
               }
               return true;
            default:
               return false;
         }
      }
   }
}

class OpenedItemDetails
{
    
   
   public var item:Object;
   
   public var data:Array;
   
   public var currentIndex:uint;
   
   public var initialIndex:uint;
   
   function OpenedItemDetails(item:Object, data:Array, initialIndex:uint, currentIndex:uint)
   {
      super();
      this.item = item;
      this.data = data;
      this.currentIndex = currentIndex;
      this.initialIndex = initialIndex;
   }
}
