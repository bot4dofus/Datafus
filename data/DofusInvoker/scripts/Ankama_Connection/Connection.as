package Ankama_Connection
{
   import Ankama_Common.Common;
   import Ankama_Connection.ui.CharacterCreation;
   import Ankama_Connection.ui.CharacterHeader;
   import Ankama_Connection.ui.CharacterSelection;
   import Ankama_Connection.ui.ConnectionBackground;
   import Ankama_Connection.ui.GiftMenu;
   import Ankama_Connection.ui.Login;
   import Ankama_Connection.ui.PreGameMainMenu;
   import Ankama_Connection.ui.PseudoChoice;
   import Ankama_Connection.ui.SecretPopup;
   import Ankama_Connection.ui.ServerListSelection;
   import Ankama_Connection.ui.UpdateInformation;
   import Ankama_Connection.ui.UpdateInformationFullTemplate;
   import Ankama_Connection.ui.UpdateInformationThreeTemplate;
   import Ankama_Connection.ui.UserAgreement;
   import Ankama_Connection.ui.items.GiftCharacterSelectionItem;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.IdentificationFailureReasonEnum;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.dofus.network.types.version.Version;
   import com.ankamagames.dofus.uiApi.ConnectionApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PopupApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class Connection extends Sprite
   {
      
      public static var loginUiName:String = "login";
      
      private static var _self:Connection;
      
      public static var TUTORIAL_SELECTION:Boolean = false;
      
      public static var TUTORIAL_SELECTION_IS_AVAILABLE:Boolean = false;
      
      public static var BREEDS_AVAILABLE:int;
      
      public static var BREEDS_VISIBLE:int;
      
      private static const POPUP_SERVEUR_FUSION_ID:uint = 23;
      
      private static const POPUP_WARNING_ID:uint = 24;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Connection));
      
      public static var waitingForCreation:Boolean = false;
      
      public static var waitingForCharactersList:Boolean = false;
      
      public static var waitingForServersList:String = "";
      
      public static var loginMustBeSaved:int;
       
      
      protected var login:Login;
      
      protected var serverListSelection:ServerListSelection;
      
      protected var characterCreation:CharacterCreation;
      
      protected var characterHeader:CharacterHeader;
      
      protected var connectionBackground:ConnectionBackground;
      
      protected var characterSelection:CharacterSelection;
      
      protected var pseudoChoice:PseudoChoice;
      
      protected var preGameMainMenu:PreGameMainMenu;
      
      protected var giftMenu:GiftMenu;
      
      protected var secretPopup:SecretPopup;
      
      protected var userAgreement:UserAgreement;
      
      protected var updateInformation:UpdateInformation;
      
      protected var updateInformationFullTemplate:UpdateInformationFullTemplate;
      
      protected var updateInformationThreeTemplate:UpdateInformationThreeTemplate;
      
      protected var giftCharaSelectItem:GiftCharacterSelectionItem;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="ConnectionApi")]
      public var connecApi:ConnectionApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PopupApi")]
      public var popupApi:PopupApi;
      
      public var previousUi:String;
      
      public var currentUi:String;
      
      public var _charaList:Object;
      
      public var _serversList:Vector.<GameServerInformations>;
      
      public var _sPopup:String;
      
      public var unlocked:Boolean = false;
      
      private var _timeoutTimer:BenchmarkTimer;
      
      private var _timeoutPopupName:String;
      
      public function Connection()
      {
         super();
      }
      
      public static function getInstance() : Connection
      {
         return _self;
      }
      
      public function main() : void
      {
         this.previousUi = "";
         this.currentUi = null;
         this.sysApi.addHook(HookList.AuthentificationStart,this.onAuthentificationStart);
         this.sysApi.addHook(HookList.ServerSelectionStart,this.onServerSelectionStart);
         this.sysApi.addHook(HookList.CharacterSelectionStart,this.onCharacterSelectionStart);
         this.sysApi.addHook(HookList.CharacterCreationStart,this.onCharacterCreationStart);
         this.sysApi.addHook(HookList.ServersList,this.onServersList);
         this.sysApi.addHook(HookList.SelectedServerRefused,this.onSelectedServerRefused);
         this.sysApi.addHook(HookList.GameStart,this.onGameStart);
         this.sysApi.addHook(HookList.GiftList,this.onGiftList);
         this.sysApi.addHook(HookList.CharactersListUpdated,this.onCharactersListUpdated);
         this.sysApi.addHook(HookList.CharacterImpossibleSelection,this.onCharacterImpossibleSelection);
         this.sysApi.addHook(HookList.TutorielAvailable,this.onTutorielAvailable);
         this.sysApi.addHook(HookList.BreedsAvailable,this.onBreedsAvailable);
         this.sysApi.addHook(HookList.OpenMainMenu,this.onOpenMainMenu);
         this.sysApi.addHook(HookList.ConnectionTimerStart,this.onConnectionTimerStart);
         this.sysApi.addHook(HookList.ServerConnectionFailed,this.onServerConnectionFailed);
         this.sysApi.addHook(HookList.UnexpectedSocketClosure,this.onUnexpectedSocketClosure);
         this.sysApi.addHook(HookList.AlreadyConnected,this.onAlreadyConnected);
         this.sysApi.addHook(HookList.ZaapConnectionFailed,this.onZaapConnectionFailed);
         this.sysApi.addHook(HookList.MigratedServerList,this.onMigratedServerList);
         this.sysApi.addHook(HookList.OpenUpdateInformation,this.onOpenUpdateInformation);
         this.sysApi.addHook(HookList.LoginQueueStatus,this.removeTimer);
         this.sysApi.addHook(HookList.QueueStatus,this.removeTimer);
         this.sysApi.addHook(HookList.NicknameRegistration,this.removeTimer);
         this.sysApi.addHook(HookList.IdentificationSuccess,this.onIdentificationSuccess);
         this.sysApi.addHook(HookList.IdentificationFailed,this.onIdentificationFailed);
         this.sysApi.addHook(HookList.IdentificationFailedWithDuration,this.onIdentificationFailed);
         this.sysApi.addHook(HookList.IdentificationFailedForBadVersion,this.onIdentificationFailedForBadVersion);
         this.sysApi.addHook(HookList.AuthenticationTicketAccepted,this.onConnectionStart);
         this.sysApi.addHook(HookList.AuthenticationTicketRefused,this.removeTimer);
         this.sysApi.addHook(HookList.InformationPopup,this.onInformationPopup);
         if(this.sysApi.getConfigEntry("config.community.current") != "ja")
         {
            this.sysApi.addHook(HookList.AgreementsRequired,this.onAgreementsRequired);
         }
         this.uiApi.addShortcutHook("closeUi",this.onOpenMainMenu);
         loginMustBeSaved = this.sysApi.getData("saveLogin");
         _self = this;
      }
      
      public function unload() : void
      {
         this.removeTimer();
         _self = null;
         this._charaList = null;
         this._serversList = null;
      }
      
      public function get charactersCount() : int
      {
         if(this._charaList)
         {
            return this._charaList.length;
         }
         return 0;
      }
      
      public function connexionEnd() : void
      {
         this.onGameStart();
      }
      
      public function characterCreationStart(charactersList:Object = null) : void
      {
         waitingForCreation = true;
         this.onCharacterCreationStart([null,null,null,charactersList]);
      }
      
      public function displayHeader(withAccountInfo:Boolean = true) : void
      {
         var connectionBackground:UiRootContainer = this.uiApi.getUi("connectionBackground");
         if(!connectionBackground)
         {
            this.uiApi.loadUi("connectionBackground","connectionBackground",null,StrataEnum.STRATA_LOW);
         }
         var header:UiRootContainer = this.uiApi.getUi("characterHeader");
         if(!header)
         {
            this.uiApi.loadUi("characterHeader","characterHeader",withAccountInfo,StrataEnum.STRATA_HIGH);
         }
         else if(withAccountInfo)
         {
            if(header.uiClass)
            {
               header.uiClass.showHeader(true);
            }
         }
      }
      
      private function onAgreementsRequired(files:Array) : void
      {
         if(!this.uiApi.getUi("userAgreement"))
         {
            this.uiApi.loadUi("userAgreement","userAgreement",files,3);
         }
      }
      
      private function onAuthentificationStart(mustDisplayLogin:Boolean = false) : void
      {
         var skinName:String = null;
         var version:com.ankamagames.jerakine.types.Version = null;
         var lastCustomUISkinWarning:uint = 0;
         this.displayHeader(false);
         this.uiApi.loadUi(loginUiName,null,[this._sPopup,!mustDisplayLogin],1,null,true);
         this.sysApi.setData("forceServerListDisplay",false,DataStoreEnum.BIND_ACCOUNT);
         this.sysApi.setData("forceCharacterCreationDisplay",false,DataStoreEnum.BIND_ACCOUNT);
         if(this.sysApi.useCustomUISkin())
         {
            skinName = this.sysApi.getOption("currentUiSkin","dofus");
            version = this.sysApi.getCurrentVersion();
            lastCustomUISkinWarning = this.sysApi.getData("lastCustomUISkinWarningWithVersion_" + skinName);
            if(lastCustomUISkinWarning && lastCustomUISkinWarning == version.minor)
            {
               return;
            }
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.customTheme.warningContent"),[this.uiApi.getText("ui.popup.customTheme.restaureDefault"),this.uiApi.getText("ui.popup.doNotShowAgain")],[this.onRestoreUiSkin,this.onDoNotShowUISkinPopupAnymore],this.onRestoreUiSkin,null,null,false,false,false);
         }
      }
      
      public function openPreviousUi() : void
      {
         switch(this.previousUi)
         {
            case "characterCreation":
            case loginUiName:
               this.onPreviousUiStart();
               break;
            case "serverListSelection":
               this.sysApi.sendAction(new ChangeServerAction([]));
               break;
            case "characterSelection":
            default:
               if(this._charaList && this._charaList.length > 0)
               {
                  waitingForCharactersList = true;
                  this.onCharacterSelectionStart(this._charaList);
               }
               else if(this.sysApi.getCurrentServer())
               {
                  this.sysApi.sendAction(new ChangeCharacterAction([this.sysApi.getCurrentServer().id]));
               }
               else
               {
                  this.sysApi.sendAction(new ChangeServerAction([]));
               }
         }
      }
      
      private function unlockLogin() : void
      {
         var login:UiRootContainer = this.uiApi.getUi("login");
         this.unlocked = true;
         if(login && login.uiClass)
         {
            login.uiClass.unlockUi();
         }
      }
      
      private function onConnectionStart() : void
      {
         if(this.uiApi.getUi(loginUiName))
         {
            this.previousUi = loginUiName;
            this.uiApi.unloadUi(loginUiName);
         }
      }
      
      private function onCharacterSelectionStart(characterList:Object) : void
      {
         if(!this.uiApi.getUi("characterCreation") || waitingForCharactersList)
         {
            if(TUTORIAL_SELECTION)
            {
               if(TUTORIAL_SELECTION_IS_AVAILABLE)
               {
                  TUTORIAL_SELECTION = false;
                  this.sysApi.sendAction(new CharacterSelectionAction([characterList[0].id,true]));
               }
               else
               {
                  this.sysApi.sendAction(new CharacterSelectionAction([characterList[0].id,false]));
               }
            }
            else
            {
               this._charaList = characterList;
               if(!this.uiApi.getUi("characterSelection"))
               {
                  this.uiApi.loadUi("characterSelection","characterSelection",this._charaList);
               }
               this.previousUi = this.currentUi;
               this.currentUi = "characterSelection";
               if(this.previousUi)
               {
                  this.uiApi.unloadUi(this.previousUi);
               }
               this.displayHeader();
            }
            waitingForCharactersList = false;
         }
      }
      
      private function onCharacterCreationStart(params:Object = null) : void
      {
         if(waitingForCreation || params && params[0] && params[0][0] == "create" && params[1] == true || params && params[0] && params[0][0] != "create")
         {
            if(!this.uiApi.getUi("characterCreation"))
            {
               this.sysApi.setData("forceCharacterCreationDisplay",false,DataStoreEnum.BIND_ACCOUNT);
               this.uiApi.loadUi("characterCreation","characterCreation",params);
               this.previousUi = this.currentUi;
               this.currentUi = "characterCreation";
               if(this.previousUi)
               {
                  this.uiApi.unloadUi(this.previousUi);
               }
            }
            waitingForCreation = false;
            this.displayHeader();
         }
      }
      
      private function onServerSelectionStart(params:Object = null) : void
      {
         waitingForCreation = params[1];
         this.uiApi.loadUi("serverListSelection");
         this.previousUi = this.currentUi;
         this.currentUi = "serverListSelection";
         if(this.previousUi)
         {
            this.uiApi.unloadUi(this.previousUi);
         }
         this.displayHeader();
      }
      
      private function onServersList(serverList:Vector.<GameServerInformations>) : void
      {
         var serversWithCharacters:Array = null;
         var server:GameServerInformations = null;
         var isServerListDisplayForced:Boolean = false;
         var chosenServer:GameServerInformations = null;
         this._serversList = serverList;
         if(!this.uiApi.getUi("serverListSelection"))
         {
            serversWithCharacters = [];
            for each(server in this.connecApi.getUsedServers())
            {
               serversWithCharacters.push(server);
            }
            isServerListDisplayForced = this.sysApi.getData("forceServerListDisplay",DataStoreEnum.BIND_ACCOUNT);
            if((serversWithCharacters.length == 0 || waitingForCreation) && !isServerListDisplayForced)
            {
               waitingForCreation = true;
               chosenServer = this.connecApi.getAutoChosenServer(GameServerTypeEnum.SERVER_TYPE_CLASSICAL);
               if(chosenServer)
               {
                  this.sysApi.log(2,"Connexion au serveur " + chosenServer.id);
                  this.sysApi.sendAction(new ServerSelectionAction([chosenServer.id]));
                  return;
               }
            }
            this.uiApi.loadUi("serverListSelection");
            this.previousUi = this.currentUi;
            this.currentUi = "serverListSelection";
            this.sysApi.setData("forceServerListDisplay",false,DataStoreEnum.BIND_ACCOUNT);
            if(this.previousUi)
            {
               this.uiApi.unloadUi(this.previousUi);
            }
            this.displayHeader();
         }
      }
      
      private function onPreviousUiStart() : void
      {
         this.uiApi.loadUi(this.previousUi);
         var currUi:String = this.previousUi;
         this.previousUi = this.currentUi;
         this.currentUi = currUi;
         if(this.previousUi)
         {
            this.uiApi.unloadUi(this.previousUi);
         }
         this.displayHeader();
      }
      
      private function onGameStart() : void
      {
         this.uiApi.unloadUi(this.currentUi);
         this.uiApi.unloadUi("characterSelection");
         this.uiApi.unloadUi("characterHeader");
         this._charaList = null;
      }
      
      private function onOpenMainMenu(s:String = "") : Boolean
      {
         if(!this.uiApi.getUi("preGameMainMenu"))
         {
            this.uiApi.loadUi("preGameMainMenu",null,[],3);
         }
         else
         {
            this.uiApi.unloadUi("preGameMainMenu");
         }
         return true;
      }
      
      private function onGiftList(giftList:Object, characterList:Object) : void
      {
         if(!this.uiApi.getUi("giftMenu"))
         {
            this.uiApi.loadUi("giftMenu","giftMenu",{
               "gift":giftList,
               "chara":characterList
            },2);
         }
         this.previousUi = this.currentUi;
         this.currentUi = "giftMenu";
         if(this.previousUi)
         {
            this.uiApi.unloadUi(this.previousUi);
         }
      }
      
      private function onTutorielAvailable(tutorielAvailable:Boolean) : void
      {
         TUTORIAL_SELECTION_IS_AVAILABLE = tutorielAvailable;
      }
      
      private function onBreedsAvailable(breedsAvailable:int, breedsVisible:int) : void
      {
         BREEDS_AVAILABLE = breedsAvailable;
         BREEDS_VISIBLE = breedsVisible;
      }
      
      public function onCharactersListUpdated(charactersList:Vector.<BasicCharacterWrapper>) : void
      {
         var cha:BasicCharacterWrapper = null;
         this._charaList = [];
         for each(cha in charactersList)
         {
            this._charaList.push(cha);
         }
      }
      
      public function onConnectionTimerStart() : void
      {
         this.removeTimer();
         this._timeoutTimer = new BenchmarkTimer(10000,1,"Connection._timeoutTimer");
         this._timeoutTimer.start();
         this._timeoutTimer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
      }
      
      public function onCharacterImpossibleSelection(pCharacterId:Number) : void
      {
      }
      
      public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Array) : void
      {
         var text:* = null;
         var servList:String = null;
         var server:* = undefined;
         this.removeTimer();
         var addPicto:Boolean = false;
         switch(error)
         {
            case "AccountRestricted":
               text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
               break;
            case "CommunityRestricted":
               text = this.uiApi.getText("ui.server.cantChoose.communityRestricted");
               break;
            case "LocationRestricted":
               text = this.uiApi.getText("ui.server.cantChoose.locationRestricted");
               break;
            case "SubscribersOnly":
               text = this.uiApi.getText("ui.server.cantChoose.communityNonSubscriberRestricted");
               break;
            case "RegularPlayersOnly":
               text = this.uiApi.getText("ui.server.cantChoose.regularPlayerRestricted");
               break;
            case "MonoaccountCannotVerify":
               text = this.uiApi.getText("ui.server.cantChoose.monoaccountNotVerified");
               addPicto = true;
               break;
            case "MonoaccountOnly":
               text = this.uiApi.getText("ui.server.cantChoose.monoaccountNotMono");
               addPicto = true;
               break;
            case "ServerFull":
               if(this.sysApi.getCurrentLanguage() == "fr")
               {
                  text = "Ce serveur est complet. Nombre maximum de joueurs atteint. Vous pouvez tenter de vous connecter sur un autre serveur.";
               }
               else
               {
                  text = "This server is full. The maximum number of players has been reached. You can try logging on to another server.";
               }
               break;
            case "StatusOffline":
               this.sysApi.log(2,"StatusOffline");
               text = this.uiApi.getText("ui.server.cantChoose.serverDown");
               break;
            case "StatusStarting":
               this.sysApi.log(2,"StatusStarting");
               text = this.uiApi.getText("ui.server.cantChoose.serverDown");
               break;
            case "StatusNojoin":
               this.sysApi.log(2,"StatusNojoin");
               text = this.uiApi.getText("ui.server.cantChoose.serverForbidden");
               break;
            case "StatusSaving":
               this.sysApi.log(2,"StatusSaving");
               text = this.uiApi.getText("ui.server.cantChoose.serverSaving");
               break;
            case "StatusStoping":
               this.sysApi.log(2,"StatusStoping");
               text = this.uiApi.getText("ui.server.cantChoose.serverDown");
               break;
            case "StatusFull":
               text = this.uiApi.getText("ui.server.cantChoose.serverFull") + "\n\n";
               servList = "";
               for each(server in selectableServers)
               {
                  servList += this.dataApi.getServer(server).name + ", ";
               }
               if(servList != "")
               {
                  servList = servList.substr(0,servList.length - 2);
               }
               else
               {
                  servList = this.uiApi.getText("ui.common.none").toLocaleLowerCase();
               }
               text += this.uiApi.getText("ui.server.serversAccessibles",servList);
               break;
            case "NoReason":
            case "StatusUnknown":
               text = this.uiApi.getText("ui.popup.connectionRefused");
         }
         if(text)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),text,[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true,true,null,3,addPicto);
         }
      }
      
      public function onIdentificationFailed(reason:uint, endDate:Number = 0) : void
      {
         var msgStr:String = null;
         this.removeTimer();
         if(reason > 0)
         {
            switch(reason)
            {
               case IdentificationFailureReasonEnum.BANNED:
                  if(endDate == 0)
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.banned"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  }
                  else
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.bannedWithDuration",this.timeApi.getDate(endDate,true) + " " + this.timeApi.getClock(endDate,false,true)),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  }
                  break;
               case IdentificationFailureReasonEnum.IN_MAINTENANCE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.inMaintenance"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.KICKED:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.kicked"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.UNKNOWN_AUTH_ERROR:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.unknown"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.WRONG_CREDENTIALS:
                  msgStr = this.uiApi.getText("ui.popup.accessDenied.wrongCredentials");
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),msgStr,[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.BAD_IPRANGE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.badIpRange"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.TOO_MANY_ON_IP:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.toomanyonip"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.ANONYMOUS_IP_FORBIDDEN:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.anonymousIp"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.TIME_OUT:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.timeout"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.CREDENTIALS_RESET:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.credentialsReset"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.EMAIL_UNVALIDATED:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.unvalidatedEmail"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.SERVICE_UNAVAILABLE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.serviceUnavailable"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.OTP_TIMEOUT:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.otpTimeout"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.SPARE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),"",[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
                  break;
               case IdentificationFailureReasonEnum.LOCKED:
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.locked"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
            }
         }
         this.unlockLogin();
      }
      
      public function onIdentificationSuccess(login:String, isForced:Boolean) : void
      {
         var oldLogins:Array = null;
         var logins:Array = null;
         var oldLogIndex:* = undefined;
         var oldLog:String = null;
         var logins2:Array = null;
         var oldLog2:String = null;
         this.removeTimer();
         if(login && login.length > 0)
         {
            if(login.indexOf("[") != -1 && login.indexOf("]") != -1)
            {
               return;
            }
            oldLogins = this.sysApi.getData("LastLogins");
            if(loginMustBeSaved > -1)
            {
               logins = [];
               for(oldLogIndex in oldLogins)
               {
                  if(oldLogins[oldLogIndex] && oldLogins[oldLogIndex].toLowerCase() == login.toLowerCase())
                  {
                     oldLogins.splice(oldLogIndex,1);
                     break;
                  }
               }
               if(!isForced)
               {
                  logins.push(login);
               }
               for each(oldLog in oldLogins)
               {
                  if(logins.length < 10 && logins.indexOf(oldLog) == -1)
                  {
                     logins.push(oldLog);
                  }
               }
               this.sysApi.setData("LastLogins",logins);
            }
            else if(oldLogins && oldLogins.length > 0)
            {
               logins2 = [];
               for each(oldLog2 in oldLogins)
               {
                  if(oldLog2 && oldLog2.toLowerCase() != login.toLowerCase())
                  {
                     logins2.push(oldLog2);
                  }
               }
               this.sysApi.setData("LastLogins",logins2);
            }
         }
      }
      
      public function onIdentificationFailedForBadVersion(reason:uint, requiredVersion:com.ankamagames.dofus.network.types.version.Version) : void
      {
         var reqVersion:com.ankamagames.jerakine.types.Version = null;
         this.removeTimer();
         if(reason == IdentificationFailureReasonEnum.BAD_VERSION)
         {
            reqVersion = com.ankamagames.jerakine.types.Version.fromServerData(requiredVersion.major,requiredVersion.minor,requiredVersion.code,requiredVersion.build,requiredVersion.buildType);
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.badVersion",this.sysApi.getCurrentVersion(),reqVersion.major + "." + reqVersion.minor + "." + reqVersion.code + "." + reqVersion.build),[this.uiApi.getText("ui.common.ok")]);
         }
         this.unlockLogin();
      }
      
      public function onServerConnectionFailed(reason:uint = 0) : void
      {
         this.removeTimer();
         if(reason == 4)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.silentServer"),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.connectionFailed.text"),[this.uiApi.getText("ui.common.ok")]);
         }
         this.unlockLogin();
      }
      
      public function onUnexpectedSocketClosure() : void
      {
         this.removeTimer();
         this._sPopup = "unexpectedSocketClosure";
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"),this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"),[this.uiApi.getText("ui.common.ok")]);
         this.unlockLogin();
      }
      
      public function onAlreadyConnected() : void
      {
         this.removeTimer();
         this.popupApi.showPopup(POPUP_WARNING_ID);
         this.unlockLogin();
      }
      
      public function onInformationPopup(msg:String) : void
      {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),msg,[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onTimeOut(e:TimerEvent) : void
      {
         this.removeTimer();
         this._timeoutPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.accessDenied.timeout"),[this.uiApi.getText("ui.common.wait"),this.uiApi.getText("ui.common.interrupt")],[this.onPopupWait,this.onPopupInterrupt],this.onPopupWait,this.onPopupInterrupt);
      }
      
      public function onPopupWait() : void
      {
      }
      
      public function onRestoreUiSkin() : void
      {
         this.sysApi.resetCustomUISkin();
      }
      
      public function onDoNotShowUISkinPopupAnymore() : void
      {
         var skinName:String = this.sysApi.getOption("currentUiSkin","dofus");
         var version:com.ankamagames.jerakine.types.Version = this.sysApi.getCurrentVersion();
         this.sysApi.setData("lastCustomUISkinWarningWithVersion_" + skinName,version.minor);
      }
      
      public function onPopupInterrupt() : void
      {
         this.sysApi.sendAction(new ResetGameAction([]));
      }
      
      public function removeTimer(... args) : void
      {
         if(this._timeoutTimer)
         {
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
            this._timeoutTimer.reset();
            this._timeoutTimer = null;
         }
      }
      
      private function onZaapConnectionFailed() : void
      {
         this._sPopup = "zaapConnectionFailed";
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.updaterConnectionFailed"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,false,true);
      }
      
      private function onMigratedServerList(migratedServerIds:Vector.<uint>) : void
      {
         var serverFusionWarning:Boolean = this.sysApi.getData("serverFusionWarning");
         if(!serverFusionWarning)
         {
            this.popupApi.showPopup(POPUP_SERVEUR_FUSION_ID);
            this.sysApi.setData("serverFusionWarning",true);
         }
      }
      
      private function onOpenUpdateInformation() : void
      {
         if(!this.uiApi.getUi("updateInformation"))
         {
            this.uiApi.loadUi("updateInformation",null,null,3);
         }
      }
   }
}
