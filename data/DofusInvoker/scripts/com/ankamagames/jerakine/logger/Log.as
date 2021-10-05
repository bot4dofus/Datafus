package com.ankamagames.jerakine.logger
{
   import com.ankamagames.jerakine.logger.targets.AbstractTarget;
   import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
   import com.ankamagames.jerakine.logger.targets.LoggingTarget;
   import com.ankamagames.jerakine.logger.targets.SentryTarget;
   import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public final class Log
   {
      
      private static var _tempTarget:TemporaryBufferTarget;
      
      private static var _initializing:Boolean;
      
      private static var _manualInit:Boolean;
      
      private static var _targets:Array = new Array();
      
      private static var _sentryTarget:LoggingTarget;
      
      private static var _loggers:Dictionary = new Dictionary();
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _configfile:String = "";
      
      public static var PREFIX:String = "";
      
      protected static var _log:Logger;
      
      public static var exitIfNoConfigFile:Boolean = true;
       
      
      public function Log()
      {
         super();
      }
      
      public static function get CONFIG_FILE() : String
      {
         return _configfile;
      }
      
      public static function initFromString(xml:String) : void
      {
         _manualInit = true;
         _initializing = true;
         parseConfiguration(new XML(xml));
         LogLogger.activeLog(true);
      }
      
      public static function getLogger(category:String, configFile:String = "log4as.xml") : Logger
      {
         var xmlLoader:URLLoader = null;
         var logger:LogLogger = null;
         if(!_initializing)
         {
            _initializing = true;
            _configfile = configFile;
            _tempTarget = new TemporaryBufferTarget();
            addTarget(_tempTarget);
            xmlLoader = new URLLoader();
            xmlLoader.addEventListener(Event.COMPLETE,completeHandler);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            xmlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
            try
            {
               xmlLoader.load(new URLRequest(_configfile));
               _log = Log.getLogger(getQualifiedClassName(Log));
            }
            catch(e:Error)
            {
            }
         }
         if(_loggers[category] != null)
         {
            return _loggers[category];
         }
         logger = new LogLogger(category);
         _loggers[category] = logger;
         return logger;
      }
      
      public static function addTarget(target:LoggingTarget) : void
      {
         if(containsTarget(target))
         {
            return;
         }
         _dispatcher.addEventListener(LogEvent.LOG_EVENT,target.onLog);
         _targets.push(target);
         if(target is SentryTarget)
         {
            _sentryTarget = target;
         }
      }
      
      public static function deactivateLevel(level:uint, deactive:Boolean) : void
      {
         var logger:LogLogger = null;
         for each(logger in _loggers)
         {
            logger.setLevelDectivation(level,deactive);
         }
      }
      
      public static function removeTargetType(qualifiedClassName:String) : void
      {
         var target:LoggingTarget = null;
         var i:int = 0;
         var targetToDelete:Array = new Array();
         for each(target in _targets)
         {
            if(getQualifiedClassName(target) == qualifiedClassName)
            {
               targetToDelete.push(target);
            }
         }
         if(targetToDelete.length > 0)
         {
            for(i = 0; i < targetToDelete.length; i++)
            {
               removeTarget(targetToDelete[i]);
            }
         }
      }
      
      public static function removeTarget(target:LoggingTarget) : void
      {
         var index:int = _targets.indexOf(target);
         if(index > -1)
         {
            _dispatcher.removeEventListener(LogEvent.LOG_EVENT,target.onLog);
            _targets.splice(index,1);
         }
      }
      
      private static function containsTarget(target:LoggingTarget) : Boolean
      {
         return _targets.indexOf(target) > -1;
      }
      
      private static function parseConfiguration(config:XML) : void
      {
         var filter:XML = null;
         var target:XML = null;
         var allow:Boolean = false;
         var ltf:LogTargetFilter = null;
         var x:XMLList = null;
         var moduleClass:Object = null;
         var targetInstance:LoggingTarget = null;
         var filters:Array = new Array();
         for(var _loc3_:int = 0,var _loc4_:* = config..filter; §§hasnext(_loc4_,_loc3_); ltf = new LogTargetFilter(filter.@value,allow),filters.push(ltf))
         {
            filter = §§nextvalue(_loc3_,_loc4_);
            allow = true;
            try
            {
               x = filter.attribute("allow");
               if(x.length() > 0)
               {
                  allow = filter.@allow == "true";
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
         for each(target in config..target)
         {
            try
            {
               moduleClass = getDefinitionByName(target.@module);
               targetInstance = new (moduleClass as Class)();
               targetInstance.filters = filters;
               if(target.hasComplexContent() && targetInstance is ConfigurableLoggingTarget)
               {
                  ConfigurableLoggingTarget(targetInstance).configure(target);
               }
               addTarget(targetInstance);
            }
            catch(ife:InvalidFilterError)
            {
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log",ife.getStackTrace(),LogLevel.WARN));
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log","Filtre invalide.",LogLevel.WARN));
            }
            catch(re:ReferenceError)
            {
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log",re.getStackTrace(),LogLevel.WARN));
               _tempTarget.getBuffer().unshift(new LogEvent("com.ankamagames.jerakine.logger.Log","Module " + target.@module + " introuvable.",LogLevel.WARN));
            }
         }
      }
      
      private static function configurationFileMissing(txt:String) : void
      {
         _log.warn(txt);
         if(exitIfNoConfigFile)
         {
            LogLogger.activeLog(false);
         }
         flushBuffer();
      }
      
      private static function flushBuffer() : void
      {
         var target:AbstractTarget = null;
         var bufferedEvent:LogEvent = null;
         var bufferedEvents:Array = _tempTarget.getBuffer();
         removeTarget(_tempTarget);
         for each(target in _targets)
         {
            if(target is TemporaryBufferTarget)
            {
               TemporaryBufferTarget(target).clearBuffer();
               break;
            }
         }
         for each(bufferedEvent in bufferedEvents)
         {
            _dispatcher.dispatchEvent(bufferedEvent);
         }
         _tempTarget.clearBuffer();
         _tempTarget = null;
      }
      
      static function broadcastToTargets(event:LogEvent) : void
      {
         _dispatcher.dispatchEvent(event);
      }
      
      static function broadcastToSentryTarget(event:LogEvent) : void
      {
         if(_sentryTarget != null)
         {
            _sentryTarget.onLog(event);
         }
      }
      
      private static function completeHandler(e:Event) : void
      {
         removeEventListeners(e);
         try
         {
            parseConfiguration(new XML(URLLoader(e.target).data));
         }
         catch(e:Error)
         {
         }
         flushBuffer();
      }
      
      private static function ioErrorHandler(ioe:IOErrorEvent) : void
      {
         removeEventListeners(ioe);
         if(_manualInit)
         {
            return;
         }
         configurationFileMissing("Missing " + _configfile + " file.");
      }
      
      private static function securityErrorHandler(se:SecurityErrorEvent) : void
      {
         removeEventListeners(se);
         if(_manualInit)
         {
            return;
         }
         configurationFileMissing("Can\'t load " + _configfile + " file : forbidden by sandbox.");
      }
      
      private static function removeEventListeners(e:Event) : void
      {
         (e.target as URLLoader).removeEventListener(Event.COMPLETE,completeHandler);
         (e.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
         (e.target as URLLoader).removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
      }
   }
}
