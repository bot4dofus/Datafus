package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.utils.Dictionary;
   
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
      
      private var _rightsList:Array;
      
      private var _memberInfo:Object;
      
      private var _playerId:Number;
      
      private var _percentXP:int;
      
      private var _playerRank:uint;
      
      private var _rankIndex:int;
      
      private var _currentRankId:uint;
      
      private var _partChangeRights:Boolean;
      
      private var _rigthBtnList:Dictionary;
      
      public var cb_rank:ComboBox;
      
      public var bgcb_rank:TextureBitmap;
      
      public var gd_list:Grid;
      
      public var btn_modify:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_changeGuildXP:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_rank:Label;
      
      public var lbl_guildXP:Label;
      
      public function GuildMemberRights()
      {
         this._rigthBtnList = new Dictionary(true);
         super();
      }
      
      public function main(params:Object) : void
      {
         var rankList:Object = null;
         var cbProvider:Array = null;
         var rankListSize:int = 0;
         var currentRank:Object = null;
         var i:int = 0;
         var rankName:Object = null;
         var rankObject:Object = null;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btn_modify.soundId = SoundEnum.OK_BUTTON;
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this._memberInfo = params.memberInfo;
         this._partChangeRights = params.rightsToChange;
         var drm:Boolean = params.displayRightsMember;
         var manageRanks:Boolean = params.allowToManageRank;
         this.uiApi.addComponentHook(this.btn_changeGuildXP,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_rank,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_modify,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         var myId:Number = this.playerApi.id();
         this._playerId = this._memberInfo.id;
         this._percentXP = this._memberInfo.experienceGivenPercent;
         this._playerRank = this._memberInfo.rank;
         this._currentRankId = this._playerRank;
         this.lbl_guildXP.text = this._percentXP + " %";
         if(this._memberInfo.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            this.lbl_title.text = this._memberInfo.name + " - <font size=\'14\'>" + this.uiApi.getText("ui.common.short.prestige") + (this._memberInfo.level - ProtocolConstantsEnum.MAX_LEVEL) + "</font>";
         }
         else
         {
            this.lbl_title.text = this._memberInfo.name + " - <font size=\'14\'>" + this.uiApi.getText("ui.common.short.level") + this._memberInfo.level + "</font>";
         }
         if(!params.manageXPContribution)
         {
            if(!(params.manageMyXPContribution && params.selfPlayerItem))
            {
               this.btn_changeGuildXP.disabled = true;
            }
         }
         this._rightsList = [];
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsAllRights"),
            "rightString":GuildWrapper.MANAGE_RIGHTS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_RIGHTS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.MANAGE_RIGHTS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsBoost"),
            "rightString":GuildWrapper.MANAGE_GUILD_BOOSTS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_GUILD_BOOSTS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.MANAGE_GUILD_BOOSTS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsRights"),
            "rightString":GuildWrapper.MANAGE_LIGHT_RIGHTS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_LIGHT_RIGHTS),
            "disabled":!drm || this._partChangeRights
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsManageRecruitment"),
            "rightString":GuildWrapper.RIGHT_MANAGE_GUILD_RECRUITMENT,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.RIGHT_MANAGE_GUILD_RECRUITMENT),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.RIGHT_MANAGE_GUILD_RECRUITMENT)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsManageApply"),
            "rightString":GuildWrapper.RIGHT_MANAGE_GUILD_APPLY,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.RIGHT_MANAGE_GUILD_APPLY),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.RIGHT_MANAGE_GUILD_APPLY)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsInvit"),
            "rightString":GuildWrapper.INVITE_NEW_MEMBERS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.INVITE_NEW_MEMBERS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.INVITE_NEW_MEMBERS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsBann"),
            "rightString":GuildWrapper.BAN_MEMBERS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.BAN_MEMBERS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.BAN_MEMBERS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsPercentXP"),
            "rightString":GuildWrapper.MANAGE_XP_CONTRIBUTION,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_XP_CONTRIBUTION),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.MANAGE_XP_CONTRIBUTION)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightManageOwnXP"),
            "rightString":GuildWrapper.MANAGE_MY_XP_CONTRIBUTION,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_MY_XP_CONTRIBUTION),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.MANAGE_MY_XP_CONTRIBUTION)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsRank"),
            "rightString":GuildWrapper.MANAGE_RANKS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.MANAGE_RANKS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.MANAGE_RANKS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsPrioritizeMe"),
            "rightString":GuildWrapper.PRIORITIZE_DEFENSE,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.PRIORITIZE_DEFENSE),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.PRIORITIZE_DEFENSE)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsHiretax"),
            "rightString":GuildWrapper.HIRE_TAX_COLLECTOR,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.HIRE_TAX_COLLECTOR),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.HIRE_TAX_COLLECTOR)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsCollect"),
            "rightString":GuildWrapper.COLLECT,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.COLLECT),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.COLLECT)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsCollectMy"),
            "rightString":GuildWrapper.COLLECT_MY_TAX_COLLECTORS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.COLLECT_MY_TAX_COLLECTORS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.COLLECT_MY_TAX_COLLECTORS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsMountParkUse"),
            "rightString":GuildWrapper.USE_FARMS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.USE_FARMS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.USE_FARMS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsMountParkArrange"),
            "rightString":GuildWrapper.ORGANIZE_FARMS,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.ORGANIZE_FARMS),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.ORGANIZE_FARMS)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsManageOtherMount"),
            "rightString":GuildWrapper.TAKE_OTHERS_RIDES_IN_FARM,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.TAKE_OTHERS_RIDES_IN_FARM),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.TAKE_OTHERS_RIDES_IN_FARM)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsSetAlliancePrism"),
            "rightString":GuildWrapper.SET_ALLIANCE_PRISM,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.SET_ALLIANCE_PRISM),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.SET_ALLIANCE_PRISM)
         });
         this._rightsList.push({
            "drm":drm,
            "name":this.uiApi.getText("ui.social.guildRightsTalkInAllianceChannel"),
            "rightString":GuildWrapper.TALK_IN_ALLIANCE_CHANNEL,
            "selected":this.socialApi.hasGuildRight(this._playerId,GuildWrapper.TALK_IN_ALLIANCE_CHANNEL),
            "disabled":!drm || this._partChangeRights && !this.socialApi.hasGuildRight(myId,GuildWrapper.TALK_IN_ALLIANCE_CHANNEL)
         });
         this.gd_list.dataProvider = this._rightsList;
         if(manageRanks && (this._playerRank != 1 || params.iamBoss))
         {
            rankList = this.dataApi.getAllRankNames();
            cbProvider = [];
            rankListSize = rankList.length;
            for(i = 0; i < rankListSize; i++)
            {
               rankName = rankList[i];
               rankObject = {
                  "order":rankName.order,
                  "label":rankName.name,
                  "rankId":rankName.id
               };
               if(rankName.id != 1 || params.iamBoss)
               {
                  cbProvider.push(rankObject);
               }
               if(rankName.id == this._playerRank)
               {
                  currentRank = rankObject;
               }
            }
            cbProvider.sortOn("order",Array.NUMERIC);
            this.cb_rank.dataProvider = cbProvider;
            this.cb_rank.value = currentRank;
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
            this.lbl_rank.text = this.dataApi.getRankName(this._playerRank).name;
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateRightLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var selectedChk:Boolean = false;
         if(!this._rigthBtnList[componentsRef.lblcb_right.name])
         {
            this.uiApi.addComponentHook(componentsRef.lblcb_right,"onRelease");
         }
         this._rigthBtnList[componentsRef.lblcb_right.name] = data;
         if(data)
         {
            componentsRef.btn_label_lblcb_right.text = data.name;
            componentsRef.lblcb_right.selected = data.selected;
            componentsRef.lblcb_right.visible = true;
            componentsRef.lblcb_right.disabled = data.disabled;
         }
         else
         {
            componentsRef.lblcb_right.visible = false;
         }
      }
      
      private function rightsToArray() : Array
      {
         var right:Object = null;
         var rightsList:Array = [];
         for each(right in this._rightsList)
         {
            if(right.selected)
            {
               rightsList.push(right.rightString);
            }
         }
         return rightsList;
      }
      
      private function onConfirmNewBoss() : void
      {
         this._playerRank = 1;
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
         var right:Object = null;
         var vsv:int = 0;
         if(target.name.indexOf("lblcb_right") != -1)
         {
            for each(right in this._rightsList)
            {
               if(right.rightString == this._rigthBtnList[target.name].rightString)
               {
                  right.selected = !right.selected;
                  break;
               }
            }
            vsv = this.gd_list.verticalScrollValue;
            this.gd_list.updateItems();
            this.gd_list.verticalScrollValue = vsv;
         }
         else if(target == this.btn_modify)
         {
            this.sysApi.sendAction(new GuildChangeMemberParametersAction([this._playerId,this._playerRank,this._percentXP,this.rightsToArray()]));
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
               if((target as ComboBox).value.rankId == 1 && this._currentRankId != 1)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.doUGiveRights",this._memberInfo.name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmNewBoss,this.onCancelNewBoss],this.onConfirmNewBoss,this.onCancelNewBoss);
               }
               else
               {
                  this._playerRank = (target as ComboBox).value.rankId;
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
               this.sysApi.sendAction(new GuildChangeMemberParametersAction([this._playerId,this._playerRank,this._percentXP,this.rightsToArray()]));
               this.uiApi.unloadUi("guildMemberRights");
               return true;
            case "closeUi":
               this.uiApi.unloadUi("guildMemberRights");
               return true;
            default:
               return false;
         }
      }
   }
}
