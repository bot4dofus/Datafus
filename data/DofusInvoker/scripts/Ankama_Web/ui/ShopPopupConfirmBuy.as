package Ankama_Web.ui
{
   import Ankama_Web.enum.ShopArticleTypeEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.geom.Point;
   
   public class ShopPopupConfirmBuy
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var btn_close_ctr_popupWindow:ButtonContainer;
      
      public var btn_buy:ButtonContainer;
      
      public var tx_picture:Texture;
      
      public var tx_slot:Texture;
      
      public var tx_leftOgrines:Texture;
      
      public var tx_ogrine:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_price:Label;
      
      public var lbl_title_ctr_popupWindow:Label;
      
      public var lbl_confirm:Label;
      
      public var lbl_credited:Label;
      
      public var btn_lbl_btn_buy:Label;
      
      public var lbl_leftOgrines:Label;
      
      public var ctr_popupWindow:GraphicContainer;
      
      private var _item;
      
      private var _params:Object;
      
      public function ShopPopupConfirmBuy()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var price:Object = null;
         var action:* = undefined;
         this.uiApi.addComponentHook(this.tx_slot,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_slot,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_buy,ComponentHookList.ON_RELEASE);
         this.lbl_name.text = (params.article.quantity > 1 ? params.article.quantity + "x " : "") + (params.article.items[0] && params.article.items.length == 1 ? params.article.items[0].name : params.article.article.name);
         for each(price in params.article.article.prices)
         {
            if(price.currency == DofusShopEnum.CURRENCY_OGRINES)
            {
               this.lbl_price.text = price.price;
            }
         }
         if(params.article.article.imageSwf)
         {
            this.tx_picture.uri = params.article.article.imageSwf;
         }
         else if(params.article.article.imageNormal && params.article.article.imageNormal.length > 0)
         {
            this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageNormal);
         }
         else if(params.article.article.imageSmall && params.article.article.imageSmall.length > 0)
         {
            this.tx_picture.uri = this.uiApi.createUri(params.article.article.imageSmall);
         }
         this._params = params;
         this._item = !!params.article.items[0] ? params.article.items[0] : params.article.article;
         this.lbl_title_ctr_popupWindow.forceUppercase = true;
         if(params.congratulations)
         {
            this.sysApi.dispatchHook(ExternalGameHookList.DofusShopValidBuy,this._params.article.article,this.tx_ogrine.visible);
            if(this._params.article.article.isFree)
            {
               this.lbl_confirm.text = this.uiApi.getText("ui.shop.freeTransactionValidated");
               this.tx_ogrine.visible = false;
               this.lbl_price.visible = false;
            }
            else
            {
               this.lbl_confirm.text = this.uiApi.getText("ui.shop.transactionValidated");
            }
            this.lbl_credited.height = 30;
            if(this._params.article.type == ShopArticleTypeEnum.HAVENBAG || this._params.article.type == ShopArticleTypeEnum.SUBSCRIPTION || this._params.article.type == ShopArticleTypeEnum.UNKNOWN)
            {
               this.lbl_credited.text = this.uiApi.getText("ui.shop.itemCredited");
            }
            else
            {
               this.sysApi.setData("giftNotification",true);
               this.sysApi.dispatchHook(ExternalGameHookList.CodesAndGiftNotificationValue,true);
               this.lbl_credited.text = this.uiApi.getText(!!this._params.article.article.isFree ? "ui.shop.freeItemInGiftTab" : "ui.shop.itemInGiftTab");
            }
            this.btn_lbl_btn_buy.text = this.uiApi.getText("ui.common.ok");
            this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.congratulations");
         }
         else if(params.moneyOgr < parseInt(this.lbl_price.text))
         {
            this.tx_leftOgrines.visible = true;
            this.lbl_leftOgrines.text = this.uiApi.getText("ui.shop.leftOgrines",params.moneyOgr.toString());
            this.lbl_leftOgrines.fullWidth();
            this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.popup.warning");
            this.lbl_confirm.text = this.uiApi.getText("ui.shop.noOgrines");
            this.btn_lbl_btn_buy.text = this.uiApi.getText("ui.shop.getOgrines");
         }
         else if(params.article.article.references[0])
         {
            for each(action in params.article.article.references[0].actions)
            {
               if(action.distribution == DofusShopEnum.LOCATION_DISTRIBUTION)
               {
                  this.lbl_credited.height = 70;
                  this.lbl_credited.text = this.uiApi.getText("ui.shop.buyConfirmLocation");
                  this.ctr_popupWindow.height += 60;
                  break;
               }
            }
         }
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var i:int = 0;
         switch(target)
         {
            case this.btn_buy:
               if(this._params.moneyOgr < parseInt(this.lbl_price.text))
               {
                  this.sysApi.dispatchHook(ExternalGameHookList.DofusShopOpenCategory,DofusShopEnum.OGRINES_CATEGORY_ID);
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else if(this._params.congratulations)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  for(i = 0; i < this._params.article.article.prices.length; i++)
                  {
                     if(this._params.article.article.prices[i].currency == DofusShopEnum.CURRENCY_OGRINES)
                     {
                        this.sysApi.dispatchHook(ExternalGameHookList.DofusShopCurrentArticle,this._params.article);
                        this.sysApi.sendAction(new ShopBuyRequestAction([this._params.article.article.id,1,DofusShopEnum.CURRENCY_OGRINES]));
                        break;
                     }
                  }
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               break;
            case this.btn_close_ctr_popupWindow:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var globalPosition:* = undefined;
         var probaObject:Object = null;
         var txt:String = null;
         switch(target)
         {
            case this.tx_slot:
               globalPosition = target["localToGlobal"](new Point(0,0));
               if(this._params.article.type == ShopArticleTypeEnum.MYSTERY_BOX)
               {
                  probaObject = {
                     "name":this._params.article.article.name,
                     "icon":this._params.article.imageUri,
                     "probas":this.createProbaObject(this._params.article.items[0].kards)
                  };
                  this.uiApi.showTooltip(probaObject,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,20,"mysteryBox",null,{
                     "showProba":true,
                     "sortInBlocks":true,
                     "description":this._params.article.article.description
                  });
                  break;
               }
               if(this._item is ItemWrapper)
               {
                  this.uiApi.showTooltip(this._item,target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,20,"item",null,{"showEffects":true});
                  break;
               }
               txt = "";
               if(this._item.name)
               {
                  txt += "<b>" + this._item.name + "</b>\n";
               }
               if(this._item.description)
               {
                  txt += this._item.description;
               }
               if(txt)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,20,null,null,null,"TextInfo");
                  break;
               }
               break;
         }
      }
      
      private function createProbaObject(data:Array) : Array
      {
         var kard:Object = null;
         var internalFunc:Function = null;
         var res:Array = [];
         for each(kard in data)
         {
            res.push({
               "name":kard.kard.name,
               "proba":kard.probability,
               "rarity":kard.rarity,
               "showProba":true
            });
         }
         internalFunc = function(kard1:Object, kard2:Object):int
         {
            if(kard1.proba > kard2.proba)
            {
               return 1;
            }
            if(kard1.proba < kard2.proba)
            {
               return -1;
            }
            return 0;
         };
         res.sort(internalFunc);
         return res;
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
