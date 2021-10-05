package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   
   public class AuctionHouseModifyMultiplePopup extends AuctionHouseWithdrawPopup
   {
       
      
      public var lbl_totalTax:Label;
      
      public var lbl_totalOldPrice:Label;
      
      public var iconKamaTotalPrice:Texture;
      
      public var iconKamaTotalTax:Texture;
      
      private var _price:Number;
      
      private var subEnterKey:Function;
      
      private var _totalTax:uint;
      
      public function AuctionHouseModifyMultiplePopup()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         _blkItemListWithoutItem = uiApi.me().getConstant("blkItemListWithoutItem");
         _popupHeightWithoutItem = uiApi.me().getConstant("popupHeightWithoutItem");
         _lblPositionWithoutItem = uiApi.me().getConstant("lblPositionWithoutItem");
         _parent = params.parent;
         this._price = params.price;
         lbl_title_popup.text = uiApi.getText("ui.popup.warning");
         lbl_subtitle.text = params.text;
         gd_itemList.dataProvider = params.itemList;
         if(params.buttonCallback && params.buttonCallback[0])
         {
            _aEventIndex["btn_yes"] = params.buttonCallback[0];
         }
         if(params.buttonCallback && params.buttonCallback[1])
         {
            _aEventIndex["btn_no"] = params.buttonCallback[1];
         }
         if(params.onCancel)
         {
            onCancelFunction = params.onCancel;
         }
         if(params.onEnterKey)
         {
            this.subEnterKey = params.onEnterKey;
         }
         btn_tabStack.mouseEnabled = false;
         btn_tabStack.handCursor = false;
         btn_tabPrice.mouseEnabled = false;
         btn_tabPrice.handCursor = false;
         btn_tabName.mouseEnabled = false;
         btn_tabName.handCursor = false;
         _withdrawAll = true;
         this.updatePopupHeight();
      }
      
      override public function updateItem(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!_componentList[componentsRef.tx_itemBg.name])
            {
               uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
            }
            if(!_componentList[componentsRef.tx_itemIcon.name])
            {
               uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
            }
            if(!_componentList[componentsRef.btn_itemRemove.name])
            {
               uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_RELEASE);
               uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(componentsRef.btn_itemRemove,ComponentHookList.ON_ROLL_OUT);
            }
            _componentList[componentsRef.tx_itemBg.name] = data;
            _componentList[componentsRef.tx_itemIcon.name] = data;
            _componentList[componentsRef.btn_itemRemove.name] = data;
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
            componentsRef.lbl_itemOldPrice.text = utilApi.kamasToString(data.price,"");
            componentsRef.lbl_itemPrice.text = utilApi.kamasToString(this._price,"");
            componentsRef.lbl_itemPrice.fullWidth();
            componentsRef.lbl_itemPrice.x = componentsRef.iconKama.x - componentsRef.lbl_itemPrice.width;
            componentsRef.lbl_itemPrice.y = 8;
            componentsRef.lbl_itemOldPrice.fullWidth();
            componentsRef.lbl_itemOldPrice.x = componentsRef.lbl_itemPrice.x - componentsRef.lbl_itemOldPrice.width - 5;
            componentsRef.lbl_itemOldPrice.y = 8;
            componentsRef.lbl_itemOldPrice.graphics.beginFill(componentsRef.lbl_itemOldPrice.textFormat.color);
            componentsRef.lbl_itemOldPrice.graphics.drawRect(0,componentsRef.lbl_itemOldPrice.height / 2 + 1,componentsRef.lbl_itemOldPrice.width,1);
            componentsRef.lbl_itemOldPrice.graphics.endFill();
            componentsRef.lbl_itemTax.text = data.price != this._price ? utilApi.kamasToString(_parent.getTax(data.price,this._price),"") : "0";
            componentsRef.iconKama.visible = true;
            componentsRef.btn_itemRemove.softDisabled = gd_itemList.dataProvider.length <= 1;
         }
         else
         {
            componentsRef.tx_itemIcon.uri = null;
            componentsRef.tx_itemIcon.visible = false;
            componentsRef.tx_itemBg.visible = false;
            componentsRef.lbl_itemName.text = "";
            componentsRef.lbl_itemQuantity.text = "";
            componentsRef.lbl_itemOldPrice.text = "";
            componentsRef.lbl_itemPrice.text = "";
            componentsRef.iconKama.visible = false;
         }
      }
      
      override protected function updatePopupHeight() : void
      {
         super.updatePopupHeight();
         lbl_totalItems.text = uiApi.processText(uiApi.getText("ui.bidhouse.numberOfItemToModify",_parent.allItemsToRemove.length),"n",_parent.allItemsToRemove.length == 1,false);
         lbl_totalPrice.fullWidth();
         lbl_totalPrice.x = this.iconKamaTotalPrice.x - lbl_totalPrice.width;
         this.lbl_totalOldPrice.text = utilApi.kamasToString(super.getTotalPrice(),"");
         this.lbl_totalOldPrice.fullWidth();
         this.lbl_totalOldPrice.x = lbl_totalPrice.x - this.lbl_totalOldPrice.width - 5;
         this.lbl_totalOldPrice.graphics.clear();
         this.lbl_totalOldPrice.graphics.beginFill(this.lbl_totalOldPrice.textFormat.color as uint);
         this.lbl_totalOldPrice.graphics.drawRect(0,this.lbl_totalOldPrice.height / 2 + 1,this.lbl_totalOldPrice.width,1);
         this.lbl_totalOldPrice.graphics.endFill();
         this._totalTax = this.getTotalTax();
         var canAffordTax:Boolean = _parent.canAffordTax(this._totalTax);
         this.lbl_totalTax.cssClass = !!canAffordTax ? "right" : "redright";
         this.lbl_totalTax.text = utilApi.kamasToString(this._totalTax,"");
         this.lbl_totalTax.fullWidth();
         this.lbl_totalTax.x = this.iconKamaTotalTax.x - this.lbl_totalTax.width;
         btn_yes.softDisabled = !canAffordTax;
      }
      
      override protected function getTotalPrice() : uint
      {
         return this._price * gd_itemList.dataProvider.length;
      }
      
      protected function getTotalTax() : uint
      {
         var item:Object = null;
         var total:uint = 0;
         for each(item in gd_itemList.dataProvider)
         {
            if(item.price != this._price)
            {
               total += _parent.getTax(item.price,this._price);
            }
         }
         return total;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         super.onRelease(target);
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var data:* = undefined;
         if(target.name.indexOf("btn_itemRemove") != -1)
         {
            if(target.softDisabled)
            {
               data = uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.minimumModify"));
            }
            else
            {
               data = uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.cancelModify"));
            }
            uiApi.showTooltip(data,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,3);
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      private function onEnterKeyChekTax() : void
      {
         if(this.subEnterKey != null && _parent.canAffordTax(this._totalTax))
         {
            this.subEnterKey();
         }
      }
   }
}
