package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.MemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Dictionary;
   
   public class GuildMembers
   {
      
      private static var _showOfflineMembers:Boolean = false;
      
      public static var playerRights:uint;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _membersList:Object;
      
      private var _iconsPath:String;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _interactiveComponentsList:Dictionary;
      
      private var _memberIdWaitingForKick:Number;
      
      public var gd_list:Grid;
      
      public var btn_showOfflineMembers:ButtonContainer;
      
      public var btn_warnWhenMemberIsOnline:ButtonContainer;
      
      public var lbl_membersNumber:Label;
      
      public var lbl_membersLevel:Label;
      
      public var btn_tabBreed:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabRank:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabXP:ButtonContainer;
      
      public var btn_tabXPP:ButtonContainer;
      
      public var btn_tabAchievement:ButtonContainer;
      
      public var btn_tabState:ButtonContainer;
      
      public var tx_status:Texture;
      
      public function GuildMembers()
      {
         this._interactiveComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(SocialHookList.GuildInformationsMembers,this.onGuildMembersUpdated);
         this.sysApi.addHook(SocialHookList.MemberWarningState,this.onMemberWarningState);
         this.sysApi.addHook(SocialHookList.GuildInformationsMemberUpdate,this.onGuildInformationsMemberUpdate);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.uiApi.addComponentHook(this.btn_showOfflineMembers,"onRelease");
         this.uiApi.addComponentHook(this.btn_warnWhenMemberIsOnline,"onRelease");
         this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_MEMBERS]));
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this.btn_showOfflineMembers.selected = _showOfflineMembers;
         this.btn_warnWhenMemberIsOnline.selected = this.socialApi.getWarnOnMemberConnec();
      }
      
      public function updateGuildMemberLine(data:*, components:*, selected:Boolean) : void
      {
         var memberInfo:Object = null;
         var displayRightsMember:Boolean = false;
         var selfPlayerItem:* = false;
         var smiley:Smiley = null;
         if(!this._interactiveComponentsList[components.btn_kick.name])
         {
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_kick,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.btn_kick.name] = data;
         if(!this._interactiveComponentsList[components.btn_rights.name])
         {
            this.uiApi.addComponentHook(components.btn_rights,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_rights,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_rights,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.btn_rights.name] = data;
         if(!this._interactiveComponentsList[components.lbl_playerName.name])
         {
            this.uiApi.addComponentHook(components.lbl_playerName,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_playerName,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.lbl_playerName.name] = data;
         if(!this._interactiveComponentsList[components.tx_status.name])
         {
            this.uiApi.addComponentHook(components.tx_status,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_status,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_status.name] = data;
         if(!this._interactiveComponentsList[components.tx_state.name])
         {
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_state,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_state.name] = data;
         if(!this._interactiveComponentsList[components.tx_mood.name])
         {
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_mood,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_mood.name] = data;
         if(!this._interactiveComponentsList[components.tx_fight.name])
         {
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_fight,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_fight.name] = data;
         if(!this._interactiveComponentsList[components.tx_havenbag.name])
         {
            this.uiApi.addComponentHook(components.tx_havenbag,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_havenbag,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.tx_havenbag,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[components.tx_havenbag.name] = data;
         if(data != null)
         {
            memberInfo = data.member;
            displayRightsMember = data.displayRightsMember || this.isBoss(playerRights) || this.manageGuildBoosts(playerRights) || this.manageRanks(playerRights) || this.manageRights(playerRights) || this.manageLightRights(playerRights) || this.manageXPContribution(playerRights);
            selfPlayerItem = this.playerApi.id() == memberInfo.id;
            components.lbl_rank.text = data.rankName;
            components.lbl_XPP.text = memberInfo.experienceGivenPercent + "%";
            components.lbl_XP.text = this.utilApi.kamasToString(memberInfo.givenExperience,"");
            components.tx_mood.uri = null;
            components.tx_fight.uri = null;
            components.tx_status.uri = null;
            components.tx_lvl.uri = null;
            if(memberInfo.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               components.lbl_lvl.cssClass = "darkboldcenter";
               components.lbl_lvl.text = memberInfo.level - ProtocolConstantsEnum.MAX_LEVEL;
               components.tx_lvl.uri = this._bgPrestigeUri;
               this.uiApi.addComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               this.uiApi.removeComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OUT);
               components.lbl_lvl.cssClass = "boldcenter";
               components.lbl_lvl.text = memberInfo.level;
               components.tx_lvl.uri = this._bgLevelUri;
            }
            components.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + data.breed + "" + data.sex + ".png");
            if(data.achievementPoints == -1)
            {
               components.lbl_achievement.text = "-";
            }
            else
            {
               components.lbl_achievement.text = data.achievementPoints;
            }
            if(memberInfo.connected != PlayerStateEnum.NOT_CONNECTED && memberInfo.moodSmileyId != 0)
            {
               smiley = this.dataApi.getSmiley(memberInfo.moodSmileyId);
               if(smiley)
               {
                  components.tx_mood.uri = this.uiApi.createUri(this.uiApi.me().getConstant("smilies_uri") + smiley.gfxId);
               }
            }
            if(memberInfo.connected == PlayerStateEnum.NOT_CONNECTED)
            {
               components.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("offline_uri"));
               components.lbl_playerName.text = memberInfo.name;
            }
            else if(memberInfo.connected == PlayerStateEnum.GAME_TYPE_ROLEPLAY)
            {
               components.lbl_playerName.text = "{player," + memberInfo.name + "," + memberInfo.id + "::" + memberInfo.name + "}";
               components.tx_state.uri = null;
            }
            else if(memberInfo.connected == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               components.lbl_playerName.text = "{player," + memberInfo.name + "," + memberInfo.id + "::" + memberInfo.name + "}";
               if(memberInfo.moodSmileyId == 0)
               {
                  components.tx_state.uri = this.uiApi.createUri(this.uiApi.me().getConstant("fight_uri"));
               }
               else
               {
                  components.tx_state.uri = null;
                  components.tx_fight.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "Social_tx_fightState_small");
               }
            }
            else if(memberInfo.connected == PlayerStateEnum.UNKNOWN_STATE)
            {
               components.lbl_playerName.text = memberInfo.name;
               components.tx_state.uri = null;
            }
            else
            {
               components.lbl_playerName.text = memberInfo.name;
               components.tx_state.uri = null;
            }
            if(memberInfo.havenBagShared)
            {
               components.tx_havenbag.visible = true;
            }
            else
            {
               components.tx_havenbag.visible = false;
            }
            if(memberInfo.connected != PlayerStateEnum.NOT_CONNECTED)
            {
               if(memberInfo.status.statusId)
               {
                  switch(memberInfo.status.statusId)
                  {
                     case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                        components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "green.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                        components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "yellow.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                        components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "blue.png");
                        break;
                     case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                        components.tx_status.uri = this.uiApi.createUri(this._iconsPath + "red.png");
                  }
               }
               else
               {
                  components.tx_status.uri = null;
               }
            }
            if(data.displayBanMember)
            {
               components.btn_kick.visible = true;
            }
            else
            {
               components.btn_kick.visible = selfPlayerItem;
            }
            if(displayRightsMember)
            {
               components.btn_rights.visible = true;
            }
            else
            {
               components.btn_rights.visible = selfPlayerItem;
            }
         }
         else
         {
            components.lbl_playerName.text = "";
            components.lbl_rank.text = "";
            components.tx_lvl.uri = null;
            components.lbl_lvl.text = "";
            components.lbl_XPP.text = "";
            components.lbl_XP.text = "";
            components.tx_head.uri = null;
            components.tx_state.uri = null;
            components.tx_mood.uri = null;
            components.tx_fight.uri = null;
            components.tx_havenbag.visible = false;
            components.btn_rights.visible = false;
            components.btn_kick.visible = false;
            components.tx_status.uri = null;
            components.lbl_achievement.text = "";
         }
      }
      
      private function popupDeletePlayer(data:Object) : void
      {
         var text:String = null;
         if(data.isBoss && !data.isAlone)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.guildBossCantBeBann"),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            if(this.playerApi.id() == data.member.id)
            {
               text = this.uiApi.getText("ui.social.doUDeleteYou");
            }
            else
            {
               text = this.uiApi.getText("ui.social.doUDeleteMember",data.member.name);
            }
            this._memberIdWaitingForKick = data.member.id;
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmDeletePlayer,this.onCancelDeletePlayer],this.onConfirmDeletePlayer,this.onCancelDeletePlayer);
         }
      }
      
      private function onConfirmDeletePlayer() : void
      {
         this.sysApi.sendAction(new GuildKickRequestAction([this._memberIdWaitingForKick]));
         this._memberIdWaitingForKick = 0;
      }
      
      private function onCancelDeletePlayer() : void
      {
         this._memberIdWaitingForKick = 0;
      }
      
      private function displayMemberRights(data:Object) : void
      {
         if(this.uiApi.getUi("guildMemberRights") != null)
         {
            this.uiApi.unloadUi("guildMemberRights");
         }
         var manageOtherPlayersRights:Boolean = this.isBoss(playerRights) || this.manageGuildBoosts(playerRights) || this.manageRights(playerRights) || this.manageLightRights(playerRights);
         var lightManage:Boolean = this.manageLightRights(playerRights) && !this.isBoss(playerRights) && !this.manageRights(playerRights);
         this.uiApi.loadUi("guildMemberRights","guildMemberRights",{
            "memberInfo":data.member,
            "displayRightsMember":manageOtherPlayersRights,
            "allowToManageRank":data.manageRanks,
            "manageXPContribution":data.manageXPContribution,
            "manageMyXPContribution":data.manageMyXPContribution,
            "selfPlayerItem":this.playerApi.id() == data.member.id,
            "iamBoss":this.isBoss(playerRights),
            "rightsToChange":lightManage
         },StrataEnum.STRATA_TOP);
      }
      
      private function isBoss(pPlayerRights:uint) : Boolean
      {
         return (1 & pPlayerRights) > 0;
      }
      
      private function manageGuildBoosts(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (2 & pPlayerRights) > 0;
      }
      
      private function manageRights(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (4 & pPlayerRights) > 0;
      }
      
      private function inviteNewMembers(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (8 & pPlayerRights) > 0;
      }
      
      private function banMembers(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (16 & pPlayerRights) > 0;
      }
      
      private function manageXPContribution(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (32 & pPlayerRights) > 0;
      }
      
      private function manageRanks(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (64 & pPlayerRights) > 0;
      }
      
      private function manageMyXpContribution(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (128 & pPlayerRights) > 0;
      }
      
      private function hireTaxCollector(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (256 & pPlayerRights) > 0;
      }
      
      private function collect(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (512 & pPlayerRights) > 0;
      }
      
      private function manageLightRights(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (1024 & pPlayerRights) > 0;
      }
      
      private function useFarms(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (4096 & pPlayerRights) > 0;
      }
      
      private function organizeFarms(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (8192 & pPlayerRights) > 0;
      }
      
      private function takeOthersRidesInFarm(pPlayerRights:uint) : Boolean
      {
         return this.isBoss(pPlayerRights) || (16384 & pPlayerRights) > 0;
      }
      
      private function onGuildMembersUpdated(members:Object) : void
      {
         var member:GuildMember = null;
         this._membersList = members;
         var listDisplayed:Array = [];
         var totalMembers:int = members.length;
         var totalLevels:int = 0;
         var connected:int = 0;
         for each(member in this._membersList)
         {
            if(member.id == this.playerApi.id())
            {
               playerRights = member.rights;
            }
            totalLevels += member.level;
            if(member.connected || _showOfflineMembers)
            {
               listDisplayed.push(this.createMemberObject(member,totalMembers == 1));
               if(member.connected)
               {
                  connected++;
               }
            }
         }
         listDisplayed.sortOn("rankOrder",Array.NUMERIC);
         this.gd_list.dataProvider = listDisplayed;
         this.lbl_membersLevel.text = this.uiApi.getText("ui.social.guildAvgMembersLevel") + this.uiApi.getText("ui.common.colon") + int(totalLevels / totalMembers);
         this.lbl_membersNumber.text = this.uiApi.getText("ui.social.guildMembers") + this.uiApi.getText("ui.common.colon") + connected + " / " + totalMembers;
      }
      
      public function onGuildInformationsMemberUpdate(memberInfo:Object) : void
      {
         var member:GuildMember = null;
         var index:int = 0;
         var i:int = 0;
         for each(member in this._membersList)
         {
            if(member.id == memberInfo.id)
            {
               member = memberInfo as GuildMember;
               index = 0;
               for(i = 0; i < this.gd_list.dataProvider.length; i++)
               {
                  if(this.gd_list.dataProvider[i].id == memberInfo.id)
                  {
                     index = i;
                  }
               }
               this.gd_list.updateItem(index);
               return;
            }
         }
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         var listDisplayed:Array = null;
         var member:Object = null;
         if(hasGuild)
         {
            listDisplayed = [];
            for each(member in this.gd_list.dataProvider)
            {
               listDisplayed.push(this.updateMemberObjectWithMyRights(member));
            }
            this.gd_list.dataProvider = listDisplayed;
         }
      }
      
      private function onMemberWarningState(enable:Boolean) : void
      {
         if(this.btn_warnWhenMemberIsOnline.selected != enable)
         {
            this.btn_warnWhenMemberIsOnline.selected = enable;
         }
      }
      
      private function createMemberObject(member:Object, isAlone:Boolean) : Object
      {
         var guild:Object = this.socialApi.getGuild();
         var memberObject:Object = {};
         memberObject.id = member.id;
         memberObject.member = member;
         memberObject.manageXPContribution = guild.manageXPContribution;
         memberObject.manageMyXPContribution = guild.manageMyXpContribution;
         memberObject.manageRanks = guild.manageRanks;
         memberObject.displayBanMember = guild.banMembers;
         memberObject.displayRightsMember = guild.manageRights;
         memberObject.displayLightRightsMember = guild.manageLightRights;
         memberObject.name = member.name;
         memberObject.breed = member.breed;
         var rank:Object = this.dataApi.getRankName(member.rank);
         memberObject.isBoss = member.rank == 1;
         memberObject.rankName = rank.name;
         memberObject.rankOrder = rank.order;
         memberObject.level = member.level;
         memberObject.XP = member.givenExperience;
         memberObject.XPP = member.experienceGivenPercent;
         memberObject.state = member.connected;
         memberObject.sex = !!member.sex ? 1 : 0;
         memberObject.isAlone = isAlone;
         memberObject.achievementPoints = member.achievementPoints;
         memberObject.status = member.status;
         memberObject.havenBagShared = member.havenBagShared;
         return memberObject;
      }
      
      private function updateMemberObjectWithMyRights(member:Object) : Object
      {
         var guild:Object = this.socialApi.getGuild();
         member.manageXPContribution = guild.manageXPContribution;
         member.manageMyXPContribution = guild.manageMyXpContribution;
         member.manageRanks = guild.manageRanks;
         member.displayBanMember = guild.banMembers;
         member.displayRightsMember = guild.manageRights;
         member.displayLightRightsMember = guild.manageLightRights;
         return member;
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var data2:Object = null;
         if(target == this.btn_showOfflineMembers)
         {
            _showOfflineMembers = this.btn_showOfflineMembers.selected;
            if(this._membersList != null)
            {
               this.onGuildMembersUpdated(this._membersList);
            }
         }
         else if(target == this.btn_warnWhenMemberIsOnline)
         {
            this.sysApi.sendAction(new MemberWarningSetAction([this.btn_warnWhenMemberIsOnline.selected]));
         }
         else if(target == this.btn_tabBreed)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("breed",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("breed",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabName)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("name",Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabRank)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("rankOrder",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("rankOrder",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabLevel)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("level",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("level",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabXP)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("XP",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("XP",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabXPP)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("XPP",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("XPP",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabAchievement)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("achievementPoints",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("achievementPoints",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target == this.btn_tabState)
         {
            if(this._bDescendingSort)
            {
               this.gd_list.sortOn("state",Array.NUMERIC);
            }
            else
            {
               this.gd_list.sortOn("state",Array.NUMERIC | Array.DESCENDING);
            }
            this._bDescendingSort = !this._bDescendingSort;
         }
         else if(target.name.indexOf("btn_rights") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            this.displayMemberRights(data);
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            data2 = this._interactiveComponentsList[target.name];
            this.popupDeletePlayer(data2);
         }
         else if(target.name.indexOf("tx_state") != -1 || target.name.indexOf("tx_mood") != -1 || target.name.indexOf("tx_fight") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data.member.connected == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               this.sysApi.sendAction(new GameFightSpectatePlayerRequestAction([data.id]));
            }
         }
         else if(target.name.indexOf("tx_havenbag") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            this.sysApi.sendAction(new HavenbagEnterAction([data.id]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:Object = null;
         var memberInfo:Object = null;
         var months:int = 0;
         var days:int = 0;
         var argText:String = null;
         var sdata:Object = null;
         var memberStatusInfo:Object = null;
         var point:uint = 6;
         var relPoint:uint = 0;
         if(target.name.indexOf("btn_rights") != -1)
         {
            tooltipText = this.uiApi.getText("ui.social.guildManageRights");
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            tooltipText = this.uiApi.getText("ui.charsel.characterDelete");
         }
         else if(target.name.indexOf("tx_state") != -1 || target.name.indexOf("tx_mood") != -1 || target.name.indexOf("tx_fight") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data.member.connected == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               tooltipText = this.uiApi.getText("ui.spectator.clicToJoin");
            }
         }
         else if(target.name.indexOf("tx_havenbag") != -1)
         {
            tooltipText = this.uiApi.getText("ui.havenbag.visit");
         }
         else if(target.name.indexOf("lbl_playerName") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            memberInfo = data.member;
            if(memberInfo && memberInfo.connected == 0)
            {
               months = Math.floor(memberInfo.hoursSinceLastConnection / 720);
               days = (memberInfo.hoursSinceLastConnection - months * 720) / 24;
               if(months > 0)
               {
                  if(days > 0)
                  {
                     argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsAndDaysSinceLastConnection",months,days),"m",days <= 1);
                  }
                  else
                  {
                     argText = this.uiApi.processText(this.uiApi.getText("ui.social.monthsSinceLastConnection",months),"m",months <= 1);
                  }
               }
               else if(days > 0)
               {
                  argText = this.uiApi.processText(this.uiApi.getText("ui.social.daysSinceLastConnection",days),"m",days <= 1);
               }
               else
               {
                  argText = this.uiApi.getText("ui.social.lessThanADay");
               }
               tooltipText = this.uiApi.getText("ui.social.lastConnection",argText);
            }
         }
         else if(target.name.indexOf("tx_lvl") != -1)
         {
            tooltipText = this.uiApi.getText("ui.tooltip.OmegaLevel");
         }
         else if(target.name.indexOf("tx_status") != -1)
         {
            sdata = this._interactiveComponentsList[target.name];
            if(!sdata)
            {
               return;
            }
            memberStatusInfo = sdata.member;
            if(memberStatusInfo && memberStatusInfo.connected != 0)
            {
               switch(memberStatusInfo.status.statusId)
               {
                  case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                     tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                     tooltipText = this.uiApi.getText("ui.chat.status.idle");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     tooltipText = this.uiApi.getText("ui.chat.status.away");
                     if(memberStatusInfo.status is PlayerStatusExtended && PlayerStatusExtended(memberStatusInfo.status).message != "")
                     {
                        tooltipText += this.uiApi.getText("ui.common.colon") + PlayerStatusExtended(memberStatusInfo.status).message;
                     }
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                     tooltipText = this.uiApi.getText("ui.chat.status.private");
                     break;
                  case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                     tooltipText = this.uiApi.getText("ui.chat.status.solo");
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
   }
}
