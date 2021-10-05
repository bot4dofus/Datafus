package Ankama_Web.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class ShopPopupAttitude
   {
      
      private static const ATTITUDE_ACTION_ID:int = 10;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var ed_popupChar:EntityDisplayer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var btn_buy:ButtonContainer;
      
      public var btn_buyOverlay:ButtonContainer;
      
      public var btn_getForFree:ButtonContainer;
      
      public var btn_lbl_btn_buy:Label;
      
      public var btn_lbl_btn_buyOverlay:Label;
      
      public var lbl_title:Label;
      
      public var tx_ogrineButton:Texture;
      
      private var _direction:int = 3;
      
      private var _params:Object;
      
      public function ShopPopupAttitude()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var possibleEffect:EffectInstanceDice = null;
         var i:int = 0;
         var hasOgrinePrice:Boolean = false;
         var hasRealPrice:Boolean = false;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._params = params;
         this.lbl_title.text = params.article.article.name;
         this.ed_popupChar.look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id,true);
         if(this.ed_popupChar.look.getBone() == 2)
         {
            this.ed_popupChar.look.setBone(1);
         }
         for each(possibleEffect in params.article.items[0].possibleEffects)
         {
            if(possibleEffect.effectId == ATTITUDE_ACTION_ID)
            {
               this.ed_popupChar.setAnimationAndDirection(this.dataApi.getEmoteAnimName(possibleEffect.diceNum,this.playerApi.getCurrentEntityLook()),this._direction);
            }
         }
         this.uiApi.addComponentHook(this.ed_popupChar,"onEntityReady");
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
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onEntityReady(entity:*) : void
      {
         this.uiApi.removeComponentHook(this.ed_popupChar,"onEntityReady");
         var maxEntityHeight:int = 0;
         var maxEntityWidth:int = 0;
         for(var i:int = 0; i < this.ed_popupChar.entity.maxFrame; i++)
         {
            if(this.ed_popupChar.entity.rawAnimation.width > maxEntityWidth)
            {
               maxEntityWidth = this.ed_popupChar.entity.rawAnimation.width;
            }
            if(this.ed_popupChar.entity.rawAnimation.height > maxEntityHeight)
            {
               maxEntityHeight = this.ed_popupChar.entity.rawAnimation.height;
            }
            this.ed_popupChar.entity.rawAnimation.nextFrame();
         }
         var scale:Number = Math.min(Math.max(this.ed_popupChar.height / maxEntityHeight,this.ed_popupChar.width / maxEntityWidth,1.25),4);
         this.ed_popupChar.entity.scaleX = scale;
         this.ed_popupChar.entity.scaleY = scale;
         this.ed_popupChar.entity.y = 500;
         this.ed_popupChar.visible = true;
      }
      
      private function turnChara(sens:int) : void
      {
         this._direction = (this._direction + 2 * sens + 8) % 8;
         this.ed_popupChar.direction = this._direction;
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
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_leftArrow:
               this.turnChara(-1);
               break;
            case this.btn_rightArrow:
               this.turnChara(1);
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
   }
}
