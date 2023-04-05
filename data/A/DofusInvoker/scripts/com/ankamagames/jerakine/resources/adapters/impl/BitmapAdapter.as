package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   
   public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter
   {
       
      
      public function BitmapAdapter()
      {
         super();
      }
      
      override public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         super.loadDirectly(uri,path,observer,dispatchProgress);
      }
      
      override protected function getResource(ldr:LoaderInfo) : *
      {
         return Bitmap(ldr.loader.content).bitmapData;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_BITMAP;
      }
   }
}
