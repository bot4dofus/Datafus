package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.PrismListenEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.text.TextFieldAutoSize;
   
   public class Alliance
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
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _nCurrentTab:int = -1;
      
      private var _alliance:Object;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_name:Label;
      
      public var lbl_tag:Label;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_bulletinWarning:Texture;
      
      public var btn_members:ButtonContainer;
      
      public var btn_bulletin:ButtonContainer;
      
      public var btn_areas:ButtonContainer;
      
      public var btn_fights:ButtonContainer;
      
      public var btn_directory:ButtonContainer;
      
      public var ctr_motd:GraphicContainer;
      
      public var lbl_motd:Label;
      
      public var btn_motdEdit:ButtonContainer;
      
      public var ctr_editMotd:GraphicContainer;
      
      public var inp_motd:Input;
      
      public var btn_motdValid:ButtonContainer;
      
      public var btn_motdExit:ButtonContainer;
      
      public function Alliance()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.btn_members.soundId = SoundEnum.TAB;
         this.btn_bulletin.soundId = SoundEnum.TAB;
         this.btn_areas.soundId = SoundEnum.TAB;
         this.btn_fights.soundId = SoundEnum.TAB;
         this.btn_directory.soundId = SoundEnum.TAB;
         this.sysApi.addHook(SocialHookList.AllianceUpdateInformations,this.onAllianceUpdateInformations);
         this.sysApi.addHook(SocialHookList.AllianceMotd,this.onAllianceMotd);
         this.sysApi.addHook(SocialHookList.AllianceBulletin,this.onAllianceBulletin);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.btn_members,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_bulletin,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_areas,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_fights,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_directory,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_name,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_name,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
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
         this.inp_motd.html = false;
         this.inp_motd.maxChars = ProtocolConstantsEnum.USER_MAX_MOTD_LEN;
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.sysApi.sendAction(new PrismsListRegisterAction(["Alliance",PrismListenEnum.PRISM_LISTEN_MINE]));
         this._alliance = this.socialApi.getAlliance();
         this.updateAllianceInfos();
         if(this.socialApi.hasGuildRank(this.playerApi.id(),0))
         {
            this.btn_motdEdit.visible = true;
         }
         else
         {
            this.btn_motdEdit.visible = false;
         }
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.lbl_motd.text = this._alliance.formattedMotd;
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
         this.inp_motd.text = this._alliance.motd;
         if(this._alliance.lastNotifiedTimestamp > this.sysApi.getData("allianceBulletinLastVisitTimestamp"))
         {
            this.tx_bulletinWarning.visible = true;
         }
         else
         {
            this.tx_bulletinWarning.visible = false;
         }
         this.openSelectedTab(args[0][0],args[0][1]);
      }
      
      public function unload() : void
      {
         this.sysApi.sendAction(new PrismsListRegisterAction(["Alliance",PrismListenEnum.PRISM_LISTEN_NONE]));
         this.uiApi.unloadUi("subAllianceUi");
      }
      
      private function updateAllianceInfos() : void
      {
         this.lbl_name.text = this._alliance.allianceName;
         this.lbl_tag.text = this.chatApi.getAllianceLink(this._alliance,"[" + this._alliance.allianceTag + "]");
         this.tx_emblemBack.uri = this._alliance.backEmblem.fullSizeIconUri;
         this.tx_emblemUp.uri = this._alliance.upEmblem.fullSizeIconUri;
      }
      
      private function openSelectedTab(tab:uint, params:Object = null) : void
      {
         if(this._nCurrentTab == tab)
         {
            return;
         }
         this.uiApi.unloadUi("subAllianceUi");
         this.uiApi.loadUiInside(this.getUiNameByTab(tab),this.mainCtr,"subAllianceUi",params);
         this.getButtonByTab(tab).selected = true;
         this._nCurrentTab = tab;
         this.uiApi.getUi("socialBase").uiClass.setSubTab(this._nCurrentTab);
      }
      
      private function getUiNameByTab(tab:uint) : String
      {
         if(tab == DataEnum.ALLIANCE_TAB_MEMBERS_ID)
         {
            return EnumTab.ALLIANCE_MEMBERS_TAB;
         }
         if(tab == DataEnum.ALLIANCE_TAB_AREAS_ID)
         {
            return EnumTab.ALLIANCE_AREAS_TAB;
         }
         if(tab == DataEnum.ALLIANCE_TAB_FIGHTS_ID)
         {
            return EnumTab.ALLIANCE_FIGHTS_TAB;
         }
         if(tab == DataEnum.ALLIANCE_TAB_BULLETIN_ID)
         {
            return EnumTab.ALLIANCE_BULLETIN_TAB;
         }
         if(tab == DataEnum.ALLIANCE_TAB_DIRECTORY_ID)
         {
            return EnumTab.ALLIANCE_DIRECTORY_TAB;
         }
         return null;
      }
      
      private function getButtonByTab(tab:uint) : ButtonContainer
      {
         if(tab == DataEnum.ALLIANCE_TAB_MEMBERS_ID)
         {
            return this.btn_members;
         }
         if(tab == DataEnum.ALLIANCE_TAB_AREAS_ID)
         {
            return this.btn_areas;
         }
         if(tab == DataEnum.ALLIANCE_TAB_FIGHTS_ID)
         {
            return this.btn_fights;
         }
         if(tab == DataEnum.ALLIANCE_TAB_BULLETIN_ID)
         {
            return this.btn_bulletin;
         }
         if(tab == DataEnum.ALLIANCE_TAB_DIRECTORY_ID)
         {
            return this.btn_directory;
         }
         return null;
      }
      
      private function switchMotdEditMode(editMode:Boolean) : void
      {
         if(editMode)
         {
            this.inp_motd.htmlText = this._alliance.motd;
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
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         switch(target)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),this._alliance.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(this._alliance.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUp,this._alliance.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUp,this._alliance.upEmblem.color,0,true);
               }
         }
      }
      
      private function onAllianceUpdateInformations() : void
      {
         this._alliance = this.socialApi.getAlliance();
         this.updateAllianceInfos();
      }
      
      private function onAllianceMotd() : void
      {
         this._alliance = this.socialApi.getAlliance();
         this.lbl_motd.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.lbl_motd.text = this._alliance.formattedMotd;
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
         this.inp_motd.text = this._alliance.motd;
      }
      
      private function onAllianceBulletin() : void
      {
         if(this._nCurrentTab == DataEnum.ALLIANCE_TAB_BULLETIN_ID)
         {
            return;
         }
         this._alliance = this.socialApi.getAlliance();
         if(this._alliance.lastNotifiedTimestamp > this.sysApi.getData("allianceBulletinLastVisitTimestamp"))
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
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_members)
         {
            this.openSelectedTab(DataEnum.ALLIANCE_TAB_MEMBERS_ID);
         }
         else if(target == this.btn_bulletin)
         {
            this.tx_bulletinWarning.visible = false;
            this.openSelectedTab(DataEnum.ALLIANCE_TAB_BULLETIN_ID);
         }
         else if(target == this.btn_areas)
         {
            this.openSelectedTab(DataEnum.ALLIANCE_TAB_AREAS_ID);
         }
         else if(target == this.btn_fights)
         {
            this.openSelectedTab(DataEnum.ALLIANCE_TAB_FIGHTS_ID);
         }
         else if(target == this.btn_directory)
         {
            this.openSelectedTab(DataEnum.ALLIANCE_TAB_DIRECTORY_ID);
         }
         else if(target == this.btn_motdEdit)
         {
            this.switchMotdEditMode(true);
         }
         else if(target == this.btn_motdExit)
         {
            this.switchMotdEditMode(false);
         }
         else if(target == this.btn_motdValid)
         {
            if(this.inp_motd.text != this._alliance.motd)
            {
               this.sysApi.sendAction(new AllianceMotdSetRequestAction([this.inp_motd.text]));
            }
            this.switchMotdEditMode(false);
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
            case this.lbl_name:
               tooltipText = this.uiApi.getText("ui.common.creationDate") + this.uiApi.getText("ui.common.colon") + this.timeApi.getDate(this._alliance.creationDate * 1000) + " " + this.timeApi.getClock(this._alliance.creationDate * 1000);
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
               if(this._alliance.motdWriterName != "")
               {
                  if(tooltipText != "")
                  {
                     tooltipText += "\n";
                  }
                  date = this._alliance.motdTimestamp * 1000;
                  tooltipText += this.uiApi.getText("ui.motd.lastModification",this.timeApi.getDate(date,true) + " " + this.timeApi.getClock(date,true,true),this._alliance.motdWriterName);
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
         switch(s)
         {
            case "validUi":
               if(this.inp_motd.visible && this.inp_motd.haveFocus)
               {
                  if(this.inp_motd.text != this._alliance.motd)
                  {
                     this.sysApi.sendAction(new AllianceMotdSetRequestAction([this.inp_motd.text]));
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
