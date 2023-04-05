package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.FileProtocol;
   import com.ankamagames.jerakine.types.Uri;
   
   public class ThemeProtocol extends FileProtocol implements IProtocol
   {
      
      private static var _themePath:String;
       
      
      public function ThemeProtocol()
      {
         super();
      }
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void
      {
         var path:String = null;
         getAdapter(uri,forcedAdapter);
         if(!_themePath)
         {
            _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
         }
         if(uri.protocol == "theme")
         {
            path = _themePath + uri.path;
         }
         else
         {
            path = uri.path;
         }
         _adapter.loadDirectly(uri,extractPath(path.split("file://").join("")),observer,dispatchProgress);
      }
   }
}
