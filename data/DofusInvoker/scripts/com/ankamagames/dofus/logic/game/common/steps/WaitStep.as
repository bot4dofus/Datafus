package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.events.TimerEvent;
   
   public class WaitStep extends AbstractSequencable
   {
       
      
      private var _ms:int;
      
      private var _timer:BenchmarkTimer;
      
      public function WaitStep(pMilliseconds:int)
      {
         super();
         this._ms = pMilliseconds;
         timeout = this._ms + 1000;
      }
      
      override public function start() : void
      {
         this._timer = new BenchmarkTimer(this._ms,0,"WaitStep._timer");
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
      }
      
      override public function pause() : void
      {
         super.pause();
         this._timer.stop();
      }
      
      override public function resume() : void
      {
         super.resume();
         this._timer.start();
      }
      
      override public function clear() : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
      }
      
      private function onTimer(pEvent:TimerEvent) : void
      {
         pEvent.currentTarget.removeEventListener(TimerEvent.TIMER,this.onTimer);
         executeCallbacks();
      }
      
      override public function toString() : String
      {
         return "Wait " + this._ms + " ms";
      }
   }
}
