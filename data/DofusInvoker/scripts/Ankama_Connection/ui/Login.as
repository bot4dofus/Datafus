package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.kernel.zaap.ZaapApi;
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
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class Login
   {
      
      private static const GAMEMODE_NONE:uint = 0;
      
      private static const GAMEMODE_LOG_IN:uint = 1;
      
      private static const GAMEMODE_LOG_IN_ZAAP:uint = 2;
      
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
      
      private var _currentMode:uint = 0;
      
      private var _timeoutId:uint;
      
      private var _popupName:String;
      
      public var ctr_options:GraphicContainer;
      
      public var ctr_zaap:GraphicContainer;
      
      public var ctr_noZaap:GraphicContainer;
      
      public var btn_login_zaap:ButtonContainer;
      
      public var lbl_noZaap:Label;
      
      public var cb_hosts:ComboBox;
      
      public function Login()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         if(params.length > 0)
         {
            this._popupName = params[0];
         }
         this.soundApi.playIntroMusic();
         this.sysApi.addHook(HookList.NicknameRegistration,this.onNicknameRegistration);
         this.sysApi.addHook(HookList.SelectedServerFailed,this.onSelectedServerFailed);
         this.sysApi.addHook(HookList.DisplayHostSelection,this.displayHostSelection);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.cb_hosts,ComponentHookList.ON_SELECT_ITEM);
         this.ctr_options.visible = false;
         if(this.sysApi.isEventMode())
         {
            this.uiApi.setFullScreen(true,true);
         }
         if(this._popupName == "unexpectedSocketClosure")
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.unexpectedSocketClosure"),this.uiApi.getText("ui.popup.unexpectedSocketClosure.text"),[this.uiApi.getText("ui.common.ok")],[this.onClosePopup]);
         }
         this.sysApi.dispatchHook(HookList.QualitySelectionRequired);
         this.sysApi.dispatchHook(HookList.LoginLoaded);
         this._timeoutId = setTimeout(this.switchUiMode,1,!!this.sysApi.isUsingZaapLogin() ? GAMEMODE_LOG_IN_ZAAP : GAMEMODE_LOG_IN);
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
         this.disableUi(false);
      }
      
      public function disableUi(disable:Boolean) : void
      {
         this.btn_login_zaap.disabled = disable;
         this.ctr_options.disabled = disable;
      }
      
      private function displayHostSelection() : void
      {
         this.ctr_options.visible = true;
         this.cb_hosts.dataProvider = XmlConfig.getInstance().getEntry("config.connection.host").split(",");
         this.cb_hosts.selectedIndex = this.sysApi.getSetData("lastHostIndex",0,DataStoreEnum.BIND_COMPUTER);
      }
      
      private function hideHostSelection() : void
      {
         this.ctr_options.visible = false;
      }
      
      private function autoLogin() : void
      {
         if(this._currentMode == GAMEMODE_LOG_IN_ZAAP)
         {
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            if(this.configApi.getConfigProperty("dofus","autoConnectType") == CONNECT_TO_GAME)
            {
               this.connectionApi.allowAutoConnectCharacter(true);
            }
            this.sysApi.sendAction(new LoginValidationWithTokenAction([false,0,this.cb_hosts.dataProvider.length >= 0 ? this.cb_hosts.selectedItem : null]));
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_login_zaap:
               this.disableUi(true);
               this.autoLogin();
         }
      }
      
      public function onSelectItem(target:ComboBox, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
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
               if(!this.btn_login_zaap.disabled)
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
      
      public function onSelectedServerFailed() : void
      {
         this.disableUi(false);
      }
      
      private function switchUiMode(mode:uint) : void
      {
         clearTimeout(this._timeoutId);
         this._currentMode = mode;
         if(mode == GAMEMODE_LOG_IN)
         {
            this.ctr_zaap.visible = false;
            this.ctr_noZaap.visible = true;
            if(ZaapApi.isDisconnected())
            {
               this.lbl_noZaap.text = this.uiApi.getText("ui.connection.updaterConnectionFailed");
            }
            else
            {
               this.lbl_noZaap.text = this.uiApi.getText("ui.connection.updaterRequired");
            }
            this.hideHostSelection();
         }
         else if(mode == GAMEMODE_LOG_IN_ZAAP)
         {
            this.ctr_zaap.visible = true;
            this.ctr_noZaap.visible = false;
            if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.INTERNAL)
            {
               this.displayHostSelection();
            }
            else
            {
               this.hideHostSelection();
            }
         }
         if(mode == GAMEMODE_LOG_IN_ZAAP && BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            this.autoLogin();
         }
      }
   }
}
