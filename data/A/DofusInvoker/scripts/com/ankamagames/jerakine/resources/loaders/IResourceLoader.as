package com.ankamagames.jerakine.resources.loaders
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.IEventDispatcher;
   
   public interface IResourceLoader extends IEventDispatcher
   {
       
      
      function load(param1:*, param2:ICache = null, param3:Class = null, param4:Boolean = false) : void;
      
      function cancel() : void;
      
      function isInCache(param1:Uri) : Boolean;
   }
}
