package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.PoolableURLLoader;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class HaapiDebugManager
   {
      
      public static const HARDWARE_DATA_TYPE:String = "hardware";
      
      public static const UI_DATA_TYPE:String = "ui";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HaapiDebugManager));
      
      private static var _singleton:HaapiDebugManager;
      
      private static var _apiUrl:String;
       
      
      private var _loaders:Dictionary;
      
      private var _currentApiDomainExtension:String;
      
      public function HaapiDebugManager()
      {
         super();
         _apiUrl = "https://haapi.ankama." + this.apiDomainExtension + "/json/Debug/v1/Log/Log";
         this._loaders = new Dictionary();
      }
      
      public static function getInstance() : HaapiDebugManager
      {
         if(!_singleton)
         {
            _singleton = new HaapiDebugManager();
         }
         return _singleton;
      }
      
      public function get apiDomainExtension() : String
      {
         if(!this._currentApiDomainExtension)
         {
            switch(BuildInfos.BUILD_TYPE)
            {
               case BuildTypeEnum.BETA:
               case BuildTypeEnum.RELEASE:
                  this._currentApiDomainExtension = "com";
                  break;
               case BuildTypeEnum.TESTING:
                  this._currentApiDomainExtension = "lan";
                  break;
               default:
                  this._currentApiDomainExtension = "tst";
            }
         }
         return this._currentApiDomainExtension;
      }
      
      public function submitData(type:String, data:String, callbackSuccess:Function = null, callbackError:Function = null) : void
      {
         var completeFct:Function = null;
         var errorFct:Function = null;
         if(!type || !data)
         {
            _log.error("Can\'t send empty data or undefined type!");
            return;
         }
         var urlVars:URLVariables = new URLVariables();
         urlVars.game_id = GameID.current;
         urlVars.message = data;
         urlVars.type = type;
         var request:URLRequest = new URLRequest(_apiUrl);
         request.data = urlVars;
         request.method = URLRequestMethod.POST;
         var loader:PoolableURLLoader = PoolsManager.getInstance().getURLLoaderPool().checkOut() as PoolableURLLoader;
         completeFct = function(e:Event):void
         {
            onApiSuccess(e,callbackSuccess,completeFct,errorFct);
         };
         errorFct = function(e:ErrorEvent):void
         {
            onApiError(e,callbackError,completeFct,errorFct);
         };
         loader.addEventListener(Event.COMPLETE,completeFct);
         loader.addEventListener(IOErrorEvent.IO_ERROR,errorFct);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,errorFct);
         loader.load(request);
      }
      
      private function onApiSuccess(event:Event, callbackSuccess:Function, completeListenerFct:Function, errorListenerFct:Function) : void
      {
         var loader:PoolableURLLoader = event.target as PoolableURLLoader;
         loader.removeEventListener(Event.COMPLETE,completeListenerFct);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,errorListenerFct);
         loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,errorListenerFct);
         PoolsManager.getInstance().getURLLoaderPool().checkIn(loader);
         _log.debug("Data successfully submitted");
         if(callbackSuccess != null)
         {
            callbackSuccess();
         }
      }
      
      private function onApiError(event:ErrorEvent, callbackError:Function, completeListenerFct:Function, errorListenerFct:Function) : void
      {
         var loader:PoolableURLLoader = event.target as PoolableURLLoader;
         loader.removeEventListener(Event.COMPLETE,completeListenerFct);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,errorListenerFct);
         loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,errorListenerFct);
         PoolsManager.getInstance().getURLLoaderPool().checkIn(loader);
         _log.debug("Failed to submit data, error:\n" + event.text);
         if(callbackError != null)
         {
            callbackError();
         }
      }
   }
}
