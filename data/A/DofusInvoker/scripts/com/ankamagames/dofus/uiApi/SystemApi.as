package com.ankamagames.dofus.uiApi
{
   import com.ankama.haapi.client.api.CharacterApi;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.DataGroundMapManager;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.zaap.ZaapApi;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkDisplayArrowManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.frames.InitializationFrame;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CameraControlFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.EntitiesTooltipsFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.misc.utils.CharacterIdConverter;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.misc.utils.GameID;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.themes.utils.ThemeInstallerFrame;
   import com.ankamagames.dofus.types.data.ServerCommand;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogLogger;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.crypto.AdvancedMd5;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.MovieClip;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   [InstanciedApi]
   public class SystemApi implements IApi
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static var _wordInteractionEnable:Boolean = true;
       
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      protected var _log:Logger;
      
      private var _characterDataStore:DataStoreType;
      
      private var _accountDataStore:DataStoreType;
      
      private var _computerDataStore:DataStoreType;
      
      private var _dofusCharacterApi:CharacterApi;
      
      private var _hooks:Dictionary;
      
      public function SystemApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(SystemApi));
         this._hooks = new Dictionary();
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static function get wordInteractionEnable() : Boolean
      {
         return _wordInteractionEnable;
      }
      
      public function enableLogs(enabled:Boolean) : void
      {
         LogLogger.activeLog(enabled);
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      [ApiData(name="currentUi")]
      public function set currentUi(value:UiRootContainer) : void
      {
         this._currentUi = value;
      }
      
      public function destroy() : void
      {
         var hookName:* = undefined;
         this._module = null;
         this._currentUi = null;
         this._characterDataStore = null;
         this._accountDataStore = null;
         this._computerDataStore = null;
         for(hookName in this._hooks)
         {
            this.removeHook(hookName);
         }
         this._hooks = new Dictionary();
      }
      
      public function isInGame() : Boolean
      {
         var worker:Worker = Kernel.getWorker();
         var authentificationFramePresent:Boolean = worker.contains(AuthentificationFrame);
         var initializationFramePresent:Boolean = worker.contains(InitializationFrame);
         var gameServerApproachFramePresent:Boolean = worker.contains(GameServerApproachFrame);
         var serverSelectionFramePresent:Boolean = worker.contains(ServerSelectionFrame);
         return !(authentificationFramePresent || initializationFramePresent || gameServerApproachFramePresent || serverSelectionFramePresent);
      }
      
      public function addHook(hookName:String, callback:Function) : void
      {
         if(!Hook.checkIfHookExists(hookName))
         {
            throw new BeriliaError("Hook [" + hookName + "] does not exists.");
         }
         var listener:GenericListener = new GenericListener(hookName,!!this._currentUi ? this._currentUi.name : "__module_" + this._module.id,callback,0,!!this._currentUi ? uint(GenericListener.LISTENER_TYPE_UI) : uint(GenericListener.LISTENER_TYPE_MODULE));
         this._hooks[hookName] = listener;
         KernelEventsManager.getInstance().registerEvent(listener);
      }
      
      public function removeHook(hookName:String) : void
      {
         if(hookName)
         {
            KernelEventsManager.getInstance().removeEventListener(this._hooks[hookName]);
            delete this._hooks[hookName];
         }
      }
      
      [NoBoxing]
      public function dispatchHook(hookName:String, ... params) : void
      {
         if(!Hook.checkIfHookExists(hookName))
         {
            throw new ApiError("Hook [" + hookName + "] does not exist");
         }
         CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(hookName).concat(params));
      }
      
      public function sendAction(action:AbstractAction) : uint
      {
         var apiAction:DofusApiAction = null;
         var classInfo:Array = getQualifiedClassName(action).split("::");
         apiAction = DofusApiAction.getApiActionByName(classInfo[classInfo.length - 1]);
         if(!apiAction)
         {
            throw new ApiError("Action [" + classInfo[classInfo.length - 1] + "] does not exist");
         }
         var actionToSend:Action = CallWithParameters.callR(apiAction.actionClass["create"],action.parameters);
         ModuleLogger.log(actionToSend);
         Kernel.getWorker().process(actionToSend);
         return 1;
      }
      
      public function log(level:uint, text:*) : void
      {
         var ui:String = !!this._currentUi ? this._currentUi.uiModule.name + "/" + this._currentUi.uiClass : "?";
         this._log.log(level,"[" + ui + "] " + text);
         if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
         {
            ModuleLogger.log("[" + ui + "] " + text,level);
         }
      }
      
      public function getClientId() : uint
      {
         return InterClientManager.getInstance().clientId;
      }
      
      public function getNumberOfClients() : uint
      {
         return InterClientManager.getInstance().numClients;
      }
      
      public function getConfigEntry(sKey:String) : *
      {
         return XmlConfig.getInstance().getEntry(sKey);
      }
      
      public function isCharacterCreationAllowed() : Boolean
      {
         return Constants.CHARACTER_CREATION_ALLOWED;
      }
      
      public function getConfigKey(key:String) : *
      {
         return XmlConfig.getInstance().getEntry("config." + key);
      }
      
      public function goToUrl(url:String) : void
      {
         if(!url)
         {
            this._log.warn("Failed to navigate to URL, no valid URL was provided.");
            return;
         }
         if(url.indexOf("[!] ") == 0)
         {
            url = url.substr(4);
         }
         navigateToURL(new URLRequest(url));
      }
      
      public function getPlayerManager() : PlayerManager
      {
         return PlayerManager.getInstance();
      }
      
      public function getTimeManager() : TimeManager
      {
         return TimeManager.getInstance();
      }
      
      public function getBuffManager() : BuffManager
      {
         return BuffManager.getInstance();
      }
      
      public function setData(name:String, value:*, dataStore:int = 2) : Boolean
      {
         var dst:DataStoreType = null;
         if(dataStore == DataStoreEnum.BIND_ACCOUNT)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else if(dataStore == DataStoreEnum.BIND_COMPUTER)
         {
            if(!this._computerDataStore)
            {
               this.initComputerDataStore();
            }
            dst = this._computerDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         return StoreDataManager.getInstance().setData(dst,name,value);
      }
      
      [NoBoxing]
      public function getData(name:String, dataStore:int = 2) : *
      {
         var dst:DataStoreType = null;
         if(dataStore == DataStoreEnum.BIND_ACCOUNT)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else if(dataStore == DataStoreEnum.BIND_COMPUTER)
         {
            if(!this._computerDataStore)
            {
               this.initComputerDataStore();
            }
            dst = this._computerDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         var value:* = StoreDataManager.getInstance().getData(dst,name);
         switch(true)
         {
            case value is IModuleUtil:
            case value is IDataCenter:
               return value;
            default:
               return value;
         }
      }
      
      public function getSetData(name:String, value:*, dataStore:int = 2) : *
      {
         var dst:DataStoreType = null;
         if(dataStore == DataStoreEnum.BIND_ACCOUNT)
         {
            if(!this._accountDataStore)
            {
               this.initAccountDataStore();
            }
            dst = this._accountDataStore;
         }
         else if(dataStore == DataStoreEnum.BIND_COMPUTER)
         {
            if(!this._computerDataStore)
            {
               this.initComputerDataStore();
            }
            dst = this._computerDataStore;
         }
         else
         {
            if(!this._characterDataStore)
            {
               this.initCharacterDataStore();
            }
            dst = this._characterDataStore;
         }
         return StoreDataManager.getInstance().getSetData(dst,name,value);
      }
      
      public function setQualityIsEnable() : Boolean
      {
         return StageShareManager.setQualityIsEnable;
      }
      
      public function getOs() : String
      {
         return SystemManager.getSingleton().os;
      }
      
      public function getOsVersion() : String
      {
         return SystemManager.getSingleton().version;
      }
      
      public function getCpu() : String
      {
         return SystemManager.getSingleton().cpu;
      }
      
      public function getOption(name:String, moduleName:String) : *
      {
         return OptionManager.getOptionManager(moduleName).getOption(name);
      }
      
      public function showWorld(b:Boolean) : void
      {
         Atouin.getInstance().showWorld(b);
      }
      
      public function worldIsVisible() : Boolean
      {
         return Atouin.getInstance().worldIsVisible;
      }
      
      public function getServerStatus() : uint
      {
         var miscframe:MiscFrame = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
         return miscframe.getServerStatus();
      }
      
      public function getConsoleAutoCompletion(cmd:String, server:Boolean) : String
      {
         if(server)
         {
            return ServerCommand.autoComplete(cmd);
         }
         return ConsolesManager.getConsole("debug").autoComplete(cmd);
      }
      
      public function getAutoCompletePossibilities(cmd:String, server:Boolean = false) : Array
      {
         if(server)
         {
            return ServerCommand.getAutoCompletePossibilities(cmd).sort();
         }
         return ConsolesManager.getConsole("debug").getAutoCompletePossibilities(cmd).sort();
      }
      
      public function getAutoCompletePossibilitiesOnParam(cmd:String, server:Boolean = false, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return ConsolesManager.getConsole("debug").getAutoCompletePossibilitiesOnParam(cmd,paramIndex,currentParams).sort();
      }
      
      public function getCmdHelp(cmd:String, server:Boolean = false) : String
      {
         if(server)
         {
            return ServerCommand.getHelp(cmd);
         }
         return ConsolesManager.getConsole("debug").getCmdHelp(cmd);
      }
      
      public function hasAdminCommand(cmd:String) : Boolean
      {
         return ServerCommand.hasCommand(cmd);
      }
      
      [NoBoxing]
      public function addEventListener(listener:Function, name:String, frameRate:uint = 25) : void
      {
         EnterFrameDispatcher.addEventListener(listener,this._module.id + ".enterframe." + name,frameRate);
      }
      
      [NoBoxing]
      public function removeEventListener(listener:Function) : void
      {
         EnterFrameDispatcher.removeEventListener(listener);
      }
      
      [NoBoxing]
      public function hasEventListener(listener:Function) : Boolean
      {
         return EnterFrameDispatcher.hasEventListener(listener);
      }
      
      public function disableWorldInteraction(pTotal:Boolean = true) : void
      {
         _wordInteractionEnable = false;
         TooltipManager.hideAll();
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(false,pTotal));
      }
      
      public function enableWorldInteraction() : void
      {
         _wordInteractionEnable = true;
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
      }
      
      public function hasWorldInteraction() : Boolean
      {
         var contextFrame:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         if(!contextFrame)
         {
            return false;
         }
         return contextFrame.hasWorldInteraction;
      }
      
      public function hasRight() : Boolean
      {
         return PlayerManager.getInstance().hasRights;
      }
      
      public function isFightContext() : Boolean
      {
         return Kernel.getWorker().contains(FightContextFrame) || Kernel.getWorker().isBeingAdded(FightContextFrame);
      }
      
      public function getEntityLookFromString(s:String) : TiphonEntityLook
      {
         return TiphonEntityLook.fromString(s);
      }
      
      public function getCurrentVersion() : Version
      {
         return BuildInfos.VERSION;
      }
      
      public function getBuildType() : uint
      {
         return BuildInfos.BUILD_TYPE;
      }
      
      public function getCurrentLanguage() : String
      {
         return XmlConfig.getInstance().getEntry("config.lang.current");
      }
      
      public function clearCache(pSelective:Boolean = false) : void
      {
         if(Kernel.getWorker().getFrame(FightContextFrame) || Kernel.getWorker().contains(FightPreparationFrame) || Kernel.getWorker().isBeingAdded(FightPreparationFrame))
         {
            return;
         }
         Dofus.getInstance().clearCache(pSelective,true);
      }
      
      public function reset() : void
      {
         Dofus.getInstance().reboot();
      }
      
      public function tryReconnectingAfterDisconnection() : Boolean
      {
         return Kernel.getInstance().tryReconnectingAfterDisconnection;
      }
      
      public function getCurrentServer() : Server
      {
         return PlayerManager.getInstance().server;
      }
      
      public function getGroundCacheSize() : Number
      {
         return DataGroundMapManager.getCurrentDiskUsed();
      }
      
      public function clearGroundCache() : void
      {
         DataGroundMapManager.clearGroundCache();
      }
      
      public function zoom(value:Number) : void
      {
         var cameraFrame:CameraControlFrame = Kernel.getWorker().getFrame(CameraControlFrame) as CameraControlFrame;
         if(cameraFrame.dragging)
         {
            return;
         }
         this.luaZoom(value);
         Atouin.getInstance().zoom(value);
      }
      
      public function getCurrentZoom() : Number
      {
         return Atouin.getInstance().currentZoom;
      }
      
      public function goToCheckLink(url:String, sender:Number, senderName:String) : void
      {
         var checkLink:* = null;
         if(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE || BuildInfos.BUILD_TYPE == BuildTypeEnum.BETA || BuildInfos.BUILD_TYPE == BuildTypeEnum.TESTING)
         {
            checkLink = I18n.getUiText("ui.link.checklink");
         }
         else
         {
            checkLink = "http://go.ankama.lan/" + this.getCurrentLanguage() + "/check";
         }
         if(url.indexOf("http://") == -1 && url.indexOf("https://") == -1)
         {
            url = "http://" + url;
         }
         var click_id:uint = PlayerManager.getInstance().accountId;
         var click_name:String = PlayedCharacterManager.getInstance().infos.name;
         var sender_id:Number = sender;
         var sender_name:String = senderName;
         var game:int = GameID.current;
         var server:int = PlayerManager.getInstance().server.id;
         this._log.debug("goToCheckLink : " + url + " " + click_id + " " + sender_id + " " + game + " " + server);
         var chaine:String = url + click_id + "" + sender_id + "" + click_name + senderName + game.toString() + server.toString();
         var keyMd5:String = AdvancedMd5.hex_hmac_md5(">:fIZ?vfU0sDM_9j",chaine);
         var jsonTab:* = "{\"url\":\"" + url + "\",\"click_account\":" + click_id + ",\"from_account\":" + sender_id + ",\"click_name\":\"" + click_name + "\",\"from_name\":\"" + sender_name + "\",\"game\":" + game + ",\"server\":" + server + ",\"hmac\":\"" + keyMd5 + "\"}";
         var bytearray:ByteArray = new ByteArray();
         bytearray.writeUTFBytes(jsonTab);
         bytearray.position = 0;
         var buffer:String = "";
         bytearray.position = 0;
         while(bytearray.bytesAvailable)
         {
            buffer += bytearray.readUnsignedByte().toString(16);
         }
         buffer = buffer.toUpperCase();
         checkLink += "?s=" + buffer;
         var ur:URLRequest = new URLRequest(checkLink);
         var params:URLVariables = new URLVariables();
         params.s = buffer;
         ur.method = URLRequestMethod.POST;
         navigateToURL(ur);
      }
      
      public function mouseZoom(zoomIn:Boolean = true) : void
      {
         var arrowPos:Point = null;
         var newPos:Point = null;
         var cameraFrame:CameraControlFrame = Kernel.getWorker().getFrame(CameraControlFrame) as CameraControlFrame;
         if(!cameraFrame || cameraFrame.dragging)
         {
            return;
         }
         var zoomLevel:Number = Atouin.getInstance().currentZoom + (!!zoomIn ? 1 : -1);
         this.luaZoom(zoomLevel);
         Atouin.getInstance().zoom(zoomLevel,Atouin.getInstance().worldContainer.mouseX,Atouin.getInstance().worldContainer.mouseY);
         var rpEntitesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(rpEntitesFrame)
         {
            rpEntitesFrame.updateAllIcons();
         }
         var entitiesTooltipsFrame:EntitiesTooltipsFrame = Kernel.getWorker().getFrame(EntitiesTooltipsFrame) as EntitiesTooltipsFrame;
         if(entitiesTooltipsFrame)
         {
            entitiesTooltipsFrame.update(true);
         }
         if(zoomLevel <= AtouinConstants.MAX_ZOOM && zoomLevel >= 1)
         {
            TooltipManager.hideAll();
         }
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.updateSwapPositionRequestsIcons();
         }
         var arrow:MovieClip = HyperlinkDisplayArrowManager.getArrowClip();
         if(arrow && HyperlinkDisplayArrowManager.getArrowStrata() != 5)
         {
            arrowPos = new Point(HyperlinkDisplayArrowManager.getArrowStartX(),HyperlinkDisplayArrowManager.getArrowStartY());
            newPos = Atouin.getInstance().rootContainer.localToGlobal(arrowPos);
            arrow.x = newPos.x;
            arrow.y = newPos.y;
         }
      }
      
      public function resetZoom() : void
      {
         Atouin.getInstance().zoom(1);
         var rpEntitesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(rpEntitesFrame)
         {
            rpEntitesFrame.updateAllIcons();
         }
         var fightPreparationFrame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(fightPreparationFrame)
         {
            fightPreparationFrame.updateSwapPositionRequestsIcons();
         }
      }
      
      public function getMaxZoom() : uint
      {
         return AtouinConstants.MAX_ZOOM;
      }
      
      public function getDirectoryContent(path:String = ".") : Array
      {
         var len:uint = 0;
         var result:Array = null;
         var folderContent:Array = null;
         var file:File = null;
         do
         {
            len = path.length;
            path = path.replace("..",".");
         }
         while(path.length != len);
         
         path = path.replace(":","");
         var folder:File = new File(unescape(this._module.rootPath.replace("file://",""))).resolvePath(path);
         if(folder.isDirectory)
         {
            result = [];
            folderContent = folder.getDirectoryListing();
            for each(file in folderContent)
            {
               result.push({
                  "name":file.name,
                  "type":(!!file.isDirectory ? "folder" : "file")
               });
            }
            return result;
         }
         return [];
      }
      
      public function isUsingZaapLogin() : Boolean
      {
         return ZaapApi.isUsingZaapLogin();
      }
      
      public function setMouseCursor(cursor:String) : void
      {
         switch(cursor)
         {
            case MouseCursor.ARROW:
            case MouseCursor.AUTO:
            case MouseCursor.BUTTON:
            case MouseCursor.HAND:
            case MouseCursor.IBEAM:
               if(Mouse.supportsCursor)
               {
                  Mouse.cursor = cursor;
               }
         }
      }
      
      public function getAccountId(playerName:String) : int
      {
         try
         {
            return AccountManager.getInstance().getAccountId(playerName);
         }
         catch(error:Error)
         {
            return 0;
         }
      }
      
      public function getAdminStatus() : int
      {
         return PlayerManager.getInstance().adminStatus;
      }
      
      public function getObjectVariables(o:Object, onlyVar:Boolean = false, useCache:Boolean = false) : Vector.<String>
      {
         return DescribeTypeCache.getVariables(o,onlyVar,useCache);
      }
      
      public function getNewDynamicSecureObject() : DynamicSecureObject
      {
         return new DynamicSecureObject();
      }
      
      public function getNickname() : String
      {
         return PlayerManager.getInstance().nickname;
      }
      
      public function getTag() : String
      {
         return PlayerManager.getInstance().tag;
      }
      
      public function copyToClipboard(val:String) : void
      {
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,val);
      }
      
      public function getLaunchArgs() : String
      {
         return CommandLineArguments.getInstance().toString();
      }
      
      public function getPartnerInfo() : String
      {
         var fs:FileStream = null;
         var content:String = null;
         var f:File = File.applicationDirectory.resolvePath("partner");
         if(f.exists)
         {
            fs = new FileStream();
            fs.open(f,FileMode.READ);
            content = fs.readUTFBytes(fs.bytesAvailable);
            fs.close();
            return content;
         }
         return "";
      }
      
      public function toggleThemeInstaller() : void
      {
         var tif:ThemeInstallerFrame = Kernel.getWorker().getFrame(ThemeInstallerFrame) as ThemeInstallerFrame;
         if(tif)
         {
            Kernel.getWorker().removeFrame(tif);
         }
         else
         {
            Kernel.getWorker().addFrame(new ThemeInstallerFrame());
         }
      }
      
      public function isKeyDown(keyCode:uint) : Boolean
      {
         return HumanInputHandler.getInstance().getKeyboardPoll().isDown(keyCode);
      }
      
      public function getGiftList() : Array
      {
         var gsapf:GameServerApproachFrame = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
         return gsapf.giftList;
      }
      
      public function getCharaListMinusDeadPeople() : Array
      {
         var gsapf:GameServerApproachFrame = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
         return gsapf.charaListMinusDeadPeople;
      }
      
      public function removeFocus() : void
      {
         StageShareManager.stage.focus = null;
      }
      
      public function getUrltoShareContent(content:Object, callback:Function, shareType:String = null) : void
      {
         if(!content || !content.hasOwnProperty("title") || !content.hasOwnProperty("description") || !content.hasOwnProperty("image"))
         {
            throw new ArgumentError("Content argument is null or missing required properties.");
         }
         if(!shareType)
         {
            var shareType:String = CharacterApi.addScreenshot_TypeEnum_DEFAULT;
         }
         HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
         {
            var apiCredentials:ApiUserCredentials = null;
            var completeFct:Function = function(e:ApiClientEvent):void
            {
               onShareUrlReady(e,callback);
            };
            var errorFct:Function = function(e:ApiClientEvent):void
            {
               onShareUrlError(e,callback);
            };
            if(!_dofusCharacterApi)
            {
               apiCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),apiKey);
               _dofusCharacterApi = new CharacterApi(apiCredentials);
            }
            _dofusCharacterApi.add_screenshot(content.image,content.title,LangManager.getInstance().getEntry("config.lang.current"),CharacterIdConverter.extractServerCharacterIdFromInterserverCharacterId(PlayedCharacterManager.getInstance().id),PlayerManager.getInstance().server.id,PlayedCharacterManager.getInstance().currentMap.mapId,content.description,shareType).onSuccess(completeFct).onError(errorFct).call();
         });
      }
      
      public function changeActiveFontType(newName:String) : void
      {
         FontManager.getInstance().activeType = newName;
      }
      
      public function getActiveFontType() : String
      {
         return FontManager.getInstance().activeType;
      }
      
      public function useCustomUISkin() : Boolean
      {
         return OptionManager.getOptionManager("dofus").getOption("currentUiSkin") != ThemeManager.OFFICIAL_THEME_NAME;
      }
      
      public function resetCustomUISkin() : void
      {
         OptionManager.getOptionManager("dofus").setOption("currentUiSkin",ThemeManager.OFFICIAL_THEME_NAME);
         Dofus.getInstance().clearCache(true,true);
      }
      
      public function startStats(pStatsName:String, ... args) : void
      {
         if(StatisticsManager.getInstance().statsEnabled)
         {
            StatisticsManager.getInstance().startStats.apply(StatisticsManager.getInstance(),[pStatsName].concat(args));
         }
      }
      
      public function removeStats(pStatsName:String) : void
      {
         if(StatisticsManager.getInstance().statsEnabled)
         {
            StatisticsManager.getInstance().removeStats(pStatsName);
         }
      }
      
      public function createCallback(fMethod:Function, ... args) : Callback
      {
         return new Callback(fMethod,args);
      }
      
      private function onShareUrlReady(e:ApiClientEvent, callback:Function) : void
      {
         var payload:Object = e.response.payload;
         if(payload && payload.hasOwnProperty("status") && payload.status)
         {
            callback(payload.url);
         }
         else
         {
            this.onShareUrlError(e,callback);
         }
      }
      
      private function onShareUrlError(e:ApiClientEvent, callback:Function) : void
      {
         this._log.error("Failed to retrieve share url!\n" + e.response.errorMessage);
         var errorMessage:String = I18n.getUiText("ui.social.share.popup.error");
         var channelId:uint = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,channelId,TimeManager.getInstance().getTimestamp());
         callback(null);
      }
      
      private function initAccountDataStore() : void
      {
         this._accountDataStore = new DataStoreType("AccountModule_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function initCharacterDataStore() : void
      {
         this._characterDataStore = new DataStoreType("Module_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
      }
      
      private function initComputerDataStore() : void
      {
         this._computerDataStore = new DataStoreType("ComputerModule_" + this._module.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
      }
      
      private function luaZoom(value:Number) : void
      {
         var lsrf:LuaScriptRecorderFrame = Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame;
         if(lsrf)
         {
            lsrf.cameraZoom(value);
         }
      }
      
      public function trimString(string:String) : String
      {
         return StringUtils.trim(string);
      }
   }
}
