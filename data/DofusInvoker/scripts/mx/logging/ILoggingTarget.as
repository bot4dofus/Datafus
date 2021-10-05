package mx.logging
{
   public interface ILoggingTarget
   {
       
      
      function get filters() : Array;
      
      function set filters(param1:Array) : void;
      
      function get level() : int;
      
      function set level(param1:int) : void;
      
      function addLogger(param1:ILogger) : void;
      
      function removeLogger(param1:ILogger) : void;
   }
}
