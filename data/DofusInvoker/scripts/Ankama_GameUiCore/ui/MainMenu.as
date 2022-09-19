package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.ServerStatusEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   
   public class MainMenu
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SecurityApi")]
      public var securityApi:SecurityApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _charsNames:Array;
      
      private var _characters:Array;
      
      private var _serversNames:Array;
      
      private var _servers:Array;
      
      private var _charPopupName:String;
      
      private var _serverPopupName:String;
      
      private var _isSafe:Boolean = false;
      
      public var btnClose:ButtonContainer;
      
      public var btnOptions:ButtonContainer;
      
      public var btnChangeCharacter:ButtonContainer;
      
      public var btnChangeServer:ButtonContainer;
      
      public var btnDisconnect:ButtonContainer;
      
      public var btnQuitGame:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public var ctr_abo:GraphicContainer;
      
      public var blk_disconnect:GraphicContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var cb_characters:ComboBox;
      
      public var cb_servers:ComboBox;
      
      public var tx_safe:Texture;
      
      public var btn_subscribe:ButtonContainer;
      
      public var lbl_abo:Label;
      
      public var tx_hourglass:Texture;
      
      public function MainMenu()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         var char:BasicCharacterWrapper = null;
         var nameText:* = null;
         var serverData:Server = null;
         var serverId:int = 0;
         this.soundApi.playSound(SoundTypeEnum.OPTIONS_OPEN);
         this.btnOptions.soundId = SoundEnum.SPEC_BUTTON;
         this.btnChangeCharacter.soundId = SoundEnum.SPEC_BUTTON;
         this.btnChangeServer.soundId = SoundEnum.SPEC_BUTTON;
         this.btnDisconnect.soundId = SoundEnum.SPEC_BUTTON;
         this.btnCancel.soundId = SoundEnum.CANCEL_BUTTON;
         var displayDisconnectButton:* = this.sysApi.getCurrentVersion().buildType >= BuildTypeEnum.TESTING;
         if(displayDisconnectButton)
         {
            this.btnDisconnect.visible = true;
            this.blk_disconnect.height = 153;
            this.btnQuitGame.y = 115;
            this.ctr_abo.y = 210;
            this.btnCancel.y = 305;
            this.mainCtr.height = 415;
         }
         else
         {
            this.btnDisconnect.visible = false;
            this.blk_disconnect.height = 125;
            this.btnQuitGame.y = 85;
            this.ctr_abo.y = 185;
            this.btnCancel.y = 280;
            this.mainCtr.height = 390;
         }
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(HookList.ServerStatusUpdate,this.onServerStatusUpdate);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cb_characters,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_servers,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.tx_hourglass,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_hourglass,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_safe,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_safe,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_safe,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.updateCharacterChangeAvailability();
         this.btnChangeServer.disabled = this.sysApi.isFightContext() && !this.fightApi.isSpectator();
         this.cb_servers.disabled = this.sysApi.isFightContext() && !this.fightApi.isSpectator();
         if(this.sysApi.getPlayerManager().isSafe)
         {
            this._isSafe = true;
            this.tx_safe.gotoAndStop = 2;
         }
         else if(this.securityApi.SecureModeisActive())
         {
            this.tx_safe.gotoAndStop = 3;
         }
         else
         {
            this.tx_safe.gotoAndStop = 1;
            this.tx_safe.handCursor = true;
         }
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
            this.lbl_abo.text = this.uiApi.getText("ui.connection.subscriberUntil",this.timeApi.getDate(this.sysApi.getPlayerManager().subscriptionEndDate,true,true) + " " + this.timeApi.getClock(this.sysApi.getPlayerManager().subscriptionEndDate,true,true));
         }
         else
         {
            this.lbl_abo.text = this.uiApi.getText("ui.common.infiniteSubscription");
         }
         this.cb_characters.useKeyboard = false;
         this.cb_servers.useKeyboard = false;
         if(this.sysApi.getPlayerManager().charactersList && this.sysApi.getPlayerManager().charactersList.length > 1)
         {
            this._charsNames = [];
            this._characters = [];
            for each(char in this.sysApi.getPlayerManager().charactersList)
            {
               if(char && char.id != this.playerApi.id() || this.sysApi.getPlayerManager().hasRights)
               {
                  nameText = char.name + " (" + char.breed.shortName + " ";
                  if(char.level > ProtocolConstantsEnum.MAX_LEVEL)
                  {
                     nameText += this.uiApi.getText("ui.common.short.prestige") + (char.level - ProtocolConstantsEnum.MAX_LEVEL) + ")";
                  }
                  else
                  {
                     nameText += this.uiApi.getText("ui.common.short.level") + char.level + ")";
                  }
                  this._charsNames.push(nameText);
                  this._characters.push(char);
               }
            }
            this.cb_characters.dataProvider = this._charsNames;
         }
         else
         {
            this.cb_characters.disabled = true;
         }
         if(this.sysApi.getPlayerManager().serversList && this.sysApi.getPlayerManager().serversList.length > 1)
         {
            this._serversNames = [];
            this._servers = [];
            for each(serverId in this.sysApi.getPlayerManager().serversList)
            {
               if(serverId != this.sysApi.getCurrentServer().id)
               {
                  serverData = this.dataApi.getServer(serverId);
                  if(serverData)
                  {
                     this._serversNames.push(serverData.name);
                  }
                  else
                  {
                     this._serversNames.push("Server " + serverId);
                  }
                  this._servers.push(serverId);
               }
            }
            this.cb_servers.dataProvider = this._serversNames;
         }
         else
         {
            this.cb_servers.disabled = true;
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.OPTIONS_CLOSE);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btnOptions:
               this.modCommon.openOptionMenu(false,"performance");
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btnChangeCharacter:
               this.uiApi.me().disabled = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmChangeCharacter"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmChangeCharacter,this.onCancel],this.onConfirmChangeCharacter,this.onCancel);
               break;
            case this.btnChangeServer:
               this.uiApi.me().disabled = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmChangeServer"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmChangeServer,this.onCancel],this.onConfirmChangeServer,this.onCancel);
               break;
            case this.btnDisconnect:
               this.uiApi.me().disabled = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmDisconnect"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmDisconnect,this.onCancel],this.onConfirmDisconnect,this.onCancel);
               break;
            case this.btnQuitGame:
               this.uiApi.me().disabled = true;
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmQuitGame"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmQuitGame,this.onCancel],this.onConfirmQuitGame,this.onCancel);
               break;
            case this.btnCancel:
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_subscribe:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
               break;
            case this.tx_safe:
               if(!this._isSafe)
               {
                  this.sysApi.goToUrl(this.uiApi.getText("ui.link.secure"));
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == SelectMethodEnum.CLICK || selectMethod == SelectMethodEnum.MANUAL || selectMethod == SelectMethodEnum.DOUBLE_CLICK)
         {
            switch(target)
            {
               case this.cb_characters:
                  if(!this._charPopupName)
                  {
                     this.uiApi.me().disabled = true;
                     this._charPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmDirectCharacter",this._charsNames[this.cb_characters.selectedIndex]),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmCharacterDirectSelection,this.onCancel],this.onConfirmCharacterDirectSelection,this.onCancel);
                  }
                  break;
               case this.cb_servers:
                  if(!this._serverPopupName)
                  {
                     this.uiApi.me().disabled = true;
                     this._serverPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmDirectServer",this._serversNames[this.cb_servers.selectedIndex]),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmServerDirectSelection,this.onCancel],this.onConfirmServerDirectSelection,this.onCancel);
                  }
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.lbl_abo:
               if(this.sysApi.getPlayerManager().subscriptionEndDate > 0)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.header.subscriptionEndDate")),target,false,"standard",2,8,0,null,null,null,"TextInfo");
               }
               return;
            case this.tx_hourglass:
               text = this.uiApi.getText("ui.common.serverstatus.saving");
               break;
            case this.tx_safe:
               if(this._isSafe)
               {
                  text = this.uiApi.getText("ui.information.safeAccount");
               }
               else if(this.securityApi.SecureModeisActive())
               {
                  text = this.uiApi.getText("ui.information.safeRestrictedAccount");
               }
               else
               {
                  text = this.uiApi.getText("ui.information.noSafeAccount");
               }
         }
         if(text && text != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_RIGHT,LocationEnum.POINT_LEFT,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onConfirmCharacterDirectSelection() : void
      {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new DirectSelectionCharacterAction([this.sysApi.getCurrentServer().id,this._characters[this.cb_characters.selectedIndex].id]));
      }
      
      private function onConfirmServerDirectSelection() : void
      {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeCharacterAction([this._servers[this.cb_servers.selectedIndex]]));
      }
      
      private function onConfirmChangeCharacter() : void
      {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeCharacterAction([this.sysApi.getCurrentServer().id]));
      }
      
      private function onConfirmChangeServer() : void
      {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeServerAction([]));
      }
      
      private function onConfirmDisconnect() : void
      {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ResetGameAction([]));
      }
      
      private function onConfirmQuitGame() : void
      {
         this.sysApi.sendAction(new QuitGameAction([]));
      }
      
      private function updateCharacterChangeAvailability() : void
      {
         var isInFight:Boolean = this.sysApi.isFightContext() && !this.fightApi.isSpectator();
         var isServerSaving:* = this.sysApi.getServerStatus() == ServerStatusEnum.SAVING;
         this.cb_characters.disabled = this.btnChangeCharacter.disabled = isInFight || isServerSaving;
         this.tx_hourglass.visible = !!isInFight ? false : Boolean(isServerSaving);
      }
      
      private function onCancel() : void
      {
         this.uiApi.me().disabled = false;
         this._charPopupName = null;
         this._serverPopupName = null;
      }
      
      public function onGameFightJoin(... rest) : void
      {
         this.btnChangeCharacter.disabled = true;
         this.btnChangeServer.disabled = true;
         this.cb_characters.disabled = true;
         this.cb_servers.disabled = true;
      }
      
      public function onGameFightEnd(... rest) : void
      {
         this.btnChangeCharacter.disabled = false;
         this.btnChangeServer.disabled = false;
         this.cb_characters.disabled = false;
         this.cb_servers.disabled = false;
      }
      
      public function onServerStatusUpdate(pStatus:uint) : void
      {
         this.updateCharacterChangeAvailability();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
