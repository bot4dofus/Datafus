package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.targets.AbstractTarget;
   import com.ankamagames.jerakine.logger.targets.ConfigurableLoggingTarget;
   
   public class DebugTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      public static var logLevels:Array = [];
       
      
      public function DebugTarget()
      {
         super();
         logLevels[LogLevel.COMMANDS] = false;
         logLevels[LogLevel.DEBUG] = true;
         logLevels[LogLevel.ERROR] = true;
         logLevels[LogLevel.FATAL] = true;
         logLevels[LogLevel.INFO] = true;
         logLevels[LogLevel.TRACE] = true;
         logLevels[LogLevel.WARN] = true;
      }
      
      public function configure(config:XML) : void
      {
         var level:XML = null;
         for each(level in config..level)
         {
            if(LogLevel[level.@name.toString().toUpperCase()])
            {
               logLevels[LogLevel[level.@name.toString().toUpperCase()]] = level.@log.toString() == "true";
            }
         }
      }
   }
}
