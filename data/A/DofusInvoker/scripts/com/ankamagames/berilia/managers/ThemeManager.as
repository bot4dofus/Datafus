package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.Margin;
   import com.ankamagames.berilia.types.data.Theme;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.messages.NoThemeErrorMessage;
   import com.ankamagames.berilia.types.messages.ThemeLoadErrorMessage;
   import com.ankamagames.berilia.types.messages.ThemeLoadedMessage;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ThemeProtocol;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ThemeManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ThemeManager));
      
      public static const OFFICIAL_THEME_NAME:String = "darkStone";
      
      private static var _self:ThemeManager;
       
      
      private var _loader:IResourceLoader;
      
      private var _themes:Array;
      
      private var _themeNames:Array;
      
      private var _dtFileToLoad:uint = 0;
      
      private var _themeCount:uint = 0;
      
      private var _themesRoot:File;
      
      private var _currentTheme:Theme;
      
      private var _applyWaiting:String = "";
      
      private var _themeDataCache:Dictionary;
      
      private var _customThemesPath:String = "";
      
      private var _officialThemesPath:String = "";
      
      private var _needAdditionalCheck:Boolean;
      
      public function ThemeManager()
      {
         this._themeDataCache = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError,false,0,true);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad,false,0,true);
         ProtocolFactory.addProtocol("theme",ThemeProtocol);
      }
      
      public static function getInstance() : ThemeManager
      {
         if(!_self)
         {
            _self = new ThemeManager();
         }
         return _self;
      }
      
      public function get customThemesPath() : String
      {
         return this._customThemesPath;
      }
      
      public function get themesRoot() : File
      {
         return this._themesRoot;
      }
      
      public function get themeCount() : uint
      {
         return this._themeCount;
      }
      
      public function get currentTheme() : String
      {
         return !!this._currentTheme ? this._currentTheme.fileName : null;
      }
      
      public function get themeData() : Object
      {
         return this._currentTheme.data;
      }
      
      public function init(officialThemesPath:String, customThemesPath:String, needAdditionalCheck:Boolean = false) : void
      {
         this._needAdditionalCheck = needAdditionalCheck;
         this._themes = new Array();
         this._themeNames = new Array();
         this._themeCount = 0;
         this._dtFileToLoad = 0;
         this._officialThemesPath = officialThemesPath;
         this._customThemesPath = customThemesPath;
         this.initPath(this._officialThemesPath,true);
         this.initPath(this._customThemesPath,false);
      }
      
      private function initPath(themesPath:String, official:Boolean) : void
      {
         var file:File = null;
         var themesRoot:File = new File(themesPath);
         if(themesRoot.exists)
         {
            if(official)
            {
               this._themesRoot = themesRoot;
            }
            for each(file in themesRoot.getDirectoryListing())
            {
               this.initTheme(file,official);
            }
         }
      }
      
      public function initTheme(themeFolder:File, official:Boolean = false) : void
      {
         var uri:Uri = null;
         var len:int = 0;
         var substr:String = null;
         var fs:FileStream = null;
         var data:XML = null;
         var folder:Array = null;
         var folderFullPath:String = null;
         if(!themeFolder.isDirectory || themeFolder.name.charAt(0) == ".")
         {
            return;
         }
         if(this._needAdditionalCheck && official && themeFolder.name != ThemeManager.OFFICIAL_THEME_NAME)
         {
            _log.warn("Won\'t load unofficial theme from " + themeFolder.nativePath);
            return;
         }
         if(!official && !ThemeInstallerSecurity.checkSecurity(themeFolder))
         {
            Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(themeFolder.name));
            return;
         }
         var dtFile:File = this.searchDtFile(themeFolder);
         if(dtFile)
         {
            ++this._dtFileToLoad;
            if(dtFile.url.indexOf("app:/") == 0)
            {
               len = "app:/".length;
               substr = dtFile.url.substring(len,dtFile.url.length);
               uri = new Uri(substr);
            }
            else
            {
               uri = new Uri(dtFile.nativePath,false);
            }
            uri.tag = dtFile;
            if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS)
            {
               _log.debug("Using FileStream to load " + dtFile.nativePath + " on MAC OS X!");
               fs = new FileStream();
               fs.open(dtFile,FileMode.READ);
               data = XML(fs.readUTFBytes(fs.bytesAvailable));
               fs.close();
               folder = uri.path.split("/");
               folderFullPath = uri.path.slice(0,uri.path.lastIndexOf("/") + 1);
               this.loadDT(data,uri.fileName.split(".")[0],folder[folder.length - 2],folderFullPath);
            }
            else
            {
               this._loader.load(uri);
            }
         }
         else if(!official || themeFolder.name != "dofus1" && themeFolder.name != "black")
         {
            _log.error("Impossible de trouver le fichier de description de thème dans le dossier " + themeFolder.nativePath);
            Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(themeFolder.name));
         }
      }
      
      public function getThemes() : Array
      {
         return this._themes;
      }
      
      public function getTheme(name:String) : Theme
      {
         return this._themes[name];
      }
      
      public function getThemeByAuthorAndName(authorAndName:String) : Theme
      {
         var t:Theme = null;
         for each(t in this._themes)
         {
            if(authorAndName == t.author + "_" + t.name)
            {
               return t;
            }
         }
         return null;
      }
      
      public function applyTheme(name:String) : void
      {
         var uiSkinEntry:String = null;
         var t:Theme = null;
         if(this._dtFileToLoad == this._themeCount)
         {
            if(this._themeNames.length == 0)
            {
               Berilia.getInstance().handler.process(new NoThemeErrorMessage());
            }
            else
            {
               this._applyWaiting = null;
               if(!this._themes[name])
               {
                  for each(t in this._themes)
                  {
                     if(t.official && t.type == 1)
                     {
                        name = t.id;
                        break;
                     }
                  }
                  OptionManager.getOptionManager("dofus").setOption("currentUiSkin",name);
                  UiRenderManager.getInstance().clearCache();
               }
               this._currentTheme = this._themes[name];
               if(this._currentTheme.type == Theme.TYPE_OLD)
               {
                  _log.error("Specified theme is no more compatible (skinType 1).");
                  return;
               }
               if(!this._currentTheme.official)
               {
                  Uri.unescapeThemePath = unescape(new File(this._currentTheme.folderFullPath).nativePath);
               }
               uiSkinEntry = this._currentTheme.folderFullPath;
               LangManager.getInstance().setEntry("config.ui.skin",uiSkinEntry,"string");
               XmlConfig.getInstance().setEntry("config.ui.skin",uiSkinEntry);
               LangManager.getInstance().loadFile(uiSkinEntry + "colors.xml");
               this.loadThemeData(name);
            }
         }
         else
         {
            this._applyWaiting = name;
         }
      }
      
      public function loadThemeData(id:String = null) : void
      {
         var file:File = null;
         var uiSkinEntry:String = !!id ? this._themes[id].folderFullPath : this._currentTheme.folderFullPath;
         var themeFolderUri:Uri = new Uri(uiSkinEntry);
         var themeFolder:File = themeFolderUri.toFile();
         var themeFiles:Array = themeFolder.getDirectoryListing();
         var jsonUris:Array = new Array();
         for each(file in themeFiles)
         {
            if(file.extension && file.extension.toLowerCase() == "json")
            {
               jsonUris.push(new Uri(file.nativePath));
            }
         }
         this._loader.load(jsonUris);
      }
      
      public function applyThemeData(target:GraphicContainer, forceThemeDataId:String = null) : Boolean
      {
         var key:String = null;
         var value:* = undefined;
         if(target == null)
         {
            return false;
         }
         if(forceThemeDataId == null)
         {
            var forceThemeDataId:String = target.themeDataId;
            if(forceThemeDataId == null)
            {
               return false;
            }
         }
         if(!this.themeData || !this.themeData[forceThemeDataId])
         {
            return false;
         }
         var wantedThemeData:Dictionary = this._themeDataCache[forceThemeDataId];
         if(!wantedThemeData)
         {
            wantedThemeData = new Dictionary();
            this._themeDataCache[forceThemeDataId] = wantedThemeData;
         }
         var userData:Object = this.themeData[forceThemeDataId];
         for(key in userData)
         {
            if(target.hasOwnProperty(key))
            {
               if(wantedThemeData[key])
               {
                  target[key] = wantedThemeData[key];
               }
               else
               {
                  switch(key)
                  {
                     case "alpha":
                        value = userData[key] is String ? parseFloat(LangManager.getInstance().replaceKey(userData[key])) : userData[key];
                        break;
                     case "tileRender":
                        value = userData[key] is String ? LangManager.getInstance().replaceKey(userData[key]).toLowerCase() == "true" : userData[key] == 1;
                        break;
                     case "align":
                        value = LangManager.getInstance().replaceKey(userData[key]);
                        break;
                     case "uri":
                        try
                        {
                           value = new Uri(LangManager.getInstance().replaceKey(userData[key]));
                        }
                        catch(e:Error)
                        {
                           _log.error(e);
                        }
                        break;
                     case "scale9Grid":
                        value = new Rectangle();
                        this.setMembers(value,userData[key]);
                        break;
                     case "colorTransform":
                        value = new ColorTransform();
                        this.setMembers(value,userData[key]);
                        break;
                     case "margin":
                        value = new Margin();
                        this.setMembers(value,userData[key]);
                        break;
                     default:
                        _log.warn("Trying to set " + key + " on " + target + " (data from themeData [" + forceThemeDataId + "]) but it is not supported through JSon file");
                        continue;
                  }
                  wantedThemeData[key] = value;
                  target[key] = wantedThemeData[key];
               }
            }
         }
         return true;
      }
      
      public function clearThemeData() : void
      {
         this._themeDataCache = new Dictionary();
         this._currentTheme.data = null;
      }
      
      public function deleteTheme(name:String) : void
      {
         delete this._themes[name];
         this._themeNames.splice(this._themeNames.indexOf(name),1);
      }
      
      private function setMembers(value:Object, userData:Object) : void
      {
         var rectKey:String = null;
         if(!value)
         {
            return;
         }
         for(rectKey in userData)
         {
            if(Object(value).hasOwnProperty(rectKey))
            {
               try
               {
                  if(userData[rectKey] is Boolean)
                  {
                     value[rectKey] = userData[rectKey];
                  }
                  else
                  {
                     value[rectKey] = parseFloat(LangManager.getInstance().replaceKey(userData[rectKey]));
                     value[rectKey] = !!isNaN(value[rectKey]) ? 0 : value[rectKey];
                  }
               }
               catch(e:Error)
               {
                  _log.error(e.toString());
                  continue;
               }
            }
         }
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void
      {
         var f:File = null;
         _log.error("Cannot load " + e.uri + "(" + e.errorMsg + ")");
         if(e.uri.fileType.toLowerCase() == "json")
         {
            return;
         }
         var path:String = e.uri.toString();
         try
         {
            f = e.uri.toFile();
            path += "(" + f.nativePath + ")";
         }
         catch(e:Error)
         {
         }
         ErrorManager.addError("Cannot load " + path);
         Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(e.uri.fileName));
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void
      {
         var res:Object = null;
         var dataKey:* = null;
         switch(e.uri.fileType.toLowerCase())
         {
            case "dt":
               this.onDTLoad(e);
               break;
            case "json":
               if(!this._currentTheme.data)
               {
                  this._themeDataCache = new Dictionary();
                  this._currentTheme.data = e.resource;
               }
               else
               {
                  res = e.resource;
                  for(dataKey in res)
                  {
                     if(this._currentTheme.data[dataKey])
                     {
                        _log.warn("Overwriting property " + dataKey + " in themeData with values from " + e.uri.fileName);
                     }
                     this._currentTheme.data[dataKey] = res[dataKey];
                  }
               }
         }
      }
      
      private function onDTLoad(e:ResourceLoadedEvent) : void
      {
         var dt:XML = e.resource as XML;
         var dtFileName:String = e.uri.fileName.split(".")[0];
         var folder:Array = e.uri.path.split("/");
         var folderName:String = folder[folder.length - 2];
         var folderFullPath:String = e.uri.path.slice(0,e.uri.path.lastIndexOf("/") + 1);
         this.loadDT(dt,dtFileName,folderName,folderFullPath);
      }
      
      private function loadDT(dt:XML, dtFileName:String, folderName:String, folderFullPath:String) : void
      {
         var version:Array = null;
         var dofusVersion:Array = null;
         ++this._themeCount;
         var thName:String = dt.name;
         var thDesc:String = dt.description;
         var f1:File = new File(this._officialThemesPath);
         var f2:File = new File(folderFullPath);
         var official:* = f2.nativePath.indexOf(f1.nativePath) != -1;
         var skinType:uint = !!official ? uint(parseInt(dt.skinType)) : uint(1);
         var thAuthor:String = !!dt.author ? dt.author : "";
         var creationDate:String = !!dt.creationDate ? dt.creationDate : "";
         var modificationDate:String = !!dt.modificationDate ? dt.modificationDate : "";
         if(dt.version && dt.version.toString().indexOf(".") != -1)
         {
            version = String(dt.version).split(".");
            version = version.length > 3 ? version.slice(0,3) : version;
            while(version.length < 3)
            {
               version.push(0);
            }
         }
         else
         {
            version = ["0","0","0"];
         }
         if(dt.dofusVersion && dt.dofusVersion.toString().indexOf(".") != -1)
         {
            dofusVersion = String(dt.dofusVersion).split(".");
            dofusVersion = dofusVersion.length > 3 ? dofusVersion.slice(0,3) : dofusVersion;
            while(dofusVersion.length < 3)
            {
               dofusVersion.push(0);
            }
         }
         else
         {
            dofusVersion = ["0","0","0"];
         }
         var themeId:String = !!official ? f2.name : folderFullPath;
         var th:Theme = new Theme(themeId,dtFileName,folderFullPath,thName,thAuthor,thDesc,dt.previewUri,skinType,official,version,dofusVersion,creationDate,modificationDate);
         this._themes[themeId] = th;
         this._themeNames.push(themeId);
         if(this._applyWaiting && this._applyWaiting != "")
         {
            this.applyTheme(this._applyWaiting);
         }
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,1);
         Berilia.getInstance().handler.process(new ThemeLoadedMessage(folderName));
      }
      
      private function searchDtFile(rootPath:File) : File
      {
         var file:File = null;
         var dt:File = null;
         if(rootPath.nativePath.indexOf(".svn") != -1)
         {
            return null;
         }
         var files:Array = rootPath.getDirectoryListing();
         for each(file in files)
         {
            if(!file.isDirectory && file.extension.toLowerCase() == "dt")
            {
               return file;
            }
         }
         for each(file in files)
         {
            if(file.isDirectory)
            {
               dt = this.searchDtFile(file);
               if(dt)
               {
                  break;
               }
            }
         }
         return dt;
      }
   }
}
