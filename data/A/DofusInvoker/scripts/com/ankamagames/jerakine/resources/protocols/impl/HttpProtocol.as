package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   
   public class HttpProtocol extends AbstractProtocol implements IProtocol
   {
       
      
      public function HttpProtocol()
      {
         super();
      }
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, uniqueFile:Boolean) : void
      {
         getAdapter(uri,forcedAdapter);
         _adapter.loadDirectly(uri,uri.protocol + "://" + uri.path,observer,dispatchProgress);
      }
      
      override protected function release() : void
      {
      }
      
      override public function cancel() : void
      {
         if(_adapter)
         {
            _adapter.free();
         }
      }
   }
}
