package Ankama_Web.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.geom.Point;
   import mx.utils.StringUtil;
   
   public class ShopPopupPack
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      public var ctr_popupMain:GraphicContainer;
      
      public var blk_description:GraphicContainer;
      
      public var ctr_description:GraphicContainer;
      
      public var scroll_description:ScrollContainer;
      
      public var blk_grid:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_picture:Texture;
      
      public var tx_promo:Texture;
      
      public var lbl_description:Label;
      
      public var lbl_promo:Label;
      
      public var gd_setItems:Grid;
      
      public var btn_lbl_btn_buy:Label;
      
      public var btn_buy:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btn_buyOverlay:ButtonContainer;
      
      public var btn_getForFree:ButtonContainer;
      
      public var tx_ogrineButton:Texture;
      
      public var btn_lbl_btn_buyOverlay:Label;
      
      private var _params:Object;
      
      public function ShopPopupPack()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var diff:int = 0;
         var prom:Object = null;
         var i:int = 0;
         var hasOgrinePrice:Boolean = false;
         var hasRealPrice:Boolean = false;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._params = params;
         if(params.article.items.length > 7)
         {
            diff = params.article.items.length - 7;
            this.ctr_popupMain.width += 44 * diff;
            this.blk_description.width += 44 * diff;
            this.scroll_description.width += 44 * diff;
            this.lbl_description.width += 44 * diff;
            this.lbl_promo.width = this.lbl_description.width;
            this.blk_grid.width += 44 * diff;
            this.gd_setItems.width += 44 * diff;
         }
         this.lbl_description.textfield.height = this.lbl_description.height;
         this.lbl_title.text = params.article.article.name;
         if(params.article.article.imageNormal)
         {
            this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageNormal);
         }
         for(var j:int = 0; j < params.article.article.promo.length; j++)
         {
            if(params.article.article.promo[j].image)
            {
               this.tx_promo.uri = this.uiApi.createUri(params.article.article.promo[j].image);
               break;
            }
         }
         this.lbl_promo.text = "";
         if(params.article.article.promo.length > 0)
         {
            this.lbl_promo.text += this.uiApi.getText("ui.shop.promotion");
            for each(prom in params.article.article.promo)
            {
               this.lbl_promo.text += prom.description;
            }
         }
         else
         {
            this.lbl_description.y -= 40;
         }
         this.lbl_promo.fullSize(this.lbl_promo.width);
         this.lbl_description.htmlText = params.article.article.description;
         this.lbl_description.htmlText = StringUtil.trim(this.lbl_description.htmlText);
         this.lbl_description.fullSize(this.lbl_description.width);
         this.ctr_description.height = this.lbl_description.height + this.lbl_promo.height + 7;
         this.scroll_description.addContent(this.ctr_description);
         this.gd_setItems.dataProvider = params.article.items;
         if(this.gd_setItems.dataProvider.length == 0)
         {
            this.blk_grid.visible = false;
         }
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
                  this.btn_buy.x = 94;
               }
            }
            else
            {
               this.btn_buy.visible = false;
               this.tx_ogrineButton.visible = false;
               if(hasRealPrice)
               {
                  this.btn_buyOverlay.x = 94;
               }
               else
               {
                  this.btn_buyOverlay.visible = false;
               }
            }
         }
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var txt:String = null;
         var globalPosition:* = target.localToGlobal(new Point(0,0));
         if(item && item.data is ItemWrapper)
         {
            this.uiApi.showTooltip(item.data,target,false,"standard",globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPRIGHT) : uint(LocationEnum.POINT_TOPLEFT),globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPLEFT) : uint(LocationEnum.POINT_TOPRIGHT),20,null,null,{
               "showEffects":true,
               "header":true
            });
         }
         else
         {
            txt = "";
            if(item.data)
            {
               txt += "<b>" + item.data.name + "</b>\n";
               txt += item.data.description;
            }
            if(txt)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPRIGHT) : uint(LocationEnum.POINT_TOPLEFT),globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPLEFT) : uint(LocationEnum.POINT_TOPRIGHT),20,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
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
      
      public function onItemRightClick(target:Grid, item:GridItem) : void
      {
         if(item.data)
         {
            this.modContextMenu.createContextMenu(this.menuApi.create(item.data,"item"));
         }
      }
   }
}
