package Ankama_Web.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ShopPopupLivingObject
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_description:TextArea;
      
      public var tx_item:Texture;
      
      public var gd_itemLevels:Grid;
      
      public var btn_lbl_btn_buy:Label;
      
      public var btn_buy:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btn_buyOverlay:ButtonContainer;
      
      public var btn_getForFree:ButtonContainer;
      
      public var tx_ogrineButton:Texture;
      
      public var btn_lbl_btn_buyOverlay:Label;
      
      private var _params:Object;
      
      public function ShopPopupLivingObject()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var i:int = 0;
         var hasOgrinePrice:Boolean = false;
         var hasRealPrice:Boolean = false;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._params = params;
         this.lbl_title.text = params.article.article.name;
         if(this._params.article.article.isFree)
         {
            this.btn_getForFree.visible = this._params.article.article.availability != DofusShopEnum.SOON_AVAILABLE;
            this.tx_ogrineButton.visible = false;
            this.btn_buyOverlay.visible = false;
            this.btn_buy.visible = false;
         }
         else if(params.article.article.prices)
         {
            hasOgrinePrice = false;
            hasRealPrice = false;
            for(i = 0; i < params.article.article.prices.length; i++)
            {
               if(params.article.article.prices[i].currency == DofusShopEnum.CURRENCY_OGRINES)
               {
                  hasOgrinePrice = true;
                  this.btn_lbl_btn_buy.text = params.article.article.prices[i].price;
               }
               else if(params.article.article.prices[i].paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
               {
                  hasRealPrice = true;
                  if(this.btn_lbl_btn_buyOverlay.text == "" || params.article.article.prices[i].country != "WD")
                  {
                     this.btn_lbl_btn_buyOverlay.text = params.article.article.prices[i].price + " " + params.article.article.prices[i].currency;
                  }
               }
            }
            if(hasOgrinePrice)
            {
               if(!hasRealPrice)
               {
                  this.btn_buyOverlay.visible = false;
                  this.btn_buy.x = 95;
               }
            }
            else
            {
               this.btn_buy.visible = false;
               this.tx_ogrineButton.visible = false;
               if(hasRealPrice)
               {
                  this.btn_buyOverlay.x = 95;
               }
               else
               {
                  this.btn_buyOverlay.visible = false;
               }
            }
         }
         this.lbl_description.text = params.article.article.description;
         params.article.items[0].livingObjectCategory = 1;
         params.article.items[0].livingObjectLevel = 20;
         params.article.items[0].livingObjectMood = 1;
         var skins:* = this.dataApi.getLivingObjectSkins(params.article.items[0]);
         params.article.items[0].livingObjectCategory = 0;
         this.gd_itemLevels.dataProvider = skins;
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function updateSlot(data:*, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.tx_slotItem.uri = data.iconUri;
            components.tx_slotFg.visible = selected;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_buy:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopIndirectBuyClick,this._params.article.article,true);
               this.uiApi.loadUi("shopPopupConfirmBuy","shopPopupConfirmBuy",this._params,StrataEnum.STRATA_TOP,null,true);
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_buyOverlay:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopIndirectBuyClick,this._params.article.article,false);
               this.sysApi.sendAction(new ShopOverlayBuyRequestAction([this._params.article.article.id]));
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_getForFree:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopCurrentArticle,this._params.article);
               this.sysApi.sendAction(new ShopBuyRequestAction([this._params.article.article.id,1,DofusShopEnum.CURRENCY_OGRINES,0]));
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.level") + " " + (item.index + 1)),target.slots[item.index]);
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Grid, selectMethod:uint, isNewSelection:Boolean) : void
      {
         this.tx_item.uri = target.selectedItem.fullSizeIconUri;
      }
   }
}
