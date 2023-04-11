package com.ankamagames.performance.tests
{
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.performance.Benchmark;
   import com.ankamagames.performance.DisplayObjectDummy;
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.utils.getTimer;
   
   public class TestDisplayPerformance implements IBenchmarkTest
   {
      
      private static const TOTAL_OBJECTS:uint = 3000;
      
      private static const MAX_DURATION:uint = 4000;
      
      private static var _results:Array;
      
      private static var _stage:Stage;
      
      public static var random:ParkMillerCarta;
       
      
      private var _ctr:Sprite;
      
      private var _currentFps:uint;
      
      private var _recordedFps:Array;
      
      private var _startTime:Number;
      
      private var _timer:uint;
      
      private var _fps:int;
      
      private var _lastTimer:int;
      
      private var _tickTimer:int;
      
      private var _tickTime:uint;
      
      public function TestDisplayPerformance()
      {
         super();
      }
      
      public static function set stage(s:Stage) : void
      {
         _stage = s;
      }
      
      public function run() : void
      {
         random = new ParkMillerCarta(8888);
         this._currentFps = 0;
         this._recordedFps = [];
         this._fps = 0;
         this._lastTimer = 0;
         this._tickTimer = 0;
         this._ctr = new Sprite();
         this._ctr.mouseEnabled = this._ctr.mouseChildren = false;
         _stage.addChildAt(this._ctr,0);
         this.addDummies(TOTAL_OBJECTS);
         this._startTime = getTimer();
         _stage.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function cancel() : void
      {
         this.clean();
      }
      
      private function onFrame(event:Event) : void
      {
         var l:uint = 0;
         var recentAverageFps:Number = NaN;
         this._timer = getTimer();
         this._tickTime = this._timer - this._tickTimer;
         if(this._tickTime >= 500)
         {
            this._tickTimer = this._timer;
            this._currentFps = this._fps * 2;
            if(this._recordedFps)
            {
               this._recordedFps.push(this._currentFps);
            }
            if(this._recordedFps && this._recordedFps.length > 4)
            {
               l = this._recordedFps.length;
               recentAverageFps = (this._recordedFps[l - 2] + this._recordedFps[l - 3] + this._recordedFps[l - 4]) / 3;
               if(Math.abs(recentAverageFps - this._currentFps) <= 2)
               {
                  if(this._recordedFps)
                  {
                     this.endTest(Math.floor((this._recordedFps[l - 1] + this._recordedFps[l - 2] + this._recordedFps[l - 3] + this._recordedFps[l - 4]) / 4));
                  }
               }
               if(getTimer() - this._startTime >= MAX_DURATION)
               {
                  if(this._recordedFps)
                  {
                     this.endTest(Math.floor((this._recordedFps[l - 1] + this._recordedFps[l - 2] + this._recordedFps[l - 3] + this._recordedFps[l - 4]) / 4));
                  }
               }
            }
            this._fps = 0;
         }
         ++this._fps;
         this._lastTimer = this._timer;
      }
      
      private function addDummies(amount:uint) : void
      {
         var i:int = 0;
         var dummy:DisplayObjectDummy = null;
         for(i = 0; i < amount; i++)
         {
            dummy = new DisplayObjectDummy(random.nextDouble() * 16777215,_stage);
            dummy.x = random.nextDouble() * _stage.stageWidth;
            dummy.y = random.nextDouble() * _stage.stageHeight;
            this._ctr.addChild(dummy);
         }
      }
      
      private function endTest(result:uint) : void
      {
         if(!_results)
         {
            _results = [];
         }
         _results.push(result);
         this.clean();
         Benchmark.onTestCompleted(this);
      }
      
      public function getResults() : String
      {
         var averageFps:Number = NaN;
         var i:int = 0;
         if(_results)
         {
            averageFps = 0;
            for(i = 0; i < _results.length; i++)
            {
               averageFps += _results[i];
            }
            averageFps = Math.floor(averageFps / _results.length);
            return "displayPerfTest:" + averageFps.toString();
         }
         return "displayPerfTest:none";
      }
      
      private function clean() : void
      {
         var dummy:DisplayObjectDummy = null;
         if(this._ctr)
         {
            while(this._ctr.numChildren)
            {
               dummy = this._ctr.getChildAt(0) as DisplayObjectDummy;
               if(dummy)
               {
                  dummy.destroy();
               }
               this._ctr.removeChildAt(0);
            }
         }
         if(_stage)
         {
            _stage.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            _stage.removeChild(this._ctr);
            _stage = null;
            this._ctr = null;
            this._recordedFps = null;
            random = null;
         }
      }
      
      private function logToConsole(txt:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("eval","console.log(\'" + txt + "\')");
         }
      }
   }
}
