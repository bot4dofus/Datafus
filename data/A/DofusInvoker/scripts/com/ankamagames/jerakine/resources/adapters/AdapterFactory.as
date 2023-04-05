package com.ankamagames.jerakine.resources.adapters
{
   import com.ankamagames.jerakine.resources.ResourceError;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.BinaryAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.BitmapAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.JSONAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.MP3Adapter;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.SwfAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.SwlAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.TxtAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.XmlAdapter;
   import com.ankamagames.jerakine.resources.adapters.impl.ZipAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.utils.Dictionary;
   
   public class AdapterFactory
   {
      
      private static var _customAdapters:Dictionary = new Dictionary();
       
      
      private var include_SimpleLoaderAdapter:SimpleLoaderAdapter = null;
      
      public function AdapterFactory()
      {
         super();
      }
      
      public static function getAdapter(uri:Uri) : IAdapter
      {
         var ca:* = undefined;
         var uriFileType:String = uri.fileType;
         switch(uriFileType.toLowerCase())
         {
            case "xml":
            case "meta":
            case "dm":
            case "dt":
               return new XmlAdapter();
            case "png":
            case "gif":
            case "jpg":
            case "jpeg":
               return new BitmapAdapter();
            case "txt":
            case "css":
               return new TxtAdapter();
            case "swf":
               return new SwfAdapter();
            case "aswf":
               return new AdvancedSwfAdapter();
            case "swl":
               return new SwlAdapter();
            case "zip":
               return new ZipAdapter();
            case "mp3":
               return new MP3Adapter();
            case "json":
               return new JSONAdapter();
            default:
               if(uri.subPath && FileUtils.getExtension(uri.path) == "swf")
               {
                  return new AdvancedSwfAdapter();
               }
               var customAdapter:Class = _customAdapters[uriFileType] as Class;
               if(customAdapter)
               {
                  ca = new customAdapter();
                  if(!(ca is IAdapter))
                  {
                     throw new ResourceError("Registered custom adapter for extension " + uriFileType + " isn\'t an IAdapter class.");
                  }
                  return ca;
               }
               if(uriFileType.substr(-1) == "s")
               {
                  return new SignedFileAdapter();
               }
               return new BinaryAdapter();
         }
      }
      
      public static function addAdapter(extension:String, adapter:Class) : void
      {
         _customAdapters[extension] = adapter;
      }
      
      public static function removeAdapter(extension:String) : void
      {
         delete _customAdapters[extension];
      }
   }
}
