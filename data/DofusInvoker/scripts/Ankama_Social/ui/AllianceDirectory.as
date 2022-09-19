package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceSummaryRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.AllianceSummarySortEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class AllianceDirectory
   {
      
      private static const SEARCH_TAG:uint = 0;
      
      private static const SEARCH_NAME:uint = 1;
      
      private static const SEARCH_MEMBER_NAME:uint = 2;
       
      
      private const MAX_ALLIANCE_COUNT_PER_REQUEST:uint = 40;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      private var _currentAllianceDataProvider;
      
      private var _allianceSortField:String;
      
      private var _allianceSortOrderAscending:Boolean = true;
      
      private var _moreBtnList:Dictionary;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _searchTimer:BenchmarkTimer;
      
      private var _inputTimer:BenchmarkTimer;
      
      private var _isScrolling:Boolean = false;
      
      private var _isScrollListener:Boolean = false;
      
      private var _nbTotalAlliance:uint;
      
      private var _lastRealIndex:uint = 0;
      
      private var _allianceTimeoutHandle:uint = 0;
      
      private var _canSendRequest:Boolean = true;
      
      private var _searchAndSortParams:AllianceSearchAndSortParams;
      
      public var btn_search:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabAllianceAbr:ButtonContainer;
      
      public var btn_tabAllianceName:ButtonContainer;
      
      public var btn_tabAllianceSubarea:ButtonContainer;
      
      public var btn_tabAllianceNbMembers:ButtonContainer;
      
      public var btn_tabAllianceGuildNumber:ButtonContainer;
      
      public var ctr_alliance:GraphicContainer;
      
      public var inp_searchAlliance:Input;
      
      public var btn_closeSearchAlliance:ButtonContainer;
      
      public var gd_alliances:Grid;
      
      public var cb_allianceSearchType:ComboBox;
      
      public var lbl_allianceCount:Label;
      
      public function AllianceDirectory()
      {
         this._moreBtnList = new Dictionary();
         this._sortFieldAssoc = new Dictionary(true);
         this._searchTimer = new BenchmarkTimer(1000,1,"AllianceDirectory._searchTimer");
         this._inputTimer = new BenchmarkTimer(400,0,"AllianceDirectory._inputTimer");
         super();
      }
      
      public function main(args:Object) : void
      {
         this.sysApi.addHook(HookList.AlliancesReceived,this.onAllianceList);
         this.uiApi.addComponentHook(this.inp_searchAlliance,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_searchAlliance,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_allianceSearchType,ComponentHookList.ON_SELECT_ITEM);
         this._sortFieldAssoc[this.btn_tabAllianceAbr] = "allianceTag";
         this._sortFieldAssoc[this.btn_tabAllianceName] = "allianceName";
         this._sortFieldAssoc[this.btn_tabAllianceSubarea] = "nbSubareas";
         this._sortFieldAssoc[this.btn_tabAllianceNbMembers] = "nbMembers";
         this._sortFieldAssoc[this.btn_tabAllianceGuildNumber] = "nbGuilds";
         this.inp_searchAlliance.placeholderText = this.uiApi.getText("ui.common.search.input");
         this.cb_allianceSearchType.dataProvider = [{
            "label":this.uiApi.getText("ui.common.name"),
            "type":SEARCH_NAME
         },{
            "label":this.uiApi.getText("ui.alliance.tag"),
            "type":SEARCH_TAG
         },{
            "label":this.uiApi.getText("ui.alliance.memberName"),
            "type":SEARCH_MEMBER_NAME
         }];
         this.cb_allianceSearchType.selectedIndex = 0;
         this._searchAndSortParams = new AllianceSearchAndSortParams();
         this._inputTimer.addEventListener(TimerEvent.TIMER,this.sendRequest);
      }
      
      public function unload() : void
      {
         this._moreBtnList = null;
         this._currentAllianceDataProvider = null;
         this._searchTimer.removeEventListener(TimerEvent.TIMER,this.onRefreshSearchFilter);
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function updateGuildLine(data:GuildWrapper, components:*, selected:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         if(data)
         {
            components.lbl_guildLvl.text = data.level.toString();
            components.lbl_guildName.text = this.chatApi.getGuildLink(data,data.guildName);
            components.lbl_guildMembers.text = data.nbMembers.toString();
            if(data.backEmblem)
            {
               components.tx_emblemBackGuild.uri = data.backEmblem.iconUri;
               components.tx_emblemUpGuild.uri = data.upEmblem.iconUri;
               this.utilApi.changeColor(components.tx_emblemBackGuild,data.backEmblem.color,1);
               icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0,true);
               }
            }
         }
         else
         {
            components.lbl_guildLvl.text = "";
            components.lbl_guildName.text = "";
            components.lbl_guildMembers.text = "";
            components.tx_emblemBackGuild.uri = null;
            components.tx_emblemUpGuild.uri = null;
         }
      }
      
      public function updateAllianceLine(data:AllianceWrapper, components:*, selected:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         if(data)
         {
            this.activePlaceholder(components,false);
            components.lbl_allianceTag.text = this.chatApi.getAllianceLink(data,data.allianceTag);
            components.lbl_allianceName.text = this.chatApi.getAllianceLink(data,data.allianceName);
            components.lbl_allianceAreas.text = data.nbSubareas;
            components.lbl_allianceGuilds.text = data.nbGuilds;
            components.lbl_allianceMembers.text = data.nbMembers;
            if(data.backEmblem)
            {
               components.tx_emblemBackAlliance.uri = data.backEmblem.iconUri;
               components.tx_emblemUpAlliance.uri = data.upEmblem.iconUri;
               this.utilApi.changeColor(components.tx_emblemBackAlliance,data.backEmblem.color,1);
               icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
               if(icon && icon.colorizable)
               {
                  this.utilApi.changeColor(components.tx_emblemUpAlliance,data.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(components.tx_emblemUpAlliance,data.upEmblem.color,0,true);
               }
            }
            else
            {
               components.tx_emblemBackAlliance.uri = null;
               components.tx_emblemUpAlliance.uri = null;
            }
         }
         else
         {
            if(this.socialApi.hasAlliance())
            {
               this.activePlaceholder(components,this.gd_alliances.dataProvider.length > 8);
            }
            else
            {
               this.activePlaceholder(components,this.gd_alliances.dataProvider.length > 11);
            }
            components.lbl_allianceTag.text = "";
            components.lbl_allianceName.text = "";
            components.lbl_allianceAreas.text = "";
            components.lbl_allianceGuilds.text = "";
            components.lbl_allianceMembers.text = "";
            components.tx_emblemUpAlliance.uri = null;
            components.tx_emblemBackAlliance.uri = null;
         }
      }
      
      private function getSearchTextAlliance() : String
      {
         if(this.inp_searchAlliance.text != this.inp_searchAlliance.placeholderText)
         {
            return this.inp_searchAlliance.text;
         }
         return "";
      }
      
      private function prepareAlliancesRequest() : void
      {
         this._allianceTimeoutHandle = 0;
         var index:uint = Math.max(0,this.gd_alliances.firstItemDisplayedIndex - this.MAX_ALLIANCE_COUNT_PER_REQUEST / 2);
         this._isScrolling = true;
         this._lastRealIndex = this.gd_alliances.firstItemDisplayedIndex;
         this.getAlliances(index,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
      }
      
      private function resetSearch() : void
      {
         this._searchAndSortParams.nameFilter = "";
         this.btn_closeSearchAlliance.visible = false;
         this._lastRealIndex = 0;
         this._searchTimer.reset();
         this.getAlliances(0,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
      }
      
      public function sendRequest(event:TimerEvent) : void
      {
         this._inputTimer.reset();
         this._canSendRequest = true;
         this._lastRealIndex = 0;
         this.getAlliances(0,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
      }
      
      private function activePlaceholder(components:*, active:Boolean) : void
      {
         components.ctr_emblemPlaceholder.visible = active;
         components.ctr_allianceNamePlaceholder.visible = active;
         components.ctr_allianceTagPlaceholder.visible = active;
         components.ctr_allianceGuildsPlaceholder.visible = active;
         components.ctr_allianceMembersPlaceholder.visible = active;
         components.ctr_allianceAreasPlaceholder.visible = active;
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_searchAlliance:
               if(this.inp_searchAlliance.text.length && this.inp_searchAlliance.text != this.inp_searchAlliance.placeholderText)
               {
                  this.updateAllianceFilter();
                  break;
               }
               if(this.inp_searchAlliance.text.length == 0 || this.inp_searchAlliance.text == this.inp_searchAlliance.placeholderText)
               {
                  this.resetSearch();
                  break;
               }
               break;
         }
      }
      
      private function updateAllianceFilter() : void
      {
         var searchText:String = this.getSearchTextAlliance();
         if(searchText == "")
         {
            this._searchAndSortParams.sortType = AllianceSummarySortEnum.SORT_BY_NB_TERRITORIES;
            this._searchAndSortParams.sortDescending = true;
            this.getAlliances(0,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
            return;
         }
         switch(this.cb_allianceSearchType.selectedItem.type)
         {
            case SEARCH_NAME:
               this.restartSearchTimer();
               break;
            case SEARCH_TAG:
               this.restartSearchTimer();
               break;
            case SEARCH_MEMBER_NAME:
               this.restartSearchTimer();
         }
      }
      
      private function restartSearchTimer() : void
      {
         this._searchTimer.reset();
         this._searchTimer.addEventListener(TimerEvent.TIMER,this.onRefreshSearchFilter);
         this._searchTimer.start();
      }
      
      private function onRefreshSearchFilter(e:Event) : void
      {
         this._searchTimer.removeEventListener(TimerEvent.TIMER,this.onRefreshSearchFilter);
         if(this.inp_searchAlliance.text != this.inp_searchAlliance.placeholderText && this.inp_searchAlliance.text.length > 2)
         {
            this._searchAndSortParams.playerNameFilter = "";
            this._searchAndSortParams.nameFilter = "";
            this._searchAndSortParams.tagFilter = "";
            switch(this.cb_allianceSearchType.selectedItem.type)
            {
               case SEARCH_NAME:
                  this._searchAndSortParams.nameFilter = this.inp_searchAlliance.text;
                  break;
               case SEARCH_TAG:
                  this._searchAndSortParams.tagFilter = this.inp_searchAlliance.text;
                  break;
               case SEARCH_MEMBER_NAME:
                  this._searchAndSortParams.playerNameFilter = this.inp_searchAlliance.text;
            }
            this.getAlliances(0,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
         }
      }
      
      private function onAllianceList(alliances:Vector.<AllianceWrapper>, index:uint, count:uint, nbTotalAlliance:uint) : void
      {
         if(nbTotalAlliance > this._nbTotalAlliance)
         {
            this._nbTotalAlliance = nbTotalAlliance;
         }
         if(!this._isScrolling)
         {
            this.gd_alliances.dataProvider = new Vector.<AllianceWrapper>(nbTotalAlliance);
         }
         else
         {
            this._isScrolling = false;
         }
         this.lbl_allianceCount.text = this.uiApi.getText("ui.alliance.allianceCount",nbTotalAlliance);
         var tmpDataProvider:Vector.<AllianceWrapper> = new Vector.<AllianceWrapper>(nbTotalAlliance);
         for(var i:uint = index; i < index + count; i++)
         {
            if(tmpDataProvider[i] == null)
            {
               tmpDataProvider[i] = alliances[i - index];
            }
         }
         this.gd_alliances.dataProvider = tmpDataProvider;
         this.gd_alliances.verticalScrollValue = this._lastRealIndex;
         this.gd_alliances.updateItems();
         this.gd_alliances.visible = this.gd_alliances.dataProvider.length != 0;
         if(!this._isScrollListener)
         {
            if(this.gd_alliances.scrollBarV)
            {
               this.gd_alliances.scrollBarV.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
               this._isScrollListener = true;
            }
         }
      }
      
      private function onScroll(event:Event) : void
      {
         if(event.target !== this.gd_alliances.scrollBarV)
         {
            return;
         }
         var currentScrollIndex:uint = this.gd_alliances.firstItemDisplayedIndex;
         if(currentScrollIndex <= Math.max(0,this._lastRealIndex - this.MAX_ALLIANCE_COUNT_PER_REQUEST / 3) || currentScrollIndex >= Math.min(this.gd_alliances.dataProvider.length - 1,this._lastRealIndex + this.MAX_ALLIANCE_COUNT_PER_REQUEST / 3))
         {
            if(this._allianceTimeoutHandle > 0)
            {
               clearTimeout(this._allianceTimeoutHandle);
               this._allianceTimeoutHandle = 0;
            }
            this._allianceTimeoutHandle = setTimeout(this.prepareAlliancesRequest,300);
         }
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         if(uiName == this.uiApi.me().name)
         {
            this.getAlliances(0,this.MAX_ALLIANCE_COUNT_PER_REQUEST);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var sortType:uint = 0;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_closeSearchAlliance:
               this.updateAllianceFilter();
               break;
            case this.btn_tabAllianceGuildNumber:
            case this.btn_tabAllianceNbMembers:
            case this.btn_tabAllianceSubarea:
            case this.btn_tabAllianceAbr:
            case this.btn_tabAllianceName:
               if(target == this.btn_tabAllianceGuildNumber)
               {
                  sortType = AllianceSummarySortEnum.SORT_BY_NB_GUILD;
               }
               else if(target == this.btn_tabAllianceNbMembers)
               {
                  sortType = AllianceSummarySortEnum.SORT_BY_ALLIANCE_NB_MEMBERS;
               }
               else if(target == this.btn_tabAllianceSubarea)
               {
                  sortType = AllianceSummarySortEnum.SORT_BY_NB_TERRITORIES;
               }
               else if(target == this.btn_tabAllianceAbr)
               {
                  sortType = AllianceSummarySortEnum.SORT_BY_ALLIANCE_TAG;
               }
               else if(target == this.btn_tabAllianceName)
               {
                  sortType = AllianceSummarySortEnum.SORT_BY_ALLIANCE_NAME;
               }
               this._searchAndSortParams.sortDescending = this._searchAndSortParams.sortType != sortType ? false : !this._searchAndSortParams.sortDescending;
               this._searchAndSortParams.sortType = sortType;
               this._lastRealIndex = this.gd_alliances.firstItemDisplayedIndex;
               this.getAlliances(Math.max(0,this.gd_alliances.firstItemDisplayedIndex - this.MAX_ALLIANCE_COUNT_PER_REQUEST / 2),this.MAX_ALLIANCE_COUNT_PER_REQUEST);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         this.updateAllianceFilter();
      }
      
      private function getAlliances(offset:uint, count:uint) : void
      {
         this.sysApi.sendAction(AllianceSummaryRequestAction.create(offset,count,this._searchAndSortParams.nameFilter,this._searchAndSortParams.tagFilter,this._searchAndSortParams.playerNameFilter,this._searchAndSortParams.sortType,this._searchAndSortParams.sortDescending));
      }
   }
}

class AllianceSearchAndSortParams
{
    
   
   public var nameFilter:String = "";
   
   public var tagFilter:String = "";
   
   public var playerNameFilter:String = "";
   
   public var sortType:uint = 0;
   
   public var sortDescending:Boolean = false;
   
   function AllianceSearchAndSortParams()
   {
      super();
   }
}
