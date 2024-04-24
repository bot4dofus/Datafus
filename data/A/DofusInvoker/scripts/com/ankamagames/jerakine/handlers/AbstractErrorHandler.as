package com.ankamagames.jerakine.handlers
{
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import com.ankamagames.jerakine.logger.targets.LimitedBufferTarget;
   import com.ankamagames.jerakine.logger.targets.SentryTarget;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
   import com.ankamagames.jerakine.utils.misc.DeviceUtils;
   import damageCalculation.tools.LinkedList;
   import flash.desktop.NativeApplication;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getQualifiedClassName;
   import scopart.raven.RavenClient;
   
   public class AbstractErrorHandler
   {
      
      private static const LOCAL_SENTRY_CONFIG_URL:String = "http://utils.dofus.lan/sentry/";
      
      private static const RELEASE_SENTRY_CONFIG_URL:String = "https://dofus2.cdn.ankama.com/content/sentry/";
      
      private static const LOCAL_CYTRUS_URL:String = "https://cytrus-staging.cdn.ankama.com/cytrus.json";
      
      private static const RELEASE_CYTRUS_URL:String = "https://cytrus.cdn.ankama.com/cytrus.json";
      
      protected static const SENTRY_DISABLED:uint = 0;
      
      protected static const SENTRY_ENABLED:uint = 1;
      
      protected static const SENTRY_ENABLED_WITH_FATAL_LOGS:uint = 2;
      
      protected static const SENTRY_ENABLED_WITH_FATAL_AND_ERROR_LOGS:uint = 3;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractErrorHandler));
      
      protected static var _logBuffer:LimitedBufferTarget;
      
      protected static var _sentryLevel:uint = SENTRY_ENABLED;
      
      private static var _sentryClient:RavenClient;
       
      
      private var _loggerName:String;
      
      private var _messagePrefix:String;
      
      private var _capabilities:Object;
      
      private var _nativeApplication:Object;
      
      private var _isLocal:Boolean;
      
      private var _environment:String;
      
      private var _cytrusVersionLoaded:Boolean = false;
      
      private var _sentryConfigLoaded:Boolean = false;
      
      public function AbstractErrorHandler(loggerName:String, messagePrefix:String, autoInit:Boolean)
      {
         super();
         this._loggerName = loggerName;
         this._messagePrefix = messagePrefix;
         if(autoInit)
         {
            this.init();
         }
      }
      
      protected static function removeDebugFile() : void
      {
         var debugFile:File = null;
         try
         {
            debugFile = getDebugFile();
            if(debugFile.exists)
            {
               debugFile.deleteFile();
            }
         }
         catch(e:Error)
         {
            _log.error("Impossible de supprimer le fichier de debug : " + e.message);
         }
      }
      
      protected static function createDebugFile() : void
      {
         var debugFile:File = null;
         var fs:FileStream = null;
         try
         {
            debugFile = getDebugFile();
            if(!debugFile.exists)
            {
               fs = new FileStream();
               fs.open(debugFile,FileMode.WRITE);
               fs.writeUTF("");
               fs.close();
            }
         }
         catch(e:Error)
         {
            _log.error("Impossible de créer le fichier debug \nErreur:\n" + e.message);
         }
      }
      
      private static function getDebugFile() : File
      {
         return new File(File.applicationDirectory.resolvePath("META-INF/AIR/debug").nativePath);
      }
      
      private static function onSentryError(message:String, event:IOErrorEvent) : void
      {
         var urlLoader:URLLoader = URLLoader(event.target);
         var preventLogError:Boolean = false;
         if(urlLoader && urlLoader.dataFormat == "text" && urlLoader.data && urlLoader.data.indexOf("rate_limit") != -1)
         {
            preventLogError = true;
         }
         else if(message)
         {
            if(message.indexOf("429") != -1)
            {
               preventLogError = true;
            }
         }
         if(preventLogError)
         {
            _log.warn(message);
         }
         else
         {
            _log.error(message);
         }
      }
      
      private static function getCapabilities() : Object
      {
         var capabilities:Object = {};
         capabilities.avHardwareDisable = Capabilities.avHardwareDisable;
         capabilities.cpuArchitecture = Capabilities.cpuArchitecture;
         capabilities.hasAudio = Capabilities.hasAudio;
         capabilities.hasAudioEncoder = Capabilities.hasAudioEncoder;
         capabilities.hasEmbeddedVideo = Capabilities.hasEmbeddedVideo;
         capabilities.hasIME = Capabilities.hasIME;
         capabilities.hasMP3 = Capabilities.hasMP3;
         capabilities.hasPrinting = Capabilities.hasPrinting;
         capabilities.hasScreenBroadcast = Capabilities.hasScreenBroadcast;
         capabilities.hasScreenPlayback = Capabilities.hasScreenPlayback;
         capabilities.hasStreamingAudio = Capabilities.hasStreamingAudio;
         capabilities.hasStreamingVideo = Capabilities.hasStreamingVideo;
         capabilities.hasTLS = Capabilities.hasTLS;
         capabilities.hasVideoEncoder = Capabilities.hasVideoEncoder;
         capabilities.isDebugger = Capabilities.isDebugger;
         capabilities.language = Capabilities.language;
         capabilities.languages = Capabilities.languages;
         capabilities.localFileReadDisable = Capabilities.localFileReadDisable;
         capabilities.manufacturer = Capabilities.manufacturer;
         capabilities.maxLevelIDC = Capabilities.maxLevelIDC;
         capabilities.pixelAspectRatio = Capabilities.pixelAspectRatio;
         capabilities.playerType = Capabilities.playerType;
         capabilities.screenColor = Capabilities.screenColor;
         capabilities.screenDPI = Capabilities.screenDPI;
         capabilities.screenResolutionX = Capabilities.screenResolutionX;
         capabilities.screenResolutionY = Capabilities.screenResolutionY;
         capabilities.supports32BitProcesses = Capabilities.supports32BitProcesses;
         capabilities.supports64BitProcesses = Capabilities.supports64BitProcesses;
         capabilities.touchscreenType = Capabilities.touchscreenType;
         return capabilities;
      }
      
      private static function getNativeApplication() : Object
      {
         var nativeApplication:Object = {};
         nativeApplication.applicationID = NativeApplication.nativeApplication.applicationID;
         nativeApplication.runtimePatchLevel = NativeApplication.nativeApplication.runtimePatchLevel;
         nativeApplication.timeSinceLastUserInput = NativeApplication.nativeApplication.timeSinceLastUserInput;
         nativeApplication.supportsDefaultApplication = NativeApplication.supportsDefaultApplication;
         nativeApplication.supportsDockIcon = NativeApplication.supportsDockIcon;
         nativeApplication.supportsMenu = NativeApplication.supportsMenu;
         nativeApplication.supportsStartAtLogin = NativeApplication.supportsStartAtLogin;
         nativeApplication.supportsSystemTrayIcon = NativeApplication.supportsSystemTrayIcon;
         return nativeApplication;
      }
      
      private static function getSystemUser() : String
      {
         return File.documentsDirectory.nativePath.split(File.separator)[2];
      }
      
      protected function init() : void
      {
         _logBuffer = new LimitedBufferTarget(1000);
         Log.addTarget(_logBuffer);
         this._capabilities = getCapabilities();
         this._nativeApplication = getNativeApplication();
      }
      
      protected function createEmptyLog4As() : void
      {
      }
      
      protected function initSentry(version:Version, environment:String, isLocal:Boolean) : void
      {
         this._isLocal = isLocal;
         this._environment = environment.toLowerCase();
         var sentryVersion:String = version.toString().split("-")[0];
         _sentryClient = new RavenClient("https://c2af8495f5f2cb171a004cb6d6db569f@o89945.ingest.us.sentry.io/271879",sentryVersion,environment,onSentryError);
         ErrorManager.eventDispatcher.addEventListener(ErrorReportedEvent.ERROR,this.onError);
         var sentryConfigUrl:URLRequest = new URLRequest((!!isLocal ? LOCAL_SENTRY_CONFIG_URL : RELEASE_SENTRY_CONFIG_URL) + this._environment + ".json");
         var sentryConfigLoader:URLLoader = new URLLoader();
         this.addListeners(sentryConfigLoader,this.onSentryConfigLoaded,this.onSentryConfigError);
         sentryConfigLoader.load(sentryConfigUrl);
         var cytrusVersionUrl:URLRequest = new URLRequest(!!isLocal ? LOCAL_CYTRUS_URL : RELEASE_CYTRUS_URL);
         var cytrusVersionLoader:URLLoader = new URLLoader();
         this.addListeners(cytrusVersionLoader,this.onCytrusVersionLoaded,this.onCytrusVersionError);
         cytrusVersionLoader.load(cytrusVersionUrl);
      }
      
      protected function removeSentry() : void
      {
         _sentryClient = null;
      }
      
      private function onCytrusVersionLoaded(event:Event) : void
      {
         var result:* = undefined;
         var lastVersion:String = null;
         var cytrusVersionLoader:URLLoader = URLLoader(event.target);
         this.removeListeners(cytrusVersionLoader,this.onCytrusVersionLoaded,this.onCytrusVersionError);
         try
         {
            result = by.blooddy.crypto.serialization.JSON.decode(cytrusVersionLoader.data);
            lastVersion = result.games.dofus.platforms.windows[this.getCytrusBranch()];
            lastVersion = lastVersion.split("_")[1];
            _log.info("Last version : " + lastVersion);
            if(_sentryClient && _sentryClient.getConfig().release != lastVersion)
            {
               _log.info("Current version " + _sentryClient.getConfig().release + " is not the last version, disabling Sentry.");
               _sentryLevel = SENTRY_DISABLED;
               this._sentryConfigLoaded = true;
            }
         }
         catch(e:Error)
         {
            _log.warn("Error during Cytrus version loading : " + e.toString());
         }
         this._cytrusVersionLoaded = true;
         this.postInit();
      }
      
      private function onSentryConfigLoaded(event:Event) : void
      {
         var result:* = undefined;
         var sentryConfigLoader:URLLoader = URLLoader(event.target);
         this.removeListeners(sentryConfigLoader,this.onSentryConfigLoaded,this.onSentryConfigError);
         _log.info("Loaded Sentry configuration : " + sentryConfigLoader.data);
         try
         {
            result = by.blooddy.crypto.serialization.JSON.decode(sentryConfigLoader.data);
            if(!this._sentryConfigLoaded)
            {
               _sentryLevel = uint(result[this._loggerName.toLowerCase()]);
            }
         }
         catch(e:Error)
         {
            _log.warn("Error during Sentry configuration loading : " + e.toString());
         }
         this._sentryConfigLoaded = true;
         this.postInit();
      }
      
      private function onSentryConfigError(event:ErrorEvent) : void
      {
         _log.error("Cannot load Sentry configuration : " + event.toString());
         this.removeListeners(URLLoader(event.target),this.onSentryConfigLoaded,this.onSentryConfigError);
         this._sentryConfigLoaded = true;
         this.postInit();
      }
      
      private function onCytrusVersionError(event:ErrorEvent) : void
      {
         _log.error("Cannot load Cytrus version : " + event.toString());
         this.removeListeners(URLLoader(event.target),this.onCytrusVersionLoaded,this.onCytrusVersionError);
         this._cytrusVersionLoaded = true;
         this.postInit();
      }
      
      private function postInit() : void
      {
         if(!this._cytrusVersionLoaded || !this._sentryConfigLoaded)
         {
            return;
         }
         this.updateDebugFile();
         if(_sentryLevel > SENTRY_ENABLED)
         {
            Log.addTarget(new SentryTarget(_sentryLevel == SENTRY_ENABLED_WITH_FATAL_AND_ERROR_LOGS,this.sendLogToSentry));
         }
         if(_sentryLevel == SENTRY_DISABLED)
         {
            _log.info("Sentry disabled.");
         }
         else if(_sentryLevel == SENTRY_ENABLED)
         {
            _log.info("Sentry enabled in normal mode.");
         }
         else if(_sentryLevel == SENTRY_ENABLED_WITH_FATAL_LOGS)
         {
            _log.info("Sentry enabled with fatal logs.");
         }
         else if(_sentryLevel == SENTRY_ENABLED_WITH_FATAL_AND_ERROR_LOGS)
         {
            _log.info("Sentry enabled with fatal and error logs.");
         }
      }
      
      private function addListeners(urlLoader:URLLoader, completeHandler:Function, errorHandler:Function) : void
      {
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,errorHandler);
         urlLoader.addEventListener(Event.COMPLETE,completeHandler);
      }
      
      private function removeListeners(urlLoader:URLLoader, completeHandler:Function, errorHandler:Function) : void
      {
         urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,errorHandler);
         urlLoader.removeEventListener(Event.COMPLETE,completeHandler);
      }
      
      private function getCytrusBranch() : String
      {
         switch(this._environment)
         {
            case "local":
            case "release":
               return "main";
            case "testing":
            case "beta":
               return this._environment;
            default:
               return null;
         }
      }
      
      protected function updateDebugFile() : void
      {
         if(_sentryLevel == SENTRY_DISABLED)
         {
            removeDebugFile();
         }
         else
         {
            createDebugFile();
         }
      }
      
      private function sendLogToSentry(log:LogEvent, error:Error) : void
      {
         if(!_sentryClient)
         {
            return;
         }
         _sentryClient.setUserInfos(this.getUserInfo());
         _sentryClient.setTags(this.getTags());
         _sentryClient.setExtras(this.getExtras());
         _sentryClient.captureException(error,this._messagePrefix + log.message,log.category,log.level == LogLevel.ERROR ? int(RavenClient.ERROR) : int(RavenClient.FATAL));
      }
      
      protected function onError(e:ErrorReportedEvent) : void
      {
         var tags:Object = null;
         var dynamicVar:* = null;
         var error:Error = e.error;
         if(_sentryClient && error && error.getStackTrace() && _sentryLevel > SENTRY_DISABLED)
         {
            tags = this.getTags();
            if(e.tags)
            {
               for(dynamicVar in e.tags)
               {
                  tags[dynamicVar] = e.tags[dynamicVar];
               }
            }
            _sentryClient.setUserInfos(this.getUserInfo());
            _sentryClient.setTags(tags);
            _sentryClient.setExtras(this.getExtras());
            _sentryClient.captureException(error,this._messagePrefix + e.text,this._loggerName);
         }
      }
      
      protected function captureMessage(message:String, tags:Object = null, level:int = 40) : void
      {
         var allTags:Object = null;
         var dynamicVar:* = null;
         if(_sentryClient && message && _sentryLevel > SENTRY_DISABLED)
         {
            allTags = this.getTags();
            if(tags)
            {
               for(dynamicVar in tags)
               {
                  allTags[dynamicVar] = tags[dynamicVar];
               }
            }
            _sentryClient.setUserInfos(this.getUserInfo());
            _sentryClient.setTags(allTags);
            _sentryClient.setExtras(this.getExtras());
            _sentryClient.captureMessage(this._messagePrefix + message,this._loggerName,level);
         }
      }
      
      protected function getUserInfo() : Object
      {
         var o:Object = {};
         var systemUser:String = getSystemUser();
         if(systemUser)
         {
            o.username = systemUser;
         }
         if(this._isLocal)
         {
            o.email = o.username + "@ankama.com";
         }
         o.deviceId = DeviceUtils.deviceUniqueIdentifier;
         return o;
      }
      
      protected function getTags() : Object
      {
         var o:Object = {};
         o.flashVersion = Capabilities.version;
         o.airVersion = NativeApplication.nativeApplication.runtimeVersion;
         o.os = Capabilities.os;
         return o;
      }
      
      protected function getExtras() : Object
      {
         var log:LogEvent = null;
         var logTailString:String = null;
         var o:Object = {};
         o.appplicationPath = File.applicationDirectory.nativePath;
         o.memoryFlash = int(System.totalMemoryNumber / 1024) + " Mb";
         o.memoryTotal = int(System.privateMemory / 1024) + " Mb";
         var logs:LinkedList = _logBuffer.getBuffer().copy();
         var logTail:Vector.<LogEvent> = new Vector.<LogEvent>(0);
         for(var i:int = 0; i < 100; i++)
         {
            log = logs.tail.item as LogEvent;
            logs.remove(logs.tail);
            if(log is TextLogEvent && log.level > 0)
            {
               logTail.unshift(log);
            }
         }
         if(logTail.length > 0)
         {
            logTailString = "";
            for each(log in logTail)
            {
               logTailString += "[" + LogLevel.getString(log.level) + "][" + log.formattedTimestamp + "] " + log.message + "\n";
            }
            o.logTail = logTailString;
         }
         var systemUser:String = getSystemUser();
         if(systemUser)
         {
            o.systemUser = systemUser;
         }
         o.capabilities = this._capabilities;
         if(this._nativeApplication)
         {
            o.nativeApplication = this._nativeApplication;
         }
         return o;
      }
   }
}
