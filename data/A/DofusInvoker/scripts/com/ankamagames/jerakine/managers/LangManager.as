package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.LangAllFilesLoadedMessage;
   import com.ankamagames.jerakine.messages.LangFileLoadedMessage;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.task.LangXmlParsingTask;
   import com.ankamagames.jerakine.tasking.SplittedTask;
   import com.ankamagames.jerakine.types.LangFile;
   import com.ankamagames.jerakine.types.LangMetaData;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.errors.FileTypeError;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class LangManager
   {
      
      private static var _self:LangManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LangManager));
      
      protected static const KEY_LANG_INDEX:String = "langIndex";
      
      protected static const KEY_LANG_CATEGORY:String = "langCategory";
      
      protected static const KEY_LANG_VERSION:String = "langVersion";
       
      
      private const REG:String = "Reg";
      
      private var _aLang:Array;
      
      private var _aCategory:Array;
      
      private var _handler:MessageHandler;
      
      private var _sLang:String;
      
      private var _aVersion:Array;
      
      private var _loader:IResourceLoader;
      
      private var _parseReference:Dictionary;
      
      private var _fontManager:FontManager;
      
      private var _replaceErrorCallback:Function;
      
      public function LangManager()
      {
         this._parseReference = new Dictionary();
         super();
         if(_self != null)
         {
            throw new SingletonError("LangManager is a singleton and should not be instanciated directly.");
         }
         this._aLang = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,new Array());
         this._aCategory = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,KEY_LANG_CATEGORY,new Array());
         this._aVersion = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION);
         this._aCategory = new Array();
         this._aVersion = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION,new Array());
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFileError);
      }
      
      public static function getInstance() : LangManager
      {
         if(_self == null)
         {
            _self = new LangManager();
         }
         return _self;
      }
      
      public function get handler() : MessageHandler
      {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void
      {
         this._handler = value;
      }
      
      public function get lang() : String
      {
         return this._sLang;
      }
      
      public function set lang(sLang:String) : void
      {
         this._sLang = sLang;
      }
      
      public function get category() : Array
      {
         return this._aCategory;
      }
      
      public function set replaceErrorCallback(fct:Function) : void
      {
         this._replaceErrorCallback = fct;
      }
      
      public function loadFile(sUrl:String, parseReference:Boolean = true) : void
      {
         if(parseReference)
         {
            this._parseReference[new Uri(sUrl).uri] = parseReference;
         }
         this.loadMetaDataFile(sUrl);
      }
      
      public function loadFromXml(xml:String, category:String, url:String, parseReference:Boolean = true) : void
      {
         var uri:Uri = new Uri(url);
         if(parseReference)
         {
            this._parseReference[uri.uri] = parseReference;
         }
         var langFile:LangFile = new LangFile(xml,category,uri.uri);
         this.startParsing([langFile],uri.uri);
      }
      
      public function getUntypedEntry(sKey:String) : *
      {
         var sEntry:* = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX)[sKey];
         if(sEntry == null)
         {
            _log.warn("[Warning] LangManager : " + sKey + " is unknow");
            sEntry = "!" + sKey;
         }
         if(sEntry != null && sEntry is String && String(sEntry).indexOf("[") != -1)
         {
            sEntry = this.replaceKey(sEntry,true);
         }
         return sEntry;
      }
      
      public function getEntry(sKey:String) : String
      {
         return this.getUntypedEntry(sKey);
      }
      
      public function getStringEntry(sKey:String) : String
      {
         return this.getUntypedEntry(sKey);
      }
      
      public function getBooleanEntry(sKey:String) : Boolean
      {
         return this.getUntypedEntry(sKey);
      }
      
      public function getIntEntry(sKey:String) : int
      {
         return this.getUntypedEntry(sKey);
      }
      
      public function getFloatEntry(sKey:String) : Number
      {
         return this.getUntypedEntry(sKey);
      }
      
      public function setEntry(sKey:String, sValue:String, sType:String = null) : void
      {
         var c:Class = null;
         if(!sType)
         {
            this._aLang[sKey] = sValue;
         }
         else
         {
            switch(sType.toUpperCase())
            {
               case "STRING":
                  this._aLang[sKey] = sValue;
                  break;
               case "NUMBER":
                  this._aLang[sKey] = parseFloat(sValue);
                  break;
               case "UINT":
               case "INT":
                  this._aLang[sKey] = parseInt(sValue,10);
                  break;
               case "BOOLEAN":
                  this._aLang[sKey] = sValue.toLowerCase() == "true";
                  break;
               case "ARRAY":
                  this._aLang[sKey] = sValue.split(",");
                  break;
               case "BOOLEAN":
                  this._aLang[sKey] = sValue.toLowerCase() == "true";
                  break;
               default:
                  c = getDefinitionByName(sType) as Class;
                  this._aLang[sKey] = new c(sValue);
            }
         }
      }
      
      public function deleteEntry(sKey:String) : void
      {
         delete this._aLang[sKey];
      }
      
      public function replaceKey(sTxt:String, bReplaceDynamicReference:Boolean = false) : String
      {
         var aKey:Array = null;
         var reg:RegExp = null;
         var i:uint = 0;
         var sNewVal:* = null;
         var aFind:Array = null;
         var sKey:String = null;
         if(sTxt != null && sTxt.indexOf("[") != -1)
         {
            reg = /(?<!\\)\[([^\]]*)\]/g;
            aKey = sTxt.match(reg);
            if(sTxt.indexOf("\\["))
            {
               sTxt = sTxt.split("\\[").join("[");
            }
            for(i = 0; i < aKey.length; i++)
            {
               sKey = aKey[i].substr(1,aKey[i].length - 2);
               if(sKey.charAt(0) == "#")
               {
                  if(!bReplaceDynamicReference)
                  {
                     continue;
                  }
                  sKey = sKey.substr(1);
               }
               sNewVal = this._aLang[sKey];
               if(sNewVal == null)
               {
                  if(int(sKey) > 0)
                  {
                     sNewVal = I18n.getText(parseInt(sKey,10));
                  }
                  if(I18n.hasUiText(sKey))
                  {
                     sNewVal = I18n.getUiText(sKey);
                  }
                  else
                  {
                     if(sKey.charAt(0) == "~")
                     {
                        continue;
                     }
                     if(this._replaceErrorCallback != null)
                     {
                        sNewVal = this._replaceErrorCallback(sKey);
                     }
                     if(sNewVal == null)
                     {
                        sNewVal = "[" + sKey + "]";
                        aFind = this.findCategory(sKey);
                        if(aFind.length)
                        {
                           _log.warn("Référence incorrect vers la clef [" + sKey + "] dans : " + sTxt + " (pourrait être " + aFind.join(" ou ") + ")");
                        }
                        else
                        {
                           _log.warn("Référence inconnue vers la clef [" + sKey + "] dans : " + sTxt);
                        }
                     }
                  }
               }
               sTxt = sTxt.split(aKey[i]).join(sNewVal);
            }
         }
         return sTxt;
      }
      
      public function getCategory(sCategory:String, matchSubCategories:Boolean = true) : Array
      {
         var key:* = null;
         var aResult:Array = new Array();
         for(key in this._aLang)
         {
            if(matchSubCategories)
            {
               if(key == sCategory)
               {
                  aResult[key] = this._aLang[key];
               }
               else if(key.indexOf(sCategory) == 0)
               {
                  aResult[key] = this._aLang[key];
               }
            }
         }
         return aResult;
      }
      
      public function findCategory(sKey:String) : Array
      {
         var s:* = null;
         var sK:String = sKey.split(".")[0];
         var aCat:Array = new Array();
         for(s in this._aCategory)
         {
            if(this._aLang[s + "." + sK] != null)
            {
               aCat.push(s + "." + sK);
            }
         }
         for(s in this._aCategory)
         {
            if(this._aLang[s + "." + sKey] != null)
            {
               aCat.push(s + "." + sKey);
            }
         }
         return aCat;
      }
      
      public function setFileVersion(sFilename:String, sVersion:String) : void
      {
         this._aVersion[sFilename] = sVersion;
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION,this._aVersion);
      }
      
      public function checkFileVersion(sFileName:String, sVersion:String) : Boolean
      {
         return this._aVersion[sFileName] == sVersion;
      }
      
      public function clear(sCategory:String = null) : void
      {
         var sCat:* = null;
         var s:* = null;
         if(sCategory)
         {
            sCat = sCategory + ".";
            for(s in this._aLang)
            {
               if(s.indexOf(sCat) == 0)
               {
                  delete this._aLang[s];
               }
            }
         }
         else
         {
            this._aLang = new Array();
         }
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,this._aLang);
      }
      
      private function loadMetaDataFile(sUrl:String) : void
      {
         var sMetDataUrl:String = null;
         var uri:Uri = null;
         try
         {
            sMetDataUrl = FileUtils.getFilePathStartName(sUrl) + ".meta";
            uri = new Uri(sMetDataUrl);
            uri.tag = sUrl;
            this._loader.load(uri);
         }
         catch(e:Error)
         {
            _log.error(e.message);
            if(e.getStackTrace())
            {
               _log.error(e.getStackTrace());
            }
            else
            {
               _log.error("no stack trace available");
            }
         }
      }
      
      private function loadLangFile(sUrl:String, oMeta:LangMetaData) : void
      {
         var uri:Uri = null;
         var sExtension:String = FileUtils.getExtension(sUrl);
         if(sExtension == null)
         {
            throw new FileTypeError(sUrl + " have no type (no extension found).");
         }
         if(!oMeta.clearAllFile && !oMeta.clearFileCount && !oMeta.loadAllFile)
         {
            this._handler.process(new LangAllFilesLoadedMessage(sUrl,true));
            return;
         }
         uri = new Uri(sUrl);
         uri.tag = oMeta;
         switch(sExtension.toUpperCase())
         {
            case "ZIP":
               Chrono.start("Chargement zip");
               break;
            case "XML":
               break;
            default:
               throw new FileTypeError(sUrl + " is not expected type (bad extension found (" + sExtension + "), support only .zip and .xml).");
         }
         this._loader.load(uri);
      }
      
      private function startParsing(aLangData:Array, sUrlProvider:String) : void
      {
         StoreDataManager.getInstance().startStoreSequence();
         var parseReference:Boolean = this._parseReference[sUrlProvider];
         var stParsing:LangXmlParsingTask = new LangXmlParsingTask(aLangData,sUrlProvider,parseReference);
         stParsing.addEventListener(LangFileEvent.ALL_COMPLETE,this.onTaskEnd);
         stParsing.addEventListener(LangFileEvent.COMPLETE,this.onTaskStep);
         if(getQualifiedClassName(StageShareManager.rootContainer) == this.REG)
         {
            StageShareManager.rootContainer.addEventListener(Event.ENTER_FRAME,stParsing.step);
         }
         else
         {
            EnterFrameDispatcher.addEventListener(stParsing.step,EnterFrameConst.LANG_MANAGER_PARSING);
         }
      }
      
      private function onFileLoaded(e:ResourceLoadedEvent) : void
      {
         switch(e.uri.fileType.toUpperCase())
         {
            case "XML":
               this.onXmlLoadComplete(e);
               break;
            case "META":
               this.onMetaLoad(e);
               break;
            case "ZIP":
               Chrono.stop();
               this.onZipFileComplete(e);
         }
      }
      
      private function onFileError(e:ResourceErrorEvent) : void
      {
         switch(e.uri.fileType.toUpperCase())
         {
            case "XML":
               this.onXmlLoadError(e);
               break;
            case "META":
               this.onMetaLoadError(e);
               break;
            case "ZIP":
               this.onZipFileLoadError(e);
         }
      }
      
      private function onXmlLoadComplete(e:ResourceLoadedEvent) : void
      {
         var metaData:LangMetaData = LangMetaData(e.uri.tag);
         var sCat:String = FileUtils.getFileStartName(e.uri.uri);
         if(sCat == "config-custom" || sCat.indexOf("config-lang-") != -1)
         {
            sCat = "config";
         }
         if(metaData.clearFile[e.uri.fileName] || metaData.clearAllFile || metaData.loadAllFile)
         {
            if(metaData.clearFile[e.uri.fileName] || metaData.clearAllFile)
            {
               this.clear(sCat);
            }
            this.startParsing(new Array(new LangFile(e.resource,sCat,e.uri.uri)),e.uri.uri);
         }
      }
      
      private function onZipFileComplete(e:ResourceLoadedEvent) : void
      {
         var sCat:String = null;
         var s:* = null;
         var entry:ZipEntry = null;
         var i:uint = 0;
         var zipFile:ZipFile = e.resource;
         var aFileList:Array = new Array();
         var aLangData:Array = new Array();
         var metaData:LangMetaData = LangMetaData(e.uri.tag);
         for(var fileIndex:uint = 0; fileIndex < zipFile.entries.length; fileIndex++)
         {
            aFileList.push(zipFile.getEntry(zipFile.entries[fileIndex]));
         }
         for(s in metaData.clearFile)
         {
            if(!zipFile.getEntry(s))
            {
               _log.warn("File \'" + s + "\' was not found in " + e.uri.uri + " (specified by metadata file)");
            }
         }
         for(i = 0; i < aFileList.length; i++)
         {
            entry = aFileList[i];
            sCat = FileUtils.getFileStartName(entry.name);
            if(metaData.clearFile[entry.name] || metaData.clearAllFile || metaData.loadAllFile)
            {
               if(metaData.clearFile[entry.name] || metaData.clearAllFile)
               {
                  this.clear(sCat);
               }
               if(metaData.clearFile[entry.name] || metaData.loadAllFile)
               {
                  aLangData.push(new LangFile(zipFile.getInput(aFileList[i]).toString(),sCat,entry.name,metaData));
               }
            }
         }
         this.startParsing(aLangData,e.uri.uri);
      }
      
      private function onMetaLoad(e:ResourceLoadedEvent) : void
      {
         this.loadLangFile(e.uri.tag as String,LangMetaData.fromXml(e.resource,e.uri.tag as String,this.checkFileVersion));
      }
      
      private function onXmlLoadError(e:ResourceErrorEvent) : void
      {
         _log.warn("[Warning] can\'t load " + e.uri.uri);
         this._handler.process(new LangFileLoadedMessage(e.uri.uri,false,e.uri.uri));
      }
      
      private function onZipFileLoadError(e:ResourceErrorEvent) : void
      {
         _log.warn("Can\'t load " + e.uri.uri);
         this._handler.process(new LangFileLoadedMessage(e.uri.uri,false,e.uri.uri));
      }
      
      private function onTaskStep(e:LangFileEvent) : void
      {
         if(this._handler)
         {
            this._handler.process(new LangFileLoadedMessage(e.url,true,e.urlProvider));
         }
      }
      
      private function onTaskEnd(e:LangFileEvent) : void
      {
         (e.currentTarget as LangXmlParsingTask).removeEventListener(LangFileEvent.ALL_COMPLETE,this.onTaskEnd);
         (e.currentTarget as LangXmlParsingTask).removeEventListener(LangFileEvent.COMPLETE,this.onTaskStep);
         if(getQualifiedClassName(StageShareManager.rootContainer) == this.REG)
         {
            StageShareManager.rootContainer.removeEventListener(Event.ENTER_FRAME,(e.currentTarget as SplittedTask).step);
         }
         else
         {
            EnterFrameDispatcher.removeEventListener((e.currentTarget as SplittedTask).step);
         }
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,this._aLang);
         StoreDataManager.getInstance().stopStoreSequence();
         if(this._handler)
         {
            this._handler.process(new LangAllFilesLoadedMessage(e.urlProvider,true));
         }
      }
      
      private function onMetaLoadError(e:ResourceErrorEvent) : void
      {
         var meta:LangMetaData = new LangMetaData();
         meta.loadAllFile = true;
         this.loadLangFile(e.uri.tag as String,meta);
      }
   }
}
