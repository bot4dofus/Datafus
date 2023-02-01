package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankama.haapi.client.api.BakBidApi;
   import com.ankama.haapi.client.api.BakRateApi;
   import com.ankama.haapi.client.api.MoneyApi;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class DofusBakManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LangManager));
      
      private static var _self:DofusBakManager;
       
      
      public var bakRateApi:BakRateApi;
      
      public var bakBidApi:BakBidApi;
      
      public var moneyApi:MoneyApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      private var _accountId:Number;
      
      private var _serverId:Number;
      
      private var _key:String;
      
      private var _timeoutTimer:BenchmarkTimer;
      
      public function DofusBakManager()
      {
         super();
      }
      
      public static function getInstance() : DofusBakManager
      {
         if(!_self)
         {
            _self = new DofusBakManager();
         }
         return _self;
      }
      
      public function init(key:String) : void
      {
         this._serverId = PlayerManager.getInstance().server.id;
         this._accountId = PlayerManager.getInstance().accountId;
         this._key = key;
         var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),this._key);
         this.bakBidApi = new BakBidApi(apiCredentials);
         this.bakRateApi = new BakRateApi(apiCredentials);
         this.moneyApi = new MoneyApi(apiCredentials);
         this.refreshOffers();
         this.refreshMoney();
         this._timeoutTimer = new BenchmarkTimer(3000,1,"DofusBakManager._timeOutTimer");
         this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
         this._timeoutTimer.start();
         this.bakRateApi.get_directions_rates(this._serverId).onSuccess(this.onAverageRate).onError(this.onAverageRateError).call();
         this.refreshAccountBids();
         this.onKamasAmount(InventoryManager.getInstance().bankInventory.kamas + InventoryManager.getInstance().inventory.kamas);
      }
      
      public function refreshMoney() : void
      {
         this.moneyApi.ogrins_account(false).onSuccess(this.onLinkedOgrines).onError(this.onLinkedOgrinesError).call();
      }
      
      public function refreshOffers() : void
      {
         this.bakBidApi.get_offers_kamas(this._serverId,"rate","A").onSuccess(this.onKamasOffers).onError(this.onKamasOffersError).call();
         this.bakBidApi.get_offers_ogrines(this._serverId,"rate","A").onSuccess(this.onOgrinesOffers).onError(this.onOgrinesOffersError).call();
      }
      
      public function refreshAccountBids() : void
      {
         this.bakBidApi.get_account_bids("open").onSuccess(this.onAccountBids).onError(this.onAccountBidsError).call();
      }
      
      private function onKamasAmount(k:Number) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakKamasAmount,k);
      }
      
      private function onAverageRate(e:ApiClientEvent) : void
      {
         this._timeoutTimer.reset();
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakAverageRate,e.response.payload.rates);
      }
      
      private function onAverageRateError(e:ApiClientEvent) : void
      {
         this._timeoutTimer.reset();
         _log.warn("Haapi bak average rate Error");
      }
      
      private function onKamasOffers(e:ApiClientEvent) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakKamasOffers,e.response.payload.offers);
      }
      
      private function onKamasOffersError(e:ApiClientEvent) : void
      {
         _log.warn("Haapi bak kamas offers Error");
      }
      
      private function onOgrinesOffers(e:ApiClientEvent) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakOgrinesOffers,e.response.payload.offers);
      }
      
      private function onOgrinesOffersError(e:ApiClientEvent) : void
      {
         _log.warn("Haapi bak ogrines offers Error");
      }
      
      private function onAccountBids(e:ApiClientEvent) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakAccountBids,e.response.payload);
      }
      
      private function onAccountBidsError(e:ApiClientEvent) : void
      {
         _log.warn("Haapi bak account bids Error");
      }
      
      private function onMoneyError(e:ApiClientEvent) : void
      {
         _log.warn("Haapi bak money Error");
      }
      
      private function onLinkedOgrines(e:ApiClientEvent) : void
      {
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakLinkedOgrines,e.response.payload);
      }
      
      private function onLinkedOgrinesError(e:ApiClientEvent) : void
      {
         _log.warn("Haapi bak linked ogrines Error");
      }
      
      private function onTimeout(e:TimerEvent) : void
      {
         this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.BakTimeout);
      }
   }
}
