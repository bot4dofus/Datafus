package com.ankamagames.jerakine.sequencer
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.FightProfiler;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractSequencable extends EventDispatcher implements IPausableSequencable
   {
      
      public static var DEFAULT_TIMEOUT:uint = 5000;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractSequencable));
       
      
      private var _listeners:Dictionary;
      
      private var _timeOut:BenchmarkTimer;
      
      private var _castingSpellId:int = -1;
      
      protected var _timeoutMax:int;
      
      private var _withTimeOut:Boolean = false;
      
      private var _paused:Boolean;
      
      private var _finished:Boolean = false;
      
      public function AbstractSequencable()
      {
         this._listeners = new Dictionary();
         this._timeoutMax = DEFAULT_TIMEOUT;
         super();
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function get timeout() : int
      {
         return this._timeoutMax;
      }
      
      public function get finished() : Boolean
      {
         return this._finished;
      }
      
      public function set finished(bool:Boolean) : void
      {
         this._finished = bool;
      }
      
      public function set timeout(value:int) : void
      {
         this._timeoutMax = value;
         if(this._timeOut && value != -1)
         {
            this._timeOut.delay = value;
         }
      }
      
      public function get hasDefaultTimeout() : Boolean
      {
         return this._timeoutMax == DEFAULT_TIMEOUT;
      }
      
      public function pause() : void
      {
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._paused = true;
      }
      
      public function resume() : void
      {
         this._paused = false;
         if(this._timeOut)
         {
            this._timeOut.start();
         }
      }
      
      public function start() : void
      {
      }
      
      public function addListener(listener:ISequencableListener) : void
      {
         if(!this._timeOut && this._timeoutMax != -1)
         {
            this._timeOut = new BenchmarkTimer(this._timeoutMax,1,"AbstractSequencable._timeOut");
            this._timeOut.addEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.start();
         }
         if(!this._listeners)
         {
            this._listeners = new Dictionary();
         }
         this._listeners[listener] = listener;
      }
      
      protected function executeCallbacks() : void
      {
         var listener:ISequencableListener = null;
         FightProfiler.getInstance().stop();
         if(this._timeOut)
         {
            this._timeOut.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeOut.reset();
            this._timeOut = null;
         }
         this._finished = true;
         for each(listener in this._listeners)
         {
            if(listener)
            {
               listener.stepFinished(this,this._withTimeOut);
            }
         }
      }
      
      public function removeListener(listener:ISequencableListener) : void
      {
         if(!this._listeners)
         {
            return;
         }
         delete this._listeners[listener];
      }
      
      override public function toString() : String
      {
         return getQualifiedClassName(this);
      }
      
      public function clear() : void
      {
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._timeOut = null;
         this._listeners = null;
      }
      
      public function get castingSpellId() : int
      {
         return this._castingSpellId;
      }
      
      public function set castingSpellId(val:int) : void
      {
         this._castingSpellId = val;
      }
      
      public function get isTimeout() : Boolean
      {
         return this._withTimeOut;
      }
      
      protected function onTimeOut(e:TimerEvent) : void
      {
         _log.error("Time out sur la step " + this + " (" + this._timeOut.delay + ")");
         this._withTimeOut = true;
         if(this._timeOut)
         {
            this._timeOut.stop();
         }
         this._timeOut = null;
         this.executeCallbacks();
         this._listeners = null;
      }
   }
}
