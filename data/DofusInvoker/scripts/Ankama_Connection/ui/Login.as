package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import Ankama_Connection.Connection;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.InputComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.StateContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTokenAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ConnectionApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class Login
   {
      
      private static const GAMEMODE_NONE:uint = 0;
      
      private static const GAMEMODE_LOG_IN:uint = 1;
      
      private static const GAMEMODE_LOG_IN_ZAAP:uint = 5;
      
      private static const CONNECT_TO_SERVER_LIST:uint = 0;
      
      private static const CONNECT_TO_CHARACTER_LIST:uint = 1;
      
      private static const CONNECT_TO_GAME:uint = 2;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Login));
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ConnectionApi")]
      public var connectionApi:ConnectionApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _zaapLoginAvailable:Boolean = false;
      
      private var _currentMode:uint = 0;
      
      private var _aPorts:Array;
      
      private var _componentsList:Dictionary;
      
      private var _previousFocus:Input;
      
      private var _mustDisableConnectionButton:Boolean = false;
      
      private var _timeoutId:uint;
      
      private var _popupName:String;
      
      public var ctr_center:GraphicContainer;
      
      public var ctr_links:GraphicContainer;
      
      public var ctr_inputs:StateContainer;
      
      public var ctr_login:GraphicContainer;
      
      public var ctr_pass:GraphicContainer;
      
      public var cbx_login:InputComboBox;
      
      public var tx_login_help:Texture;
      
      public var input_pass:Input;
      
      public var lbl_login:Label;
      
      public var lbl_pass:Label;
      
      public var lbl_capsLock:Label;
      
      public var ctr_capsLockMsg:GraphicContainer;
      
      public var btn_passForgotten:ButtonContainer;
      
      public var btn_createAccount:ButtonContainer;
      
      public var btn_play:ButtonContainer;
      
      public var btn_options:ButtonContainer;
      
      public var ctr_options:GraphicContainer;
      
      public var btn_rememberLogin:ButtonContainer;
      
      public var cb_connectionType:ComboBox;
      
      public var cb_socket:ComboBox;
      
      public var ctr_gifts:GraphicContainer;
      
      public var btn_members:ButtonContainer;
      
      public var btn_lowa:ButtonContainer;
      
      public var gd_shop:Grid;
      
      public var ctr_zaap:GraphicContainer;
      
      public var btn_login_zaap:ButtonContainer;
      
      public var cb_hosts:ComboBox;
      
      public var bgcb_hosts:TextureBitmap;
      
      public var ctr_optionsBg:GraphicContainer;
      
      public var tx_optionsBorder:TextureBitmap;
      
      public var lbl_hostSelection:Label;
      
      public var btn_skipHost:ButtonContainer;
      
      public function Login()
      {
         this._componentsList = new Dictionary(true);
         super();
      }
      
      public function main(params:Array) : void
      {
         var porc:String = null;
         var serverPort:uint = 0;
         var autoConnectType:uint = 0;
         var initialUiMode:uint = 0;
         var loginMustBeSaved:int = 0;
         var lastLogins:Array = null;
         var deprecatedLogin:String = null;
         var logins:Array = null;
         if(params.length > 0)
         {
            this._popupName = params[0];
         }
         if(params.length > 1 && !this.uiApi.me().uiModule.mainClass.unlocked)
         {
            this._mustDisableConnectionButton = params[1];
         }
         if(this.sysApi.isUsingZaapLogin())
         {
            this._zaapLoginAvailable = true;
         }
         this.btn_play.soundId = "-1";
         this.soundApi.playIntroMusic();
         this.sysApi.addHook(HookList.NicknameRegistration,this.onNicknameRegistration);
         this.sysApi.addHook(HookList.SubscribersList,this.onSubscribersList);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.sysApi.addHook(HookList.SelectedServerFailed,this.onSelectedServerFailed);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontChanged);
         this.sysApi.addHook(HookList.DisplayHostSelection,this.displayHostSelection);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_login_help,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_login_help,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_rememberLogin,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_connectionType,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_socket,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.input_pass,"onChange");
         this.uiApi.addComponentHook(this.cb_hosts,ComponentHookList.ON_SELECT_ITEM);
         this.ctr_gifts.visible = false;
         this.uiApi.addComponentHook(this.cbx_login,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cbx_login.input,"onChange");
         this.ctr_options.visible = false;
         this.cbx_login.input.tabEnabled = true;
         this.input_pass.tabEnabled = true;
         this.tx_login_help.visible = true;
         this._aPorts = [];
         var aPortsName:Array = [];
         var ports:String = this.sysApi.getConfigKey("connection.port");
         for each(porc in ports.split(","))
         {
            this._aPorts.push(int(porc));
            aPortsName.push("" + porc);
         }
         this.cb_socket.dataProvider = aPortsName;
         serverPort = this.configApi.getConfigProperty("dofus","connectionPort");
         this.sysApi.setPort(serverPort);
         this.cb_socket.value = aPortsName[this._aPorts.indexOf(serverPort)];
         this.cb_connectionType.dataProvider = [{
            "label":this.uiApi.getText("ui.connection.connectionToServerChoice"),
            "connectionType":CONNECT_TO_SERVER_LIST
         },{
            "label":this.uiApi.getText("ui.connection.connectionToCharacterChoice"),
            "connectionType":CONNECT_TO_CHARACTER_LIST
         },{
            "label":this.uiApi.getText("ui.connection.connectionDirectAccess"),
            "connectionType":CONNECT_TO_GAME
         }];
         autoConnectType = this.configApi.getConfigProperty("dofus","autoConnectType");
         this.cb_connectionType.value = this.cb_connectionType.dataProvider[autoConnectType];
         this.cbx_login.input.restrict = "A-Za-z0-9\\-\\|.@_[]+";
         if(this.sysApi.isEventMode())
         {
            this.uiApi.setFullScreen(true,true);
            this.cbx_login.input.text = this.uiApi.getText("ui.connection.eventModeLogin");
            this.input_pass.text = "**********";
            this.cbx_login.disabled = true;
            this.input_pass.disabled = true;
            this.ctr_inputs.state = "DISABLED";
            this.btn_rememberLogin.disabled = true;
            this.btn_rememberLogin.mouseEnabled = false;
            this.cb_connectionType.disabled = true;
         }
         else
         {
            if(this.sysApi.getConfigKey("boo") == "1" && this.sysApi.getBuildType() > 1)
            {
               this.input_pass.text = !!this.sysApi.getData("LastPassword") ? this.sysApi.getData("LastPassword") : "";
            }
            else
            {
               this.lbl_pass.text = this.uiApi.getText("ui.login.password");
            }
            loginMustBeSaved = this.sysApi.getData("saveLogin");
            if(loginMustBeSaved == 0)
            {
               Connection.loginMustBeSaved = 1;
               this.btn_rememberLogin.selected = true;
               this.sysApi.setData("saveLogin",1);
            }
            else
            {
               Connection.loginMustBeSaved = loginMustBeSaved;
               this.btn_rememberLogin.selected = loginMustBeSaved == 1;
            }
            lastLogins = this.sysApi.getData("LastLogins");
            if(lastLogins && lastLogins.length > 0)
            {
               if(this.sysApi.getBuildType() != BuildTypeEnum.DEBUG && lastLogins.length >= this.sysApi.getNumberOfClients())
               {
                  this.cbx_login.input.text = lastLogins[this.sysApi.getClientId() - 1];
               }
               else
               {
                  this.cbx_login.input.text = lastLogins[0];
               }
               this.cbx_login.dataProvider = lastLogins;
               this.input_pass.focus();
            }
            else
            {
               deprecatedLogin = this.sysApi.getData("LastLogin");
               if(deprecatedLogin && deprecatedLogin.length > 0)
               {
                  this.sysApi.setData("LastLogin","");
                  logins = [];
                  logins.push(deprecatedLogin);
                  this.sysApi.setData("LastLogins",logins);
                  this.sysApi.setData("saveLogin",1);
                  Connection.loginMustBeSaved = 1;
                  this.btn_rememberLogin.selected = true;
                  this.cbx_login.input.text = deprecatedLogin;
                  this.cbx_login.dataProvider = logins;
                  this.input_pass.focus();
               }
               else
               {
                  this.lbl_login.text = this.uiApi.getText("ui.login.username");
                  this.cbx_login.input.focus();
               }
            }
         }
         if(this._popupName == "unexpectedSocketClosure")
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"),this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"),[this.uiApi.getText("ui.common.ok")],[this.onClosePopup]);
         }
         else if(this._popupName == "zaapConnectionFailed")
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.updaterConnectionFailed"),[this.uiApi.getText("ui.common.ok")],[this.onClosePopup],null,null,null,false,true);
         }
         this.lbl_capsLock.multiline = false;
         this.lbl_capsLock.wordWrap = false;
         this.lbl_capsLock.fullWidthAndHeight();
         this.ctr_capsLockMsg.width = this.lbl_capsLock.textfield.width + 12;
         if(!Keyboard.capsLock || this.sysApi.getOs() == "Mac OS")
         {
            this.lbl_capsLock.visible = false;
            this.ctr_capsLockMsg.visible = false;
         }
         this.sysApi.dispatchHook(HookList.QualitySelectionRequired);
         if(this._zaapLoginAvailable)
         {
            initialUiMode = GAMEMODE_LOG_IN_ZAAP;
         }
         else
         {
            initialUiMode = GAMEMODE_LOG_IN;
         }
         this._timeoutId = setTimeout(this.switchUiMode,1,initialUiMode);
         if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            this.hideHostSelection();
         }
      }
      
      private function onClosePopup() : void
      {
         this._popupName = null;
      }
      
      public function unload() : void
      {
         clearTimeout(this._timeoutId);
         if(this.uiApi)
         {
            this.uiApi.hideTooltip();
         }
      }
      
      public function unlockUi() : void
      {
         this._mustDisableConnectionButton = false;
         this.disableUi(false);
      }
      
      public function disableUi(disable:Boolean) : void
      {
         this.cbx_login.input.mouseEnabled = !disable;
         this.cbx_login.input.mouseChildren = !disable;
         this.input_pass.mouseEnabled = !disable;
         this.input_pass.mouseChildren = !disable;
         if(disable)
         {
            this.ctr_inputs.state = "DISABLED";
            if(this.cbx_login.input.haveFocus)
            {
               this._previousFocus = this.cbx_login.input;
            }
            else if(this.input_pass.haveFocus)
            {
               this._previousFocus = this.input_pass;
            }
            this.btn_play.focus();
         }
         else
         {
            this.ctr_inputs.state = "NORMAL";
            if(this._previousFocus)
            {
               this._previousFocus.focus();
               this._previousFocus = null;
            }
         }
         this.btn_play.disabled = disable;
         this.btn_login_zaap.disabled = disable;
         this.btn_rememberLogin.disabled = disable;
         this.btn_rememberLogin.mouseEnabled = !disable;
         this.cbx_login.disabled = disable;
         this.cb_connectionType.disabled = disable;
      }
      
      public function updateLoginLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var mod:String = !!componentsRef.hasOwnProperty("btn_removeLogin") ? "" : "2";
         if(!this._componentsList[componentsRef["btn_removeLogin" + mod].name])
         {
            this.uiApi.addComponentHook(componentsRef["btn_removeLogin" + mod],"onRelease");
            this.uiApi.addComponentHook(componentsRef["btn_removeLogin" + mod],"onRollOut");
            this.uiApi.addComponentHook(componentsRef["btn_removeLogin" + mod],"onRollOver");
         }
         this._componentsList[componentsRef["btn_removeLogin" + mod].name] = data;
         if(data)
         {
            componentsRef["lbl_loginName" + mod].text = data;
            componentsRef["btn_removeLogin" + mod].visible = true;
            componentsRef["btn_login" + mod].selected = selected;
         }
         else
         {
            componentsRef["lbl_loginName" + mod].text = "";
            componentsRef["btn_removeLogin" + mod].visible = false;
            componentsRef["btn_login" + mod].selected = false;
         }
      }
      
      private function displayHostSelection() : void
      {
         this.ctr_options.visible = true;
         this.btn_skipHost.visible = true;
         this.btn_skipHost.selected = this.sysApi.getSetData("skipHostSelection",0,DataStoreEnum.BIND_COMPUTER);
         this.ctr_optionsBg.height = 312;
         this.tx_optionsBorder.height = 353;
         this.cb_hosts.visible = true;
         this.bgcb_hosts.visible = true;
         this.lbl_hostSelection.visible = true;
         this.cb_hosts.dataProvider = XmlConfig.getInstance().getEntry("config.connection.host").split(",");
         this.cb_hosts.selectedIndex = this.sysApi.getSetData("lastHostIndex",0,DataStoreEnum.BIND_COMPUTER);
         this.btn_login_zaap.disabled = this.sysApi.getSetData("skipHostSelection",0,DataStoreEnum.BIND_COMPUTER);
      }
      
      private function hideHostSelection() : void
      {
         this.btn_skipHost.visible = false;
         this.cb_hosts.visible = false;
         this.bgcb_hosts.visible = false;
         this.lbl_hostSelection.visible = false;
      }
      
      private function login() : void
      {
         var username:String = null;
         var usernameLength:uint = 0;
         var i:uint = 0;
         var directConnection:* = false;
         this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
         var sLogin:String = this.cbx_login.input.text;
         var sPass:String = this.input_pass.text;
         if(sLogin.length == 0 || sPass.length == 0)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.accessDenied"),this.uiApi.getText("ui.popup.accessDenied.wrongCredentials"),[this.uiApi.getText("ui.common.ok")],[]);
            this.disableUi(false);
         }
         else
         {
            if(this.sysApi.getConfigKey("boo") == "1" && this.sysApi.getBuildType() > BuildTypeEnum.BETA)
            {
               this.sysApi.setData("LastPassword",sPass);
            }
            else
            {
               this.sysApi.setData("LastPassword",null);
            }
            if(this.sysApi.isEventMode())
            {
               username = this.sysApi.getData("EventModeLogins");
               if(!username || username.length == 0)
               {
                  username = "$";
                  usernameLength = 10 + Math.random() * 10;
                  for(i = 0; i < usernameLength; i++)
                  {
                     username += String.fromCharCode(Math.floor(97 + Math.random() * 26));
                  }
                  this.sysApi.setData("EventModeLogins",username);
               }
               this.sysApi.sendAction(new LoginValidationAction([username,"pass",true,0,this.cb_hosts.dataProvider.length >= 0 ? this.cb_hosts.selectedItem : null]));
            }
            else
            {
               directConnection = this.cb_connectionType.selectedItem.connectionType == CONNECT_TO_GAME;
               if(directConnection)
               {
                  this.connectionApi.allowAutoConnectCharacter(true);
               }
               this.sysApi.sendAction(new LoginValidationAction([sLogin,sPass,this.cb_connectionType.selectedItem.connectionType != CONNECT_TO_SERVER_LIST,0,this.cb_hosts.dataProvider.length >= 0 ? this.cb_hosts.selectedItem : null]));
            }
         }
      }
      
      private function autoLogin() : void
      {
         if(this._currentMode == GAMEMODE_LOG_IN_ZAAP)
         {
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            if(this.cb_connectionType.selectedItem.connectionType == CONNECT_TO_GAME)
            {
               this.connectionApi.allowAutoConnectCharacter(true);
            }
            this.sysApi.sendAction(new LoginValidationWithTokenAction([false,0,this.cb_hosts.dataProvider.length >= 0 ? this.cb_hosts.selectedItem : null]));
         }
      }
      
      public function updateShopGift(data:*, componentsRef:*, selected:Boolean) : void
      {
         var intPriceCrossed:int = 0;
         if(data)
         {
            if(!this._componentsList[componentsRef.tx_bgArticle.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_bgArticle,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.tx_bgArticle,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_bgArticle,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentsList[componentsRef.tx_bgArticle.name] = data;
            if(data.visualUri)
            {
               componentsRef.tx_article.uri = this.uiApi.createUri(data.visualUri);
            }
            componentsRef.tx_bgArticle.handCursor = true;
            componentsRef.tx_bgArticle.mouseEnabled = true;
            intPriceCrossed = data.price;
            if(data.priceCrossed)
            {
               intPriceCrossed = data.priceCrossed.split(".")[0];
            }
            if(data.priceCrossed && intPriceCrossed > data.price)
            {
               componentsRef.lbl_banner.text = data.price;
               componentsRef.tx_banner.gotoAndStop = 2;
               componentsRef.lbl_price.text = intPriceCrossed;
               componentsRef.ctr_crossprice.visible = true;
               componentsRef.tx_money.visible = true;
               componentsRef.lbl_banner.x = 15;
            }
            else
            {
               if(data.promotionTag)
               {
                  componentsRef.lbl_banner.text = this.uiApi.getText("ui.shop.sales");
                  componentsRef.tx_banner.gotoAndStop = 2;
               }
               else if(data.newTag)
               {
                  componentsRef.lbl_banner.text = this.uiApi.getText("ui.common.new");
                  componentsRef.tx_banner.gotoAndStop = 1;
               }
               else
               {
                  componentsRef.tx_banner.visible = false;
                  componentsRef.lbl_banner.visible = false;
               }
               componentsRef.lbl_price.text = data.price;
            }
         }
         else
         {
            componentsRef.ctr_article.visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var loginMustBeSaved:int = 0;
         var loginToDelete:String = null;
         var oldLogins:Array = null;
         var logins:Array = null;
         var oldLog:String = null;
         switch(target)
         {
            case this.btn_play:
               if(!this.btn_play.disabled)
               {
                  this.disableUi(true);
                  this.login();
               }
               break;
            case this.btn_rememberLogin:
               loginMustBeSaved = !!this.btn_rememberLogin.selected ? 1 : -1;
               Connection.loginMustBeSaved = loginMustBeSaved;
               this.sysApi.setData("saveLogin",loginMustBeSaved);
               break;
            case this.btn_passForgotten:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.cantlogin"));
               break;
            case this.btn_createAccount:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.createAccount"));
               break;
            case this.btn_options:
               this.ctr_options.visible = !this.ctr_options.visible;
               break;
            case this.btn_members:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.members"));
               break;
            case this.btn_lowa:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.lowa"));
               break;
            case this.btn_login_zaap:
               this.disableUi(true);
               this.autoLogin();
               break;
            case this.btn_skipHost:
               this.sysApi.setData("skipHostSelection",this.btn_skipHost.selected,DataStoreEnum.BIND_COMPUTER);
               break;
            default:
               if(target.name.indexOf("btn_removeLogin") != -1)
               {
                  loginToDelete = this._componentsList[target.name];
                  oldLogins = this.sysApi.getData("LastLogins");
                  logins = [];
                  for each(oldLog in oldLogins)
                  {
                     if(oldLog != loginToDelete)
                     {
                        logins.push(oldLog);
                     }
                  }
                  this.sysApi.setData("LastLogins",logins);
                  this.cbx_login.dataProvider = logins;
                  this.cbx_login.selectedIndex = 0;
               }
               else if(target.name.indexOf("tx_bgArticle") != -1)
               {
                  if(this._componentsList[target.name].onCliqueUri)
                  {
                     this.sysApi.goToUrl(this._componentsList[target.name].onCliqueUri);
                  }
                  else
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.loginAdsIGShop.title"),this.uiApi.getText("ui.popup.loginAdsIGShop.text"),[this.uiApi.getText("ui.common.ok")],[]);
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var tooltipPoint:uint = 6;
         var tooltipRelativePoint:uint = 1;
         switch(target)
         {
            case this.btn_rememberLogin:
               tooltipText = this.uiApi.getText("ui.connection.rememberLogin.info");
               break;
            case this.tx_login_help:
               tooltipText = this.uiApi.getText("ui.login.usernameHelper");
               break;
            default:
               if(target.name.indexOf("btn_removeLogin") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.login.deleteLogin");
                  this.cbx_login.closeOnClick = false;
               }
               else if(target.name.indexOf("tx_bgArticle") != -1)
               {
                  tooltipPoint = 7;
                  tooltipRelativePoint = 1;
                  tooltipText = this._componentsList[target.name].name;
               }
         }
         if(tooltipText && tooltipText.length > 1)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",tooltipPoint,tooltipRelativePoint,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         if(target.name.indexOf("btn_removeLogin") != -1)
         {
            this.cbx_login.closeOnClick = true;
         }
      }
      
      public function onSelectItem(target:ComboBox, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_socket:
               this.sysApi.setPort(this._aPorts[this.cb_socket.selectedIndex]);
               break;
            case this.cb_connectionType:
               this.configApi.setConfigProperty("dofus","autoConnectType",this.cb_connectionType.selectedItem.connectionType);
               break;
            case this.cbx_login:
               if(selectMethod != GridItemSelectMethodEnum.AUTO)
               {
                  this.lbl_login.text = "";
               }
            case this.cb_hosts:
               if(this.cb_hosts.selectedItem != null)
               {
                  this.sysApi.setData("lastHostIndex",this.cb_hosts.selectedIndex,DataStoreEnum.BIND_COMPUTER);
               }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(!this.btn_play.disabled && this.ctr_center.visible)
               {
                  this.disableUi(true);
                  this.login();
                  return true;
               }
               if(!this.btn_login_zaap.disabled && !this.ctr_center.visible)
               {
                  this.disableUi(true);
                  this.autoLogin();
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function onNicknameRegistration() : void
      {
         this.disableUi(true);
         this.uiApi.loadUi("pseudoChoice");
      }
      
      private function onUiUnloaded(name:String) : void
      {
         if(name.indexOf("popup") == 0 && this._previousFocus)
         {
            this._previousFocus.focus();
            this._previousFocus = null;
         }
      }
      
      private function onSubscribersList(giftsList:Array) : void
      {
         var newWidth:int = 0;
         this.ctr_gifts.visible = true;
         if(giftsList.length < 4)
         {
            newWidth = this.gd_shop.slotWidth * giftsList.length;
            this.gd_shop.x += (this.gd_shop.width - newWidth) / 2;
         }
         this.gd_shop.dataProvider = giftsList;
      }
      
      public function onSelectedServerFailed() : void
      {
         this.disableUi(false);
      }
      
      public function onChange(target:Object) : void
      {
         if(target == this.input_pass)
         {
            if(this.lbl_pass.text != "" && this.input_pass.text != "")
            {
               this.lbl_pass.text = "";
            }
            if(this.lbl_pass.text == "" && this.input_pass.text == "")
            {
               this.lbl_pass.text = this.uiApi.getText("ui.login.password");
            }
         }
         if(target == this.cbx_login.input)
         {
            if(this.lbl_login.text != "" && this.cbx_login.input.text != "")
            {
               this.lbl_login.text = "";
            }
            if(this.lbl_login.text == "" && this.cbx_login.input.text == "")
            {
               this.lbl_login.text = this.uiApi.getText("ui.login.username");
            }
         }
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == 9)
         {
            if(this.cbx_login.input.haveFocus)
            {
               this.input_pass.focus();
               this.input_pass.setSelection(0,this.input_pass.text.length);
            }
            else if(this.input_pass.haveFocus)
            {
               this.cbx_login.input.focus();
               this.cbx_login.input.setSelection(0,this.cbx_login.input.text.length);
            }
         }
         else if(keyCode == 20)
         {
            if(Keyboard.capsLock)
            {
               this.ctr_capsLockMsg.visible = true;
               this.lbl_capsLock.visible = true;
            }
            else
            {
               this.ctr_capsLockMsg.visible = false;
               this.lbl_capsLock.visible = false;
            }
         }
      }
      
      public function onFontChanged() : void
      {
         this.lbl_capsLock.fullWidthAndHeight();
         this.ctr_capsLockMsg.width = this.lbl_capsLock.textfield.width + 12;
      }
      
      private function switchUiMode(mode:uint) : void
      {
         clearTimeout(this._timeoutId);
         this._currentMode = mode;
         this.sysApi.setData("loginUiMode",mode);
         if(mode == GAMEMODE_LOG_IN)
         {
            this.ctr_center.visible = true;
            this.ctr_links.visible = true;
            this.ctr_login.visible = true;
            this.ctr_pass.visible = true;
            this.ctr_zaap.visible = false;
            this.cb_connectionType.disabled = false;
            this.btn_rememberLogin.disabled = false;
            if(!this._popupName)
            {
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.connection.updaterConnectionFailed"),[this.uiApi.getText("ui.common.ok")],[this.onClosePopup],null,null,null,false,true);
            }
         }
         else if(mode == GAMEMODE_LOG_IN_ZAAP)
         {
            this.ctr_center.visible = false;
            this.ctr_links.visible = false;
            this.ctr_zaap.visible = true;
            this.btn_login_zaap.disabled = this._mustDisableConnectionButton;
            this.btn_options.disabled = this._mustDisableConnectionButton;
            this.cb_connectionType.disabled = false;
            this.btn_rememberLogin.disabled = true;
         }
         if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.INTERNAL)
         {
            this.displayHostSelection();
         }
         else
         {
            this.hideHostSelection();
         }
         if(mode == GAMEMODE_LOG_IN_ZAAP && this._mustDisableConnectionButton && (this.btn_skipHost.selected || BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL))
         {
            this.autoLogin();
         }
      }
   }
}
