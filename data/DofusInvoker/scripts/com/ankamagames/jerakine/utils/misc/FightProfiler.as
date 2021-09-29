package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.getTimer;
   
   public class FightProfiler
   {
      
      private static const _profiler:FightProfiler = new FightProfiler();
      
      private static var _startTime:int = 0;
       
      
      private var _info:String;
      
      public function FightProfiler()
      {
         super();
      }
      
      public static function getInstance() : FightProfiler
      {
         return _profiler;
      }
      
      public function start() : void
      {
         _startTime = getTimer();
      }
      
      public function stop() : void
      {
         this._info = (getTimer() - _startTime).toString();
      }
      
      public function get info() : String
      {
         return this._info;
      }
   }
}
