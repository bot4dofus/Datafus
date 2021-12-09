package Ankama_TradeCenter.ui
{
   import Ankama_TradeCenter.TradeCenter;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   
   public class AuctionHouse extends Stock
   {
       
      
      public var sellerDescriptor:Object;
      
      private var _currentTabUi:String = "";
      
      public var uiCtr:GraphicContainer;
      
      public var btn_purchase:ButtonContainer;
      
      public var btn_sale:ButtonContainer;
      
      public var lbl_btn_purchase:Label;
      
      public var lbl_btn_sale:Label;
      
      public var tx_icon_auctionHouse:Texture;
      
      public function AuctionHouse()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         this.sellerDescriptor = params.sellerBuyerDescriptor;
         uiApi.me().restoreSnapshotAfterLoading = false;
         sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_btn_purchase.text = uiApi.getText("ui.common.purchase");
         this.lbl_btn_sale.text = uiApi.getText("ui.common.sale");
         if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_COLLAR) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0039_Equipements_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRINK) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0038_Objets_util_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_WING) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0037_Ressources_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0041_runes_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_EMPTY_SOULSTONE) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0042_pierre_ame_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0040_creatures_HDV.png");
         }
         else if(params.sellerBuyerDescriptor.types.indexOf(DataEnum.ITEM_TYPE_LIVING_OBJECT) != -1)
         {
            this.tx_icon_auctionHouse.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "windowIcon/icon__0047_apparat_HDV.png");
         }
         if(this._currentTabUi == "")
         {
            if(TradeCenter.BID_HOUSE_BUY_MODE)
            {
               this.openTab(UIEnum.AUCTIONHOUSE_BUY,params);
            }
            else
            {
               this.openTab(UIEnum.AUCTIONHOUSE_SELL,params);
            }
         }
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == UIEnum.STORAGE_UI)
         {
            uiApi.me().setOnTop();
            uiApi.me().setOnTopBeforeMe.push(uiApi.getUi(UIEnum.STORAGE_UI));
         }
      }
      
      public function onUiUnloaded(pUiName:String) : void
      {
         if(pUiName == UIEnum.STORAGE_UI)
         {
            uiApi.me().setOnTopBeforeMe = [];
         }
      }
      
      override public function unload() : void
      {
         TradeCenter.SEARCH_MODE = false;
         sysApi.sendAction(new CloseInventoryAction([]));
         if(this._currentTabUi != "")
         {
            this.closeTab(this._currentTabUi);
         }
         uiApi.hideTooltip();
      }
      
      public function openTab(tab:String, params:Object = null) : void
      {
         if(this._currentTabUi == tab)
         {
            return;
         }
         if(this._currentTabUi != "")
         {
            uiApi.unloadUi(this._currentTabUi);
         }
         if(tab == "")
         {
            this._currentTabUi = UIEnum.AUCTIONHOUSE_BUY;
         }
         else
         {
            this._currentTabUi = tab;
         }
         if(this._currentTabUi == UIEnum.AUCTIONHOUSE_BUY)
         {
            uiApi.loadUiInside(this._currentTabUi,this.uiCtr,UIEnum.AUCTIONHOUSE_BUY,params);
         }
         else if(this._currentTabUi == UIEnum.AUCTIONHOUSE_SELL)
         {
            uiApi.loadUiInside(this._currentTabUi,this.uiCtr,UIEnum.AUCTIONHOUSE_SELL,params);
         }
         if(!uiApi.getUi(UIEnum.STORAGE_UI))
         {
            sysApi.sendAction(new OpenInventoryAction(["bidHouse"]));
         }
         else
         {
            uiApi.getUi(UIEnum.STORAGE_UI).uiClass.associateUi();
         }
         uiApi.setRadioGroupSelectedItem("tabHGroup",this.getButtonByTab(this._currentTabUi),uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      private function closeTab(tab:String) : void
      {
         uiApi.unloadUi(tab);
      }
      
      private function getButtonByTab(tab:String) : ButtonContainer
      {
         var returnButton:ButtonContainer = null;
         switch(tab)
         {
            case UIEnum.AUCTIONHOUSE_BUY:
               returnButton = this.btn_purchase;
               break;
            case UIEnum.AUCTIONHOUSE_SELL:
               returnButton = this.btn_sale;
         }
         return returnButton;
      }
      
      public function isSwitching() : Boolean
      {
         return TradeCenter.SWITCH_MODE;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btn_close:
               sysApi.sendAction(new LeaveShopStockAction([]));
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.btn_purchase:
               if(!TradeCenter.BID_HOUSE_BUY_MODE)
               {
                  TradeCenter.SWITCH_MODE = true;
                  TradeCenter.BID_HOUSE_BUY_MODE = true;
                  sysApi.sendAction(new BidSwitchToBuyerModeAction([]));
               }
               break;
            case this.btn_sale:
               if(TradeCenter.BID_HOUSE_BUY_MODE)
               {
                  TradeCenter.SWITCH_MODE = true;
                  TradeCenter.BID_HOUSE_BUY_MODE = false;
                  sysApi.sendAction(new BidSwitchToSellerModeAction([]));
               }
         }
      }
      
      override protected function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            sysApi.sendAction(new LeaveShopStockAction([]));
            uiApi.unloadUi(uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
