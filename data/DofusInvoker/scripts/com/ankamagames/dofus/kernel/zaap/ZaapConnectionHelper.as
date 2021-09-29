package com.ankamagames.dofus.kernel.zaap
{
   import com.ankama.zaap.ErrorCode;
   import com.ankama.zaap.OverlayPosition;
   import com.ankama.zaap.ZaapClient;
   import com.ankama.zaap.ZaapError;
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapOutputMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ApiTokenMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.LanguageMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestApiTokenMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestLanguageMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapNeedUpdateMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapPayArticleMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapSettingMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapUserInfosMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapCloseOverlayMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapNeedUpdateMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapResetOgrinesMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapSettingMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapUserInfosMessage;
   import com.ankamagames.jerakine.json.JSON;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.errors.Result;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class ZaapConnectionHelper
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ZaapConnectionHelper));
       
      
      private var _handlers:Vector.<IZaapMessageHandler>;
      
      private var _buffer:Vector.<IZaapOutputMessage>;
      
      private var _zaap:ZaapClient;
      
      private var _zaapLogin:Boolean;
      
      private var _disconnected:Boolean;
      
      private var _waitingResponse:Boolean = false;
      
      public function ZaapConnectionHelper()
      {
         super();
         this._handlers = new Vector.<IZaapMessageHandler>();
         this._buffer = new Vector.<IZaapOutputMessage>();
      }
      
      public static function hasZaapArguments() : Boolean
      {
         return CommandLineArguments.getInstance().hasArgument("port") && CommandLineArguments.getInstance().hasArgument("gameName") && CommandLineArguments.getInstance().hasArgument("gameRelease") && CommandLineArguments.getInstance().hasArgument("instanceId") && CommandLineArguments.getInstance().hasArgument("hash") && CommandLineArguments.getInstance().hasArgument("canLogin");
      }
      
      public function addObserver(handler:IZaapMessageHandler) : void
      {
         this._handlers.push(handler);
      }
      
      public function removeObserver(handler:IZaapMessageHandler) : void
      {
         this._handlers.slice(this._handlers.indexOf(handler),1);
      }
      
      public function connect() : void
      {
         if(hasZaapArguments())
         {
            this._zaapLogin = CommandLineArguments.getInstance().getArgument("canLogin") == "true";
            if(this._zaap == null)
            {
               this._zaap = new ZaapClient();
            }
            if(this._zaap.connection == null)
            {
               this._zaap.connect(parseInt(CommandLineArguments.getInstance().getArgument("port")),CommandLineArguments.getInstance().getArgument("gameName"),CommandLineArguments.getInstance().getArgument("gameRelease"),parseInt(CommandLineArguments.getInstance().getArgument("instanceId")),CommandLineArguments.getInstance().getArgument("hash"),this.onError,this.onConnectionOpened,this.onConnectionClosed);
            }
         }
      }
      
      public function close() : void
      {
         if(this._zaap)
         {
            this._zaap.disconnect();
         }
      }
      
      public function isConnected() : Boolean
      {
         if(this._zaap && this._zaap.session != null)
         {
            return true;
         }
         return false;
      }
      
      public function isDisconnected() : Boolean
      {
         return this._disconnected;
      }
      
      public function isUsingZaap() : Boolean
      {
         return this._zaap != null && this._zaap.connection != null && this._zaap.connection.isOpen();
      }
      
      public function isUsingZaapLogin() : Boolean
      {
         return this._zaapLogin && this.isUsingZaap();
      }
      
      public function canLoginWithZaap() : Boolean
      {
         return this._zaapLogin;
      }
      
      public function disableZaapLogin() : void
      {
         this._zaapLogin = false;
      }
      
      public function sendMessage(msg:IZaapOutputMessage) : Boolean
      {
         var setting:String = null;
         var rzpam:RequestZaapPayArticleMessage = null;
         if(!this.isConnected() || this._waitingResponse)
         {
            this._buffer.push(msg);
            return false;
         }
         if(this._zaap)
         {
            if(msg is RequestApiTokenMessage)
            {
               _log.info("Asking Zaap an API token...");
               this._zaap.client.auth_getGameToken(this._zaap.session,RequestApiTokenMessage(msg).gameId,this.onAuthTokenError,this.onAuthTokenSuccess);
               this._waitingResponse = true;
            }
            else if(msg is RequestLanguageMessage)
            {
               _log.info("Asking Zaap language...");
               this._zaap.client.settings_get(this._zaap.session,"language",this.onLanguageGetError,this.onLanguageGetSuccess);
               this._waitingResponse = true;
            }
            else if(msg is RequestZaapSettingMessage)
            {
               setting = RequestZaapSettingMessage(msg).name;
               _log.info("Asking Zaap parameter " + setting + "...");
               this._zaap.client.settings_get(this._zaap.session,setting,function(e:Error):void
               {
                  onSettingGetError(setting,e);
               },function(value:String):void
               {
                  onSettingGetSuccess(setting,value);
               });
               this._waitingResponse = true;
            }
            else if(msg is RequestZaapUserInfosMessage)
            {
               _log.info("Asking Zaap user infos...");
               this._zaap.client.userInfo_get(this._zaap.session,this.onUserInfosGetError,this.onUserInfosGetSuccess);
               this._waitingResponse = true;
            }
            else if(msg is RequestZaapNeedUpdateMessage)
            {
               _log.info("Asking zaap version...");
               try
               {
                  if(this._zaap && this._zaap.client)
                  {
                     this._zaap.client.zaapMustUpdate_get(this._zaap.session,this.onZaapNeedUpdateError,this.onZaapNeedUpdateSuccess);
                     this._waitingResponse = true;
                  }
               }
               catch(error:Error)
               {
                  _log.info("Error trying to get zaap update need " + error.toString());
                  dispatchMessage(new ZaapNeedUpdateMessage(true));
               }
            }
            else if(msg is RequestZaapPayArticleMessage)
            {
               rzpam = msg as RequestZaapPayArticleMessage;
               _log.info("Asking zaap pay article... (" + rzpam.articleId + ")");
               this._zaap.client.payArticle(this._zaap.session,rzpam.apiKey,rzpam.articleId,this.getOverlayPosition(),this.onZaapPayArticleError,this.onZaapPayArticleSuccess);
            }
         }
         return true;
      }
      
      private function getOverlayPosition() : OverlayPosition
      {
         var pos:OverlayPosition = new OverlayPosition();
         pos.posX = 25;
         pos.posY = 25;
         pos.width = 50;
         pos.height = 50;
         return pos;
      }
      
      private function onZaapPayArticleError(e:Error) : void
      {
         _log.info("Error trying to pay article via zaap " + e.toString());
         this.dispatchMessage(new ZaapResetOgrinesMessage());
         this.dispatchMessage(new ZaapCloseOverlayMessage());
      }
      
      private function onZaapPayArticleSuccess(result:String) : void
      {
         _log.info("onZaapPayArticleSuccess, Result from launcher is " + result);
         this.dispatchMessage(new ZaapResetOgrinesMessage());
         this.dispatchMessage(new ZaapCloseOverlayMessage());
      }
      
      private function onZaapNeedUpdateError(e:Error) : void
      {
         _log.info("Error trying to get zaap update need " + e.toString());
         this.dispatchMessage(new ZaapNeedUpdateMessage(true));
      }
      
      private function onZaapNeedUpdateSuccess(result:String) : void
      {
         _log.info("onZaapNeedUpdateSuccess, Result from launcher is " + result);
         this.dispatchMessage(new ZaapNeedUpdateMessage(result == "true"));
      }
      
      public function requestZaapRestart(callback:Function) : void
      {
         this._zaap.client.release_restartOnExit(this._zaap.session,function(e:Error):void
         {
            onrequestZaapRestartError(e);
            callback();
         },callback);
      }
      
      private function onrequestZaapRestartError(e:Error) : void
      {
         if(e is ZaapError)
         {
            this.onError(new ErrorEvent(ErrorCode.VALUES_TO_NAMES[ZaapError(e).code],false,false,ZaapError(e).details,ZaapError(e).code));
         }
         else
         {
            this.onError(new ErrorEvent(e.name,false,false,e.message,e.errorID));
         }
      }
      
      private function onUserInfosGetError(e:Error) : void
      {
         if(e is ZaapError)
         {
            this.dispatchMessage(new ZaapUserInfosMessage(null,ZaapError(e).code));
         }
         else
         {
            this.onError(new ErrorEvent(e.name,false,false,e.message,e.errorID));
         }
      }
      
      private function onUserInfosGetSuccess(value:String) : void
      {
         var result:Result = ErrorManager.tryFunction(com.ankamagames.jerakine.json.JSON.decode,[value]);
         if(result.success)
         {
            this.dispatchMessage(new ZaapUserInfosMessage(result.result.login));
         }
         else
         {
            _log.warn("Error during Zaap JSON decoding for user infos : " + result.stackTrace);
            this.dispatchMessage(new ZaapUserInfosMessage(null,ErrorCode.UNKNOWN));
         }
      }
      
      private function onSettingGetError(name:String, e:Error) : void
      {
         if(e is ZaapError)
         {
            this.dispatchMessage(new ZaapSettingMessage(name,null,ZaapError(e).code));
         }
         else
         {
            this.onError(new ErrorEvent(e.name,false,false,e.message,e.errorID));
         }
      }
      
      private function onSettingGetSuccess(name:String, value:String) : void
      {
         var result:Result = ErrorManager.tryFunction(com.ankamagames.jerakine.json.JSON.decode,[value]);
         if(result.success)
         {
            value = result.result;
            _log.info("Zaap setting : " + name + " = " + value);
            this.dispatchMessage(new ZaapSettingMessage(name,value));
         }
         else
         {
            _log.warn("Error during Zaap JSON decoding for setting " + name + " : " + result.stackTrace);
            this.dispatchMessage(new ZaapSettingMessage(name,null,ErrorCode.UNKNOWN));
         }
      }
      
      private function onLanguageGetError(e:Error) : void
      {
         if(e is ZaapError)
         {
            this.dispatchMessage(new LanguageMessage(null,ZaapError(e).code));
         }
         else
         {
            this.onError(new ErrorEvent(e.name,false,false,e.message,e.errorID));
         }
      }
      
      private function onLanguageGetSuccess(value:String) : void
      {
         var result:Result = ErrorManager.tryFunction(com.ankamagames.jerakine.json.JSON.decode,[value]);
         if(result.success)
         {
            value = result.result;
            _log.info("Language: " + value);
            this.dispatchMessage(new LanguageMessage(value));
         }
         else
         {
            _log.warn("Error during language JSON decoding : " + result.stackTrace);
            this.dispatchMessage(new LanguageMessage(null,ErrorCode.UNKNOWN));
         }
      }
      
      private function onAuthTokenError(e:Error) : void
      {
         if(e is ZaapError)
         {
            this.dispatchMessage(new ApiTokenMessage(null,ZaapError(e).code));
         }
         else
         {
            this.onError(new ErrorEvent(e.name,false,false,e.message,e.errorID));
         }
      }
      
      private function onAuthTokenSuccess(token:String) : void
      {
         _log.info("Auth token: " + token);
         this.dispatchMessage(new ApiTokenMessage(token));
      }
      
      private function dispatchConnected() : void
      {
         for(var i:int = 0; i < this._handlers.length; i++)
         {
            this._handlers[i].handleConnectionOpened();
         }
      }
      
      private function dispatchRageQuit() : void
      {
         if(this._disconnected)
         {
            return;
         }
         this._disconnected = true;
         _log.info((!!hasZaapArguments() ? "Zaap" : "") + " connection has been closed.");
         for(var i:int = 0; i < this._handlers.length; i++)
         {
            this._handlers[i].handleConnectionClosed();
         }
      }
      
      private function dispatchMessage(msg:IZaapInputMessage) : void
      {
         this._waitingResponse = false;
         for(var i:int = 0; i < this._handlers.length; i++)
         {
            this._handlers[i].handleMessage(msg);
         }
         this.resumeMessages();
      }
      
      private function resumeMessages() : void
      {
         for(var i:int = 0; i < this._buffer.length; i++)
         {
            this.sendMessage(this._buffer.shift());
         }
      }
      
      private function onConnectionOpened(event:Event = null) : void
      {
         if(this._zaap && this._zaap.session != null)
         {
            _log.info("Connected to Zaap on port : " + CommandLineArguments.getInstance().getArgument("port") + " with session " + this._zaap.session);
         }
         this.dispatchConnected();
         this.resumeMessages();
      }
      
      private function onConnectionClosed(event:Event) : void
      {
         this.dispatchRageQuit();
      }
      
      private function onError(event:ErrorEvent) : void
      {
         _log.error("Error : [" + event.errorID + "] " + event.text);
         this.dispatchRageQuit();
      }
   }
}
