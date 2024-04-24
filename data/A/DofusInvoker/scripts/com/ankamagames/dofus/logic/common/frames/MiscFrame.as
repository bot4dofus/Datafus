package com.ankamagames.dofus.logic.common.frames
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.GoToUrlAction;
   import com.ankamagames.dofus.logic.game.common.actions.ReportPlayerAction;
   import com.ankamagames.dofus.logic.game.common.frames.HouseFrame;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.dofus.network.enums.HaapiAuthTypeEnum;
   import com.ankamagames.dofus.network.enums.HaapiSessionTypeEnum;
   import com.ankamagames.dofus.network.messages.game.approach.ServerSessionConstantsMessage;
   import com.ankamagames.dofus.network.messages.game.approach.ServerSettingsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.CurrentServerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.AccountHouseMessage;
   import com.ankamagames.dofus.network.messages.report.ReportRequestMessage;
   import com.ankamagames.dofus.network.messages.report.ReportResponseMessage;
   import com.ankamagames.dofus.network.messages.security.CheckFileMessage;
   import com.ankamagames.dofus.network.messages.security.CheckFileRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiApiKeyMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiAuthErrorMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiSessionMessage;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstant;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantInteger;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantLong;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstantString;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class MiscFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MiscFrame));
      
      private static const SERVER_CONST_TIME_BEFORE_DISCONNECTION:int = 1;
      
      private static const SERVER_CONST_KOH_DURATION:int = 2;
      
      private static const SERVER_CONST_KOH_WINNING_SCORE:int = 3;
      
      private static const SERVER_CONST_MINIMAL_TIME_BEFORE_KOH:int = 4;
      
      private static const SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH:int = 5;
      
      private static var _instance:MiscFrame;
       
      
      private var _serverSessionConstants:Dictionary;
      
      private var _stage:Stage;
      
      private var _mouseOnStage:Boolean = true;
      
      private var _serverStatus:uint;
      
      public function MiscFrame()
      {
         super();
      }
      
      public static function getInstance() : MiscFrame
      {
         return _instance;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._serverSessionConstants = new Dictionary(true);
         this._stage = StageShareManager.stage;
         this._stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         this._stage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         if(!this._mouseOnStage)
         {
            this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         }
         this._stage = null;
         return true;
      }
      
      public function getServerSessionConstant(id:int) : Object
      {
         return this._serverSessionConstants[id];
      }
      
      public function getServerStatus() : uint
      {
         return this._serverStatus;
      }
      
      public function process(msg:Message) : Boolean
      {
         var mrcMsg:MouseRightClickMessage = null;
         var current:DisplayObject = null;
         var beriliaContainer:DisplayObjectContainer = null;
         var stage:Stage = null;
         var cfrmsg:CheckFileRequestMessage = null;
         var fileStream:FileStream = null;
         var fileByte:ByteArray = null;
         var value:String = null;
         var filenameHash:String = null;
         var cfmsg:CheckFileMessage = null;
         var ssmsg:ServerSettingsMessage = null;
         var sscmsg:ServerSessionConstantsMessage = null;
         var cssum:CurrentServerStatusUpdateMessage = null;
         var ahm:AccountHouseMessage = null;
         var houseFrame:HouseFrame = null;
         var gtua:GoToUrlAction = null;
         var hsm:HaapiSessionMessage = null;
         var hakmsg:HaapiApiKeyMessage = null;
         var logStr:String = null;
         var haem:HaapiAuthErrorMessage = null;
         var rrmsg:ReportRequestMessage = null;
         var rpa:ReportPlayerAction = null;
         var mwMsg:MouseWheelMessage = null;
         var currentW:DisplayObject = null;
         var stageW:Stage = null;
         var beriliaContainerW:DisplayObjectContainer = null;
         var wheelUp:Boolean = false;
         var file:File = null;
         var constant:ServerSessionConstant = null;
         switch(true)
         {
            case msg is MouseRightClickMessage:
               mrcMsg = msg as MouseRightClickMessage;
               current = mrcMsg.target;
               beriliaContainer = Berilia.getInstance().docMain;
               stage = StageShareManager.stage;
               while(current != stage && current)
               {
                  if(beriliaContainer == current)
                  {
                     return false;
                  }
                  current = current.parent;
               }
               KernelEventsManager.getInstance().processCallback(HookList.WorldRightClick);
               return true;
            case msg is MouseWheelMessage:
               if(this._mouseOnStage)
               {
                  mwMsg = msg as MouseWheelMessage;
                  currentW = mwMsg.target;
                  stageW = StageShareManager.stage;
                  beriliaContainerW = Berilia.getInstance().docMain;
                  while(currentW != stageW && currentW)
                  {
                     if(beriliaContainerW == currentW)
                     {
                        return false;
                     }
                     currentW = currentW.parent;
                  }
                  wheelUp = false;
                  if(mwMsg.mouseEvent.delta > 0)
                  {
                     wheelUp = true;
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.WorldMouseWheel,wheelUp);
                  return true;
               }
               return false;
               break;
            case msg is CheckFileRequestMessage:
               cfrmsg = msg as CheckFileRequestMessage;
               cfrmsg.filename = cfrmsg.filename.replace(/\.\.[\/|\\]/g,"");
               fileStream = new FileStream();
               fileByte = new ByteArray();
               value = "";
               filenameHash = MD5.hash(cfrmsg.filename);
               try
               {
                  file = File.applicationDirectory;
                  if(!file || !file.exists)
                  {
                     value = "-1";
                  }
                  else
                  {
                     file = file.resolvePath(file.nativePath + File.separator + cfrmsg.filename);
                     fileStream.open(file,FileMode.READ);
                     fileStream.readBytes(fileByte);
                     fileStream.close();
                  }
               }
               catch(e:Error)
               {
                  if(e)
                  {
                     _log.error(e.getStackTrace());
                     value = "-1";
                  }
               }
               finally
               {
                  if(fileStream)
                  {
                     fileStream.close();
                  }
               }
               if(value == "")
               {
                  if(cfrmsg.type == 0)
                  {
                     value = fileByte.length.toString();
                  }
                  else if(cfrmsg.type == 1)
                  {
                     value = MD5.hash(fileByte.toString());
                  }
               }
               cfmsg = new CheckFileMessage();
               cfmsg.initCheckFileMessage(filenameHash,cfrmsg.type,value);
               ConnectionsHandler.getConnection().send(cfmsg);
               return true;
            case msg is ServerSettingsMessage:
               ssmsg = msg as ServerSettingsMessage;
               PlayerManager.getInstance().serverCommunityId = ssmsg.community;
               PlayerManager.getInstance().serverLang = ssmsg.lang;
               PlayerManager.getInstance().serverGameType = ssmsg.gameType;
               PlayerManager.getInstance().serverIsMonoAccount = ssmsg.isMonoAccount;
               PlayerManager.getInstance().arenaLeaveBanTime = ssmsg.arenaLeaveBanTime;
               PlayerManager.getInstance().hasFreeAutopilot = ssmsg.hasFreeAutopilot;
               return true;
            case msg is ServerSessionConstantsMessage:
               sscmsg = msg as ServerSessionConstantsMessage;
               this._serverSessionConstants = new Dictionary(true);
               for each(constant in sscmsg.variables)
               {
                  if(constant is ServerSessionConstantInteger)
                  {
                     this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantInteger).value;
                  }
                  else if(constant is ServerSessionConstantLong)
                  {
                     this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantLong).value;
                  }
                  else if(constant is ServerSessionConstantString)
                  {
                     this._serverSessionConstants[constant.id] = (constant as ServerSessionConstantString).value;
                  }
                  else
                  {
                     this._serverSessionConstants[constant.id] = null;
                  }
               }
               return true;
            case msg is CurrentServerStatusUpdateMessage:
               cssum = msg as CurrentServerStatusUpdateMessage;
               this._serverStatus = cssum.status;
               KernelEventsManager.getInstance().processCallback(HookList.ServerStatusUpdate,this._serverStatus);
               return true;
            case msg is AccountHouseMessage:
               ahm = msg as AccountHouseMessage;
               if(!Kernel.getWorker().getFrame(HouseFrame))
               {
                  Kernel.getWorker().addFrame(new HouseFrame());
               }
               houseFrame = Kernel.getWorker().getFrame(HouseFrame) as HouseFrame;
               if(houseFrame != null)
               {
                  houseFrame.process(msg);
               }
               return true;
            case msg is GoToUrlAction:
               gtua = msg as GoToUrlAction;
               navigateToURL(new URLRequest(gtua.url));
               return true;
            case msg is HaapiSessionMessage:
               hsm = HaapiSessionMessage(msg);
               if(hsm.type == HaapiSessionTypeEnum.HAAPI_ACCOUNT_SESSION)
               {
                  HaapiKeyManager.getInstance().saveAccountSessionId(hsm.key);
               }
               else
               {
                  if(hsm.type != HaapiSessionTypeEnum.HAAPI_GAME_SESSION)
                  {
                     return false;
                  }
                  HaapiKeyManager.getInstance().saveGameSessionId(hsm.key);
               }
               return true;
            case msg is HaapiApiKeyMessage:
               hakmsg = msg as HaapiApiKeyMessage;
               logStr = "RECEIVED API KEY : ";
               if(hakmsg != null && hakmsg.token != null && hakmsg.token.length >= 5)
               {
                  logStr += hakmsg.token.substr(0,5);
               }
               _log.debug(logStr);
               HaapiKeyManager.getInstance().saveApiKey(hakmsg.token);
               return true;
            case msg is HaapiAuthErrorMessage:
               haem = msg as HaapiAuthErrorMessage;
               _log.debug("ERROR ON ASKING API KEY type=" + haem.type + ", id=" + haem.getMessageId());
               if(haem.type == HaapiAuthTypeEnum.HAAPI_API_KEY)
               {
                  _log.error("Error during ApiKey request.");
               }
               return true;
            case msg is ReportPlayerAction:
               rrmsg = new ReportRequestMessage();
               rpa = msg as ReportPlayerAction;
               rrmsg.initReportRequestMessage(rpa.targetId,rpa.categories,rpa.description);
               ConnectionsHandler.getConnection().send(rrmsg);
               return true;
            case msg is ReportResponseMessage:
               if((msg as ReportResponseMessage).success)
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.ReportResponse,(msg as ReportResponseMessage).success);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.LOW;
      }
      
      private function onMouseLeave(e:Event) : void
      {
         this._mouseOnStage = false;
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(e:Event) : void
      {
         this._mouseOnStage = true;
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
   }
}
