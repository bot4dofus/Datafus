package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildMotdSetRequestAction;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.text.TextFieldAutoSize;
   
   public class Guild
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _nCurrentTab:int = -1;
      
      private var _guild:GuildWrapper;
      
      private var guildInformationsAsked:Boolean = false;
      
      private var _expLevelFloor:Number = 0;
      
      private var _experience:Number = 0;
      
      private var _expNextLevelFloor:Number = 0;
      
      private var _level:uint = 0;
      
      public var guildCtr:GraphicContainer;
      
      public var lbl_name:Label;
      
      public var lbl_guildLevel:Label;
      
      public var pb_experience:ProgressBar;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_paddockWarning:Texture;
      
      public var tx_bulletinWarning:Texture;
      
      public var ctr_motd:GraphicContainer;
      
      public var lbl_motd:Label;
      
      public var btn_motdEdit:ButtonContainer;
      
      public var ctr_editPlaceholder:GraphicContainer;
      
      public var ctr_motdInteractive:GraphicContainer;
      
      public var tx_add:TextureBitmap;
      
      public var ctr_editMotd:GraphicContainer;
      
      public var inp_motd:Input;
      
      public var btn_motdValid:ButtonContainer;
      
      public var btn_motdExit:ButtonContainer;
      
      public var btn_members:ButtonContainer;
      
      public var btn_bulletin:ButtonContainer;
      
      public var btn_customization:ButtonContainer;
      
      public var btn_taxCollector:ButtonContainer;
      
      public var btn_paddock:ButtonContainer;
      
      public var btn_houses:ButtonContainer;
      
      public var btn_directory:ButtonContainer;
      
      public var btn_recruitmentSettings:ButtonContainer;
      
      public function Guild()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.btn_members.soundId = SoundEnum.TAB;
         this.btn_bulletin.soundId = SoundEnum.TAB;
         this.btn_customization.soundId = SoundEnum.TAB;
         this.btn_taxCollector.soundId = SoundEnum.TAB;
         this.btn_paddock.soundId = SoundEnum.TAB;
         this.btn_houses.soundId = SoundEnum.TAB;
         this.btn_directory.soundId = SoundEnum.TAB;
         this.sysApi.addHook(SocialHookList.GuildInformationsGeneral,this.onGuildInformationsGeneral);
         this.sysApi.addHook(SocialHookList.GuildMotd,this.onGuildMotd);
         this.sysApi.addHook(SocialHookList.GuildBulletin,this.onGuildBulletin);
         this.sysApi.addHook(SocialHookList.GuildRecruitmentDataReceived,this.onRecruitmentData);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this._guild = this.socialApi.getGuild();
         this.lbl_name.text = this._guild.guildName;
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.lbl_motd.text = this._guild.formattedMotd;
         var tempHeight:Number = this.lbl_motd.textfield.height;
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.NONE;
         if(this.lbl_motd.textfield.numLines == 1)
         {
            this.lbl_motd.textfield.height = tempHeight + 2;
         }
         else
         {
            this.lbl_motd.resizeText();
         }
         this.inp_motd.text = this._guild.motd;
         if(this._guild.lastNotifiedTimestamp > this.sysApi.getData("guildBulletinLastVisitTimestamp"))
         {
            this.tx_bulletinWarning.visible = true;
         }
         else
         {
            this.tx_bulletinWarning.visible = false;
         }
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.btn_members,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_bulletin,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_customization,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_taxCollector,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_paddock,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_houses,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_directory,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_directory,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_directory,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_experience,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_experience,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_guildLevel,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_guildLevel,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_motd,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_motd,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_motdEdit,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_motdEdit,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_motdValid,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_motdValid,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_motdExit,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_motdExit,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_bulletinWarning,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_bulletinWarning,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_recruitmentSettings,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_recruitmentSettings,ComponentHookList.ON_ROLL_OUT);
         this.inp_motd.html = false;
         this.inp_motd.maxChars = ProtocolConstantsEnum.USER_MAX_MOTD_LEN;
         this.tx_emblemBack.uri = this._guild.backEmblem.fullSizeIconUri;
         this.tx_emblemUp.uri = this._guild.upEmblem.fullSizeIconUri;
         this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_RECRUITMENT]));
         this.btn_directory.softDisabled = this.playerApi.isInKoli();
         this.btn_recruitmentSettings.softDisabled = this.playerApi.isInKoli();
         this.openSelectedTab(args[0][0]);
         this.setUpRecruitmentSettingsButton();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi("subGuildUi");
      }
      
      private function openSelectedTab(tab:uint) : void
      {
         if(!this.guildInformationsAsked)
         {
            this.guildInformationsAsked = true;
            this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_GENERAL]));
         }
         if(this._nCurrentTab == tab)
         {
            return;
         }
         switch(tab)
         {
            case DataEnum.GUILD_TAB_PERSONALIZATION_ID:
               this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY]));
               break;
            case DataEnum.GUILD_TAB_HOUSES_ID:
               this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_HOUSES]));
         }
         if(tab == DataEnum.GUILD_TAB_DIRECTORY_ID && this.playerApi.isInKoli())
         {
            tab == DataEnum.GUILD_TAB_MEMBERS_ID;
         }
         this.uiApi.unloadUi("subGuildUi");
         this.uiApi.loadUiInside(this.getUiNameByTab(tab),this.guildCtr,"subGuildUi",null) as UiRootContainer;
         this.getButtonByTab(tab).selected = true;
         this._nCurrentTab = tab;
         this.uiApi.getUi("socialBase").uiClass.setSubTab(this._nCurrentTab);
      }
      
      private function getUiNameByTab(tab:uint) : String
      {
         if(tab == DataEnum.GUILD_TAB_MEMBERS_ID)
         {
            return EnumTab.GUILD_MEMBERS_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_PERSONALIZATION_ID)
         {
            return EnumTab.GUILD_PERSONALIZATION_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_COLLECTOR_ID)
         {
            return EnumTab.GUILD_TAX_COLLECTOR_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_PADDOCK_ID)
         {
            return EnumTab.GUILD_PADDOCK_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_HOUSES_ID)
         {
            return EnumTab.GUILD_HOUSES_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_BULLETIN_ID)
         {
            return EnumTab.GUILD_BULLETIN_TAB;
         }
         if(tab == DataEnum.GUILD_TAB_DIRECTORY_ID)
         {
            return EnumTab.GUILD_DIRECTORY_TAB;
         }
         return null;
      }
      
      private function getButtonByTab(tab:uint) : ButtonContainer
      {
         if(tab == DataEnum.GUILD_TAB_MEMBERS_ID)
         {
            return this.btn_members;
         }
         if(tab == DataEnum.GUILD_TAB_PERSONALIZATION_ID)
         {
            return this.btn_customization;
         }
         if(tab == DataEnum.GUILD_TAB_COLLECTOR_ID)
         {
            return this.btn_taxCollector;
         }
         if(tab == DataEnum.GUILD_TAB_PADDOCK_ID)
         {
            return this.btn_paddock;
         }
         if(tab == DataEnum.GUILD_TAB_HOUSES_ID)
         {
            return this.btn_houses;
         }
         if(tab == DataEnum.GUILD_TAB_BULLETIN_ID)
         {
            return this.btn_bulletin;
         }
         if(tab == DataEnum.GUILD_TAB_DIRECTORY_ID)
         {
            return this.btn_directory;
         }
         return null;
      }
      
      private function switchMotdEditMode(editMode:Boolean) : void
      {
         if(editMode)
         {
            this.inp_motd.htmlText = this._guild.motd;
            this.inp_motd.focus();
            this.inp_motd.setSelection(8388607,8388607);
            this.ctr_editMotd.visible = true;
            this.ctr_motd.visible = false;
         }
         else
         {
            this.ctr_editMotd.visible = false;
            this.ctr_motd.visible = true;
         }
      }
      
      private function setUpRecruitmentSettingsButton() : void
      {
         if(this._guild === null || !this._guild.manageGuildRecruitment || !this._guild.guildRecruitmentInfo)
         {
            this.btn_recruitmentSettings.visible = false;
            this.ctr_editPlaceholder.width = 540;
            this.ctr_motdInteractive.width = 505;
            this.lbl_motd.width = 525;
            this.btn_motdEdit.x = 540;
            this.tx_add.width = 550;
            this.inp_motd.width = 525;
            this.btn_motdValid.x = 540;
            this.btn_motdExit.x = 540;
         }
         else
         {
            this.btn_recruitmentSettings.visible = true;
            this.btn_recruitmentSettings.softDisabled = this.secureApi.SecureModeisActive() || this.playerApi.isInKoli();
            this.ctr_editPlaceholder.width = 390;
            this.ctr_motdInteractive.width = 355;
            this.lbl_motd.width = 370;
            this.btn_motdEdit.x = 390;
            this.tx_add.width = 400;
            this.inp_motd.width = 370;
            this.btn_motdValid.x = 390;
            this.btn_motdExit.x = 390;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         switch(target)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),this._guild.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(this._guild.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._guild.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._guild.upEmblem.color,0,true);
               }
         }
      }
      
      private function onGuildInformationsGeneral(expLevelFloor:Number, experience:Number, expNextLevelFloor:Number, level:uint, creationDate:uint, warning:Boolean, nbConnectedMembers:int, nbMembers:int) : void
      {
         this._expLevelFloor = expLevelFloor;
         this._experience = experience;
         this._expNextLevelFloor = expNextLevelFloor;
         this._level = level;
         this.lbl_guildLevel.text = this.uiApi.getText("ui.common.short.level") + " " + level.toString();
         if(this._level < ProtocolConstantsEnum.MAX_GUILD_LEVEL)
         {
            this.pb_experience.value = (experience - expLevelFloor) / (expNextLevelFloor - expLevelFloor);
         }
         else
         {
            this.pb_experience.value = 1;
         }
         if(warning)
         {
            this.tx_paddockWarning.visible = true;
         }
         else
         {
            this.tx_paddockWarning.visible = false;
         }
      }
      
      private function onGuildMotd() : void
      {
         this._guild = this.socialApi.getGuild();
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.lbl_motd.text = this._guild.formattedMotd;
         var tempHeight:Number = this.lbl_motd.textfield.height;
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.NONE;
         if(this.lbl_motd.textfield.numLines == 1)
         {
            this.lbl_motd.textfield.height = tempHeight + 2;
         }
         else
         {
            this.lbl_motd.resizeText();
         }
         this.inp_motd.text = this._guild.motd;
      }
      
      private function onGuildBulletin() : void
      {
         if(this._nCurrentTab == DataEnum.GUILD_TAB_BULLETIN_ID)
         {
            return;
         }
         this._guild = this.socialApi.getGuild();
         if(this._guild.lastNotifiedTimestamp > this.sysApi.getData("guildBulletinLastVisitTimestamp"))
         {
            this.tx_bulletinWarning.visible = true;
         }
         else
         {
            this.tx_bulletinWarning.visible = false;
         }
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         this.uiApi.me().childUiRoot.uiClass.showTabHints();
      }
      
      private function onRecruitmentData(recruitmentData:GuildRecruitmentDataWrapper) : void
      {
         this.setUpRecruitmentSettingsButton();
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         if(!hasGuild)
         {
            this.uiApi.unloadUi(UIEnum.SOCIAL_BASE);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var escapeText:String = null;
         switch(target)
         {
            case this.btn_members:
               this.openSelectedTab(DataEnum.GUILD_TAB_MEMBERS_ID);
               break;
            case this.btn_bulletin:
               this.tx_bulletinWarning.visible = false;
               this.openSelectedTab(DataEnum.GUILD_TAB_BULLETIN_ID);
               break;
            case this.btn_customization:
               this.openSelectedTab(DataEnum.GUILD_TAB_PERSONALIZATION_ID);
               break;
            case this.btn_taxCollector:
               this.openSelectedTab(DataEnum.GUILD_TAB_COLLECTOR_ID);
               break;
            case this.btn_paddock:
               this.tx_paddockWarning.visible = false;
               this.openSelectedTab(DataEnum.GUILD_TAB_PADDOCK_ID);
               break;
            case this.btn_houses:
               this.openSelectedTab(DataEnum.GUILD_TAB_HOUSES_ID);
               break;
            case this.btn_directory:
               this.openSelectedTab(DataEnum.GUILD_TAB_DIRECTORY_ID);
               break;
            case this.btn_motdEdit:
               this.switchMotdEditMode(true);
               break;
            case this.btn_motdExit:
               this.switchMotdEditMode(false);
               break;
            case this.btn_motdValid:
               escapeText = this.chatApi.escapeChatString(this.inp_motd.text);
               if(escapeText != this._guild.motd)
               {
                  this.sysApi.sendAction(new GuildMotdSetRequestAction([escapeText]));
               }
               this.switchMotdEditMode(false);
               break;
            case this.btn_recruitmentSettings:
               if(this.uiApi.getUi(UIEnum.GUILD_PREZ_AND_RECRUIT) || !this._guild || !this._guild.guildRecruitmentInfo)
               {
                  return;
               }
               this.uiApi.loadUi(UIEnum.GUILD_PREZ_AND_RECRUIT,null,{"recruitmentData":this._guild.guildRecruitmentInfo});
               break;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:* = null;
         var date:Number = NaN;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.pb_experience:
               tooltipText = this.utilApi.kamasToString(this._experience,"") + " / " + this.utilApi.kamasToString(this._expNextLevelFloor,"");
               break;
            case this.lbl_guildLevel:
               tooltipText = this.uiApi.getText("ui.common.creationDate") + this.uiApi.getText("ui.common.colon") + this.timeApi.getDate(this._guild.creationDate * 1000) + " " + this.timeApi.getClock(this._guild.creationDate * 1000);
               break;
            case this.btn_motdEdit:
               tooltipText = this.uiApi.getText("ui.motd.edit");
               break;
            case this.btn_motdValid:
               tooltipText = this.uiApi.getText("ui.common.validation");
               break;
            case this.btn_motdExit:
               tooltipText = this.uiApi.getText("ui.common.cancel");
               break;
            case this.tx_bulletinWarning:
               tooltipText = this.uiApi.getText("ui.motd.bulletinUpdated");
               break;
            case this.lbl_motd:
               tooltipText = "";
               if(this.lbl_motd.hasTooltipExtension)
               {
                  tooltipText += this.lbl_motd.text;
               }
               if(this._guild.motdWriterName != "")
               {
                  if(tooltipText != "")
                  {
                     tooltipText += "\n";
                  }
                  date = this._guild.motdTimestamp * 1000;
                  tooltipText += this.uiApi.getText("ui.motd.lastModification",this.timeApi.getDate(date,true) + " " + this.timeApi.getClock(date,true,true),this._guild.motdWriterName);
               }
               break;
            case this.tx_paddockWarning:
               tooltipText = this.uiApi.getText("ui.mount.paddocksAbandonned");
               break;
            case this.btn_directory:
               if(this.playerApi.isInKoli())
               {
                  tooltipText = this.uiApi.getText("ui.guild.lockDirectory");
               }
               break;
            case this.btn_recruitmentSettings:
               if(this.btn_recruitmentSettings.softDisabled)
               {
                  if(this.secureApi.SecureModeisActive())
                  {
                     tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
                  }
                  else if(this.playerApi.isInKoli())
                  {
                     tooltipText = this.uiApi.getText("ui.guild.lockRecruitmentSettings");
                  }
               }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var escapeText:String = null;
         switch(s)
         {
            case "validUi":
               if(this.inp_motd.visible && this.inp_motd.haveFocus)
               {
                  escapeText = this.chatApi.escapeChatString(this.inp_motd.text);
                  if(escapeText != this._guild.motd)
                  {
                     this.sysApi.sendAction(new GuildMotdSetRequestAction([escapeText]));
                  }
                  this.switchMotdEditMode(false);
                  return true;
               }
               return false;
               break;
            case "closeUi":
               if(this.inp_motd.visible && this.inp_motd.haveFocus)
               {
                  this.switchMotdEditMode(false);
                  return true;
               }
               this.uiApi.unloadUi("socialBase");
               return true;
               break;
            default:
               return false;
         }
      }
   }
}
