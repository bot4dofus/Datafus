package com.ankamagames.dofus.themes.utils
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.ThemeInstallerSecurity;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.berilia.types.data.Theme;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ThemeInspector;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.themes.utils.actions.ThemeDeleteRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeInstallRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeListRequestAction;
   import com.ankamagames.jerakine.json.JSON;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class ThemeInstallerFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
      
      private static const _priority:int = Priority.NORMAL;
       
      
      private var _loader:IResourceLoader;
      
      private var _contextLoader:LoaderContext;
      
      private var _themeDirectory:File;
      
      private var fileCrc:CRC32;
      
      private var _fileToInstall:Vector.<ZipEntry>;
      
      private var _totalTreatedFile:int;
      
      private var _instalThemeDirectory:File;
      
      private var _currentZipFile:ZipFile;
      
      private var _currentDtData:XML;
      
      public function ThemeInstallerFrame()
      {
         this.fileCrc = new CRC32();
         super();
      }
      
      public function pushed() : Boolean
      {
         this._contextLoader = new LoaderContext();
         this._contextLoader.checkPolicyFile = true;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         var uiRoot:String = LangManager.getInstance().getEntry("config.mod.path");
         if(uiRoot.substr(0,2) != "\\\\" && uiRoot.substr(1,2) != ":/")
         {
            this._themeDirectory = new File(File.applicationStorageDirectory.nativePath + File.separator + uiRoot);
            this._themeDirectory.createDirectory();
         }
         else
         {
            this._themeDirectory = new File(uiRoot);
         }
         return true;
      }
      
      public function pulled() : Boolean
      {
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoad);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var listUri:Uri = null;
         var zipUri:Uri = null;
         switch(true)
         {
            case msg is ThemeListRequestAction:
               listUri = new Uri((msg as ThemeListRequestAction).listUrl);
               listUri.loaderContext = this._contextLoader;
               this._loader.load(listUri);
               return true;
            case msg is ThemeInstallRequestAction:
               zipUri = new Uri((msg as ThemeInstallRequestAction).url);
               zipUri.loaderContext = this._contextLoader;
               this._loader.load(zipUri);
               return true;
            case msg is ThemeDeleteRequestAction:
               this.deleteTheme(ThemeDeleteRequestAction(msg).themeDirectory);
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void
      {
         var jsonArray:* = undefined;
         var array:Array = null;
         switch(e.uri.fileType.toLowerCase())
         {
            case "json":
               if(e.resource is Array)
               {
                  jsonArray = e.resource;
               }
               else
               {
                  try
                  {
                     jsonArray = com.ankamagames.jerakine.json.JSON.decode(e.resource,true);
                  }
                  catch(error:Error)
                  {
                     _log.error("Cannot read Json " + e.uri + "(" + error.message + ")");
                  }
               }
               array = jsonArray as Array;
               if(array != null && array.length > 0 && array[0].dofusVersion != null)
               {
                  this.processJsonList(jsonArray);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ThemeList,[]);
               }
               break;
            case "zip":
               this.getZippedThemeInformations(e.resource);
               break;
            default:
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,2);
         }
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void
      {
         _log.error("Cannot load file " + e.uri + "(" + e.errorMsg + ")");
         switch(e.uri.fileType.toLowerCase())
         {
            case "json":
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,1);
               break;
            case "zip":
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,8);
               break;
            default:
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,0);
         }
      }
      
      private function processJsonList(jsonArray:*) : void
      {
         var themeEntry:* = undefined;
         var entryVersionArray:Array = null;
         var i:int = 0;
         var theme:Theme = null;
         for each(themeEntry in jsonArray)
         {
            theme = ThemeManager.getInstance().getThemeByAuthorAndName(themeEntry.author + "_" + themeEntry.name);
            if(theme)
            {
               themeEntry.exist = true;
               themeEntry.upToDate = true;
               entryVersionArray = String(themeEntry.version).split(".");
               while(theme.version.length > entryVersionArray.length)
               {
                  entryVersionArray.push(0);
               }
               for(i = 0; i < theme.version.length; i++)
               {
                  if(theme.version[i] < entryVersionArray[i])
                  {
                     themeEntry.upToDate = false;
                  }
               }
            }
            else
            {
               themeEntry.exist = false;
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ThemeList,jsonArray);
      }
      
      private function getZippedThemeInformations(zipFile:ZipFile) : void
      {
         var dtData:XML = ThemeInspector.getZipDmFile(zipFile);
         if(!dtData || !ThemeInspector.checkArchiveValidity(zipFile))
         {
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,3);
            _log.error("Theme ZIP file is missing .dt file!");
            return;
         }
         if(ThemeManager.getInstance().getThemeByAuthorAndName(dtData.author + "_" + dtData.name))
         {
            this.updateTheme(zipFile,dtData);
         }
         else
         {
            this.installTheme(zipFile,dtData);
         }
      }
      
      private function installTheme(zipFile:ZipFile, dtData:XML) : void
      {
         var entry:ZipEntry = null;
         this._currentZipFile = zipFile;
         if(!dtData || !zipFile)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
            _log.fatal("No description theme file found( DT file)");
            return;
         }
         this._instalThemeDirectory = new File(ThemeManager.getInstance().customThemesPath + dtData.author + "_" + dtData.name);
         this._instalThemeDirectory.createDirectory();
         ThemeInstallerSecurity.createSecurity(this._instalThemeDirectory);
         this._totalTreatedFile = 0;
         this._fileToInstall = new Vector.<ZipEntry>();
         for each(entry in zipFile.entries)
         {
            this._fileToInstall.push(entry);
         }
         this.processZipEntry();
      }
      
      private function processZipEntry() : void
      {
         var writeStream:FileStream = null;
         var unzipedFile:File = null;
         var unzipedData:ByteArray = null;
         var entry:ZipEntry = null;
         var startProcess:uint = getTimer();
         while(this._fileToInstall.length && getTimer() - startProcess < 16)
         {
            entry = this._fileToInstall.pop();
            ++this._totalTreatedFile;
            unzipedFile = new File(this._instalThemeDirectory.nativePath + File.separator + entry.name);
            try
            {
               if(unzipedFile.exists && !unzipedFile.isDirectory)
               {
                  unzipedFile.deleteFile();
               }
            }
            catch(e:Error)
            {
               _log.fatal("Cannot delete " + unzipedFile.nativePath + " : " + e.toString());
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
               return;
            }
            if(!(!unzipedFile.exists || unzipedFile.isDirectory))
            {
               KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
            }
            if(entry.isDirectory())
            {
               try
               {
                  unzipedFile.createDirectory();
               }
               catch(e:Error)
               {
                  _log.fatal("Cannot create directory " + unzipedFile.nativePath + " : " + e.toString());
                  KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
               }
            }
            else
            {
               try
               {
                  this.writeZipEntry(unzipedData,entry,writeStream,unzipedFile,this._currentZipFile);
               }
               catch(e:Error)
               {
                  _log.fatal("Can\'t create file " + unzipedFile.nativePath + " : " + e.toString());
                  KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
               }
            }
            continue;
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,this._totalTreatedFile / this._currentZipFile.entries.length);
            return;
         }
         if(this._fileToInstall.length)
         {
            setTimeout(this.processZipEntry,1);
         }
         else
         {
            this.finishInstall();
         }
      }
      
      private function finishInstall() : void
      {
         ThemeManager.getInstance().initTheme(this._instalThemeDirectory);
         if(this._totalTreatedFile == this._currentZipFile.entries.length)
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,1);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
            _log.fatal("Wrong extracted file, done : " + this._totalTreatedFile + ", in Zip : " + this._currentZipFile.entries.length);
         }
         this._currentDtData = null;
         this._currentZipFile = null;
         this._fileToInstall = null;
         this._totalTreatedFile = 0;
         this._instalThemeDirectory = null;
      }
      
      private function updateTheme(zipFile:ZipFile, dtData:XML) : void
      {
         var entry:ZipEntry = null;
         if(!dtData || !zipFile)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,3);
            return;
         }
         this._instalThemeDirectory = new File(ThemeManager.getInstance().customThemesPath + dtData.author + "_" + dtData.name);
         if(!this._instalThemeDirectory.exists)
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,4);
         }
         this._currentDtData = dtData;
         this._currentZipFile = zipFile;
         this._totalTreatedFile = 0;
         this._fileToInstall = new Vector.<ZipEntry>();
         for each(entry in zipFile.entries)
         {
            this._fileToInstall.push(entry);
         }
         this.processZipEntryForUpdate();
      }
      
      private function processZipEntryForUpdate() : void
      {
         var writeStream:FileStream = null;
         var readStream:FileStream = null;
         var unzipedFile:File = null;
         var unzipedData:ByteArray = null;
         var entry:ZipEntry = null;
         var buffer:ByteArray = null;
         var fileCrcValue:uint = 0;
         var startProcess:uint = getTimer();
         while(this._fileToInstall.length && getTimer() - startProcess < 16)
         {
            entry = this._fileToInstall.pop();
            ++this._totalTreatedFile;
            unzipedFile = new File(this._instalThemeDirectory.nativePath + File.separator + entry.name);
            if(!unzipedFile.exists)
            {
               if(entry.isDirectory())
               {
                  unzipedFile.createDirectory();
               }
               else
               {
                  this.writeZipEntry(unzipedData,entry,writeStream,unzipedFile,this._currentZipFile);
               }
            }
            else if(!entry.isDirectory())
            {
               buffer = new ByteArray();
               readStream = new FileStream();
               readStream.open(unzipedFile,FileMode.READ);
               readStream.readBytes(buffer,0,readStream.bytesAvailable);
               readStream.close();
               this.fileCrc.update(buffer,0,buffer.bytesAvailable);
               fileCrcValue = this.fileCrc.getValue();
               if(fileCrcValue != entry.crc)
               {
                  unzipedFile.deleteFile();
                  this.writeZipEntry(unzipedData,entry,writeStream,unzipedFile,this._currentZipFile);
               }
            }
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,this._totalTreatedFile / this._currentZipFile.entries.length);
         }
         if(this._fileToInstall.length)
         {
            setTimeout(this.processZipEntryForUpdate,1);
         }
         else
         {
            this.finishUpdate();
         }
      }
      
      private function finishUpdate() : void
      {
         var theme:Theme = null;
         var version:Array = null;
         if(this._totalTreatedFile == this._currentZipFile.entries.length)
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,1);
            theme = ThemeManager.getInstance().getThemeByAuthorAndName(this._currentDtData.author + "_" + this._currentDtData.name);
            if(theme)
            {
               version = !!this._currentDtData.version ? String(this._currentDtData.version).split(".") : new Array(0,0,0);
               version = version.length > 3 ? version.slice(0,3) : version;
               while(version.length < 3)
               {
                  version.push(0);
               }
               theme.version = version == null ? new Array(0,0,0) : version;
            }
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,3);
            _log.fatal("Wrong extracted file, done : " + this._totalTreatedFile + ", in Zip : " + this._currentZipFile.entries.length);
         }
         this._currentDtData = null;
         this._currentZipFile = null;
         this._fileToInstall = null;
         this._totalTreatedFile = 0;
         this._instalThemeDirectory = null;
      }
      
      private function writeZipEntry(unzipedData:ByteArray, entry:ZipEntry, writeStream:FileStream, unzipedFile:File, zipFile:ZipFile) : Boolean
      {
         unzipedData = zipFile.getInput(entry);
         if(!ThemeInstallerSecurity.isValidFile(unzipedFile.extension,unzipedData))
         {
            _log.error(unzipedFile.name + " is invalid! Either its size is too big or its header is not matching its extension");
            KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,6);
            return false;
         }
         writeStream = new FileStream();
         writeStream.open(unzipedFile,FileMode.WRITE);
         writeStream.writeBytes(unzipedData,0,unzipedData.bytesAvailable);
         writeStream.close();
         return true;
      }
      
      private function deleteTheme(directoryName:String) : void
      {
         var theme:Theme = null;
         var toDelete:File = new File(ThemeManager.getInstance().customThemesPath + directoryName);
         if(toDelete.exists)
         {
            toDelete.deleteDirectory(true);
            theme = ThemeManager.getInstance().getThemeByAuthorAndName(directoryName);
            if(theme && theme.folderFullPath)
            {
               ThemeManager.getInstance().deleteTheme(theme.folderFullPath);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,-1);
               return;
            }
         }
         else
         {
            toDelete = new File(directoryName);
            if(toDelete.exists)
            {
               toDelete.deleteDirectory(true);
               ThemeManager.getInstance().deleteTheme(directoryName);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ThemeInstallationProgress,-1);
               return;
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ThemeInstallationError,5);
         _log.fatal("Can\'t delete " + toDelete.nativePath);
      }
   }
}
