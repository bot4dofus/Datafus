package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.getQualifiedClassName;
   
   public class AppIdModifier
   {
      
      private static var _self:AppIdModifier;
      
      private static const FORCE_CPU_RENDER_MODE:String = "auto";
      
      private static const GPU_RENDER_MODE:String = "direct";
      
      private static const APP_ID_TAG:String = "id";
      
      private static const RENDER_MODE_TAG:String = "renderMode";
      
      private static const INITIAL_WINDOW_TAG:String = "initialWindow";
      
      private static const APP_ID:String = "DofusAppId" + BuildInfos.BUILD_TYPE + "_";
      
      private static const APP_INFO:String = "D2Info" + BuildInfos.BUILD_TYPE;
      
      private static var COMMON_FOLDER:String;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AppIdModifier));
       
      
      private var _currentAppId:uint;
      
      private var _renderMode:String;
      
      public function AppIdModifier()
      {
         var applicationConfig:File = null;
         var idFile:File = null;
         var newAppId:String = null;
         var tmp2:Array = null;
         var ts:Number = NaN;
         var pathSo:String = null;
         super();
         _self = this;
         if(!COMMON_FOLDER)
         {
            tmp2 = File.applicationStorageDirectory.nativePath.split(File.separator);
            tmp2.pop();
            tmp2.pop();
            COMMON_FOLDER = tmp2.join(File.separator) + File.separator;
         }
         applicationConfig = this.getFileDescriptor();
         if(!applicationConfig.exists && BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
         {
            return;
         }
         var fs:FileStream = new FileStream();
         fs.open(applicationConfig,FileMode.READ);
         var content:String = fs.readUTFBytes(fs.bytesAvailable);
         fs.close();
         var startIdTagPos:int = content.indexOf("<" + APP_ID_TAG + ">");
         var endIdTagPos:int = content.indexOf("</" + APP_ID_TAG + ">");
         if(startIdTagPos == -1 || endIdTagPos == -1)
         {
            return;
         }
         startIdTagPos = startIdTagPos + 2 + APP_ID_TAG.length;
         var currentId:String = content.substr(startIdTagPos,endIdTagPos - startIdTagPos);
         var prefix:String = "Dofus" + (BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE ? "" : "-" + BuildInfos.buildTypeName.toLowerCase());
         var tmp:Array = currentId.split(prefix + "-");
         if(!tmp[1])
         {
            this._currentAppId = 1;
         }
         else
         {
            this._currentAppId = parseInt(tmp[1],10);
         }
         var contentXml:XML = XML(content);
         var ns:Namespace = contentXml.namespace();
         var renderModeXML:XMLList = contentXml.ns::initialWindow[0].ns::renderMode;
         this._renderMode = renderModeXML.length() > 0 ? renderModeXML.text() : FORCE_CPU_RENDER_MODE;
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
         {
            return;
         }
         this.updateTs();
         var nextId:uint = 1;
         var idFileStream:FileStream = new FileStream();
         var currentTimestamp:Number = new Date().time;
         while(true)
         {
            idFile = new File(COMMON_FOLDER + APP_ID + nextId);
            if(!idFile.exists)
            {
               break;
            }
            try
            {
               idFileStream.open(idFile,FileMode.READ);
               ts = idFileStream.readDouble();
               idFileStream.close();
               if(currentTimestamp - ts > 30000)
               {
                  break;
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
         if(nextId == 1)
         {
            newAppId = prefix;
         }
         else
         {
            newAppId = prefix + "-" + nextId;
         }
         try
         {
            content = content.substr(0,startIdTagPos) + newAppId + content.substr(endIdTagPos);
            fs.open(applicationConfig,FileMode.WRITE);
            fs.writeUTFBytes(content);
            fs.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible d\'écrir le fichier " + applicationConfig.nativePath);
         }
         var soFolder:File = File.applicationStorageDirectory.resolvePath("#SharedObjects/" + FileUtils.getFileName(Dofus.getInstance().loaderInfo.loaderURL));
         var appInfoFile:File = new File(COMMON_FOLDER + APP_INFO);
         try
         {
            fs.open(new File(COMMON_FOLDER + APP_INFO),FileMode.WRITE);
            pathSo = Base64.encode(soFolder.nativePath);
            fs.writeInt(pathSo.length);
            fs.writeUTFBytes(pathSo);
            fs.writeBoolean(true);
            fs.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible d\'écrir le fichier " + applicationConfig.nativePath);
         }
         var t:BenchmarkTimer = new BenchmarkTimer(20000,0,"AppIdModifier.t");
         LogInFile.getInstance().logLine("AppIdModifier t.addEventListener updateTs",FileLoggerEnum.EVENTLISTENERS);
         t.addEventListener(TimerEvent.TIMER,this.updateTs);
         t.start();
      }
      
      public static function getInstance() : AppIdModifier
      {
         return _self;
      }
      
      private function getFileDescriptor() : File
      {
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
         {
            return new File(File.applicationDirectory.nativePath + File.separator + "dofus-client-" + BuildInfos.VERSION.toString() + "-SNAPSHOT-descriptor.xml");
         }
         return new File(File.applicationDirectory.nativePath + File.separator + "META-INF" + File.separator + "AIR" + File.separator + "application.xml");
      }
      
      public function invalideCache() : void
      {
         var pathLen:uint = 0;
         var fs:FileStream = new FileStream();
         var appInfoFile:File = new File(COMMON_FOLDER + APP_INFO);
         var lastPath:String = "";
         if(appInfoFile.exists)
         {
            fs.open(appInfoFile,FileMode.READ);
            pathLen = fs.readInt();
            lastPath = fs.readUTFBytes(pathLen);
            fs.close();
         }
         fs.open(appInfoFile,FileMode.WRITE);
         fs.writeInt(lastPath.length);
         fs.writeUTFBytes(lastPath);
         fs.writeBoolean(false);
         fs.close();
      }
      
      public function get forceCPURenderMode() : Boolean
      {
         return this._renderMode == FORCE_CPU_RENDER_MODE;
      }
      
      public function setRenderMode(forceCPU:Boolean, silent:Boolean = false) : void
      {
         var applicationConfig:File = null;
         var startTagPos:int = 0;
         var i:int = 0;
         var endTagPos:int = 0;
         var renderMode:String = !!forceCPU ? FORCE_CPU_RENDER_MODE : GPU_RENDER_MODE;
         if(this._renderMode == renderMode)
         {
            return;
         }
         applicationConfig = this.getFileDescriptor();
         if(!applicationConfig.exists && BuildInfos.BUILD_TYPE == BuildTypeEnum.DEBUG)
         {
            return;
         }
         var fs:FileStream = new FileStream();
         fs.open(applicationConfig,FileMode.READ);
         var content:String = fs.readUTFBytes(fs.bytesAvailable);
         fs.close();
         var contentXml:XML = XML(content);
         var ns:Namespace = contentXml.namespace();
         var renderModeXML:XMLList = contentXml.ns::initialWindow[0].ns::renderMode;
         if(renderModeXML.length() > 0)
         {
            i = 0;
            while(true)
            {
               startTagPos = content.indexOf("<" + RENDER_MODE_TAG + ">",i);
               if(startTagPos == -1)
               {
                  break;
               }
               endTagPos = content.indexOf("</" + RENDER_MODE_TAG + ">",i);
               startTagPos = startTagPos + 2 + RENDER_MODE_TAG.length;
               content = content.substr(0,startTagPos) + renderMode + content.substr(endTagPos);
               i = endTagPos + 3 + RENDER_MODE_TAG.length;
            }
         }
         else
         {
            startTagPos = content.indexOf("</" + INITIAL_WINDOW_TAG + ">");
            content = content.substr(0,startTagPos) + "  <renderMode>" + renderMode + "</renderMode>\n  " + content.substr(startTagPos);
         }
         try
         {
            fs.open(applicationConfig,FileMode.WRITE);
            fs.writeUTFBytes(content);
            fs.close();
            this._renderMode = renderMode;
            if(!silent)
            {
               Dofus.getInstance().reboot();
            }
         }
         catch(e:Error)
         {
            _log.error("Impossible d\'écrir le fichier " + applicationConfig.nativePath);
         }
      }
      
      private function log(txt:String) : void
      {
         var applicationConfig:File = null;
         var fs:FileStream = null;
         try
         {
            applicationConfig = new File(File.applicationDirectory.nativePath + File.separator + "logAppId.txt");
            fs = new FileStream();
            fs.open(applicationConfig,FileMode.APPEND);
            fs.writeUTFBytes("[" + this._currentAppId + "] " + txt + "\n");
            fs.close();
         }
         catch(e:Error)
         {
            _log.info("Impossible d\'écrir dans le fichier " + File.applicationDirectory.nativePath + File.separator + "logAppId.txt");
         }
      }
      
      private function updateTs(e:* = null) : void
      {
         var currentTimestamp:Number = NaN;
         var idFile:File = null;
         var idFileStream:FileStream = null;
         LogInFile.getInstance().logLine("AppIdModifier updateTs",FileLoggerEnum.EVENTLISTENERS);
         try
         {
            currentTimestamp = new Date().time;
            idFile = new File(COMMON_FOLDER + APP_ID + this._currentAppId);
            idFileStream = new FileStream();
            idFileStream.open(idFile,FileMode.WRITE);
            idFileStream.writeDouble(currentTimestamp);
            idFileStream.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible de mettre à jour le fichier " + (COMMON_FOLDER + APP_ID + _currentAppId));
         }
      }
   }
}
