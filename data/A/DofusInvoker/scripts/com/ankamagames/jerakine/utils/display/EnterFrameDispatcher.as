package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Worker;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class EnterFrameDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EnterFrameDispatcher));
      
      private static var _maxAllowedTime:uint = 20;
      
      private static var _listenerUp:Boolean = false;
      
      private static var _workerListenerUp:Boolean = false;
      
      private static var _currentTime:uint;
      
      private static var _postWorkerTime:uint;
      
      private static var _diff:int = 0;
      
      private static var _noWorkerFrameCount:uint = 0;
      
      private static var _controledListeners:Dictionary = new Dictionary(true);
      
      private static var _worker:Worker;
       
      
      public function EnterFrameDispatcher()
      {
         super();
      }
      
      public static function addWorker(w:Worker) : void
      {
         _worker = w;
         if(!_listenerUp)
         {
            StageShareManager.rootContainer.addEventListener(Event.ENTER_FRAME,handleEnterFrameEvents);
            _listenerUp = true;
         }
         if(!_workerListenerUp)
         {
            StageShareManager.rootContainer.addEventListener(Event.ENTER_FRAME,handleWorkers);
            _workerListenerUp = true;
         }
      }
      
      public static function removeWorker() : void
      {
         if(_workerListenerUp)
         {
            StageShareManager.rootContainer.removeEventListener(Event.ENTER_FRAME,handleWorkers);
            _workerListenerUp = false;
         }
      }
      
      public static function get enterFrameListenerCount() : uint
      {
         var key:* = undefined;
         var count:int = 0;
         for(key in _controledListeners)
         {
            count++;
         }
         return count;
      }
      
      public static function get controledEnterFrameListeners() : Dictionary
      {
         return _controledListeners;
      }
      
      public static function get worker() : Worker
      {
         return _worker;
      }
      
      public static function addEventListener(listener:Function, name:String, frameRate:uint = 4.294967295E9) : void
      {
         if(!_controledListeners[listener])
         {
            _controledListeners[listener] = new ControledEnterFrameListener(name,listener,frameRate <= 0 || frameRate == uint.MAX_VALUE ? uint(0) : uint(1000 / frameRate),!!_listenerUp ? uint(_currentTime) : uint(getTimer()));
            if(!_listenerUp)
            {
               if(StageShareManager.rootContainer)
               {
                  StageShareManager.rootContainer.addEventListener(Event.ENTER_FRAME,handleEnterFrameEvents);
               }
               _listenerUp = true;
            }
         }
      }
      
      public static function hasEventListener(listener:Function) : Boolean
      {
         return _controledListeners[listener] != null;
      }
      
      public static function set maxAllowedTime(time:uint) : void
      {
         _maxAllowedTime = time;
      }
      
      public static function removeEventListener(listener:Function) : void
      {
         if(_controledListeners[listener])
         {
            delete _controledListeners[listener];
            if(_controledListeners.length == 0 && !_workerListenerUp && StageShareManager.rootContainer)
            {
               StageShareManager.rootContainer.removeEventListener(Event.ENTER_FRAME,handleEnterFrameEvents);
               _listenerUp = false;
            }
         }
      }
      
      private static function handleEnterFrameEvents(e:Event) : void
      {
         var cefl:ControledEnterFrameListener = null;
         var diff:uint = 0;
         _currentTime = getTimer();
         for each(cefl in _controledListeners)
         {
            diff = _currentTime - cefl.latestChange;
            if(diff > cefl.wantedGap - cefl.overhead)
            {
               cefl.listener(e);
               cefl.latestChange = _currentTime;
               cefl.overhead = diff - cefl.wantedGap + cefl.overhead;
            }
         }
      }
      
      public static function remainsTime() : Boolean
      {
         return getTimer() - _postWorkerTime < _maxAllowedTime;
      }
      
      private static function handleWorkers(e:Event) : void
      {
         _diff = getTimer() - _postWorkerTime;
         if(_diff < _maxAllowedTime)
         {
            _worker.processQueues(_maxAllowedTime - _diff);
            _noWorkerFrameCount = 0;
         }
         else
         {
            _worker.processQueues(_noWorkerFrameCount);
            if(_noWorkerFrameCount < _maxAllowedTime / 2)
            {
               ++_noWorkerFrameCount;
            }
         }
         _postWorkerTime = getTimer();
      }
   }
}

class ControledEnterFrameListener
{
    
   
   public var name:String;
   
   public var listener:Function;
   
   public var wantedGap:uint;
   
   public var overhead:uint;
   
   public var latestChange:uint;
   
   function ControledEnterFrameListener(name:String, listener:Function, wantedGap:uint, latestChange:uint)
   {
      super();
      this.name = name;
      this.listener = listener;
      this.wantedGap = wantedGap;
      this.latestChange = latestChange;
   }
}
