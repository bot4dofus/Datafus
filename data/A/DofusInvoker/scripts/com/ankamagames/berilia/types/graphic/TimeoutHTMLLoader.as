package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.Event;
   import flash.events.HTMLUncaughtScriptExceptionEvent;
   import flash.events.TimerEvent;
   import flash.html.HTMLLoader;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TimeoutHTMLLoader extends HTMLLoader
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TimeoutHTMLLoader));
      
      private static var INSTANCE_CACHE:Dictionary = new Dictionary();
      
      public static const TIMEOUT:String = "TimeoutHTMLLoader_timeout";
       
      
      private var _fromCache:Boolean;
      
      private var _timer:BenchmarkTimer;
      
      private var _uid:String;
      
      public function TimeoutHTMLLoader()
      {
         super();
         addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
      }
      
      public static function getLoader(uid:String = null) : TimeoutHTMLLoader
      {
         var instance:TimeoutHTMLLoader = null;
         if(uid != null && INSTANCE_CACHE[uid])
         {
            instance = INSTANCE_CACHE[uid];
            instance._fromCache = true;
            instance.restartTimer();
            return instance;
         }
         instance = new TimeoutHTMLLoader();
         instance._uid = uid;
         instance.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,onJsError,false,0,true);
         if(uid)
         {
            INSTANCE_CACHE[uid] = instance;
         }
         return instance;
      }
      
      public static function resetCache() : void
      {
         INSTANCE_CACHE = new Dictionary();
      }
      
      private static function onJsError(event:HTMLUncaughtScriptExceptionEvent) : void
      {
         var i:uint = 0;
         var msg:* = "Javascript exception \"" + event.exceptionValue.message + "\"";
         if(event.stackTrace)
         {
            for(i = 0; i < event.stackTrace.length; i++)
            {
               msg += "\n" + event.stackTrace[i].functionName + " at line " + event.stackTrace[i].line;
            }
         }
         _log.error(msg);
      }
      
      public function set life(value:Number) : void
      {
         this._timer = new BenchmarkTimer(value * 60 * 1000,0,"TimeoutHTMLLoader._timer");
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
      }
      
      public function get fromCache() : Boolean
      {
         return this._fromCache;
      }
      
      private function restartTimer() : void
      {
         if(this._timer)
         {
            this._timer.reset();
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timer.start();
         }
      }
      
      private function onLocationChange(e:Event) : void
      {
         this.restartTimer();
      }
      
      private function onTimeOut(e:Event) : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
         dispatchEvent(new Event(TIMEOUT));
         if(this._uid)
         {
            removeEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,onJsError);
            removeEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
            delete INSTANCE_CACHE[this._uid];
         }
      }
   }
}
