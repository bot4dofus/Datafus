package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import Ankama_Connection.Connection;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.datacenter.servers.ServerGameType;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ConnectionApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class CharacterHeader
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ConnectionApi")]
      public var connecApi:ConnectionApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var ctr_main:GraphicContainer;
      
      public var btn_subscribe:ButtonContainer;
      
      public var btn_serverChoice:ButtonContainer;
      
      public var lbl_pseudo:Label;
      
      public var lbl_abo:Label;
      
      public var lbl_server:Label;
      
      public var cb_mode:ComboBox;
      
      public var ctr_cbMode:GraphicContainer;
      
      private var _isSuscribed:Boolean = true;
      
      private var _currentServerType:int;
      
      private var _selectedServerType:int;
      
      private var _currentUi:String;
      
      public function CharacterHeader()
      {
         super();
      }
      
      public function main(... args) : void
      {
         var gtype:ServerGameType = null;
         this.sysApi.addHook(HookList.AuthenticationTicket,this.onAuthenticationTicket);
         this.sysApi.addHook(HookList.ServersList,this.onServersList);
         this.sysApi.addHook(HookList.SubscriptionEndDateUpdate,this.onSubscriptionEndDateUpdate);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_pseudo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_pseudo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_serverChoice,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_serverChoice,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cb_mode,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.cb_mode,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cb_mode,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_mode,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.cb_mode,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.btn_subscribe.soundId = SoundEnum.SPEC_BUTTON;
         var gameTypes:Array = this.dataApi.getServerGameTypes();
         var gameTypesDataProvider:Array = [];
         for each(gtype in gameTypes)
         {
            if(gtype.selectableByPlayer)
            {
               gameTypesDataProvider.push({
                  "label":gtype.name,
                  "type":gtype.id,
                  "description":gtype.description,
                  "rules":gtype.rules
               });
            }
         }
         this.cb_mode.autoSelectMode = 0;
         this.cb_mode.dataProvider = gameTypesDataProvider;
         this.cb_mode.disabled = true;
         this.showHeader(args[0]);
      }
      
      public function unload() : void
      {
      }
      
      public function showHeader(b:Boolean) : void
      {
         var lastWarning:Number = NaN;
         var now:Number = NaN;
         this.ctr_main.visible = b;
         if(b)
         {
            this.onSubscriptionEndDateUpdate();
            this._currentUi = Connection.getInstance().currentUi;
            if(this._currentUi == "serverListSelection")
            {
               this.ctr_cbMode.visible = false;
               this.btn_serverChoice.disabled = true;
            }
            else if(this._currentUi == "characterSelection")
            {
               this.ctr_cbMode.visible = false;
               this.btn_serverChoice.disabled = false;
            }
            else if(this._currentUi == "characterCreation")
            {
               this.btn_serverChoice.disabled = false;
            }
            this.playerDisplay();
            if(this.sysApi.getBuildType() != BuildTypeEnum.BETA && (this.sysApi.getOs() == "Windows" && this.sysApi.getOsVersion() == "2000" || this.sysApi.getOs() == "Mac OS" && this.sysApi.getCpu() == "PowerPC"))
            {
               if(!this.sysApi.getData("lastOsWarning"))
               {
                  this.sysApi.setData("lastOsWarning",0);
               }
               lastWarning = this.sysApi.getData("lastOsWarning");
               now = new Date().getTime();
               if(lastWarning == 0 || now - lastWarning > 604800000)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.report.oldOs.popup"),[this.uiApi.getText("ui.common.ok")],[this.voidFunction],this.voidFunction);
                  this.sysApi.setData("lastOsWarning",now);
               }
            }
         }
      }
      
      private function playerDisplay() : void
      {
         var serverGameTypeId:uint = 0;
         var modeCount:int = 0;
         var i:int = 0;
         this.lbl_pseudo.text = PlayerManager.getInstance().formatTagName(this.sysApi.getPlayerManager().nickname,this.sysApi.getPlayerManager().tag);
         if(this.sysApi.getPlayerManager().subscriptionEndDate == 0)
         {
            if(this.sysApi.getPlayerManager().hasRights)
            {
               this.lbl_abo.text = this.uiApi.getText("ui.common.admin");
            }
            else
            {
               this.lbl_abo.text = this.uiApi.getText("ui.common.non_subscriber");
            }
         }
         else if(this.sysApi.getPlayerManager().subscriptionEndDate < 2051222400000)
         {
            this.lbl_abo.text = this.uiApi.getText("ui.common.until",this.timeApi.getDate(this.sysApi.getPlayerManager().subscriptionEndDate,true,true) + " " + this.timeApi.getClock(this.sysApi.getPlayerManager().subscriptionEndDate,true,true));
         }
         else
         {
            this.lbl_abo.text = this.uiApi.getText("ui.common.infiniteSubscription");
         }
         this.lbl_server.text = this.uiApi.getText("ui.header.server") + this.uiApi.getText("ui.common.colon");
         var server:Server = this.sysApi.getCurrentServer();
         if(server)
         {
            this._currentServerType = server.gameTypeId;
            this.lbl_server.text += server.name;
            serverGameTypeId = server.gameTypeId;
            modeCount = this.cb_mode.dataProvider.length;
            for(i = 0; i < modeCount; i++)
            {
               if(this.cb_mode.dataProvider[i].type == serverGameTypeId)
               {
                  this.cb_mode.selectedIndex = i;
               }
            }
            this.cb_mode.disabled = false;
         }
         else
         {
            this.cb_mode.disabled = true;
         }
      }
      
      private function onSubscriptionEndDateUpdate() : void
      {
         if(this.sysApi.getPlayerManager().subscriptionEndDate > 0 || this.sysApi.getPlayerManager().hasRights)
         {
            this.btn_subscribe.visible = false;
            this._isSuscribed = true;
         }
         else
         {
            this.btn_subscribe.visible = true;
            this._isSuscribed = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_subscribe:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
               break;
            case this.btn_serverChoice:
               if(this._currentUi == "characterCreation")
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.header.goToServerChoice"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onChangeServer,this.onPopupClose],this.onChangeServer,this.onPopupClose);
               }
               else
               {
                  this.onChangeServer();
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = "";
         switch(target)
         {
            case this.lbl_pseudo:
               text = this.uiApi.getText("ui.header.dofusPseudo");
               break;
            case this.lbl_abo:
               if(this.sysApi.getPlayerManager().subscriptionEndDate > 0)
               {
                  text = this.uiApi.getText("ui.header.subscriptionEndDate");
               }
               break;
            case this.btn_serverChoice:
               text = this.uiApi.getText("ui.sersel.manualChoice");
               break;
            case this.cb_mode:
               text = this.uiApi.getText("ui.connection.switchToAnotherGameMode");
         }
         if(text != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,5,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var text:String = null;
         var availableSlotsByServerType:Array = null;
         if(target == this.cb_mode && this.ctr_cbMode.visible && selectMethod != SelectMethodEnum.MANUAL)
         {
            this._selectedServerType = this.cb_mode.selectedItem.type;
            this.sysApi.log(2,"Mode choisi : " + this.cb_mode.selectedItem.label + " : " + this._selectedServerType + "      select method " + selectMethod);
            if(this.configApi.isFeatureWithKeywordEnabled("server.heroic") && !this._isSuscribed)
            {
               text = this.uiApi.getText("ui.sersel.sucriberOnly");
            }
            availableSlotsByServerType = this.connecApi.getAvailableSlotsByServerType();
            if(availableSlotsByServerType[this._selectedServerType] == 0)
            {
               text = this.uiApi.getText("ui.sersel.noSlotOnThisServerType");
            }
            if(text)
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),text,[this.uiApi.getText("ui.common.ok")]);
               return;
            }
            text = this.uiApi.getText("ui.header.modeChoiceWarning",this.cb_mode.selectedItem.label,this.cb_mode.selectedItem.rules);
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupConnection,this.onPopupClose],this.onPopupConnection,this.onPopupClose);
            this.cb_mode.softDisabled = true;
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(!item || !item.data || target != this.cb_mode)
         {
            return;
         }
         var text:String = item.data.description;
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),item.container,false,"standard",LocationEnum.POINT_RIGHT,LocationEnum.POINT_LEFT,5,null,null,null,"TextInfo");
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onAuthenticationTicket() : void
      {
         this.playerDisplay();
      }
      
      public function onServersList(o:Object) : void
      {
         this.playerDisplay();
      }
      
      public function onPopupClose() : void
      {
         var serverGameTypeId:uint = 0;
         var modeCount:int = 0;
         var i:int = 0;
         this.cb_mode.softDisabled = false;
         var server:Server = this.sysApi.getCurrentServer();
         if(server)
         {
            serverGameTypeId = server.gameTypeId;
            modeCount = this.cb_mode.dataProvider.length;
            for(i = 0; i < modeCount; i++)
            {
               if(this.cb_mode.dataProvider[i].type == serverGameTypeId)
               {
                  this.cb_mode.selectedIndex = i;
               }
            }
         }
      }
      
      public function onChangeServer() : void
      {
         this.sysApi.setData("forceServerListDisplay",true,DataStoreEnum.BIND_ACCOUNT);
         this.sysApi.sendAction(new ChangeServerAction([]));
      }
      
      public function onPopupConnection() : void
      {
         var chosenServer:GameServerInformations = this.connecApi.getAutoChosenServer(this._selectedServerType);
         if(chosenServer)
         {
            this.sysApi.log(2,"Connexion au serveur " + chosenServer.id);
            this.sysApi.setData("forceCharacterCreationDisplay",true,DataStoreEnum.BIND_ACCOUNT);
            this.sysApi.sendAction(new ChangeCharacterAction([chosenServer.id]));
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.noServerAvailiable"),[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
         }
         this.cb_mode.softDisabled = false;
      }
      
      public function voidFunction() : void
      {
      }
   }
}
