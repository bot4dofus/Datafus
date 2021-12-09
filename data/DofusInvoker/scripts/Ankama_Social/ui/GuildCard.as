package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.GuildTag;
   import com.ankamagames.dofus.datacenter.guild.GuildTagsType;
   import com.ankamagames.dofus.datacenter.guild.RankName;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildDirectoryFiltersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.GuildRecruitmentTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalGuildPublicInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.application.GuildApplicationInformation;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.TextAlign;
   
   public class GuildCard
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      private const TAG_TYPE_INTEREST:uint = 1;
      
      private const TAG_TYPE_ATMOSPHERE:uint = 2;
      
      private const TAG_TYPE_PLAY_TIME:uint = 3;
      
      private const GUILD_INFO_TAB:uint = 0;
      
      private const GUILD_MEMBERS_TAB:uint = 1;
      
      private const DATA_SORT_MEMBERS:String = "guildDetailsSortMembers";
      
      private const SORT_BY_NAME:String = "name";
      
      private const SORT_BY_RANK:String = "rankOrder";
      
      private const SORT_BY_LEVEL:String = "level";
      
      private const SORT_ARROW_OFFSET:uint = 8;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var EMPTY_TEXT:String = "---";
      
      private var _data:Object;
      
      private var _myGuild:GuildWrapper;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      private var _sortingParams:Object;
      
      private var _descendingSort:Boolean = false;
      
      private var _currentTabName:String;
      
      private var _nCurrentTab:uint = 0;
      
      private var _currentSearchText:String;
      
      private var _guildDirectoryFilters:GuildDirectoryFiltersWrapper;
      
      public var lbl_title:Label;
      
      public var lbl_alliance:Label;
      
      public var lbl_level:Label;
      
      public var lbl_creationDate:Label;
      
      public var lbl_leader:Label;
      
      public var lbl_taxcollectors:Label;
      
      public var lbl_members:Label;
      
      public var lbl_guildTitle:Label;
      
      public var lbl_guildDescription:TextArea;
      
      public var lbl_guildTags:Label;
      
      public var lbl_minLevel:Label;
      
      public var lbl_minSuccess:Label;
      
      public var tx_minSuccess:Texture;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_disabled:Texture;
      
      public var gd_members:Grid;
      
      public var btn_inviteInAlliance:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_apply:ButtonContainer;
      
      public var btn_lbl_btn_apply:Label;
      
      public var btn_sortByName:ButtonContainer;
      
      public var btn_sortByRank:ButtonContainer;
      
      public var btn_sortByLevel:ButtonContainer;
      
      public var btn_lbl_btn_sortByName:Label;
      
      public var btn_lbl_btn_sortByRank:Label;
      
      public var btn_lbl_btn_sortByLevel:Label;
      
      public var tx_sortDown:Texture;
      
      public var tx_sortUp:Texture;
      
      public var btn_guildInfo:ButtonContainer;
      
      public var btn_members:ButtonContainer;
      
      public var ctr_guildInfo:GraphicContainer;
      
      public var ctr_guildMembers:GraphicContainer;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public function GuildCard()
      {
         this._sortingParams = {
            "sortType":this.SORT_BY_NAME,
            "descending":false,
            "btnTarget":"btn_sortByName"
         };
         super();
      }
      
      public function main(... args) : void
      {
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(SocialHookList.GuildPlayerApplicationReceived,this.onGuildPlayerApplication);
         this.sysApi.addHook(SocialHookList.GuildPlayerApplicationDeleted,this.onGuildPlayerApplicationDeleted);
         this.sysApi.addHook(SocialHookList.GuildApplicationIsAnswered,this.onGuildApplicationIsAnswered);
         this.sysApi.addHook(SocialHookList.GuildJoined,this.onGuildJoined);
         this.sysApi.addHook(SocialHookList.GuildLeft,this.onGuildLeft);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_sortByName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByRank,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByLevel,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_apply,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_apply,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_apply,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         var guildDir:GuildDirectory = this.uiApi.getUi("guildDirectory") as GuildDirectory;
         if(guildDir != null)
         {
            this._guildDirectoryFilters = guildDir.currentFilters;
         }
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.guild.searchMembers");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.restrict = "^[&\"~!@#$£%*\\_+=\'[]|;<>./?{},]()";
         this.btn_resetSearch.visible = false;
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_guildInfo,this.uiApi.me());
         this.btn_guildInfo.selected = true;
         this.currentTabName = this.btn_guildInfo.name;
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this._data = args[0].guild;
         this._myGuild = this.socialApi.getGuild();
         this._sortingParams = this.sysApi.getSetData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         this._descendingSort = this._sortingParams.descending;
      }
      
      public function unload() : void
      {
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(name == this.uiApi.me().name)
         {
            this.updateInformations();
            this.updateSortArrow(this[this._sortingParams.btnTarget]);
            this.sortMembers();
         }
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function updateMemberLine(data:*, components:*, selected:Boolean) : void
      {
         var rankName:RankName = null;
         if(data != null)
         {
            components.lbl_memberName.text = "{player," + data.name + "," + data.id + "::" + data.name + "}";
            rankName = this.dataApi.getRankName(data.rank);
            if(rankName != null)
            {
               components.lbl_memberRank.text = rankName.name;
            }
            else
            {
               components.lbl_memberRank.text = this.EMPTY_TEXT;
            }
            if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               components.lbl_memberLvl.cssClass = "darkboldcenter";
               components.lbl_memberLvl.text = "" + (data.level - ProtocolConstantsEnum.MAX_LEVEL);
               components.tx_memberLvl.uri = this._bgPrestigeUri;
               this.uiApi.addComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               components.lbl_memberLvl.cssClass = "boldcenter";
               components.lbl_memberLvl.text = data.level;
               components.tx_memberLvl.uri = this._bgLevelUri;
               this.uiApi.removeComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OUT);
            }
         }
         else
         {
            components.lbl_memberName.text = "";
            components.lbl_memberLvl.text = "";
            components.lbl_memberRank.text = "";
            components.tx_memberLvl.uri = null;
         }
      }
      
      private function updateInformations() : void
      {
         var alliance:AllianceWrapper = null;
         this.lbl_title.text = this._data.guildName;
         this.btn_inviteInAlliance.visible = false;
         this.btn_apply.visible = this._data.guildRecruitmentInfo.recruitmentType != GuildRecruitmentTypeEnum.DISABLED && !this.socialApi.hasGuild() && !this.socialApi.hasAlliance();
         this.btn_apply.softDisabled = !this.canJoinGuild() || this.secureApi.SecureModeisActive();
         if(this._data.guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.MANUAL)
         {
            this.btn_lbl_btn_apply.text = this.uiApi.getText("ui.guild.apply");
         }
         else if(this._data.guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.AUTOMATIC)
         {
            this.btn_lbl_btn_apply.text = this.uiApi.getText("ui.guild.joinGuild");
         }
         if(this._data.allianceId)
         {
            this.lbl_alliance.text = this.chatApi.getAllianceLink(this._data,this._data.allianceName);
         }
         else
         {
            this.lbl_alliance.text = this.EMPTY_TEXT;
            if(this.socialApi.hasAlliance())
            {
               alliance = this.socialApi.getAlliance();
               if(alliance)
               {
                  if(this._myGuild.guildId == alliance.leadingGuildId && this.socialApi.hasGuildRight(this.playerApi.id(),"isBoss"))
                  {
                     this.btn_inviteInAlliance.visible = true;
                  }
               }
            }
         }
         this.lbl_level.text = this._data.guildLevel;
         this.lbl_creationDate.text = this.timeApi.getIRLDate(this._data.creationDate * 1000);
         this.lbl_leader.text = "{player," + this._data.leaderName + "," + this._data.leaderId + "::" + this._data.leaderName + "}";
         this.lbl_members.text = this._data.nbMembers + "/" + this.socialApi.getGuildMembersMax(this._data.guildLevel) + " " + this.uiApi.getText("ui.social.guildMembers");
         this.lbl_taxcollectors.text = this._data.nbTaxCollectors;
         this.tx_emblemBack.uri = this._data.backEmblem.fullSizeIconUri;
         this.tx_emblemUp.uri = this._data.upEmblem.fullSizeIconUri;
         if(this._data.members && this._data.members.length)
         {
            this.gd_members.dataProvider = this._data.members;
         }
         else
         {
            this.gd_members.dataProvider = new Vector.<CharacterMinimalGuildPublicInformations>();
         }
         this.lbl_guildTitle.text = this._data.guildRecruitmentInfo.recruitmentTitle;
         this.lbl_guildDescription.text = this._data.guildRecruitmentInfo.recruitmentText != "" ? this._data.guildRecruitmentInfo.recruitmentText : this.uiApi.getText("ui.guild.noDescription");
         this.lbl_guildTags.htmlText = this.processTagsText(this._data.guildRecruitmentInfo.selectedCriteria);
         this.lbl_minLevel.htmlText = "<b><font color=\'#e0e0de\'>" + this.uiApi.getText("ui.guild.recruitement.minimumLevelHeader") + (!!this._data.guildRecruitmentInfo.isMinLevelRequired ? " (" + this.uiApi.getText("ui.common.mandatory").toLowerCase() + ")" : "") + this.uiApi.getText("ui.common.colon") + "</font></b> " + (this._data.guildRecruitmentInfo.minLevel > 1 ? this._data.guildRecruitmentInfo.minLevel : this.EMPTY_TEXT);
         this.lbl_minSuccess.htmlText = "<b><font color=\'#e0e0de\'>" + this.uiApi.getText("ui.guild.recruitement.minimumAchievementPointsHeader") + (!!this._data.guildRecruitmentInfo.minAchievementPoints ? " (" + this.uiApi.getText("ui.common.mandatory").toLowerCase() + ")" : "") + this.uiApi.getText("ui.common.colon") + "</font></b> " + (this._data.guildRecruitmentInfo.minAchievementPoints > 0 ? this._data.guildRecruitmentInfo.minAchievementPoints : this.EMPTY_TEXT);
         this.tx_minSuccess.visible = this._data.guildRecruitmentInfo.minAchievementPoints > 0;
         this.tx_minSuccess.x = this.lbl_minSuccess.x + this.lbl_minSuccess.textWidth + 7;
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         switch(tab)
         {
            case this.GUILD_INFO_TAB:
               this.ctr_guildInfo.visible = true;
               this.ctr_guildMembers.visible = false;
               break;
            case this.GUILD_MEMBERS_TAB:
               this.ctr_guildInfo.visible = false;
               this.ctr_guildMembers.visible = true;
         }
      }
      
      private function canJoinGuild() : Boolean
      {
         if(this._data.guildRecruitmentInfo.isMinLevelRequired && this.playerApi.getPlayedCharacterInfo().level < this._data.guildRecruitmentInfo.minLevel)
         {
            return false;
         }
         if(this._data.guildRecruitmentInfo.areMinAchievementPointsRequired && this.playerApi.getAchievementPoints() < this._data.guildRecruitmentInfo.minAchievementPoints)
         {
            return false;
         }
         if(this.playerApi.getApplicationInfo())
         {
            return false;
         }
         return true;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_inviteInAlliance:
               this.sysApi.sendAction(new AllianceInvitationAction([this._data.leaderId]));
               break;
            case this.btn_sortByName:
               this._descendingSort = this._sortingParams.sortType == this.SORT_BY_NAME ? !this._descendingSort : false;
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByName);
               this._sortingParams.sortType = this.SORT_BY_NAME;
               this._sortingParams.descending = this._descendingSort;
               this._sortingParams.btnTarget = target.name;
               this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               this.updateSortArrow(target);
               break;
            case this.btn_sortByLevel:
               this._descendingSort = this._sortingParams.sortType == this.SORT_BY_LEVEL ? !this._descendingSort : false;
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByLevel);
               this._sortingParams.sortType = this.SORT_BY_LEVEL;
               this._sortingParams.descending = this._descendingSort;
               this._sortingParams.btnTarget = target.name;
               this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               this.updateSortArrow(target);
               break;
            case this.btn_sortByRank:
               this._descendingSort = this._sortingParams.sortType == this.SORT_BY_RANK ? !this._descendingSort : false;
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByRank);
               this._sortingParams.sortType = this.SORT_BY_RANK;
               this._sortingParams.descending = this._descendingSort;
               this._sortingParams.btnTarget = target.name;
               this.sysApi.setData(this.DATA_SORT_MEMBERS,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               this.updateSortArrow(target);
               break;
            case this.btn_guildInfo:
               if(this._nCurrentTab != this.GUILD_INFO_TAB)
               {
                  this._nCurrentTab = this.GUILD_INFO_TAB;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
               }
               break;
            case this.btn_members:
               if(this._nCurrentTab != this.GUILD_MEMBERS_TAB)
               {
                  this._nCurrentTab = this.GUILD_MEMBERS_TAB;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
               }
               break;
            case this.btn_resetSearch:
               this.resetSearch();
               break;
            case this.btn_apply:
               if(this._data.guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.AUTOMATIC)
               {
                  this.openJoinPopup(GuildWrapper.fromGuildFactSheetWrapper(this._data as GuildFactSheetWrapper));
               }
               else if(this._data.guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.MANUAL)
               {
                  if(this.playerApi.getApplicationInfo())
                  {
                     this.openApplyPopup(GuildWrapper.fromGuildFactSheetWrapper(this._data as GuildFactSheetWrapper),this.playerApi.getApplicationInfo().applyText);
                  }
                  else
                  {
                     this.openApplyPopup(GuildWrapper.fromGuildFactSheetWrapper(this._data as GuildFactSheetWrapper));
                  }
               }
         }
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
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_inviteInAlliance:
               tooltipText = this.uiApi.getText("ui.alliance.inviteLeader",this._data.leaderName);
               break;
            case this.tx_disabled:
               tooltipText = this.uiApi.getText("ui.guild.disabled");
               break;
            case this.btn_apply:
               if(this.btn_apply.softDisabled)
               {
                  if(this._data.guildRecruitmentInfo.isMinLevelRequired && this.playerApi.getPlayedCharacterInfo().level < this._data.guildRecruitmentInfo.minLevel || this._data.guildRecruitmentInfo.areMinAchievementPointsRequired && this.playerApi.getAchievementPoints() < this._data.guildRecruitmentInfo.minAchievementPoints)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.requirementWarning");
                  }
                  else if(this.playerApi.getApplicationInfo())
                  {
                     tooltipText = this.uiApi.getText("ui.guild.cantJoinPendingApplication");
                  }
                  else if(this.secureApi.SecureModeisActive())
                  {
                     tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
                  }
               }
               break;
            default:
               if(target.name.indexOf("tx_memberLvl") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.tooltip.OmegaLevel");
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
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         if(target.name.indexOf("tx_emblemBack") != -1)
         {
            this.utilApi.changeColor(target.getChildByName("back"),this._data.backEmblem.color,1);
         }
         else if(target.name.indexOf("tx_emblemUp") != -1)
         {
            icon = this.dataApi.getEmblemSymbol(this._data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._data.upEmblem.color,0,true);
            }
         }
      }
      
      public function sortPlayersByName(a:CharacterMinimalGuildPublicInformations, b:CharacterMinimalGuildPublicInformations, forceAsc:Boolean = false) : int
      {
         var nameA:String = StringUtils.noAccent(a.name);
         var nameB:String = StringUtils.noAccent(b.name);
         if(nameA > nameB)
         {
            return !this._descendingSort || forceAsc ? 1 : -1;
         }
         if(nameA < nameB)
         {
            return !this._descendingSort || forceAsc ? -1 : 1;
         }
         return 0;
      }
      
      public function sortPlayersByLevel(a:CharacterMinimalGuildPublicInformations, b:CharacterMinimalGuildPublicInformations) : int
      {
         var levelA:uint = a.level;
         var levelB:uint = b.level;
         if(levelA > levelB)
         {
            return !!this._descendingSort ? -1 : 1;
         }
         if(levelA < levelB)
         {
            return !!this._descendingSort ? 1 : -1;
         }
         return this.sortPlayersByName(a,b,true);
      }
      
      public function sortPlayersByRank(a:CharacterMinimalGuildPublicInformations, b:CharacterMinimalGuildPublicInformations) : int
      {
         var rankNameA:RankName = this.dataApi.getRankName(a.rank);
         var rankNameB:RankName = this.dataApi.getRankName(b.rank);
         if(rankNameA.order > rankNameB.order)
         {
            return !!this._descendingSort ? -1 : 1;
         }
         if(rankNameA.order < rankNameB.order)
         {
            return !!this._descendingSort ? 1 : -1;
         }
         return this.sortPlayersByName(a,b,true);
      }
      
      private function processTagsText(tags:Vector.<uint>) : String
      {
         var tag:GuildTag = null;
         var tagType:GuildTagsType = null;
         var tagId:uint = 0;
         var listText:String = null;
         var tmpText:* = null;
         var tmpTextWidth:Number = NaN;
         var tagKey:* = null;
         var sortedTags:Dictionary = new Dictionary();
         var index:uint = 0;
         var guildTagTypes:Array = this.dataApi.getAllGuildTagsType();
         for each(tagType in guildTagTypes)
         {
            if(sortedTags[tagType.id] == null)
            {
               sortedTags[tagType.id] = [];
            }
         }
         for each(tagId in tags)
         {
            tag = this.dataApi.getGuildTagById(tagId);
            if(sortedTags[tag.typeId] == null)
            {
               sortedTags[tag.typeId] = [];
            }
            sortedTags[tag.typeId].push(tag);
         }
         listText = "";
         tmpText = "";
         tmpTextWidth = this.lbl_guildTags.width;
         for(tagKey in sortedTags)
         {
            switch(int(tagKey))
            {
               case this.TAG_TYPE_INTEREST:
                  tmpText = "<b><font color=\'#e0e0de\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_INTEREST).name + this.uiApi.getText("ui.common.colon") + " </font></b>";
                  if(sortedTags[tagKey].length > 0)
                  {
                     for(index = 0; index < sortedTags[tagKey].length; index++)
                     {
                        tag = sortedTags[tagKey][index];
                        tmpText += this.clearTagText(tag.name) + (index < sortedTags[tagKey].length - 1 ? ", " : "");
                     }
                  }
                  else
                  {
                     tmpText += this.EMPTY_TEXT;
                  }
                  tmpTextWidth = this.uiApi.getTextSize(tmpText,this.lbl_guildTags.css,this.lbl_guildTags.cssClass).width;
                  listText += tmpText;
                  break;
               case this.TAG_TYPE_ATMOSPHERE:
                  listText += tmpTextWidth > this.lbl_guildTags.width ? "\n" : "\n\n";
                  tmpText = "<b><font color=\'#e0e0de\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_ATMOSPHERE).name + this.uiApi.getText("ui.common.colon") + " </font></b>";
                  if(sortedTags[tagKey].length > 0)
                  {
                     for(index = 0; index < sortedTags[tagKey].length; index++)
                     {
                        tag = sortedTags[tagKey][index];
                        tmpText += this.clearTagText(tag.name) + (index < sortedTags[tagKey].length - 1 ? ", " : "");
                     }
                  }
                  else
                  {
                     tmpText += this.EMPTY_TEXT;
                  }
                  tmpTextWidth = this.uiApi.getTextSize(tmpText,this.lbl_guildTags.css,this.lbl_guildTags.cssClass).width;
                  listText += tmpText;
                  break;
               case this.TAG_TYPE_PLAY_TIME:
                  listText += tmpTextWidth > this.lbl_guildTags.width ? "\n" : "\n\n";
                  tmpText = "<b><font color=\'#e0e0de\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_PLAY_TIME).name + this.uiApi.getText("ui.common.colon") + " </font></b>";
                  if(sortedTags[tagKey].length > 0)
                  {
                     for(index = 0; index < sortedTags[tagKey].length; index++)
                     {
                        tag = sortedTags[tagKey][index];
                        tmpText += this.clearTagText(tag.name) + (index < sortedTags[tagKey].length - 1 ? ", " : "");
                     }
                  }
                  else
                  {
                     tmpText += this.EMPTY_TEXT;
                  }
                  tmpTextWidth = this.uiApi.getTextSize(tmpText,this.lbl_guildTags.css,this.lbl_guildTags.cssClass).width;
                  listText += tmpText;
                  break;
            }
         }
         return listText;
      }
      
      private function clearTagText(tag:String) : String
      {
         var index:int = tag.indexOf("(");
         if(index > -1)
         {
            tag = tag.substr(0,index - 1);
         }
         return tag;
      }
      
      private function updateSortArrow(target:GraphicContainer) : void
      {
         var btn_lbl_target:Label = this["btn_lbl_" + target.name];
         this.tx_sortDown.visible = !this._sortingParams.descending;
         this.tx_sortUp.visible = this._sortingParams.descending;
         var pos:int = 0;
         switch(btn_lbl_target.textFormat.align)
         {
            case TextAlign.LEFT:
            case TextAlign.JUSTIFY:
               pos = target.anchorX + btn_lbl_target.textWidth + this.SORT_ARROW_OFFSET + 3;
               break;
            case TextAlign.CENTER:
               pos = target.anchorX + btn_lbl_target.width / 2 + btn_lbl_target.textWidth / 2 + this.SORT_ARROW_OFFSET;
               break;
            case TextAlign.RIGHT:
               pos = target.anchorX + btn_lbl_target.width + this.SORT_ARROW_OFFSET;
         }
         this.tx_sortDown.x = this.tx_sortUp.x = pos;
      }
      
      private function sortMembers() : void
      {
         switch(this._sortingParams.sortType)
         {
            case this.SORT_BY_NAME:
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByName);
               break;
            case this.SORT_BY_LEVEL:
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByLevel);
               break;
            case this.SORT_BY_RANK:
               this.gd_members.dataProvider = this.gd_members.dataProvider.sort(this.sortPlayersByRank);
         }
      }
      
      private function searchMember() : void
      {
         this.gd_members.dataProvider = this.utilApi.filter(this._data.members,this._currentSearchText,"name");
         this.sortMembers();
      }
      
      private function resetSearch() : void
      {
         this._currentSearchText = null;
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this.gd_members.dataProvider = this._data.members;
         this.sortMembers();
      }
      
      private function openJoinPopup(data:GuildWrapper) : void
      {
         var popup:UiRootContainer = this.uiApi.getUi("guildJoin");
         if(popup)
         {
            popup.setOnTop();
         }
         else
         {
            this.uiApi.loadUi(UIEnum.GUILD_JOIN_POPUP,"guildJoin",{"guild":data});
         }
      }
      
      private function openApplyPopup(data:GuildWrapper, presentation:String = null) : void
      {
         var params:Object = {"guild":data};
         if(presentation != null)
         {
            params.presentation = presentation;
         }
         else if(this._guildDirectoryFilters)
         {
            params.filters = this._guildDirectoryFilters;
         }
         var popup:UiRootContainer = this.uiApi.getUi("guildApply");
         if(popup)
         {
            popup.setOnTop();
         }
         else
         {
            this.uiApi.loadUi(UIEnum.GUILD_APPLY_POPUP,"guildApply",params);
         }
      }
      
      public function onGuildPlayerApplication(guildInfo:GuildInformations, application:GuildApplicationInformation) : void
      {
         if(application != null)
         {
            this.btn_apply.softDisabled = !this.canJoinGuild();
         }
      }
      
      public function onGuildPlayerApplicationDeleted(deleted:Boolean) : void
      {
         if(deleted)
         {
            this.btn_apply.softDisabled = !this.canJoinGuild();
         }
      }
      
      public function onGuildApplicationIsAnswered(guildInfo:GuildInformations, accepted:Boolean) : void
      {
         this.btn_apply.softDisabled = !this.canJoinGuild();
      }
      
      public function onGuildJoined() : void
      {
         this.btn_apply.visible = this._data.guildRecruitmentInfo.recruitmentType != GuildRecruitmentTypeEnum.DISABLED && !this.socialApi.hasGuild() && !this.socialApi.hasAlliance();
      }
      
      public function onGuildLeft() : void
      {
         this.btn_apply.visible = this._data.guildRecruitmentInfo.recruitmentType != GuildRecruitmentTypeEnum.DISABLED && !this.socialApi.hasGuild() && !this.socialApi.hasAlliance();
      }
   }
}
