package Ankama_Web.ui
{
   import Ankama_Web.enum.BakPopupTypeEnum;
   import Ankama_Web.enum.WebTabEnum;
   import com.ankama.haapi.client.model.BakBidOffer;
   import com.ankama.haapi.client.model.BakRate;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiBufferKamasListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiCancelBidRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConfirmationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConsumeBufferKamasRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiValidationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenBakRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.RefreshBakOffersAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.network.enums.BidActionEnum;
   import com.ankamagames.dofus.network.enums.BidCancellationEnum;
   import com.ankamagames.dofus.network.enums.BidValidationEnum;
   import com.ankamagames.dofus.network.types.web.haapi.BufferInformation;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class BakTab
   {
       
      
      private const BUY_OGRINES_TAB:int = 0;
      
      private const BUY_KAMAS_TAB:int = 1;
      
      private const KAMAS_OFFER_ID:int = 1400;
      
      private const OGRINE_OFFER_ID:int = 1401;
      
      private const WEEK_IN_MS:int = 604800000;
      
      private const ONE_DAYS_IN_MS:int = 86400000;
      
      private const ONE_HOUR_IN_MS:int = 3600000;
      
      private const ONE_MIN_IN_MS:int = 60000;
      
      private const SUBSCRIPTION_CAT_ID:int = 558;
      
      private const BAK_LAST_TAB:String = "bakLastTab";
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private const OGRINES_BUY_PREVALUES:Array = PlayerManager.getInstance().subscriptionEndDate > 0 ? ["700","1 000","4 000","11 500","20 000"] : ["700","1 100","4 200","12 000"];
      
      private var _ogrinesSellPrevalues:Array;
      
      private const KAMAS_PREVALUES:Array = ["100 000","200 000","500 000","1 000 000","10 000 000"];
      
      public var blk_ogrinesOffersGridBlock:GraphicContainer;
      
      public var blk_kamasOffersGridBlock:GraphicContainer;
      
      public var ctr_kamasAmount:GraphicContainer;
      
      public var ctr_ogrinesAmount:GraphicContainer;
      
      public var ctr_linkedOgrines:GraphicContainer;
      
      public var ctr_rightTradeInterface:GraphicContainer;
      
      public var ctr_currentOffer:GraphicContainer;
      
      public var ctr_averageRate:GraphicContainer;
      
      public var ctr_header:GraphicContainer;
      
      public var ctr_timeout:GraphicContainer;
      
      public var ctr_bakMain:GraphicContainer;
      
      public var ctr_yourOfferDetail:GraphicContainer;
      
      public var ctr_leftCountdown:GraphicContainer;
      
      public var ctr_rightCountdown:GraphicContainer;
      
      public var ctr_kamasTemp:GraphicContainer;
      
      public var cb_leftDemand:ComboBox;
      
      public var cb_leftPrice:ComboBox;
      
      public var cb_rightDemand:ComboBox;
      
      public var cb_rightPrice:ComboBox;
      
      public var lbl_averageRate:Label;
      
      public var lbl_leftDemand:Label;
      
      public var lbl_leftPrice:Label;
      
      public var lbl_leftRate:Label;
      
      public var lbl_rightDemand:Label;
      
      public var lbl_rightPrice:Label;
      
      public var lbl_rightRate:Label;
      
      public var lbl_linkedOgrinesAmount:Label;
      
      public var lbl_linked:Label;
      
      public var lbl_leftTitle:Label;
      
      public var lbl_rightTitle:Label;
      
      public var lbl_leftDemandKamas:Label;
      
      public var lbl_rightDemandKamas:Label;
      
      public var btn_lbl_btn_leftBuy:Label;
      
      public var lbl_ogrinesOffersOgrines:Label;
      
      public var lbl_ogrinesOffersKamas:Label;
      
      public var lbl_ogrinesOffersRate:Label;
      
      public var lbl_kamasOffersKamas:Label;
      
      public var lbl_kamasOffersOgrines:Label;
      
      public var lbl_kamasOffersRate:Label;
      
      public var lbl_kamasOffersGrid:Label;
      
      public var lbl_ogrinesOffersGrid:Label;
      
      public var lbl_leftRateValue:Label;
      
      public var lbl_currentOgrines:Label;
      
      public var lbl_leftPriceOgrines:Label;
      
      public var lbl_rightPriceOgrines:Label;
      
      public var lbl_currentKamas:Label;
      
      public var lbl_offerAlreadyExists:Label;
      
      public var lbl_currentOffer:Label;
      
      public var lbl_yourOffer:Label;
      
      public var lbl_yourGain:Label;
      
      public var lbl_yourOfferRate:Label;
      
      public var btn_lbl_btn_rightOffer:Label;
      
      public var lbl_kamasTransfer:Label;
      
      public var lbl_leftError:Label;
      
      public var lbl_rightError:Label;
      
      public var lbl_kamasTemp:Label;
      
      public var lbl_refreshKamasOffersButton:Label;
      
      public var lbl_refreshOgrinesOffersButton:Label;
      
      public var lbl_rightRefreshCountdown:Label;
      
      public var lbl_leftRefreshCountdown:Label;
      
      public var lbl_webLinkSeeThe:Label;
      
      public var lbl_ogrinePricesLink:Label;
      
      public var lbl_webLinkSlash:Label;
      
      public var lbl_myBankLink:Label;
      
      public var btn_buyOgrines:ButtonContainer;
      
      public var btn_buyKamasTab:ButtonContainer;
      
      public var btn_transferKamasTemp:ButtonContainer;
      
      public var btn_buyOgrinesTab:ButtonContainer;
      
      public var btn_ogrinesOffersOgrines:ButtonContainer;
      
      public var btn_ogrinesOffersKamas:ButtonContainer;
      
      public var btn_ogrinesOffersRate:ButtonContainer;
      
      public var btn_kamasOffersKamas:ButtonContainer;
      
      public var btn_kamasOffersOgrines:ButtonContainer;
      
      public var btn_kamasOffersRate:ButtonContainer;
      
      public var btn_leftBuy:ButtonContainer;
      
      public var btn_rightOffer:ButtonContainer;
      
      public var btn_gotToSubscriptions:ButtonContainer;
      
      public var btn_refreshKamasOffers:ButtonContainer;
      
      public var btn_refreshOgrinesOffers:ButtonContainer;
      
      public var btn_myBankLink:ButtonContainer;
      
      public var btn_ogrinePricesLink:ButtonContainer;
      
      public var inp_leftDemand:Input;
      
      public var inp_leftPrice:Input;
      
      public var inp_rightDemand:Input;
      
      public var inp_rightPrice:Input;
      
      public var inp_rightRate:Input;
      
      public var gd_ogrinesOffers:Grid;
      
      public var gd_kamasOffers:Grid;
      
      public var tx_ogrinesExpire:Texture;
      
      public var tx_averageRate:Texture;
      
      public var tx_leftDemand:Texture;
      
      public var tx_leftPrice:Texture;
      
      public var tx_rightDemand:Texture;
      
      public var tx_rightPrice:Texture;
      
      public var tx_yourOffer:Texture;
      
      public var tx_yourOfferRate:Texture;
      
      public var tx_yourGain:Texture;
      
      public var tx_ogrinesExpireIcon:Texture;
      
      public var tx_link:Texture;
      
      private var _selectedTab:int;
      
      private var _ogrinesAmount:int = 0;
      
      private var _kamasAmount:int = 0;
      
      private var _linkedOgrinesAmount:int = 0;
      
      private var _expiringOgrines:Array;
      
      private var _myBid:Object = null;
      
      private var _myBids:Array;
      
      private var _uriOgrineBig:Uri;
      
      private var _uriKamaShad:Uri;
      
      private var kamasTransferTimer:BenchmarkTimer;
      
      private var offersRefreshTimer:BenchmarkTimer;
      
      private var _labelTransferText:String;
      
      private var _buffers:Vector.<BufferInformation>;
      
      private var _averageRates:Vector.<BakRate>;
      
      private var _changing:Boolean = false;
      
      private var _rateStatTimer:BenchmarkTimer;
      
      public function BakTab()
      {
         this._ogrinesSellPrevalues = ["3 000","6 000","13 000","28 000","47 000"];
         this._myBids = [];
         this.offersRefreshTimer = new BenchmarkTimer(1000,5,"BakTab.offersRefreshTimer");
         this._averageRates = new Vector.<BakRate>();
         this._rateStatTimer = new BenchmarkTimer(4000,1,"BakTab._rateStatTimer");
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.addHook(ExternalGameHookList.DofusBakAverageRate,this.onDofusBakAverageRate);
         this.sysApi.addHook(ExternalGameHookList.DofusBakKamasOffers,this.onDofusBakKamasOffers);
         this.sysApi.addHook(ExternalGameHookList.DofusBakOgrinesOffers,this.onDofusBakOgrinesOffers);
         this.sysApi.addHook(ExternalGameHookList.DofusBakLinkedOgrines,this.onDofusBakLinkedOgrines);
         this.sysApi.addHook(ExternalGameHookList.DofusBakKamasAmount,this.onDofusBakKamasAmount);
         this.sysApi.addHook(ExternalGameHookList.DofusBakAccountBids,this.onDofusBakAccountBids);
         this.sysApi.addHook(ExternalGameHookList.DofusBakKamasBufferList,this.onDofusBakKamasBufferList);
         this.sysApi.addHook(ExternalGameHookList.DofusBakBuyValidation,this.onDofusBakBuyValidation);
         this.sysApi.addHook(ExternalGameHookList.DofusBakConfirmation,this.onDofusBakConfirmation);
         this.sysApi.addHook(ExternalGameHookList.DofusBakError,this.onDofusBakError);
         this.sysApi.addHook(ExternalGameHookList.DofusBakCreateBidSuccess,this.onDofusBakCreateBidSuccess);
         this.sysApi.addHook(ExternalGameHookList.DofusBakTransferSuccess,this.onDofusBakTransferSuccess);
         this.sysApi.addHook(ExternalGameHookList.BakTimeout,this.onBakTimeout);
         this.uiApi.addComponentHook(this.cb_leftDemand,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_leftPrice,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_rightDemand,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_rightPrice,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_kamasOffers,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_ogrinesOffers,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.ctr_kamasAmount,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_kamasAmount,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_ogrinesAmount,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_ogrinesAmount,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_transferKamasTemp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_transferKamasTemp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_ogrinesExpire,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_link,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_link,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_ogrinesExpire,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_ogrinesOffersOgrines,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_ogrinesOffersKamas,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_ogrinesOffersRate,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_kamasOffersKamas,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_kamasOffersOgrines,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_kamasOffersRate,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_leftDemand,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_leftPrice,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_rightDemand,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_rightPrice,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_rightRate,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_leftDemand,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_leftPrice,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_rightDemand,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_rightPrice,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_rightRate,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_buyOgrines,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_gotToSubscriptions,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_refreshOgrinesOffers,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_refreshKamasOffers,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_myBankLink,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_ogrinePricesLink,ComponentHookList.ON_RELEASE);
         this._uriOgrineBig = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri_big"));
         this._uriKamaShad = this.uiApi.createUri(this.uiApi.me().getConstant("kam_uri_shad"));
         this.btn_buyOgrines.transform.colorTransform = new ColorTransform(1,1,1,1,-112,-15,253);
         this.btn_ogrinesOffersRate.selected = true;
         this.btn_kamasOffersRate.selected = true;
         this.gd_ogrinesOffers.dataProvider = [];
         this.gd_kamasOffers.dataProvider = [];
         this.kamasTransferTimer = new BenchmarkTimer(500,1,"BakTab.kamasTransferTimer");
         this.kamasTransferTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.kamasTransferLabelUpdate);
         this.offersRefreshTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.enableRefresh);
         this.offersRefreshTimer.addEventListener(TimerEvent.TIMER,this.decrementRefresh);
         this.sysApi.sendAction(new OpenBakRequestAction([]));
         this.cb_leftDemand.container.visible = false;
         this.cb_leftPrice.container.visible = false;
         this.cb_rightDemand.container.visible = false;
         this.cb_rightPrice.container.visible = false;
         this.initComboBoxes();
         this.resize_labels();
         this.getKamasBuffer();
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.startStats("bakNavigation");
         this._rateStatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onRateStatTimer);
      }
      
      public function updateOgrinesOffersGrid(data:*, componentsRef:*, selected:Boolean) : void
      {
         var bid:Object = null;
         if(data)
         {
            componentsRef.lbl_ogrinesOffersGridKamas.text = this.utilApi.kamasToString(data.kama,"");
            componentsRef.lbl_ogrinesOffersGridOgrines.text = this.utilApi.kamasToString(data.ogrine,"");
            componentsRef.lbl_ogrinesOffersGridRate.text = this.utilApi.kamasToString(data.rate,"");
            componentsRef.ctr_ogrinesOffersGridLineKamas.visible = true;
            componentsRef.ctr_ogrinesOffersGridLineOgrines.visible = true;
            componentsRef.ctr_ogrinesOffersGridLineRate.visible = true;
            componentsRef.btn_ogrinesOffer.visible = true;
            componentsRef.ctr_lineBg.visible = false;
            for each(bid in this._myBids)
            {
               if(bid && bid.sale_article_id != this.KAMAS_OFFER_ID && data.rate == bid.rate)
               {
                  componentsRef.ctr_lineBg.visible = true;
               }
            }
         }
         else
         {
            componentsRef.btn_ogrinesOffer.visible = false;
         }
      }
      
      public function updateKamasOffersGrid(data:*, componentsRef:*, selected:Boolean) : void
      {
         var bid:Object = null;
         if(data)
         {
            componentsRef.lbl_kamasOffersGridKamas.text = this.utilApi.kamasToString(data.kama,"");
            componentsRef.lbl_kamasOffersGridOgrines.text = this.utilApi.kamasToString(data.ogrine,"");
            componentsRef.lbl_kamasOffersGridRate.text = this.utilApi.kamasToString(data.rate,"");
            componentsRef.ctr_kamasOffersGridLineKamas.visible = true;
            componentsRef.ctr_kamasOffersGridLineOgrines.visible = true;
            componentsRef.ctr_kamasOffersGridLineRate.visible = true;
            componentsRef.btn_kamasOffer.visible = true;
            componentsRef.ctr_lineBg.visible = false;
            for each(bid in this._myBids)
            {
               if(bid && bid.sale_article_id == this.KAMAS_OFFER_ID && data.rate == bid.rate)
               {
                  componentsRef.ctr_lineBg.visible = true;
               }
            }
         }
         else
         {
            componentsRef.btn_kamasOffer.visible = false;
         }
      }
      
      public function openBakPopup(type:String, buttonCallback:Function, additionalParams:Dictionary = null) : void
      {
         var params:Object = {};
         params.type = type;
         params.parent = this;
         params.buttonCallback = buttonCallback;
         params.additionalParams = additionalParams;
         this.uiApi.loadUi(WebTabEnum.BAK_POPUP,WebTabEnum.BAK_POPUP,params,StrataEnum.STRATA_TOP,null,true);
      }
      
      private function getKamasBuffer() : void
      {
         this.sysApi.sendAction(new HaapiBufferKamasListRequestAction([]));
      }
      
      private function startTransfer() : void
      {
         this.sysApi.sendAction(new HaapiConsumeBufferKamasRequestAction([]));
         this._labelTransferText = this.uiApi.getText("ui.bak.kamasTransfer");
         this.kamasTransferTimer.start();
         this.ctr_kamasTemp.visible = false;
         this.lbl_kamasTransfer.visible = true;
      }
      
      private function stopTransfer() : void
      {
         this.kamasTransferTimer.stop();
         this.lbl_kamasTransfer.visible = false;
      }
      
      private function kamasTransferLabelUpdate(e:TimerEvent) : void
      {
         this.kamasTransferTimer.reset();
         switch(this.lbl_kamasTransfer.text)
         {
            case this._labelTransferText:
               this.lbl_kamasTransfer.text = this._labelTransferText + " .";
               break;
            case this._labelTransferText + " .":
               this.lbl_kamasTransfer.text = this._labelTransferText + " ..";
               break;
            case this._labelTransferText + " ..":
               this.lbl_kamasTransfer.text = this._labelTransferText + " ...";
               break;
            case this._labelTransferText + " ...":
               this.lbl_kamasTransfer.text = this._labelTransferText;
         }
         this.lbl_kamasTransfer.removeTooltipExtension();
         this.lbl_kamasTransfer.fullWidthAndHeight(0,10);
         this.kamasTransferTimer.start();
      }
      
      private function enableRefresh(e:TimerEvent) : void
      {
         this.btn_refreshKamasOffers.disabled = false;
         this.btn_refreshOgrinesOffers.disabled = false;
         this.ctr_rightCountdown.visible = false;
         this.ctr_leftCountdown.visible = false;
      }
      
      private function decrementRefresh(e:TimerEvent) : void
      {
         this.lbl_rightRefreshCountdown.text = (parseInt(this.lbl_rightRefreshCountdown.text) - 1).toString();
         this.lbl_leftRefreshCountdown.text = (parseInt(this.lbl_leftRefreshCountdown.text) - 1).toString();
      }
      
      private function onDofusBakAccountBids(bid:Array) : void
      {
         this._myBids = bid;
         this._myBid = null;
         for(var i:int = 0; i < this._myBids.length; i++)
         {
            if(this._myBids[i].sale_article_id == this.KAMAS_OFFER_ID && this._selectedTab == this.BUY_OGRINES_TAB)
            {
               this._myBid = this._myBids[i];
            }
            if(this._myBids[i].sale_article_id == this.OGRINE_OFFER_ID && this._selectedTab == this.BUY_KAMAS_TAB)
            {
               this._myBid = this._myBids[i];
            }
         }
         if(this._myBid == null)
         {
            this.ctr_rightTradeInterface.visible = true;
            this.ctr_currentOffer.visible = false;
            this.btn_lbl_btn_rightOffer.text = this.uiApi.getText("ui.bak.createOffer" + (this._selectedTab == this.BUY_KAMAS_TAB ? "Ogrins" : "Kamas"));
         }
         else
         {
            this.ctr_rightTradeInterface.visible = false;
            this.ctr_currentOffer.visible = true;
            this.lbl_yourOffer.text = this.uiApi.getText("ui.bak.currentOfferAmount",this.utilApi.kamasToString(this._myBid.sale_quantity,""));
            this.lbl_yourOffer.removeTooltipExtension();
            this.lbl_yourGain.text = this.uiApi.getText("ui.bak.currentOfferGain",this.utilApi.kamasToString(this._myBid.exchange_quantity,""));
            this.lbl_yourGain.removeTooltipExtension();
            this.lbl_yourOfferRate.text = this.uiApi.getText("ui.bak.popupAtRate",this.utilApi.kamasToString(this._myBid.rate,""));
            this.lbl_yourOfferRate.removeTooltipExtension();
            this.tx_yourOffer.uri = this._myBid.sale_article_id == this.KAMAS_OFFER_ID ? this._uriKamaShad : this._uriOgrineBig;
            this.tx_yourGain.uri = this._myBid.sale_article_id == this.KAMAS_OFFER_ID ? this._uriOgrineBig : this._uriKamaShad;
            this.btn_lbl_btn_rightOffer.text = this.uiApi.getText("ui.bak.cancelOffer");
            this.lbl_yourOffer.fullWidth();
            this.lbl_yourGain.fullWidth();
            this.lbl_yourOfferRate.fullWidth();
            this.tx_yourOffer.x = this.lbl_yourOffer.x + this.lbl_yourOffer.width;
            this.lbl_yourGain.x = this.tx_yourOffer.x + this.tx_yourOffer.width;
            this.tx_yourGain.x = this.lbl_yourGain.x + this.lbl_yourGain.width;
            this.ctr_yourOfferDetail.x = this.lbl_currentOffer.x + this.lbl_currentOffer.width / 2 - this.ctr_yourOfferDetail.width / 2;
            this.lbl_yourOfferRate.x = this.tx_yourOfferRate.x - this.lbl_yourOfferRate.width;
         }
         this.gd_kamasOffers.dataProvider = this.gd_kamasOffers.dataProvider;
         this.gd_ogrinesOffers.dataProvider = this.gd_ogrinesOffers.dataProvider;
      }
      
      private function onDofusBakKamasAmount(k:Number) : void
      {
         this._kamasAmount = k;
         this.lbl_currentKamas.text = this.utilApi.kamasToString(k,"");
      }
      
      private function onDofusBakLinkedOgrines(ogrinesList:Object) : void
      {
         var amount:int = 0;
         var ogrines:Object = null;
         this._linkedOgrinesAmount = 0;
         this._expiringOgrines = [];
         this._ogrinesAmount = 0;
         for each(ogrines in ogrinesList)
         {
            amount = parseInt(ogrines.amount_left,10);
            this._ogrinesAmount += amount;
            if(ogrines.forbidden_usages != "")
            {
               this._linkedOgrinesAmount += amount;
               if(ogrines.date_expiration && new Date(Date.parse(ogrines.date_expiration.replace(/-/g,"/") + " GMT+0200")).valueOf() - new Date().valueOf() < this.WEEK_IN_MS)
               {
                  this._expiringOgrines.push(ogrines);
               }
            }
         }
         if(this._linkedOgrinesAmount != 0)
         {
            this.lbl_linkedOgrinesAmount.text = this.uiApi.getText("ui.bak.linkedOgrinesAmount",this.utilApi.kamasToString(this._linkedOgrinesAmount,""));
            this.lbl_linkedOgrinesAmount.removeTooltipExtension();
            this.lbl_linkedOgrinesAmount.fullWidthAndHeight();
            this.ctr_linkedOgrines.width = this.lbl_linkedOgrinesAmount.width + 85;
            this.tx_ogrinesExpire.uri = this._expiringOgrines.length == 0 ? this.uiApi.createUri(this.uiApi.me().getConstant("interrogation_uri")) : this.uiApi.createUri(this.uiApi.me().getConstant("exclamation_uri"));
            this.lbl_linkedOgrinesAmount.x = this.tx_ogrinesExpireIcon.x - this.lbl_linkedOgrinesAmount.width - 2;
            this.ctr_linkedOgrines.visible = true;
         }
         this.lbl_currentOgrines.text = this.utilApi.kamasToString(this._ogrinesAmount,"");
         if(this._ogrinesSellPrevalues.length == 5 && this.utilApi.stringToKamas(this._ogrinesSellPrevalues[this._ogrinesSellPrevalues.length - 1],"") < this._ogrinesAmount - this._linkedOgrinesAmount)
         {
            this._ogrinesSellPrevalues.push(this.utilApi.kamasToString(this._ogrinesAmount - this._linkedOgrinesAmount,""));
            this.initComboBoxes();
         }
      }
      
      private function onDofusBakAverageRate(rates:Vector.<BakRate>) : void
      {
         this._averageRates = rates;
         this.refreshRate();
      }
      
      private function refreshRate() : void
      {
         var rate:BakRate = null;
         var rateValue:int = 0;
         this.lbl_averageRate.visible = false;
         this.tx_averageRate.visible = false;
         for each(rate in this._averageRates)
         {
            if(rate.type == BakRate.TypeEnum_OGRINES_FOR_KAMAS && this._selectedTab == this.BUY_KAMAS_TAB || rate.type == BakRate.TypeEnum_KAMAS_FOR_OGRINES && this._selectedTab == this.BUY_OGRINES_TAB)
            {
               rateValue = rate.rate;
               this.inp_rightRate.text = rateValue.toString();
               this.lbl_averageRate.text = this.uiApi.getText("ui.bak.averageRate",rateValue);
               this.lbl_averageRate.removeTooltipExtension();
               this.lbl_averageRate.fullWidthAndHeight(0,10);
               this.tx_averageRate.x = this.lbl_averageRate.x + this.lbl_averageRate.width + 1;
               this.lbl_averageRate.visible = true;
               this.tx_averageRate.visible = true;
               this.ctr_averageRate.width = this.tx_averageRate.width + this.lbl_averageRate.width + 1;
               this.ctr_averageRate.x = this.lbl_leftTitle.x + this.lbl_leftTitle.width / 2 - this.ctr_averageRate.width / 2;
            }
         }
      }
      
      private function onDofusBakKamasBufferList(buffers:Vector.<BufferInformation>) : void
      {
         var buffer:BufferInformation = null;
         var bufferedKamas:int = 0;
         for each(buffer in buffers)
         {
            bufferedKamas += buffer.amount;
         }
         this._buffers = buffers;
         this.lbl_kamasTemp.text = this.utilApi.kamasToString(bufferedKamas,"");
         this.ctr_kamasTemp.visible = bufferedKamas > 0;
      }
      
      private function onDofusBakBuyValidation(amount:Number, action:uint, email:String) : void
      {
         var params:Dictionary = new Dictionary();
         params["email"] = email;
         params["amount"] = amount;
         if(action == BidActionEnum.BUY_KAMA)
         {
            this.openBakPopup(BakPopupTypeEnum.BUY_KAMAS_VALIDATED,null,params);
            this.startTransfer();
         }
         else
         {
            this.openBakPopup(BakPopupTypeEnum.BUY_OGRINES_VALIDATED,null,params);
         }
      }
      
      private function onDofusBakConfirmation(params:Dictionary, action:uint) : void
      {
         switch(action)
         {
            case BidActionEnum.BUY_OGRINE:
               this.openBakPopup(BakPopupTypeEnum.BUY_OGRINES,function():void
               {
                  sysApi.sendAction(new HaapiValidationRequestAction([params["transaction"]]));
               },params);
               break;
            case BidActionEnum.BUY_KAMA:
               params["initialKamas"] = this.utilApi.stringToKamas(this.inp_leftDemand.text,"");
               this.openBakPopup(BakPopupTypeEnum.BUY_KAMAS,function():void
               {
                  sysApi.sendAction(new HaapiValidationRequestAction([params["transaction"]]));
               },params);
               break;
            case BidActionEnum.CREATE_KAMA:
               this.openBakPopup(BakPopupTypeEnum.SUBMIT_OFFER_KAMAS,function():void
               {
                  sysApi.sendAction(new HaapiValidationRequestAction([params["transaction"]]));
               },params);
               break;
            case BidActionEnum.CREATE_OGRINE:
               this.openBakPopup(BakPopupTypeEnum.SUBMIT_OFFER_OGRINES,function():void
               {
                  sysApi.sendAction(new HaapiValidationRequestAction([params["transaction"]]));
               },params);
         }
      }
      
      private function onDofusBakCreateBidSuccess() : void
      {
         this.openBakPopup(BakPopupTypeEnum.VALIDATE_OFFER,null);
      }
      
      private function onDofusBakTransferSuccess() : void
      {
         this.stopTransfer();
         this._buffers = new Vector.<BufferInformation>();
         this.ctr_kamasTemp.visible = false;
      }
      
      private function onBakTimeout() : void
      {
         this.ctr_timeout.visible = true;
         this.ctr_bakMain.disabled = true;
         this.ctr_timeout.disabled = false;
      }
      
      private function onDofusBakKamasOffers(offers:Vector.<BakBidOffer>) : void
      {
         this.gd_kamasOffers.dataProvider = offers;
         switch(true)
         {
            case this.btn_kamasOffersOgrines.selected:
               this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByOgrines);
               break;
            case this.btn_kamasOffersKamas.selected:
               this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByKamas);
               break;
            case this.btn_kamasOffersRate.selected:
               this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByRateDesc);
         }
         this.inp_leftDemand.text = this.inp_leftDemand.text;
      }
      
      private function onDofusBakOgrinesOffers(offers:Vector.<BakBidOffer>) : void
      {
         this.gd_ogrinesOffers.dataProvider = offers;
         switch(true)
         {
            case this.btn_ogrinesOffersOgrines.selected:
               this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByOgrines);
               break;
            case this.btn_ogrinesOffersKamas.selected:
               this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByKamas);
               break;
            case this.btn_ogrinesOffersRate.selected:
               this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByRateAsc);
         }
         this.inp_leftDemand.text = this.inp_leftDemand.text;
      }
      
      private function onDofusBakError(code:uint, action:uint) : void
      {
         var errorLbl:Label = action == BidActionEnum.CREATE_OGRINE || action == BidActionEnum.CREATE_KAMA || action == BidActionEnum.CANCEL ? this.lbl_rightError : this.lbl_leftError;
         switch(code)
         {
            case BidValidationEnum.OFFER_DOESNT_EXIST:
               errorLbl.text = this.uiApi.getText("ui.bak.errorNullOffer");
               break;
            case BidValidationEnum.NOT_ENOUGH_KAMAS:
               errorLbl.text = this.uiApi.getText("ui.bak.errorMissingKamas");
               break;
            case BidValidationEnum.NOT_ENOUGH_OGRINES:
               errorLbl.text = this.uiApi.getText("ui.bak.errorMissingOgrines");
               break;
            case BidValidationEnum.SERVER_MAINTENANCE:
               errorLbl.text = this.uiApi.getText("ui.bak.errorWebService");
               break;
            case BidValidationEnum.PLAYER_IN_DEBT:
               errorLbl.text = this.uiApi.getText("ui.bak.errorDebt");
               break;
            case BidValidationEnum.OFFER_IS_YOURS:
               errorLbl.text = this.uiApi.getText("ui.bak.errorCantBuyOwn");
               break;
            default:
               errorLbl.text = this.uiApi.getText("ui.bak.errorGeneric");
         }
      }
      
      private function initComboBoxes() : void
      {
         this.cb_leftDemand.dataProvider = this.cb_rightDemand.dataProvider = this._selectedTab == this.BUY_OGRINES_TAB ? this.OGRINES_BUY_PREVALUES : this.KAMAS_PREVALUES;
         this.cb_leftPrice.dataProvider = this.cb_rightPrice.dataProvider = this._selectedTab == this.BUY_OGRINES_TAB ? this.KAMAS_PREVALUES : this._ogrinesSellPrevalues;
      }
      
      private function resize_labels() : void
      {
         this.lbl_averageRate.fullWidthAndHeight();
         this.lbl_linkedOgrinesAmount.fullWidthAndHeight();
         this.lbl_linked.fullWidthAndHeight();
         this.lbl_leftDemand.fullWidthAndHeight();
         this.lbl_leftPrice.fullWidthAndHeight();
         this.lbl_leftRate.fullWidthAndHeight();
         this.lbl_rightDemand.fullWidthAndHeight();
         this.lbl_rightPrice.fullWidthAndHeight();
         this.lbl_rightPriceOgrines.fullWidthAndHeight();
         this.lbl_rightRate.fullWidthAndHeight();
         this.lbl_leftTitle.fullWidthAndHeight();
         this.lbl_leftDemandKamas.fullWidthAndHeight();
         this.lbl_rightDemandKamas.fullWidthAndHeight();
         this.lbl_leftPrice.fullWidthAndHeight();
         this.lbl_leftPriceOgrines.fullWidthAndHeight();
         this.lbl_ogrinesOffersOgrines.fullWidth();
         this.lbl_ogrinesOffersKamas.fullWidth();
         this.lbl_ogrinesOffersRate.fullWidth();
         this.lbl_kamasOffersKamas.fullWidth();
         this.lbl_kamasOffersOgrines.fullWidth();
         this.lbl_kamasOffersRate.fullWidth();
         this.lbl_offerAlreadyExists.fullWidthAndHeight();
         this.lbl_currentOffer.fullWidthAndHeight();
         this.lbl_yourOffer.fullWidthAndHeight();
         this.lbl_yourGain.fullWidthAndHeight();
         this.lbl_yourOfferRate.fullWidthAndHeight();
         this.lbl_kamasTransfer.removeTooltipExtension();
         this.lbl_offerAlreadyExists.fullWidth();
         this.lbl_offerAlreadyExists.removeTooltipExtension();
         this.lbl_refreshKamasOffersButton.fullWidth();
         this.lbl_refreshOgrinesOffersButton.fullWidth();
         this.lbl_webLinkSeeThe.removeTooltipExtension();
         this.lbl_ogrinePricesLink.removeTooltipExtension();
         this.lbl_webLinkSlash.removeTooltipExtension();
         this.lbl_myBankLink.removeTooltipExtension();
         this.lbl_webLinkSeeThe.fullWidth();
         this.lbl_ogrinePricesLink.fullWidth();
         this.lbl_webLinkSlash.fullWidth();
         this.lbl_myBankLink.fullWidth();
      }
      
      private function resetTradeInterfaces() : void
      {
         this.inp_leftDemand.text = "0";
         this.inp_leftPrice.text = "0";
         this.inp_rightDemand.text = "0";
         this.inp_rightPrice.text = "0";
         this.lbl_leftRateValue.text = "0";
      }
      
      private function selectBuyOgrinesTab() : void
      {
         var diff:int = 0;
         this.changeLeftBuyButtonActiveState(true);
         this.lbl_leftDemand.visible = true;
         this.lbl_leftDemandKamas.visible = false;
         this.lbl_leftPrice.visible = true;
         this.lbl_leftPriceOgrines.visible = false;
         this.lbl_rightDemand.visible = true;
         this.lbl_rightDemandKamas.visible = false;
         this.lbl_rightPrice.visible = true;
         this.lbl_rightPriceOgrines.visible = false;
         this.tx_leftDemand.uri = this._uriOgrineBig;
         this.tx_leftPrice.uri = this._uriKamaShad;
         this.tx_rightDemand.uri = this._uriOgrineBig;
         this.tx_rightPrice.uri = this._uriKamaShad;
         this.lbl_rightTitle.text = this.uiApi.getText("ui.bak.submitOfferKamas");
         this.lbl_rightTitle.removeTooltipExtension();
         this.lbl_rightTitle.fullWidth();
         this.btn_lbl_btn_leftBuy.text = this.uiApi.getText("ui.bak.buyOgrines");
         if(this.blk_ogrinesOffersGridBlock.x > this.blk_kamasOffersGridBlock.x)
         {
            diff = this.blk_ogrinesOffersGridBlock.x - this.blk_kamasOffersGridBlock.x;
            this.blk_ogrinesOffersGridBlock.x -= diff;
            this.lbl_ogrinesOffersGrid.x -= diff;
            this.blk_kamasOffersGridBlock.x += diff;
            this.lbl_kamasOffersGrid.x += diff;
         }
         this._selectedTab = this.BUY_OGRINES_TAB;
         this.sysApi.setData(this.BAK_LAST_TAB,this._selectedTab);
         this.initComboBoxes();
         this.resetTradeInterfaces();
         this.refreshRate();
         this.onDofusBakAccountBids(this._myBids);
      }
      
      private function selectBuyKamasTab() : void
      {
         var diff:int = 0;
         this.changeLeftBuyButtonActiveState(true);
         this.lbl_leftDemand.visible = false;
         this.lbl_leftDemandKamas.visible = true;
         this.lbl_leftPrice.visible = false;
         this.lbl_leftPriceOgrines.visible = true;
         this.lbl_rightDemand.visible = false;
         this.lbl_rightDemandKamas.visible = true;
         this.lbl_rightPrice.visible = false;
         this.lbl_rightPriceOgrines.visible = true;
         this.tx_leftDemand.uri = this._uriKamaShad;
         this.tx_leftPrice.uri = this._uriOgrineBig;
         this.tx_rightDemand.uri = this._uriKamaShad;
         this.tx_rightPrice.uri = this._uriOgrineBig;
         this.lbl_rightTitle.text = this.uiApi.getText("ui.bak.submitOfferOgrins");
         this.lbl_rightTitle.removeTooltipExtension();
         this.lbl_rightTitle.fullWidth();
         this.btn_lbl_btn_leftBuy.text = this.uiApi.getText("ui.bak.buyKamas");
         if(this.blk_ogrinesOffersGridBlock.x < this.blk_kamasOffersGridBlock.x)
         {
            diff = this.blk_kamasOffersGridBlock.x - this.blk_ogrinesOffersGridBlock.x;
            this.blk_ogrinesOffersGridBlock.x += diff;
            this.lbl_ogrinesOffersGrid.x += diff;
            this.blk_kamasOffersGridBlock.x -= diff;
            this.lbl_kamasOffersGrid.x -= diff;
         }
         this._selectedTab = this.BUY_KAMAS_TAB;
         this.sysApi.setData(this.BAK_LAST_TAB,this._selectedTab);
         this.initComboBoxes();
         this.resetTradeInterfaces();
         this.refreshRate();
         this.onDofusBakAccountBids(this._myBids);
      }
      
      private function sortOffersByKamas(offerA:Object, offerB:Object) : Number
      {
         return offerA.kama > offerB.kama ? Number(-1) : (offerA.kama == offerB.kama ? Number(0) : Number(1));
      }
      
      private function sortOffersByOgrines(offerA:Object, offerB:Object) : Number
      {
         return offerA.ogrine > offerB.ogrine ? Number(-1) : (offerA.ogrine == offerB.ogrine ? Number(0) : Number(1));
      }
      
      private function sortOffersByRateAsc(offerA:Object, offerB:Object) : Number
      {
         return offerA.rate > offerB.rate ? Number(1) : (offerA.rate == offerB.rate ? Number(0) : Number(-1));
      }
      
      private function sortOffersByRateDesc(offerA:Object, offerB:Object) : Number
      {
         return offerA.rate > offerB.rate ? Number(-1) : (offerA.rate == offerB.rate ? Number(0) : Number(1));
      }
      
      private function sortOffersGrid(grid:*, sortMethod:Function) : void
      {
         var tempArray:Vector.<BakBidOffer> = grid.dataProvider as Vector.<BakBidOffer>;
         tempArray.sort(sortMethod);
         grid.dataProvider = tempArray;
      }
      
      private function displayKamasOffer(item:Object) : void
      {
         if(this._selectedTab == this.BUY_OGRINES_TAB)
         {
            this.inp_rightDemand.text = this.utilApi.kamasToString(item.ogrine,"");
            this.inp_rightPrice.text = this.utilApi.kamasToString(item.kama,"");
            this.inp_rightRate.text = this.utilApi.kamasToString(item.rate,"");
         }
         else
         {
            this.inp_leftDemand.text = this.utilApi.kamasToString(item.kama,"");
            this.inp_leftPrice.text = this.utilApi.kamasToString(item.ogrine,"");
            this.lbl_leftRateValue.text = this.utilApi.kamasToString(item.rate,"");
         }
      }
      
      private function changeLeftBuyButtonActiveState(isEnabled:Boolean) : void
      {
         this.btn_leftBuy.softDisabled = !isEnabled;
         if(isEnabled)
         {
            this.uiApi.removeComponentHook(this.btn_leftBuy,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.btn_leftBuy,ComponentHookList.ON_ROLL_OUT);
         }
         else if(this._selectedTab === this.BUY_OGRINES_TAB)
         {
            this.uiApi.addComponentHook(this.btn_leftBuy,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_leftBuy,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function displayOgrinesOffer(item:Object) : void
      {
         if(this._selectedTab == this.BUY_OGRINES_TAB)
         {
            this.inp_leftDemand.text = this.utilApi.kamasToString(item.ogrine,"");
            this.inp_leftPrice.text = this.utilApi.kamasToString(item.kama,"");
            this.lbl_leftRateValue.text = this.utilApi.kamasToString(item.rate,"");
         }
         else
         {
            this.inp_rightDemand.text = this.utilApi.kamasToString(item.kama,"");
            this.inp_rightPrice.text = this.utilApi.kamasToString(item.ogrine,"");
            this.inp_rightRate.text = this.utilApi.kamasToString(item.rate,"");
         }
      }
      
      private function autoSelectOfferDemand() : void
      {
         var tempRate:int = 0;
         var selectedOffer:Object = null;
         var offer:* = undefined;
         for each(offer in this._selectedTab == this.BUY_KAMAS_TAB ? this.gd_kamasOffers.dataProvider : this.gd_ogrinesOffers.dataProvider)
         {
            if((this._selectedTab == this.BUY_KAMAS_TAB ? offer.kama : offer.ogrine) >= int(this.utilApi.stringToKamas(this.inp_leftDemand.text,"")) && (!tempRate || (this._selectedTab == this.BUY_KAMAS_TAB ? Boolean(tempRate < offer.rate) : Boolean(tempRate > offer.rate))))
            {
               tempRate = offer.rate;
               selectedOffer = offer;
            }
         }
         if(tempRate)
         {
            this.changeLeftBuyButtonActiveState(true);
            this.lbl_leftRateValue.text = selectedOffer.rate;
            this.inp_leftPrice.text = this._selectedTab == this.BUY_OGRINES_TAB ? (this.utilApi.stringToKamas(this.inp_leftDemand.text,"") * this.utilApi.stringToKamas(this.lbl_leftRateValue.text,"")).toString() : Math.ceil(this.utilApi.stringToKamas(this.inp_leftDemand.text,"") / this.utilApi.stringToKamas(this.lbl_leftRateValue.text,"")).toString();
            if(this.inp_leftPrice.text == NaN.toString() || this.inp_leftPrice.text == Infinity.toString())
            {
               this.inp_leftPrice.text = "0";
            }
            this.selectOffer(this._selectedTab == this.BUY_KAMAS_TAB ? this.gd_kamasOffers : this.gd_ogrinesOffers,selectedOffer);
         }
         else
         {
            this.inp_leftPrice.text = "0";
            this.changeLeftBuyButtonActiveState(false);
         }
      }
      
      private function autoSelectOfferPrice() : void
      {
         var tempRate:int = 0;
         var selectedOffer:Object = null;
         var offer:* = undefined;
         for each(offer in this._selectedTab == this.BUY_KAMAS_TAB ? this.gd_kamasOffers.dataProvider : this.gd_ogrinesOffers.dataProvider)
         {
            if((this._selectedTab == this.BUY_KAMAS_TAB ? offer.ogrine : offer.kama) >= int(this.utilApi.stringToKamas(this.inp_leftPrice.text,"")) && (!tempRate || (this._selectedTab == this.BUY_KAMAS_TAB ? Boolean(tempRate < offer.rate) : Boolean(tempRate > offer.rate))))
            {
               tempRate = offer.rate;
               selectedOffer = offer;
            }
         }
         if(tempRate)
         {
            this.changeLeftBuyButtonActiveState(true);
            this.lbl_leftRateValue.text = selectedOffer.rate;
            this.inp_leftDemand.text = this._selectedTab == this.BUY_OGRINES_TAB ? Math.ceil(this.utilApi.stringToKamas(this.inp_leftPrice.text,"") / this.utilApi.stringToKamas(this.lbl_leftRateValue.text,"")).toString() : Math.ceil(this.utilApi.stringToKamas(this.inp_leftPrice.text,"") * this.utilApi.stringToKamas(this.lbl_leftRateValue.text,"")).toString();
            if(this.inp_leftDemand.text == NaN.toString() || this.inp_leftDemand.text == Infinity.toString())
            {
               this.inp_leftDemand.text = "0";
            }
            this.selectOffer(this._selectedTab == this.BUY_KAMAS_TAB ? this.gd_kamasOffers : this.gd_ogrinesOffers,selectedOffer);
         }
         else
         {
            this.inp_leftDemand.text = "0";
            this.changeLeftBuyButtonActiveState(false);
         }
      }
      
      private function selectOffer(grid:Grid, offer:Object) : void
      {
         for(var i:int = 0; i < grid.dataProvider.length; i++)
         {
            if(grid.dataProvider[i].kama == offer.kama && grid.dataProvider[i].ogrine == offer.ogrine && grid.dataProvider[i].rate == offer.rate)
            {
               grid.selectedIndex = i;
               return;
            }
         }
      }
      
      private function refreshOffers() : void
      {
         if(!this.offersRefreshTimer.running)
         {
            this.offersRefreshTimer.reset();
            this.offersRefreshTimer.start();
            this.lbl_leftRefreshCountdown.text = "5";
            this.lbl_rightRefreshCountdown.text = "5";
            this.btn_refreshKamasOffers.disabled = true;
            this.btn_refreshOgrinesOffers.disabled = true;
            this.ctr_rightCountdown.visible = true;
            this.ctr_leftCountdown.visible = true;
            this.sysApi.sendAction(new RefreshBakOffersAction());
         }
      }
      
      private function onUiLoaded(name:String) : void
      {
         if(this.uiApi.me().name == name)
         {
            this.sysApi.removeHook(BeriliaHookList.UiLoaded);
            switch(this.sysApi.getData(this.BAK_LAST_TAB))
            {
               case this.BUY_KAMAS_TAB:
                  this.selectBuyKamasTab();
                  this.btn_buyKamasTab.selected = true;
                  break;
               default:
                  this.selectBuyOgrinesTab();
                  this.btn_buyOgrinesTab.selected = true;
            }
         }
      }
      
      public function unload() : void
      {
         this.stopTransfer();
         this._rateStatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRateStatTimer);
         this.kamasTransferTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.kamasTransferLabelUpdate);
         this.offersRefreshTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.enableRefresh);
         this.offersRefreshTimer.removeEventListener(TimerEvent.TIMER,this.decrementRefresh);
         this.kamasTransferTimer.reset();
         this.offersRefreshTimer.reset();
         this._rateStatTimer.reset();
         this._rateStatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onRateStatTimer);
      }
      
      public function onChange(target:Input) : void
      {
         if(this._changing)
         {
            return;
         }
         if(target.haveFocus)
         {
            this._changing = true;
            switch(target)
            {
               case this.inp_leftDemand:
                  this.autoSelectOfferDemand();
                  this.inp_leftDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_leftDemand.text,""),"");
                  this.inp_leftPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_leftPrice.text,""),"");
                  this.lbl_leftRateValue.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.lbl_leftRateValue.text,""),"");
                  break;
               case this.inp_leftPrice:
                  this.autoSelectOfferPrice();
                  this.inp_leftDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_leftDemand.text,""),"");
                  this.inp_leftPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_leftPrice.text,""),"");
                  this.lbl_leftRateValue.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.lbl_leftRateValue.text,""),"");
                  break;
               case this.inp_rightDemand:
               case this.inp_rightRate:
                  this._rateStatTimer.start();
                  this.inp_rightPrice.text = this._selectedTab == this.BUY_OGRINES_TAB ? (this.utilApi.stringToKamas(this.inp_rightDemand.text,"") * this.utilApi.stringToKamas(this.inp_rightRate.text,"")).toString() : Math.floor(this.utilApi.stringToKamas(this.inp_rightDemand.text,"") / this.utilApi.stringToKamas(this.inp_rightRate.text,"")).toString();
                  if(this.inp_rightPrice.text == NaN.toString() || this.inp_rightPrice.text == Infinity.toString())
                  {
                     this.inp_rightPrice.text = "0";
                  }
                  this.inp_rightDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_rightDemand.text,""),"");
                  this.inp_rightPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_rightPrice.text,""),"");
                  this.inp_rightRate.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_rightRate.text,""),"");
                  break;
               case this.inp_rightPrice:
                  this.inp_rightDemand.text = this._selectedTab == this.BUY_OGRINES_TAB ? Math.floor(this.utilApi.stringToKamas(this.inp_rightPrice.text,"") / this.utilApi.stringToKamas(this.inp_rightRate.text,"")).toString() : (this.utilApi.stringToKamas(this.inp_rightPrice.text,"") * this.utilApi.stringToKamas(this.inp_rightRate.text,"")).toString();
                  if(this.inp_rightDemand.text == NaN.toString() || this.inp_rightDemand.text == Infinity.toString())
                  {
                     this.inp_rightDemand.text = "0";
                  }
                  this.inp_rightDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_rightDemand.text,""),"");
                  this.inp_rightPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(this.inp_rightPrice.text,""),"");
            }
            target.setSelection(target.length,target.length);
            this._changing = false;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == GridItemSelectMethodEnum.CLICK)
         {
            switch(target)
            {
               case this.gd_ogrinesOffers:
                  this.displayOgrinesOffer(target.selectedItem);
                  break;
               case this.gd_kamasOffers:
                  this.displayKamasOffer(target.selectedItem);
                  break;
               case this.cb_leftDemand:
                  this.inp_leftDemand.focus();
                  this.inp_leftDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(target.selectedItem,""),"");
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"choose",this._selectedTab == this.BUY_OGRINES_TAB ? "choose combox OGR" : "choose combox KAMAS",this.utilApi.stringToKamas(target.selectedItem,""));
                  break;
               case this.cb_leftPrice:
                  this.inp_leftPrice.focus();
                  this.inp_leftPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(target.selectedItem,""),"");
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"choose",this._selectedTab == this.BUY_OGRINES_TAB ? "choose combox KAMAS" : "choose combox OGR",this.utilApi.stringToKamas(target.selectedItem,""));
                  break;
               case this.cb_rightDemand:
                  this.inp_rightDemand.focus();
                  this.inp_rightDemand.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(target.selectedItem,""),"");
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"choose",this._selectedTab == this.BUY_OGRINES_TAB ? "choose combox OGR" : "choose combox KAMAS",this.utilApi.stringToKamas(target.selectedItem,""));
                  break;
               case this.cb_rightPrice:
                  this.inp_rightPrice.focus();
                  this.inp_rightPrice.text = this.utilApi.kamasToString(this.utilApi.stringToKamas(target.selectedItem,""),"");
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"choose",this._selectedTab == this.BUY_OGRINES_TAB ? "choose combox KAMAS" : "choose combox OGR",this.utilApi.stringToKamas(target.selectedItem,""));
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var params:Dictionary = null;
         this.lbl_leftError.text = "";
         this.lbl_rightError.text = "";
         switch(target)
         {
            case this.btn_myBankLink:
               this.sysApi.goToUrl(this.sysApi.getConfigEntry("config.webSiteUrl") + this.uiApi.getText("ui.link.bakBankUrl") + "?nickname=" + this.sysApi.getNickname());
               break;
            case this.btn_ogrinePricesLink:
               this.sysApi.goToUrl(this.sysApi.getConfigEntry("config.webSiteUrl") + this.uiApi.getText("ui.link.bakOgrineRateUrl"));
               break;
            case this.btn_gotToSubscriptions:
               this.sysApi.dispatchHook(ExternalGameHookList.OpenWebService,"webShop",[this.SUBSCRIPTION_CAT_ID]);
               break;
            case this.btn_buyOgrines:
               this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click plus button",null);
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.buyOgrine"));
               break;
            case this.btn_buyOgrinesTab:
               this.refreshOffers();
               this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click purchase Ogrines",null);
               this.selectBuyOgrinesTab();
               break;
            case this.btn_buyKamasTab:
               this.refreshOffers();
               this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click purchase Kamas",null);
               this.selectBuyKamasTab();
               break;
            case this.btn_leftBuy:
               this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click buy an offer",null);
               if(this.inp_leftPrice.text == "0" || this.inp_leftDemand.text == "0" || this.lbl_leftRateValue.text == "0")
               {
                  this.lbl_leftError.text = this.uiApi.getText("ui.bak.errorZeroValue");
                  break;
               }
               if(this._selectedTab == this.BUY_OGRINES_TAB)
               {
                  this.sysApi.sendAction(new HaapiConfirmationRequestAction([this.utilApi.stringToKamas(this.inp_leftPrice.text,""),this.utilApi.stringToKamas(this.inp_leftDemand.text,""),this.utilApi.stringToKamas(this.lbl_leftRateValue.text,""),BidActionEnum.BUY_OGRINE]));
               }
               else
               {
                  this.sysApi.sendAction(new HaapiConfirmationRequestAction([this.utilApi.stringToKamas(this.inp_leftDemand.text,""),this.utilApi.stringToKamas(this.inp_leftPrice.text,""),this.utilApi.stringToKamas(this.lbl_leftRateValue.text,""),BidActionEnum.BUY_KAMA]));
               }
               break;
            case this.btn_rightOffer:
               this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click create an offer",null);
               if(this._myBid)
               {
                  params = new Dictionary();
                  params["bid"] = this._myBid;
                  this.openBakPopup(this._selectedTab == this.BUY_OGRINES_TAB ? BakPopupTypeEnum.CANCEL_OFFER_KAMAS : BakPopupTypeEnum.CANCEL_OFFER_OGRINES,function():void
                  {
                     sysApi.sendAction(new HaapiCancelBidRequestAction([_myBid.id,BidCancellationEnum.CLASSIC]));
                  },params);
               }
               else
               {
                  if(this.inp_rightPrice.text == "0" || this.inp_rightDemand.text == "0" || this.inp_rightRate.text == "0" || this.inp_rightRate.text == "")
                  {
                     this.lbl_rightError.text = this.uiApi.getText("ui.bak.errorZeroValue");
                     break;
                  }
                  if(this._selectedTab == this.BUY_OGRINES_TAB)
                  {
                     this.sysApi.sendAction(new HaapiConfirmationRequestAction([this.utilApi.stringToKamas(this.inp_rightPrice.text,""),this.utilApi.stringToKamas(this.inp_rightDemand.text,""),this.utilApi.stringToKamas(this.inp_rightRate.text,""),BidActionEnum.CREATE_KAMA]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new HaapiConfirmationRequestAction([this.utilApi.stringToKamas(this.inp_rightDemand.text,""),this.utilApi.stringToKamas(this.inp_rightPrice.text,""),this.utilApi.stringToKamas(this.inp_rightRate.text,""),BidActionEnum.CREATE_OGRINE]));
                  }
               }
               break;
            case this.btn_transferKamasTemp:
               this.startTransfer();
               break;
            case this.btn_refreshOgrinesOffers:
            case this.btn_refreshKamasOffers:
               this.refreshOffers();
            default:
               if(target.name.indexOf("btn_ogrinesOffers") != -1)
               {
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click sort",null);
                  this.btn_ogrinesOffersOgrines.selected = false;
                  this.btn_ogrinesOffersKamas.selected = false;
                  this.btn_ogrinesOffersRate.selected = false;
                  (target as ButtonContainer).selected = true;
                  switch(true)
                  {
                     case target.name.indexOf("Ogrines") != -1:
                        this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByOgrines);
                        break;
                     case target.name.indexOf("Kamas") != -1:
                        this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByKamas);
                        break;
                     case target.name.indexOf("Rate") != -1:
                        this.sortOffersGrid(this.gd_ogrinesOffers,this.sortOffersByRateAsc);
                  }
               }
               else if(target.name.indexOf("btn_kamasOffers") != -1)
               {
                  this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"click","click sort",null);
                  this.btn_kamasOffersKamas.selected = false;
                  this.btn_kamasOffersOgrines.selected = false;
                  this.btn_kamasOffersRate.selected = false;
                  (target as ButtonContainer).selected = true;
                  switch(true)
                  {
                     case target.name.indexOf("Ogrines") != -1:
                        this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByOgrines);
                        break;
                     case target.name.indexOf("Kamas") != -1:
                        this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByKamas);
                        break;
                     case target.name.indexOf("Rate") != -1:
                        this.sortOffersGrid(this.gd_kamasOffers,this.sortOffersByRateDesc);
                  }
               }
               else if(target.name.indexOf("inp_") != -1)
               {
                  (target as Input).setSelection((target as Input).length,(target as Input).length);
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:* = null;
         var msDiff:int = 0;
         var ogrines:Object = null;
         switch(target)
         {
            case this.tx_link:
               text = this.uiApi.getText("ui.bak.overKamOgrLinked");
               break;
            case this.btn_leftBuy:
               if(this._selectedTab === this.BUY_OGRINES_TAB)
               {
                  text = this.uiApi.getText("ui.bak.noOfferOgrineQuantity");
               }
               break;
            case this.ctr_kamasAmount:
               text = this.uiApi.getText("ui.bak.kamasAmount");
               break;
            case this.ctr_ogrinesAmount:
               text = this.uiApi.getText("ui.bak.ogrinesTotalAmount");
               break;
            case this.btn_transferKamasTemp:
               text = this.uiApi.getText("ui.bak.getTempKamas");
               break;
            case this.tx_ogrinesExpire:
               if(this._expiringOgrines.length == 0)
               {
                  text = this.uiApi.getText("ui.bak.linkedOgrines") + "<br/><br/>" + this.uiApi.getText("ui.bak.linkedOgrinesNotExpiring");
               }
               else
               {
                  text = this.uiApi.getText("ui.bak.linkedOgrines") + "<br/><br/>" + this.uiApi.getText("ui.bak.linkedOgrinesExpiring") + "<br/>";
                  for each(ogrines in this._expiringOgrines)
                  {
                     msDiff = Date.parse(ogrines.date_expiration.replace(/-/g,"/") + " GMT+0200") - new Date().valueOf();
                  }
                  text += "<br/>" + ogrines.amount_left.toString() + " " + this.uiApi.getText("ui.bak.ogrinesExpireValue") + " " + (Math.ceil(msDiff / this.ONE_DAYS_IN_MS) <= 1 ? "" : Math.ceil(msDiff / this.ONE_DAYS_IN_MS) - 1 + this.uiApi.getText("ui.time.short.day")) + " " + (Math.ceil(msDiff % this.ONE_DAYS_IN_MS / this.ONE_HOUR_IN_MS) <= 1 ? "" : Math.ceil(msDiff % this.ONE_DAYS_IN_MS / this.ONE_HOUR_IN_MS) - 1 + this.uiApi.getText("ui.time.short.hour")) + " " + (Math.ceil(msDiff % this.ONE_HOUR_IN_MS / this.ONE_MIN_IN_MS) <= 1 ? "" : Math.ceil(msDiff % this.ONE_HOUR_IN_MS / this.ONE_MIN_IN_MS) - 1 + this.uiApi.getText("ui.time.short.minute"));
               }
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      private function onRateStatTimer(e:Event) : void
      {
         this._rateStatTimer.reset();
         this.sysApi.dispatchHook(ExternalGameHookList.BakTabStats,"value","entered value",this.utilApi.stringToKamas(this.inp_rightRate.text,""));
      }
   }
}
