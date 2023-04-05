package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   
   public class SentryTarget extends AbstractTarget
   {
       
      
      private var _logErrors:Boolean;
      
      private var _sentryCallback:Function;
      
      public function SentryTarget(logErrors:Boolean, sentryCallback:Function)
      {
         super();
         this._logErrors = logErrors;
         this._sentryCallback = sentryCallback;
      }
      
      override public function logEvent(event:LogEvent) : void
      {
         if(event is TextLogEvent && (event.level == LogLevel.FATAL || event.level == LogLevel.ERROR && this._logErrors))
         {
            this._sentryCallback(event,new Error());
         }
      }
   }
}
