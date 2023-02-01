package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.ByteArray;
   
   public interface IAdapter extends Poolable
   {
       
      
      function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void;
      
      function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void;
      
      function getResourceType() : uint;
   }
}
