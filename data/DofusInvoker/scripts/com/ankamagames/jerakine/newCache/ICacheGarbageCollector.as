package com.ankamagames.jerakine.newCache
{
   public interface ICacheGarbageCollector
   {
       
      
      function set cache(param1:ICache) : void;
      
      function used(param1:*) : void;
      
      function purge(param1:uint) : void;
   }
}
