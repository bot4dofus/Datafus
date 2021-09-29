package Ankama_Grimoire.ui.optionalFeatures
{
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.CraftResultEnum;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.CaptureApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ChinqUi
   {
      
      public static const ADD_CARD_RANDOM:String = "random";
      
      public static const ADD_CARD_SAME:String = "same";
      
      public static const ADD_CARD_HAND:String = "hand";
      
      private static const TYPE_ECAFLIP_CARD:uint = 238;
      
      private static const SORT_ON_NONE:int = -1;
      
      private static const SORT_ON_NAME:int = 0;
      
      private static const SORT_ON_QTY:int = 1;
      
      private static const SORT_ON_AVERAGEPRICE:int = 2;
      
      private static const SORT_ON_LOT_AVERAGEPRICE:int = 3;
      
      private static const SORT_ON_LEVEL:int = 4;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="CaptureApi")]
      public var captureApi:CaptureApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _slotCollection:Array;
      
      private var _lastCombination:Array;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _searchTimer:Timer;
      
      private var _searchCriteria:String;
      
      private var _lastSearchCriteria:String;
      
      private var _combinationUpdateTimer:Timer;
      
      private var _animationEndTimer:Timer;
      
      private var _hideCardTimer:Timer;
      
      private var _inventoryItems:Array;
      
      private var _itemsDisplayed:Vector.<uint>;
      
      private var _sortParameters:Array;
      
      private var _primarySort:int = -1;
      
      private var _secondarySort:int = -1;
      
      private var _emptyUri:Uri;
      
      private var _itemResultToDisplay:ItemWrapper;
      
      private var _merging:Boolean = false;
      
      private var _chinqStats:ChinqStats;
      
      private var _nbCardAdded:Dictionary;
      
      public var ctr_modal:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_sameCards:ButtonContainer;
      
      public var btn_randomCards:ButtonContainer;
      
      public var btn_clearCards:ButtonContainer;
      
      public var btn_play:ButtonContainer;
      
      public var slot_0:Slot;
      
      public var slot_1:Slot;
      
      public var slot_2:Slot;
      
      public var slot_3:Slot;
      
      public var slot_4:Slot;
      
      public var slot_default:Slot;
      
      public var glow_0:Texture;
      
      public var glow_1:Texture;
      
      public var glow_2:Texture;
      
      public var glow_3:Texture;
      
      public var glow_4:Texture;
      
      public var ed_slot_0:EntityDisplayer;
      
      public var ed_slot_1:EntityDisplayer;
      
      public var ed_slot_2:EntityDisplayer;
      
      public var ed_slot_3:EntityDisplayer;
      
      public var ed_slot_4:EntityDisplayer;
      
      public var ed_center:EntityDisplayer;
      
      public var gd_cardsInventory:Grid;
      
      public var btn_filters:ButtonContainer;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var inp_minLevel:Input;
      
      public var inp_maxLevel:Input;
      
      public var btn_close_resultPopup:ButtonContainer;
      
      public var resultPopup:GraphicContainer;
      
      public var lbl_resultItem:Label;
      
      public var ctr_bgResultItemQuantity:GraphicContainer;
      
      public var lbl_title_resultPopup:Label;
      
      public var tx_logoDofus:Texture;
      
      public var tx_icon_resultItem:Texture;
      
      public var lbl_resultItemQuantity:Label;
      
      public var btn_saveResult:ButtonContainer;
      
      public var btn_copyResult:ButtonContainer;
      
      public var tx_item_0:Texture;
      
      public var tx_item_1:Texture;
      
      public var tx_item_2:Texture;
      
      public var tx_item_3:Texture;
      
      public var tx_item_4:Texture;
      
      public var lbl_item_0:Label;
      
      public var lbl_item_1:Label;
      
      public var lbl_item_2:Label;
      
      public var lbl_item_3:Label;
      
      public var lbl_item_4:Label;
      
      public var ed_result:EntityDisplayer;
      
      public function ChinqUi()
      {
         this._slotCollection = [];
         this._lastCombination = [];
         this._searchTimer = new Timer(500,1);
         this._combinationUpdateTimer = new Timer(100,1);
         this._animationEndTimer = new Timer(1500,1);
         this._hideCardTimer = new Timer(500,1);
         this._nbCardAdded = new Dictionary(true);
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.sysApi.disableWorldInteraction();
         this.sysApi.startStats("chinq");
         this._chinqStats = new ChinqStats();
         this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
         this.uiApi.addComponentHook(this.gd_cardsInventory,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_cardsInventory,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_cardsInventory,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sameCards,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sameCards,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_sameCards,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_randomCards,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_randomCards,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_randomCards,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_clearCards,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_clearCards,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_clearCards,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_play,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_play,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_play,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close_resultPopup,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_saveResult,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_saveResult,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_saveResult,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_copyResult,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_copyResult,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_copyResult,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_icon_resultItem,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_icon_resultItem,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.sysApi.addHook(CraftHookList.ExchangeCraftResult,this.onExchangeCraftResult);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this._searchTimer.addEventListener(TimerEvent.TIMER,this.onSearchTimer);
         this._combinationUpdateTimer.addEventListener(TimerEvent.TIMER,this.onCombinationUpdateTimer);
         this._animationEndTimer.addEventListener(TimerEvent.TIMER,this.onAnimationTimer);
         this._hideCardTimer.addEventListener(TimerEvent.TIMER,this.onHideCardTimer);
         this._emptyUri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tx_invisible");
         (this.gd_cardsInventory.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorFunction;
         (this.gd_cardsInventory.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
         (this.gd_cardsInventory.renderer as SlotGridRenderer).allowDrop = true;
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.temporis.chinqSearch");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this.lbl_title_resultPopup.text = this.lbl_title_resultPopup.text.toLocaleUpperCase();
         this._sortParameters = [];
         this._sortParameters[SORT_ON_NAME] = new SortParameters(this.uiApi.getText("ui.common.sortBy.name"),this.sortByName);
         this._sortParameters[SORT_ON_QTY] = new SortParameters(this.uiApi.getText("ui.common.sortBy.quantity"),this.sortByQuantity);
         this._sortParameters[SORT_ON_AVERAGEPRICE] = new SortParameters(this.uiApi.getText("ui.common.sortBy.averageprice"),this.sortByAveragePrice);
         this._sortParameters[SORT_ON_LOT_AVERAGEPRICE] = new SortParameters(this.uiApi.getText("ui.common.sortBy.averageprice.lot"),this.sortByItemsAveragePrice);
         this._sortParameters[SORT_ON_LEVEL] = new SortParameters(this.uiApi.getText("ui.common.sortBy.level"),this.sortByLevel);
         this._primarySort = this.sysApi.getSetData("chinqPrimarySort",SORT_ON_NONE,DataStoreEnum.BIND_ACCOUNT);
         this._secondarySort = this.sysApi.getSetData("chinqSecondarySort",SORT_ON_NONE,DataStoreEnum.BIND_ACCOUNT);
         this.cardSlotInit();
         this.fillCardInventory();
         this.updateButtons();
      }
      
      public function unload() : void
      {
         this._searchTimer.removeEventListener(TimerEvent.TIMER,this.onSearchTimer);
         this._combinationUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onCombinationUpdateTimer);
         this._animationEndTimer.removeEventListener(TimerEvent.TIMER,this.onAnimationTimer);
         this._hideCardTimer.removeEventListener(TimerEvent.TIMER,this.onHideCardTimer);
         this.storageApi.removeAllItemMasks("storageMinouki");
         this.sysApi.enableWorldInteraction();
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
      }
      
      private function cardSlotInit() : void
      {
         var slot:Slot = null;
         this._slotCollection = [];
         this._slotCollection[0] = this.slot_0;
         this._slotCollection[1] = this.slot_1;
         this._slotCollection[2] = this.slot_2;
         this._slotCollection[3] = this.slot_3;
         this._slotCollection[4] = this.slot_4;
         this.slot_default.dropValidator = this.dropValidatorFunction;
         this.slot_default.processDrop = this.processDrop;
         for each(slot in this._slotCollection)
         {
            slot.dropValidator = this.dropValidatorFunction as Function;
            slot.processDrop = this.processDrop as Function;
            slot.hideTopLabel = true;
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
         }
      }
      
      private function fillCardInventory() : void
      {
         this.storageApi.removeAllItemMasks("storageMinouki");
         this._inventoryItems = this.getCardInventory().reverse();
         this.updateInventory();
         this.sortOn(this._primarySort);
      }
      
      private function getCardInventory() : Array
      {
         var iw:ItemWrapper = null;
         var returnItems:Array = new Array();
         var inventory:Vector.<ItemWrapper> = this.storageApi.getViewContent("storageMinouki");
         for each(iw in inventory)
         {
            if(!(iw.typeId != TYPE_ECAFLIP_CARD || iw.position < 63))
            {
               returnItems.push(iw);
            }
         }
         return returnItems;
      }
      
      private function disableAllButtons() : void
      {
         this.btn_play.softDisabled = true;
         this.btn_sameCards.softDisabled = true;
         this.btn_randomCards.softDisabled = true;
         this.btn_clearCards.softDisabled = true;
      }
      
      private function updateButtons() : void
      {
         this.btn_play.softDisabled = !this.validCombination();
         this.btn_sameCards.softDisabled = this._lastCombination.length == 0;
         this.btn_randomCards.softDisabled = this.gd_cardsInventory.dataProvider.length == 0;
         this.btn_clearCards.softDisabled = !this.combinationContainCard();
      }
      
      private function disableUiInteractions() : void
      {
         this.btn_play.softDisabled = true;
         this.btn_clearCards.softDisabled = true;
         this.gd_cardsInventory.disabled = true;
      }
      
      private function enableUiInteractions() : void
      {
         this.updateButtons();
         this.gd_cardsInventory.disabled = false;
         this.ctr_modal.visible = false;
      }
      
      private function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         if(target == this.slot_default)
         {
            return true;
         }
         if(target.name.indexOf("slot_") != -1 && source.name.indexOf("gd_cardsInventory") != -1)
         {
            if(data is ShortcutWrapper)
            {
               data = (data as ShortcutWrapper).realItem;
            }
            if(!data || !data.type || data.typeId != TYPE_ECAFLIP_CARD)
            {
               return false;
            }
            if(data is ItemWrapper && data.quantity > 0)
            {
               return true;
            }
         }
         else if(source.name.indexOf("slot_") != -1 && target.name.indexOf("gd_cardsInventory") != -1)
         {
            return data != null;
         }
         return false;
      }
      
      private function processDrop(target:Object, data:Object, source:Object) : void
      {
         var slotId:Number = NaN;
         var sourceId:int = 0;
         var targetId:int = 0;
         if(this.dropValidatorFunction(target,data,source))
         {
            if(target.name.indexOf("gd_cardsInventory") != -1 && source.name.indexOf("slot_") != -1)
            {
               slotId = Number(source.name.split("slot_")[1]);
               this.removeCard(slotId);
            }
            else if(target.name.indexOf("slot_") != -1 && source.name.indexOf("slot_") != -1)
            {
               if(source.data && target.data)
               {
                  sourceId = Number(source.name.split("slot_")[1]);
                  targetId = Number(target.name.split("slot_")[1]);
                  this.exchangeCards(sourceId,targetId);
               }
            }
            else if(target.name.indexOf("slot_") != -1)
            {
               if(data is ShortcutWrapper)
               {
                  data = (data as ShortcutWrapper).realItem;
               }
               slotId = Number(target.name.split("slot_")[1]);
               this.addCard(data as ItemWrapper,ADD_CARD_HAND,slotId);
            }
         }
      }
      
      public function updateInventory() : void
      {
         var item:Object = null;
         var l:int = 0;
         var i:int = 0;
         var filteredInventory:Array = null;
         var reusingDataProvider:Boolean = false;
         var inventory:* = undefined;
         var scrollValue:int = this.gd_cardsInventory.verticalScrollValue;
         if(this._inventoryItems)
         {
            filteredInventory = [];
            this._itemsDisplayed = new Vector.<uint>();
            if(this._searchCriteria)
            {
               reusingDataProvider = this._lastSearchCriteria && this._lastSearchCriteria.length < this._searchCriteria.length && this._searchCriteria.indexOf(this._lastSearchCriteria) != -1;
               inventory = !!reusingDataProvider ? this.gd_cardsInventory.dataProvider : this._inventoryItems;
               l = inventory.length;
               for(i = 0; i < l; i++)
               {
                  item = inventory[i];
                  if(item.level >= int(this.inp_minLevel.text) && item.level <= int(this.inp_maxLevel.text))
                  {
                     if(item.undiatricalName.indexOf(this._searchCriteria) != -1 || item.searchContent.length > 0 && item.searchContent.indexOf(this._searchCriteria) != -1)
                     {
                        filteredInventory.push(item);
                        this._itemsDisplayed.push(item.objectUID);
                     }
                  }
               }
               this.gd_cardsInventory.dataProvider = filteredInventory;
               this._lastSearchCriteria = this._searchCriteria;
            }
            else
            {
               l = this._inventoryItems.length;
               for(i = 0; i < l; i++)
               {
                  item = this._inventoryItems[i];
                  if(item.level >= int(this.inp_minLevel.text) && item.level <= int(this.inp_maxLevel.text))
                  {
                     filteredInventory.push(item);
                     this._itemsDisplayed.push(item.objectUID);
                  }
               }
               this.gd_cardsInventory.dataProvider = filteredInventory;
               this._lastSearchCriteria = null;
            }
         }
         this.gd_cardsInventory.verticalScrollValue = scrollValue;
         if(!this._merging)
         {
            this.updateButtons();
         }
      }
      
      private function resetSearch() : void
      {
         this._searchCriteria = null;
         this._searchTimer.reset();
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this._lastSearchCriteria = null;
         this.updateInventory();
         this.sortOn(this._primarySort);
      }
      
      private function onSearchTimer(r:TimerEvent = null) : void
      {
         this._searchTimer.reset();
         if(this.inp_minLevel.haveFocus)
         {
            this.inp_minLevel.text = Math.min(int(this.inp_minLevel.text),int(this.inp_maxLevel.text)).toString();
         }
         else if(this.inp_maxLevel.haveFocus)
         {
            this.inp_maxLevel.text = Math.max(int(this.inp_minLevel.text),int(this.inp_maxLevel.text)).toString();
         }
         this.updateInventory();
         this.sortOn(this._primarySort);
      }
      
      protected function fillContextMenu(contextMenu:Array, data:Object, disabled:Boolean) : void
      {
         var secondarySorts:Array = null;
         var sort:* = undefined;
         var sortField:int = this._primarySort;
         var sortMenu:ContextMenuItem = this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort"),null,null,false,null,disabled);
         var sortMenuChildren:Array = [];
         sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sortBy.default"),this.updateSort,[SORT_ON_NONE],disabled,null,sortField == SORT_ON_NONE,true));
         for(sort in this._sortParameters)
         {
            sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this._sortParameters[sort].sortText,this.updateSort,[sort],disabled,null,sortField == sort,true));
            if(sortField != SORT_ON_NONE && sort != sortField)
            {
               if(!secondarySorts)
               {
                  secondarySorts = [];
               }
               secondarySorts.push(this.modContextMenu.createContextMenuItemObject(this._sortParameters[sort].sortText,this.addSecondarySort,[sort],false,null,this._secondarySort == sort,true));
            }
         }
         sortMenuChildren.push(this.modContextMenu.createContextMenuSeparatorObject(),this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort.secondary"),null,null,sortField == SORT_ON_NONE,secondarySorts,false));
         sortMenu.child = sortMenuChildren;
         contextMenu.push(sortMenu);
      }
      
      private function updateSort(property:int, descending:Boolean = false) : void
      {
         if(property == this._primarySort)
         {
            return;
         }
         this._primarySort = property;
         this.sortOn(this._primarySort);
         this.sysApi.setData("chinqPrimarySort",this._primarySort,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function addSecondarySort(property:int, descending:Boolean = false) : void
      {
         if(property == this._secondarySort)
         {
            return;
         }
         this._secondarySort = property;
         this.sortOn(this._primarySort);
         this.sysApi.setData("chinqSecondarySort",this._secondarySort,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function sortOn(property:int) : void
      {
         var tempDataProvider:Array = null;
         if(property != SORT_ON_NONE)
         {
            tempDataProvider = this.gd_cardsInventory.dataProvider.concat();
            tempDataProvider.sort(this._sortParameters[property].sortFunction);
            this.gd_cardsInventory.dataProvider = tempDataProvider;
         }
         else
         {
            this.updateInventory();
         }
      }
      
      private function sortByLevel(item1:ItemWrapper, item2:ItemWrapper, alreadySecondary:Boolean = false) : int
      {
         var firstValue:uint = item1.level;
         var secondValue:uint = item2.level;
         if(firstValue == secondValue)
         {
            if(!alreadySecondary && this._secondarySort != -1)
            {
               return (this._sortParameters[this._secondarySort] as SortParameters).sortFunction(item1,item2,true);
            }
            return 0;
         }
         return secondValue - firstValue;
      }
      
      private function sortByQuantity(item1:ItemWrapper, item2:ItemWrapper, alreadySecondary:Boolean = false) : int
      {
         var firstValue:uint = item1.quantity;
         var secondValue:uint = item2.quantity;
         if(firstValue == secondValue)
         {
            if(!alreadySecondary && this._secondarySort != SORT_ON_NONE)
            {
               return (this._sortParameters[this._secondarySort] as SortParameters).sortFunction(item1,item2,true);
            }
            return 0;
         }
         return secondValue - firstValue;
      }
      
      private function sortByAveragePrice(item1:ItemWrapper, item2:ItemWrapper, alreadySecondary:Boolean = false) : int
      {
         var firstValue:int = this.averagePricesApi.getItemAveragePrice(item1.id);
         var secondValue:int = this.averagePricesApi.getItemAveragePrice(item2.id);
         if(firstValue == secondValue)
         {
            if(!alreadySecondary && this._secondarySort != SORT_ON_NONE)
            {
               return (this._sortParameters[this._secondarySort] as SortParameters).sortFunction(item1,item2,true);
            }
            return 0;
         }
         return secondValue - firstValue;
      }
      
      private function sortByItemsAveragePrice(item1:ItemWrapper, item2:ItemWrapper, alreadySecondary:Boolean = false) : int
      {
         var firstValue:int = this.averagePricesApi.getItemAveragePrice(item1.id) * item1.quantity;
         var secondValue:int = this.averagePricesApi.getItemAveragePrice(item2.id) * item2.quantity;
         if(firstValue == secondValue)
         {
            if(!alreadySecondary && this._secondarySort != SORT_ON_NONE)
            {
               return (this._sortParameters[this._secondarySort] as SortParameters).sortFunction(item1,item2,true);
            }
            return 0;
         }
         return secondValue - firstValue;
      }
      
      private function sortByName(item1:ItemWrapper, item2:ItemWrapper, alreadySecondary:Boolean = false) : int
      {
         var firstValue:String = item1.nameWithoutAccent;
         var secondValue:String = item2.nameWithoutAccent;
         if(firstValue == secondValue)
         {
            if(!alreadySecondary && this._secondarySort != SORT_ON_NONE)
            {
               return (this._sortParameters[this._secondarySort] as SortParameters).sortFunction(item1,item2,true);
            }
            return 0;
         }
         if(firstValue > secondValue)
         {
            return 1;
         }
         return -1;
      }
      
      protected function displayItemTooltip(target:GraphicContainer, item:Object, settings:Object = null) : void
      {
         var setting:String = null;
         var globalPosition:* = undefined;
         if(!settings)
         {
            settings = {};
         }
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
         globalPosition = target.localToGlobal(new Point(0,0));
         this.uiApi.showTooltip(item,target,false,"standard",globalPosition.x > 500 ? uint(LocationEnum.POINT_TOPRIGHT) : uint(LocationEnum.POINT_TOPLEFT),globalPosition.x > 500 ? uint(LocationEnum.POINT_TOPLEFT) : uint(LocationEnum.POINT_TOPRIGHT),20,null,null,settings);
      }
      
      private function addCard(card:ItemWrapper, mode:String, slotId:int = -1) : Boolean
      {
         var slot:Slot = null;
         var index:int = 0;
         if(card == null)
         {
            return false;
         }
         for each(slot in this._slotCollection)
         {
            if((mode == ADD_CARD_RANDOM || mode == ADD_CARD_SAME) && slot.data && slot.data.id == card.id)
            {
               return false;
            }
            if(slot.data && slot.data.id == card.id)
            {
               this.sysApi.sendAction(new ExchangeObjectMoveAction([slot.data.objectUID,-1]));
               if(!this._nbCardAdded[mode])
               {
                  this._nbCardAdded[mode] = [];
               }
               index = this._nbCardAdded[mode].indexOf(slot.data.objectUID);
               if(index > -1)
               {
                  this._nbCardAdded[mode].splice(index,1);
               }
               slot.data = null;
               this.updateSlotBackground(slot);
               break;
            }
         }
         if(slotId != -1)
         {
            if(mode == ADD_CARD_RANDOM && this._slotCollection[slotId].data)
            {
               this.updateButtons();
               return false;
            }
            if(this._slotCollection[slotId].data)
            {
               if(!this._nbCardAdded[mode])
               {
                  this._nbCardAdded[mode] = [];
               }
               index = this._nbCardAdded[mode].indexOf(this._slotCollection[slotId].data.objectUID);
               if(index > -1)
               {
                  this._nbCardAdded[mode].splice(index,1);
               }
               this.sysApi.sendAction(new ExchangeObjectMoveAction([this._slotCollection[slotId].data.objectUID,-1]));
            }
            this._slotCollection[slotId].data = card;
            if(!this._nbCardAdded[mode])
            {
               this._nbCardAdded[mode] = [];
            }
            this._nbCardAdded[mode].push(card.objectUID);
            this.sysApi.sendAction(new ExchangeObjectMoveAction([card.objectUID,1]));
            this.updateSlotBackground(this._slotCollection[slotId]);
         }
         else
         {
            for each(slot in this._slotCollection)
            {
               if(slot.data == null)
               {
                  slot.data = card;
                  if(!this._nbCardAdded[mode])
                  {
                     this._nbCardAdded[mode] = [];
                  }
                  this._nbCardAdded[mode].push(card.objectUID);
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([card.objectUID,1]));
                  this.updateSlotBackground(slot);
                  break;
               }
            }
         }
         this.updateButtons();
         return true;
      }
      
      private function removeCard(slotId:int) : void
      {
         var mode:* = null;
         var index:int = 0;
         if(this._slotCollection[slotId].data)
         {
            this.sysApi.sendAction(new ExchangeObjectMoveAction([this._slotCollection[slotId].data.objectUID,-1]));
            for(mode in this._nbCardAdded)
            {
               if(this._nbCardAdded[mode])
               {
                  index = this._nbCardAdded[mode].indexOf(this._slotCollection[slotId].data.objectUID);
                  if(index > -1)
                  {
                     this._nbCardAdded[mode].splice(index,1);
                     break;
                  }
               }
            }
            this._slotCollection[slotId].data = null;
         }
         this.updateSlotBackground(this._slotCollection[slotId]);
         this.updateButtons();
      }
      
      private function exchangeCards(sourceSlotId:uint, targetSlotId:uint) : void
      {
         var sourceSlotData:ItemWrapper = this._slotCollection[sourceSlotId].data;
         var targetSlotData:ItemWrapper = this._slotCollection[targetSlotId].data;
         this._slotCollection[sourceSlotId].data = targetSlotData;
         this._slotCollection[targetSlotId].data = sourceSlotData;
      }
      
      private function playMergeAnimation() : void
      {
         var ed_slot:EntityDisplayer = null;
         var i:uint = 0;
         if(OptionManager.getOptionManager("berilia").getOption("uiAnimations"))
         {
            for(i = 0; i < 5; i++)
            {
               ed_slot = this["ed_slot_" + i];
               ed_slot.direction = i;
               ed_slot.animation = ChinqAnimEnum.ANIM_MERGE;
               ed_slot.addEndAnimationListener(this.onMergeAnimationEnd);
               ed_slot.visible = true;
            }
            this.ed_center.direction = 0;
            this.ed_center.animation = ChinqAnimEnum.ANIM_MERGE_CENTER;
            this.ed_center.addShotAnimationListener(this.onMergeAnimationShot);
            this.ed_center.addEndAnimationListener(this.onMergeCenterAnimationEnd);
            this.ed_center.visible = true;
            this._animationEndTimer.reset();
            this._hideCardTimer.reset();
            this._animationEndTimer.start();
            this._hideCardTimer.start();
         }
      }
      
      private function updateSlotBackground(slot:Slot) : void
      {
         var slotId:Number = Number(slot.id.split("slot_")[1]);
         var glowTexture:Texture = this["glow_" + slotId] as Texture;
         if(!slot.data || slot.data.level < 200)
         {
            glowTexture.visible = false;
         }
         else
         {
            glowTexture.visible = true;
            glowTexture.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/" + this.selectHalo(slot.data as ItemWrapper));
         }
         if(!slot.data)
         {
            slot.highlightTexture = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/carte_plus.png");
         }
         else
         {
            slot.highlightTexture = this._emptyUri;
         }
      }
      
      private function selectHalo(card:ItemWrapper) : String
      {
         var currentCardTypeEffect:int = 0;
         var cardEffect:EffectInstance = null;
         var param:int = 0;
         for each(cardEffect in card.effects)
         {
            if(cardEffect.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               param = int(cardEffect.parameter2);
               if(param == DataEnum.CARD_BONUS_CUSTOM_EFFECT_ID || param == DataEnum.CARD_HEART_CUSTOM_EFFECT_ID || param == DataEnum.CARD_DIAMOND_CUSTOM_EFFECT_ID || param == DataEnum.CARD_SPADE_CUSTOM_EFFECT_ID || param == DataEnum.CARD_CLUB_CUSTOM_EFFECT_ID)
               {
                  currentCardTypeEffect = param;
                  break;
               }
            }
         }
         switch(currentCardTypeEffect)
         {
            case DataEnum.CARD_BONUS_CUSTOM_EFFECT_ID:
               return "halo_card_bonus.png";
            case DataEnum.CARD_HEART_CUSTOM_EFFECT_ID:
               return "halo_card_coeur.png";
            case DataEnum.CARD_DIAMOND_CUSTOM_EFFECT_ID:
               return "halo_card_carreau.png";
            case DataEnum.CARD_SPADE_CUSTOM_EFFECT_ID:
               return "halo_card_pique.png";
            case DataEnum.CARD_CLUB_CUSTOM_EFFECT_ID:
               return "halo_card_trefle.png";
            default:
               return "halo_card_bonus.png";
         }
      }
      
      private function combinationContainCard() : Boolean
      {
         var slot:Slot = null;
         for each(slot in this._slotCollection)
         {
            if(slot.data != null)
            {
               return true;
            }
         }
         return false;
      }
      
      private function validCombination() : Boolean
      {
         var slot:Slot = null;
         for each(slot in this._slotCollection)
         {
            if(slot.data == null)
            {
               return false;
            }
         }
         return true;
      }
      
      private function makeSameCombination() : void
      {
         var cardId:uint = 0;
         var card:ItemWrapper = null;
         this.clearCards();
         if(this._lastCombination.length != 0 && this._lastCombination.length != 5)
         {
            this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.temporis.chatMissingCards"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
         for each(cardId in this._lastCombination)
         {
            card = this.inventoryApi.getItemByGID(cardId);
            if(card)
            {
               this.addCard(card,ADD_CARD_SAME);
            }
         }
      }
      
      private function makeRandomCombination() : void
      {
         var randomIndex:int = 0;
         if(this.validCombination())
         {
            this.clearCards();
         }
         var slotId:uint = 0;
         var cardsInventory:Array = this.gd_cardsInventory.dataProvider.concat();
         while(!this.validCombination() && slotId < 5 && slotId < this.gd_cardsInventory.dataProvider.length)
         {
            randomIndex = Math.floor(Math.random() * cardsInventory.length);
            if(cardsInventory[randomIndex] && !this.cardAlreadyPresent(cardsInventory[randomIndex]))
            {
               this.addCard(cardsInventory[randomIndex],ADD_CARD_RANDOM,slotId);
               cardsInventory.splice(randomIndex,1);
               slotId++;
            }
         }
      }
      
      private function cardAlreadyPresent(card:ItemWrapper) : Boolean
      {
         var slot:Slot = null;
         for each(slot in this._slotCollection)
         {
            if(slot.data != null)
            {
               if(slot.data.objectGID == card.objectGID)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function clearCards(auto:Boolean = false) : void
      {
         var slot:Slot = null;
         for each(slot in this._slotCollection)
         {
            if(slot.data)
            {
               if(!auto)
               {
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([slot.data.objectUID,-1]));
               }
               slot.data = null;
               this.updateSlotBackground(slot);
            }
         }
         this._nbCardAdded = new Dictionary(true);
      }
      
      private function displayPopup(item:ItemWrapper) : void
      {
         var id:* = null;
         var card:ItemWrapper = null;
         var itemName:String = null;
         this._chinqStats.updateNbCardsInputed(this._nbCardAdded);
         this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
         this._merging = false;
         this._lastCombination = [];
         this.ctr_modal.visible = true;
         if(OptionManager.getOptionManager("berilia").getOption("uiAnimations"))
         {
            this.ed_result.direction = 0;
            this.ed_result.animation = ChinqAnimEnum.ANIM_HALO;
            this.ed_result.visible = true;
         }
         else
         {
            this.ed_result.visible = false;
         }
         this.tx_logoDofus.visible = false;
         this.lbl_resultItem.text = item.name;
         this.tx_icon_resultItem.uri = item.fullSizeIconUri;
         this.lbl_resultItemQuantity.visible = this.ctr_bgResultItemQuantity.visible = item.quantity > 1;
         this.lbl_resultItemQuantity.text = "x" + item.quantity.toString();
         this.ctr_bgResultItemQuantity.width = this.lbl_resultItemQuantity.textWidth + 14;
         this.ctr_bgResultItemQuantity.x = this.tx_icon_resultItem.x + this.tx_icon_resultItem.width - this.ctr_bgResultItemQuantity.width;
         for(id in this._slotCollection)
         {
            for each(card in this._inventoryItems)
            {
               if(card.objectGID == this._slotCollection[id].data.objectGID)
               {
                  this._lastCombination.push((this._slotCollection[id].data as ItemWrapper).id);
                  break;
               }
            }
            this["tx_item_" + id].uri = (this._slotCollection[id].data as ItemWrapper).fullSizeIconUri;
            itemName = (this._slotCollection[id].data as ItemWrapper).name;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               itemName += " (" + (this._slotCollection[id].data as ItemWrapper).objectGID + ")";
            }
            this["lbl_item_" + id].text = itemName;
         }
         this.resultPopup.visible = true;
         this.updateButtons();
         this.disableUiInteractions();
         this.clearCards(true);
      }
      
      private function closeResultPopup() : void
      {
         this._itemResultToDisplay = null;
         this.clearCards(true);
         for(var i:uint = 0; i < 5; i++)
         {
            this["slot_" + i].visible = true;
         }
         this.resultPopup.visible = false;
         this.enableUiInteractions();
      }
      
      private function captureResult() : BitmapData
      {
         this.tx_logoDofus.visible = true;
         this.btn_saveResult.visible = false;
         this.btn_copyResult.visible = false;
         var screen:BitmapData = this.captureApi.getFromTarget(this.resultPopup);
         this.tx_logoDofus.visible = false;
         this.btn_saveResult.visible = true;
         this.btn_copyResult.visible = true;
         return screen;
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != SelectMethodEnum.AUTO)
         {
            var _loc4_:* = target;
            switch(0)
            {
            }
            if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
            {
               this.uiApi.hideTooltip();
               if(this.gd_cardsInventory != null)
               {
                  this.addCard(this.gd_cardsInventory.selectedItem,ADD_CARD_HAND);
               }
            }
            return;
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(item.data)
         {
            this.displayItemTooltip(this.gd_cardsInventory,item.data);
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if(target is Slot && (target as Slot).data)
         {
            this.sysApi.sendAction(new ExchangeObjectMoveAction([(target as Slot).data.objectUID,-1]));
            (target as Slot).data = null;
            this.updateSlotBackground(target as Slot);
            this.validCombination();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var itemName:String = null;
         var contextMenu:Array = null;
         switch(target)
         {
            case this.btn_sameCards:
               if(this.resultPopup.visible)
               {
                  this.closeResultPopup();
               }
               this.makeSameCombination();
               this._chinqStats.addUtilisation("btn_sameCards");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               break;
            case this.btn_randomCards:
               if(this.resultPopup.visible)
               {
                  this.closeResultPopup();
               }
               this.makeRandomCombination();
               this._chinqStats.addUtilisation("btn_randomCards");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               break;
            case this.btn_clearCards:
               if(this.resultPopup.visible)
               {
                  this.closeResultPopup();
               }
               else
               {
                  this.clearCards();
                  this.updateButtons();
               }
               this._chinqStats.addUtilisation("btn_clearCards");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               break;
            case this.btn_saveResult:
               itemName = this._itemResultToDisplay.nameWithoutAccent.replace(/[\s]/g,"_");
               itemName = itemName.replace(/[^\w]/g,"");
               this.captureApi.jpegEncode(this.captureResult(),80,true,itemName + ".jpg");
               this._chinqStats.addUtilisation("btn_saveResult");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               break;
            case this.btn_copyResult:
               Clipboard.generalClipboard.setData(ClipboardFormats.BITMAP_FORMAT,this.captureResult());
               this._chinqStats.addUtilisation("btn_copyResult");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               break;
            case this.btn_resetSearch:
               this.resetSearch();
               break;
            case this.btn_filters:
               contextMenu = [];
               this.fillContextMenu(contextMenu,null,false);
               contextMenu.unshift(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.common.options")));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_play:
               this.sysApi.sendAction(new ExchangeReadyAction([true]));
               this._chinqStats.addUtilisation("btn_play");
               this.sysApi.dispatchHook(HookList.ChinqStats,this._chinqStats);
               this._merging = true;
               this.disableAllButtons();
               this.playMergeAnimation();
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_close_resultPopup:
               this.closeResultPopup();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var slotId:Number = NaN;
         switch(target)
         {
            case this.btn_play:
               if(this.btn_play.softDisabled)
               {
                  text = this.uiApi.getText("ui.temporis.exchangeCardsWarning");
               }
               else
               {
                  text = this.uiApi.getText("ui.temporis.exchangeCards");
               }
               break;
            case this.btn_sameCards:
               text = this.uiApi.getText("ui.temporis.useSameCards");
               break;
            case this.btn_randomCards:
               text = this.uiApi.getText("ui.temporis.useRandomCards");
               break;
            case this.btn_clearCards:
               text = this.uiApi.getText("ui.temporis.clearCards");
               break;
            case this.btn_saveResult:
               text = this.uiApi.getText("ui.temporis.saveCombinationScreenshot");
               break;
            case this.btn_copyResult:
               text = this.uiApi.getText("ui.temporis.copyCombination");
               break;
            case this.slot_0:
            case this.slot_1:
            case this.slot_2:
            case this.slot_3:
            case this.slot_4:
               slotId = Number(target.name.split("slot_")[1]);
               if(this._slotCollection[slotId].data != null)
               {
                  this.displayItemTooltip(this._slotCollection[slotId],this._slotCollection[slotId].data);
               }
               else
               {
                  text = this.uiApi.getText("ui.temporis.emptyCardSlotHover");
               }
               break;
            case this.tx_icon_resultItem:
               this.displayItemTooltip(this.tx_icon_resultItem,this._itemResultToDisplay);
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      private function onKeyUp(target:Object, keyCode:uint) : void
      {
         if(this.inp_search.haveFocus && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT && this._searchCriteria != this.inp_search.text.toLowerCase())
         {
            if(this.inp_search.text.length)
            {
               this._searchCriteria = this.inp_search.text.toLowerCase();
               this._searchTimer.reset();
               this._searchTimer.start();
               this.btn_resetSearch.visible = true;
            }
            else if(this._searchCriteria)
            {
               this.resetSearch();
            }
         }
         else if(this.inp_minLevel.haveFocus || this.inp_maxLevel.haveFocus)
         {
            this._searchTimer.reset();
            this._searchTimer.start();
         }
      }
      
      protected function onExchangeCraftResult(result:uint, item:ItemWrapper) : void
      {
         switch(result)
         {
            case CraftResultEnum.CRAFT_SUCCESS:
               this._itemResultToDisplay = item;
               if(!OptionManager.getOptionManager("berilia").getOption("uiAnimations"))
               {
                  this.displayPopup(this._itemResultToDisplay);
               }
               break;
            default:
               this._merging = false;
         }
      }
      
      private function onExchangeObjectAdded(item:ItemWrapper, remote:Object) : void
      {
         this.storageApi.addItemMask(item.objectUID,"storageMinouki",item.quantity);
         this.storageApi.releaseHooks();
         this._combinationUpdateTimer.reset();
         this._combinationUpdateTimer.start();
      }
      
      private function onExchangeObjectRemoved(itemUID:int, remote:Boolean) : void
      {
         this.storageApi.removeItemMask(itemUID,"storageMinouki");
         this.storageApi.releaseHooks();
         this._combinationUpdateTimer.reset();
         this._combinationUpdateTimer.start();
      }
      
      private function onCombinationUpdateTimer(r:TimerEvent = null) : void
      {
         this._combinationUpdateTimer.reset();
         this._inventoryItems = this.getCardInventory().reverse();
         this.updateInventory();
         this.sortOn(this._primarySort);
      }
      
      private function onHideCardTimer(t:TimerEvent = null) : void
      {
         this._hideCardTimer.reset();
         for(var i:uint = 0; i < 5; i++)
         {
            this["slot_" + i].visible = false;
            this["glow_" + i].visible = false;
         }
      }
      
      private function onAnimationTimer(t:TimerEvent = null) : void
      {
         this._animationEndTimer.reset();
         if(!this.resultPopup.visible && this._itemResultToDisplay)
         {
            this.displayPopup(this._itemResultToDisplay);
         }
      }
      
      public function onMergeAnimationEnd(e:Event) : void
      {
         var ed_slot:EntityDisplayer = null;
         var direction:int = -1;
         if((e as TiphonEvent).sprite)
         {
            direction = (e as TiphonEvent).sprite.getDirection();
         }
         if(direction != -1)
         {
            ed_slot = this["ed_slot_" + direction];
            ed_slot.removeEndAnimationListener(this.onMergeAnimationEnd);
            ed_slot.gotoAndStop = 0;
            ed_slot.visible = false;
         }
      }
      
      public function onMergeAnimationShot(e:Event) : void
      {
         this.ed_center.removeShotAnimationListener(this.onMergeAnimationShot);
         this.ed_center.visible = false;
         if(this._itemResultToDisplay)
         {
            this.displayPopup(this._itemResultToDisplay);
         }
      }
      
      public function onMergeCenterAnimationEnd(e:Event) : void
      {
         this.ed_center.removeEndAnimationListener(this.onMergeCenterAnimationEnd);
         this.ed_center.gotoAndStop = 0;
         this.ed_center.visible = false;
      }
   }
}

class SortParameters
{
    
   
   public var sortText:String;
   
   public var sortFunction:Function;
   
   function SortParameters(sortText:String, sortFunction:Function)
   {
      super();
      this.sortText = sortText;
      this.sortFunction = sortFunction;
   }
}

import Ankama_Grimoire.ui.optionalFeatures.ChinqUi;
import flash.utils.Dictionary;

class ChinqStats
{
    
   
   public var nbCardsInputedByRandom:uint;
   
   public var nbCardsInputedByPrevious:uint;
   
   public var nbCardsInputedByHand:uint;
   
   public var buttonsUtilisation:Dictionary;
   
   function ChinqStats()
   {
      super();
      this.initButtonsUtilisation();
   }
   
   private function initButtonsUtilisation() : void
   {
      this.buttonsUtilisation = new Dictionary();
      this.buttonsUtilisation["btn_randomCards"] = 0;
      this.buttonsUtilisation["btn_sameCards"] = 0;
      this.buttonsUtilisation["btn_clearCards"] = 0;
      this.buttonsUtilisation["btn_saveResult"] = 0;
      this.buttonsUtilisation["btn_copyResult"] = 0;
      this.buttonsUtilisation["btn_play"] = 0;
   }
   
   public function addUtilisation(btnName:String) : void
   {
      ++this.buttonsUtilisation[btnName];
   }
   
   public function updateNbCardsInputed(cardsInputed:Dictionary) : void
   {
      if(cardsInputed[ChinqUi.ADD_CARD_RANDOM])
      {
         this.nbCardsInputedByRandom += cardsInputed[ChinqUi.ADD_CARD_RANDOM].length;
      }
      if(cardsInputed[ChinqUi.ADD_CARD_SAME])
      {
         this.nbCardsInputedByPrevious += cardsInputed[ChinqUi.ADD_CARD_SAME].length;
      }
      if(cardsInputed[ChinqUi.ADD_CARD_HAND])
      {
         this.nbCardsInputedByHand += cardsInputed[ChinqUi.ADD_CARD_HAND].length;
      }
   }
}

class ChinqAnimEnum
{
   
   public static const ANIM_MERGE:String = "AnimMerge";
   
   public static const ANIM_MERGE_CENTER:String = "AnimMergePatte";
   
   public static const ANIM_HALO:String = "AnimHaloObjet";
    
   
   function ChinqAnimEnum()
   {
      super();
   }
}
