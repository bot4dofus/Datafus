package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class Chrono
   {
      
      private static var times:Array = [];
      
      private static var labels:Array = [];
      
      private static var level:int = 0;
      
      private static var indent:String = "";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Chrono));
      
      public static var show_total_time:Boolean = true;
       
      
      public function Chrono()
      {
         super();
      }
      
      public static function start(label:String = "") : void
      {
         label = !!label.length ? label : "Chrono " + times.length;
         times.push(getTimer());
         labels.push(label);
         level += 1;
         indent += "  ";
      }
      
      public static function stop() : int
      {
         var elapsed:int = getTimer() - times.pop();
         if(!show_total_time && times.length)
         {
            times[times.length - 1] -= elapsed;
         }
         --level;
         indent = indent.slice(0,2 * level + 1);
         return elapsed;
      }
      
      public static function display(str:String) : void
      {
         _log.trace("!!" + indent + "TRACE " + str);
      }
   }
}
