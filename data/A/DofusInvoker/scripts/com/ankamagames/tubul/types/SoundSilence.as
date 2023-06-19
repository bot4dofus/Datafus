package com.ankamagames.tubul.types
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tubul.events.SoundSilenceEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   [Event(name="start",type="com.ankamagames.tubul.events.SoundSilenceEvent")]
   [Event(name="complete",type="com.ankamagames.tubul.events.SoundSilenceEvent")]
   public class SoundSilence extends EventDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundSilence));
       
      
      private var _silenceMin:Number;
      
      private var _silenceMax:Number;
      
      private var _timer:BenchmarkTimer;
      
      public function SoundSilence(pSilenceMin:Number, pSilenceMax:Number)
      {
         super();
         this.setSilence(pSilenceMin,pSilenceMax);
      }
      
      public function get silenceMin() : Number
      {
         return this._silenceMin;
      }
      
      public function get silenceMax() : Number
      {
         return this._silenceMax;
      }
      
      public function get running() : Boolean
      {
         if(this._timer && this._timer.running)
         {
            return true;
         }
         return false;
      }
      
      public function start() : void
      {
         if(this._timer && this._timer.running)
         {
            return;
         }
         var silenceRandom:uint = (Math.random() * (this._silenceMax - this._silenceMin) + this._silenceMin) * 1000 * 60;
         this._timer = new BenchmarkTimer(silenceRandom,1,"SoundSilence._timer");
         if(!this._timer.hasEventListener(TimerEvent.TIMER))
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
         }
         this._timer.start();
         var e:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.START);
         dispatchEvent(e);
      }
      
      public function stop() : void
      {
         if(!this.running)
         {
            return;
         }
         this._timer.stop();
      }
      
      public function clean() : void
      {
         this.stop();
         if(this._timer == null)
         {
            return;
         }
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerEnd);
         this._timer = null;
      }
      
      public function setSilence(pSilenceMin:Number, pSilenceMax:Number) : void
      {
         this._silenceMin = Math.min(pSilenceMin,pSilenceMax);
         this._silenceMax = Math.max(pSilenceMin,pSilenceMax);
      }
      
      private function onTimerEnd(pEvent:TimerEvent) : void
      {
         this.clean();
         var e:SoundSilenceEvent = new SoundSilenceEvent(SoundSilenceEvent.COMPLETE);
         dispatchEvent(e);
      }
   }
}
