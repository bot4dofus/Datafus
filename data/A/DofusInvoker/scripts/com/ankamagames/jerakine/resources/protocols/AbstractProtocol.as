package com.ankamagames.jerakine.resources.protocols
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AbstractProtocol
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      protected var _observer:IResourceObserver;
      
      protected var _adapter:IAdapter;
      
      public function AbstractProtocol()
      {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public function free() : void
      {
         this.release();
         this._observer = null;
         this._adapter = null;
      }
      
      public function cancel() : void
      {
      }
      
      protected function release() : void
      {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void
      {
         this.getAdapter(uri,forcedAdapter);
         this._adapter.loadDirectly(uri,uri.path,observer,dispatchProgress);
      }
      
      protected function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void
      {
         this.getAdapter(uri,forcedAdapter);
         this._adapter.loadFromData(uri,data,observer,dispatchProgress);
      }
      
      protected function getAdapter(uri:Uri, forcedAdapter:Class) : void
      {
         if(forcedAdapter == null)
         {
            this._adapter = AdapterFactory.getAdapter(uri);
         }
         else
         {
            this._adapter = new forcedAdapter();
         }
      }
   }
}
