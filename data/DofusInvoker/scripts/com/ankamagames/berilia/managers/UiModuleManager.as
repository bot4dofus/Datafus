package com.ankamagames.berilia.managers
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.berilia.components.TextureBase;
   import com.ankamagames.berilia.types.data.PreCompiledUiModule;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiGroup;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.ParsingErrorEvent;
   import com.ankamagames.berilia.types.event.ParsorEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.berilia.types.messages.AllUiXmlParsedMessage;
   import com.ankamagames.berilia.types.messages.ModuleLoadedMessage;
   import com.ankamagames.berilia.types.messages.ModuleRessourceLoadFailedMessage;
   import com.ankamagames.berilia.types.messages.UiXmlParsedErrorMessage;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.types.shortcut.ShortcutCategory;
   import com.ankamagames.berilia.uiRender.XmlParsor;
   import com.ankamagames.berilia.utils.ModProtocol;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.impl.TxtAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import flash.filesystem.File;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class UiModuleManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModuleManager));
      
      private static const _lastModulesToUnload:Array = ["Ankama_GameUiCore","Ankama_Common","Ankama_Tooltips","Ankama_ContextMenu"];
      
      private static const _regImport:RegExp = /<Import *url *= *"([^"]*)/g;
      
      private static var _self:UiModuleManager;
       
      
      private var _loader:IResourceLoader;
      
      private var _uiFilesLoader:IResourceLoader;
      
      private var _scriptNum:int;
      
      private var _moduleCount:uint = 0;
      
      private var _modulesRoot:File;
      
      private var _modulesPaths:Dictionary;
      
      private var _resetState:Boolean;
      
      private var _shortcutsLoadedCallback:Dictionary;
      
      private var _modules:Dictionary;
      
      private var _disabledModules:Dictionary;
      
      private var _unInitializedModules:Vector.<UiModule>;
      
      private var _uiFilesToLoad:Vector.<Uri>;
      
      private var _uiFilesLoaded:Vector.<String>;
      
      private var _remainingUiFilesToLoad:int;
      
      private var _unparsedXml:Vector.<UiData>;
      
      private var _xmlFilesToParse:Dictionary;
      
      private var _remainingXmlFilesToParse:int;
      
      public var isDevMode:Boolean = false;
      
      private var _uiModulesScripts:Dictionary;
      
      private var _everyModuleNames:Vector.<String>;
      
      public function UiModuleManager()
      {
         this._shortcutsLoadedCallback = new Dictionary();
         this._uiFilesLoaded = new Vector.<String>();
         this._unparsedXml = new Vector.<UiData>();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError,false,0,true);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad,false,0,true);
         this._uiFilesLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._uiFilesLoader.addEventListener(ResourceErrorEvent.ERROR,this.onUiLoadError,false,0,true);
         this._uiFilesLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onUiLoaded,false,0,true);
      }
      
      public static function getInstance() : UiModuleManager
      {
         if(!_self)
         {
            _self = new UiModuleManager();
         }
         return _self;
      }
      
      public function set uiModulesScripts(v:Dictionary) : void
      {
         this._uiModulesScripts = v;
      }
      
      public function get resetting() : Boolean
      {
         return this._resetState;
      }
      
      public function get moduleCount() : uint
      {
         return this._moduleCount;
      }
      
      public function get ready() : Boolean
      {
         return this._moduleCount > 0;
      }
      
      public function get disabledModules() : Dictionary
      {
         return this._disabledModules;
      }
      
      public function init(filter:Array, filterInclude:Boolean) : void
      {
         var modName:String = null;
         var uiRoot:String = null;
         var file:File = null;
         if(this._uiModulesScripts == null)
         {
            ErrorManager.addError("Property \'_uiModulesScripts\' of UiModuleManager must be set before calling init method");
         }
         if(this._everyModuleNames == null)
         {
            this._everyModuleNames = new Vector.<String>();
            uiRoot = LangManager.getInstance().getEntry("config.mod.path");
            if(uiRoot.substr(0,2) != "\\\\" && uiRoot.substr(1,2) != ":/")
            {
               this._modulesRoot = new File(File.applicationDirectory.nativePath + File.separator + uiRoot);
            }
            else
            {
               this._modulesRoot = new File(uiRoot);
            }
            if(this._modulesRoot.exists)
            {
               for each(file in this._modulesRoot.getDirectoryListing())
               {
                  if(!(file.isDirectory && !this._uiModulesScripts[file.name]))
                  {
                     if(file.isDirectory && file.name.charAt(0) != ".")
                     {
                        this._everyModuleNames.push(file.name);
                     }
                  }
               }
            }
            else
            {
               ErrorManager.addError("Impossible de trouver le dossier contenant les modules (url: " + LangManager.getInstance().getEntry("config.mod.path") + ")");
            }
         }
         ProtocolFactory.addProtocol("mod",ModProtocol);
         BindsManager.getInstance().initialize();
         this._resetState = false;
         this._unInitializedModules = new Vector.<UiModule>();
         this._uiFilesToLoad = new Vector.<Uri>();
         this._xmlFilesToParse = new Dictionary();
         this._modules = new Dictionary();
         if(this._modulesPaths == null)
         {
            this._modulesPaths = new Dictionary();
         }
         if(this._disabledModules == null)
         {
            this._disabledModules = new Dictionary();
         }
         this._scriptNum = 0;
         this._remainingUiFilesToLoad = 0;
         this._remainingXmlFilesToParse = 0;
         if(filterInclude)
         {
            this._scriptNum = filter.length;
            this._moduleCount = filter.length;
            for each(modName in filter)
            {
               this.loadModule(modName);
            }
         }
         else
         {
            this._scriptNum = this._everyModuleNames.length - filter.length;
            this._moduleCount = this._everyModuleNames.length - filter.length;
            for each(modName in this._everyModuleNames)
            {
               if(filter.indexOf(modName) == -1)
               {
                  this.loadModule(modName);
               }
            }
         }
      }
      
      public function lightInit(moduleList:Vector.<UiModule>) : void
      {
         var m:UiModule = null;
         this._resetState = false;
         this._modules = new Dictionary();
         this._modulesPaths = new Dictionary();
         for each(m in moduleList)
         {
            this._modules[m.id] = m;
            this._modulesPaths[m.id] = m.rootPath;
         }
      }
      
      public function getModules() : Dictionary
      {
         return this._modules;
      }
      
      public function getModule(name:String) : UiModule
      {
         if(this._modules != null && this._modules[name])
         {
            return this._modules[name];
         }
         if(this._disabledModules != null && this._disabledModules[name])
         {
            return this._disabledModules[name];
         }
         return null;
      }
      
      public function getModulePath(moduleName:String) : String
      {
         return this._modulesPaths[moduleName];
      }
      
      public function reset() : void
      {
         var module:UiModule = null;
         var i:int = 0;
         _log.warn("Reset des modules");
         this._resetState = true;
         if(this._loader)
         {
            this._loader.cancel();
         }
         if(this._uiFilesLoader)
         {
            this._uiFilesLoader.cancel();
         }
         TooltipManager.clearCache();
         for each(module in this._modules)
         {
            if(_lastModulesToUnload.indexOf(module.id) == -1)
            {
               this.unloadModule(module.id);
            }
         }
         for(i = 0; i < _lastModulesToUnload.length; i++)
         {
            if(this._modules[_lastModulesToUnload[i]])
            {
               this.unloadModule(_lastModulesToUnload[i]);
            }
         }
         Shortcut.reset();
         Berilia.getInstance().reset();
         Berilia.getInstance().init(Berilia.getInstance().docMain,Berilia.getInstance().applicationVersion);
         ApiBinder.reset();
         UiPerformanceManager.getInstance().reset();
         TextureBase.clearCache();
         KernelEventsManager.getInstance().initialize();
         this._modules = new Dictionary();
         this._unInitializedModules = new Vector.<UiModule>();
         this._uiFilesToLoad = new Vector.<Uri>();
         this._xmlFilesToParse = new Dictionary();
         this._scriptNum = 0;
         this._moduleCount = 0;
         this._remainingUiFilesToLoad = 0;
         this._remainingXmlFilesToParse = 0;
      }
      
      public function loadModule(id:String) : void
      {
         var dmFile:File = null;
         var uri:Uri = null;
         var modulePath:String = null;
         var len:int = 0;
         var substr:String = null;
         if(this._modules[id] != null)
         {
            this.unloadModule(id);
         }
         if(this._disabledModules[id] != null)
         {
            this.reenableModule(id);
            return;
         }
         var targetedModuleFolder:File = this._modulesRoot.resolvePath(id);
         if(targetedModuleFolder.exists)
         {
            dmFile = this.searchDmOrD2uiFile(targetedModuleFolder);
            if(dmFile)
            {
               if(dmFile.nativePath.indexOf("app:/") == 0)
               {
                  len = "app:/".length;
                  substr = dmFile.nativePath.substring(len,dmFile.url.length);
                  uri = new Uri(substr);
                  modulePath = substr.substr(0,substr.lastIndexOf("/"));
               }
               else
               {
                  uri = new Uri(dmFile.nativePath);
                  modulePath = dmFile.parent.nativePath;
               }
               uri.tag = dmFile;
               this._modulesPaths[id] = modulePath;
               this._loader.load(uri);
            }
            else
            {
               _log.error("Cannot found .dm or .d2ui file in " + targetedModuleFolder.url);
            }
         }
      }
      
      public function unloadModule(id:String) : void
      {
         var uiCtr:UiRootContainer = null;
         var ui:String = null;
         var group:UiGroup = null;
         if(this._modules == null)
         {
            return;
         }
         var m:UiModule = this._modules[id];
         if(!m)
         {
            return;
         }
         var moduleUiInstances:Vector.<String> = new Vector.<String>();
         for each(uiCtr in Berilia.getInstance().uiList)
         {
            if(uiCtr.uiModule == m)
            {
               moduleUiInstances.push(uiCtr.name);
            }
         }
         for each(ui in moduleUiInstances)
         {
            Berilia.getInstance().unloadUi(ui);
         }
         for each(group in m.groups)
         {
            UiGroupManager.getInstance().removeGroup(group.name);
         }
         if(m.mainClass && m.mainClass.hasOwnProperty("unload"))
         {
            m.mainClass["unload"]();
         }
         BindsManager.getInstance().removeAllEventListeners("__module_" + m.id);
         KernelEventsManager.getInstance().removeAllEventListeners("__module_" + m.id);
         delete this._modules[id];
         this._disabledModules[id] = m;
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void
      {
         if(this._resetState)
         {
            return;
         }
         switch(e.uri.fileType.toLowerCase())
         {
            case "d2ui":
            case "dm":
               this.onDMOrD2UILoad(e);
               break;
            case "xml":
               this.onShortcutLoad(e);
         }
      }
      
      private function launchModules() : void
      {
         var m:UiModule = null;
         BindsManager.getInstance().checkBinds();
         Berilia.getInstance().handler.process(new AllUiXmlParsedMessage());
         for each(m in this._unInitializedModules)
         {
            ApiBinder.addApiData("currentUi",null);
            ApiBinder.initApi(m.mainClass,m);
            if(m.mainClass)
            {
               ErrorManager.tryFunction(m.mainClass.main,null,"Une erreur est survenue lors de l\'appel à la fonction main() du module " + m.id);
            }
            else
            {
               _log.error("Impossible d\'instancier la classe principale du module " + m.id);
            }
         }
         this._unInitializedModules = new Vector.<UiModule>();
         Berilia.getInstance().handler.process(new AllModulesLoadedMessage());
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void
      {
         _log.error("onLoadError() - " + e.errorMsg);
         if(e.uri.fileType.toLowerCase() != "metas")
         {
            Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag,e.uri));
            ErrorManager.addError("Impossible de charger le fichier " + e.uri + " (" + e.errorMsg + ")");
         }
      }
      
      private function onDMOrD2UILoad(e:ResourceLoadedEvent) : void
      {
         var um:UiModule = null;
         var scriptClass:Class = null;
         var shortcutsUri:Uri = null;
         var ui:UiData = null;
         var uiUri:Uri = null;
         _log.warn("Start load of module : " + e.uri.fileName);
         if(e.resourceType == ResourceType.RESOURCE_XML)
         {
            um = UiModule.createFromXml(e.resource as XML,FileUtils.getFilePath(e.uri.path),File(e.uri.tag).parent.name);
         }
         else
         {
            um = PreCompiledUiModule.fromRaw(e.resource,FileUtils.getFilePath(e.uri.path),File(e.uri.tag).parent.name);
         }
         _log.warn("UIModule created : " + e.uri.fileName);
         this._unInitializedModules.push(um);
         scriptClass = this._uiModulesScripts[um.id];
         if(scriptClass == null)
         {
            _log.error("Script from module " + um.id + " has not been created, module failed to load");
            --this._moduleCount;
            --this._scriptNum;
            return;
         }
         if(um.shortcuts)
         {
            _log.warn("Module has shortcuts : " + e.uri.fileName);
            shortcutsUri = new Uri(um.shortcuts);
            shortcutsUri.tag = um.id;
            this._shortcutsLoadedCallback[um.id] = function(shortcutsXml:XML):void
            {
               um.shortcutsXml = shortcutsXml;
               bindModuleShortcuts(um);
               onModuleScriptLoaded(scriptClass,um);
            };
            this._loader.load(shortcutsUri);
         }
         else
         {
            this.onModuleScriptLoaded(scriptClass,um);
            _log.warn("No shortcuts for module : " + e.uri.fileName + "   loadbytes finished");
         }
         if(e.resourceType == ResourceType.RESOURCE_XML)
         {
            for each(ui in um.uis)
            {
               if(ui.file)
               {
                  uiUri = new Uri(ui.file);
                  uiUri.tag = {"mod":um.id};
                  this._uiFilesToLoad.push(uiUri);
               }
            }
         }
         _log.warn("DmOrD2UI function finished for : " + e.uri.fileName);
      }
      
      private function onModuleScriptLoaded(sc:Class, uiModule:UiModule) : void
      {
         _log.trace("Load script " + uiModule.id + ", " + (this._moduleCount - this._scriptNum + 1) + "/" + this._moduleCount);
         uiModule.scriptClass = sc;
         uiModule.bindUiClasses();
         uiModule.mainClass = new sc();
         this._modules[uiModule.id] = uiModule;
         Berilia.getInstance().handler.process(new ModuleLoadedMessage(uiModule.id));
         --this._scriptNum;
         if(this._scriptNum <= 0)
         {
            this.launchUiCheck();
         }
      }
      
      public function reenableModule(id:String) : void
      {
         var uiModule:UiModule = this._disabledModules[id];
         delete this._disabledModules[id];
         this._unInitializedModules.push(uiModule);
         if(uiModule.shortcuts)
         {
            this.bindModuleShortcuts(uiModule);
         }
         _log.trace("Reenabling module : " + id);
         this.onModuleScriptLoaded(uiModule.scriptClass,uiModule);
      }
      
      private function onUiLoaded(e:ResourceLoadedEvent) : void
      {
         var it:UiModule = null;
         var xml:String = null;
         var res:Array = null;
         var filePath:String = null;
         var modName:String = null;
         var md5:String = null;
         var templateUri:Uri = null;
         if(this._resetState)
         {
            return;
         }
         this._uiFilesToLoad.splice(this._uiFilesToLoad.indexOf(e.uri),1);
         var mod:UiModule = null;
         for each(it in this._unInitializedModules)
         {
            if(it.id == e.uri.tag.mod)
            {
               mod = it;
               break;
            }
         }
         xml = e.resource as String;
         while(res = _regImport.exec(xml))
         {
            filePath = LangManager.getInstance().replaceKey(res[1]);
            if(filePath.indexOf("mod://") != -1)
            {
               modName = filePath.substr(6,filePath.indexOf("/",6) - 6);
               filePath = this._modulesPaths[modName] + filePath.substr(6 + modName.length);
            }
            else if(filePath.indexOf(":") == -1 && filePath.indexOf("ui/Ankama_Common") == -1)
            {
               filePath = mod.rootPath + filePath;
            }
            if(this._xmlFilesToParse[e.uri.uri] == null)
            {
               md5 = MD5.hash(e.resource as String);
               if(md5 != UiRenderManager.getInstance().getUiVersion(e.uri.uri))
               {
                  this._xmlFilesToParse[e.uri.uri] = md5;
                  ++this._remainingXmlFilesToParse;
               }
            }
            if(this._uiFilesLoaded.indexOf(filePath) == -1)
            {
               this._uiFilesLoaded.push(filePath);
               ++this._remainingUiFilesToLoad;
               templateUri = new Uri(filePath);
               templateUri.tag = {
                  "mod":mod.id,
                  "template":true
               };
               this._uiFilesLoader.load(templateUri,null,TxtAdapter);
            }
         }
         --this._remainingUiFilesToLoad;
         if(this._remainingUiFilesToLoad <= 0)
         {
            this.onAllUiChecked();
         }
      }
      
      private function onUiLoadError(e:ResourceErrorEvent) : void
      {
         ErrorManager.addError("Impossible de charger le fichier d\'interface " + e.uri + " (" + e.errorMsg + ")");
         Berilia.getInstance().handler.process(new ModuleRessourceLoadFailedMessage(e.uri.tag,e.uri));
         this._uiFilesToLoad.splice(this._uiFilesToLoad.indexOf(e.uri),1);
         --this._remainingUiFilesToLoad;
      }
      
      private function onShortcutLoad(e:ResourceLoadedEvent) : void
      {
         _log.warn("onShortcutsLoad start for : " + e.uri.tag);
         var shortcutsXml:XML = e.resource;
         var callback:Function = this._shortcutsLoadedCallback[e.uri.tag];
         if(callback != null)
         {
            delete this._shortcutsLoadedCallback[e.uri.tag];
            callback(shortcutsXml);
         }
         _log.warn("onShortcutsLoad finished for : " + e.uri.tag);
      }
      
      private function bindModuleShortcuts(mod:UiModule) : void
      {
         var category:XML = null;
         var cat:ShortcutCategory = null;
         var permanent:Boolean = false;
         var visible:Boolean = false;
         var required:Boolean = false;
         var holdKeys:Boolean = false;
         var boundFeatureKeyword:String = null;
         var shortcut:XML = null;
         _log.warn("Bind module shortcuts start for : " + mod.name);
         for each(category in mod.shortcutsXml..category)
         {
            cat = ShortcutCategory.create(category.@name,LangManager.getInstance().replaceKey(category.@description));
            boundFeatureKeyword = null;
            for each(shortcut in category..shortcut)
            {
               if(!shortcut.@name || !shortcut.@name.toString().length)
               {
                  ErrorManager.addError("Le fichier de raccourci est mal formé, il manque la priopriété name dans le fichier de raccourcis de " + mod.id);
                  return;
               }
               permanent = shortcut.@permanent && shortcut.@permanent == "true";
               visible = !shortcut.@visible || shortcut.@visible != "false";
               required = shortcut.@required && shortcut.@required == "true";
               holdKeys = shortcut.@holdKeys && shortcut.@holdKeys == "true";
               boundFeatureKeyword = shortcut.@feature;
               if(!boundFeatureKeyword)
               {
                  boundFeatureKeyword = null;
               }
               new Shortcut(shortcut.@name,shortcut.@textfieldEnabled == "true",LangManager.getInstance().replaceKey(shortcut.toString()),cat,!permanent,visible,required,holdKeys,LangManager.getInstance().replaceKey(shortcut.@tooltipContent),shortcut.@admin == "true",boundFeatureKeyword);
            }
         }
         _log.warn("Bind module shortcuts finished for : " + mod.name);
      }
      
      private function launchUiCheck() : void
      {
         var uri:Uri = null;
         _log.warn("launchUiCheck start");
         this._remainingUiFilesToLoad = this._uiFilesToLoad.length;
         if(this._uiFilesToLoad.length > 0)
         {
            for each(uri in this._uiFilesToLoad)
            {
               this._uiFilesLoader.load(uri,null,TxtAdapter);
            }
         }
         else
         {
            this.onAllUiChecked();
         }
         _log.warn("launchUiCheck finished");
      }
      
      private function onAllUiChecked() : void
      {
         var module:UiModule = null;
         var urls:Array = null;
         var url:* = null;
         var ui:UiData = null;
         var uiDataList:Dictionary = new Dictionary();
         for each(module in this._unInitializedModules)
         {
            for each(ui in module.uis)
            {
               uiDataList[ui.file] = ui;
            }
         }
         urls = [];
         for(url in this._xmlFilesToParse)
         {
            urls.push(url);
         }
         EnterFrameDispatcher.worker.addForeachTreatment(this,this.clearXmlCache,[uiDataList],urls);
         EnterFrameDispatcher.worker.addSingleTreatment(this,this.parseNextXml,[this._unparsedXml]);
      }
      
      private function clearXmlCache(url:String, uiDataList:Dictionary) : void
      {
         UiRenderManager.getInstance().clearCacheFromId(url);
         UiRenderManager.getInstance().setUiVersion(url,this._xmlFilesToParse[url]);
         if(uiDataList[url])
         {
            this._unparsedXml.push(uiDataList[url]);
         }
      }
      
      private function parseNextXml(unparsedXml:Vector.<UiData>) : void
      {
         var uiData:UiData = null;
         var xmlParsor:XmlParsor = null;
         if(unparsedXml.length == 0)
         {
            this.launchModules();
         }
         else
         {
            uiData = unparsedXml.pop();
            xmlParsor = new XmlParsor();
            xmlParsor.rootPath = uiData.module.rootPath;
            xmlParsor.addEventListener(Event.COMPLETE,this.onXmlParsed,false,0,true);
            xmlParsor.addEventListener(ParsingErrorEvent.ERROR,this.onXmlParsingError);
            xmlParsor.processFile(uiData.file);
         }
      }
      
      private function onXmlParsed(e:ParsorEvent) : void
      {
         this.removeParsorListeners(e.currentTarget as XmlParsor);
         if(e.uiDefinition)
         {
            e.uiDefinition.name = XmlParsor(e.target).url;
            UiRenderManager.getInstance().setUiDefinition(e.uiDefinition);
         }
         this.parseNextXml(this._unparsedXml);
      }
      
      private function onXmlParsingError(e:ParsingErrorEvent) : void
      {
         this.removeParsorListeners(e.currentTarget as XmlParsor);
         Berilia.getInstance().handler.process(new UiXmlParsedErrorMessage(e.url,e.msg));
         this.parseNextXml(this._unparsedXml);
      }
      
      public function removeParsorListeners(parsor:XmlParsor) : void
      {
         parsor.removeEventListener(Event.COMPLETE,this.onXmlParsed);
         parsor.removeEventListener(ParsingErrorEvent.ERROR,this.onXmlParsingError);
      }
      
      private function searchDmOrD2uiFile(rootPath:File) : File
      {
         var dm:File = null;
         var file:File = null;
         var files:Array = rootPath.getDirectoryListing();
         for each(file in files)
         {
            if(!file.isDirectory && file.extension)
            {
               if(file.extension.toLowerCase() == "d2ui")
               {
                  return file;
               }
               if(!dm && file.extension.toLowerCase() == "dm")
               {
                  dm = file;
               }
            }
         }
         return dm;
      }
   }
}
