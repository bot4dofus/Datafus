package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class SynchroTimer
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchroTimer));
       
      
      private var _value:Number;
      
      private var _maxValue:Number;
      
      private var _time:Number;
      
      private var _callBack:Function;
      
      public function SynchroTimer(pMaxValue:Number)
      {
         super();
         this._maxValue = pMaxValue;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function start(pCallback:Function) : void
      {
         this._callBack = pCallback;
         this._value = TimeManager.getInstance().getTimestamp() % this._maxValue;
         this._time = this.getTimerValue();
         EnterFrameDispatcher.addEventListener(this.tick,EnterFrameConst.SYNCHRO_TIMER);
      }
      
      public function stop() : void
      {
         EnterFrameDispatcher.removeEventListener(this.tick);
         this._callBack = null;
         this._value = this._maxValue = 0;
      }
      
      private function getTimerValue() : int
      {
         return getTimer() % int.MAX_VALUE;
      }
      
      private function tick(pEvent:Event) : void
      {
         var time:int = this.getTimerValue();
         this._value += time - this._time;
         if(this._value > this._maxValue)
         {
            this._value = 0;
         }
         this._time = time;
         if(this._callBack != null)
         {
            this._callBack.apply(this,[this]);
         }
      }
   }
}
