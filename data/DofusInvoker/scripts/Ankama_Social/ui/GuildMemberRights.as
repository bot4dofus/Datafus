package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.data.XmlConfig;
   
   public class GuildMemberRights
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _memberInfo:GuildMember;
      
      private var _playerId:Number;
      
      private var _percentXP:int;
      
      private var _playerRank:GuildRankInformation;
      
      private var _myRank:GuildRankInformation;
      
      private var _myId:Number;
      
      private var _rankIndex:int;
      
      private var _currentRankOrder:uint;
      
      public var cb_rank:ComboBox;
      
      public var bgcb_rank:TextureBitmap;
      
      public var btn_modify:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_changeGuildXP:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_rank:Label;
      
      public var lbl_guildXP:Label;
      
      public function GuildMemberRights()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         var rankList:Object = null;
         var cbProvider:Array = null;
         var rankListSize:int = 0;
         var currentRank:Object = null;
         var i:int = 0;
         var guildRank:GuildRankInformation = null;
         var rankObject:Object = null;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btn_modify.soundId = SoundEnum.OK_BUTTON;
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this._memberInfo = params.memberInfo;
         this.uiApi.addComponentHook(this.btn_changeGuildXP,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_rank,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_modify,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_changeGuildXP,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_changeGuildXP,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this._myId = this.playerApi.id();
         this._myRank = params.myRank;
         this._playerId = this._memberInfo.id;
         this._percentXP = this._memberInfo.experienceGivenPercent;
         this._playerRank = this.socialApi.getGuildRankById(this._memberInfo.rankId);
         this._currentRankOrder = this._playerRank.order;
         this.lbl_guildXP.text = this._percentXP + " %";
         if(params.selfPlayerItem)
         {
            this.lbl_title.text = this.uiApi.getText("ui.guild.myGuildRights");
         }
         else
         {
            this.lbl_title.text = this.uiApi.getText("ui.guild.playerGuildRights",this._memberInfo.name);
         }
         if(this._myRank.order < this._playerRank.order && params.manageXPContribution)
         {
            this.btn_changeGuildXP.disabled = false;
         }
         else if(this._myRank.order == this._playerRank.order && params.manageMyXPContribution && params.selfPlayerItem)
         {
            this.btn_changeGuildXP.disabled = false;
         }
         else
         {
            this.btn_changeGuildXP.disabled = true;
         }
         if(params.allowToManageRank && this._playerRank.order > this._myRank.order)
         {
            rankList = this.socialApi.getGuildRanks();
            cbProvider = [];
            rankListSize = rankList.length;
            for(i = 0; i < rankListSize; i++)
            {
               guildRank = rankList[i];
               rankObject = {
                  "order":guildRank.order,
                  "label":guildRank.name,
                  "rank":guildRank,
                  "disabled":this._myRank.order != 0 && guildRank.order <= this._myRank.order,
                  "icon":guildRank.gfxId
               };
               if(guildRank.id != 1 || params.iamBoss)
               {
                  cbProvider.push(rankObject);
               }
               if(guildRank.id == this._playerRank.id)
               {
                  currentRank = rankObject;
               }
            }
            cbProvider.sortOn("order",Array.NUMERIC);
            this.cb_rank.dataProvider = cbProvider;
            this.cb_rank.selectedItem = currentRank;
            this._rankIndex = this.cb_rank.selectedIndex;
            this.cb_rank.visible = true;
            this.bgcb_rank.visible = true;
            this.lbl_rank.visible = false;
         }
         else
         {
            this.cb_rank.visible = false;
            this.bgcb_rank.visible = false;
            this.lbl_rank.visible = true;
            this.lbl_rank.text = this._playerRank.name;
         }
      }
      
      public function updateRankRightsLine(data:Object, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.lbl_cb_rankName.text = data.label;
            components.btn_grid.softDisabled = data.disabled;
            components.btn_grid.handCursor = !data.disabled;
            components.tx_cb_rankName.uri = data.icon == 116 || data.icon == 117 ? this.uiApi.createUri(XmlConfig.getInstance().getEntry("config.gfx.path") + "guildRanks/" + data.icon + ".png") : this.socialApi.getGuildRankIconUriById(data.icon);
            this.uiApi.addComponentHook(components.btn_grid,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_grid,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function onConfirmNewBoss() : void
      {
         this._playerRank = this._myRank;
         this._rankIndex = this.cb_rank.selectedIndex;
      }
      
      private function onCancelNewBoss() : void
      {
         this.cb_rank.selectedIndex = this._rankIndex;
      }
      
      private function onValidQty(qty:Number) : void
      {
         this._percentXP = qty;
         this.lbl_guildXP.text = qty + " %";
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_modify)
         {
            this.sysApi.sendAction(new GuildChangeMemberParametersAction([this._playerId,this._playerRank.id,this._percentXP]));
            this.uiApi.unloadUi("guildMemberRights");
         }
         else if(target == this.btn_close)
         {
            this.uiApi.unloadUi("guildMemberRights");
         }
         else if(target == this.btn_help)
         {
            this.hintsApi.showSubHints();
         }
         else if(target == this.btn_changeGuildXP)
         {
            this.modCommon.openQuantityPopup(0,90,this._percentXP,this.onValidQty,null,true);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.cb_rank)
         {
            if(isNewSelection && selectMethod != 2)
            {
               if((target as ComboBox).selectedItem.rank.id == 1 && this._currentRankOrder != 0)
               {
                  this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.doUGiveRights",(target as ComboBox).selectedItem.rank.name,this._memberInfo.name,(target as ComboBox).selectedItem.rank.name),[this.uiApi.getText("ui.common.validation"),this.uiApi.getText("ui.common.cancel")],[this.onConfirmNewBoss,this.onCancelNewBoss],this.onConfirmNewBoss,this.onCancelNewBoss);
               }
               else
               {
                  this._playerRank = (target as ComboBox).selectedItem.rank;
                  this._rankIndex = (target as ComboBox).selectedIndex;
               }
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.sysApi.sendAction(new GuildChangeMemberParametersAction([this._playerId,this._playerRank.id,this._percentXP]));
               this.uiApi.unloadUi("guildMemberRights");
               return true;
            case "closeUi":
               this.uiApi.unloadUi("guildMemberRights");
               return true;
            default:
               return false;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = "";
         if(target == this.btn_changeGuildXP)
         {
            if(!this.btn_changeGuildXP.disabled)
            {
               tooltipText = this.uiApi.getText("ui.guild.modifyGuildXP");
            }
            else
            {
               tooltipText = this.uiApi.getText("ui.guild.cantModifyGuildXP");
            }
         }
         else if(target.name.indexOf("btn_grid") != -1)
         {
            if(target.softDisabled)
            {
               tooltipText = this.uiApi.getText("ui.guild.modifyHigherRank");
            }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
