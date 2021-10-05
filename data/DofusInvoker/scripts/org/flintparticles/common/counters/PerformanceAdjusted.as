package org.flintparticles.common.counters
{
   import flash.utils.getTimer;
   import org.flintparticles.common.emitters.Emitter;
   
   public class PerformanceAdjusted implements Counter
   {
       
      
      private var _timeToNext:Number;
      
      private var _rateMin:Number;
      
      private var _rateMax:Number;
      
      private var _target:Number;
      
      private var _rate:Number;
      
      private var _times:Array;
      
      private var _timeToRateCheck:Number;
      
      private var _stop:Boolean;
      
      public function PerformanceAdjusted(rateMin:Number, rateMax:Number, targetFrameRate:Number)
      {
         super();
         this._stop = false;
         this._rateMin = rateMin;
         this._rate = this._rateMax = rateMax;
         this._target = targetFrameRate;
         this._times = new Array();
         this._timeToRateCheck = 0;
      }
      
      public function get rateMin() : Number
      {
         return this._rateMin;
      }
      
      public function set rateMin(value:Number) : void
      {
         this._rateMin = value;
         this._timeToRateCheck = 0;
      }
      
      public function get rateMax() : Number
      {
         return this._rateMax;
      }
      
      public function set rateMax(value:Number) : void
      {
         this._rate = this._rateMax = value;
         this._timeToRateCheck = 0;
      }
      
      public function get targetFrameRate() : Number
      {
         return this._target;
      }
      
      public function set targetFrameRate(value:Number) : void
      {
         this._target = value;
      }
      
      public function stop() : void
      {
         this._stop = true;
      }
      
      public function resume() : void
      {
         this._stop = false;
      }
      
      public function startEmitter(emitter:Emitter) : uint
      {
         this.newTimeToNext();
         return 0;
      }
      
      private function newTimeToNext() : void
      {
         this._timeToNext = 1 / this._rate;
      }
      
      public function updateEmitter(emitter:Emitter, time:Number) : uint
      {
         var t:Number = NaN;
         var frameRate:Number = NaN;
         if(this._stop)
         {
            return 0;
         }
         if(this._rate > this._rateMin && (this._timeToRateCheck = this._timeToRateCheck - time) <= 0)
         {
            if(this._times.push(t = getTimer()) > 9)
            {
               frameRate = Math.round(10000 / (t - Number(this._times.shift())));
               if(frameRate < this._target)
               {
                  this._rate = Math.floor((this._rate + this._rateMin) * 0.5);
                  this._times.length = 0;
                  if(!(this._timeToRateCheck = emitter.particles[0].lifetime))
                  {
                     this._timeToRateCheck = 2;
                  }
               }
            }
         }
         var emitTime:Number = time;
         var count:uint = 0;
         emitTime -= this._timeToNext;
         while(emitTime >= 0)
         {
            count++;
            this.newTimeToNext();
            emitTime -= this._timeToNext;
         }
         this._timeToNext = -emitTime;
         return count;
      }
   }
}
