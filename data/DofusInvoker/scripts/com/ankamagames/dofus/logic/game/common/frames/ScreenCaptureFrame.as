package com.ankamagames.dofus.logic.game.common.frames
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenAction;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenWithoutUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.ChangeScreenshotsDirectoryAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.CaptureApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ScreenCaptureFrame implements Frame
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ScreenCaptureFrame));
      
      private static const MIN_LEVEL_NOTIFICATION:uint = 20;
       
      
      private var _encoder:PNGEncoder2;
      
      private var _capturing:Boolean;
      
      private var _captureCount:uint = 1;
      
      private var _screenshotsChecksums:Dictionary;
      
      public function ScreenCaptureFrame()
      {
         this._screenshotsChecksums = new Dictionary();
         super();
      }
      
      public static function getDefaultDirectory() : String
      {
         var path:* = null;
         switch(SystemManager.getSingleton().os)
         {
            case OperatingSystem.WINDOWS:
            case OperatingSystem.MAC_OS:
               path = File.userDirectory.nativePath + File.separator + "Pictures";
               break;
            case OperatingSystem.LINUX:
               path = File.userDirectory.nativePath + File.separator + "Images";
         }
         var f:File = new File(path);
         if(!f.exists)
         {
            path = File.documentsDirectory.nativePath + File.separator + "Dofus" + File.separator + "screenshots";
         }
         return path;
      }
      
      public function pushed() : Boolean
      {
         var b:Bind = null;
         var captureScreenShortcutKey:String = null;
         var captureScreenWithoutUiShortcutKey:String = null;
         var notifId:uint = 0;
         PNGEncoder2.level = CompressionLevel.UNCOMPRESSED;
         if(!StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS,"screenshotNotification") && PlayedCharacterManager.getInstance().infos.level >= MIN_LEVEL_NOTIFICATION)
         {
            StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS,"screenshotNotification",true);
            b = BindsManager.getInstance().getBindFromShortcut("captureScreen");
            captureScreenShortcutKey = b && b.key ? b.toString() : Shortcut.getShortcutByName("captureScreen").defaultBind.toString();
            b = BindsManager.getInstance().getBindFromShortcut("captureScreenWithoutUI");
            captureScreenWithoutUiShortcutKey = b && b.key ? b.toString() : Shortcut.getShortcutByName("captureScreenWithoutUI").defaultBind.toString();
            notifId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.screenshot"),I18n.getUiText("ui.common.screenshot.notification",[HtmlManager.addTag(captureScreenShortcutKey,HtmlManager.SPAN,{"color":XmlConfig.getInstance().getEntry("colors.shortcut")}),HtmlManager.addTag(captureScreenWithoutUiShortcutKey,HtmlManager.SPAN,{"color":XmlConfig.getInstance().getEntry("colors.shortcut")})]),NotificationTypeEnum.TUTORIAL);
            NotificationManager.getInstance().sendNotification(notifId);
         }
         this._screenshotsChecksums = new Dictionary();
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is ChangeScreenshotsDirectoryAction:
               this.selectDirectory();
               return true;
            case msg is CaptureScreenAction:
            case msg is CaptureScreenWithoutUIAction:
               if(!this._capturing)
               {
                  this._capturing = true;
                  this.captureScreen(msg is CaptureScreenWithoutUIAction);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function getChecksum(pFileName:String) : String
      {
         return this._screenshotsChecksums[pFileName];
      }
      
      private function selectDirectory() : void
      {
         var dir:String = OptionManager.getOptionManager("dofus").getOption("screenshotsDirectory");
         if(!dir)
         {
            dir = getDefaultDirectory();
         }
         var f:File = new File(dir);
         f.addEventListener(Event.SELECT,this.onFileSelect);
         f.browseForDirectory(I18n.getUiText("ui.gameuicore.screenshot.changeDirectory"));
      }
      
      private function onSaveFile(pEvent:Event) : void
      {
         var f:File = null;
         var d:Date = null;
         var date:Array = null;
         var time:String = null;
         var fileName:* = null;
         var fs:FileStream = null;
         var screenshot:ByteArray = null;
         var lastDashIndex:int = 0;
         var newFileName:String = null;
         this._encoder.removeEventListener(Event.COMPLETE,this.onSaveFile);
         var dir:String = OptionManager.getOptionManager("dofus").getOption("screenshotsDirectory");
         if(!dir)
         {
            dir = getDefaultDirectory();
         }
         if(this.checkWritePermissions(dir))
         {
            d = new Date();
            date = TimeManager.getInstance().formatDateIRL(d.time).split("/");
            time = TimeManager.getInstance().formatClock(d.time) + ":" + (d.seconds < 10 ? "0" + d.seconds : d.seconds);
            fileName = "dofus-" + date[2] + "-" + date[1] + "-" + date[0] + "_" + time.replace(/:/g,"-") + "-" + PlayedCharacterManager.getInstance().infos.name + ".png";
            fs = new FileStream();
            f = new File(dir).resolvePath(fileName);
            if(f.exists)
            {
               ++this._captureCount;
               lastDashIndex = fileName.lastIndexOf("-");
               newFileName = fileName.substring(0,lastDashIndex) + "_" + this._captureCount + fileName.substring(lastDashIndex);
               f = new File(dir).resolvePath(newFileName);
            }
            else
            {
               this._captureCount = 1;
            }
            fs.open(f,FileMode.WRITE);
            screenshot = this._encoder.png#3;
            fs.writeBytes(screenshot);
            fs.close();
            this._screenshotsChecksums[f.name] = MD5.hashBytes(screenshot);
            this.displayChatMessage(f);
            this._capturing = false;
            PNGEncoder2.freeCachedMemory();
         }
      }
      
      private function captureScreen(pWithoutUserInterfaces:Boolean = false) : void
      {
         var screen:BitmapData = null;
         var uiList:Dictionary = null;
         var name:* = undefined;
         var adminUiVisible:Boolean = false;
         var visibleUis:Vector.<String> = null;
         if(pWithoutUserInterfaces)
         {
            if(!Atouin.getInstance().worldVisible || !Atouin.getInstance().worldIsVisible)
            {
               this._capturing = false;
               return;
            }
            uiList = Berilia.getInstance().uiList;
            visibleUis = new Vector.<String>(0);
            for(name in uiList)
            {
               if((name as String).indexOf("tooltip_entity") == -1)
               {
                  if(uiList[name].visible)
                  {
                     uiList[name].visible = false;
                     visibleUis.push(name);
                  }
               }
            }
            if(XmlConfig.getInstance().getBooleanEntry("config.dev.mode") && XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.controler"))
            {
               adminUiVisible = true;
               ModuleDebugManager.display(false);
            }
            screen = CaptureApi.getInstance().getScreen();
            for each(name in visibleUis)
            {
               uiList[name].visible = true;
            }
            if(adminUiVisible)
            {
               ModuleDebugManager.display(true);
            }
         }
         else
         {
            screen = CaptureApi.getInstance().getScreen();
         }
         this._encoder = PNGEncoder2.encodeAsync(screen);
         this._encoder.addEventListener(Event.COMPLETE,this.onSaveFile);
      }
      
      private function displayChatMessage(pFile:File) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{screenshot," + escape(pFile.nativePath) + "::" + I18n.getUiText("ui.gameuicore.screenshot",[pFile.nativePath]) + "}",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
      }
      
      private function checkWritePermissions(pPath:String) : Boolean
      {
         var success:Boolean = false;
         var fs:FileStream = null;
         var f:File = null;
         var mod:UiModule = null;
         try
         {
            fs = new FileStream();
            f = new File(pPath).resolvePath("foo.bar");
            fs.open(f,FileMode.WRITE);
            success = true;
         }
         catch(e:Error)
         {
            mod = UiModuleManager.getInstance().getModule("Ankama_Common");
            Berilia.getInstance().loadUi(mod,mod.uis["popup"],"screenshot_error_popup",{
               "title":I18n.getUiText("ui.common.error"),
               "content":I18n.getUiText("ui.gameuicore.screenshot.changeDirectory.error"),
               "buttonText":[I18n.getUiText("ui.common.ok")],
               "buttonCallback":[selectDirectory],
               "onEnterKey":selectDirectory
            },false,StrataEnum.STRATA_TOP);
         }
         if(success)
         {
            fs.close();
            f.deleteFile();
         }
         return success;
      }
      
      private function onFileSelect(pEvent:Event) : void
      {
         var f:File = pEvent.currentTarget as File;
         f.removeEventListener(Event.SELECT,this.onFileSelect);
         if(this.checkWritePermissions(f.nativePath))
         {
            OptionManager.getOptionManager("dofus").setOption("screenshotsDirectory",f.nativePath);
         }
      }
   }
}
