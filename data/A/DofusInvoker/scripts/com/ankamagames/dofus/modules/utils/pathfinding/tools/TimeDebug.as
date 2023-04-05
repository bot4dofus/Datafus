package com.ankamagames.dofus.modules.utils.pathfinding.tools
{
   import flash.utils.getTimer;
   
   public class TimeDebug
   {
      
      private static var lastTime:int = getTimer();
       
      
      public function TimeDebug()
      {
         super();
      }
      
      public static function reset(value:int = -1) : void
      {
         if(value < 0)
         {
            lastTime = getTimer();
         }
         else
         {
            lastTime = value;
         }
      }
      
      public static function getElapsedTime(autoReset:Boolean = true) : int
      {
         var time:int = getTimer();
         var elapsedTime:int = time - lastTime;
         if(autoReset)
         {
            reset(time);
         }
         return elapsedTime;
      }
      
      public static function getElapsedTimeInSeconds() : Number
      {
         return getElapsedTime() * 0.001;
      }
      
      public static function exec(f:Function, onEnd:Function = null) : Number
      {
         var duration:Number = NaN;
         if(f != null)
         {
            reset();
            f();
            duration = getElapsedTimeInSeconds();
            if(onEnd != null)
            {
               onEnd(duration);
            }
            return duration;
         }
         return -1;
      }
   }
}
