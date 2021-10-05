package cmodule.lua_wrapper
{
   public interface Debuggee
   {
       
      
      function cancelDebug() : void;
      
      function suspend() : void;
      
      function resume() : void;
      
      function get isRunning() : Boolean;
   }
}
