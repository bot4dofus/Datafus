package com.ankamagames.dofus.logic.game.approach.frames
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.dofus.console.moduleLogger.Console;
   import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.connection.CreationCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.frames.FeatureFrame;
   import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.frames.GameStartingFrame;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeselectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRemodelSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterReplayRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignAllRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.CharacterAutoConnectAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.PopupWarningCloseRequestAction;
   import com.ankamagames.dofus.logic.game.common.frames.AdministrablePopupFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CameraControlFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.CommonUiFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ContextChangeFrame;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ExternalGameFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ForgettableSpellsUiFrame;
   import com.ankamagames.dofus.logic.game.common.frames.HouseFrame;
   import com.ankamagames.dofus.logic.game.common.frames.IdolsFrame;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.JobsFrame;
   import com.ankamagames.dofus.logic.game.common.frames.LivingObjectFrame;
   import com.ankamagames.dofus.logic.game.common.frames.MountFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ProgressionFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ProtectPishingFrame;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ScreenCaptureFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ServerTransferFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.StackManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SynchronisationFrame;
   import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
   import com.ankamagames.dofus.logic.game.common.frames.WorldFrame;
   import com.ankamagames.dofus.logic.game.common.managers.DebtManager;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.AlterationFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayIntroductionFrame;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.dofus.misc.interClient.InterClientManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.CharacterDeletionErrorEnum;
   import com.ankamagames.dofus.network.enums.CharacterRemodelingEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.messages.authorized.ConsoleCommandsListMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AccountCapabilitiesMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AlreadyConnectedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketAcceptedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketRefusedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.HelloGameMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicTimeMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterFirstSelectionMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterReplayWithRemodelRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceReadyMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectionWithRemodelMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListWithRemodelingMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCanBeCreatedRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCanBeCreatedResultMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCreationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCreationResultMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionFailureMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterNameSuggestionSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.character.deletion.CharacterDeletionErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.deletion.CharacterDeletionPrepareMessage;
   import com.ankamagames.dofus.network.messages.game.character.deletion.CharacterDeletionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.replay.CharacterReplayRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaSwitchToFightServerMessage;
   import com.ankamagames.dofus.network.messages.game.moderation.PopupWarningCloseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.moderation.PopupWarningClosedMessage;
   import com.ankamagames.dofus.network.messages.game.startup.ConsumeAllGameActionItemMessage;
   import com.ankamagames.dofus.network.messages.game.startup.ConsumeGameActionItemMessage;
   import com.ankamagames.dofus.network.messages.game.startup.GameActionItemConsumedMessage;
   import com.ankamagames.dofus.network.messages.game.startup.GameActionItemListMessage;
   import com.ankamagames.dofus.network.messages.security.ClientKeyMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterHardcoreOrEpicInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRemodelInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.RemodelingInformation;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
   import com.ankamagames.dofus.network.types.game.startup.GameActionItem;
   import com.ankamagames.dofus.scripts.api.CameraApi;
   import com.ankamagames.dofus.scripts.api.EntityApi;
   import com.ankamagames.dofus.scripts.api.ScriptSequenceApi;
   import com.ankamagames.dofus.types.data.ServerCommand;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogLogger;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.lua.LuaPlayer;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.jerakine.script.ScriptsManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import scopart.raven.RavenClient;
   
   public class GameServerApproachFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameServerApproachFrame));
      
      public static var authenticationTicketAccepted:Boolean = false;
       
      
      private const LOADING_TIMEOUT:uint = 60000.0;
      
      private var _charactersList:Vector.<BasicCharacterWrapper>;
      
      private var _charactersToRemodelList:Array;
      
      private var _kernel:KernelEventsManager;
      
      private var _gmaf:LoadingModuleFrame;
      
      private var _loadingStart:Number;
      
      private var _waitingMessages:Vector.<Message>;
      
      private var _cssmsg:CharacterSelectedSuccessMessage;
      
      private var _requestedCharacterId:Number;
      
      private var _requestedToRemodelCharacterId:Number;
      
      private var _waitingForListRefreshAfterDeletion:Boolean;
      
      private var _lc:LoaderContext;
      
      private var commonMod:Object;
      
      private var _giftList:Array;
      
      private var _charaListMinusDeadPeople:Array;
      
      private var _reconnectMsgSend:Boolean = false;
      
      public function GameServerApproachFrame()
      {
         this._charactersList = new Vector.<BasicCharacterWrapper>();
         this._charactersToRemodelList = [];
         this._kernel = KernelEventsManager.getInstance();
         this._lc = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         this._giftList = [];
         this._charaListMinusDeadPeople = [];
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get giftList() : Array
      {
         return this._giftList;
      }
      
      public function get charaListMinusDeadPeople() : Array
      {
         return this._charaListMinusDeadPeople;
      }
      
      public function get requestedCharaId() : Number
      {
         return this._requestedCharacterId;
      }
      
      public function set requestedCharaId(id:Number) : void
      {
         this._requestedCharacterId = id;
      }
      
      public function isCharacterWaitingForChange(id:Number) : Boolean
      {
         if(this._charactersToRemodelList[id])
         {
            return true;
         }
         return false;
      }
      
      public function pushed() : Boolean
      {
         SecureModeManager.getInstance().checkMigrate();
         AirScanner.allowByteCodeExecution(this._lc,true);
         Kernel.getWorker().addFrame(new MiscFrame());
         Kernel.getWorker().addFrame(new FeatureFrame());
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var perso:BasicCharacterWrapper = null;
         var characterId:Number = NaN;
         var isReplay:Boolean = false;
         var atmsg:AuthenticationTicketMessage = null;
         var atrmsg:AuthenticationTicketRefusedMessage = null;
         var scfMsg:ServerConnectionFailedMessage = null;
         var acmsg:AlreadyConnectedMessage = null;
         var clmsg:CharactersListMessage = null;
         var unusableCharacters:Vector.<Number> = null;
         var o:BasicCharacterWrapper = null;
         var unusable:Boolean = false;
         var server:Server = null;
         var bonusXp:int = 0;
         var mod:UiModule = null;
         var dst:DataStoreType = null;
         var isCharacterCreationDisplayForced:Boolean = false;
         var ccbcmsg:CharacterCanBeCreatedResultMessage = null;
         var accmsg:AccountCapabilitiesMessage = null;
         var cca:CharacterCreationAction = null;
         var ccmsg:CharacterCreationRequestMessage = null;
         var colors:Vector.<int> = null;
         var ccrmsg:CharacterCreationResultMessage = null;
         var cdpmsg:CharacterDeletionPrepareMessage = null;
         var cda:CharacterDeletionAction = null;
         var cdrmsg:CharacterDeletionRequestMessage = null;
         var cdemsg:CharacterDeletionErrorMessage = null;
         var reason:String = null;
         var cnsra:CharacterNameSuggestionRequestAction = null;
         var cnsrmsg:CharacterNameSuggestionRequestMessage = null;
         var cnssmsg:CharacterNameSuggestionSuccessMessage = null;
         var cnsfmsg:CharacterNameSuggestionFailureMessage = null;
         var crsa:CharacterRemodelSelectionAction = null;
         var remodel:RemodelingInformation = null;
         var tempColorsArray:Vector.<int> = null;
         var characterToConnect:BasicCharacterWrapper = null;
         var currentServer:Server = null;
         var bTutorial:Boolean = false;
         var cssmsg:CharacterSelectedSuccessMessage = null;
         var authenticationFrame:AuthentificationFrame = null;
         var isRelease:* = false;
         var gccrmsg:GameContextCreateRequestMessage = null;
         var soundApi:SoundApi = null;
         var devMode:* = false;
         var now:Number = NaN;
         var delta:Number = NaN;
         var csemsg:CharacterSelectedErrorMessage = null;
         var btmsg:BasicTimeMessage = null;
         var date:Date = null;
         var gailm:GameActionItemListMessage = null;
         var gar:GiftAssignRequestAction = null;
         var cgaimsg:ConsumeGameActionItemMessage = null;
         var gaara:GiftAssignAllRequestAction = null;
         var cagaimsg:ConsumeAllGameActionItemMessage = null;
         var gaicmsg:GameActionItemConsumedMessage = null;
         var indexToDelete:int = 0;
         var cclMsg:ConsoleCommandsListMessage = null;
         var stf:ServerTransferFrame = null;
         var pwcrmsg:PopupWarningCloseRequestMessage = null;
         var ccbcrm:CharacterCanBeCreatedRequestMessage = null;
         var clwrmsg:CharactersListWithRemodelingMessage = null;
         var ctri:CharacterToRemodelInformations = null;
         var chi:CharacterHardcoreOrEpicInformations = null;
         var featureManager:FeatureManager = null;
         var bonusXpFeatureActivated:Boolean = false;
         var cbi:CharacterBaseInformations = null;
         var cbi2:CharacterBaseInformations = null;
         var charToConnect:BasicCharacterWrapper = null;
         var c:* = undefined;
         var colorIndex:* = undefined;
         var colorInteger:* = 0;
         var person2:Object = null;
         var crwrrmsg:CharacterReplayWithRemodelRequestMessage = null;
         var cswrmsg:CharacterSelectionWithRemodelMessage = null;
         var charToRemodel:Object = null;
         var indexedColors:Vector.<int> = null;
         var char:CreationCharacterWrapper = null;
         var modificationModules:Array = null;
         var mandatoryModules:Array = null;
         var firstSelection:Boolean = false;
         var cfsmsg:CharacterFirstSelectionMessage = null;
         var crrmsg:CharacterReplayRequestMessage = null;
         var csmsg:CharacterSelectionMessage = null;
         var j:int = 0;
         var bchar:BasicCharacterWrapper = null;
         var flashKeyMsg:ClientKeyMessage = null;
         var fpsManagerState:uint = 0;
         var i:uint = 0;
         var luaPlayer:LuaPlayer = null;
         var tag:Object = null;
         var gift:GameActionItem = null;
         var _items:Array = null;
         var item:ObjectItemInformationWithQuantity = null;
         var oj:Object = null;
         var iw:ItemWrapper = null;
         var giftAction:Object = null;
         var cmdIndex:uint = 0;
         switch(true)
         {
            case msg is HelloGameMessage:
               ConnectionsHandler.confirmGameServerConnection();
               authenticationTicketAccepted = false;
               atmsg = new AuthenticationTicketMessage();
               atmsg.initAuthenticationTicketMessage(LangManager.getInstance().getEntry("config.lang.current"),AuthentificationManager.getInstance().gameServerTicket);
               ConnectionsHandler.getConnection().send(atmsg);
               InactivityManager.getInstance().start();
               this._kernel.processCallback(HookList.AuthenticationTicket);
               return true;
            case msg is AuthenticationTicketAcceptedMessage:
               setTimeout(this.requestCharactersList,500);
               authenticationTicketAccepted = true;
               this._kernel.processCallback(HookList.AuthenticationTicketAccepted);
               return true;
            case msg is AuthenticationTicketRefusedMessage:
               atrmsg = msg as AuthenticationTicketRefusedMessage;
               authenticationTicketAccepted = false;
               this._kernel.processCallback(HookList.AuthenticationTicketRefused);
               return true;
            case msg is ServerConnectionFailedMessage:
               scfMsg = ServerConnectionFailedMessage(msg);
               authenticationTicketAccepted = false;
               if(scfMsg.failedConnection == ConnectionsHandler.getConnection().getSubConnection(scfMsg))
               {
                  PlayerManager.getInstance().destroy();
                  this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.connexion.gameConnexionFailed"),[I18n.getUiText("ui.common.ok")],[this.onEscapePopup],this.onEscapePopup,this.onEscapePopup);
                  KernelEventsManager.getInstance().processCallback(HookList.SelectedServerFailed);
               }
               return true;
            case msg is AlreadyConnectedMessage:
               acmsg = AlreadyConnectedMessage(msg);
               PlayerManager.getInstance().wasAlreadyConnected = true;
               KernelEventsManager.getInstance().processCallback(HookList.AlreadyConnected);
               return true;
            case msg is CharactersListMessage:
               clmsg = msg as CharactersListMessage;
               if(this._waitingForListRefreshAfterDeletion)
               {
                  ccbcrm = new CharacterCanBeCreatedRequestMessage();
                  ccbcrm.initCharacterCanBeCreatedRequestMessage();
                  ConnectionsHandler.getConnection().send(ccbcrm);
                  this._waitingForListRefreshAfterDeletion = false;
               }
               unusableCharacters = new Vector.<Number>();
               if(msg is CharactersListWithRemodelingMessage)
               {
                  clwrmsg = msg as CharactersListWithRemodelingMessage;
                  for each(ctri in clwrmsg.charactersToRemodel)
                  {
                     this._charactersToRemodelList[ctri.id] = ctri;
                  }
               }
               this._charactersList = new Vector.<BasicCharacterWrapper>();
               unusable = false;
               server = PlayerManager.getInstance().server;
               bonusXp = 1;
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER) || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
               {
                  for each(chi in clmsg.characters)
                  {
                     if(unusableCharacters.indexOf(chi.id) != -1)
                     {
                        unusable = true;
                     }
                     if(chi.deathMaxLevel > chi.level)
                     {
                        bonusXp = 6;
                     }
                     else
                     {
                        bonusXp = 3;
                     }
                     o = BasicCharacterWrapper.create(chi.id,chi.name,chi.level,chi.entityLook,chi.breed,chi.sex,chi.deathState,chi.deathCount,chi.deathMaxLevel,bonusXp,unusable);
                     this._charactersList.push(o);
                  }
               }
               else
               {
                  featureManager = FeatureManager.getInstance();
                  bonusXpFeatureActivated = !featureManager || featureManager.isFeatureWithKeywordEnabled(FeatureEnum.CHARACTER_XP_BONUS_YOUNG_CHARACTERS);
                  for each(cbi in clmsg.characters)
                  {
                     bonusXp = 1;
                     if(unusableCharacters.indexOf(cbi.id) != -1)
                     {
                        unusable = true;
                     }
                     if(bonusXpFeatureActivated)
                     {
                        for each(cbi2 in clmsg.characters)
                        {
                           if(cbi2.id != cbi.id && cbi2.level > cbi.level && bonusXp < 4)
                           {
                              bonusXp++;
                           }
                        }
                     }
                     o = BasicCharacterWrapper.create(cbi.id,cbi.name,cbi.level,cbi.entityLook,cbi.breed,cbi.sex,0,0,0,bonusXp,unusable);
                     this._charactersList.push(o);
                  }
               }
               PlayerManager.getInstance().charactersList = this._charactersList;
               mod = UiModuleManager.getInstance().getModule("Ankama_Connection");
               dst = new DataStoreType("AccountModule_" + mod.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
               isCharacterCreationDisplayForced = StoreDataManager.getInstance().getData(dst,"forceCharacterCreationDisplay");
               if(this._charactersList.length && !isCharacterCreationDisplayForced)
               {
                  charToConnect = this.getCharacterToConnect();
                  if(charToConnect)
                  {
                     this.launchAutoConnect(charToConnect,server);
                  }
                  else if(!Berilia.getInstance().getUi("characterSelection"))
                  {
                     this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                  }
                  else
                  {
                     this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
                  }
               }
               else
               {
                  this._kernel.processCallback(HookList.CharacterCreationStart,[["create"],true]);
                  this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
               }
               return true;
            case msg is CharactersListErrorMessage:
               this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.connexion.charactersListError"),[I18n.getUiText("ui.common.ok")]);
               return false;
            case msg is CharacterCanBeCreatedResultMessage:
               ccbcmsg = msg as CharacterCanBeCreatedResultMessage;
               PlayerManager.getInstance().canCreateNewCharacter = ccbcmsg.yesYouCan;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterCanBeCreated);
               return true;
            case msg is AccountCapabilitiesMessage:
               accmsg = msg as AccountCapabilitiesMessage;
               this._kernel.processCallback(HookList.TutorielAvailable,accmsg.tutorialAvailable);
               PlayerManager.getInstance().adminStatus = accmsg.status;
               PlayerManager.getInstance().canCreateNewCharacter = accmsg.canCreateNewCharacter;
               KernelEventsManager.getInstance().processCallback(HookList.CharacterCreationStart,[["create"]]);
               return true;
            case msg is CharacterCreationAction:
               cca = msg as CharacterCreationAction;
               ccmsg = new CharacterCreationRequestMessage();
               colors = new Vector.<int>();
               for each(c in cca.colors)
               {
                  colors.push(c);
               }
               while(colors.length < ProtocolConstantsEnum.MAX_PLAYER_COLOR)
               {
                  colors.push(-1);
               }
               ccmsg.initCharacterCreationRequestMessage(cca.name,cca.breed,cca.sex,colors,cca.head);
               ConnectionsHandler.getConnection().send(ccmsg);
               return true;
            case msg is CharacterCreationResultMessage:
               ccrmsg = msg as CharacterCreationResultMessage;
               this._kernel.processCallback(HookList.CharacterCreationResult,ccrmsg.result,ccrmsg.reason);
               return true;
            case msg is CharacterDeletionPrepareMessage:
               cdpmsg = msg as CharacterDeletionPrepareMessage;
               this._kernel.processCallback(HookList.CharacterDeletion,cdpmsg.characterId,cdpmsg.characterName,cdpmsg.secretQuestion,cdpmsg.needSecretAnswer);
               return true;
            case msg is CharacterDeletionAction:
               cda = msg as CharacterDeletionAction;
               this._waitingForListRefreshAfterDeletion = true;
               cdrmsg = new CharacterDeletionRequestMessage();
               cdrmsg.initCharacterDeletionRequestMessage(cda.id,MD5.hash(cda.id + "~" + cda.answer));
               ConnectionsHandler.getConnection().send(cdrmsg);
               return true;
            case msg is CharacterDeletionErrorMessage:
               cdemsg = msg as CharacterDeletionErrorMessage;
               this._waitingForListRefreshAfterDeletion = false;
               reason = "";
               if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_TOO_MANY_CHAR_DELETION)
               {
                  reason = "TooManyDeletion";
               }
               else if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_BAD_SECRET_ANSWER)
               {
                  reason = "WrongAnswer";
               }
               else if(cdemsg.reason == CharacterDeletionErrorEnum.DEL_ERR_RESTRICED_ZONE)
               {
                  reason = "UnsecureMode";
               }
               this._kernel.processCallback(HookList.CharacterDeletionError,reason);
               this._requestedCharacterId = 0;
               return true;
            case msg is CharacterNameSuggestionRequestAction:
               cnsra = msg as CharacterNameSuggestionRequestAction;
               cnsrmsg = new CharacterNameSuggestionRequestMessage();
               cnsrmsg.initCharacterNameSuggestionRequestMessage();
               ConnectionsHandler.getConnection().send(cnsrmsg);
               return true;
            case msg is CharacterNameSuggestionSuccessMessage:
               cnssmsg = msg as CharacterNameSuggestionSuccessMessage;
               this._kernel.processCallback(HookList.CharacterNameSuggestioned,cnssmsg.suggestion);
               return true;
            case msg is CharacterNameSuggestionFailureMessage:
               cnsfmsg = msg as CharacterNameSuggestionFailureMessage;
               _log.error("Generation de nom impossible !");
               this._kernel.processCallback(HookList.CharacterNameSuggestioned,"");
               return true;
            case msg is CharacterSelectedForceMessage:
               if(!this._reconnectMsgSend)
               {
                  Kernel.beingInReconection = true;
                  characterId = CharacterSelectedForceMessage(msg).id;
                  this._reconnectMsgSend = true;
                  ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
               }
               return true;
            case msg is CharacterRemodelSelectionAction:
               crsa = msg as CharacterRemodelSelectionAction;
               remodel = new RemodelingInformation();
               remodel.sex = crsa.sex;
               remodel.breed = crsa.breed;
               remodel.cosmeticId = crsa.cosmeticId;
               remodel.name = crsa.name;
               tempColorsArray = new Vector.<int>();
               for(colorIndex in crsa.colors)
               {
                  colorInteger = int(crsa.colors[colorIndex]);
                  if(colorInteger >= 0)
                  {
                     colorInteger &= 16777215;
                     tempColorsArray.push(colorInteger | int(colorIndex) + 1 << 24);
                  }
               }
               remodel.colors = tempColorsArray;
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER) || PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
               {
                  for each(person2 in this._charactersList)
                  {
                     if(person2.id == this._requestedToRemodelCharacterId)
                     {
                        if(person2.deathState == 1)
                        {
                           isReplay = true;
                        }
                        else if(person2.deathState == 0)
                        {
                           isReplay = false;
                        }
                        else
                        {
                           this.commonMod.openPopup(I18n.getUiText("ui.common.error"),I18n.getUiText("ui.common.cantSelectThisCharacterLimb"),[I18n.getUiText("ui.common.ok")]);
                        }
                     }
                  }
               }
               else
               {
                  isReplay = false;
               }
               if(isReplay)
               {
                  crwrrmsg = new CharacterReplayWithRemodelRequestMessage();
                  crwrrmsg.initCharacterReplayWithRemodelRequestMessage(this._requestedToRemodelCharacterId,remodel);
                  ConnectionsHandler.getConnection().send(crwrrmsg);
               }
               else
               {
                  cswrmsg = new CharacterSelectionWithRemodelMessage();
                  cswrmsg.initCharacterSelectionWithRemodelMessage(this._requestedToRemodelCharacterId,remodel);
                  ConnectionsHandler.getConnection().send(cswrmsg);
               }
               return true;
            case msg is CharacterDeselectionAction:
               this._requestedCharacterId = 0;
               return true;
            case msg is CharacterAutoConnectAction:
               characterToConnect = this.getCharacterToConnect();
               currentServer = PlayerManager.getInstance().server;
               if(characterToConnect && currentServer)
               {
                  this.launchAutoConnect(characterToConnect,currentServer);
               }
               break;
            case msg is CharacterSelectionAction:
            case msg is CharacterReplayRequestAction:
               if(this._requestedCharacterId)
               {
                  return false;
               }
               bTutorial = false;
               if(msg is CharacterSelectionAction)
               {
                  characterId = (msg as CharacterSelectionAction).characterId;
                  bTutorial = (msg as CharacterSelectionAction).btutoriel;
                  isReplay = false;
               }
               else if(msg is CharacterReplayRequestAction)
               {
                  characterId = (msg as CharacterReplayRequestAction).characterId;
                  bTutorial = false;
                  isReplay = true;
               }
               this._requestedCharacterId = characterId;
               if(this._charactersToRemodelList[characterId])
               {
                  this._requestedToRemodelCharacterId = characterId;
                  charToRemodel = this._charactersToRemodelList[characterId];
                  indexedColors = this.getCharacterColorsInformations(charToRemodel);
                  char = CreationCharacterWrapper.create(charToRemodel.name,charToRemodel.sex,charToRemodel.breed,charToRemodel.cosmeticId,indexedColors);
                  for each(perso in this._charactersList)
                  {
                     if(perso.id == characterId)
                     {
                        char.entityLook = perso.entityLook;
                     }
                  }
                  modificationModules = [];
                  if((charToRemodel.possibleChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_BREED) > 0)
                  {
                     modificationModules.push("rebreed");
                  }
                  if((charToRemodel.possibleChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_COLORS) > 0)
                  {
                     modificationModules.push("recolor");
                  }
                  if((charToRemodel.possibleChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_COSMETIC) > 0)
                  {
                     modificationModules.push("relook");
                  }
                  if((charToRemodel.possibleChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_NAME) > 0)
                  {
                     modificationModules.push("rename");
                  }
                  if((charToRemodel.possibleChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_GENDER) > 0)
                  {
                     modificationModules.push("regender");
                  }
                  mandatoryModules = [];
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_BREED) > 0)
                  {
                     mandatoryModules.push("rebreed");
                  }
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_COLORS) > 0)
                  {
                     mandatoryModules.push("recolor");
                  }
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_COSMETIC) > 0)
                  {
                     mandatoryModules.push("relook");
                  }
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_NAME) > 0)
                  {
                     mandatoryModules.push("rename");
                  }
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_REMODELING_GENDER) > 0)
                  {
                     mandatoryModules.push("regender");
                  }
                  if((charToRemodel.mandatoryChangeMask & CharacterRemodelingEnum.CHARACTER_OPT_REMODELING_NAME) > 0)
                  {
                     modificationModules.push("rename");
                  }
                  this._kernel.processCallback(HookList.CharacterCreationStart,[modificationModules,mandatoryModules,char]);
               }
               else
               {
                  this._requestedToRemodelCharacterId = 0;
                  firstSelection = bTutorial;
                  if(bTutorial)
                  {
                     cfsmsg = new CharacterFirstSelectionMessage();
                     cfsmsg.initCharacterFirstSelectionMessage(characterId,true);
                     ConnectionsHandler.getConnection().send(cfsmsg);
                  }
                  else if(isReplay)
                  {
                     crrmsg = new CharacterReplayRequestMessage();
                     crrmsg.initCharacterReplayRequestMessage(characterId);
                     ConnectionsHandler.getConnection().send(crrmsg);
                  }
                  else
                  {
                     csmsg = new CharacterSelectionMessage();
                     csmsg.initCharacterSelectionMessage(characterId);
                     ConnectionsHandler.getConnection().send(csmsg);
                  }
               }
               return true;
               break;
            case msg is CharacterSelectedSuccessMessage:
               cssmsg = msg as CharacterSelectedSuccessMessage;
               authenticationFrame = Kernel.getWorker().getFrame(AuthentificationFrame) as AuthentificationFrame;
               if(authenticationFrame)
               {
                  Kernel.getWorker().removeFrame(authenticationFrame);
               }
               this._loadingStart = new Date().time;
               ConnectionsHandler.pause();
               if(Kernel.getWorker().getFrame(ServerSelectionFrame))
               {
                  Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(ServerSelectionFrame));
               }
               if(this._gmaf == null)
               {
                  this._gmaf = new LoadingModuleFrame();
                  Kernel.getWorker().addFrame(this._gmaf);
               }
               PlayedCharacterManager.getInstance().infos = cssmsg.infos;
               Kernel.getWorker().pause();
               this._cssmsg = cssmsg;
               UiModuleManager.getInstance().reset();
               if(PlayerManager.getInstance().hasRights)
               {
                  UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE,false);
               }
               else
               {
                  UiModuleManager.getInstance().init(Constants.PRE_GAME_MODULE.concat(Constants.ADMIN_MODULE),false);
               }
               Dofus.getInstance().renameApp(cssmsg.infos.name + " - Dofus " + BuildInfos.VERSION.toStringForAppName());
               ExternalNotificationManager.getInstance().init();
               if(cssmsg.isCollectingStats)
               {
                  StatisticsManager.getInstance().startStats("shortcuts");
               }
               else
               {
                  StatisticsManager.getInstance().quit();
               }
               if(cssmsg.infos.id == this._requestedToRemodelCharacterId)
               {
                  for(j = 0; j < this._charactersList.length; j++)
                  {
                     bchar = this._charactersList[j];
                     if(bchar.id == cssmsg.infos.id)
                     {
                        this._charactersList[j] = BasicCharacterWrapper.create(bchar.id,cssmsg.infos.name,cssmsg.infos.level,cssmsg.infos.entityLook,cssmsg.infos.breed,cssmsg.infos.sex,0,0,bchar.bonusXp);
                        break;
                     }
                  }
               }
               DebtManager.clean();
               return true;
            case msg is AllModulesLoadedMessage:
               _log.warn("GameServerApproachFrame AllModulesLoaded");
               this._gmaf = null;
               isRelease = BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE;
               LogLogger.activeLog(!isRelease || isRelease && DofusErrorHandler.debugManuallyActivated);
               Kernel.getWorker().addFrame(new WorldFrame());
               Kernel.getWorker().addFrame(new AlignmentFrame());
               Kernel.getWorker().addFrame(new SynchronisationFrame());
               Kernel.getWorker().addFrame(new LivingObjectFrame());
               Kernel.getWorker().addFrame(new AllianceFrame());
               Kernel.getWorker().addFrame(new PlayedCharacterUpdatesFrame());
               Kernel.getWorker().addFrame(new SocialFrame());
               Kernel.getWorker().addFrame(new AlterationFrame());
               Kernel.getWorker().addFrame(new SpellInventoryManagementFrame());
               Kernel.getWorker().addFrame(new InventoryManagementFrame());
               Kernel.getWorker().addFrame(new ContextChangeFrame());
               Kernel.getWorker().addFrame(new CommonUiFrame());
               Kernel.getWorker().addFrame(new ProgressionFrame());
               Kernel.getWorker().addFrame(new ChatFrame());
               Kernel.getWorker().addFrame(new JobsFrame());
               Kernel.getWorker().addFrame(new MountFrame());
               Kernel.getWorker().addFrame(new EmoticonFrame());
               Kernel.getWorker().addFrame(new QuestFrame());
               Kernel.getWorker().addFrame(new TinselFrame());
               Kernel.getWorker().addFrame(new PartyManagementFrame());
               Kernel.getWorker().addFrame(new ProtectPishingFrame());
               Kernel.getWorker().addFrame(new StackManagementFrame());
               Kernel.getWorker().addFrame(new ExternalGameFrame());
               Kernel.getWorker().addFrame(new AveragePricesFrame());
               Kernel.getWorker().addFrame(new CameraControlFrame());
               Kernel.getWorker().addFrame(new IdolsFrame());
               Kernel.getWorker().addFrame(new RoleplayIntroductionFrame());
               Kernel.getWorker().addFrame(new ScreenCaptureFrame());
               Kernel.getWorker().addFrame(new AdministrablePopupFrame());
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.FORGETTABLE_SPELLS))
               {
                  Kernel.getWorker().addFrame(new ForgettableSpellsUiFrame());
               }
               if(!Kernel.getWorker().contains(HouseFrame))
               {
                  Kernel.getWorker().addFrame(new HouseFrame());
               }
               Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(GameStartingFrame));
               Kernel.getWorker().resume();
               ConnectionsHandler.resume();
               if(Kernel.beingInReconection && !this._reconnectMsgSend)
               {
                  this._reconnectMsgSend = true;
                  ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
               }
               if(InterClientManager.getInstance().flashKey && (!PlayerManager.getInstance() || PlayerManager.getInstance().server.id != 129 && PlayerManager.getInstance().server.id != 130))
               {
                  flashKeyMsg = new ClientKeyMessage();
                  flashKeyMsg.initClientKeyMessage(InterClientManager.getInstance().flashKey);
                  ConnectionsHandler.getConnection().send(flashKeyMsg);
               }
               if(this._cssmsg != null)
               {
                  PlayedCharacterManager.getInstance().infos = this._cssmsg.infos;
               }
               Kernel.getWorker().removeFrame(this);
               if(XmlConfig.getInstance().getBooleanEntry("config.dev.mode"))
               {
                  ModuleDebugManager.display(XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.controler"));
                  Console.getInstance().display(!XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.eventUtil"));
                  ConsoleLUA.getInstance().display(!XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.luaUtil"));
                  if(XmlConfig.getInstance().getBooleanEntry("config.dev.auto.display.fpsManager"))
                  {
                     FpsManager.getInstance().display();
                     fpsManagerState = XmlConfig.getInstance().getEntry("config.dev.auto.display.fpsManager.state");
                     if(fpsManagerState)
                     {
                        for(i = 0; i < fpsManagerState; i++)
                        {
                           FpsManager.getInstance().changeState();
                        }
                     }
                  }
               }
               else
               {
                  Console.logChatMessagesOnly = true;
                  Console.getInstance().activate();
               }
               this._kernel.processCallback(HookList.GameStart);
               Kernel.getWorker().addFrame(new ServerTransferFrame());
               gccrmsg = new GameContextCreateRequestMessage();
               ConnectionsHandler.getConnection().send(gccrmsg);
               soundApi = new SoundApi();
               soundApi.stopIntroMusic();
               Shortcut.loadSavedData();
               devMode = LangManager.getInstance().getEntry("config.dev.mode") == "true";
               if(devMode)
               {
                  luaPlayer = ScriptsManager.getInstance().getPlayer(ScriptsManager.LUA_PLAYER) as LuaPlayer;
                  if(!luaPlayer)
                  {
                     luaPlayer = new LuaPlayer();
                     ScriptsManager.getInstance().addPlayer(ScriptsManager.LUA_PLAYER,luaPlayer);
                     ScriptsManager.getInstance().addPlayerApi(luaPlayer,"EntityApi",new EntityApi());
                     ScriptsManager.getInstance().addPlayerApi(luaPlayer,"SeqApi",new ScriptSequenceApi());
                     ScriptsManager.getInstance().addPlayerApi(luaPlayer,"CameraApi",new CameraApi());
                  }
               }
               if(BuildInfos.BUILD_TYPE != BuildTypeEnum.DEBUG)
               {
                  if(OptionManager.getOptionManager("dofus").getOption("optimizeMultiAccount"))
                  {
                     if(InterClientManager.isMaster())
                     {
                        new DataApi().initStaticCartographyData();
                     }
                  }
                  else
                  {
                     new DataApi().initStaticCartographyData();
                  }
               }
               now = new Date().time;
               delta = now - this._loadingStart;
               if(delta > this.LOADING_TIMEOUT)
               {
                  tag = {};
                  tag.duration = uint(delta / 1000);
                  _log.warn("Client took too long to load (" + tag.duration + "s), reporting.");
                  DofusErrorHandler.captureMessage("Client loading timeout.",tag,RavenClient.WARN);
               }
               if(!AuthentificationManager.getInstance().isAccountForced)
               {
                  ChatServiceManager.getInstance().tryToConnect();
               }
               else
               {
                  _log.info("We are currently forcing an account, so we don\'t connect to the inter-game chat.");
               }
               return true;
            case msg is ConnectionResumedMessage:
               return true;
            case msg is CharacterSelectedErrorMessage:
               csemsg = msg as CharacterSelectedErrorMessage;
               this._kernel.processCallback(HookList.CharacterImpossibleSelection,this._requestedCharacterId);
               this._requestedCharacterId = 0;
               return true;
            case msg is BasicTimeMessage:
               btmsg = msg as BasicTimeMessage;
               date = new Date();
               TimeManager.getInstance().serverTimeLag = btmsg.timestamp + btmsg.timezoneOffset * 60 * 1000 - date.getTime();
               TimeManager.getInstance().serverUtcTimeLag = btmsg.timestamp - date.getTime();
               TimeManager.getInstance().timezoneOffset = btmsg.timezoneOffset * 60 * 1000;
               TimeManager.getInstance().dofusTimeYearLag = -1370;
               return true;
            case msg is GameActionItemListMessage:
               gailm = msg as GameActionItemListMessage;
               this._giftList = [];
               for each(gift in gailm.actions)
               {
                  _items = [];
                  for each(item in gift.items)
                  {
                     iw = ItemWrapper.create(0,0,item.objectGID,item.quantity,item.effects,false);
                     _items.push(iw);
                  }
                  oj = {
                     "uid":gift.uid,
                     "title":gift.title,
                     "text":gift.text,
                     "items":_items
                  };
                  this._giftList.push(oj);
               }
               if(this._giftList.length)
               {
                  this._charaListMinusDeadPeople = [];
                  for each(perso in this._charactersList)
                  {
                     if(!perso.deathState || perso.deathState == 0)
                     {
                        this._charaListMinusDeadPeople.push(perso);
                     }
                  }
                  if(!Berilia.getInstance().getUi("characterSelection"))
                  {
                     this._kernel.processCallback(HookList.CharacterSelectionStart,this._charactersList);
                  }
                  else
                  {
                     this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
                  }
               }
               return true;
            case msg is GiftAssignRequestAction:
               gar = msg as GiftAssignRequestAction;
               cgaimsg = new ConsumeGameActionItemMessage();
               cgaimsg.initConsumeGameActionItemMessage(gar.giftId,gar.characterId);
               ConnectionsHandler.getConnection().send(cgaimsg);
               return true;
            case msg is GiftAssignAllRequestAction:
               gaara = msg as GiftAssignAllRequestAction;
               cagaimsg = new ConsumeAllGameActionItemMessage();
               cagaimsg.initConsumeAllGameActionItemMessage(gaara.characterId);
               ConnectionsHandler.getConnection().send(cagaimsg);
               return true;
            case msg is GameActionItemConsumedMessage:
               gaicmsg = msg as GameActionItemConsumedMessage;
               indexToDelete = -1;
               for each(giftAction in this._giftList)
               {
                  if(giftAction.uid == gaicmsg.actionId)
                  {
                     indexToDelete = this._giftList.indexOf(giftAction);
                     break;
                  }
               }
               if(indexToDelete > -1)
               {
                  this._giftList.splice(indexToDelete,1);
                  KernelEventsManager.getInstance().processCallback(HookList.GiftAssigned,gaicmsg.actionId);
               }
               return true;
            case msg is ConsoleCommandsListMessage:
               cclMsg = msg as ConsoleCommandsListMessage;
               for(cmdIndex = 0; cmdIndex < cclMsg.aliases.length; cmdIndex++)
               {
                  new ServerCommand(cclMsg.aliases[cmdIndex],cclMsg.descriptions[cmdIndex]);
               }
               return true;
            case msg is GameRolePlayArenaSwitchToFightServerMessage:
               if(Kernel.getWorker().contains(ServerTransferFrame))
               {
                  return false;
               }
               stf = new ServerTransferFrame();
               Kernel.getWorker().addFrame(stf);
               return stf.process(msg);
               break;
            case msg is PopupWarningClosedMessage:
               KernelEventsManager.getInstance().processCallback(HookList.PopupWarningClosed);
               return true;
            case msg is PopupWarningCloseRequestAction:
               pwcrmsg = new PopupWarningCloseRequestMessage();
               pwcrmsg.initPopupWarningCloseRequestMessage();
               ConnectionsHandler.getConnection().send(pwcrmsg);
               return true;
         }
         return false;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function getCharacterColorsInformations(ctrci:*) : Vector.<int>
      {
         var uIndexedColor:Number = NaN;
         var uIndex:int = 0;
         var uColor:* = 0;
         if(!ctrci || !ctrci.colors)
         {
            return null;
         }
         var charColors:Vector.<int> = new Vector.<int>();
         for(var ic:int = 0; ic < ProtocolConstantsEnum.MAX_PLAYER_COLOR; ic++)
         {
            charColors.push(-1);
         }
         var num:int = ctrci.colors.length;
         for(var i:int = 0; i < num; i++)
         {
            uIndexedColor = ctrci.colors[i];
            uIndex = (uIndexedColor >> 24) - 1;
            uColor = uIndexedColor & 16777215;
            if(uIndex > -1 && uIndex < charColors.length)
            {
               charColors[uIndex] = uColor;
            }
         }
         return charColors;
      }
      
      private function onEscapePopup() : void
      {
         Kernel.getInstance().reset();
      }
      
      private function requestCharactersList() : void
      {
         var clrmsg:CharactersListRequestMessage = new CharactersListRequestMessage();
         if(ConnectionsHandler && ConnectionsHandler.getConnection())
         {
            ConnectionsHandler.getConnection().send(clrmsg);
         }
      }
      
      private function getCharacterToConnect() : BasicCharacterWrapper
      {
         var charToConnect:BasicCharacterWrapper = null;
         var charToConnectSpecificallyId:Number = NaN;
         var ctc:BasicCharacterWrapper = null;
         if((Dofus.getInstance().options && Dofus.getInstance().options.getOption("autoConnectType") == 2 || PlayerManager.getInstance().autoConnectOfASpecificCharacterId > -1) && PlayerManager.getInstance().allowAutoConnectCharacter)
         {
            charToConnectSpecificallyId = PlayerManager.getInstance().autoConnectOfASpecificCharacterId;
            if(charToConnectSpecificallyId == -1)
            {
               if(this._charactersList.length <= 0)
               {
                  return null;
               }
               charToConnect = this._charactersList[0];
            }
            else
            {
               for each(ctc in this._charactersList)
               {
                  if(ctc.id == charToConnectSpecificallyId)
                  {
                     charToConnect = ctc;
                     break;
                  }
               }
            }
            return charToConnect;
         }
         return null;
      }
      
      private function launchAutoConnect(charToConnect:BasicCharacterWrapper, server:Server) : void
      {
         var updateInformationDisplayed:String = null;
         var currentVersion:String = null;
         var fakacsa:CharacterSelectionAction = null;
         if(charToConnect && ((!FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER) && server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_EPIC || charToConnect.deathState == 0) && !SecureModeManager.getInstance().active && !this.isCharacterWaitingForChange(charToConnect.id) && !PlayerManager.getInstance().wasAlreadyConnected))
         {
            this._kernel.processCallback(HookList.CharactersListUpdated,this._charactersList);
            updateInformationDisplayed = StoreDataManager.getInstance().getData(new DataStoreType("ComputerModule_Ankama_Connection",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER),"updateInformationDisplayed");
            currentVersion = BuildInfos.VERSION.major.toString() + "-" + BuildInfos.VERSION.minor.toString();
            if(updateInformationDisplayed == currentVersion)
            {
               fakacsa = new CharacterSelectionAction();
               fakacsa.btutoriel = false;
               fakacsa.characterId = charToConnect.id;
               this.process(fakacsa);
               PlayerManager.getInstance().allowAutoConnectCharacter = false;
            }
         }
      }
   }
}
