package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildApplicationWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildNoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSetApplicationUpdatesRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.MemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.GuildApplicationStateEnum;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildRecruitmentTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class GuildMembers
   {
      
      private static var _showOfflineMembers:Boolean = false;
       
      
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
      
      private const DATA_SORT_MEMBERS:String = "sortGuildMembers";
      
      private const SORT_ORDER:String = "rankOrder";
      
      private const SORT_NAME:String = "name";
      
      private const SORT_LEVEL:String = "level";
      
      private const SORT_XP:String = "XP";
      
      private const SORT_XPP:String = "XPP";
      
      private const SORT_ACHIEVEMENT:String = "achievementPoints";
      
      private const SORT_STATUS:String = "status.statusId";
      
      private var _membersList:Object;
      
      private var _iconsPath:String;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _sortingParams:Object;
      
      private var _interactiveComponentsList:Dictionary;
      
      private var _memberIdWaitingForKick:Number;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _currentSearchText:String;
      
      private var _guildApplicationTotal:int = 0;
      
      private var _currentHoveredEditNoteBtn:ButtonContainer = null;
      
      private var _notesTimer:BenchmarkTimer = null;
      
      private var _lockedNotes:Vector.<GuildNoteWrapper>;
      
      public var gd_list:Grid;
      
      public var btn_showOfflineMembers:ButtonContainer;
      
      public var btn_warnWhenMemberIsOnline:ButtonContainer;
      
      public var lbl_membersNumber:Label;
      
      public var lbl_membersLevel:Label;
      
      public var btn_tabStatus:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabRank:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabXP:ButtonContainer;
      
      public var btn_tabXPP:ButtonContainer;
      
      public var btn_tabAchievement:ButtonContainer;
      
      public var btn_tabState:ButtonContainer;
      
      public var btn_seeGuildApplications:ButtonContainer;
      
      public var btn_guildRights:ButtonContainer;
      
      public var btn_lbl_btn_guildRights:Label;
      
      public var tx_status:Texture;
      
      public var btn_lbl_btn_tabStatus:Label;
      
      public var btn_lbl_btn_tabName:Label;
      
      public var btn_lbl_btn_tabRank:Label;
      
      public var btn_lbl_btn_tabLevel:Label;
      
      public var btn_lbl_btn_tabXP:Label;
      
      public var btn_lbl_btn_tabXPP:Label;
      
      public var btn_lbl_btn_tabAchievement:Label;
      
      public var tx_sortDown:Texture;
      
      public var tx_sortUp:Texture;
      
      public var ctr_search:GraphicContainer;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public function GuildMembers()
      {
         this._sortingParams = {
            "sortType":this.SORT_ORDER,
            "descending":false
         };
         this._interactiveComponentsList = new Dictionary(true);
         this._lockedNotes = new Vector.<GuildNoteWrapper>();
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(SocialHookList.GuildInformationsMembers,this.onGuildMembersUpdated);
         this.sysApi.addHook(SocialHookList.MemberWarningState,this.onMemberWarningState);
         this.sysApi.addHook(SocialHookList.GuildInformationsMemberUpdate,this.onGuildInformationsMemberUpdate);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.sysApi.addHook(SocialHookList.GuildApplicationsReceived,this.onApplications);
         this.sysApi.addHook(SocialHookList.GuildApplicationUpdated,this.onUpdatedApplication);
         this.sysApi.addHook(SocialHookList.GuildRanksReceived,this.onGuildRankReceived);
         this.uiApi.addComponentHook(this.btn_showOfflineMembers,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_warnWhenMemberIsOnline,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabXPP,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabXPP,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_tabXP,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabXP,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         this._sortingParams = this.sysApi.getSetData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         this._bDescendingSort = this._sortingParams.descending;
         this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_MEMBERS]));
         this.initSortArrow(this._sortingParams.sortType);
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.guild.searchMembers");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.restrict = "^[&\"~!@#$£%*\\_+=\'[]|;<>./?{},]()";
         this.btn_resetSearch.visible = false;
         this.btn_lbl_btn_tabXP.text = this.btn_lbl_btn_tabXP.text.toLocaleUpperCase();
         this.btn_lbl_btn_tabXPP.text = this.btn_lbl_btn_tabXPP.text.toLocaleUpperCase();
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this.btn_showOfflineMembers.selected = _showOfflineMembers;
         this.btn_warnWhenMemberIsOnline.selected = this.socialApi.getWarnOnMemberConnec();
         this.setGuildApplicationsButton(false);
         this.updateGuildRightsButton();
         if(!this.playerApi.isInKoli())
         {
            if(this.uiApi.getUi(UIEnum.GUILD_APPLICATIONS) === null)
            {
               this.sysApi.sendAction(GuildSetApplicationUpdatesRequestAction.create(true));
            }
            this.sysApi.sendAction(GuildApplicationsRequestAction.create(0,0));
         }
      }
      
      public function unload() : void
      {
         this.destroyNotesTimer();
         if(!this.playerApi.isInKoli() && this.uiApi.getUi(UIEnum.GUILD_APPLICATIONS) === null)
         {
            this.sysApi.sendAction(GuildSetApplicationUpdatesRequestAction.create(false));
         }
      }
      
      private function isRecruitmentBlocked() : Boolean
      {
         var guildWrapper:GuildWrapper = this.socialApi.getGuild();
         return guildWrapper !== null && guildWrapper.guildRecruitmentInfo !== null && guildWrapper.guildRecruitmentInfo.recruitmentType === GuildRecruitmentTypeEnum.DISABLED && this._guildApplicationTotal === 0;
      }
      
      private function setGuildApplicationsButton(areThereApplications:Boolean) : void
      {
         var isButtonDisabled:Boolean = !areThereApplications || this.isRecruitmentBlocked() || this.playerApi.isInKoli();
         this.btn_seeGuildApplications.softDisabled = isButtonDisabled;
         if(isButtonDisabled)
         {
            this.uiApi.addComponentHook(this.btn_seeGuildApplications,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_seeGuildApplications,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.uiApi.removeComponentHook(this.btn_seeGuildApplications,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.btn_seeGuildApplications,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function disableEditNoteBtn() : void
      {
         if(this._currentHoveredEditNoteBtn === null)
         {
            return;
         }
         this._currentHoveredEditNoteBtn.visible = false;
         this._currentHoveredEditNoteBtn = null;
      }
      
      private function enableEditNoteBtn(editNoteBtn:ButtonContainer) : void
      {
         if(editNoteBtn == null || this._currentHoveredEditNoteBtn === editNoteBtn)
         {
            return;
         }
         this.disableEditNoteBtn();
         this._currentHoveredEditNoteBtn = editNoteBtn;
         this._currentHoveredEditNoteBtn.visible = true;
      }
      
      public function updateGuildMemberLine(data:MemberWrapper, components:*, selected:Boolean) : void
      {
         var memberInfo:GuildMember = null;
         var selfPlayerItem:* = false;
         var maxPlayerNameWidth:Number = NaN;
         var maxNoteWidth:Number = NaN;
         var smiley:Smiley = null;
         var lastData:MemberWrapper = this._interactiveComponentsList[components.btn_rights.name];
         delete this._interactiveComponentsList[components.btn_editNote.name];
         this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OUT);
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
         if(!this._interactiveComponentsList[components.tx_head.name])
         {
            this.uiApi.addComponentHook(components.tx_head,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_head,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_head.name] = data;
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
            selfPlayerItem = this.playerApi.id() == memberInfo.id;
            if(data.note !== null)
            {
               components.lbl_note.text = data.note.text;
               components.lbl_note.fullWidth();
               maxNoteWidth = Number(this.uiApi.me().getConstant("note_width"));
               if(components.lbl_note.width > maxNoteWidth)
               {
                  components.lbl_note.width = maxNoteWidth;
               }
            }
            if(this.playerApi.id() === memberInfo.id || this.hasRight(GuildRightsEnum.RIGHT_MANAGE_MEMBERS_NOTE))
            {
               components.btn_editNote.visible = this._currentHoveredEditNoteBtn !== null && this._currentHoveredEditNoteBtn === components.btn_editNote;
               if(data.note !== null)
               {
                  components.btn_editNote.x = components.lbl_note.x + components.lbl_note.width + Number(this.uiApi.me().getConstant("note_margin_x"));
                  this._interactiveComponentsList[data.note.playerId] = components.btn_editNote;
                  this.setEditNoteButtonState(components.btn_editNote,data.note.isEditable);
               }
               else
               {
                  if(data.note.playerId in this._interactiveComponentsList)
                  {
                     delete this._interactiveComponentsList[data.note.playerId];
                  }
                  components.btn_editNote.x = components.lbl_note.x;
               }
               components.btn_editNote.y = Number(this.uiApi.me().getConstant("note_margin_y"));
               this._interactiveComponentsList[components.btn_editNote.name] = data;
               this.uiApi.addComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OUT);
               if(!this.playerApi.isInKoli())
               {
                  this.uiApi.addComponentHook(components.btn_editNote,ComponentHookList.ON_RELEASE);
               }
               this._interactiveComponentsList[memberInfo.id] = components.btn_editNote;
               this.uiApi.addComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               components.btn_editNote.visible = false;
               delete this._interactiveComponentsList[data.note.playerId];
               delete this._interactiveComponentsList[components.btn_editNote.name];
               delete this._interactiveComponentsList[memberInfo.id];
               this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_RELEASE);
               this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OUT);
            }
            components.tx_rank.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ranks_uri") + data.rank.gfxId + ".png");
            components.lbl_rank.text = data.rank.name;
            components.lbl_XPP.text = memberInfo.experienceGivenPercent + "%";
            this._interactiveComponentsList[components.lbl_XP.name] = this.utilApi.kamasToString(memberInfo.givenExperience,"");
            this.uiApi.addComponentHook(components.lbl_XP,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_XP,ComponentHookList.ON_ROLL_OUT);
            components.lbl_XP.text = this.utilApi.getShortenedStringOfNumber(memberInfo.givenExperience);
            components.tx_mood.uri = null;
            components.tx_fight.uri = null;
            if(memberInfo.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               components.lbl_lvl.cssClass = "darkboldcenter";
               components.lbl_lvl.text = memberInfo.level - ProtocolConstantsEnum.MAX_LEVEL;
               if(components.tx_lvl.uri != this._bgPrestigeUri)
               {
                  components.tx_lvl.uri = this._bgPrestigeUri;
               }
               this.uiApi.addComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               this.uiApi.removeComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.tx_lvl,ComponentHookList.ON_ROLL_OUT);
               components.lbl_lvl.cssClass = "boldcenter";
               components.lbl_lvl.text = memberInfo.level;
               if(components.tx_lvl.uri != this._bgLevelUri)
               {
                  components.tx_lvl.uri = this._bgLevelUri;
               }
            }
            components.tx_slotHead.visible = true;
            components.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + memberInfo.breed + "" + data.sex + ".png");
            if(memberInfo.achievementPoints == -1)
            {
               components.lbl_achievement.text = "-";
            }
            else
            {
               components.lbl_achievement.text = StringUtils.kamasToString(memberInfo.achievementPoints,"");
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
            if(lastData && lastData.member.status.statusId != memberInfo.status.statusId || components.tx_status.uri == null)
            {
               components.tx_status.uri = this.socialApi.getStatusIcon(memberInfo.status.statusId);
            }
            components.btn_kick.visible = data.displayBanMember || selfPlayerItem;
            components.btn_rights.visible = data.canAssignRanks || data.canManageXp;
            components.lbl_playerName.fullWidth();
            maxPlayerNameWidth = Number(this.uiApi.me().getConstant("playerName_width"));
            if(components.lbl_playerName.width > maxPlayerNameWidth)
            {
               components.lbl_playerName.width = maxPlayerNameWidth;
            }
         }
         else
         {
            components.lbl_playerName.text = "";
            components.lbl_note.text = "";
            components.lbl_rank.text = "";
            components.tx_rank.uri = null;
            components.lbl_rank.text = "";
            components.tx_lvl.uri = null;
            components.lbl_lvl.text = "";
            components.lbl_XPP.text = "";
            components.lbl_XP.text = "";
            components.tx_head.uri = null;
            components.tx_slotHead.visible = false;
            components.tx_state.uri = null;
            components.tx_mood.uri = null;
            components.tx_fight.uri = null;
            components.tx_havenbag.visible = false;
            components.btn_rights.visible = false;
            components.btn_kick.visible = false;
            components.tx_status.uri = null;
            components.lbl_achievement.text = "";
            components.btn_editNote.visible = false;
            delete this._interactiveComponentsList[components.lbl_XP.name];
            this.uiApi.removeComponentHook(components.lbl_XP,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.lbl_XP,ComponentHookList.ON_ROLL_OUT);
            delete this._interactiveComponentsList[components.btn_editNote.name];
            this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_editNote,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_memberLine,ComponentHookList.ON_ROLL_OUT);
         }
         this.sysApi.addHook(SocialHookList.GuildRecruitmentDataReceived,this.onRecruitmentData);
      }
      
      private function onRecruitmentData(recruitmentData:GuildRecruitmentDataWrapper) : void
      {
         this.setGuildApplicationsButton(this._guildApplicationTotal > 0);
      }
      
      private function popupDeletePlayer(data:MemberWrapper) : void
      {
         var text:String = null;
         var quitButton:String = null;
         var cancelButton:String = null;
         if(data.isBoss && !data.isAlone)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.guildBossCantBeBann",data.rank.name),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            if(this.playerApi.id() == data.member.id)
            {
               if(data.isAlone)
               {
                  text = this.uiApi.getText("ui.social.doUDeleteYouWarningGuildChest");
               }
               else
               {
                  text = this.uiApi.getText("ui.social.doUDeleteYou");
               }
               quitButton = this.uiApi.getText("ui.guild.quit");
               cancelButton = this.uiApi.getText("ui.guild.stay");
            }
            else
            {
               text = this.uiApi.getText("ui.social.doUDeleteMember",data.member.name);
               quitButton = this.uiApi.getText("ui.guild.exclude");
               cancelButton = this.uiApi.getText("ui.guild.keep");
            }
            this._memberIdWaitingForKick = data.member.id;
            this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),text,[quitButton,cancelButton],[this.onConfirmDeletePlayer,this.onCancelDeletePlayer],this.onConfirmDeletePlayer,this.onCancelDeletePlayer);
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
      
      private function displayMemberRights(data:MemberWrapper) : void
      {
         if(this.uiApi.getUi("guildMemberRights") != null)
         {
            this.uiApi.unloadUi("guildMemberRights");
         }
         this.uiApi.loadUi("guildMemberRights","guildMemberRights",{
            "memberInfo":data.member,
            "myRank":this.socialApi.playerGuildRank,
            "allowToManageRank":this.hasRight(GuildRightsEnum.RIGHT_ASSIGN_RANKS),
            "manageXPContribution":this.hasRight(GuildRightsEnum.RIGHT_MANAGE_ALL_XP_CONTRIBUTION),
            "manageMyXPContribution":this.hasRight(GuildRightsEnum.RIGHT_MANAGE_SELF_XP_CONTRIBUTION),
            "selfPlayerItem":this.playerApi.id() == data.member.id,
            "iamBoss":this.socialApi.playerGuildRank.order == 0
         },StrataEnum.STRATA_HIGH);
      }
      
      private function manageRanks(pPlayerRights:Vector.<uint>) : Boolean
      {
         return pPlayerRights && pPlayerRights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1;
      }
      
      public function manageGuildApply(pPlayerRights:Vector.<uint>) : Boolean
      {
         return pPlayerRights && pPlayerRights.indexOf(GuildRightsEnum.RIGHT_MANAGE_APPLY_AND_INVITATION) != -1;
      }
      
      private function searchMember() : void
      {
         var member:GuildMember = null;
         var listDisplayed:Array = [];
         for each(member in this._membersList)
         {
            if(member.connected || _showOfflineMembers)
            {
               listDisplayed.push(this.createMemberObject(member,this._membersList.length == 1));
            }
         }
         listDisplayed = this.utilApi.filter(listDisplayed,this._currentSearchText,"name");
         this.gd_list.dataProvider = this.sortMembers(listDisplayed);
      }
      
      private function resetSearch() : void
      {
         this._currentSearchText = null;
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         if(this._membersList != null)
         {
            this.onGuildMembersUpdated(this._membersList);
         }
      }
      
      private function sortMembers(members:Array) : Array
      {
         switch(this._sortingParams.sortType)
         {
            case this.SORT_NAME:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByName,Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               return members.sort(this.sortByName,Array.CASEINSENSITIVE);
               break;
            case this.SORT_ORDER:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByOrder,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
               }
               return members.sort(this.sortByOrder,Array.NUMERIC | Array.CASEINSENSITIVE);
               break;
            case this.SORT_LEVEL:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByLevel,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
               }
               return members.sort(this.sortByLevel,Array.NUMERIC | Array.CASEINSENSITIVE);
               break;
            case this.SORT_XP:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByXp,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
               }
               return members.sort(this.sortByXp,Array.NUMERIC | Array.CASEINSENSITIVE);
               break;
            case this.SORT_XPP:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByXpp,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
               }
               return members.sort(this.sortByXpp,Array.NUMERIC | Array.CASEINSENSITIVE);
               break;
            case this.SORT_ACHIEVEMENT:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByAchievement,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
               }
               return members.sort(this.sortByAchievement,Array.NUMERIC | Array.CASEINSENSITIVE);
               break;
            case this.SORT_STATUS:
               if(this._sortingParams.descending)
               {
                  return members.sort(this.sortByStatus,Array.DESCENDING);
               }
               return members.sort(this.sortByStatus);
               break;
            default:
               return members;
         }
      }
      
      private function initSortArrow(sort:String) : void
      {
         switch(sort)
         {
            case this.SORT_NAME:
               this.updateSortArrow(this.btn_tabName);
               break;
            case this.SORT_ORDER:
               this.updateSortArrow(this.btn_tabRank);
               break;
            case this.SORT_LEVEL:
               this.updateSortArrow(this.btn_tabLevel);
               break;
            case this.SORT_XP:
               this.updateSortArrow(this.btn_tabXP);
               break;
            case this.SORT_XPP:
               this.updateSortArrow(this.btn_tabXPP);
               break;
            case this.SORT_ACHIEVEMENT:
               this.updateSortArrow(this.btn_tabAchievement);
               break;
            case this.SORT_STATUS:
               this.updateSortArrow(this.btn_tabStatus);
         }
      }
      
      private function updateSortArrow(target:GraphicContainer) : void
      {
         var btn_lbl_target:Label = this["btn_lbl_" + target.name];
         this.tx_sortDown.visible = !this._bDescendingSort;
         this.tx_sortUp.visible = this._bDescendingSort;
         var pos:int = 0;
         var sortArrowOffset:Number = Number(this.uiApi.me().getConstant("sort_arrow_offset"));
         switch(btn_lbl_target.textFormat.align)
         {
            case TextAlign.LEFT:
            case TextAlign.JUSTIFY:
               pos = target.anchorX + btn_lbl_target.textWidth + sortArrowOffset + 3;
               break;
            case TextAlign.CENTER:
               pos = target.anchorX + btn_lbl_target.width / 2 + btn_lbl_target.textWidth / 2 + sortArrowOffset;
               break;
            case TextAlign.RIGHT:
               pos = target.anchorX + btn_lbl_target.width + sortArrowOffset;
         }
         this.tx_sortDown.x = this.tx_sortUp.x = pos;
      }
      
      private function sortByStatus(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var firstStatus:int = member1.member.status.statusId;
         var secondStatus:int = member2.member.status.statusId;
         firstStatus = firstStatus != 0 ? int(firstStatus) : 1000;
         secondStatus = secondStatus != 0 ? int(secondStatus) : 1000;
         var sortResult:int = this.sortBase(firstStatus,secondStatus);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function sortByName(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         return this.sortBase(member1.member.name,member2.member.name);
      }
      
      private function sortByOrder(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var sortResult:int = this.sortBase(member1.rank.order,member2.rank.order);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function sortByLevel(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var sortResult:int = this.sortBase(member1.member.level,member2.member.level);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function sortByXp(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var sortResult:int = this.sortBase(member1.member.givenExperience,member2.member.givenExperience);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function sortByXpp(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var sortResult:int = this.sortBase(member1.member.experienceGivenPercent,member2.member.experienceGivenPercent);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function sortByAchievement(member1:MemberWrapper, member2:MemberWrapper) : int
      {
         var sortResult:int = this.sortBase(member1.member.achievementPoints,member2.member.achievementPoints);
         if(sortResult == 0)
         {
            return this.secondSort(member1,member2,this.sortByName);
         }
         return sortResult;
      }
      
      private function secondSort(member1:MemberWrapper, member2:MemberWrapper, sortFunc:Function) : int
      {
         if(this._bDescendingSort)
         {
            return sortFunc(member2,member1);
         }
         return sortFunc(member1,member2);
      }
      
      public function sortBase(first:*, second:*) : int
      {
         if(first > second)
         {
            return 1;
         }
         if(first < second)
         {
            return -1;
         }
         return 0;
      }
      
      private function updateGuildRightsButton() : void
      {
         if(this.manageRanks(this.socialApi.playerGuildRank.rights))
         {
            this.btn_lbl_btn_guildRights.text = this.uiApi.getText("ui.guild.manageRanks");
         }
         else
         {
            this.btn_lbl_btn_guildRights.text = this.uiApi.getText("ui.guild.seeRanks");
         }
         this.btn_guildRights.softDisabled = this.playerApi.isInKoli();
         if(this.btn_guildRights.softDisabled)
         {
            this.uiApi.addComponentHook(this.btn_guildRights,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_guildRights,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.uiApi.removeComponentHook(this.btn_guildRights,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.btn_guildRights,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function hasRight(rightId:uint) : Boolean
      {
         return this.socialApi.playerGuildRank.rights.indexOf(rightId) != -1;
      }
      
      private function onApplications(applicationDescrs:Vector.<GuildApplicationWrapper>, offset:uint, limit:uint, total:uint) : void
      {
         this._guildApplicationTotal = total;
         this.setGuildApplicationsButton(this._guildApplicationTotal > 0);
      }
      
      private function onUpdatedApplication(application:GuildApplicationWrapper, state:uint, playerId:Number) : void
      {
         switch(state)
         {
            case GuildApplicationStateEnum.ADDED:
               ++this._guildApplicationTotal;
               break;
            case GuildApplicationStateEnum.DELETED:
               this._guildApplicationTotal = Math.max(0,this._guildApplicationTotal - 1);
               break;
            default:
               return;
         }
         this.setGuildApplicationsButton(this._guildApplicationTotal > 0);
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
         this.gd_list.dataProvider = this.sortMembers(listDisplayed);
         this.lbl_membersLevel.text = this.uiApi.getText("ui.social.guildAvgMembersLevel") + this.uiApi.getText("ui.common.colon") + int(totalLevels / totalMembers);
         this.lbl_membersNumber.text = this.uiApi.getText("ui.social.guildMembers") + this.uiApi.getText("ui.common.colon") + connected + " / " + totalMembers;
         this.updateGuildRightsButton();
      }
      
      public function onGuildInformationsMemberUpdate(memberInfo:GuildMember) : void
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
                  if(this.gd_list.dataProvider[i].member.id == memberInfo.id)
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
         var member:MemberWrapper = null;
         if(hasGuild)
         {
            listDisplayed = [];
            for each(member in this.gd_list.dataProvider)
            {
               listDisplayed.push(this.updateMemberObjectWithMyRights(member));
            }
            this.gd_list.dataProvider = this.sortMembers(listDisplayed);
         }
      }
      
      private function onMemberWarningState(enable:Boolean) : void
      {
         if(this.btn_warnWhenMemberIsOnline.selected != enable)
         {
            this.btn_warnWhenMemberIsOnline.selected = enable;
         }
      }
      
      private function onGuildRankReceived(ranks:Vector.<GuildRankInformation>) : void
      {
         this.gd_list.updateItems();
      }
      
      private function createMemberObject(member:GuildMember, isAlone:Boolean) : Object
      {
         var memberWrapper:MemberWrapper = new MemberWrapper();
         var rank:GuildRankInformation = this.socialApi.socialFrame.getGuildRankById(member.rankId);
         var playedCharacterRank:GuildRankInformation = this.socialApi.playerGuildRank;
         memberWrapper.rank = rank;
         memberWrapper.member = member;
         memberWrapper.displayBanMember = this.hasRight(GuildRightsEnum.RIGHT_KICK_MEMBER) && playedCharacterRank.order < rank.order;
         memberWrapper.canManageXp = this.hasRight(GuildRightsEnum.RIGHT_MANAGE_SELF_XP_CONTRIBUTION) && member.id == this.playerApi.id() || playedCharacterRank.order < rank.order && this.hasRight(GuildRightsEnum.RIGHT_MANAGE_ALL_XP_CONTRIBUTION);
         memberWrapper.canAssignRanks = playedCharacterRank.order < rank.order && this.hasRight(GuildRightsEnum.RIGHT_ASSIGN_RANKS);
         memberWrapper.sex = !!member.sex ? 1 : 0;
         memberWrapper.isAlone = isAlone;
         memberWrapper.name = member.name;
         memberWrapper.note = GuildNoteWrapper.wrap(member.id,member.note);
         this.listenToGuildNote(memberWrapper.note);
         return memberWrapper;
      }
      
      private function listenToGuildNote(note:GuildNoteWrapper) : void
      {
         if(note.isEditable)
         {
            return;
         }
         this.createNotesTimer();
         this.addLockedNote(note);
      }
      
      private function addLockedNote(note:GuildNoteWrapper) : void
      {
         var lockedNote:GuildNoteWrapper = null;
         var index:uint = 0;
         var count:uint = this._lockedNotes.length;
         var insertIndex:int = count;
         while(index < count)
         {
            lockedNote = this._lockedNotes[index];
            if(lockedNote.editDate >= note.editDate)
            {
               insertIndex = index;
            }
            index++;
         }
         if(note.playerId in this._interactiveComponentsList)
         {
            this.setEditNoteButtonState(this._interactiveComponentsList[note.playerId],false);
         }
         if(insertIndex > count - 1)
         {
            this._lockedNotes.push(note);
         }
         else
         {
            this._lockedNotes.insertAt(insertIndex,note);
         }
      }
      
      private function setEditNoteButtonState(noteButton:ButtonContainer, isEditable:Boolean) : void
      {
         if(isEditable && !this.playerApi.isInKoli())
         {
            this.uiApi.addComponentHook(noteButton,ComponentHookList.ON_RELEASE);
            noteButton.useHandCursor = true;
            return;
         }
         this.uiApi.removeComponentHook(noteButton,ComponentHookList.ON_RELEASE);
         noteButton.useHandCursor = false;
      }
      
      private function updateMemberObjectWithMyRights(member:MemberWrapper) : MemberWrapper
      {
         var playedCharacterRank:GuildRankInformation = this.socialApi.playerGuildRank;
         member.displayBanMember = this.hasRight(GuildRightsEnum.RIGHT_KICK_MEMBER) && playedCharacterRank.order < member.rank.order;
         member.canManageXp = this.hasRight(GuildRightsEnum.RIGHT_MANAGE_SELF_XP_CONTRIBUTION) && member.member.id == this.playerApi.id() || playedCharacterRank.order < member.rank.order && this.hasRight(GuildRightsEnum.RIGHT_MANAGE_ALL_XP_CONTRIBUTION);
         member.canAssignRanks = playedCharacterRank.order < member.rank.order && this.hasRight(GuildRightsEnum.RIGHT_ASSIGN_RANKS);
         return member;
      }
      
      private function createNotesTimer() : void
      {
         if(this._notesTimer !== null)
         {
            return;
         }
         this._notesTimer = new BenchmarkTimer(1000,0,"GuildMembers._notesTimer");
         this._notesTimer.addEventListener(TimerEvent.TIMER,this.onNotesTimer);
         this._notesTimer.start();
      }
      
      private function destroyNotesTimer() : void
      {
         if(this._notesTimer === null)
         {
            return;
         }
         this._notesTimer.stop();
         this._notesTimer.removeEventListener(TimerEvent.TIMER,this.onNotesTimer);
         this._notesTimer = null;
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:MemberWrapper = null;
         if(target == this.btn_showOfflineMembers)
         {
            _showOfflineMembers = this.btn_showOfflineMembers.selected;
            if(this._membersList != null)
            {
               this.onGuildMembersUpdated(this._membersList);
            }
            if(this.inp_search.text != "" && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
            {
               this.searchMember();
            }
         }
         else if(target == this.btn_warnWhenMemberIsOnline)
         {
            this.sysApi.sendAction(new MemberWarningSetAction([this.btn_warnWhenMemberIsOnline.selected]));
         }
         else if(target == this.btn_tabStatus)
         {
            if(this._sortingParams.sortType == this.SORT_STATUS)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByStatus,Array.DESCENDING);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByStatus);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_STATUS;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabName)
         {
            if(this._sortingParams.sortType == this.SORT_NAME)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByName,Array.CASEINSENSITIVE | Array.DESCENDING);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByName,Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_NAME;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabRank)
         {
            if(this._sortingParams.sortType == this.SORT_ORDER)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByOrder,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByOrder,Array.NUMERIC | Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_ORDER;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabLevel)
         {
            if(this._sortingParams.sortType == this.SORT_LEVEL)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByLevel,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByLevel,Array.NUMERIC | Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_LEVEL;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabXP)
         {
            if(this._sortingParams.sortType == this.SORT_XP)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByXp,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByXp,Array.NUMERIC | Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_XP;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabXPP)
         {
            if(this._sortingParams.sortType == this.SORT_XPP)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByXpp,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByXpp,Array.NUMERIC | Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_XPP;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_tabAchievement)
         {
            if(this._sortingParams.sortType == this.SORT_ACHIEVEMENT)
            {
               this._bDescendingSort = !this._bDescendingSort;
            }
            else
            {
               this._bDescendingSort = false;
            }
            if(this._bDescendingSort)
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByAchievement,Array.NUMERIC | Array.DESCENDING | Array.CASEINSENSITIVE);
            }
            else
            {
               this.gd_list.dataProvider = this.gd_list.dataProvider.sort(this.sortByAchievement,Array.NUMERIC | Array.CASEINSENSITIVE);
            }
            this.updateSortArrow(target);
            this._sortingParams.sortType = this.SORT_ACHIEVEMENT;
            this._sortingParams.descending = this._bDescendingSort;
            this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         }
         else if(target == this.btn_resetSearch)
         {
            this.resetSearch();
         }
         else if(target == this.btn_seeGuildApplications)
         {
            if(!this.uiApi.getUi(UIEnum.GUILD_APPLICATIONS))
            {
               this.uiApi.loadUi(UIEnum.GUILD_APPLICATIONS,null);
            }
         }
         else if(target == this.btn_guildRights)
         {
            if(!this.uiApi.getUi(UIEnum.GUILD_RIGHTS_AND_RANKS))
            {
               this.uiApi.loadUi(UIEnum.GUILD_RIGHTS_AND_RANKS,UIEnum.GUILD_RIGHTS_AND_RANKS);
            }
            else
            {
               this.uiApi.unloadUi(UIEnum.GUILD_RIGHTS_AND_RANKS);
            }
         }
         else if(target.name.indexOf("btn_rights") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            this.displayMemberRights(data);
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            data = this._interactiveComponentsList[target.name] as MemberWrapper;
            this.popupDeletePlayer(data);
         }
         else if(target.name.indexOf("tx_state") != -1 || target.name.indexOf("tx_mood") != -1 || target.name.indexOf("tx_fight") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data.member.connected == PlayerStateEnum.GAME_TYPE_FIGHT)
            {
               this.sysApi.sendAction(new GameFightSpectatePlayerRequestAction([data.member.id]));
            }
         }
         else if(target.name.indexOf("tx_havenbag") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            this.sysApi.sendAction(new HavenbagEnterAction([data.member.id]));
         }
         else if(target.name.indexOf("btn_editNote") !== -1)
         {
            if(target.name in this._interactiveComponentsList && target.name in this._interactiveComponentsList)
            {
               data = this._interactiveComponentsList[target.name];
               if(!data.note.isEditable)
               {
                  return;
               }
               this.uiApi.loadUi(UIEnum.GUILD_NOTE_EDITING_POPUP,UIEnum.GUILD_NOTE_EDITING_POPUP,{
                  "guildMember":data.member,
                  "note":data.note
               });
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:MemberWrapper = null;
         var playerId:Number = NaN;
         var member:MemberWrapper = null;
         var memberInfo:Object = null;
         var months:int = 0;
         var days:int = 0;
         var argText:String = null;
         var memberStatusInfo:Object = null;
         var note:GuildNoteWrapper = null;
         var point:uint = LocationEnum.POINT_BOTTOMLEFT;
         var relPoint:uint = LocationEnum.POINT_TOPLEFT;
         if(target == this.btn_tabXPP)
         {
            tooltipText = this.uiApi.getText("ui.guild.XPPercent");
         }
         else if(target == this.btn_tabXP)
         {
            tooltipText = this.uiApi.getText("ui.guild.XPAmount");
         }
         else if(target == this.btn_seeGuildApplications)
         {
            if(this.isRecruitmentBlocked())
            {
               tooltipText = this.uiApi.getText("ui.guild.recruitmentBlockedWarning");
            }
            else if(this.playerApi.isInKoli())
            {
               tooltipText = this.uiApi.getText("ui.guild.lockGuildApplications");
            }
            else
            {
               tooltipText = this.uiApi.getText("ui.guild.noApplicationsAvailable");
            }
         }
         else if(target == this.btn_guildRights)
         {
            if(this.btn_guildRights.softDisabled && this.playerApi.isInKoli())
            {
               tooltipText = this.uiApi.getText("ui.guild.rightsNotAvailableInKoli");
            }
         }
         else if(target.name.indexOf("btn_rights") != -1)
         {
            member = this._interactiveComponentsList[target.name];
            if(member.canAssignRanks && member.canManageXp)
            {
               tooltipText = this.uiApi.getText("ui.guild.managePlayerRankAndXP");
            }
            else if(member.canManageXp)
            {
               tooltipText = this.uiApi.getText("ui.guild.managePlayerXP");
            }
            else if(member.canAssignRanks)
            {
               tooltipText = this.uiApi.getText("ui.guild.managePlayerRank");
            }
         }
         else if(target.name.indexOf("btn_kick") != -1)
         {
            tooltipText = this.uiApi.getText("ui.charsel.characterDelete");
            playerId = this._interactiveComponentsList[target.name].member.id;
            if(playerId === this.playerApi.id())
            {
               tooltipText = this.uiApi.getText("ui.guild.quitGuild");
            }
            else
            {
               tooltipText = this.uiApi.getText("ui.guild.excludeFromGuild");
            }
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
            point = LocationEnum.POINT_BOTTOM;
            relPoint = LocationEnum.POINT_TOP;
            tooltipText = this.uiApi.getText("ui.tooltip.OmegaLevel");
         }
         else if(target.name.indexOf("tx_head") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            tooltipText = this.dataApi.getBreed(data.member.breed).name;
         }
         else if(target.name.indexOf("tx_status") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            memberStatusInfo = data.member;
            if(memberStatusInfo)
            {
               if(memberStatusInfo.status is PlayerStatusExtended && PlayerStatusExtended(memberStatusInfo.status).message != "")
               {
                  tooltipText = this.socialApi.getStatusText(memberStatusInfo.status.statusId,PlayerStatusExtended(memberStatusInfo.status).message);
               }
               else
               {
                  tooltipText = this.socialApi.getStatusText(memberStatusInfo.status.statusId);
               }
            }
         }
         else if(target.name.indexOf("btn_editNote") !== -1 && target.name in this._interactiveComponentsList)
         {
            if(this.playerApi.isInKoli())
            {
               tooltipText = this.uiApi.getText("ui.guild.note.editDuringPvPImpossible");
            }
            else
            {
               data = this._interactiveComponentsList[target.name];
               note = data.note;
               if(!note.isEditable)
               {
                  tooltipText = this.uiApi.getText("ui.guild.note.lockDelay",Math.round(GuildNoteWrapper.MIN_EDIT_DELAY / 1000));
               }
               else
               {
                  playerId = data.member.id;
                  if(!isNaN(playerId))
                  {
                     if(playerId === this.playerApi.id())
                     {
                        tooltipText = this.uiApi.getText("ui.guild.note.editMyNote");
                     }
                     else
                     {
                        tooltipText = this.uiApi.getText("ui.guild.note.editNote");
                     }
                  }
               }
            }
         }
         else if(target.name.indexOf("lbl_XP") !== -1)
         {
            point = LocationEnum.POINT_BOTTOM;
            relPoint = LocationEnum.POINT_TOP;
            tooltipText = this._interactiveComponentsList[target.name];
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
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         this.disableEditNoteBtn();
         if(item.data === null)
         {
            return;
         }
         this.enableEditNoteBtn(this._interactiveComponentsList[item.data.member.id]);
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_search:
               if(this.inp_search.text.length && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this._currentSearchText = this.inp_search.text;
                  this.btn_resetSearch.visible = true;
                  this.searchMember();
               }
               else if(this._currentSearchText)
               {
                  this.resetSearch();
               }
         }
      }
      
      private function onNotesTimer(event:TimerEvent) : void
      {
         var note:GuildNoteWrapper = null;
         var index:int = this._lockedNotes.length - 1;
         while(index >= 0)
         {
            note = this._lockedNotes[index];
            if(!note.isEditable)
            {
               break;
            }
            this._lockedNotes.pop();
            index--;
            if(note.playerId in this._interactiveComponentsList)
            {
               this.setEditNoteButtonState(this._interactiveComponentsList[note.playerId],true);
            }
         }
         if(this._lockedNotes.length > 0)
         {
            return;
         }
         this.destroyNotesTimer();
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.guild.GuildNoteWrapper;
import com.ankamagames.dofus.network.types.game.guild.GuildMember;
import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;

class MemberWrapper
{
    
   
   public var displayBanMember:Boolean = false;
   
   public var canAssignRanks:Boolean = false;
   
   public var canManageXp:Boolean = false;
   
   public var member:GuildMember;
   
   public var note:GuildNoteWrapper = null;
   
   public var rank:GuildRankInformation;
   
   public var sex:int;
   
   public var isAlone:Boolean = false;
   
   public var name:String;
   
   function MemberWrapper()
   {
      super();
   }
   
   public function get isBoss() : Boolean
   {
      return this.rank.order == 0;
   }
}
