package mx.logging
{
   import flash.events.IEventDispatcher;
   
   public interface ILogger extends IEventDispatcher
   {
       
      
      function get category() : String;
      
      function log(param1:int, param2:String, ... rest) : void;
      
      function debug(param1:String, ... rest) : void;
      
      function error(param1:String, ... rest) : void;
      
      function fatal(param1:String, ... rest) : void;
      
      function info(param1:String, ... rest) : void;
      
      function warn(param1:String, ... rest) : void;
   }
}
