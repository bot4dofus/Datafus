package com.ankamagames.jerakine.logger
{
   public final class LogLevel
   {
      
      public static const TRACE:uint = 1;
      
      public static const DEBUG:uint = 1 << 1;
      
      public static const INFO:uint = 1 << 2;
      
      public static const WARN:uint = 1 << 3;
      
      public static const ERROR:uint = 1 << 4;
      
      public static const FATAL:uint = 1 << 5;
      
      public static const COMMANDS:uint = 1 << 6;
       
      
      public function LogLevel()
      {
         super();
      }
      
      public static function getString(level:uint) : String
      {
         switch(level)
         {
            case TRACE:
               return "TRACE";
            case DEBUG:
               return "DEBUG";
            case INFO:
               return "INFO";
            case WARN:
               return "WARN";
            case ERROR:
               return "ERROR";
            case FATAL:
               return "FATAL";
            default:
               return "UNKNOWN";
         }
      }
   }
}
