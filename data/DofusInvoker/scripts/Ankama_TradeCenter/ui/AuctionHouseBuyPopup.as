package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AuctionHouseBuyPopup
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      private var _tooltipApi:TooltipApi;
      
      public var lbl_title_popup:Label;
      
      public var lbl_subtitle:Label;
      
      public var btn_close_popup:ButtonContainer;
      
      public var tx_itemIcon:Texture;
      
      public var tx_itemBg:Texture;
      
      public var lbl_itemName:Label;
      
      public var lbl_itemQuantity:Label;
      
      public var lbl_unityPriceTitle:Label;
      
      public var lbl_unityPrice:Label;
      
      public var lbl_priceTitle:Label;
      
      public var lbl_price:Label;
      
      public var btn_lbl_btn_yes:Label;
      
      public var btn_yes:ButtonContainer;
      
      private var _aEventIndex:Array;
      
      private var _currentItem:Object;
      
      protected var onCancelFunction:Function = null;
      
      protected var onEnterKey:Function = null;
      
      private var _duration:Number = 2000;
      
      private var _clockStart:Number;
      
      private var _btnYesText:String;
      
      private var _canBuy:Boolean = false;
      
      public function AuctionHouseBuyPopup()
      {
         this._aEventIndex = new Array();
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this.uiApi.addComponentHook(this.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
         this.sysApi.addHook(HookList.DisplayPinnedItemTooltip,this.onDisplayPinnedTooltip);
         this.lbl_title_popup.text = this.uiApi.getText("ui.popup.warning");
         this.lbl_subtitle.text = params.text;
         this._currentItem = params.itemInfo;
         this.tx_itemIcon.uri = this._currentItem.item.iconUri;
         if(this._currentItem.item.itemSetId != -1)
         {
            this.lbl_itemName.cssClass = "orangeleft";
            this.lbl_itemName.text = "{encyclopediaPinItem," + this._currentItem.item.objectGID + "," + this._currentItem.item.objectUID + "," + this.uiApi.me().name + ",linkColor:0xEBC304,hoverColor:0xF2FABD::" + this._currentItem.item.name + "}";
         }
         else
         {
            this.lbl_itemName.cssClass = "greenleft";
            this.lbl_itemName.text = "{encyclopediaPinItem," + this._currentItem.item.objectGID + "," + this._currentItem.item.objectUID + "," + this.uiApi.me().name + ",linkColor:0xDEFF00,hoverColor:0xF2FABD::" + this._currentItem.item.name + "}";
         }
         this.lbl_itemQuantity.text = "x " + this._currentItem.stack;
         this.lbl_unityPriceTitle.text = this.uiApi.getText("ui.common.unitPrice") + this.uiApi.getText("ui.common.colon");
         this.lbl_unityPrice.text = this._currentItem.unityPrice;
         this.lbl_priceTitle.text = this.uiApi.getText("ui.common.totalPrice") + this.uiApi.getText("ui.common.colon");
         this.lbl_price.text = this._currentItem.price;
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
         if(params.blocking)
         {
            this.sysApi.addEventListener(this.onEnterFrame,"btnTimerAuctionHouseBuyPopup");
            this._btnYesText = this.btn_lbl_btn_yes.text;
            this.btn_yes.softDisabled = true;
            this._clockStart = getTimer();
         }
         else
         {
            this._canBuy = true;
         }
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var _loc2_:* = target;
         switch(0)
         {
         }
         if(target == this.btn_yes && !this._canBuy)
         {
            return;
         }
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
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var settings:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var setting:String = null;
         var objVariables:* = undefined;
         switch(target)
         {
            case this.tx_itemIcon:
            case this.tx_itemBg:
               settings = {};
               itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
               if(itemTooltipSettings == null)
               {
                  itemTooltipSettings = this._tooltipApi.createItemSettings();
                  this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
               }
               objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
               for each(setting in objVariables)
               {
                  settings[setting] = itemTooltipSettings[setting];
               }
               if(!this._currentItem.item.objectUID)
               {
                  settings.showEffects = true;
               }
               settings.noFooter = true;
               this.uiApi.showTooltip(this._currentItem.item,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,3,null,null,settings);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip("tooltip_standard");
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
            itemTooltipSettings = this._tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:* = this.sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         if(!this._currentItem.item.objectUID)
         {
            settings.showEffects = true;
         }
         settings.pinnable = true;
         this.uiApi.showTooltip(this._currentItem.item,new Rectangle(20,20,0,0),false,"standard",0,0,0,null,null,settings,null,true);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(!this._canBuy)
               {
                  return true;
               }
               if(this.onEnterKey != null)
               {
                  this.onEnterKey();
               }
               this.closeMe();
               return true;
               break;
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
      
      private function onEnterFrame(e:Event) : void
      {
         var clock:uint = getTimer();
         var remainedTime:Number = (this._duration - (clock - this._clockStart)) / 1000;
         if(remainedTime > 0)
         {
            this.btn_lbl_btn_yes.text = (Math.floor(remainedTime) + 1).toString();
         }
         else
         {
            this.resetBtnYesButton();
         }
      }
      
      private function closeMe() : void
      {
         this.sysApi.removeEventListener(this.onEnterFrame);
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function resetBtnYesButton() : void
      {
         this.btn_lbl_btn_yes.text = this._btnYesText;
         this.btn_yes.softDisabled = false;
         this.sysApi.removeEventListener(this.onEnterFrame);
         this._canBuy = true;
      }
      
      public function get tooltipApi() : TooltipApi
      {
         return this._tooltipApi;
      }
      
      public function set tooltipApi(value:TooltipApi) : void
      {
         this._tooltipApi = value;
      }
   }
}
