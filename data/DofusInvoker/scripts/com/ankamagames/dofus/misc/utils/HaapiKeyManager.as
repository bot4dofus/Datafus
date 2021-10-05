package com.ankamagames.dofus.misc.utils
{
   import com.ankama.haapi.client.api.AccountApi;
   import com.ankama.haapi.client.model.Token;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.misc.utils.events.AccountSessionReadyEvent;
   import com.ankamagames.dofus.misc.utils.events.GameSessionReadyEvent;
   import com.ankamagames.dofus.misc.utils.events.TokenReadyEvent;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiApiKeyRequestMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class HaapiKeyManager extends EventDispatcher implements IDestroyable
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(HaapiKeyManager));
      
      private static const ONE_HOUR_IN_MS:uint = 3600000;
      
      private static var _instance:HaapiKeyManager;
       
      
      private var _apiKey:String = null;
      
      private var _gameSessionId:Number = 0;
      
      private var _accountSessionId:String = null;
      
      private var _tokens:Dictionary;
      
      private var _askedApiKey:Boolean = false;
      
      private var _askedToken:Boolean = false;
      
      private var _askedTokens:Vector.<int>;
      
      private var _accountApi:AccountApi;
      
      private var _apiKeyCallbacks:Vector.<Function>;
      
      private var _apiKeyExpirationTimer:BenchmarkTimer;
      
      private var _retryTimer:BenchmarkTimer;
      
      private var _apiCredentials:ApiUserCredentials;
      
      public function HaapiKeyManager()
      {
         this._tokens = new Dictionary();
         this._askedTokens = new Vector.<int>();
         this._apiKeyExpirationTimer = new BenchmarkTimer(ONE_HOUR_IN_MS,1,"HaapiKeyManager._apiKeyExpirationTimer");
         this._retryTimer = new BenchmarkTimer(500,1,"HaapiKeyManager._retryTimer");
         super();
         this._apiCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),null);
         this._apiKeyExpirationTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onApiKeyExpiration);
         this._retryTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
      }
      
      public static function getInstance() : HaapiKeyManager
      {
         if(!_instance)
         {
            _instance = new HaapiKeyManager();
         }
         return _instance;
      }
      
      private function onAccountApiCallError(event:ApiClientEvent) : void
      {
         if(event.response.payload != null)
         {
            _log.debug("Account Api Error : " + event.response.errorMessage);
            this._askedToken = false;
            this.nextToken();
         }
      }
      
      private function onAccountApiCallResult(event:ApiClientEvent) : void
      {
         var token:String = null;
         var gameId:int = 0;
         var payload:* = event.response.payload;
         if(payload && payload is Token)
         {
            token = Token(payload).token;
            gameId = this._askedTokens.shift();
            this._tokens[gameId] = token;
            dispatchEvent(new TokenReadyEvent(gameId));
            this._askedToken = false;
            this.nextToken();
         }
      }
      
      private function onApiKeyExpiration(e:TimerEvent) : void
      {
         this._apiKeyExpirationTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onApiKeyExpiration);
         this._askedApiKey = false;
         this._apiKey = null;
         this._apiKeyExpirationTimer.stop();
      }
      
      public function getAccountSessionId() : String
      {
         return this._accountSessionId;
      }
      
      public function getGameSessionId() : Number
      {
         return this._gameSessionId;
      }
      
      public function pullToken(gameId:int) : String
      {
         if(!this._tokens[gameId])
         {
            _log.error("No token available for gameID " + GameID.getName(gameId));
            return null;
         }
         var value:String = this._tokens[gameId];
         delete this._tokens[gameId];
         return value;
      }
      
      public function askToken(gameId:int) : void
      {
         if(this._askedTokens.indexOf(gameId) != -1)
         {
            return;
         }
         this._askedTokens.push(gameId);
         this.callWithApiKey(function(apiKey:String):void
         {
            nextToken();
         });
      }
      
      private function nextToken() : void
      {
         if(this._askedToken || this._askedTokens.length == 0)
         {
            return;
         }
         this._askedToken = true;
         if(!this._apiCredentials.apiPath)
         {
            this._apiCredentials.apiPath = XmlConfig.getInstance().getEntry("config.haapiUrlAnkama");
         }
         this._accountApi = new AccountApi(this._apiCredentials);
         this._accountApi.create_token(this._askedTokens[0]).onSuccess(this.onAccountApiCallResult).onError(this.onAccountApiCallError).call();
      }
      
      public function callWithApiKey(callback:Function) : void
      {
         _log.debug("CALL WITH API KEY");
         if(this._apiKey != null)
         {
            _log.debug("CALL WITH API KEY :: API KEY IS NOT NULL");
            callback(this._apiKey);
         }
         else
         {
            _log.debug("CALL WITH API KEY :: API KEY IS NULL");
            if(this._apiKeyCallbacks == null)
            {
               this._apiKeyCallbacks = new Vector.<Function>();
            }
            this._apiKeyCallbacks.push(callback);
            if(!GameServerApproachFrame.authenticationTicketAccepted)
            {
               this._retryTimer.reset();
               this._retryTimer.start();
            }
            else if(!this._askedApiKey && GameServerApproachFrame.authenticationTicketAccepted)
            {
               _log.debug("CALL WITH API KEY :: ASK FOR API KEY");
               ConnectionsHandler.getConnection().send(new HaapiApiKeyRequestMessage());
               this._askedApiKey = true;
            }
         }
      }
      
      public function onTimerEnd(pEvent:TimerEvent) : void
      {
         if(!GameServerApproachFrame.authenticationTicketAccepted)
         {
            _log.debug("TIMER RESET, NOT AUTHENTICATED");
            this._retryTimer.reset();
            this._retryTimer.start();
         }
         else if(!this._askedApiKey && GameServerApproachFrame.authenticationTicketAccepted)
         {
            this._retryTimer.reset();
            this._retryTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
            _log.debug("ON TIMER END :: ASK FOR API KEY");
            ConnectionsHandler.getConnection().send(new HaapiApiKeyRequestMessage());
            this._askedApiKey = true;
         }
      }
      
      public function saveApiKey(pHaapiKey:String) : void
      {
         var callbcak:Function = null;
         _log.debug("SAVE API KEY");
         this._apiKey = pHaapiKey;
         this._askedApiKey = false;
         this._apiCredentials.apiToken = pHaapiKey;
         this._accountApi = new AccountApi(this._apiCredentials);
         this._apiKeyExpirationTimer.reset();
         this._apiKeyExpirationTimer.start();
         if(this._apiKeyCallbacks)
         {
            for each(callbcak in this._apiKeyCallbacks)
            {
               callbcak(pHaapiKey);
            }
            this._apiKeyCallbacks = null;
         }
      }
      
      public function saveGameSessionId(key:String) : void
      {
         this._gameSessionId = parseInt(key);
         dispatchEvent(new GameSessionReadyEvent(this._gameSessionId));
      }
      
      public function saveAccountSessionId(key:String) : void
      {
         this._accountSessionId = key;
         dispatchEvent(new AccountSessionReadyEvent(this._accountSessionId));
      }
      
      public function destroy() : void
      {
         _instance = null;
      }
   }
}
