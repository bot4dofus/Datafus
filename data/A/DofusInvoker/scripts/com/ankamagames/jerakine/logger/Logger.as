package com.ankamagames.jerakine.logger
{
   public interface Logger
   {
       
      
      function trace(param1:Object) : void;
      
      function debug(param1:Object) : void;
      
      function info(param1:Object) : void;
      
      function warn(param1:Object) : void;
      
      function error(param1:Object) : void;
      
      function fatal(param1:Object) : void;
      
      function log(param1:uint, param2:Object) : void;
      
      function logDirectly(param1:LogEvent) : void;
      
      function get category() : String;
      
      function clear() : void;
   }
}
