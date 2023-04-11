package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.LangMetaData;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.events.FileEvent;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class DataUpdateManager extends EventDispatcher
   {
      
      public static const SQL_MODE:Boolean = XmlConfig.getInstance().getEntry("config.data.SQLMode") == "true";
       
      
      protected const _log:Logger = Log.getLogger(getQualifiedClassName(DataUpdateManager));
      
      protected var _loader:IResourceLoader;
      
      protected var _versions:Array;
      
      protected var _dataFilesLoaded:Boolean = false;
      
      protected var _files:Array;
      
      protected var _loadedFileCount:uint = 0;
      
      protected var _metaFileListe:Uri;
      
      protected var _storeKey:String;
      
      private var _clearAll:Boolean;
      
      private var _datastoreList:Array;
      
      public function DataUpdateManager()
      {
         super();
      }
      
      public function init(metaFileListe:Uri, clearAll:Boolean = false) : void
      {
         this._metaFileListe = metaFileListe;
         this._storeKey = "version_" + this._metaFileListe.uri;
         this._clearAll = clearAll;
         if(this._clearAll)
         {
            this.clear();
         }
         this.initMetaFileListe();
      }
      
      public function initMetaFileListe() : void
      {
         this._versions = !!this._clearAll ? [] : StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_FILES_INFO,this._storeKey,new Array());
         this._files = [];
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onComplete);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadFailed);
         this._loader.load(this._metaFileListe);
      }
      
      public function get files() : Array
      {
         return this._files;
      }
      
      public function clear() : void
      {
      }
      
      protected function checkFileVersion(sFileName:String, sVersion:String) : Boolean
      {
         return this._versions[sFileName] == sVersion;
      }
      
      protected function onLoaded(e:ResourceLoadedEvent) : void
      {
         var meta:LangMetaData = null;
         var uri:Uri = null;
         var container:Object = null;
         var file:* = null;
         switch(e.uri.fileType)
         {
            case "meta":
               meta = LangMetaData.fromXml(e.resource,e.uri.uri,this.checkFileVersion);
               for(file in meta.clearFile)
               {
                  uri = new Uri(FileUtils.getFilePath(e.uri.path) + "/" + file);
                  uri.tag = {
                     "version":meta.clearFile[file],
                     "file":FileUtils.getFileStartName(e.uri.uri) + "." + file
                  };
                  this._files.push(uri);
               }
               if(meta.clearFileCount)
               {
                  this._loader.load(this._files);
               }
               else
               {
                  dispatchEvent(new Event(Event.COMPLETE));
               }
               break;
            case "swf":
               this._dataFilesLoaded = true;
               container = e.resource;
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,container.moduleName + "_filelist",container.fileList);
               StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,container.moduleName + "_chunkLength",container.chunkLength);
               ++this._loadedFileCount;
         }
      }
      
      private function onLoadFailed(e:ResourceErrorEvent) : void
      {
         this._log.error("Failed " + e.uri);
         dispatchEvent(new FileEvent(FileEvent.ERROR,e.uri.uri,false));
      }
      
      private function onComplete(e:ResourceLoaderProgressEvent) : void
      {
         this._loader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onComplete);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadFailed);
         if(this._dataFilesLoaded)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
   }
}
