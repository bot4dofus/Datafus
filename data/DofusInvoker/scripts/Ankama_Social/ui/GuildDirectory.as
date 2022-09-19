package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.GuildTag;
   import com.ankamagames.dofus.datacenter.guild.GuildTagsType;
   import com.ankamagames.dofus.datacenter.servers.ServerLang;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildDirectoryFiltersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowGuildManager;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSummaryRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildRecruitmentTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildSummarySortEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.application.GuildApplicationInformation;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class GuildDirectory
   {
      
      private static const CTR_SEARCH:String = "ctr_searchBar";
      
      private static const CTR_FILTER_CAT:String = "ctr_filterCategory";
      
      private static const CTR_FILTER:String = "ctr_filter";
      
      private static const CTR_FILTER_GUILD_LEVEL:String = "ctr_filterGuildLevel";
      
      private static const CTR_FILTER_DESIRED_LEVEL:String = "ctr_filterDesiredLevel";
      
      private static const CTR_FILTER_ACHIEVEMENT:String = "ctr_filterAchievement";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private const MAX_GUILD_COUNT_PER_REQUEST:uint = 40;
      
      private const SEARCHBAR_CAT_ID:uint = 0;
      
      private const GUILD_LEVEL_CAT_ID:uint = 1;
      
      private const RECRUITMENT_CAT_ID:uint = 2;
      
      private const INTERESTS_CAT_ID:uint = 3;
      
      private const ATMOSPHERE_CAT_ID:uint = 4;
      
      private const PLAY_TIME_CAT_ID:uint = 5;
      
      private const LANGUAGE_CAT_ID:uint = 6;
      
      private const DESIRED_LEVEL_CAT_ID:uint = 7;
      
      private const ACHIEVEMENT_CAT_ID:uint = 8;
      
      private const RECRUITMENT_NAME_ID:String = "recruitment";
      
      private const LANGUAGE_NAME_ID:String = "language";
      
      private const INTEREST_NAME_ID:String = "interest";
      
      private const ATMOSPHERE_NAME_ID:String = "atmosphere";
      
      private const PLAY_TIME_NAME_ID:String = "playTime";
      
      private const TAG_TYPE_INTEREST:uint = 1;
      
      private const TAG_TYPE_ATMOSPHERE:uint = 2;
      
      private const TAG_TYPE_PLAY_TIME:uint = 3;
      
      private const SORT_ARROW_OFFSET:uint = 8;
      
      private const DATA_SORT_DIRECTORY:String = "sortGuildDirectory";
      
      private const DATA_OPENED_CAT_DIRECTORY:String = "openedCatGuildDirectory";
      
      private var _isScrollListener:Boolean = false;
      
      private var _searchCriteria:String = "";
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _componentList:Dictionary;
      
      private var _openedCategories:Array;
      
      private var _dataFilters:Array;
      
      private var _inputTimer:BenchmarkTimer;
      
      private var _filterTimer:BenchmarkTimer;
      
      private var _currentMinGuildLevel:uint = 1;
      
      private var _currentMaxGuildLevel:uint = 200;
      
      private var _currentMinDesiredLevel:uint = 1;
      
      private var _currentMaxDesiredLevel:uint = 200;
      
      private var _currentMinAchievement:uint = 0;
      
      private var _currentMaxAchievement:uint = 20792;
      
      private var _totalSuccessPoints:Number = 0;
      
      private var _currentFilters:GuildDirectoryFiltersWrapper;
      
      private var _canSendRequest:Boolean = true;
      
      private var _displayApplication:Boolean;
      
      private var _currentGuildRollOver:Object;
      
      private var _nbTotalGuild:uint;
      
      private var _playerApplication:GuildApplicationInformation;
      
      private var _guildApplication:GuildWrapper;
      
      private var _updateApplication:Boolean;
      
      private var _sortingParams:Object;
      
      private var _guildsTimeoutHandle:uint = 0;
      
      private var _lastRealIndex:uint = 0;
      
      private var _isScrolling:Boolean = false;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabMembers:ButtonContainer;
      
      public var btn_tabActivity:ButtonContainer;
      
      public var btn_lbl_btn_tabName:Label;
      
      public var btn_lbl_btn_tabLevel:Label;
      
      public var btn_lbl_btn_tabMembers:Label;
      
      public var btn_lbl_btn_tabActivity:Label;
      
      public var tx_sortDown:Texture;
      
      public var tx_sortUp:Texture;
      
      public var gd_guilds:Grid;
      
      public var gd_filters:Grid;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var inp_minGuildLevel:Input;
      
      public var inp_maxGuildLevel:Input;
      
      public var inp_minDesiredLevel:Input;
      
      public var inp_maxDesiredLevel:Input;
      
      public var inp_minAchievement:Input;
      
      public var inp_maxAchievement:Input;
      
      public var ctr_application:GraphicContainer;
      
      public var ctr_applicationHeader:GraphicContainer;
      
      public var ctr_applicationDescription:GraphicContainer;
      
      public var tx_catPlusMinusApp:Texture;
      
      public var tx_emblemBackGuildApp:Texture;
      
      public var tx_emblemUpGuildApp:Texture;
      
      public var lbl_guildNameApp:Label;
      
      public var lbl_Application:Label;
      
      public var lbl_editApp:Label;
      
      public var btn_cancelApp:ButtonContainer;
      
      public var lbl_guildCount:Label;
      
      public var lbl_noResult:Label;
      
      public var lbl_howToCreateGuild:Label;
      
      public var btn_showOfflineMembers:ButtonContainer;
      
      public function GuildDirectory()
      {
         this._componentList = new Dictionary();
         this._inputTimer = new BenchmarkTimer(200,0,"GuildDirectory._inputTimer");
         this._filterTimer = new BenchmarkTimer(500,0,"GuildDirectory._filterTimer");
         this._sortingParams = {
            "sortType":GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY,
            "descending":false,
            "btnTarget":"btn_tabActivity"
         };
         super();
      }
      
      public function get currentFilters() : GuildDirectoryFiltersWrapper
      {
         return this._currentFilters;
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(HookList.GuildsReceived,this.onGuildList);
         this.sysApi.addHook(SocialHookList.GuildPlayerApplicationReceived,this.onGuildPlayerApplication);
         this.sysApi.addHook(SocialHookList.GuildPlayerApplicationDeleted,this.onGuildPlayerApplicationDeleted);
         this.sysApi.addHook(SocialHookList.GuildApplicationIsAnswered,this.onGuildApplicationIsAnswered);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.uiApi.addComponentHook(this.gd_filters,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_showOfflineMembers,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabActivity,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabActivity,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabActivity,ComponentHookList.ON_ROLL_OUT);
         if(this.ctr_applicationHeader)
         {
            this.uiApi.addComponentHook(this.ctr_applicationHeader,ComponentHookList.ON_RELEASE);
         }
         if(this.btn_cancelApp)
         {
            this.uiApi.addComponentHook(this.btn_cancelApp,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_cancelApp,ComponentHookList.ON_ROLL_OUT);
            this.btn_cancelApp.softDisabled = this.secureApi.SecureModeisActive();
         }
         if(this.lbl_editApp)
         {
            this.uiApi.addComponentHook(this.lbl_editApp,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.lbl_editApp,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.lbl_editApp,ComponentHookList.ON_ROLL_OUT);
            if(this.secureApi.SecureModeisActive())
            {
               this.lbl_editApp.cssClass = "darkright";
            }
         }
         this._totalSuccessPoints = this.dataApi.getTotalAchievementPoints();
         this._currentMaxAchievement = this._totalSuccessPoints;
         this._sortingParams = this.sysApi.getSetData(this.DATA_SORT_DIRECTORY,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
         this.updateSortArrow(this[this._sortingParams.btnTarget]);
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.guild.searchGuild");
         this._inputTimer.addEventListener(TimerEvent.TIMER,this.sendRequest);
         this._filterTimer.addEventListener(TimerEvent.TIMER,this.sendRequest);
         this._openedCategories = this.sysApi.getSetData(this.DATA_OPENED_CAT_DIRECTORY,[this.SEARCHBAR_CAT_ID,this.GUILD_LEVEL_CAT_ID,this.RECRUITMENT_CAT_ID],DataStoreEnum.BIND_CHARACTER);
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getCatLineType(data,line))
         {
            case CTR_SEARCH:
               this.inp_search = componentsRef.inp_search;
               this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
               this.btn_resetSearch = componentsRef.btn_resetSearch;
               if(this._searchCriteria)
               {
                  this.btn_resetSearch.visible = true;
                  this.inp_search.text = this._searchCriteria;
               }
               else if(!this._searchCriteria && this.inp_search.text == "" && !this.inp_search.haveFocus || this.inp_search.text == this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                  this.btn_resetSearch.visible = false;
               }
               break;
            case CTR_FILTER_CAT:
               componentsRef.lbl_catName.text = data.name;
               componentsRef.btn_cat.selected = selected;
               if(this._openedCategories.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               break;
            case CTR_FILTER:
               if(!this._componentList[componentsRef.btn_selectFilter.name])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_selectFilter,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.btn_selectFilter.name] = data;
               if(data.gfxId && data.gfxId != "null")
               {
                  componentsRef.btn_label_btn_selectFilter.x = 58;
                  componentsRef.tx_picto.visible = true;
                  (componentsRef.tx_picto as Texture).graphics.lineStyle(1,13092805);
                  (componentsRef.tx_picto as Texture).graphics.beginFill(13092805,0);
                  (componentsRef.tx_picto as Texture).graphics.drawRect(0,0,componentsRef.tx_picto.width,componentsRef.tx_picto.height);
                  (componentsRef.tx_picto as Texture).graphics.endFill();
                  componentsRef.tx_picto.uri = this.uiApi.createUri(data.gfxId);
               }
               else
               {
                  componentsRef.btn_label_btn_selectFilter.x = 30;
                  componentsRef.tx_picto.visible = false;
                  componentsRef.tx_picto.uri = null;
                  (componentsRef.tx_picto as Texture).graphics.clear();
               }
               componentsRef.btn_selectFilter.selected = data.selected;
               componentsRef.btn_label_btn_selectFilter.text = data.text;
               break;
            case CTR_FILTER_GUILD_LEVEL:
               this.inp_minGuildLevel = componentsRef.inp_minGuildLevel;
               this.uiApi.addComponentHook(this.inp_minGuildLevel,ComponentHookList.ON_CHANGE);
               this.inp_maxGuildLevel = componentsRef.inp_maxGuildLevel;
               this.uiApi.addComponentHook(this.inp_maxGuildLevel,ComponentHookList.ON_CHANGE);
               componentsRef.inp_minGuildLevel.text = this._currentMinGuildLevel;
               componentsRef.inp_maxGuildLevel.text = this._currentMaxGuildLevel;
               break;
            case CTR_FILTER_DESIRED_LEVEL:
               this.inp_minDesiredLevel = componentsRef.inp_minDesiredLevel;
               this.uiApi.addComponentHook(this.inp_minDesiredLevel,ComponentHookList.ON_CHANGE);
               this.inp_maxDesiredLevel = componentsRef.inp_maxDesiredLevel;
               this.uiApi.addComponentHook(this.inp_maxDesiredLevel,ComponentHookList.ON_CHANGE);
               componentsRef.inp_minDesiredLevel.text = this._currentMinDesiredLevel;
               componentsRef.inp_maxDesiredLevel.text = this._currentMaxDesiredLevel;
               break;
            case CTR_FILTER_ACHIEVEMENT:
               this.inp_minAchievement = componentsRef.inp_minAchievement;
               this.uiApi.addComponentHook(this.inp_minAchievement,ComponentHookList.ON_CHANGE);
               this.inp_maxAchievement = componentsRef.inp_maxAchievement;
               this.uiApi.addComponentHook(this.inp_maxAchievement,ComponentHookList.ON_CHANGE);
               componentsRef.inp_minAchievement.text = this._currentMinAchievement;
               componentsRef.inp_maxAchievement.text = this._currentMaxAchievement;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data.isCat)
         {
            return CTR_FILTER_CAT;
         }
         if(data.hasOwnProperty("id") && data.id == "search")
         {
            return CTR_SEARCH;
         }
         if(data.hasOwnProperty("id") && data.id == "guildLevel")
         {
            return CTR_FILTER_GUILD_LEVEL;
         }
         if(data.hasOwnProperty("id") && data.id == "desiredLevel")
         {
            return CTR_FILTER_DESIRED_LEVEL;
         }
         if(data.hasOwnProperty("id") && data.id == "achievement")
         {
            return CTR_FILTER_ACHIEVEMENT;
         }
         return CTR_FILTER;
      }
      
      public function updateGuildLine(data:GuildWrapper, components:*, selected:Boolean) : void
      {
         var recruitmentInfo:GuildRecruitmentDataWrapper = null;
         var playerInfo:Object = null;
         if(data)
         {
            if(!this._componentList[components.lbl_guildName.name])
            {
               this.uiApi.addComponentHook(components.lbl_guildName,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.lbl_guildName,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.lbl_guildName.name] = data;
            if(!this._componentList[components.gd_flags.name])
            {
               this.uiApi.addComponentHook(components.gd_flags,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.gd_flags,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.gd_flags.name] = data;
            if(!this._componentList[components.lbl_details.name])
            {
               this.uiApi.addComponentHook(components.lbl_details,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.lbl_details,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.lbl_details.name] = data;
            if(!this._componentList[components.btn_join.name])
            {
               this.uiApi.addComponentHook(components.btn_join,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_join,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_join,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.btn_join.name] = data;
            if(!this._componentList[components.btn_line.name])
            {
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_RELEASE);
            }
            this._componentList[components.btn_line.name] = {
               "data":data,
               "detailsLabel":components.lbl_details
            };
            if(!this._componentList[components.gd_flags.name])
            {
               this.uiApi.addComponentHook(components.gd_flags,ComponentHookList.ON_RELEASE);
            }
            this._componentList[components.gd_flags.name] = data;
            if(!this._componentList[components.tx_interest.name])
            {
               this.uiApi.addComponentHook(components.tx_interest,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_interest,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_interest.name] = data;
            if(!this._componentList[components.tx_minLevel.name])
            {
               this.uiApi.addComponentHook(components.tx_minLevel,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_minLevel,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_minLevel.name] = data;
            if(!this._componentList[components.tx_minAP.name])
            {
               this.uiApi.addComponentHook(components.tx_minAP,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_minAP,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_minAP.name] = data;
            if(!this._componentList[components.tx_emblemBackGuild.name])
            {
               components.tx_emblemBackGuild.useCache = false;
               this.uiApi.addComponentHook(components.tx_emblemBackGuild,ComponentHookList.ON_TEXTURE_READY);
               this.uiApi.addComponentHook(components.tx_emblemBackGuild,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_emblemBackGuild,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_emblemBackGuild.name] = data;
            if(!this._componentList[components.tx_emblemUpGuild.name])
            {
               components.tx_emblemUpGuild.useCache = false;
               this.uiApi.addComponentHook(components.tx_emblemUpGuild,ComponentHookList.ON_TEXTURE_READY);
               this.uiApi.addComponentHook(components.tx_emblemUpGuild,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_emblemUpGuild,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_emblemUpGuild.name] = data;
            this.activePlaceholder(components,false);
            components.lbl_guildLvl.text = data.level.toString();
            components.lbl_guildName.text = this.chatApi.getGuildLink(data,data.guildName);
            components.lbl_guildName.width = (components.lbl_guildName as Label).textWidth + 5;
            components.gd_flags.visible = true;
            components.gd_flags.width = data.guildRecruitmentInfo.selectedLanguages.length * 20;
            components.gd_flags.x = components.lbl_guildName.x + components.lbl_guildName.textWidth + 10;
            components.gd_flags.dataProvider = data.guildRecruitmentInfo.selectedLanguages.length == 0 ? [] : data.guildRecruitmentInfo.selectedLanguages;
            components.lbl_guildDescription.text = data.guildRecruitmentInfo.recruitmentTitle;
            if(components.lbl_guildDescription.text == "")
            {
               if(this.socialApi.hasGuild())
               {
                  components.ctr_name_flags.y = data.guildRecruitmentInfo.selectedCriteria.length > 0 || data.guildRecruitmentInfo.minLevel > 1 || data.guildRecruitmentInfo.minAchievementPoints > 0 ? 30 : 40;
                  components.ctr_interest.y = 55;
               }
               else
               {
                  components.ctr_name_flags.y = data.guildRecruitmentInfo.selectedCriteria.length > 0 || data.guildRecruitmentInfo.minLevel > 1 || data.guildRecruitmentInfo.minAchievementPoints > 0 ? 36 : 46;
                  components.ctr_interest.y = 61;
               }
            }
            else
            {
               components.ctr_name_flags.y = 16;
               components.ctr_interest.y = 76;
            }
            components.lbl_guildMembers.text = data.nbMembers.toString() + "/" + this.socialApi.getGuildMembersMax(data.level);
            components.lbl_guilActivity.visible = true;
            components.lbl_guilActivity.text = data.lastActivityDay > 30 ? "---" : this.timeApi.getDate(this.timeApi.getTimestamp() - data.lastActivityDay * TimeApi.DAY_TO_MILLISECOND,true);
            components.lbl_details.text = this.chatApi.getGuildLink(data,this.uiApi.getText("ui.guild.seeDetails"));
            components.btn_join.visible = !this.socialApi.hasGuild();
            components.btn_line.visible = true;
            components.btn_join.softDisabled = this.secureApi.SecureModeisActive();
            if(data.guildRecruitmentInfo)
            {
               recruitmentInfo = data.guildRecruitmentInfo;
               switch(recruitmentInfo.recruitmentType)
               {
                  case GuildRecruitmentTypeEnum.DISABLED:
                     components.btn_join.visible = false;
                     break;
                  case GuildRecruitmentTypeEnum.MANUAL:
                     components.btn_join.softDisabled = this.socialApi.hasGuild() || this._playerApplication != null || this.secureApi.SecureModeisActive() || data.nbPendingApply >= 50;
                     components.btn_lbl_btn_join.text = this.uiApi.getText("ui.guild.apply");
                     break;
                  case GuildRecruitmentTypeEnum.AUTOMATIC:
                     components.btn_join.softDisabled = this.socialApi.hasGuild() || this._playerApplication != null || this.secureApi.SecureModeisActive() || data.nbMembers >= this.socialApi.getGuildMembersMax(data.level);
                     components.btn_lbl_btn_join.text = this.uiApi.getText("ui.common.join");
                     playerInfo = this.playerApi.getPlayedCharacterInfo();
                     if(recruitmentInfo.isMinLevelRequired && (playerInfo === null || playerInfo.level < recruitmentInfo.minLevel))
                     {
                        components.btn_join.softDisabled = true;
                     }
                     if(recruitmentInfo.areMinAchievementPointsRequired && this.playerApi.getAchievementPoints() < recruitmentInfo.minAchievementPoints)
                     {
                        components.btn_join.softDisabled = true;
                     }
               }
            }
            if(!components.btn_join.visible)
            {
               components.lbl_details.y = !!this.socialApi.hasGuild() ? 39 : 45;
            }
            else
            {
               components.lbl_details.y = 75;
            }
            components.tx_interest.visible = data.guildRecruitmentInfo.selectedCriteria.length > 0;
            components.tx_minLevel.visible = data.guildRecruitmentInfo.minLevel > 1;
            components.tx_minAP.visible = data.guildRecruitmentInfo.minAchievementPoints > 0;
            if(data.backEmblem)
            {
               components.tx_emblemBackGuild.uri = data.backEmblem.fullSizeIconUri;
               components.tx_emblemUpGuild.uri = data.upEmblem.fullSizeIconUri;
            }
         }
         else
         {
            if(this.socialApi.hasGuild())
            {
               this.activePlaceholder(components,this.gd_guilds.dataProvider.length > 4);
            }
            else
            {
               this.activePlaceholder(components,this.gd_guilds.dataProvider.length > 5);
            }
            components.gd_flags.dataProvider = null;
            components.lbl_guildLvl.text = "";
            components.lbl_guildName.text = "";
            components.gd_flags.visible = false;
            components.lbl_guildDescription.text = "";
            components.lbl_guildMembers.text = "";
            components.lbl_guilActivity.visible = false;
            components.tx_emblemBackGuild.uri = null;
            components.tx_emblemUpGuild.uri = null;
            components.btn_join.visible = false;
            components.lbl_details.text = "";
            components.tx_interest.visible = false;
            components.tx_minLevel.visible = false;
            components.tx_minAP.visible = false;
            components.btn_line.visible = false;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var guildWrapper:GuildWrapper = null;
         var icon:EmblemSymbol = null;
         if(target.name.indexOf("tx_emblemBack") != -1)
         {
            if(this.tx_emblemBackGuildApp && target.name == this.tx_emblemBackGuildApp.name)
            {
               guildWrapper = this._guildApplication;
            }
            else
            {
               guildWrapper = this._componentList[target.name];
            }
            this.utilApi.changeColor(target.getChildByName("back"),guildWrapper.backEmblem.color,1);
         }
         else if(target.name.indexOf("tx_emblemUp") != -1)
         {
            if(this.tx_emblemUpGuildApp && target.name == this.tx_emblemUpGuildApp.name)
            {
               guildWrapper = this._guildApplication;
            }
            else
            {
               guildWrapper = this._componentList[target.name];
            }
            icon = this.dataApi.getEmblemSymbol(guildWrapper.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(target,guildWrapper.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(target,guildWrapper.upEmblem.color,0,true);
            }
         }
      }
      
      public function updateFlags(data:*, components:*, selected:Boolean) : void
      {
         if(data !== null)
         {
            if(!this._componentList[components.tx_flag.name])
            {
               this.uiApi.addComponentHook(components.tx_flag,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_flag,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_flag.name] = data;
            components.tx_flag.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "/languages/language_" + data + ".png");
            (components.tx_flag as Texture).graphics.lineStyle(1,13092805);
            (components.tx_flag as Texture).graphics.beginFill(13092805,0);
            (components.tx_flag as Texture).graphics.drawRect(0,0,components.tx_flag.width,components.tx_flag.height);
            (components.tx_flag as Texture).graphics.endFill();
         }
         else
         {
            components.tx_flag.uri = null;
            (components.tx_flag as Texture).graphics.clear();
         }
      }
      
      private function initFilters() : void
      {
         this._currentFilters = new GuildDirectoryFiltersWrapper();
         this._currentFilters.maxSuccessFilter = this._totalSuccessPoints;
         this._currentFilters.sortType = this._sortingParams.sortType;
         this._currentFilters.sortDescending = this._sortingParams.descending;
         this._dataFilters = [];
         this._dataFilters.push({
            "isCat":false,
            "catId":this.SEARCHBAR_CAT_ID,
            "id":"search"
         });
         this._dataFilters.push({
            "name":this.uiApi.getText("ui.guild.guildLevel"),
            "id":this.GUILD_LEVEL_CAT_ID,
            "isCat":true
         });
         this._dataFilters.push({
            "isCat":false,
            "catId":this.GUILD_LEVEL_CAT_ID,
            "id":"guildLevel"
         });
         this.initRecruitmentFilters();
         this.initTagsFilters();
         this.initLanguageFilters();
         this._dataFilters.push({
            "name":this.uiApi.getText("ui.guild.playerDesiredLevel"),
            "id":this.DESIRED_LEVEL_CAT_ID,
            "isCat":true
         });
         this._dataFilters.push({
            "isCat":false,
            "catId":this.DESIRED_LEVEL_CAT_ID,
            "id":"desiredLevel"
         });
         this._dataFilters.push({
            "name":this.uiApi.getText("ui.guild.playerDesiredAP"),
            "id":this.ACHIEVEMENT_CAT_ID,
            "isCat":true
         });
         this._dataFilters.push({
            "isCat":false,
            "catId":this.ACHIEVEMENT_CAT_ID,
            "id":"achievement"
         });
      }
      
      private function initRecruitmentFilters() : void
      {
         this._dataFilters.push({
            "name":this.uiApi.getText("ui.guild.recruitment"),
            "id":this.RECRUITMENT_CAT_ID,
            "isCat":true
         });
         this._dataFilters.push(new FilterGridItem(GuildRecruitmentTypeEnum.AUTOMATIC,this.RECRUITMENT_NAME_ID,this.uiApi.getText("ui.guild.openAuto"),null,false,this.RECRUITMENT_CAT_ID));
         this._dataFilters.push(new FilterGridItem(GuildRecruitmentTypeEnum.MANUAL,this.RECRUITMENT_NAME_ID,this.uiApi.getText("ui.guild.openManual"),null,false,this.RECRUITMENT_CAT_ID));
         this._dataFilters.push(new FilterGridItem(GuildRecruitmentTypeEnum.DISABLED,this.RECRUITMENT_NAME_ID,this.uiApi.getText("ui.guild.close"),null,false,this.RECRUITMENT_CAT_ID));
      }
      
      private function initLanguageFilters() : void
      {
         var language:ServerLang = null;
         var languageObjs:Array = [];
         var languages:Array = ServerLang.getServerLangs();
         for each(language in languages)
         {
            if(language !== null)
            {
               languageObjs.push(new FilterGridItem(language.id,this.LANGUAGE_NAME_ID,language.name,this.uiApi.me().getConstant("texture") + "/languages/language_" + language.id + ".png",false,this.LANGUAGE_CAT_ID));
            }
         }
         languageObjs.sortOn("text",Array.CASEINSENSITIVE);
         this._dataFilters.push({
            "name":this.uiApi.getText("ui.guild.language"),
            "id":this.LANGUAGE_CAT_ID,
            "isCat":true
         });
         this._dataFilters = this._dataFilters.concat(languageObjs);
      }
      
      private function initTagsFilters() : void
      {
         var allTags:Vector.<GuildTag> = null;
         var tag:GuildTag = null;
         var tagType:GuildTagsType = null;
         var key:* = null;
         var allTagsType:Array = this.dataApi.getAllGuildTagsType();
         var sortedTags:Dictionary = new Dictionary(true);
         for each(tagType in allTagsType)
         {
            switch(tagType.id)
            {
               case this.TAG_TYPE_INTEREST:
                  if(sortedTags[tagType.id] == null)
                  {
                     sortedTags[tagType.id] = [];
                     sortedTags[tagType.id].push({
                        "name":tagType.name,
                        "id":this.INTERESTS_CAT_ID,
                        "isCat":true
                     });
                  }
                  allTags = this.dataApi.getGuildTagsFromGuildTagId(tagType.id);
                  allTags = this.utilApi.sort(allTags,"order",true,true);
                  for each(tag in allTags)
                  {
                     sortedTags[tagType.id].push(new FilterGridItem(tag.id,this.INTEREST_NAME_ID,tag.name,null,false,this.INTERESTS_CAT_ID));
                  }
                  break;
               case this.TAG_TYPE_ATMOSPHERE:
                  if(sortedTags[tagType.id] == null)
                  {
                     sortedTags[tagType.id] = [];
                     sortedTags[tagType.id].push({
                        "name":tagType.name,
                        "id":this.ATMOSPHERE_CAT_ID,
                        "isCat":true
                     });
                  }
                  allTags = this.dataApi.getGuildTagsFromGuildTagId(tagType.id);
                  allTags = this.utilApi.sort(allTags,"order",true,true);
                  for each(tag in allTags)
                  {
                     sortedTags[tagType.id].push(new FilterGridItem(tag.id,this.ATMOSPHERE_NAME_ID,tag.name,null,false,this.ATMOSPHERE_CAT_ID));
                  }
                  break;
               case this.TAG_TYPE_PLAY_TIME:
                  if(sortedTags[tagType.id] == null)
                  {
                     sortedTags[tagType.id] = [];
                     sortedTags[tagType.id].push({
                        "name":tagType.name,
                        "id":this.PLAY_TIME_CAT_ID,
                        "isCat":true
                     });
                  }
                  allTags = this.dataApi.getGuildTagsFromGuildTagId(tagType.id);
                  allTags = this.utilApi.sort(allTags,"order",true,true);
                  for each(tag in allTags)
                  {
                     sortedTags[tagType.id].push(new FilterGridItem(tag.id,this.PLAY_TIME_NAME_ID,tag.name,null,false,this.PLAY_TIME_CAT_ID));
                  }
                  break;
            }
         }
         for(key in sortedTags)
         {
            this._dataFilters = this._dataFilters.concat(sortedTags[key]);
         }
      }
      
      private function displayCategories(selectedCategory:Object = null) : Array
      {
         var myIndex:int = 0;
         var entry:Object = null;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedCategories.indexOf(selecCatId) != -1)
            {
               this._openedCategories.splice(this._openedCategories.indexOf(selecCatId),1);
            }
            else
            {
               this._openedCategories.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = new Array();
         for each(entry in this._dataFilters)
         {
            if(entry.isCat)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            if(!entry.isCat && this._openedCategories.indexOf(entry.catId) != -1)
            {
               if(entry.catId == this.SEARCHBAR_CAT_ID)
               {
                  tempCats = tempCats.concat(this.addLineFilter("search",1));
               }
               else if(entry.catId == this.GUILD_LEVEL_CAT_ID && (entry.id && entry.id == "guildLevel"))
               {
                  tempCats = tempCats.concat(this.addLineFilter("guildLevel",1));
               }
               else if(entry.catId == this.DESIRED_LEVEL_CAT_ID && (entry.id && entry.id == "desiredLevel"))
               {
                  tempCats = tempCats.concat(this.addLineFilter("desiredLevel",1));
               }
               else if(entry.catId == this.ACHIEVEMENT_CAT_ID && (entry.id && entry.id == "achievement"))
               {
                  tempCats = tempCats.concat(this.addLineFilter("achievement",1));
               }
               else
               {
                  tempCats.push(entry);
               }
               index++;
            }
         }
         this.sysApi.setData(this.DATA_OPENED_CAT_DIRECTORY,this._openedCategories);
         scrollValue = this.gd_filters.verticalScrollValue;
         this.gd_filters.dataProvider = tempCats;
         this.gd_filters.verticalScrollValue = scrollValue;
         return tempCats;
      }
      
      private function addLineFilter(id:String, nbLine:uint) : Array
      {
         var result:Array = [];
         result.push({"id":id});
         return this.addEmptyLine(result,nbLine);
      }
      
      private function addEmptyLine(array:Array, nb:uint) : Array
      {
         for(var i:int = 0; i < nb; i++)
         {
            array.push(null);
         }
         return array;
      }
      
      private function displayApplication(display:Boolean) : void
      {
         this.ctr_applicationDescription.visible = false;
         this.tx_catPlusMinusApp.uri = !!display ? this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png") : this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
         this.ctr_application.y = !!display ? Number(437) : Number(546);
         this.ctr_applicationDescription.visible = display;
      }
      
      private function showDetailsLabel() : void
      {
         var lbl_details:Label = this._componentList[this._currentGuildRollOver.name].detailsLabel;
         lbl_details.visible = true;
      }
      
      private function hideDetailsLabel() : void
      {
         var lbl_details:Label = this._componentList[this._currentGuildRollOver.name].detailsLabel;
         lbl_details.visible = false;
      }
      
      private function resetSearch() : void
      {
         this._searchCriteria = null;
         this._currentFilters.nameFilter = "";
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this._inputTimer.reset();
         this._lastRealIndex = 0;
         this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,0,this.MAX_GUILD_COUNT_PER_REQUEST));
      }
      
      private function processTagsText(tags:Vector.<uint>) : String
      {
         var tag:GuildTag = null;
         var tagId:uint = 0;
         var listText:String = null;
         var tagKey:* = null;
         var sortedTags:Dictionary = new Dictionary();
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
         for(tagKey in sortedTags)
         {
            (sortedTags[tagKey] as Array).sortOn("order",Array.NUMERIC);
            switch(int(tagKey))
            {
               case this.TAG_TYPE_INTEREST:
                  listText += "<b><font size=\'16\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_INTEREST).name + " : </font></b>\n";
                  for each(tag in sortedTags[tagKey])
                  {
                     listText += "  • " + tag.name + "\n";
                  }
                  break;
               case this.TAG_TYPE_ATMOSPHERE:
                  listText += sortedTags[this.TAG_TYPE_INTEREST] != null ? "\n" : "";
                  listText += "<b><font size=\'16\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_ATMOSPHERE).name + " : </font></b>\n";
                  for each(tag in sortedTags[tagKey])
                  {
                     listText += "  • " + tag.name + "\n";
                  }
                  break;
               case this.TAG_TYPE_PLAY_TIME:
                  listText += sortedTags[this.TAG_TYPE_ATMOSPHERE] != null ? "\n" : "";
                  listText += "<b><font size=\'16\'>" + this.dataApi.getGuildTagsTypeById(this.TAG_TYPE_PLAY_TIME).name + " : </font></b>\n";
                  for each(tag in sortedTags[tagKey])
                  {
                     listText += "  • " + tag.name + "\n";
                  }
                  break;
            }
         }
         return listText;
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
      
      private function prepareGuildsRequest() : void
      {
         this._guildsTimeoutHandle = 0;
         var index:Number = Math.max(0,this.gd_guilds.firstItemDisplayedIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 2);
         var count:Number = this.MAX_GUILD_COUNT_PER_REQUEST;
         this._isScrolling = true;
         this._lastRealIndex = this.gd_guilds.firstItemDisplayedIndex;
         this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,index,count));
      }
      
      private function activePlaceholder(components:*, active:Boolean) : void
      {
         components.ctr_emblemPlaceholder.visible = active;
         components.ctr_nameGuildPlaceholder.visible = active;
         components.ctr_guildDescriptionPlaceholder.visible = active;
         components.ctr_guildActivityPlaceholder.visible = active;
         components.ctr_interestPlaceholder.visible = active;
         components.ctr_guildLvlPlaceholder.visible = active;
         components.ctr_guildMembersPlaceholder.visible = active;
         components.ctr_guildActivityPlaceholder.visible = active;
      }
      
      private function checkFilterInput(target:Input) : void
      {
         switch(target)
         {
            case this.inp_minGuildLevel:
               this._currentMinGuildLevel = Math.max(1,this._currentMinGuildLevel);
               if(this._currentMinGuildLevel > this._currentMaxGuildLevel)
               {
                  this._currentMinGuildLevel = this._currentMaxGuildLevel;
               }
               this.inp_minGuildLevel.text = this._currentMinGuildLevel.toString();
               this._currentFilters.minLevelFilter = this._currentMinGuildLevel;
               break;
            case this.inp_maxGuildLevel:
               this._currentMaxGuildLevel = Math.min(200,this._currentMaxGuildLevel);
               if(this._currentMaxGuildLevel < this._currentMinGuildLevel)
               {
                  this._currentMaxGuildLevel = this._currentMinGuildLevel;
               }
               this.inp_maxGuildLevel.text = this._currentMaxGuildLevel.toString();
               this._currentFilters.maxLevelFilter = this._currentMaxGuildLevel;
               break;
            case this.inp_minDesiredLevel:
               this._currentMinDesiredLevel = Math.max(1,this._currentMinDesiredLevel);
               if(this._currentMinDesiredLevel > this._currentMaxDesiredLevel)
               {
                  this._currentMinDesiredLevel = this._currentMaxDesiredLevel;
               }
               this.inp_minDesiredLevel.text = this._currentMinDesiredLevel.toString();
               this._currentFilters.minPlayerLevelFilter = this._currentMinDesiredLevel;
               break;
            case this.inp_maxDesiredLevel:
               this._currentMaxDesiredLevel = Math.min(200,this._currentMaxDesiredLevel);
               if(this._currentMaxDesiredLevel < this._currentMinDesiredLevel)
               {
                  this._currentMaxDesiredLevel = this._currentMinDesiredLevel;
               }
               this.inp_maxDesiredLevel.text = this._currentMaxDesiredLevel.toString();
               this._currentFilters.maxPlayerLevelFilter = this._currentMaxDesiredLevel;
               break;
            case this.inp_minAchievement:
               this._currentMinAchievement = Math.max(0,this._currentMinAchievement);
               if(this._currentMinAchievement > this._currentMaxAchievement)
               {
                  this._currentMinAchievement = this._currentMaxAchievement;
               }
               this.inp_minAchievement.text = this._currentMinAchievement.toString();
               this._currentFilters.minSuccessFilter = this._currentMinAchievement;
               break;
            case this.inp_maxAchievement:
               this._currentMaxAchievement = Math.min(this._totalSuccessPoints,this._currentMaxAchievement);
               if(this._currentMaxAchievement < this._currentMinAchievement)
               {
                  this._currentMaxAchievement = this._currentMinAchievement;
               }
               this.inp_maxAchievement.text = this._currentMaxAchievement.toString();
               this._currentFilters.maxSuccessFilter = this._currentMaxAchievement;
         }
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         if(uiName == this.uiApi.me().name)
         {
            this.lbl_howToCreateGuild.text = this.uiApi.getText("ui.guild.howToCreateGuild");
            this.initFilters();
            this.displayCategories();
            this.sysApi.sendAction(GuildGetPlayerApplicationAction.create());
            this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,0,this.MAX_GUILD_COUNT_PER_REQUEST));
         }
      }
      
      private function onUiUnloaded(uiName:String) : void
      {
         if(uiName == "guildApply" && this._updateApplication)
         {
            this.sysApi.sendAction(GuildGetPlayerApplicationAction.create());
            this._updateApplication = false;
         }
      }
      
      private function onGuildList(guilds:Vector.<GuildWrapper>, index:uint, count:uint, nbTotalGuild:uint) : void
      {
         if(nbTotalGuild > this._nbTotalGuild)
         {
            this._nbTotalGuild = nbTotalGuild;
         }
         if(!this._isScrolling)
         {
            this.gd_guilds.dataProvider = new Vector.<GuildWrapper>(nbTotalGuild);
         }
         else
         {
            this._isScrolling = false;
         }
         for(var i:uint = index; i < index + count; i++)
         {
            if(this.gd_guilds.dataProvider[i] == null || this.gd_guilds.dataProvider[i].guildRecruitmentInfo.lastEditDate != guilds[i - index].guildRecruitmentInfo.lastEditDate)
            {
               this.gd_guilds.dataProvider[i] = guilds[i - index];
            }
         }
         this.gd_guilds.verticalScrollValue = this._lastRealIndex;
         this.gd_guilds.updateItems();
         this.gd_guilds.visible = this.gd_guilds.dataProvider.length != 0;
         this.lbl_noResult.visible = this.gd_guilds.dataProvider.length == 0;
         this.lbl_guildCount.text = StringUtils.kamasToString(nbTotalGuild,"") + " / " + StringUtils.kamasToString(this._nbTotalGuild,"") + " " + this.uiApi.getText("ui.social.guilds");
         if(!this._isScrollListener)
         {
            if(this.gd_guilds.scrollBarV)
            {
               this.gd_guilds.scrollBarV.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
               this._isScrollListener = true;
            }
         }
      }
      
      public function onGuildPlayerApplication(guildInfo:GuildInformations, application:GuildApplicationInformation) : void
      {
         this._displayApplication = false;
         if(this.ctr_application)
         {
            this.ctr_application.visible = application != null;
         }
         this._playerApplication = null;
         this._guildApplication = null;
         if(application != null)
         {
            this._playerApplication = application;
            this._guildApplication = GuildWrapper.getFromNetwork(guildInfo);
            this.lbl_guildNameApp.text = this.chatApi.getGuildLink(this._guildApplication,this._guildApplication.guildName);
            this.lbl_Application.text = this._playerApplication.applyText;
            this._displayApplication = true;
            this.displayApplication(true);
            if(this._guildApplication.backEmblem)
            {
               this.uiApi.addComponentHook(this.tx_emblemBackGuildApp,ComponentHookList.ON_TEXTURE_READY);
               this.uiApi.addComponentHook(this.tx_emblemUpGuildApp,ComponentHookList.ON_TEXTURE_READY);
               this.tx_emblemBackGuildApp.uri = this._guildApplication.backEmblem.fullSizeIconUri;
               this.tx_emblemUpGuildApp.uri = this._guildApplication.upEmblem.fullSizeIconUri;
            }
         }
         this.gd_guilds.updateItems();
      }
      
      public function onGuildPlayerApplicationDeleted(deleted:Boolean) : void
      {
         if(deleted)
         {
            this._playerApplication = null;
            this._guildApplication = null;
            this._displayApplication = false;
            if(this.ctr_application)
            {
               this.ctr_application.visible = false;
            }
            this.gd_guilds.updateItems();
         }
      }
      
      public function onGuildApplicationIsAnswered(guildInfo:GuildInformations, accepted:Boolean) : void
      {
         this._playerApplication = null;
         this._guildApplication = null;
         this._displayApplication = false;
         if(this.ctr_application)
         {
            this.ctr_application.visible = false;
         }
         this.gd_guilds.updateItems();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_filters)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO && this.gd_filters.selectedItem && this.gd_filters.selectedItem.isCat)
            {
               this.displayCategories(this.gd_filters.selectedItem);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var dataFilter:FilterGridItem = null;
         switch(target)
         {
            case this.btn_tabName:
               this._sortingParams.descending = this._sortingParams.sortType != GuildSummarySortEnum.SORT_BY_NAME ? false : !this._sortingParams.descending;
               this._sortingParams.sortType = GuildSummarySortEnum.SORT_BY_NAME;
               this._sortingParams.btnTarget = target.name;
               this._currentFilters.sortType = GuildSummarySortEnum.SORT_BY_NAME;
               this._currentFilters.sortDescending = this._sortingParams.descending;
               this.updateSortArrow(target);
               this._lastRealIndex = this.gd_guilds.firstItemDisplayedIndex;
               this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,Math.max(0,this.gd_guilds.firstItemDisplayedIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 2),this.MAX_GUILD_COUNT_PER_REQUEST));
               this.sysApi.setData(this.DATA_SORT_DIRECTORY,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               break;
            case this.btn_tabLevel:
               this._sortingParams.descending = this._sortingParams.sortType != GuildSummarySortEnum.SORT_BY_LEVEL ? false : !this._sortingParams.descending;
               this._sortingParams.sortType = GuildSummarySortEnum.SORT_BY_LEVEL;
               this._sortingParams.btnTarget = target.name;
               this._currentFilters.sortType = GuildSummarySortEnum.SORT_BY_LEVEL;
               this._currentFilters.sortDescending = this._sortingParams.descending;
               this.updateSortArrow(target);
               this._lastRealIndex = this.gd_guilds.firstItemDisplayedIndex;
               this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,Math.max(0,this.gd_guilds.firstItemDisplayedIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 2),this.MAX_GUILD_COUNT_PER_REQUEST));
               this.sysApi.setData(this.DATA_SORT_DIRECTORY,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               break;
            case this.btn_tabMembers:
               this._sortingParams.descending = this._sortingParams.sortType != GuildSummarySortEnum.SORT_BY_NB_MEMBERS ? false : !this._sortingParams.descending;
               this._sortingParams.sortType = GuildSummarySortEnum.SORT_BY_NB_MEMBERS;
               this._sortingParams.btnTarget = target.name;
               this._currentFilters.sortType = GuildSummarySortEnum.SORT_BY_NB_MEMBERS;
               this._currentFilters.sortDescending = this._sortingParams.descending;
               this.updateSortArrow(target);
               this._lastRealIndex = this.gd_guilds.firstItemDisplayedIndex;
               this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,Math.max(0,this.gd_guilds.firstItemDisplayedIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 2),this.MAX_GUILD_COUNT_PER_REQUEST));
               this.sysApi.setData(this.DATA_SORT_DIRECTORY,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               break;
            case this.btn_tabActivity:
               this._sortingParams.descending = this._sortingParams.sortType != GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY ? false : !this._sortingParams.descending;
               this._sortingParams.sortType = GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY;
               this._sortingParams.btnTarget = target.name;
               this._currentFilters.sortType = GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY;
               this._currentFilters.sortDescending = this._sortingParams.descending;
               this.updateSortArrow(target);
               this._lastRealIndex = this.gd_guilds.firstItemDisplayedIndex;
               this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,Math.max(0,this.gd_guilds.firstItemDisplayedIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 2),this.MAX_GUILD_COUNT_PER_REQUEST));
               this.sysApi.setData(this.DATA_SORT_DIRECTORY,this._sortingParams,DataStoreEnum.BIND_CHARACTER);
               break;
            case this.ctr_applicationHeader:
               this._displayApplication = !this._displayApplication;
               this.displayApplication(this._displayApplication);
               break;
            case this.btn_cancelApp:
               this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.guild.deleteApplication"),this.uiApi.getText("ui.guild.deleteApplicationConfirmation",[this.chatApi.getGuildLink(this._guildApplication)]),[this.uiApi.getText("ui.popup.delete"),this.uiApi.getText("ui.guild.keepApplication")],[this.onDeleteApplication,function():void
               {
               }],this.onDeleteApplication,function():void
               {
               });
               break;
            case this.btn_resetSearch:
               this.resetSearch();
               break;
            case this.btn_showOfflineMembers:
               this._currentFilters.hideFullFilter = this.btn_showOfflineMembers.selected;
               this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,0,this.MAX_GUILD_COUNT_PER_REQUEST));
               break;
            case this.lbl_editApp:
               if(!this.secureApi.SecureModeisActive())
               {
                  this.openApplyPopup(GuildWrapper.getGuildById(this._guildApplication.guildId),this.lbl_Application.text);
               }
               break;
            default:
               if(target.name.indexOf("btn_selectFilter") != -1)
               {
                  dataFilter = this._componentList[target.name];
                  dataFilter.selected = !dataFilter.selected;
                  switch(dataFilter.nameId)
                  {
                     case this.RECRUITMENT_NAME_ID:
                        if(dataFilter.selected)
                        {
                           if(this._currentFilters.recruitmentTypeFilter.indexOf(dataFilter.filterId) == -1)
                           {
                              this._currentFilters.recruitmentTypeFilter.push(dataFilter.filterId);
                           }
                        }
                        else if(this._currentFilters.recruitmentTypeFilter.indexOf(dataFilter.filterId) != -1)
                        {
                           this._currentFilters.recruitmentTypeFilter.splice(this._currentFilters.recruitmentTypeFilter.indexOf(dataFilter.filterId),1);
                        }
                        break;
                     case this.LANGUAGE_NAME_ID:
                        if(dataFilter.selected)
                        {
                           if(this._currentFilters.languagesFilter.indexOf(dataFilter.filterId) == -1)
                           {
                              this._currentFilters.languagesFilter.push(dataFilter.filterId);
                           }
                        }
                        else if(this._currentFilters.languagesFilter.indexOf(dataFilter.filterId) != -1)
                        {
                           this._currentFilters.languagesFilter.splice(this._currentFilters.languagesFilter.indexOf(dataFilter.filterId),1);
                        }
                        break;
                     case this.INTEREST_NAME_ID:
                     case this.ATMOSPHERE_NAME_ID:
                     case this.PLAY_TIME_NAME_ID:
                        if(dataFilter.selected)
                        {
                           if(this._currentFilters.criterionFilter.indexOf(dataFilter.filterId) == -1)
                           {
                              this._currentFilters.criterionFilter.push(dataFilter.filterId);
                           }
                        }
                        else if(this._currentFilters.criterionFilter.indexOf(dataFilter.filterId) != -1)
                        {
                           this._currentFilters.criterionFilter.splice(this._currentFilters.criterionFilter.indexOf(dataFilter.filterId),1);
                        }
                  }
                  if(this._canSendRequest)
                  {
                     this._lastRealIndex = 0;
                     this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,0,this.MAX_GUILD_COUNT_PER_REQUEST));
                  }
                  this._filterTimer.reset();
                  this._filterTimer.start();
                  this._canSendRequest = false;
                  this.gd_filters.updateItem(this.gd_filters.selectedIndex);
               }
               else if(target.name.indexOf("btn_line") != -1)
               {
                  data = this._componentList[target.name];
                  HyperlinkShowGuildManager.showGuild(data.data.guildId,data.data.guildName);
               }
               else if(target.name.indexOf("gd_flags") != -1)
               {
                  data = this._componentList[target.name];
                  HyperlinkShowGuildManager.showGuild(data.guildId,data.guildName);
               }
               else if(target.name.indexOf("btn_join") != -1)
               {
                  if(this._componentList[target.name].guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.AUTOMATIC)
                  {
                     this.openJoinPopup(this._componentList[target.name]);
                  }
                  else if(this._componentList[target.name].guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.MANUAL)
                  {
                     this.openApplyPopup(this._componentList[target.name]);
                  }
               }
         }
      }
      
      private function openJoinPopup(data:GuildWrapper) : void
      {
         this.uiApi.loadUi(UIEnum.GUILD_JOIN_POPUP,"guildJoin",{"guild":data});
      }
      
      private function openApplyPopup(data:GuildWrapper, presentation:String = null) : void
      {
         var params:Object = {"guild":data};
         params.filters = this._currentFilters;
         if(presentation != null)
         {
            params.presentation = presentation;
            this._updateApplication = true;
         }
         this.uiApi.loadUi(UIEnum.GUILD_APPLY_POPUP,"guildApply",params);
      }
      
      private function onDeleteApplication() : void
      {
         this.sysApi.sendAction(new GuildDeleteApplicationRequestAction());
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var targetName:String = null;
         var data:* = undefined;
         var flagId:uint = 0;
         var tooltipParams:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         switch(target)
         {
            case this.btn_tabActivity:
               tooltipText = this.uiApi.getText("ui.guild.lastActivity");
               break;
            case this.lbl_editApp:
               if(this.secureApi.SecureModeisActive())
               {
                  tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
               }
               this.sysApi.setMouseCursor(MouseCursor.BUTTON);
               break;
            case this.btn_cancelApp:
               if(this.secureApi.SecureModeisActive())
               {
                  tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
               }
               break;
            default:
               if(this._currentGuildRollOver)
               {
                  this.hideDetailsLabel();
               }
               targetName = target.name;
               data = this._componentList[targetName];
               if(targetName.indexOf("btn_line") != -1)
               {
                  this._currentGuildRollOver = target;
               }
               else if(targetName.indexOf("btn_join") != -1 || targetName.indexOf("lbl_guildName") != -1 || targetName.indexOf("lbl_details") != -1 || targetName.indexOf("gd_flags") != -1 || targetName.indexOf("tx_flag") != -1 || targetName.indexOf("tx_interest") != -1 || targetName.indexOf("tx_minLevel") != -1 || targetName.indexOf("tx_minAP") != -1 || targetName.indexOf("tx_emblemBackGuild") != -1 || targetName.indexOf("tx_emblemUpGuild") != -1)
               {
                  if(targetName.indexOf("tx_flag") != -1)
                  {
                     flagId = this._componentList[targetName];
                     tooltipText = this.uiApi.getText("ui.guild.language") + this.uiApi.getText("ui.common.colon") + this.dataApi.getServerLang(flagId).name;
                  }
                  else if(data && targetName.indexOf("btn_join") != -1)
                  {
                     if(target.softDisabled)
                     {
                        if(this.socialApi.hasGuild())
                        {
                           tooltipText = this.uiApi.getText("ui.guild.cantJoinAlreadyInGuild");
                        }
                        else if(this._playerApplication != null)
                        {
                           tooltipText = this.uiApi.getText("ui.guild.cantJoinPendingApplication");
                        }
                        else if((data as GuildWrapper).guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.DISABLED)
                        {
                           tooltipText = this.uiApi.getText("ui.guild.notRecruiting");
                        }
                        else if((data as GuildWrapper).guildRecruitmentInfo.isMinLevelRequired && this.playerApi.getPlayedCharacterInfo().level < (data as GuildWrapper).guildRecruitmentInfo.minLevel || (data as GuildWrapper).guildRecruitmentInfo.areMinAchievementPointsRequired && this.playerApi.getAchievementPoints() < (data as GuildWrapper).guildRecruitmentInfo.minAchievementPoints)
                        {
                           tooltipText = this.uiApi.getText("ui.guild.requirementWarning");
                        }
                        else if(this.secureApi.SecureModeisActive())
                        {
                           tooltipText = this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode");
                        }
                        else if(data.nbPendingApply >= 50)
                        {
                           tooltipText = this.uiApi.getText("ui.guild.pendingApplyFull");
                        }
                        else if(data.nbMembers >= this.socialApi.getGuildMembersMax(data.level))
                        {
                           tooltipText = this.uiApi.getText("ui.guild.notRecruiting");
                        }
                     }
                     else if((data as GuildWrapper).guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.MANUAL)
                     {
                        tooltipText = this.uiApi.getText("ui.guild.manualRecruitment");
                     }
                     else if((data as GuildWrapper).guildRecruitmentInfo.recruitmentType == GuildRecruitmentTypeEnum.AUTOMATIC)
                     {
                        tooltipText = this.uiApi.getText("ui.guild.autoRecruitment");
                     }
                  }
                  else if(data && targetName.indexOf("tx_interest") != -1)
                  {
                     tooltipText = this.processTagsText((data as GuildWrapper).guildRecruitmentInfo.selectedCriteria);
                     tooltipParams.point = LocationEnum.POINT_TOP;
                     tooltipParams.relativePoint = LocationEnum.POINT_BOTTOM;
                  }
                  else if(data && targetName.indexOf("tx_minLevel") != -1)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.minPlayerLevel",(data as GuildWrapper).guildRecruitmentInfo.minLevel);
                     if((data as GuildWrapper).guildRecruitmentInfo.isMinLevelRequired)
                     {
                        tooltipText += " (" + this.uiApi.getText("ui.common.mandatory") + ")";
                     }
                     tooltipParams.point = LocationEnum.POINT_TOP;
                     tooltipParams.relativePoint = LocationEnum.POINT_BOTTOM;
                  }
                  else if(data && targetName.indexOf("tx_minAP") != -1)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.minPlayerAP",(data as GuildWrapper).guildRecruitmentInfo.minAchievementPoints);
                     if((data as GuildWrapper).guildRecruitmentInfo.areMinAchievementPointsRequired)
                     {
                        tooltipText += " (" + this.uiApi.getText("ui.common.mandatory") + ")";
                     }
                     tooltipParams.point = LocationEnum.POINT_TOP;
                     tooltipParams.relativePoint = LocationEnum.POINT_BOTTOM;
                  }
                  if(this._currentGuildRollOver)
                  {
                     this._currentGuildRollOver.state = !!this._currentGuildRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
               }
               if(this._currentGuildRollOver)
               {
                  this.showDetailsLabel();
               }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",tooltipParams.point,tooltipParams.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         if(this._currentGuildRollOver && (this._currentGuildRollOver.state != StatesEnum.STATE_SELECTED_CLICKED && this._currentGuildRollOver.state != StatesEnum.STATE_SELECTED))
         {
            this._currentGuildRollOver.state = StatesEnum.STATE_NORMAL;
            this.hideDetailsLabel();
         }
         this.sysApi.setMouseCursor(MouseCursor.AUTO);
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_search:
               if(this.inp_search.text.length && this.inp_search.text != this._searchCriteria && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._searchCriteria = this.inp_search.text;
                  this.btn_resetSearch.visible = true;
                  this._currentFilters.nameFilter = this._searchCriteria;
               }
               else if(this._searchCriteria && this.inp_search.text.length == 0)
               {
                  this.resetSearch();
               }
               break;
            case this.inp_minGuildLevel:
               if(this.inp_minGuildLevel.text.length && uint(this.inp_minGuildLevel.text) != this._currentMinGuildLevel)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMinGuildLevel = uint(this.inp_minGuildLevel.text);
                  this.checkFilterInput(this.inp_minGuildLevel);
               }
               break;
            case this.inp_maxGuildLevel:
               if(this.inp_maxGuildLevel.text.length && uint(this.inp_maxGuildLevel.text) != this._currentMaxGuildLevel)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMaxGuildLevel = uint(this.inp_maxGuildLevel.text);
                  this.checkFilterInput(this.inp_maxGuildLevel);
               }
               break;
            case this.inp_minDesiredLevel:
               if(this.inp_minDesiredLevel.text.length && uint(this.inp_minDesiredLevel.text) != this._currentMinDesiredLevel)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMinDesiredLevel = uint(this.inp_minDesiredLevel.text);
                  this.checkFilterInput(this.inp_minDesiredLevel);
               }
               break;
            case this.inp_maxDesiredLevel:
               if(this.inp_maxDesiredLevel.text.length && uint(this.inp_maxDesiredLevel.text) != this._currentMaxDesiredLevel)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMaxDesiredLevel = uint(this.inp_maxDesiredLevel.text);
                  this.checkFilterInput(this.inp_maxDesiredLevel);
               }
               break;
            case this.inp_minAchievement:
               if(this.inp_minAchievement.text.length && uint(this.inp_minAchievement.text) != this._currentMinAchievement)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMinAchievement = uint(this.inp_minAchievement.text);
                  this.checkFilterInput(this.inp_minAchievement);
               }
               break;
            case this.inp_maxAchievement:
               if(this.inp_maxAchievement.text.length && uint(this.inp_maxAchievement.text) != this._currentMaxAchievement)
               {
                  this._inputTimer.reset();
                  this._inputTimer.start();
                  this._currentMaxAchievement = uint(this.inp_maxAchievement.text);
                  this.checkFilterInput(this.inp_maxAchievement);
               }
         }
      }
      
      private function onScroll(event:Event) : void
      {
         if(event.target !== this.gd_guilds.scrollBarV)
         {
            return;
         }
         var currentScrollIndex:uint = this.gd_guilds.firstItemDisplayedIndex;
         if(currentScrollIndex <= Math.max(0,this._lastRealIndex - this.MAX_GUILD_COUNT_PER_REQUEST / 3) || currentScrollIndex >= Math.min(this.gd_guilds.dataProvider.length - 1,this._lastRealIndex + this.MAX_GUILD_COUNT_PER_REQUEST / 3))
         {
            if(this._guildsTimeoutHandle > 0)
            {
               clearTimeout(this._guildsTimeoutHandle);
               this._guildsTimeoutHandle = 0;
            }
            this._guildsTimeoutHandle = setTimeout(this.prepareGuildsRequest,300);
         }
      }
      
      public function sendRequest(event:TimerEvent) : void
      {
         this._inputTimer.reset();
         this._filterTimer.reset();
         this._canSendRequest = true;
         this._lastRealIndex = 0;
         this.sysApi.sendAction(GuildSummaryRequestAction.create(this._currentFilters,0,this.MAX_GUILD_COUNT_PER_REQUEST));
      }
   }
}

class FilterGridItem
{
    
   
   public var filterId:int = 0;
   
   public var nameId:String;
   
   public var text:String;
   
   public var gfxId:String;
   
   public var catId:int;
   
   public var selected:Boolean = false;
   
   public var isCat:Boolean = false;
   
   function FilterGridItem(pFilterId:int, pNameId:String, pText:String, pGfxId:String, pSelected:Boolean, pCatId:int)
   {
      super();
      this.filterId = pFilterId;
      this.nameId = pNameId;
      this.text = pText;
      this.gfxId = pGfxId;
      this.selected = pSelected;
      this.catId = pCatId;
      this.isCat = false;
   }
}
