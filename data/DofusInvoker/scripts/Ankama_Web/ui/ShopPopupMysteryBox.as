package Ankama_Web.ui
{
   import Ankama_Web.enum.MysteryBoxRarityEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ShopPopupMysteryBox
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var btn_close:ButtonContainer;
      
      public var gd_content:Grid;
      
      public var lbl_content:Label;
      
      public var lbl_description:Label;
      
      public var lbl_totalJackpot:Label;
      
      public var lbl_totalEpic:Label;
      
      public var lbl_totalRare:Label;
      
      public var lbl_totalUncommon:Label;
      
      public var lbl_totalCommon:Label;
      
      public var btn_lbl_btn_buy:Label;
      
      public var btn_lbl_btn_buyOverlay:Label;
      
      public var lbl_title:Label;
      
      public var btn_buy:ButtonContainer;
      
      public var btn_buyOverlay:ButtonContainer;
      
      public var btn_getForFree:ButtonContainer;
      
      public var tx_ogrineButton:Texture;
      
      private var _data:Dictionary;
      
      private var _totalProba:Dictionary;
      
      private var _dataOrder:Array;
      
      private var _params:Object;
      
      private var _nbJackpot:int = 0;
      
      private var _bgColor1:ColorTransform;
      
      public function ShopPopupMysteryBox()
      {
         this._data = new Dictionary();
         this._totalProba = new Dictionary();
         this._dataOrder = [MysteryBoxRarityEnum.COMMON,MysteryBoxRarityEnum.UNCOMMON,MysteryBoxRarityEnum.RARE,MysteryBoxRarityEnum.EPIC,MysteryBoxRarityEnum.LEGENDARY];
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var kard:Object = null;
         var provider:Array = null;
         var rarity:String = null;
         var i:int = 0;
         var hasOgrinePrice:Boolean = false;
         var hasRealPrice:Boolean = false;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_title.text = params.article.article.name;
         this._params = params;
         this._bgColor1 = new ColorTransform();
         var bgColor:* = this.sysApi.getConfigEntry("colors.grid.line");
         this._bgColor1.color = parseInt(bgColor,16) & 16777215;
         this._bgColor1.alphaMultiplier = ((parseInt(bgColor,16) & 4278190080) >> 24) / 255;
         if(params.article.article.description)
         {
            this.lbl_description.text = params.article.article.description;
         }
         for each(kard in this._params.article.items[0].kards)
         {
            if(!this._data[kard.rarity])
            {
               this._data[kard.rarity] = [];
               this._totalProba[kard.rarity] = 0;
            }
            this._data[kard.rarity].push(kard);
            if(kard.rarity == MysteryBoxRarityEnum.LEGENDARY)
            {
               this._data[kard.rarity].push(false);
            }
            this._totalProba[kard.rarity] += kard.probability;
         }
         provider = [];
         for each(rarity in this._dataOrder)
         {
            if(!(this._data[rarity] && this._data[rarity].length > 0))
            {
               continue;
            }
            provider = provider.concat(this._data[rarity]);
            switch(rarity)
            {
               case MysteryBoxRarityEnum.COMMON:
                  this.lbl_totalCommon.text = this.uiApi.getText("ui.codesAndGift.mb.rarityCommon") + " (" + Math.round(10 * this._totalProba[MysteryBoxRarityEnum.COMMON]) / 10 + " %)";
                  this.lbl_totalCommon.colorText = MysteryBoxRarityEnum.COMMON_COLOR;
                  break;
               case MysteryBoxRarityEnum.UNCOMMON:
                  this.lbl_totalUncommon.text = this.uiApi.getText("ui.codesAndGift.mb.rarityUncommon") + " (" + Math.round(10 * this._totalProba[MysteryBoxRarityEnum.UNCOMMON]) / 10 + " %),";
                  this.lbl_totalUncommon.colorText = MysteryBoxRarityEnum.UNCOMMON_COLOR;
                  break;
               case MysteryBoxRarityEnum.RARE:
                  this.lbl_totalRare.text = this.uiApi.getText("ui.codesAndGift.mb.rarityRare") + " (" + Math.round(10 * this._totalProba[MysteryBoxRarityEnum.RARE]) / 10 + " %),";
                  this.lbl_totalRare.colorText = MysteryBoxRarityEnum.RARE_COLOR;
                  break;
               case MysteryBoxRarityEnum.EPIC:
                  this.lbl_totalEpic.text = this.uiApi.getText("ui.codesAndGift.mb.rarityEpic") + " (" + Math.round(10 * this._totalProba[MysteryBoxRarityEnum.EPIC]) / 10 + " %),";
                  this.lbl_totalEpic.colorText = MysteryBoxRarityEnum.EPIC_COLOR;
                  break;
               case MysteryBoxRarityEnum.LEGENDARY:
                  this.lbl_totalJackpot.text = this.uiApi.getText("ui.codesAndGift.mb.rarityLegendary") + " (" + Math.round(10 * this._totalProba[MysteryBoxRarityEnum.LEGENDARY]) / 10 + " %),";
                  this.lbl_totalJackpot.colorText = MysteryBoxRarityEnum.LEGENDARY_COLOR;
                  break;
            }
         }
         this.lbl_content.fullWidth();
         this.lbl_totalCommon.fullWidth();
         this.lbl_totalUncommon.fullWidth();
         this.lbl_totalRare.fullWidth();
         this.lbl_totalEpic.fullWidth();
         this.lbl_totalJackpot.fullWidth();
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
                  this.btn_buy.x = 0;
               }
            }
            else
            {
               this.btn_buy.visible = false;
               this.tx_ogrineButton.visible = false;
               if(hasRealPrice)
               {
                  this.btn_buyOverlay.x = 0;
               }
               else
               {
                  this.btn_buyOverlay.visible = false;
               }
            }
         }
         this.gd_content.dataProvider = provider;
      }
      
      public function updateBlock(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         if(data)
         {
            switch(data.rarity)
            {
               case MysteryBoxRarityEnum.COMMON:
                  componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityCommon");
                  componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.COMMON_COLOR;
                  break;
               case MysteryBoxRarityEnum.UNCOMMON:
                  componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityUncommon");
                  componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.UNCOMMON_COLOR;
                  break;
               case MysteryBoxRarityEnum.RARE:
                  componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityRare");
                  componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.RARE_COLOR;
                  break;
               case MysteryBoxRarityEnum.EPIC:
                  componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityEpic");
                  componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.EPIC_COLOR;
                  break;
               case MysteryBoxRarityEnum.LEGENDARY:
                  componentsRef.lbl_rarityName.text = this.uiApi.getText("ui.codesAndGift.mb.rarityLegendary");
                  componentsRef.lbl_rarityName.colorText = MysteryBoxRarityEnum.LEGENDARY_COLOR;
            }
            componentsRef.lbl_kardDescription.text = data.kard.description;
            componentsRef.lbl_kardName.text = data.kard.name;
            componentsRef.lbl_kardProba.text = data.probability + " %";
            componentsRef.tx_kardImage.uri = data.kard.iconUri;
         }
         if(componentsRef.ctr_emptyLine)
         {
            ++this._nbJackpot;
         }
         var index:int = line + this._nbJackpot;
         var ctr:GraphicContainer = componentsRef[this.getBlockType(data,line)];
         ctr.graphics.clear();
         if(index % 2 == 0)
         {
            ctr.graphics.beginFill(this._bgColor1.color,this._bgColor1.alphaMultiplier);
            ctr.graphics.drawRect(0,0,this.gd_content.slotWidth,this.gd_content.slotHeight);
            ctr.graphics.endFill();
         }
      }
      
      public function getBlockType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "ctr_emptyLine";
         }
         if(data.rarity == MysteryBoxRarityEnum.LEGENDARY)
         {
            return "ctr_legendaryRarity";
         }
         return "ctr_basicRarity";
      }
      
      public function updateContentLine(data:*, componentsRef:*, selected:Boolean) : void
      {
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
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
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var globalPosition:* = undefined;
         if(target.name.indexOf("kardImage") != -1)
         {
            globalPosition = target["localToGlobal"](new Point(0,0));
            this.uiApi.showTooltip({
               "uri":(target as Texture).uri,
               "width":250,
               "height":250
            },target,false,"zoomTooltip",globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPRIGHT) : uint(LocationEnum.POINT_TOPLEFT),globalPosition.x > 200 ? uint(LocationEnum.POINT_TOPLEFT) : uint(LocationEnum.POINT_TOPRIGHT),20,"slotTexture",null,null);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip("zoomTooltip");
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
   }
}
