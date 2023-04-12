package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankama.haapi.client.api.GiftApi;
   import com.ankama.haapi.client.api.KardApi;
   import com.ankama.haapi.client.api.MoneyApi;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class CodesAndGiftManager
   {
      
      private static const HAAPI_BASE_PATH:String = XmlConfig.getInstance().getEntry("config.haapiUrlAnkama");
      
      private static const DOFUS_GAME_ID:Number = 1;
      
      private static const DOFUS_COLLECTION_ID:Number = 2;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CodesAndGiftManager));
      
      private static var _self:CodesAndGiftManager;
       
      
      public var openedMB:Dictionary;
      
      [Api(name="KardApi")]
      public var kardApi:KardApi;
      
      [Api(name="GiftApi")]
      public var giftApi:GiftApi;
      
      public var moneyApi:MoneyApi;
      
      private var _accountId:Number;
      
      private var _serverId:Number;
      
      private var _key:String;
      
      public function CodesAndGiftManager()
      {
         super();
      }
      
      public static function getInstance() : CodesAndGiftManager
      {
         if(!_self)
         {
            _self = new CodesAndGiftManager();
         }
         return _self;
      }
      
      public function init(key:String) : void
      {
         this._serverId = PlayerManager.getInstance().server.id;
         this._accountId = PlayerManager.getInstance().accountId;
         this.openedMB = new Dictionary();
         this._key = key;
         var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",HAAPI_BASE_PATH,this._key);
         this.kardApi = new KardApi(apiCredentials);
         this.giftApi = new GiftApi(apiCredentials);
         this.moneyApi = new MoneyApi(apiCredentials);
         this.refreshDatas(null);
      }
      
      public function consumeCode(code:String) : void
      {
         this.kardApi.consume_by_code(code,"null").onSuccess(this.onCodeConsume).onError(this.onCodeError).call();
      }
      
      public function consumeKard(id:uint) : void
      {
         this.kardApi.consume_by_id("null",id,DOFUS_GAME_ID).onSuccess(this.onKardConsume(id)).onError(this.onKardConsumeError).call();
      }
      
      public function consumeKardMultiple(id:uint) : void
      {
         this.kardApi.consume_by_id("null",id,DOFUS_GAME_ID).onSuccess(this.onMultipleKardConsumed).onError(this.onMultipleKardConsumedError).call();
      }
      
      public function updatePurchaseList() : void
      {
         this.kardApi.get_by_account_id_with_api_key("null",DOFUS_COLLECTION_ID).onSuccess(this.onPurchaseListUpdated).onError(this.onListUpdateError).call();
      }
      
      private function refreshDatas(e:TimerEvent) : void
      {
         this.updatePurchaseList();
         this.moneyApi.ogrins_amount().onSuccess(this.onMoney).onError(this.onMoneyError).call();
      }
      
      private function processCallError(error:*) : void
      {
         _log.error(error);
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.shop.errorApi"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
      }
      
      private function onCodeConsume(e:ApiClientEvent) : void
      {
         if(e.response.payload)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftCodeSuccess,e.response.payload);
         }
      }
      
      private function onMoney(e:ApiClientEvent) : void
      {
         if(e.response.payload)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,e.response.payload.amount);
         }
      }
      
      public function onMoneyError(e:ApiClientEvent) : void
      {
         _log.error("Can\'t Retrieve Money ammount from Haapi");
      }
      
      private function onCodeError(e:ApiClientEvent) : void
      {
         if(e.response.payload)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftErrorCode,e.response.payload);
         }
      }
      
      private function onMultipleKardConsumed(e:ApiClientEvent) : void
      {
         var payload:Array = e.response.payload as Array;
         if(!payload || payload.length <= 0)
         {
            return;
         }
         if(!this.openedMB[payload[0].id])
         {
            this.openedMB[payload[0].id] = 0;
         }
         ++this.openedMB[payload[0].id];
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftConsumeMultipleKardSuccess,payload);
      }
      
      private function onMultipleKardConsumedError(e:ApiClientEvent) : void
      {
         _log.error("Error while consuming multiple kard from haapi");
      }
      
      private function onKardConsume(id:int) : Function
      {
         return function(e:ApiClientEvent):void
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftConsumeSimpleKardSuccess,id);
         };
      }
      
      private function onKardConsumeError(e:ApiClientEvent) : void
      {
         _log.error("Error while consuming kard from haapi");
      }
      
      private function onPurchaseListUpdated(e:ApiClientEvent) : void
      {
         if(e.response.payload)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.CodesAndGiftUpdatePurchaseList,e.response.payload);
         }
      }
      
      private function onListUpdateError(e:ApiClientEvent) : void
      {
         _log.error("Error while retrieving purchase list from Haapi");
      }
   }
}
