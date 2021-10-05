package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class AuctionHouseWithdrawPopup
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var lbl_title_popup:Label;
      
      public var lbl_subtitle:Label;
      
      public var lbl_totalItems:Label;
      
      public var lbl_totalPrice:Label;
      
      public var btn_close_popup:ButtonContainer;
      
      public var gd_itemList:Grid;
      
      public var blk_itemList:GraphicContainer;
      
      public var popCtr:GraphicContainer;
      
      public var ctr_labelInfo:GraphicContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabStack:ButtonContainer;
      
      public var btn_tabPrice:ButtonContainer;
      
      public var btn_yes:ButtonContainer;
      
      protected const MAX_ITEM_COUNT:uint = 4;
      
      protected var _blkItemListWithoutItem:uint;
      
      protected var _popupHeightWithoutItem:uint;
      
      protected var _lblPositionWithoutItem:uint;
      
      protected var _aEventIndex:Array;
      
      protected var _componentList:Dictionary;
      
      protected var _sortCriteria:String = "name";
      
      protected var _ascendingSort:Boolean = true;
      
      protected var onCancelFunction:Function = null;
      
      protected var onEnterKey:Function = null;
      
      protected var _parent:AuctionHouseSell;
      
      protected var _withdrawAll:Boolean;
      
      public function AuctionHouseWithdrawPopup()
      {
         this._aEventIndex = new Array();
         this._componentList = new Dictionary(true);
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this._blkItemListWithoutItem = this.uiApi.me().getConstant("blkItemListWithoutItem");
         this._popupHeightWithoutItem = this.uiApi.me().getConstant("popupHeightWithoutItem");
         this._lblPositionWithoutItem = this.uiApi.me().getConstant("lblPositionWithoutItem");
         this._parent = params.parent;
         this._withdrawAll = params.withdrawAll;
         this.lbl_title_popup.text = this.uiApi.getText("ui.popup.warning");
         this.lbl_subtitle.text = params.text;
         this.gd_itemList.dataProvider = params.itemList;
         if(params.buttonCallback && params.buttonCallback[0])
         {
            this._aEventIndex["btn_yes"] = params.buttonCallback[0];
         }
         if(params.buttonCallback && params.buttonCallback[1])
         {
            this._aEventIndex["btn_no"] = params.buttonCallback[1];
         }
         if(params.onCancel)
         {
            this.onCancelFunction = params.onCancel;
         }
         if(params.onEnterKey)
         {
            this.onEnterKey = params.onEnterKey;
         }
         this.updatePopupHeight();
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function updateItem(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!this._componentList[componentsRef.tx_itemBg.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
            }
            if(!this._componentList[componentsRef.tx_itemIcon.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
            }
            if(!this._componentList[componentsRef.btn_itemRemove.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[componentsRef.tx_itemBg.name] = data;
            this._componentList[componentsRef.tx_itemIcon.name] = data;
            this._componentList[componentsRef.btn_itemRemove.name] = data;
            componentsRef.tx_itemIcon.uri = data.itemWrapper.iconUri;
            componentsRef.tx_itemIcon.visible = true;
            componentsRef.tx_itemBg.visible = true;
            componentsRef.lbl_itemName.text = data.itemWrapper.name;
            if(data.itemWrapper.info1)
            {
               componentsRef.lbl_itemQuantity.text = data.itemWrapper.info1;
            }
            else
            {
               componentsRef.lbl_itemQuantity.text = "1";
            }
            componentsRef.lbl_itemPrice.text = this.utilApi.kamasToString(data.price,"");
            componentsRef.iconKama.visible = true;
            componentsRef.btn_itemRemove.softDisabled = this.gd_itemList.dataProvider.length <= 1;
         }
         else
         {
            componentsRef.tx_itemIcon.uri = null;
            componentsRef.tx_itemIcon.visible = false;
            componentsRef.tx_itemBg.visible = false;
            componentsRef.lbl_itemName.text = "";
            componentsRef.lbl_itemQuantity.text = "";
            componentsRef.lbl_itemPrice.text = "";
            componentsRef.iconKama.visible = false;
         }
      }
      
      private function removeItem() : void
      {
         this.updatePopupHeight();
         this.uiApi.me().render();
      }
      
      protected function updatePopupHeight() : void
      {
         this.gd_itemList.updateItems();
         this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,this._sortCriteria);
         this.gd_itemList.height = Math.min(this.gd_itemList.dataProvider.length,this.MAX_ITEM_COUNT) * this.gd_itemList.slotHeight;
         this.blk_itemList.height = this._blkItemListWithoutItem + this.gd_itemList.height;
         this.blk_itemList.visible = this.gd_itemList.dataProvider.length > 0;
         this.ctr_labelInfo.y = this._lblPositionWithoutItem + this.blk_itemList.height;
         this.popCtr.height = this.blk_itemList.height + this._popupHeightWithoutItem;
         this.btn_yes.disabled = this.gd_itemList.dataProvider.length <= 0;
         this.lbl_totalItems.text = this.uiApi.getText("ui.bidhouse.numberOfItemToWithdraw",this.gd_itemList.dataProvider.length);
         this.lbl_totalPrice.text = this.utilApi.kamasToString(this.getTotalPrice(),"");
      }
      
      protected function getTotalPrice() : uint
      {
         var item:Object = null;
         var totalPrice:uint = 0;
         for each(item in this.gd_itemList.dataProvider)
         {
            totalPrice += item.price;
         }
         return totalPrice;
      }
      
      private function sortItemList(arrayToSort:Array, sortField:String) : Array
      {
         this._sortCriteria = sortField;
         var dataProvider:Array = arrayToSort;
         switch(sortField)
         {
            case "name":
               if(this._ascendingSort)
               {
                  dataProvider.sort(this.sortByName);
               }
               else
               {
                  dataProvider.sort(this.sortByName,Array.DESCENDING);
               }
               break;
            case "stack":
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
      
      private function sortByName(firstItem:Object, secondItem:Object) : int
      {
         var firstValue:String = this.utilApi.noAccent(firstItem.itemWrapper.name);
         var secondValue:String = this.utilApi.noAccent(secondItem.itemWrapper.name);
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return 0;
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
         return 0;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var itemData:Object = null;
         switch(target)
         {
            case this.btn_tabName:
               if(this._sortCriteria == "name")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"name");
               break;
            case this.btn_tabStack:
               if(this._sortCriteria == "stack")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"stack");
               break;
            case this.btn_tabPrice:
               if(this._sortCriteria == "price")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"price");
               break;
            case this.btn_tabPrice:
               if(this._sortCriteria == "price")
               {
                  this._ascendingSort = !this._ascendingSort;
               }
               this.gd_itemList.dataProvider = this.sortItemList(this.gd_itemList.dataProvider,"price");
               break;
            default:
               if(target.name.indexOf("btn_itemRemove") != -1)
               {
                  itemData = this._componentList[target.name];
                  if(this._withdrawAll)
                  {
                     if(this._parent.allItemsToRemove.indexOf(itemData) != -1)
                     {
                        itemData.selected = false;
                        this._parent.allItemsToRemove.splice(this._parent.allItemsToRemove.indexOf(itemData),1);
                        this.removeItem();
                     }
                  }
                  else if(this._parent.currentObjectToRemove == itemData)
                  {
                     this._parent.currentObjectToRemove = null;
                     this.gd_itemList.dataProvider = [];
                     this.removeItem();
                  }
               }
               else
               {
                  if(this._aEventIndex[target.name])
                  {
                     this._aEventIndex[target.name].apply(null);
                  }
                  else if(target == this.btn_close_popup && this.onCancelFunction != null)
                  {
                     this.onCancelFunction();
                  }
                  if(this.uiApi && this.uiApi.me() && this.uiApi.getUi(this.uiApi.me().name))
                  {
                     this.closeMe();
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:* = undefined;
         var settings:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var setting:String = null;
         var objVariables:* = undefined;
         var _loc7_:* = target;
         switch(0)
         {
         }
         settings = null;
         if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
         {
            data = this._componentList[target.name].itemWrapper;
            settings = {};
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(itemTooltipSettings == null)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each(setting in objVariables)
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            if(!this._componentList[target.name].itemWrapper.objectUID)
            {
               settings.showEffects = true;
            }
            settings.noFooter = true;
         }
         else if(target.name.indexOf("btn_itemRemove") != -1)
         {
            if(target.softDisabled)
            {
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.bidhouse.minimumWithdraw"));
            }
            else
            {
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.bidhouse.cancelWithdraw"));
            }
         }
         this.uiApi.showTooltip(data,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,3,null,null,settings);
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip("tooltip_standard");
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this.onEnterKey != null)
               {
                  this.onEnterKey();
               }
               this.closeMe();
               return true;
            case "closeUi":
               if(this.onCancelFunction != null)
               {
                  this.onCancelFunction();
               }
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      private function closeMe() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
   }
}
