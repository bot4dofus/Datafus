package com.ankamagames.jerakine.benchmark
{
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BenchmarkTimer extends Timer
   {
      
      private static var startedTimers:Dictionary = new Dictionary(true);
      
      private static var startWithoutResetCount:int = 0;
       
      
      private var hasBeenReset:Boolean = true;
      
      private var name:String = "unamed";
      
      public function BenchmarkTimer(delay:int, repeatCount:int = 0, name:String = "")
      {
         this.name = name;
         super(delay,repeatCount);
      }
      
      public static function printUnstoppedTimers() : void
      {
         var timer:* = null;
         var unstoppedTimersCount:int = 0;
         for(timer in startedTimers)
         {
            unstoppedTimersCount++;
            LogInFile.getInstance().logLine("This Timer is unstopped: " + timer.name,FileLoggerEnum.BENCHMARKTIMERS);
         }
         LogInFile.getInstance().logLine("Total unstopped Timers: " + unstoppedTimersCount,FileLoggerEnum.BENCHMARKTIMERS);
         LogInFile.getInstance().logLine("Stop Recording BenchmarkTimers.",FileLoggerEnum.BENCHMARKTIMERS);
      }
      
      override public function start() : void
      {
         super.start();
         if(!this.hasBeenReset)
         {
            ++startWithoutResetCount;
            LogInFile.getInstance().logLine("This Timer has not been reset before start: " + this.name,FileLoggerEnum.BENCHMARKTIMERS);
         }
         if(!startedTimers[this])
         {
            startedTimers[this] = true;
         }
         this.hasBeenReset = false;
      }
      
      override public function stop() : void
      {
         super.stop();
         delete startedTimers[this];
      }
      
      override public function reset() : void
      {
         super.reset();
         this.hasBeenReset = true;
      }
   }
}
