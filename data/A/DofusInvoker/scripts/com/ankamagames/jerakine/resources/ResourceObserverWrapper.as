package com.ankamagames.jerakine.resources
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class ResourceObserverWrapper implements IResourceObserver
   {
       
      
      private var _onLoadedCallback:Function;
      
      private var _onFailedCallback:Function;
      
      private var _onProgressCallback:Function;
      
      public function ResourceObserverWrapper(onLoadedCallback:Function = null, onFailedCallback:Function = null, onProgressCallback:Function = null)
      {
         super();
         this._onLoadedCallback = onLoadedCallback;
         this._onFailedCallback = onFailedCallback;
         this._onProgressCallback = onProgressCallback;
      }
      
      public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         if(this._onLoadedCallback != null)
         {
            this._onLoadedCallback(uri,resourceType,resource);
         }
      }
      
      public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         if(this._onFailedCallback != null)
         {
            this._onFailedCallback(uri,errorMsg,errorCode);
         }
      }
      
      public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void
      {
         if(this._onProgressCallback != null)
         {
            this._onProgressCallback(uri,bytesLoaded,bytesTotal);
         }
      }
   }
}
