package com.ankamagames.jerakine.sequencer
{
   import com.ankamagames.jerakine.lua.LuaPackage;
   
   public interface ISequencable extends LuaPackage
   {
       
      
      function start() : void;
      
      function addListener(param1:ISequencableListener) : void;
      
      function removeListener(param1:ISequencableListener) : void;
      
      function toString() : String;
      
      function clear() : void;
      
      function get isTimeout() : Boolean;
      
      function set timeout(param1:int) : void;
      
      function get timeout() : int;
      
      function get hasDefaultTimeout() : Boolean;
   }
}
