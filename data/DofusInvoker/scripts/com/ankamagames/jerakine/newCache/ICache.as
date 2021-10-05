package com.ankamagames.jerakine.newCache
{
   public interface ICache
   {
       
      
      function get size() : uint;
      
      function destroy() : void;
      
      function contains(param1:*) : Boolean;
      
      function extract(param1:*) : *;
      
      function peek(param1:*) : *;
      
      function store(param1:*, param2:*) : Boolean;
   }
}
