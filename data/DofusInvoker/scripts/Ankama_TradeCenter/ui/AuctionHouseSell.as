package Ankama_TradeCenter.ui
{
   import Ankama_TradeCenter.TradeCenter;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentAddAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   public class AuctionHouseSell extends BasicItemCard
   {
      
      private static const RELATION_MINI_FOR_WARNING_POPUP:int = 5;
      
      private static const SORT_CACHE_NAME_PREFIX:String = "HV_SELL_SORTING_";
      
      private static const EQUIPMENT_CATEGORY:uint = 1;
      
      private static const CONSUMABLE_CATEGORY:uint = 2;
      
      private static const RESOURCE_CATEGORY:uint = 3;
      
      private static const RUNE_CATEGORY:uint = 4;
      
      private static const SOUL_CATEGORY:uint = 5;
      
      private static const CREATURE_CATEGORY:uint = 6;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_TradeCenter")]
      public var modTradeCenter:TradeCenter;
      
      private var _componentList:Dictionary;
      
      public var sellerDescriptor:Object;
      
      private var _currentSameItemsInAuctionHouse:Dictionary;
      
      private var _currentStackFilter:uint = 1;
      
      private var _exchangeQuantity:uint;
      
      private var _mode:Boolean;
      
      private var _maxQuantityReached:Boolean = false;
      
      private var _currentType:uint = 0;
      
      private var _itemsToSale:Array;
      
      private var _allItemsToRemove:Array;
      
      private var _itemName:String;
      
      private var _price:Number = 0;
      
      private var _averagePrice:Number = -1;
      
      private var _oldPrice:Number = 0;
      
      private var _tax:Number = 0;
      
      private var _totalObjectPrice:Number;
      
      private var _tooltipTextButtonValid:String;
      
      private var _currentItemSelected:Object;
      
      private var _currentObjectToRemove:Object;
      
      private var _nbOfObjectAfterRemove:uint;
      
      private var _removing:Boolean = false;
      
      private var _sellPopupName:String;
      
      private var _priceWarningPopupName:String;
      
      private var _stackChoices:Array;
      
      private var _searchTimer:BenchmarkTimer;
      
      private var _searchCriteria:String;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _sortCriteria:String = "name";
      
      private var _ascendingSort:Boolean = true;
      
      private var currentRollOver:Object;
      
      public var gd_itemList:Grid;
      
      public var gd_otherItemList:Grid;
      
      public var btn_beta:ButtonContainer;
      
      public var ctr_currentItemDetails:GraphicContainer;
      
      public var ctr_sellingGroup:GraphicContainer;
      
      public var lbl_quantity:Label;
      
      public var cb_quantity:ComboBox;
      
      public var lbl_taxTimeTitle:Label;
      
      public var lbl_taxTime:Label;
      
      public var lbl_averagePrice:Label;
      
      public var lbl_error:Label;
      
      public var lbl_noCurrentPrice:Label;
      
      public var tx_miniPricesWarning:Texture;
      
      public var lbl_quantityObject:Label;
      
      public var lbl_sumPrices:Label;
      
      public var lbl_selectItemList:Label;
      
      public var lbl_selectItemInventory:Label;
      
      public var lbl_modifyMultipleError:Label;
      
      public var btn_tabOtherStack:ButtonContainer;
      
      public var cb_stack:ComboBox;
      
      public var bgcb_stack:TextureBitmap;
      
      public var iconKamaTaxTime:Texture;
      
      public var iconKamaAveragePrice:Texture;
      
      public var blk_otherItems:GraphicContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var inp_search:Input;
      
      public var chk_all:ButtonContainer;
      
      public var btn_removeItems:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabStoreTime:ButtonContainer;
      
      public var btn_tabStack:ButtonContainer;
      
      public var btn_tabPrice:ButtonContainer;
      
      public var lbl_tabName:Label;
      
      public var lbl_tabStoreTime:Label;
      
      public var lbl_tabStack:Label;
      
      public var lbl_tabPrice:Label;
      
      public var tx_sortNameDown:Texture;
      
      public var tx_sortNameUp:Texture;
      
      public var tx_sortStoreTimeDown:Texture;
      
      public var tx_sortStoreTimeUp:Texture;
      
      public var tx_sortStackDown:Texture;
      
      public var tx_sortStackUp:Texture;
      
      public var tx_sortPriceDown:Texture;
      
      public var tx_sortPriceUp:Texture;
      
      public function AuctionHouseSell()
      {
         this._componentList = new Dictionary(true);
         this._currentSameItemsInAuctionHouse = new Dictionary(true);
         this._itemsToSale = [];
         this._allItemsToRemove = [];
         this._stackChoices = ["1","10","100"];
         super();
      }
      
      public function get allItemsToRemove() : Array
      {
         return this._allItemsToRemove;
      }
      
      public function get currentObjectToRemove() : Object
      {
         return this._currentObjectToRemove;
      }
      
      public function set currentObjectToRemove(value:Object) : void
      {
         this._currentObjectToRemove = value;
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         this.sellerDescriptor = params.sellerBuyerDescriptor;
         sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         uiApi.addShortcutHook("validUi",this.onShortcut);
         sysApi.addHook(ExchangeHookList.ExchangeBidPriceForSeller,this.onExchangeBidPriceForSeller);
         sysApi.addHook(ExchangeHookList.SellerObjectListUpdate,this.onSellerObjectListUpdate);
         sysApi.addHook(HookList.DisplayPinnedItemTooltip,this.onDisplayPinnedTooltip);
         sysApi.addHook(ExchangeHookList.BidObjectListUpdate,this.onBidObjectListUpdate);
         sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         uiApi.addComponentHook(this.gd_itemList,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(btn_valid,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(btn_valid,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(btn_modify,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(btn_modify,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_removeItems,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_removeItems,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.lbl_quantityObject,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.lbl_quantityObject,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.lbl_sumPrices,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.lbl_sumPrices,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.lbl_taxTimeTitle,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.lbl_taxTimeTitle,ComponentHookList.ON_ROLL_OUT);
         this.INPUT_SEARCH_DEFAULT_TEXT = uiApi.getText("ui.search.list");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         if(!this._searchTimer)
         {
            this._searchTimer = new BenchmarkTimer(200,1,"AuctionHouseSell._searchTimer");
         }
         if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_COLLAR) != -1)
         {
            this._currentType = EQUIPMENT_CATEGORY;
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRINK) != -1)
         {
            this._currentType = CONSUMABLE_CATEGORY;
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_WING) != -1)
         {
            this._currentType = RESOURCE_CATEGORY;
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE) != -1)
         {
            this._currentType = RUNE_CATEGORY;
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_EMPTY_SOULSTONE) != -1)
         {
            this._currentType = SOUL_CATEGORY;
         }
         else if(this.sellerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE) != -1)
         {
            this._currentType = CREATURE_CATEGORY;
         }
         this.cb_stack.dataProvider = this._stackChoices;
         this.cb_stack.value = this._stackChoices[0];
         this._currentStackFilter = int(this.cb_stack.value);
         ctr_inputQty.visible = false;
         this.btn_removeItems.disabled = true;
         this.btn_tabOtherStack.visible = false;
         btn_valid.visible = false;
         this.blk_otherItems.visible = false;
         this.lbl_tabName.fullWidth();
         this.lbl_tabStoreTime.fullWidth();
         this.lbl_tabStack.fullWidth();
         this.lbl_tabPrice.fullWidth();
         this.lbl_modifyMultipleError.visible = false;
         if(params.objectsInfos)
         {
            this.parseObjectsInfos(params.objectsInfos);
         }
         var sortInfos:Object = sysApi.getData(SORT_CACHE_NAME_PREFIX + this._currentType,DataStoreEnum.BIND_ACCOUNT);
         if(sortInfos)
         {
            this._sortCriteria = sortInfos.sort;
            this._ascendingSort = sortInfos.ascending;
         }
         this.gd_itemList.updateItems();
         this.gd_otherItemList.updateItems();
      }
      
      override public function unload() : void
      {
         sysApi.setData(SORT_CACHE_NAME_PREFIX + this._currentType,{
            "sort":this._sortCriteria,
            "ascending":this._ascendingSort
         },DataStoreEnum.BIND_ACCOUNT);
         if(uiApi.getUi(this._sellPopupName))
         {
            uiApi.unloadUi(this._sellPopupName);
         }
         if(uiApi.getUi(this._priceWarningPopupName))
         {
            uiApi.unloadUi(this._priceWarningPopupName);
         }
      }
      
      public function updateItem(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var days:int = 0;
         var hours:int = 0;
         var minutes:int = 0;
         var daysStr:* = null;
         var hourStr:* = null;
         var minutesStr:String = null;
         var time:String = null;
         var price:Number = NaN;
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
            if(!this._componentList[componentsRef.lbl_storeTime.name])
            {
               uiApi.addComponentHook(componentsRef.lbl_storeTime,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.lbl_storeTime,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[componentsRef.tx_itemBg.name] = data;
            this._componentList[componentsRef.tx_itemIcon.name] = data;
            this._componentList[componentsRef.btn_gridItem.name] = data;
            this._componentList[componentsRef.lbl_storeTime.name] = data;
            if(!this._componentList[componentsRef.chk_remove.name])
            {
               uiApi.addComponentHook(componentsRef.chk_remove,ComponentHookList.ON_RELEASE);
               uiApi.addComponentHook(componentsRef.chk_remove,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.chk_remove,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[componentsRef.chk_remove.name] = data;
            componentsRef.lbl_storeTime.width = this.lbl_tabStoreTime.width;
            componentsRef.btn_gridItem.handCursor = false;
            componentsRef.chk_remove.visible = true;
            componentsRef.chk_remove.selected = data.selected;
            componentsRef.tx_itemBg.visible = true;
            componentsRef.tx_itemIcon.uri = data.itemWrapper.iconUri;
            if(data.itemWrapper.itemSetId != -1)
            {
               componentsRef.lbl_itemName.cssClass = "orangeleftlight";
            }
            else
            {
               componentsRef.lbl_itemName.cssClass = "greenleftlight";
            }
            componentsRef.lbl_itemName.text = "{HDVItem," + data.itemWrapper.objectGID + "," + data.itemWrapper.objectUID + "::" + data.itemWrapper.name + "}";
            days = Math.floor(data.unsoldDelay / (24 * 3600));
            hours = Math.floor(data.unsoldDelay % (24 * 3600) / 3600);
            minutes = Math.floor(data.unsoldDelay % (24 * 3600) % 3600 / 60);
            daysStr = days + " " + uiApi.getText("ui.time.short.day") + " ";
            hourStr = (hours > 0 ? (hours < 10 ? "0" + hours : hours) : "00") + " " + uiApi.getText("ui.time.short.hour") + " ";
            minutesStr = (minutes > 0 ? (minutes < 10 ? "0" + minutes : minutes) : "00") + " " + uiApi.getText("ui.time.short.minute");
            time = (days > 0 ? daysStr : "") + (days < 1 && hours > 0 ? hourStr : "") + (days < 1 ? minutesStr : "");
            componentsRef.lbl_storeTime.text = time;
            price = data.price;
            if(price <= 0)
            {
               componentsRef.lbl_itemPrice.text = "--------";
               componentsRef.iconKama.visible = false;
            }
            else
            {
               componentsRef.lbl_itemPrice.text = utilApi.kamasToString(price,"");
               componentsRef.iconKama.visible = true;
            }
            if(data.itemWrapper.info1)
            {
               componentsRef.lbl_itemStack.text = data.itemWrapper.info1;
            }
            else
            {
               componentsRef.lbl_itemStack.text = "1";
            }
         }
         else
         {
            componentsRef.chk_remove.visible = false;
            componentsRef.tx_itemBg.visible = false;
            componentsRef.tx_itemIcon.uri = null;
            componentsRef.lbl_itemName.text = "";
            componentsRef.lbl_storeTime.text = "";
            componentsRef.lbl_itemPrice.text = "";
            componentsRef.iconKama.visible = false;
            componentsRef.lbl_itemStack.text = "";
         }
         componentsRef.btn_gridItem.selected = selected;
      }
      
      public function updateOtherItem(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!this._componentList[componentsRef.tx_otherItemBg.name])
            {
               uiApi.addComponentHook(componentsRef.tx_otherItemBg,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.tx_otherItemBg,ComponentHookList.ON_ROLL_OUT);
               uiApi.addComponentHook(componentsRef.tx_otherItemBg,ComponentHookList.ON_RIGHT_CLICK);
            }
            if(!this._componentList[componentsRef.tx_otherItemIcon.name])
            {
               uiApi.addComponentHook(componentsRef.tx_otherItemIcon,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.tx_otherItemIcon,ComponentHookList.ON_ROLL_OUT);
               uiApi.addComponentHook(componentsRef.tx_otherItemIcon,ComponentHookList.ON_RIGHT_CLICK);
            }
            this._componentList[componentsRef.tx_otherItemBg.name] = data;
            this._componentList[componentsRef.tx_otherItemIcon.name] = data;
            componentsRef.tx_otherItemBg.visible = true;
            componentsRef.tx_otherItemIcon.uri = data.itemWrapper.iconUri;
            componentsRef.otherIconKama.visible = true;
            componentsRef.lbl_otherItemPrice.text = utilApi.kamasToString(data.price,"");
            componentsRef.lbl_otherItemSlot.text = data.stack;
         }
         else
         {
            componentsRef.tx_otherItemBg.visible = false;
            componentsRef.tx_otherItemIcon.uri = null;
            componentsRef.otherIconKama.visible = false;
            componentsRef.lbl_otherItemPrice.text = "";
            componentsRef.lbl_otherItemSlot.text = "";
         }
      }
      
      public function getItemLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         return "ctr_itemLine";
      }
      
      private function updateTax() : void
      {
         var currentPrice:Number = utilApi.stringToKamas(input_price.text,"");
         if(this._mode || currentPrice != this._oldPrice)
         {
            if(this.sellerDescriptor.taxPercentage == 0)
            {
               this._tax = 0;
            }
            else if(this._mode)
            {
               this._tax = Math.max(1,Math.round(currentPrice * this.sellerDescriptor.taxPercentage / 100));
            }
            else if(this._oldPrice < currentPrice)
            {
               this._tax = Math.max(1,Math.round((currentPrice - this._oldPrice) * this.sellerDescriptor.taxPercentage / 100));
            }
            else
            {
               this._tax = Math.max(1,Math.round(currentPrice * this.sellerDescriptor.taxModificationPercentage / 100));
            }
            this.iconKamaTaxTime.visible = true;
            this.lbl_taxTime.text = utilApi.kamasToString(this._tax,"");
            if(this._mode)
            {
               this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreTax") + uiApi.getText("ui.common.colon") + this.sellerDescriptor.taxPercentage + "%";
            }
            else
            {
               this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreModificationTax") + uiApi.getText("ui.common.colon") + this.sellerDescriptor.taxModificationPercentage + "%";
            }
            if(this._tax > playerApi.characteristics().kamas)
            {
               btn_valid.softDisabled = true;
               this.lbl_taxTimeTitle.cssClass = "redleft";
            }
            else
            {
               if(!this._maxQuantityReached && utilApi.stringToKamas(input_price.text,"") > 0)
               {
                  btn_valid.softDisabled = false;
               }
               this.lbl_taxTimeTitle.cssClass = "left";
            }
            btn_valid.handCursor = !btn_valid.softDisabled;
            this.changeTooltipTextForButtonValid();
         }
      }
      
      public function getTax(oldPrice:uint, newPrice:uint) : uint
      {
         if(this.sellerDescriptor.taxPercentage == 0)
         {
            this._tax = 0;
         }
         else if(this._mode)
         {
            this._tax = Math.max(1,Math.round(newPrice * this.sellerDescriptor.taxPercentage / 100));
         }
         else if(oldPrice < newPrice)
         {
            this._tax = Math.max(1,Math.round((newPrice - oldPrice) * this.sellerDescriptor.taxPercentage / 100));
         }
         else
         {
            this._tax = Math.max(1,Math.round(newPrice * this.sellerDescriptor.taxModificationPercentage / 100));
         }
         return this._tax;
      }
      
      public function canAffordTax(tax:uint) : Boolean
      {
         var kamas:uint = playerApi.characteristics().kamas;
         return tax <= kamas;
      }
      
      private function changeTooltipTextForButtonValid() : void
      {
         if(this._maxQuantityReached)
         {
            this._tooltipTextButtonValid = uiApi.getText("ui.bidhouse.cantSellLimit");
         }
         else if(utilApi.stringToKamas(input_price.text,"") <= 0)
         {
            this._tooltipTextButtonValid = uiApi.getText("ui.bidhouse.cantSellMinimumPrice");
         }
         else if(this._tax > playerApi.characteristics().kamas)
         {
            this._tooltipTextButtonValid = uiApi.getText("ui.bidhouse.cantSellTax");
         }
      }
      
      protected function updateLabelQuantitySoldObject() : void
      {
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            this.lbl_quantityObject.visible = false;
            this.lbl_sumPrices.visible = false;
         }
         else
         {
            this.lbl_quantityObject.visible = true;
            this.lbl_sumPrices.visible = true;
            this.lbl_quantityObject.text = uiApi.getText("ui.bidhouse.slotOfSale",this.gd_itemList.dataProvider.length + "/" + this.sellerDescriptor.maxItemPerAccount);
            this.lbl_sumPrices.text = utilApi.kamasToString(this._totalObjectPrice,"");
         }
      }
      
      private function searchSameItemsInAuctionHouse(item:Object, autoSelect:Boolean = false) : void
      {
         if(autoSelect)
         {
            this._currentItemSelected = item;
            return;
         }
         if(this._currentItemSelected)
         {
            sysApi.sendAction(new ExchangeBidHouseSearchAction([this._currentItemSelected.typeId,this._currentItemSelected.objectGID,false]));
         }
         this._currentItemSelected = item;
         sysApi.sendAction(new ExchangeBidHouseSearchAction([item.typeId,item.objectGID,true]));
      }
      
      private function putOnSell() : void
      {
         var params:Object = null;
         var unityPrice:Number = this._price / int(TradeCenter.QUANTITIES[this._exchangeQuantity]);
         if(this._sellPopupName == null && this._averagePrice > -1 && (unityPrice * RELATION_MINI_FOR_WARNING_POPUP < this._averagePrice || unityPrice > this._averagePrice * RELATION_MINI_FOR_WARNING_POPUP))
         {
            params = {};
            params.item = _currentObject;
            params.stack = TradeCenter.QUANTITIES[this._exchangeQuantity];
            params.unityPrice = utilApi.kamasToString(unityPrice,"");
            params.price = utilApi.kamasToString(this._price,"");
            params.tax = utilApi.kamasToString(this._tax,"");
            this._sellPopupName = this.modTradeCenter.openAuctionHousePutOnSellPopup(uiApi.getText("ui.bidhouse.confirmPutOnSell") + uiApi.getText("ui.common.colon"),params,[this.onConfirmSellObject,this.onCancelSellObject],this.onConfirmSellObject,this.onCancelSellObject);
         }
         else
         {
            this.onConfirmSellObject();
         }
      }
      
      private function putOnSellAgain() : void
      {
         var params:Object = null;
         var unityPrice:Number = this._price / int(TradeCenter.QUANTITIES[this._exchangeQuantity]);
         if(this._sellPopupName == null && this._averagePrice > -1 && (unityPrice * RELATION_MINI_FOR_WARNING_POPUP < this._averagePrice || unityPrice > this._averagePrice * RELATION_MINI_FOR_WARNING_POPUP))
         {
            params = {};
            params.item = _currentObject;
            params.stack = TradeCenter.QUANTITIES[this._exchangeQuantity];
            params.oldPrice = utilApi.kamasToString(this._oldPrice,"");
            params.price = utilApi.kamasToString(this._price,"");
            params.tax = utilApi.kamasToString(this._tax,"");
            this._sellPopupName = this.modTradeCenter.openAuctionHousePutOnSellPopup(uiApi.getText("ui.bidhouse.confirmPutOnSellAgain") + uiApi.getText("ui.common.colon"),params,[this.onConfirmModifyObject,this.onCancelSellObject],this.onConfirmModifyObject,this.onCancelSellObject);
         }
         else
         {
            this.onConfirmModifyObject();
         }
      }
      
      private function withdrawFromSell() : void
      {
         if(this._sellPopupName == null && this._currentObjectToRemove)
         {
            this._sellPopupName = this.modTradeCenter.openAuctionHouseWithdrawPopup(uiApi.getText("ui.bidhouse.confirmWithdrawal"),this,false,[this._currentObjectToRemove],[this.onConfirmWithdrawObject,this.onCancelSellObject],this.onConfirmWithdrawObject,this.onCancelSellObject);
         }
      }
      
      private function withdrawAllFromSell() : void
      {
         if(this._sellPopupName == null)
         {
            this._sellPopupName = this.modTradeCenter.openAuctionHouseWithdrawPopup(uiApi.getText("ui.bidhouse.confirmWithdrawal"),this,true,this._allItemsToRemove,[this.onConfirmWithdrawAllObject,this.onCancelSellObject],this.onConfirmWithdrawAllObject,this.onCancelSellObject);
         }
      }
      
      private function displayItemTooltip(target:Object, item:Object) : void
      {
         var setting:String = null;
         var settings:Object = {};
         var itemTooltipSettings:ItemTooltipSettings = sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
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
         uiApi.showTooltip(item.itemWrapper,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,3,null,null,settings);
      }
      
      override protected function hideCard(hide:Boolean = true) : void
      {
         this.ctr_currentItemDetails.visible = !hide;
         if(!this.ctr_currentItemDetails.visible)
         {
            this.lbl_selectItemList.visible = true;
            this.blk_otherItems.visible = false;
            if(this.gd_itemList.dataProvider.length <= 0)
            {
               this.lbl_selectItemList.text = uiApi.getText("ui.bidhouse.selectItemInventory");
            }
            else
            {
               this.lbl_selectItemList.text = uiApi.getText("ui.bidhouse.selectItemList");
            }
         }
         else
         {
            this.lbl_selectItemList.visible = false;
         }
         if(hide && !_currentObject)
         {
            this.gd_otherItemList.dataProvider = [];
         }
      }
      
      private function filterItems(searchCriteria:String) : void
      {
         var item:Object = null;
         var itemsWithCriteria:Array = [];
         for each(item in this._itemsToSale)
         {
            if(utilApi.noAccent(item.itemWrapper.name).toLowerCase().indexOf(searchCriteria) != -1)
            {
               itemsWithCriteria.push(item);
            }
         }
         this.updateItemListData(itemsWithCriteria);
      }
      
      private function parseObjectsInfos(objectsInfos:Object) : void
      {
         var object:Object = null;
         var objectInfo:Object = null;
         var dataProvider:Array = [];
         this._totalObjectPrice = 0;
         for each(objectInfo in objectsInfos)
         {
            object = {};
            object.itemWrapper = dataApi.getItemWrapper(objectInfo.objectGID,0,objectInfo.objectUID,objectInfo.quantity,objectInfo.effects);
            object.price = objectInfo.objectPrice;
            object.unsoldDelay = objectInfo.unsoldDelay;
            object.selected = false;
            this._totalObjectPrice += object.price;
            dataProvider.push(object);
         }
         this._itemsToSale = dataProvider.concat();
         this.updateItemListData(dataProvider);
         this.updateLabelQuantitySoldObject();
      }
      
      private function updateItemListData(dataProvider:Array) : void
      {
         this.gd_itemList.dataProvider = this.sortItemList(dataProvider,this._sortCriteria);
         this.chk_all.selected = this._allItemsToRemove.length == this._itemsToSale.length && this._allItemsToRemove.length > 0;
         if(this.gd_itemList.dataProvider.length <= 0)
         {
            this.gd_itemList.visible = false;
            this.lbl_selectItemInventory.visible = true;
         }
         else
         {
            this.gd_itemList.visible = true;
            this.lbl_selectItemInventory.visible = false;
         }
         if(!_currentObject)
         {
            this.hideCard();
         }
      }
      
      private function sortItemList(arrayToSort:Array, sortField:String) : Array
      {
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
            case "unsoldDelay":
               this.displaySortArrows(false,true,false,false);
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByUnsoldDelay);
               }
               else
               {
                  dataProvider.sort(this.sortByUnsoldDelay,Array.DESCENDING);
               }
               break;
            case "stack":
               this.displaySortArrows(false,false,true,false);
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByStack);
               }
               else
               {
                  dataProvider.sort(this.sortByStack,Array.DESCENDING);
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
         return dataProvider;
      }
      
      private function displaySortArrows(name:Boolean, storeTime:Boolean, stack:Boolean, price:Boolean) : void
      {
         this.tx_sortNameDown.visible = name && this._ascendingSort;
         this.tx_sortNameUp.visible = name && !this._ascendingSort;
         this.tx_sortStoreTimeDown.visible = storeTime && this._ascendingSort;
         this.tx_sortStoreTimeUp.visible = storeTime && !this._ascendingSort;
         this.tx_sortStackDown.visible = stack && this._ascendingSort;
         this.tx_sortStackUp.visible = stack && !this._ascendingSort;
         this.tx_sortPriceDown.visible = price && this._ascendingSort;
         this.tx_sortPriceUp.visible = price && !this._ascendingSort;
      }
      
      private function sortByName(firstItem:Object, secondItem:Object, forceAscending:Boolean = false) : int
      {
         var firstValue:String = utilApi.noAccent(firstItem.itemWrapper.name);
         var secondValue:String = utilApi.noAccent(secondItem.itemWrapper.name);
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
      
      private function sortByPrice(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:uint = firstItem.price;
         var secondValue:uint = secondItem.price;
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
      
      private function sortByUnsoldDelay(firstItem:Object, secondItem:Object) : int
      {
         var hoursF1:int = Math.floor(firstItem.unsoldDelay / 3600);
         var minutesF1:int = Math.floor(firstItem.unsoldDelay % (24 * 3600) % 3600 / 60);
         var hoursF2:int = Math.floor(secondItem.unsoldDelay / 3600);
         var minutesF2:int = Math.floor(secondItem.unsoldDelay % (24 * 3600) % 3600 / 60);
         var firstValue:int = hoursF1 < 1 ? int(minutesF1) : int(hoursF1);
         var secondValue:int = hoursF2 < 1 ? int(minutesF2) : int(hoursF2);
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
      
      private function sortByStack(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:int = !!firstItem.itemWrapper.info1 ? int(firstItem.itemWrapper.info1) : 1;
         var secondValue:int = !!secondItem.itemWrapper.info1 ? int(secondItem.itemWrapper.info1) : 1;
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
      
      private function itemSelectedToBeRemoved(item:Object) : Boolean
      {
         var itemToRemoved:Object = null;
         for each(itemToRemoved in this._allItemsToRemove)
         {
            if(itemToRemoved.itemWrapper.objectUID == item.itemWrapper.objectUID)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getCurrentObject(element:*, index:int, arr:Array) : Boolean
      {
         this._currentObjectToRemove = element;
         return element.itemWrapper.objectUID == _currentObject.objectUID;
      }
      
      private function selectAllItemsToRemove(select:Boolean) : void
      {
         var item:Object = null;
         if(select)
         {
            for each(item in this.gd_itemList.dataProvider)
            {
               if(this._allItemsToRemove.indexOf(item) == -1)
               {
                  item.selected = select;
                  this._allItemsToRemove.push(item);
               }
            }
         }
         else
         {
            for each(item in this.gd_itemList.dataProvider)
            {
               if(this._allItemsToRemove.indexOf(item) != -1)
               {
                  item.selected = select;
               }
            }
            this._allItemsToRemove = [];
         }
         this.hideCard();
         this.lbl_selectItemList.visible = !(this._allItemsToRemove.length > 1 && !this.checkItemToModify());
         this.lbl_modifyMultipleError.visible = this._allItemsToRemove.length > 1 && !this.checkItemToModify();
         this.ctr_sellingGroup.visible = false;
         this.lbl_error.visible = false;
         btn_valid.visible = false;
         btn_modify.visible = false;
         btn_remove.visible = false;
         this.btn_removeItems.disabled = this._allItemsToRemove.length <= 0;
         if(select)
         {
            this.onSelectItemFromStockItemList(this.gd_itemList.dataProvider[0]);
            this.gd_itemList.selectedItem = this.gd_itemList.dataProvider[0];
         }
         this.gd_itemList.updateItems();
      }
      
      private function itemHasVariableEffect(currentObject:Object) : Boolean
      {
         var effectinstance:EffectInstanceDice = null;
         for each(effectinstance in currentObject.possibleEffects)
         {
            if(effectinstance.diceSide > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function onSellerObjectListUpdate(vendorObjects:Object) : void
      {
         var item:Object = null;
         var object:Object = null;
         var i:int = 0;
         var j:int = 0;
         if(this._removing && vendorObjects.length > this._nbOfObjectAfterRemove)
         {
            return;
         }
         var nbObjectForSale:int = 0;
         this._totalObjectPrice = 0;
         this._itemsToSale = [];
         this._removing = false;
         for each(object in vendorObjects)
         {
            item = {};
            nbObjectForSale++;
            this._totalObjectPrice += object.price;
            item.itemWrapper = object.itemWrapper;
            item.price = object.price;
            item.unsoldDelay = object.unsoldDelay;
            item.selected = this.itemSelectedToBeRemoved(item);
            this._itemsToSale.push(item);
         }
         if(nbObjectForSale >= this.sellerDescriptor.maxItemPerAccount)
         {
            this._maxQuantityReached = true;
         }
         else
         {
            this._maxQuantityReached = false;
         }
         if(this._maxQuantityReached && this._mode)
         {
            btn_valid.softDisabled = true;
            this.changeTooltipTextForButtonValid();
         }
         else
         {
            btn_valid.softDisabled = false;
         }
         var itemsToRemoveCount:int = this._allItemsToRemove.length;
         var itemsToSellCount:int = this._itemsToSale.length;
         for(var newItemsToRemove:Array = []; i < itemsToRemoveCount; )
         {
            while(j < itemsToSellCount)
            {
               if(this._allItemsToRemove[i].itemWrapper.objectUID == this._itemsToSale[j].itemWrapper.objectUID)
               {
                  newItemsToRemove.push(this._itemsToSale[j]);
                  break;
               }
               j++;
            }
            i++;
         }
         this._allItemsToRemove = newItemsToRemove;
         btn_valid.handCursor = !btn_valid.softDisabled;
         this.updateItemListData(this._itemsToSale);
         this.updateLabelQuantitySoldObject();
      }
      
      public function onSelectItemFromInventory(selectedItem:Object, autoselect:Boolean = false) : void
      {
         var effect:* = undefined;
         var dataProvider:Array = null;
         var nQuantities:int = 0;
         var i:int = 0;
         var q:uint = 0;
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            return;
         }
         this._mode = true;
         onObjectSelected(selectedItem);
         this.searchSameItemsInAuctionHouse(selectedItem,autoselect);
         this._itemName = selectedItem.name;
         this.lbl_quantity.visible = false;
         this.cb_quantity.visible = true;
         if(selectedItem.name == selectedItem.realName)
         {
            this.cb_quantity.disabled = false;
         }
         else
         {
            this.cb_quantity.disabled = true;
         }
         this.ctr_sellingGroup.visible = false;
         this.lbl_modifyMultipleError.visible = false;
         this.lbl_error.visible = false;
         btn_valid.softDisabled = true;
         btn_valid.handCursor = !btn_valid.softDisabled;
         this.changeTooltipTextForButtonValid();
         this.iconKamaTaxTime.visible = true;
         this.lbl_taxTime.text = "";
         this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreTax") + uiApi.getText("ui.common.colon");
         this.lbl_taxTimeTitle.cssClass = "left";
         var allowedType:Boolean = false;
         var nonExchangeable:Boolean = false;
         var nType:int = this.sellerDescriptor.types.length;
         for(var t:int = 0; t < nType; t++)
         {
            if(this.sellerDescriptor.types[t] == _currentObject.typeId)
            {
               allowedType = true;
               for each(effect in _currentObject.effects)
               {
                  if(effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE_STRONG || effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE || effect.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)
                  {
                     nonExchangeable = true;
                  }
               }
               break;
            }
         }
         if(!_currentObject.isSaleable)
         {
            this.lbl_error.text = uiApi.getText("ui.bidhouse.notSaleable");
            this.lbl_error.visible = true;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
         }
         else if(!allowedType)
         {
            this.lbl_error.text = uiApi.getText("ui.bidhouse.badType");
            this.lbl_error.visible = true;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
         }
         else if(nonExchangeable)
         {
            this.lbl_error.text = uiApi.getText("ui.bidhouse.badExchange");
            this.lbl_error.visible = true;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
         }
         else if(_currentObject.level > this.sellerDescriptor.maxItemLevel)
         {
            this.lbl_error.text = uiApi.getText("ui.bidhouse.badLevel");
            this.lbl_error.visible = true;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
         }
         else
         {
            dataProvider = [];
            nQuantities = TradeCenter.QUANTITIES.length;
            for(i = 0; i < nQuantities; i++)
            {
               q = TradeCenter.QUANTITIES[i];
               if(_currentObject.quantity >= q)
               {
                  dataProvider.push({
                     "label":String(q),
                     "quantity":i + 1
                  });
               }
            }
            this.cb_quantity.dataProvider = dataProvider;
            if(selectedItem.name == selectedItem.realName)
            {
               if(TradeCenter.SALES_QUANTITIES[selectedItem.objectGID] && TradeCenter.SALES_QUANTITIES[selectedItem.objectGID] <= this.cb_quantity.dataProvider.length)
               {
                  this.cb_quantity.selectedIndex = TradeCenter.SALES_QUANTITIES[selectedItem.objectGID] - 1;
               }
               else
               {
                  this.cb_quantity.selectedIndex = dataProvider.length - 1;
               }
            }
            else
            {
               this.cb_quantity.selectedIndex = 0;
            }
            btn_valid.visible = true;
            btn_remove.visible = false;
            btn_modify.visible = false;
            if(this._maxQuantityReached)
            {
               btn_valid.softDisabled = true;
            }
            else
            {
               btn_valid.softDisabled = false;
            }
            if(TradeCenter.SALES_PRICES[selectedItem.objectGID] && TradeCenter.SALES_PRICES[selectedItem.objectGID][this.cb_quantity.value.quantity - 1])
            {
               input_price.text = utilApi.kamasToString(TradeCenter.SALES_PRICES[selectedItem.objectGID][this.cb_quantity.value.quantity - 1],"");
               btn_valid.softDisabled = false;
            }
            else
            {
               input_price.text = "0";
               btn_valid.softDisabled = true;
            }
            btn_valid.handCursor = !btn_valid.softDisabled;
            input_price.focus();
            input_price.setSelection(0,8388607);
            this.updateTax();
            this.ctr_sellingGroup.visible = true;
         }
         sysApi.sendAction(new ExchangeBidHousePriceAction([_currentObject.objectGID]));
      }
      
      public function onSelectItemFromStockItemList(selectedItem:Object) : void
      {
         if(selectedItem == null)
         {
            return;
         }
         if(this._allItemsToRemove.length > 1 && !this.checkItemToModify())
         {
            this.hideCard();
            this.lbl_selectItemList.visible = false;
            this.lbl_modifyMultipleError.visible = true;
            this.ctr_sellingGroup.visible = false;
            this.lbl_error.visible = false;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
            return;
         }
         this._mode = false;
         var itemToDisplay:Object = selectedItem;
         if(this._allItemsToRemove.length > 1)
         {
            itemToDisplay = this._allItemsToRemove[this._allItemsToRemove.length - 1];
         }
         onObjectSelected(itemToDisplay.itemWrapper);
         this.searchSameItemsInAuctionHouse(itemToDisplay.itemWrapper);
         this.cb_quantity.visible = false;
         this.lbl_quantity.visible = true;
         this.ctr_sellingGroup.visible = true;
         this.lbl_error.visible = false;
         this.lbl_modifyMultipleError.visible = false;
         this._exchangeQuantity = TradeCenter.QUANTITIES.indexOf(_currentObject.quantity);
         var item:Item = dataApi.getItem(_currentObject.objectGID);
         this._itemName = item.name;
         input_price.text = itemToDisplay.price;
         btn_modify.softDisabled = this._oldPrice == itemToDisplay.price && this._allItemsToRemove.length <= 1 || this._allItemsToRemove.length > 1 && this.allItemHaveSamePrice();
         btn_modify.handCursor = !btn_modify.softDisabled;
         this._oldPrice = itemToDisplay.price;
         input_price.focus();
         input_price.setSelection(0,8388607);
         this.lbl_quantity.text = _currentObject.quantity.toString();
         sysApi.sendAction(new ExchangeBidHousePriceAction([_currentObject.objectGID]));
         this.lbl_taxTimeTitle.cssClass = "left";
         this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreTime") + uiApi.getText("ui.common.colon");
         var days:int = Math.floor(selectedItem.unsoldDelay / (24 * 3600));
         var hours:int = Math.floor(selectedItem.unsoldDelay % (24 * 3600) / 3600);
         var minutes:int = Math.floor(selectedItem.unsoldDelay % (24 * 3600) % 3600 / 60);
         var daysStr:* = days + " " + uiApi.getText("ui.time.short.day") + " ";
         var hourStr:* = (hours > 0 ? (hours < 10 ? "0" + hours : hours) : "00") + " " + uiApi.getText("ui.time.short.hour") + " ";
         var minutesStr:String = (minutes > 0 ? (minutes < 10 ? "0" + minutes : minutes) : "00") + " " + uiApi.getText("ui.time.short.minute");
         var time:String = (days > 0 ? daysStr : "") + (days < 1 && hours > 0 ? hourStr : "") + (days < 1 ? minutesStr : "");
         this.lbl_taxTime.text = time;
         this.iconKamaTaxTime.visible = false;
         btn_valid.visible = false;
         btn_remove.visible = true;
         btn_modify.visible = true;
      }
      
      private function allItemHaveSamePrice() : Boolean
      {
         var item:Object = null;
         var price:uint = this._allItemsToRemove[0].price;
         for each(item in this._allItemsToRemove)
         {
            if(item.price != price)
            {
               return false;
            }
         }
         return true;
      }
      
      private function checkItemToModify() : Boolean
      {
         var itemStack:int = 0;
         var firstItem:* = this._allItemsToRemove[0];
         var firstItemStack:int = !!this._allItemsToRemove[0].itemWrapper.info1 ? int(this._allItemsToRemove[0].itemWrapper.info1) : 1;
         for(var i:int = 1; i < this._allItemsToRemove.length; i++)
         {
            itemStack = !!this._allItemsToRemove[i].itemWrapper.info1 ? int(this._allItemsToRemove[i].itemWrapper.info1) : 1;
            if(itemStack != firstItemStack || this._allItemsToRemove[i].itemWrapper.objectGID != firstItem.itemWrapper.objectGID)
            {
               return false;
            }
         }
         return true;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var priceChanged:* = false;
         var item:Object = null;
         switch(target)
         {
            case btn_valid:
               if(this._mode || !_isSellingItem)
               {
                  this._price = utilApi.stringToKamas(input_price.text,"");
                  if(this._price > 0)
                  {
                     this.putOnSell();
                  }
               }
               break;
            case btn_modify:
               if(!this._mode || !_isSellingItem)
               {
                  this._price = utilApi.stringToKamas(input_price.text,"");
                  priceChanged = this._price != this._oldPrice;
                  if((priceChanged || this._allItemsToRemove.length > 1) && this._price > 0)
                  {
                     this.putOnSellAgain();
                  }
               }
               break;
            case btn_remove:
               if(!this._mode)
               {
                  this._currentObjectToRemove = {};
                  if(this._itemsToSale.some(this.getCurrentObject))
                  {
                     this.withdrawFromSell();
                  }
                  else
                  {
                     this._currentObjectToRemove = null;
                  }
               }
               break;
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
               this.btn_resetSearch.visible = false;
               this.updateItemListData(this._itemsToSale);
               break;
            case this.btn_removeItems:
               this.withdrawAllFromSell();
               break;
            case this.chk_all:
               this.selectAllItemsToRemove(this.chk_all.selected);
               break;
            case this.btn_tabName:
               this._ascendingSort = this._sortCriteria == "name" ? !this._ascendingSort : true;
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"name");
               break;
            case this.btn_tabStoreTime:
               this._ascendingSort = this._sortCriteria == "unsoldDelay" ? !this._ascendingSort : true;
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"unsoldDelay");
               break;
            case this.btn_tabStack:
               this._ascendingSort = this._sortCriteria == "stack" ? !this._ascendingSort : true;
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"stack");
               break;
            case this.btn_tabPrice:
               this._ascendingSort = this._sortCriteria == "price" ? !this._ascendingSort : true;
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"price");
               break;
            default:
               if(target.name.indexOf("chk_remove") != -1)
               {
                  item = this._componentList[target.name];
                  item.selected = !item.selected;
                  this.gd_itemList.updateItem(this.gd_itemList.selectedIndex);
                  if(item.selected)
                  {
                     this._allItemsToRemove.push(item);
                  }
                  else
                  {
                     this._allItemsToRemove.splice(this._allItemsToRemove.indexOf(item),1);
                  }
                  if(this._allItemsToRemove.length > 0 && this.checkItemToModify())
                  {
                     this.onSelectItemFromStockItemList(this.gd_itemList.dataProvider[this.gd_itemList.dataProvider.indexOf(this._allItemsToRemove[this._allItemsToRemove.length - 1])]);
                  }
                  this.chk_all.selected = this._allItemsToRemove.length == this._itemsToSale.length && this._allItemsToRemove.length > 0;
                  this.btn_removeItems.disabled = this._allItemsToRemove.length <= 0;
               }
         }
      }
      
      private function onExchangeBidPriceForSeller(genericId:uint, averagePrice:Number, minimalPrices:Object, allIdentical:Boolean) : void
      {
         var o:Object = null;
         var price:Number = NaN;
         this._averagePrice = averagePrice;
         if(averagePrice != -1)
         {
            this.lbl_averagePrice.text = utilApi.kamasToString(averagePrice,"");
            this.iconKamaAveragePrice.visible = true;
         }
         else
         {
            this.lbl_averagePrice.text = uiApi.getText("ui.item.averageprice.unavailable");
            this.iconKamaAveragePrice.visible = false;
         }
         var minimalPricesExist:Boolean = false;
         var tmpPrices:Vector.<Number> = new Vector.<Number>();
         for each(o in minimalPrices)
         {
            tmpPrices.push(o);
         }
         if(minimalPrices && tmpPrices.length == this.sellerDescriptor.quantities.length)
         {
            for each(price in tmpPrices)
            {
               if(price > 0)
               {
                  minimalPricesExist = true;
                  break;
               }
            }
         }
         if(!minimalPricesExist)
         {
            this.blk_otherItems.visible = false;
            this.lbl_noCurrentPrice.visible = true;
         }
         else
         {
            this.blk_otherItems.visible = true;
            this.lbl_noCurrentPrice.visible = false;
         }
      }
      
      public function onBidObjectListUpdate(items:Object, itemGID:int, update:Boolean = false, newObjectType:Boolean = false) : void
      {
         var item:Object = null;
         var i:uint = 0;
         var stack:uint = 0;
         var itemInfos:Object = null;
         var itemType:ItemType = null;
         var dataProvider:Array = null;
         var key:* = null;
         var displayOtherItems:Boolean = false;
         var currentKey:* = null;
         this._currentSameItemsInAuctionHouse = new Dictionary(true);
         for each(item in items)
         {
            for(i = 0; i < item.prices.length; i++)
            {
               if(item.prices[i] != 0)
               {
                  stack = Math.pow(10,i);
                  if(!this._currentSameItemsInAuctionHouse[stack])
                  {
                     this._currentSameItemsInAuctionHouse[stack] = [];
                  }
                  itemInfos = {
                     "itemWrapper":item.itemWrapper,
                     "price":item.prices[i],
                     "stack":stack
                  };
                  this._currentSameItemsInAuctionHouse[stack].push(itemInfos);
               }
            }
         }
         if(!this._currentSameItemsInAuctionHouse[this._currentStackFilter])
         {
            this._currentSameItemsInAuctionHouse[this._currentStackFilter] = [];
         }
         this._currentSameItemsInAuctionHouse[this._currentStackFilter] = this._currentSameItemsInAuctionHouse[this._currentStackFilter].sort(this.sortByPrice);
         if(_currentObject)
         {
            itemType = dataApi.getItemType(_currentObject.typeId);
            if(!this.itemHasVariableEffect(_currentObject) || this._currentType == CONSUMABLE_CATEGORY || this._currentType == RESOURCE_CATEGORY || this._currentType == RUNE_CATEGORY)
            {
               dataProvider = [];
               for(key in this._currentSameItemsInAuctionHouse)
               {
                  dataProvider = dataProvider.concat(this._currentSameItemsInAuctionHouse[key]);
               }
               this.cb_stack.visible = this.bgcb_stack.visible = false;
               this.btn_tabOtherStack.visible = true;
               this.gd_otherItemList.dataProvider = dataProvider;
            }
            else
            {
               this.cb_stack.visible = this.bgcb_stack.visible = true;
               this.btn_tabOtherStack.visible = false;
               this.gd_otherItemList.dataProvider = this._currentSameItemsInAuctionHouse[this._currentStackFilter];
            }
         }
         if(this.gd_otherItemList.dataProvider.length > 0)
         {
            this.blk_otherItems.visible = true;
         }
         else
         {
            displayOtherItems = false;
            for(currentKey in this._currentSameItemsInAuctionHouse)
            {
               if(this._currentSameItemsInAuctionHouse[currentKey] && this._currentSameItemsInAuctionHouse[currentKey].length > 0)
               {
                  displayOtherItems = true;
                  break;
               }
            }
            this.blk_otherItems.visible = displayOtherItems;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_quantity:
               if(_currentObject == null)
               {
                  break;
               }
               this._exchangeQuantity = (target as ComboBox).value.quantity - 1;
               if(TradeCenter.SALES_PRICES[_currentObject.objectGID] && TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity])
               {
                  input_price.text = utilApi.kamasToString(TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity],"");
                  input_price.focus();
                  input_price.setSelection(0,8388607);
                  btn_valid.softDisabled = false;
                  this.updateTax();
               }
               else
               {
                  input_price.text = "0";
                  btn_valid.softDisabled = true;
                  this.updateTax();
               }
               break;
            case this.gd_itemList:
               if(selectMethod != GridItemSelectMethodEnum.AUTO && (target as Grid).selectedItem && !uiApi.keyIsDown(Keyboard.SHIFT))
               {
                  this.onSelectItemFromStockItemList((target as Grid).selectedItem);
               }
               break;
            case this.cb_stack:
               this._currentStackFilter = int(this.cb_stack.value);
               if(this._currentItemSelected)
               {
                  this.searchSameItemsInAuctionHouse(this._currentItemSelected);
               }
         }
      }
      
      override public function onChange(target:GraphicContainer) : void
      {
         var currentPrice:Number = NaN;
         if(target as Input == input_price && input_price.haveFocus)
         {
            currentPrice = utilApi.stringToKamas(input_price.text,"");
            if(currentPrice > ProtocolConstantsEnum.MAX_KAMA)
            {
               currentPrice = ProtocolConstantsEnum.MAX_KAMA;
               input_price.text = utilApi.kamasToString(currentPrice,"");
            }
            btn_modify.softDisabled = this._allItemsToRemove.length <= 1 && this._oldPrice == currentPrice || currentPrice == 0 || this._oldPrice == currentPrice && this._allItemsToRemove.length > 1 && this.allItemHaveSamePrice();
            btn_modify.handCursor = !btn_modify.softDisabled;
            this.updateTax();
            if(currentPrice <= 0 || this._maxQuantityReached || this._tax > playerApi.characteristics().kamas)
            {
               btn_valid.softDisabled = true;
            }
            else
            {
               btn_valid.softDisabled = false;
            }
            btn_valid.handCursor = !btn_valid.softDisabled;
            if(!this._priceWarningPopupName && currentPrice >= PRICE_LIMIT)
            {
               this._priceWarningPopupName = modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.priceWarning"),[uiApi.getText("ui.common.ok")],[this.onPriceWarningClose],this.onPriceWarningClose,this.onPriceWarningClose);
            }
         }
      }
      
      private function onPriceWarningClose() : void
      {
         this._priceWarningPopupName = null;
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = "";
         switch(target)
         {
            case btn_valid:
               if(btn_valid.softDisabled && this._tooltipTextButtonValid != "")
               {
                  tooltipText = this._tooltipTextButtonValid;
               }
               break;
            case btn_modify:
               if(btn_modify.softDisabled)
               {
                  if(utilApi.stringToKamas(input_price.text,"") <= 0)
                  {
                     tooltipText = uiApi.getText("ui.bidhouse.cantSellMinimumPrice");
                  }
                  else
                  {
                     tooltipText = uiApi.getText("ui.bidhouse.cantModifySamePrice");
                  }
               }
               break;
            case this.btn_removeItems:
               tooltipText = uiApi.getText("ui.bidhouse.withdraw");
               break;
            case this.lbl_quantityObject:
               tooltipText = uiApi.getText("ui.bidhouse.explainSlotOfSale");
               break;
            case this.lbl_sumPrices:
               tooltipText = uiApi.getText("ui.bidhouse.totalPrice");
               break;
            case this.lbl_taxTimeTitle:
               if(this._tax > playerApi.characteristics().kamas)
               {
                  tooltipText = uiApi.getText("ui.bidhouse.cantSellTax");
               }
               else
               {
                  tooltipText = "";
               }
               break;
            case tx_item:
               uiApi.showTooltip(_currentObject,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,7,null,null,{"showEffects":false});
               break;
            default:
               tooltipText = "";
               if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
               {
                  this.currentRollOver = target.getParent();
                  if(this.currentRollOver)
                  {
                     this.currentRollOver.state = !!this.currentRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
                  this.displayItemTooltip(this.gd_itemList,this._componentList[target.name]);
               }
               else if(target.name.indexOf("tx_otherItemBg") != -1 || target.name.indexOf("tx_otherItemIcon") != -1)
               {
                  this.displayItemTooltip(this.gd_otherItemList,this._componentList[target.name]);
               }
               else if(target.name.indexOf("lbl_itemName") != -1 || target.name.indexOf("chk_remove") != -1)
               {
                  if(this.currentRollOver)
                  {
                     this.currentRollOver.state = !!this.currentRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
               }
               else if(target.name.indexOf("btn_gridItem") != -1)
               {
                  this.currentRollOver = target;
               }
               else if(target.name.indexOf("lbl_storeTime") != -1)
               {
                  if(this.currentRollOver)
                  {
                     this.currentRollOver.state = !!this.currentRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
                  this.displayUnsoldDelayTooltip(target);
               }
         }
         if(tooltipText != "")
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      private function displayUnsoldDelayTooltip(target:Object) : void
      {
         var timestamp:Date = new Date();
         timestamp.setTime(timestamp.getTime() + this._componentList[target.name].unsoldDelay * 1000);
         var tooltipText:String = uiApi.getText("ui.common.until",timeApi.getDate(timestamp.getTime(),true,true) + " " + timeApi.getClock(timestamp.getTime(),true,true));
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"unsoldDelay");
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip("tooltip_standard");
         uiApi.hideTooltip("tooltip_unsoldDelay");
         if(this.currentRollOver && (this.currentRollOver.state != StatesEnum.STATE_SELECTED_CLICKED && this.currentRollOver.state != StatesEnum.STATE_SELECTED))
         {
            this.currentRollOver.state = StatesEnum.STATE_NORMAL;
         }
      }
      
      private function onConfirmSellObject() : void
      {
         this._sellPopupName = null;
         _isSellingItem = true;
         if(_currentObject == null)
         {
            return;
         }
         sysApi.sendAction(new ExchangeShopStockMouvmentAddAction([_currentObject.objectUID,TradeCenter.QUANTITIES[this._exchangeQuantity],this._price]));
         if(!TradeCenter.SALES_PRICES[_currentObject.objectGID])
         {
            TradeCenter.SALES_PRICES[_currentObject.objectGID] = [];
         }
         TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity] = this._price;
         if(this._exchangeQuantity < this.cb_quantity.dataProvider.length)
         {
            TradeCenter.SALES_QUANTITIES[_currentObject.objectGID] = this._exchangeQuantity + 1;
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.successSell")),btn_valid,true,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      private function onConfirmModifyObject() : void
      {
         this._sellPopupName = null;
         _isSellingItem = true;
         if(this._allItemsToRemove.length <= 1)
         {
            sysApi.sendAction(new ExchangeObjectModifyPricedAction([_currentObject.objectUID,TradeCenter.QUANTITIES[this._exchangeQuantity],this._price]));
            if(!TradeCenter.SALES_PRICES[_currentObject.objectGID])
            {
               TradeCenter.SALES_PRICES[_currentObject.objectGID] = [];
            }
            TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity] = this._price;
            if(this._exchangeQuantity < this.cb_quantity.dataProvider.length)
            {
               TradeCenter.SALES_QUANTITIES[_currentObject.objectGID] = this._exchangeQuantity + 1;
            }
            _currentObject = null;
            this.hideCard();
         }
         else
         {
            this._sellPopupName = this.modTradeCenter.openAuctionHouseModifyMultiplePopup(uiApi.getText("ui.bidhouse.confirmModifyMultiple"),this,this._allItemsToRemove,this._price,[this.onConfirmModifyMultipleItems,this.onCancelSellObject],this.onConfirmModifyMultipleItems,this.onCancelSellObject);
         }
      }
      
      public function onConfirmModifyMultipleItems() : void
      {
         var item:Object = null;
         for each(item in this._allItemsToRemove)
         {
            if(item.price != this._price)
            {
               sysApi.sendAction(new ExchangeObjectModifyPricedAction([item.itemWrapper.objectUID,TradeCenter.QUANTITIES[this._exchangeQuantity],this._price]));
               if(!TradeCenter.SALES_PRICES[item.itemWrapper.objectGID])
               {
                  TradeCenter.SALES_PRICES[item.itemWrapper.objectGID] = [];
               }
               TradeCenter.SALES_PRICES[item.itemWrapper.objectGID][this._exchangeQuantity] = this._price;
               if(this._exchangeQuantity < this.cb_quantity.dataProvider.length)
               {
                  TradeCenter.SALES_QUANTITIES[item.itemWrapper.objectGID] = this._exchangeQuantity + 1;
               }
               _currentObject = null;
            }
         }
         this._allItemsToRemove = [];
         this._sellPopupName = null;
         this.chk_all.selected = false;
         this.hideCard();
      }
      
      private function onConfirmWithdrawObject() : void
      {
         this._sellPopupName = null;
         sysApi.sendAction(new ExchangeShopStockMouvmentRemoveAction([this._currentObjectToRemove.itemWrapper.objectUID,-TradeCenter.QUANTITIES[this._exchangeQuantity]]));
         if(this._allItemsToRemove.indexOf(this._currentObjectToRemove) != -1)
         {
            this._allItemsToRemove.splice(this._allItemsToRemove.indexOf(this._currentObjectToRemove),1);
         }
         _currentObject = null;
         this.hideCard();
      }
      
      private function onConfirmWithdrawAllObject() : void
      {
         var item:Object = null;
         this._sellPopupName = null;
         this._removing = true;
         this._nbOfObjectAfterRemove = this._itemsToSale.length;
         for each(item in this._allItemsToRemove)
         {
            _currentObject = item.itemWrapper;
            this._exchangeQuantity = TradeCenter.QUANTITIES.indexOf(_currentObject.quantity);
            --this._nbOfObjectAfterRemove;
            sysApi.sendAction(new ExchangeShopStockMouvmentRemoveAction([_currentObject.objectUID,-TradeCenter.QUANTITIES[this._exchangeQuantity]]));
            _currentObject = null;
         }
         this.chk_all.selected = false;
         this.lbl_modifyMultipleError.visible = false;
         this._allItemsToRemove = [];
         this.btn_removeItems.disabled = this._allItemsToRemove.length <= 0;
         this.hideCard();
      }
      
      private function onCancelSellObject() : void
      {
         this._sellPopupName = null;
         this.updateItemListData(this.gd_itemList.dataProvider);
      }
      
      public function onObjectDeleted(pObject:Object) : void
      {
         _isSellingItem = false;
         if(_currentObject && _currentObject.objectUID == pObject.objectUID)
         {
            _currentObject = null;
            if(uiApi.getUi(this._sellPopupName))
            {
               uiApi.unloadUi(this._sellPopupName);
            }
            this.hideCard();
         }
      }
      
      public function onObjectModified(item:Object) : void
      {
         _isSellingItem = false;
         if(_currentObject && _currentObject.objectUID == item.objectUID)
         {
            this.onSelectItemFromInventory(item,true);
         }
      }
      
      public function onDisplayPinnedTooltip(uiName:String, objectGID:uint, objectUID:uint = 0) : void
      {
         var setting:String = null;
         if(uiName != uiApi.me().name)
         {
            return;
         }
         var item:ItemWrapper = dataApi.getItemWrapper(objectGID,0,objectUID);
         var settings:Object = {};
         var itemTooltipSettings:ItemTooltipSettings = sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:* = sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         if(!item.objectUID)
         {
            settings.showEffects = true;
         }
         settings.pinnable = true;
         uiApi.showTooltip(item,new Rectangle(20,20,0,0),false,"standard",0,0,0,"item",null,settings,null,true);
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_search.haveFocus && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            if(this.inp_search.text.length > 2)
            {
               this._searchCriteria = utilApi.noAccent(this.inp_search.text).toLowerCase();
               this.btn_resetSearch.visible = true;
               this._searchTimer.reset();
               this._searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSearchTimerComplete);
               this._searchTimer.start();
            }
            else if(this._searchCriteria)
            {
               this._searchCriteria = null;
               this.btn_resetSearch.visible = false;
            }
            if(this.inp_search.text.length == 0)
            {
               this._searchCriteria = null;
               this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
               this.btn_resetSearch.visible = false;
               this.updateItemListData(this._itemsToSale);
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var priceChanged:* = false;
         if(!TradeCenter.BID_HOUSE_BUY_MODE)
         {
            switch(s)
            {
               case "validUi":
                  if(!_currentObject)
                  {
                     return false;
                  }
                  this.soundApi.playSoundById(SoundEnum.STORE_SELL_BUTTON);
                  if(this.ctr_sellingGroup.visible && this._mode)
                  {
                     if(!_isSellingItem)
                     {
                        this._price = utilApi.stringToKamas(input_price.text,"");
                        if(this._price > 0)
                        {
                           this.putOnSell();
                           btn_valid.focus();
                        }
                     }
                  }
                  else
                  {
                     this._price = utilApi.stringToKamas(input_price.text,"");
                     priceChanged = this._price != this._oldPrice;
                     if((priceChanged || this._allItemsToRemove.length > 1) && this._price > 0)
                     {
                        this.putOnSellAgain();
                     }
                  }
                  return true;
            }
         }
         return false;
      }
      
      protected function onSearchTimerComplete(e:TimerEvent) : void
      {
         this._searchTimer.stop();
         this._searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSearchTimerComplete);
         if(this._searchCriteria != "" && this._searchCriteria != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            this.filterItems(this._searchCriteria);
         }
         else if(this.inp_search && this._searchCriteria.length <= 2 && !this.inp_search.haveFocus && this._searchCriteria != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            this._searchCriteria = null;
            this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         }
      }
      
      override public function onRightClick(target:Object) : void
      {
         super.onRightClick(this._componentList[target.name] != null ? this._componentList[target.name].itemWrapper : target);
      }
   }
}
