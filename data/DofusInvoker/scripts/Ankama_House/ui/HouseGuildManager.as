package Ankama_House.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class HouseGuildManager
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _myGuild:GuildWrapper;
      
      private var _houseSharingGuild:GuildWrapper;
      
      private var _house:HouseWrapper;
      
      public var btnClose:ButtonContainer;
      
      public var btnValidate:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var lblGuildHouseNotice:TextArea;
      
      public var lbl_title:Label;
      
      public var cbGuildHouseEnabled:ButtonContainer;
      
      public var cbAccessGuildmatesHouse:ButtonContainer;
      
      public var cbAccessHouseDenyOthers:ButtonContainer;
      
      public var cbGuildmatesAccessSafes:ButtonContainer;
      
      public var cbForbiddenSafes:ButtonContainer;
      
      public var cbAllowRespawn:ButtonContainer;
      
      public var cbAllowTeleport:ButtonContainer;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_emblemBackOld:Texture;
      
      public var tx_emblemUpOld:Texture;
      
      public var tx_emblemBackNew:Texture;
      
      public var tx_emblemUpNew:Texture;
      
      public var ctr_guildShare:GraphicContainer;
      
      public var ctr_rightsList:GraphicContainer;
      
      public var ctr_oneEmblem:GraphicContainer;
      
      public var ctr_twoEmblems:GraphicContainer;
      
      public function HouseGuildManager()
      {
         super();
      }
      
      public function main(arg:*) : void
      {
         this.sysApi.addHook(HookList.HouseGuildNone,this.houseGuildNone);
         this.sysApi.addHook(HookList.HouseGuildRights,this.houseGuildRights);
         this._house = arg;
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.tx_emblemBackOld.dispatchMessages = true;
         this.tx_emblemUpOld.dispatchMessages = true;
         this.tx_emblemBackNew.dispatchMessages = true;
         this.tx_emblemUpNew.dispatchMessages = true;
         this.sysApi.sendAction(new HouseGuildRightsViewAction([this._house.houseId,this._house.houseInstances[0].id]));
         this.uiApi.addComponentHook(this.btnClose,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btnValidate,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cbGuildHouseEnabled,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemBackOld,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUpOld,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemBackNew,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUpNew,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.ctr_guildShare,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_guildShare,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lblGuildHouseNotice.wordWrap = true;
         this.lblGuildHouseNotice.multiline = true;
         if(this._house.houseInstances[0].price > 0)
         {
            this.ctr_guildShare.softDisabled = true;
         }
         else
         {
            this.ctr_guildShare.softDisabled = false;
         }
         this._myGuild = this.socialApi.getGuild();
      }
      
      private function houseGuildNone() : void
      {
         this.ctr_rightsList.disabled = true;
         this.lbl_title.text = this.uiApi.getText("ui.common.guildHouse");
         this.showEmblem();
      }
      
      private function houseGuildRights(houseId:uint, guild:GuildWrapper, rights:int) : void
      {
         this.ctr_rightsList.disabled = false;
         this._houseSharingGuild = guild;
         this.lbl_title.text = this.uiApi.getText("ui.common.houseOwnerName",this._houseSharingGuild.guildName);
         this.showEmblem();
         this.updateRights(rights);
      }
      
      private function showEmblem() : void
      {
         if(!this._myGuild && !this._houseSharingGuild)
         {
            this.ctr_oneEmblem.visible = false;
            this.ctr_twoEmblems.visible = false;
            return;
         }
         if(!this._houseSharingGuild)
         {
            this.ctr_oneEmblem.visible = true;
            this.ctr_twoEmblems.visible = false;
            this.tx_emblemBack.uri = this.uiApi.createUri(this._myGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUp.uri = this.uiApi.createUri(this._myGuild.upEmblem.fullSizeIconUri.toString());
         }
         else if(!this._myGuild || this._myGuild.guildId == this._houseSharingGuild.guildId)
         {
            this.ctr_oneEmblem.visible = true;
            this.ctr_twoEmblems.visible = false;
            this.tx_emblemBack.uri = this.uiApi.createUri(this._houseSharingGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUp.uri = this.uiApi.createUri(this._houseSharingGuild.upEmblem.fullSizeIconUri.toString());
         }
         else
         {
            this.ctr_oneEmblem.visible = false;
            this.ctr_twoEmblems.visible = true;
            this.tx_emblemBackOld.uri = this.uiApi.createUri(this._houseSharingGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUpOld.uri = this.uiApi.createUri(this._houseSharingGuild.upEmblem.fullSizeIconUri.toString());
            this.tx_emblemBackNew.uri = this.uiApi.createUri(this._myGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUpNew.uri = this.uiApi.createUri(this._myGuild.upEmblem.fullSizeIconUri.toString());
         }
      }
      
      private function updateRights(rights:int) : void
      {
         this.cbGuildHouseEnabled.selected = (1 & rights >> 0) == 1;
         this.cbAccessGuildmatesHouse.selected = (1 & rights >> 3) == 1;
         this.cbAccessHouseDenyOthers.selected = (1 & rights >> 4) == 1;
         this.cbGuildmatesAccessSafes.selected = (1 & rights >> 5) == 1;
         this.cbForbiddenSafes.selected = (1 & rights >> 6) == 1;
         this.cbAllowTeleport.selected = (1 & rights >> 7) == 1;
         this.cbAllowRespawn.selected = (1 & rights >> 8) == 1;
      }
      
      private function rightsToInt() : int
      {
         var rights:int = 0;
         rights = this.setBoolean(this.cbGuildHouseEnabled.selected,rights,0);
         rights = this.setBoolean(this.cbAccessGuildmatesHouse.selected,rights,3);
         rights = this.setBoolean(this.cbAccessHouseDenyOthers.selected,rights,4);
         rights = this.setBoolean(this.cbGuildmatesAccessSafes.selected,rights,5);
         rights = this.setBoolean(this.cbForbiddenSafes.selected,rights,6);
         rights = this.setBoolean(this.cbAllowTeleport.selected,rights,7);
         return int(this.setBoolean(this.cbAllowRespawn.selected,rights,8));
      }
      
      private function setBoolean(b:Boolean, integer:int, index:int) : int
      {
         if(b)
         {
            integer |= 1 << index;
         }
         else
         {
            integer &= ~(1 << index);
         }
         return integer;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btnValidate:
               if(!this._houseSharingGuild || !this._myGuild || this._houseSharingGuild.guildId == this._myGuild.guildId)
               {
                  this.onPopupValid();
               }
               else
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.house.takeAnotherGuildHouse",this._houseSharingGuild.guildName),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupValid,this.onPopupClose],this.onPopupValid,this.onPopupClose);
               }
               return;
            case this.cbGuildHouseEnabled:
               this.ctr_rightsList.disabled = !this.cbGuildHouseEnabled.selected;
               return;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         if(target == this.ctr_guildShare && this.ctr_guildShare.softDisabled)
         {
            tooltipText = this.uiApi.getText("ui.house.noShareWhileOnSale");
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",1,7,3,null,null,null,"TextInfo");
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
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var guildToDisplay:GuildWrapper = null;
         var icon:EmblemSymbol = null;
         var icono:EmblemSymbol = null;
         var iconn:EmblemSymbol = null;
         if(this._houseSharingGuild)
         {
            guildToDisplay = this._houseSharingGuild;
         }
         else
         {
            guildToDisplay = this._myGuild;
         }
         switch(target)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),guildToDisplay.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(guildToDisplay.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUp,guildToDisplay.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUp,guildToDisplay.upEmblem.color,0,true);
               }
               break;
            case this.tx_emblemBackOld:
               this.utilApi.changeColor(this.tx_emblemBackOld.getChildByName("back"),this._houseSharingGuild.backEmblem.color,1);
               break;
            case this.tx_emblemUpOld:
               icono = this.dataApi.getEmblemSymbol(this._houseSharingGuild.upEmblem.idEmblem);
               if(icono.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUpOld,this._houseSharingGuild.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUpOld,this._houseSharingGuild.upEmblem.color,0,true);
               }
               break;
            case this.tx_emblemBackNew:
               this.utilApi.changeColor(this.tx_emblemBackNew.getChildByName("back"),this._myGuild.backEmblem.color,1);
               break;
            case this.tx_emblemUpNew:
               iconn = this.dataApi.getEmblemSymbol(this._myGuild.upEmblem.idEmblem);
               if(iconn.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUpNew,this._myGuild.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUpNew,this._myGuild.upEmblem.color,0,true);
               }
         }
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupValid() : void
      {
         this.sysApi.sendAction(new HouseGuildShareAction([this._house.houseId,this._house.houseInstances[0].id,this.cbGuildHouseEnabled.selected,this.rightsToInt()]));
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
