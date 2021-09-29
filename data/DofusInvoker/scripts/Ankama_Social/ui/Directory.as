package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.BasicWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildListRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class Directory
   {
      
      private static const TAB_GUILD:uint = 0;
      
      private static const TAB_ALLIANCE:uint = 1;
      
      private static const SEARCH_TAG:uint = 0;
      
      private static const SEARCH_NAME:uint = 1;
      
      private static const SEARCH_MEMBER_NAME:uint = 2;
       
      
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
      
      private var _currentTab:int = -1;
      
      private var _currentTabName:String;
      
      private var _currentGuildDataProvider;
      
      private var _currentAllianceDataProvider;
      
      private var _guildSortField:String;
      
      private var _guildSortOrderAscending:Boolean = true;
      
      private var _allianceSortField:String;
      
      private var _allianceSortOrderAscending:Boolean = true;
      
      private var _moreBtnList:Dictionary;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _exactMemberSearchTimer:BenchmarkTimer;
      
      private var _searchText:String = "";
      
      public var btn_guilds:ButtonContainer;
      
      public var btn_alliances:ButtonContainer;
      
      public var btn_search:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabGuildName:ButtonContainer;
      
      public var btn_tabGuildLevel:ButtonContainer;
      
      public var btn_tabGuildMembers:ButtonContainer;
      
      public var btn_tabAllianceAbr:ButtonContainer;
      
      public var btn_tabAllianceName:ButtonContainer;
      
      public var btn_tabAllianceSubarea:ButtonContainer;
      
      public var btn_tabAllianceNbMembers:ButtonContainer;
      
      public var btn_tabAllianceGuildNumber:ButtonContainer;
      
      public var ctr_guild:GraphicContainer;
      
      public var inp_searchGuild:Input;
      
      public var btn_closeSearchGuild:ButtonContainer;
      
      public var gd_guilds:Grid;
      
      public var ctr_alliance:GraphicContainer;
      
      public var inp_searchAlliance:Input;
      
      public var btn_closeSearchAlliance:ButtonContainer;
      
      public var gd_alliances:Grid;
      
      public var cb_allianceSearchType:ComboBox;
      
      public var cb_guildSearchType:ComboBox;
      
      public function Directory()
      {
         this._moreBtnList = new Dictionary();
         this._sortFieldAssoc = new Dictionary(true);
         this._exactMemberSearchTimer = new BenchmarkTimer(1000,1,"Directory._exactMemberSearchTimer");
         super();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(args:Object) : void
      {
         this.sysApi.addHook(SocialHookList.AllianceList,this.onAllianceList);
         this.sysApi.addHook(SocialHookList.GuildList,this.onGuildList);
         this.sysApi.addHook(ChatHookList.SilentWhoIs,this.onWhoisInfo);
         this.uiApi.addComponentHook(this.btn_guilds,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_alliances,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_searchGuild,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_searchAlliance,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_searchGuild,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_searchAlliance,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_allianceSearchType,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_guildSearchType,ComponentHookList.ON_SELECT_ITEM);
         this._sortFieldAssoc[this.btn_tabGuildName] = "guildName";
         this._sortFieldAssoc[this.btn_tabGuildLevel] = "level";
         this._sortFieldAssoc[this.btn_tabGuildMembers] = "nbMembers";
         this._sortFieldAssoc[this.btn_tabAllianceAbr] = "allianceTag";
         this._sortFieldAssoc[this.btn_tabAllianceName] = "allianceName";
         this._sortFieldAssoc[this.btn_tabAllianceSubarea] = "nbSubareas";
         this._sortFieldAssoc[this.btn_tabAllianceNbMembers] = "nbMembers";
         this._sortFieldAssoc[this.btn_tabAllianceGuildNumber] = "nbGuilds";
         if(args[0] == TAB_GUILD)
         {
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_guilds,this.uiApi.me());
            this.btn_guilds.selected = true;
         }
         else
         {
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_alliances,this.uiApi.me());
            this.btn_alliances.selected = true;
         }
         this._searchText = this.uiApi.getText("ui.common.search.input");
         this.inp_searchAlliance.text = this._searchText;
         this.inp_searchGuild.text = this._searchText;
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
         this.cb_guildSearchType.dataProvider = [{
            "label":this.uiApi.getText("ui.common.name"),
            "type":SEARCH_NAME
         },{
            "label":this.uiApi.getText("ui.alliance.memberName"),
            "type":SEARCH_MEMBER_NAME
         }];
         this.cb_guildSearchType.selectedIndex = 0;
         this.displaySelectedTab(args[0]);
      }
      
      public function unload() : void
      {
         this._moreBtnList = null;
         this._currentGuildDataProvider = null;
         this._currentAllianceDataProvider = null;
         this._exactMemberSearchTimer.removeEventListener(TimerEvent.TIMER,this.onRefreshExactMemberNameFilter);
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
            components.lbl_allianceTag.text = "";
            components.lbl_allianceName.text = "";
            components.lbl_allianceAreas.text = "";
            components.lbl_allianceGuilds.text = "";
            components.lbl_allianceMembers.text = "";
            components.tx_emblemUpAlliance.uri = null;
            components.tx_emblemBackAlliance.uri = null;
         }
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         if(this._currentTab == tab)
         {
            return;
         }
         this._currentTab = tab;
         this.uiApi.getUi("socialBase").uiClass.setSubTab(this._currentTab);
         switch(this._currentTab)
         {
            case TAB_GUILD:
               this.ctr_guild.visible = true;
               this.ctr_alliance.visible = false;
               this.currentTabName = this.btn_guilds.name;
               if(this.gd_guilds.dataProvider == null || this.gd_guilds.dataProvider.length == 0)
               {
                  this.sysApi.sendAction(new GuildListRequestAction([]));
               }
               break;
            case TAB_ALLIANCE:
               this.ctr_guild.visible = false;
               this.ctr_alliance.visible = true;
               this.currentTabName = this.btn_alliances.name;
               if(this.gd_alliances.dataProvider == null || this.gd_alliances.dataProvider.length == 0)
               {
                  this.sysApi.sendAction(new AllianceListRequestAction([]));
               }
         }
      }
      
      private function getSearchTextAlliance() : String
      {
         if(this.inp_searchAlliance.text != this._searchText)
         {
            return this.inp_searchAlliance.text;
         }
         return "";
      }
      
      private function getSearchTextGuild() : String
      {
         if(this.inp_searchGuild.text != this._searchText)
         {
            return this.inp_searchGuild.text;
         }
         return "";
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_searchGuild:
               this.updateGuildFilter();
               break;
            case this.inp_searchAlliance:
               this.updateAllianceFilter();
         }
      }
      
      private function updateGuildFilter() : void
      {
         var searchText:String = this.getSearchTextGuild();
         if(searchText == "")
         {
            this.gd_guilds.dataProvider = this.utilApi["sort"](this._currentGuildDataProvider,"nbMembers",false,true);
            return;
         }
         switch(this.cb_guildSearchType.selectedItem.type)
         {
            case SEARCH_NAME:
               this.gd_guilds.dataProvider = this.utilApi["filter"](this._currentGuildDataProvider,searchText,"guildName");
               break;
            case SEARCH_TAG:
               this.gd_guilds.dataProvider = this.utilApi["filter"](this._currentGuildDataProvider,searchText,"allianceTag");
               break;
            case SEARCH_MEMBER_NAME:
               this.restartSearchTimer();
         }
      }
      
      private function updateAllianceFilter() : void
      {
         var searchText:String = this.getSearchTextAlliance();
         if(searchText == "")
         {
            this.gd_alliances.dataProvider = this.utilApi["sort"](this._currentAllianceDataProvider,"nbSubareas",false,true);
            return;
         }
         switch(this.cb_allianceSearchType.selectedItem.type)
         {
            case SEARCH_NAME:
               this.gd_alliances.dataProvider = this.utilApi["filter"](this._currentAllianceDataProvider,searchText,"allianceName");
               break;
            case SEARCH_TAG:
               this.gd_alliances.dataProvider = this.utilApi["filter"](this._currentAllianceDataProvider,searchText,"allianceTag");
               break;
            case SEARCH_MEMBER_NAME:
               this.restartSearchTimer();
         }
      }
      
      private function restartSearchTimer() : void
      {
         this._exactMemberSearchTimer.reset();
         this._exactMemberSearchTimer.addEventListener(TimerEvent.TIMER,this.onRefreshExactMemberNameFilter);
         this._exactMemberSearchTimer.start();
      }
      
      private function onRefreshExactMemberNameFilter(e:Event) : void
      {
         this._exactMemberSearchTimer.removeEventListener(TimerEvent.TIMER,this.onRefreshExactMemberNameFilter);
         if(this._currentTab == TAB_GUILD && this.getSearchTextGuild().length > 2)
         {
            this.sysApi.sendAction(new BasicWhoIsRequestAction([this.getSearchTextGuild(),false]));
         }
         if(this._currentTab == TAB_ALLIANCE && this.getSearchTextAlliance().length > 2)
         {
            this.sysApi.sendAction(new BasicWhoIsRequestAction([this.getSearchTextAlliance(),false]));
         }
      }
      
      private function onGuildList(list:Object, isUpdate:Boolean, error:Boolean) : void
      {
         this._currentGuildDataProvider = list;
         this.gd_guilds.dataProvider = this.utilApi["sort"](this._currentGuildDataProvider,"nbMembers",false,true);
      }
      
      private function onAllianceList(list:Object, isUpdate:Boolean, error:Boolean) : void
      {
         this._currentAllianceDataProvider = list;
         this.gd_alliances.dataProvider = this.utilApi["sort"](this._currentAllianceDataProvider,"nbSubareas",false,true);
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         this.hintsApi.showSubHints(this.currentTabName);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.inp_searchGuild:
               if(this.inp_searchGuild.text == this._searchText)
               {
                  this.inp_searchGuild.text = "";
               }
               break;
            case this.inp_searchAlliance:
               if(this.inp_searchAlliance.text == this._searchText)
               {
                  this.inp_searchAlliance.text = "";
               }
               break;
            case this.btn_closeSearchGuild:
               this.inp_searchGuild.text = this._searchText;
               this.updateGuildFilter();
               break;
            case this.btn_closeSearchAlliance:
               this.inp_searchAlliance.text = this._searchText;
               this.updateAllianceFilter();
               break;
            case this.btn_guilds:
               if(this._currentTab != TAB_GUILD)
               {
                  this.displaySelectedTab(TAB_GUILD);
               }
               break;
            case this.btn_alliances:
               if(this._currentTab != TAB_ALLIANCE)
               {
                  this.displaySelectedTab(TAB_ALLIANCE);
               }
               break;
            case this.btn_tabGuildLevel:
            case this.btn_tabGuildMembers:
            case this.btn_tabAllianceGuildNumber:
            case this.btn_tabAllianceNbMembers:
            case this.btn_tabAllianceSubarea:
               if(this._currentTab == TAB_GUILD)
               {
                  this._guildSortOrderAscending = !this._guildSortOrderAscending;
                  this.gd_guilds.dataProvider = this.utilApi["sort"](this.gd_guilds.dataProvider,this._sortFieldAssoc[target],this._guildSortOrderAscending,true);
               }
               else
               {
                  this._allianceSortOrderAscending = !this._allianceSortOrderAscending;
                  this.gd_alliances.dataProvider = this.utilApi["sort"](this.gd_alliances.dataProvider,this._sortFieldAssoc[target],this._allianceSortOrderAscending,true);
               }
               break;
            case this.btn_tabGuildName:
            case this.btn_tabAllianceAbr:
            case this.btn_tabAllianceName:
               if(this._currentTab == TAB_GUILD)
               {
                  this._guildSortOrderAscending = !this._guildSortOrderAscending;
                  this.gd_guilds.dataProvider = this.utilApi["sort"](this.gd_guilds.dataProvider,this._sortFieldAssoc[target],this._guildSortOrderAscending,false);
               }
               else
               {
                  this._allianceSortOrderAscending = !this._allianceSortOrderAscending;
                  this.gd_alliances.dataProvider = this.utilApi["sort"](this.gd_alliances.dataProvider,this._sortFieldAssoc[target],this._allianceSortOrderAscending,false);
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(this._currentTab == TAB_GUILD)
         {
            this.updateGuildFilter();
         }
         else if(this._currentTab == TAB_ALLIANCE)
         {
            this.updateAllianceFilter();
         }
      }
      
      private function onWhoisInfo(accountId:uint, accountNickname:String, accountTag:String, areaId:uint, playerId:Number, playerName:String, position:uint, socialGroups:Object) : void
      {
         var asgi:AbstractSocialGroupInfos = null;
         if(socialGroups && socialGroups.length)
         {
            for each(asgi in socialGroups)
            {
               if(asgi is BasicGuildInformations && this._currentTab == TAB_GUILD)
               {
                  this.gd_guilds.dataProvider = this.utilApi["filter"](this._currentGuildDataProvider,BasicGuildInformations(asgi).guildId,"guildId");
               }
               else if(asgi is BasicAllianceInformations && this._currentTab == TAB_ALLIANCE)
               {
                  this.gd_alliances.dataProvider = this.utilApi["filter"](this._currentAllianceDataProvider,BasicAllianceInformations(asgi).allianceId,"allianceId");
               }
            }
         }
      }
   }
}
