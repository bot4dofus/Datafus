package Ankama_Cartography.ui
{
   import Ankama_Cartography.ui.type.AreaGroup;
   import Ankama_Cartography.ui.type.AreaInfo;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.MapAreaShape;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;
   import com.ankamagames.dofus.datacenter.breach.BreachWorldMapSector;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.AnomalySubareaInformationRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.PrismListenEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AnomalySubareaInformation;
   import com.ankamagames.dofus.types.enums.HintPriorityEnum;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class CartographyUi extends CartographyBase
   {
      
      private static var _conquestInformationsIsActive:Boolean = false;
      
      private static const HINT_SEARCH_TYPE:uint = 1;
      
      private static const HINT_GROUP_SEARCH_TYPE:uint = 5;
      
      private static const SUBAREA_SEARCH_TYPE:uint = 2;
      
      private static const MONSTER_SEARCH_TYPE:uint = 3;
      
      private static const ITEM_SEARCH_TYPE:uint = 4;
      
      private static const SEARCH_AREAS:String = "searchAreas";
      
      private static const SEARCH_AREAS_FLAGS:String = "searchAreasFlags";
      
      private static const SEARCH_HINTS:String = "searchHints";
      
      private static const RESOURCES_QUANTITY_COLOR:Array = [16642234,16573085,16566143,16493940,16417127,15293534,13519461,10766949];
      
      private static const CONQUEST_FILTERS:String = "mapFiltersConquest";
      
      private static const REWARD_FILTERS:String = "mapFiltersReward";
      
      private static const SEARCH_FILTERS:String = "mapFiltersSearch";
      
      private static const SORT_BY_NAME:uint = 1;
      
      private static const SORT_BY_VULNERABILITY_DATE:uint = 2;
      
      private static const SORT_BY_PERCENT:uint = 3;
      
      private static const CTR_WORLDMAP_CAT:String = "ctr_worldmapCat";
      
      private static const CTR_WORLDMAP_SUB_CAT:String = "ctr_worldmapSubCat";
      
      private static const MAX_WORLDMAP_DISPLAYED:uint = 15;
      
      private static var _worldmapCatInfos:Array = null;
       
      
      public var conquest_content;
      
      public var reward_content;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_filter:GraphicContainer;
      
      public var ctr_info:GraphicContainer;
      
      public var ctr_breach:GraphicContainer;
      
      public var tx_bg_results:TextureBitmap;
      
      public var tx_caption_bg:TextureBitmap;
      
      public var btnFilterFlags:ButtonContainer;
      
      public var btnFilterPrivate:ButtonContainer;
      
      public var btnFilterTemple:ButtonContainer;
      
      public var btnFilterBidHouse:ButtonContainer;
      
      public var btnFilterCraftHouse:ButtonContainer;
      
      public var btnFilterMisc:ButtonContainer;
      
      public var btnFilterTransport:ButtonContainer;
      
      public var btnFilterConquest:ButtonContainer;
      
      public var btnFilterDungeon:ButtonContainer;
      
      public var btnFilterQuest:ButtonContainer;
      
      public var btnFilterAnomaly:ButtonContainer;
      
      public var btnFilterAll:ButtonContainer;
      
      public var btn_closeSearch:ButtonContainer;
      
      public var btn_sortConquests:ButtonContainer;
      
      public var lblbtnFilterFlags:Label;
      
      public var lblbtnFilterPrivate:Label;
      
      public var lblbtnFilterTemple:Label;
      
      public var lblbtnFilterBidHouse:Label;
      
      public var lblbtnFilterCraftHouse:Label;
      
      public var lblbtnFilterMisc:Label;
      
      public var lblbtnFilterTransport:Label;
      
      public var lblbtnFilterConquest:Label;
      
      public var lblbtnFilterDungeon:Label;
      
      public var lblbtnFilterQuest:Label;
      
      public var lblbtnFilterAnomaly:Label;
      
      public var lblbtnFilterAll:Label;
      
      public var tx_filter_bg:TextureBitmap;
      
      public var territory_filter_close:ButtonContainer;
      
      public var btnConquest:ButtonContainer;
      
      public var btnReward:ButtonContainer;
      
      public var btnBestiary:ButtonContainer;
      
      public var btn_openConfig:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_player:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabPercent:ButtonContainer;
      
      public var btn_showOnlyCurrentMapSubareas:ButtonContainer;
      
      public var tiSearch:Input;
      
      public var lbl_results:Label;
      
      public var lbl_title:Label;
      
      public var ctr_locTree:GraphicContainer;
      
      public var ctr_quantity:GraphicContainer;
      
      public var ctr_search_bg:GraphicContainer;
      
      public var cbx_territory_type:ComboBox;
      
      public var gdZone:Grid;
      
      public var gdZoneReward:Grid;
      
      public var gdSearchAll:Grid;
      
      public var gd_sectors:Grid;
      
      public var btn_worldmap:ButtonContainer;
      
      public var gd_worldmaps:Grid;
      
      public var ctr_worldmapMenu:GraphicContainer;
      
      public var tx_bgWorldmapMenu:TextureBitmap;
      
      private var _dataProvider:AreaGroup;
      
      private var _searchCriteria:String;
      
      private var _rewardMode:Boolean = false;
      
      private var _conquestMode:Boolean = false;
      
      private var _gdConquestProvider:Vector.<AreaGroup>;
      
      private var _gdRewardProvider:Vector.<AreaGroup>;
      
      private var _lastLayer:String;
      
      private var _filterCat:Dictionary;
      
      private var _updateConquestAreas:Boolean;
      
      private var _updateRewardAreas:Boolean;
      
      private var _lastSearch:String;
      
      private var _addEntryHighlight:Boolean;
      
      private var _removeEntryHighlight:Boolean;
      
      private var _searchSelectedItem:Object;
      
      private var _lastSearchSubAreaId:int;
      
      private var _lastSearchSubAreaInfo:String;
      
      private var _searchTimeoutId:uint;
      
      private var _prismsHintGroup:Object;
      
      private var _perceptorsHintGroup:Object;
      
      private var _hintCategoryFiltersListConquest:Array;
      
      private var _hintCategoryFiltersListReward:Array;
      
      private var _hintCategoryFiltersListSearch:Array;
      
      private var _hasResultsInOtherWorldMap:Boolean;
      
      private var currentSorting:uint;
      
      private var _showOnlyCurrentMapSubareas:Boolean = true;
      
      private var _worldmapCatInfosDisplayed:Array;
      
      private var _openedCategories:Array;
      
      private var _worldmapCatOrder:Array;
      
      private var _currentTabName:String;
      
      private var _componentList:Dictionary;
      
      public function CartographyUi()
      {
         this._filterCat = new Dictionary(true);
         this._hintCategoryFiltersListConquest = [];
         this._hintCategoryFiltersListReward = [];
         this._hintCategoryFiltersListSearch = [];
         this._worldmapCatInfosDisplayed = [];
         this._openedCategories = [];
         this._worldmapCatOrder = [3,0,5,6,84];
         this._componentList = new Dictionary(true);
         super();
      }
      
      private static function isSelected(element:*, index:int, arr:Array) : Boolean
      {
         return element;
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      override public function main(params:Object = null) : void
      {
         var worldmapInfo:WorldmapCatInfo = null;
         var worldmapSelected:WorldmapCatInfo = null;
         var i:int = 0;
         var bmpColor:Bitmap = null;
         var bannerMap:UiRootContainer = uiApi.getUi("bannerMap");
         if(bannerMap)
         {
            bannerMap.uiClass.hide();
         }
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.btn_player.soundId = SoundEnum.GEN_BUTTON;
         mapViewer.finalized = false;
         _conquestInformationsIsActive = _conquestInformationsIsActive || this._conquestMode;
         uiApi.addComponentHook(this.btnFilterFlags,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterFlags,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterFlags,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterPrivate,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterPrivate,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterPrivate,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterTemple,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterTemple,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterTemple,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterBidHouse,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterBidHouse,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterBidHouse,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterCraftHouse,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterCraftHouse,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterCraftHouse,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterMisc,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterMisc,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterMisc,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterTransport,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterTransport,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterTransport,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterQuest,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterQuest,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterQuest,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterConquest,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterConquest,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterConquest,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterDungeon,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterDungeon,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterDungeon,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnFilterAnomaly,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterAnomaly,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterAnomaly,ComponentHookList.ON_ROLL_OUT);
         if(sysApi.getBuildType() == BuildTypeEnum.DEBUG)
         {
            this.btn_openConfig.visible = true;
            uiApi.addComponentHook(this.btn_openConfig,ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.btn_openConfig,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_openConfig,ComponentHookList.ON_ROLL_OUT);
         }
         uiApi.addComponentHook(this.btnFilterAll,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnFilterAll,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnFilterAll,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.tx_filter_bg,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.tx_filter_bg,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnReward,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnReward,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnConquest,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnConquest,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btnBestiary,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btnBestiary,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_player,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_player,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.tiSearch,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnReward,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnConquest,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btnBestiary,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.territory_filter_close,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.cbx_territory_type,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.gdZone,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.gdZone,ComponentHookList.ON_ITEM_ROLL_OVER);
         uiApi.addComponentHook(this.gdZoneReward,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.gdZoneReward,ComponentHookList.ON_ITEM_ROLL_OVER);
         uiApi.addComponentHook(this.gdZoneReward,ComponentHookList.ON_ITEM_ROLL_OUT);
         sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         sysApi.addHook(HookList.MapDebugWorldGraphSortcutToggle,this.traceShortcuts);
         loadMapFilters(this._hintCategoryFiltersListConquest,CONQUEST_FILTERS);
         loadMapFilters(this._hintCategoryFiltersListReward,REWARD_FILTERS);
         loadMapFilters(this._hintCategoryFiltersListSearch,SEARCH_FILTERS);
         loadMapFilters(__hintCategoryFiltersList,MAP_FILTERS);
         this._conquestMode = params.conquest;
         this.switchTo();
         gridDisplayed = configApi.getConfigProperty("dofus","showMapGrid");
         if(!_worldmapCatInfos)
         {
            this.createWorldmapMenuInfo();
         }
         this._openedCategories = sysApi.getSetData("worldmapOpenedCat",this._openedCategories,DataStoreEnum.BIND_ACCOUNT);
         this._worldmapCatInfosDisplayed = _worldmapCatInfos;
         for each(worldmapInfo in this._worldmapCatInfosDisplayed)
         {
            if(this._openedCategories.indexOf(worldmapInfo.id) != -1)
            {
               this.addSubCategories(worldmapInfo);
            }
         }
         this.gd_worldmaps.dataProvider = this._worldmapCatInfosDisplayed;
         this.ctr_worldmapMenu.visible = sysApi.getData("worldmapMenuIsHidden",DataStoreEnum.BIND_ACCOUNT);
         this.updateWorldmapGridHeight();
         super.main(params);
         worldmapSelected = this.selectWorldmapCatInfoById(_currentWorldId);
         if(worldmapSelected)
         {
            this.gd_worldmaps.selectedItem = worldmapSelected;
         }
         sysApi.dispatchHook(HookList.MapDisplay,true);
         this.tiSearch.text = uiApi.getText("ui.map.search");
         var numColors:uint = RESOURCES_QUANTITY_COLOR.length;
         for(i = 0; i < numColors; i++)
         {
            bmpColor = new Bitmap(new BitmapData(30,20,false,RESOURCES_QUANTITY_COLOR[i]));
            bmpColor.x = 15;
            bmpColor.y = 8 + i * 30;
            this.ctr_quantity.addChild(bmpColor);
         }
         this.gdSearchAll.visible = this.ctr_search_bg.visible = this.ctr_quantity.visible = false;
         this.initBreachSectors();
         sysApi.startStats("cartography");
      }
      
      override protected function initMap() : void
      {
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var coordinate:BreachWorldMapCoordinate = null;
         var breachIconId:int = 0;
         super.initMap();
         this._updateRewardAreas = true;
         mapViewer.addLayer(SEARCH_AREAS);
         mapViewer.addLayer(SEARCH_AREAS_FLAGS);
         mapViewer.addLayer(SEARCH_HINTS);
         this.btnReward.soundId = SoundEnum.TAB;
         this.btnConquest.soundId = SoundEnum.TAB;
         this.territory_filter_close.soundId = SoundEnum.TAB;
         soundApi.playSound(SoundTypeEnum.MAP_OPEN);
         this.showHints(__hintCategoryFiltersList);
         this.setLblFilterWidth(1);
         this.btnFilterAll.selected = this.someFilterSelected();
         this._filterCat[this.btnFilterTemple] = MAP_LAYER_CLASS_TEMPLES;
         this._filterCat[this.btnFilterBidHouse] = MAP_LAYER_BIDHOUSES;
         this._filterCat[this.btnFilterCraftHouse] = MAP_LAYER_CRAFT_HOUSES;
         this._filterCat[this.btnFilterMisc] = MAP_LAYER_MISC;
         this._filterCat[this.btnFilterConquest] = MAP_LAYER_PRISMS;
         this._filterCat[this.btnFilterDungeon] = MAP_LAYER_DUNGEONS;
         this._filterCat[this.btnFilterPrivate] = MAP_LAYER_PRIVATE;
         this._filterCat[this.btnFilterFlags] = MAP_LAYER_FLAGS;
         this._filterCat[this.btnFilterTransport] = MAP_LAYER_TRANSPORTS;
         this._filterCat[this.btnFilterQuest] = MAP_LAYER_QUEST;
         this._filterCat[this.btnFilterAnomaly] = MAP_LAYER_ANOMALIES;
         if(!__conquestSubAreasInfos)
         {
            if(modCartography.showConquestInformation())
            {
               this.btnConquest.disabled = false;
               sysApi.sendAction(new PrismsListRegisterAction(["cartography.Cartography",PrismListenEnum.PRISM_LISTEN_ALL]));
               _conquestInformationsIsActive = true;
            }
            else
            {
               this.btnConquest.disabled = true;
            }
         }
         else if(modCartography.showConquestInformation())
         {
            this.addAreaShapesFromData(__capturableAreas);
            this.addAreaShapesFromData(__normalAreas);
            this.addAreaShapesFromData(__weakenedAreas);
            this.addAreaShapesFromData(__vulnerableAreas);
            this.addAreaShapesFromData(__sabotagedAreas);
            this.updateConquestSubarea(false);
            for each(prismSubAreaInfo in __conquestSubAreasInfos)
            {
               updatePrismIcon(prismSubAreaInfo);
            }
         }
         if(!__subAreasInfos)
         {
            sysApi.sendAction(new AnomalySubareaInformationRequestAction(["cartography.Cartography"]));
         }
         uiApi.getUi("gameMenu").visible = false;
         sysApi.showWorld(false);
         this.mainCtr.visible = true;
         this.ctr_filter.visible = this.ctr_info.visible = !playerApi.isInBreach() && !playerApi.isInBreachSubArea();
         this.ctr_breach.visible = playerApi.isInBreach() || playerApi.isInBreachSubArea();
         var hintUri:String = uiApi.me().getConstant("hintIcons");
         if(playerApi.isInBreach() || playerApi.isInBreachSubArea())
         {
            _showMapCoords = false;
            for each(coordinate in dataApi.getAllBreachWorldMapCoordinate())
            {
               if(!mapViewer.getMapElement("breachIcon_" + coordinate.mapStage))
               {
                  mapViewer.addBreachIcon(MAP_LAYER_BREACH,"breachIcon_" + coordinate.mapStage,hintUri + coordinate.unexploredMapIcon + ".png",coordinate.mapCoordinateX,coordinate.mapCoordinateY,1.5,coordinate.mapStage < 200 ? uiApi.getText("ui.breach.floors",breachMinStage,coordinate.mapStage) : uiApi.getText("ui.breach.floor",coordinate.mapStage),false,-1,false,HintPriorityEnum.FLAGS);
               }
               breachIconId = this.getBreachIconByFloor(coordinate);
               if(!mapViewer.getMapElement("breachIcon_" + coordinate.mapStage + "highlight") && breachIconId > 0)
               {
                  mapViewer.addBreachIcon(MAP_LAYER_BREACH_HIGHLIGHT,"breachIcon_" + coordinate.mapStage + "highlight",hintUri + breachIconId + ".png",coordinate.mapCoordinateX,coordinate.mapCoordinateY,1.5,coordinate.mapStage < 200 ? uiApi.getText("ui.breach.floors",breachMinStage,coordinate.mapStage) : uiApi.getText("ui.breach.floor",coordinate.mapStage),false,-1,false,HintPriorityEnum.FLAGS);
               }
            }
            mapViewer.updateMapElements();
         }
      }
      
      private function getBreachIconByFloor(coord:BreachWorldMapCoordinate) : int
      {
         if(!breachApi.breachFrame || !breachApi.getFloor() || coord.mapStage > breachApi.getFloor())
         {
            return 0;
         }
         return coord.exploredMapIcon;
      }
      
      override public function unload() : void
      {
         super.unload();
         _conquestInformationsIsActive = false;
         sysApi.showWorld(true);
         sysApi.dispatchHook(HookList.MapDisplay,false);
         uiApi.getUi("gameMenu").visible = true;
         clearTimeout(this._searchTimeoutId);
         if(this._conquestMode)
         {
            saveMapFilters(this._hintCategoryFiltersListConquest,CONQUEST_FILTERS);
         }
         else if(this._rewardMode)
         {
            saveMapFilters(this._hintCategoryFiltersListReward,REWARD_FILTERS);
         }
         else if(this._searchSelectedItem)
         {
            saveMapFilters(this._hintCategoryFiltersListSearch,SEARCH_FILTERS);
         }
         var bannerMap:UiRootContainer = uiApi.getUi("bannerMap");
         if(bannerMap)
         {
            bannerMap.uiClass.show();
         }
      }
      
      public function updateGridLine(data:AreaInfo, componentsRef:*, selected:Boolean) : void
      {
         var c:ColorTransform = null;
         if(data)
         {
            c = new ColorTransform();
            if(data.parent != null)
            {
               c.color = uiApi.me().getConstant(data.parent.colorKey);
            }
            if(this._rewardMode)
            {
               componentsRef.tx_anomaly_filter.visible = data.hasAnomaly;
               componentsRef.lbl_percent_filter.text = (data.percent > 0 ? "+" : "") + data.percent + "%";
               componentsRef.lbl_percent_filter.colorTransform = c;
            }
            componentsRef.tx_area_filter.uri = uiApi.createUri(uiApi.me().getConstant(data.uri));
            componentsRef.tx_area_filter.colorTransform = c;
            componentsRef.lbl_area_filter.text = data.label;
            componentsRef.lbl_area_filter.colorTransform = c;
            componentsRef.tx_area_filter.width = int(uiApi.me().getConstant("icon_simple_width"));
         }
         else
         {
            componentsRef.tx_area_filter.uri = null;
            componentsRef.lbl_area_filter.text = "";
            if(componentsRef["tx_anomaly_filter"])
            {
               componentsRef.tx_anomaly_filter.visible = false;
            }
            if(componentsRef["lbl_percent_filter"])
            {
               componentsRef.lbl_percent_filter.text = "";
            }
         }
      }
      
      public function updateFilterLine(data:AreaGroup, componentsRef:*, selected:Boolean) : void
      {
         var c:ColorTransform = null;
         if(data)
         {
            c = new ColorTransform();
            if(data.layer == ANOMALY_AREAS)
            {
               c.color = uiApi.me().getConstant("sabotaged_areas_color");
            }
            else
            {
               c.color = uiApi.me().getConstant(data.colorKey);
            }
            if(this._rewardMode)
            {
               componentsRef.lbl_area_filter.text = data.label;
            }
            else
            {
               componentsRef.lbl_area_filter.text = data.label + " (" + data.children.length + ")";
            }
            componentsRef.lbl_area_filter.colorTransform = c;
            componentsRef.tx_area_filter.colorTransform = c;
            componentsRef.tx_area_filter.uri = uiApi.createUri(uiApi.me().getConstant(data.uri));
            if(data.layer == ALL_AREAS && this._conquestMode)
            {
               componentsRef.tx_area_filter.width = int(uiApi.me().getConstant("icon_multi_prism_width"));
            }
            else
            {
               componentsRef.tx_area_filter.width = int(uiApi.me().getConstant("icon_simple_width"));
            }
         }
      }
      
      public function updateSectors(data:BreachWorldMapSector, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!this._componentList[componentsRef.btn_breachSector.name])
            {
               uiApi.addComponentHook(componentsRef.btn_breachSector,ComponentHookList.ON_ROLL_OUT);
               uiApi.addComponentHook(componentsRef.btn_breachSector,ComponentHookList.ON_ROLL_OVER);
            }
            this._componentList[componentsRef.btn_breachSector.name] = data;
            componentsRef.tx_breachSector.uri = uiApi.createUri(uiApi.me().getConstant("hintIcons") + data.sectorIcon + ".png");
            componentsRef.lbl_breachSector.text = data.legend;
         }
      }
      
      protected function updateAllFilters() : void
      {
         var filters:Array = null;
         var filtersMode:String = null;
         var btn:* = undefined;
         var id:int = 0;
         if(this._conquestMode)
         {
            filters = this._hintCategoryFiltersListConquest;
            filtersMode = CONQUEST_FILTERS;
         }
         else if(this._rewardMode)
         {
            filters = this._hintCategoryFiltersListReward;
            filtersMode = REWARD_FILTERS;
         }
         else if(this._searchSelectedItem)
         {
            filters = this._hintCategoryFiltersListSearch;
            filtersMode = SEARCH_FILTERS;
         }
         else
         {
            filters = __hintCategoryFiltersList;
            filtersMode = MAP_FILTERS;
         }
         var select:Boolean = filters.some(isSelected);
         for(var i:int = 1; i < filters.length; i++)
         {
            filters[i] = !select;
         }
         saveMapFilters(filters,filtersMode);
         for(btn in this._filterCat)
         {
            btn.selected = !select;
            if(__layersToShow[this._filterCat[btn]])
            {
               mapViewer.showLayer(this._filterCat[btn],btn.selected);
               mapViewer.updateMapElements();
            }
            id = int(this._filterCat[btn].split("_")[1]);
            if(filters == __hintCategoryFiltersList)
            {
               sysApi.dispatchHook(CustomUiHookList.MapHintsFilter,id,btn.selected,true);
            }
         }
         this.lblbtnFilterAll.text = !!this.btnFilterAll.selected ? uiApi.getText("ui.map.hideAll") : uiApi.getText("ui.map.displayAll");
      }
      
      protected function updateMapFilter(pTarget:ButtonContainer) : void
      {
         var filters:Array = null;
         var filtersMode:String = null;
         var filterId:int = int(this._filterCat[pTarget].split("_")[1]);
         if(this._conquestMode)
         {
            filters = this._hintCategoryFiltersListConquest;
            filtersMode = CONQUEST_FILTERS;
         }
         else if(this._rewardMode)
         {
            filters = this._hintCategoryFiltersListReward;
            filtersMode = REWARD_FILTERS;
         }
         else if(this._searchSelectedItem)
         {
            filters = this._hintCategoryFiltersListSearch;
            filtersMode = SEARCH_FILTERS;
         }
         else
         {
            filters = __hintCategoryFiltersList;
            filtersMode = MAP_FILTERS;
         }
         filters[filterId] = pTarget.selected;
         saveMapFilters(filters,filtersMode);
         if(pTarget.selected)
         {
            this.btnFilterAll.selected = true;
         }
         else
         {
            this.btnFilterAll.selected = this.someFilterSelected();
         }
         this.lblbtnFilterAll.text = !!this.btnFilterAll.selected ? uiApi.getText("ui.map.hideAll") : uiApi.getText("ui.map.displayAll");
         if(__layersToShow[this._filterCat[pTarget]])
         {
            if(pTarget == this.btnFilterDungeon)
            {
               this.showDungeonFilter(pTarget.selected);
            }
            else
            {
               mapViewer.showLayer(this._filterCat[pTarget],pTarget.selected);
            }
            mapViewer.updateMapElements();
         }
         if(filters == __hintCategoryFiltersList)
         {
            sysApi.dispatchHook(CustomUiHookList.MapHintsFilter,filterId,pTarget.selected,true);
         }
      }
      
      override protected function addCustomFlagWithRightClick(pX:Number, pY:Number) : void
      {
         if(!this.btnFilterFlags.selected)
         {
            this.btnFilterFlags.selected = true;
            this.updateMapFilter(this.btnFilterFlags);
         }
         super.addCustomFlagWithRightClick(pX,pY);
      }
      
      override protected function addAreaInfo(pList:AreaGroup, pItem:AreaInfo) : void
      {
         var group:AreaGroup = null;
         var item:AreaInfo = null;
         super.addAreaInfo(pList,pItem);
         if(pList && this._conquestMode)
         {
            if(pList.layer != ALL_AREAS)
            {
               for each(group in this._gdConquestProvider)
               {
                  if(group.layer != ALL_AREAS && group.layer != pList.layer)
                  {
                     for each(item in group.children)
                     {
                        if(item.data.id == pItem.data.id)
                        {
                           group.children.splice(group.children.indexOf(item),1);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      override protected function onPrismsListInformation(pPrismsInfo:Dictionary) : void
      {
         super.onPrismsListInformation(pPrismsInfo);
         this._gdConquestProvider = new Vector.<AreaGroup>(0);
         this._gdConquestProvider.push(__capturableAreas);
         this._gdConquestProvider.push(__normalAreas);
         this._gdConquestProvider.push(__weakenedAreas);
         this._gdConquestProvider.push(__vulnerableAreas);
         this._gdConquestProvider.push(__sabotagedAreas);
         this._updateConquestAreas = true;
         if(this._conquestMode)
         {
            this.switchMode();
         }
         this.createPrismsSearchGroup(pPrismsInfo);
      }
      
      override protected function onPrismsInfoUpdate(pPrismSubAreaIds:Array) : void
      {
         var list:AreaGroup = null;
         var selectedTerritoryTypeLayer:String = null;
         var itemValue:int = 0;
         var areaGroup:AreaGroup = null;
         var item:AreaInfo = null;
         super.onPrismsInfoUpdate(pPrismSubAreaIds);
         if(this._conquestMode)
         {
            for each(list in this._gdConquestProvider)
            {
               list.children.sort(this.compareSubAreaItem);
            }
            selectedTerritoryTypeLayer = "";
            if(this.cbx_territory_type.selectedItem)
            {
               selectedTerritoryTypeLayer = this.cbx_territory_type.selectedItem.value.layer;
            }
            if(this.gdZone.selectedItem)
            {
               itemValue = this.gdZone.selectedItem.value.data.id;
            }
            this.cbx_territory_type.dataProvider = this._gdConquestProvider;
            if(!this._searchCriteria)
            {
               for each(areaGroup in this._gdConquestProvider)
               {
                  if(areaGroup.layer == selectedTerritoryTypeLayer)
                  {
                     this.cbx_territory_type.selectedItem = areaGroup;
                     break;
                  }
               }
               this.gdZone.dataProvider = this.cbx_territory_type.selectedItem.value.children;
               for each(item in this.gdZone.dataProvider)
               {
                  if(item.data.id == itemValue)
                  {
                     this.gdZone.selectedItem = item;
                     break;
                  }
               }
            }
            else
            {
               this.cbx_territory_type.selectedItem = __allAreas;
               this.gdZone.dataProvider = this.filterSubArea(this._searchCriteria,__allAreas.children);
               for each(item in this.gdZone.dataProvider)
               {
                  if(item.data.id == itemValue)
                  {
                     this.gdZone.selectedItem = item;
                     break;
                  }
               }
            }
            if(this._lastLayer)
            {
               this.updateLayerAreaShapes(this._lastLayer);
            }
         }
         this.updatePrismsSearchGroup(pPrismSubAreaIds);
      }
      
      override protected function onTaxCollectorListUpdate(infoType:uint = 0) : void
      {
         var taxCollector:TaxCollectorWrapper = null;
         var hint:Object = null;
         super.onTaxCollectorListUpdate(infoType);
         if(!this._perceptorsHintGroup)
         {
            this._perceptorsHintGroup = {};
            this._perceptorsHintGroup.type = HINT_GROUP_SEARCH_TYPE;
            this._perceptorsHintGroup.name = uiApi.getText("ui.social.guildTaxCollectors");
            this._perceptorsHintGroup.data = [];
            this._perceptorsHintGroup.uri = uiApi.me().getConstant("hintIcons") + "1003.png";
         }
         this._perceptorsHintGroup.data.length = 0;
         var taxCollectorsList:Dictionary = socialApi.getTaxCollectors();
         for each(taxCollector in taxCollectorsList)
         {
            if(dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == superAreaId)
            {
               hint = {};
               hint.id = "_taxCollector" + taxCollector.uniqueId;
               hint.gfx = "1003";
               hint.x = taxCollector.mapWorldX;
               hint.y = taxCollector.mapWorldY;
               hint.name = __hintCaptions["guildPony_" + taxCollector.uniqueId];
               this._perceptorsHintGroup.data.push(hint);
            }
         }
      }
      
      override protected function getSubAreaTooltipPosition() : Point
      {
         var tooltip:UiRootContainer = uiApi.getUi("tooltip_cartographyCurrentSubArea");
         __subAreaTooltipPosition.x = (this.btn_close as Object).localToGlobal(new Point(this.btn_close.x,this.btn_close.y)).x - 10 - tooltip.width;
         __subAreaTooltipPosition.y = 30;
         return __subAreaTooltipPosition;
      }
      
      private function createWorldmapMenuInfo() : void
      {
         var worldmap:WorldMap = null;
         var worldmapInfo:WorldmapInfo = null;
         var key:* = null;
         var area:Area = null;
         var subCatKey:* = null;
         var parentCatInfo:WorldmapCatInfo = null;
         var id:uint = 0;
         var superArea:SuperArea = null;
         var worldmaps:Array = dataApi.getAllWorldMaps();
         var worldmapInfos:Dictionary = new Dictionary();
         var superAreaCategories:Dictionary = new Dictionary();
         var areaCategories:Dictionary = new Dictionary();
         var subCategories:Dictionary = new Dictionary();
         for each(worldmap in worldmaps)
         {
            if(worldmap.visibleOnMap)
            {
               worldmapInfo = new WorldmapInfo(worldmap);
               worldmapInfo.superAreaWithWorldmapIds = dataApi.queryEquals(SuperArea,"worldmapId",worldmap.id);
               worldmapInfo.areaWithWorldmapIds = dataApi.queryEquals(Area,"worldmapId",worldmap.id);
               worldmapInfo.subAreaWithWorldmapIds = dataApi.queryEquals(SubArea,"worldmapId",worldmap.id);
               worldmapInfo.setup();
               worldmapInfos[worldmapInfo.worldmap.id] = worldmapInfo;
            }
         }
         for(key in worldmapInfos)
         {
            worldmapInfo = worldmapInfos[key];
            if(worldmapInfo.parentSuperAreaId != -1 && worldmapInfo.parentAreaId < 0)
            {
               if(!superAreaCategories[worldmapInfo.parentSuperAreaId])
               {
                  superAreaCategories[worldmapInfo.parentSuperAreaId] = [];
               }
               superAreaCategories[worldmapInfo.parentSuperAreaId].push(worldmapInfo);
            }
            else if(worldmapInfo.parentSuperAreaId != -1 && worldmapInfo.parentAreaId != -1)
            {
               if(!subCategories[worldmapInfo.parentAreaId])
               {
                  subCategories[worldmapInfo.parentAreaId] = [];
               }
               subCategories[worldmapInfo.parentAreaId].push(worldmapInfo);
            }
         }
         for(subCatKey in subCategories)
         {
            area = dataApi.getArea(int(subCatKey));
            if(area)
            {
               if(superAreaCategories[area.superAreaId])
               {
                  superAreaCategories[area.superAreaId] = superAreaCategories[area.superAreaId].concat(subCategories[int(subCatKey)]);
               }
               else
               {
                  areaCategories[area.id] = [];
                  areaCategories[area.id] = areaCategories[area.id].concat(subCategories[area.id]);
               }
            }
         }
         _worldmapCatInfos = [];
         for each(id in this._worldmapCatOrder)
         {
            if(superAreaCategories[id])
            {
               superArea = dataApi.getSuperArea(id);
               if(superArea)
               {
                  if(worldmapInfos[superArea.worldmapId])
                  {
                     parentCatInfo = new WorldmapCatInfo(superArea.worldmapId,worldmapInfos[superArea.worldmapId].worldmap,false,superArea);
                     _worldmapCatInfos.push(parentCatInfo);
                  }
                  else
                  {
                     worldmapInfo = superAreaCategories[id][0];
                     parentCatInfo = new WorldmapCatInfo(worldmapInfo.worldmap.id,null,false,superArea);
                     if(superAreaCategories[id].length == 1)
                     {
                        parentCatInfo.name = worldmapInfo.worldmap.name;
                        _worldmapCatInfos.push(parentCatInfo);
                        continue;
                     }
                     if(worldmapInfo.parentAreaId < 0 && worldmapInfo.parentSuperAreaId >= 0)
                     {
                        parentCatInfo.name = dataApi.getSuperArea(worldmapInfo.parentSuperAreaId).name;
                     }
                     else if(worldmapInfo.parentAreaId >= 0)
                     {
                        parentCatInfo.name = dataApi.getArea(worldmapInfo.parentAreaId).name;
                     }
                     _worldmapCatInfos.push(parentCatInfo);
                  }
                  for each(worldmapInfo in superAreaCategories[id])
                  {
                     if(worldmapInfo.worldmap.id != superArea.worldmapId)
                     {
                        parentCatInfo.children.push(new WorldmapCatInfo(worldmapInfo.worldmap.id,worldmapInfo.worldmap,true,superArea,parentCatInfo));
                     }
                  }
                  if(parentCatInfo.children.length > 1)
                  {
                     parentCatInfo.children = parentCatInfo.children.sort(this.sortByName);
                  }
               }
            }
            else if(areaCategories[id])
            {
               area = dataApi.getArea(id);
               if(area)
               {
                  if(worldmapInfos[area.worldmapId])
                  {
                     parentCatInfo = new WorldmapCatInfo(area.worldmapId,worldmapInfos[area.worldmapId].worldmap,false,area.superArea);
                     _worldmapCatInfos.push(parentCatInfo);
                  }
                  else
                  {
                     worldmapInfo = areaCategories[id][0];
                     parentCatInfo = new WorldmapCatInfo(worldmapInfo.worldmap.id,null,false,area.superArea);
                     if(areaCategories[id].length == 1)
                     {
                        parentCatInfo.name = worldmapInfo.worldmap.name;
                        parentCatInfo.worldmap = worldmapInfo.worldmap;
                        _worldmapCatInfos.push(parentCatInfo);
                        continue;
                     }
                     if(worldmapInfo.parentAreaId < 0 && worldmapInfo.parentSuperAreaId >= 0)
                     {
                        parentCatInfo.name = dataApi.getSuperArea(worldmapInfo.parentSuperAreaId).name;
                     }
                     else if(worldmapInfo.parentAreaId >= 0)
                     {
                        parentCatInfo.name = dataApi.getArea(worldmapInfo.parentAreaId).name;
                     }
                     _worldmapCatInfos.push(parentCatInfo);
                  }
                  for each(worldmapInfo in areaCategories[id])
                  {
                     if(worldmapInfo.worldmap.id != area.worldmapId)
                     {
                        parentCatInfo.children.push(new WorldmapCatInfo(worldmapInfo.worldmap.id,worldmapInfo.worldmap,true,area.superArea,parentCatInfo));
                     }
                  }
                  if(parentCatInfo.children.length > 1)
                  {
                     parentCatInfo.children = parentCatInfo.children.sort(this.sortByName);
                  }
               }
            }
         }
      }
      
      private function sortByName(worldmapCatInfo1:WorldmapCatInfo, worldmapCatInfo2:WorldmapCatInfo) : int
      {
         var firstValue:String = StringUtils.noAccent(worldmapCatInfo1.name);
         var secondValue:String = StringUtils.noAccent(worldmapCatInfo2.name);
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return 0;
      }
      
      public function updateWorldmap(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getWorldmapLineType(data,line))
         {
            case CTR_WORLDMAP_CAT:
               if(!this._componentList[componentsRef.btn_worldmapCat.name])
               {
                  uiApi.addComponentHook(componentsRef.btn_worldmapCat,ComponentHookList.ON_RELEASE);
               }
               if(!this._componentList[componentsRef.btn_deployWorldmapCat.name])
               {
                  uiApi.addComponentHook(componentsRef.btn_deployWorldmapCat,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.btn_worldmapCat.name] = data;
               this._componentList[componentsRef.btn_deployWorldmapCat.name] = data;
               componentsRef.tx_catplusminus.visible = data.children.length > 0;
               if(this._openedCategories.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               componentsRef.lbl_worldmapCatName.text = data.name;
               componentsRef.btn_worldmapCat.selected = selected;
               break;
            case CTR_WORLDMAP_SUB_CAT:
               if(!this._componentList[componentsRef.btn_worldmapSubCat.name])
               {
                  uiApi.addComponentHook(componentsRef.btn_worldmapSubCat,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.btn_worldmapSubCat.name] = data;
               componentsRef.lbl_worldmapSubCatName.text = data.name;
               componentsRef.btn_worldmapSubCat.selected = selected;
         }
      }
      
      public function getWorldmapLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data && !data.isSubCat)
         {
            return CTR_WORLDMAP_CAT;
         }
         if(data && data.isSubCat)
         {
            return CTR_WORLDMAP_SUB_CAT;
         }
         return "";
      }
      
      private function displayCategories(worldmapcatInfo:WorldmapCatInfo) : void
      {
         var index:int = this._openedCategories.indexOf(worldmapcatInfo.id);
         if(index == -1)
         {
            this._openedCategories.push(worldmapcatInfo.id);
            this.addSubCategories(worldmapcatInfo);
         }
         else
         {
            this._openedCategories.splice(index,1);
            this.removeSubCategories(worldmapcatInfo);
         }
         sysApi.setData("worldmapOpenedCat",this._openedCategories,DataStoreEnum.BIND_ACCOUNT);
         var worldmapSelected:WorldmapCatInfo = this.selectWorldmapCatInfoById(_currentWorldId);
         if(worldmapSelected)
         {
            this.gd_worldmaps.selectedItem = worldmapSelected;
         }
         this.updateWorldmapGridHeight();
      }
      
      private function addSubCategories(worldmapcatInfo:WorldmapCatInfo) : void
      {
         var parentIndex:int = this._worldmapCatInfosDisplayed.indexOf(worldmapcatInfo);
         for(var i:uint = 0; i < worldmapcatInfo.children.length; i++)
         {
            if(this._worldmapCatInfosDisplayed.indexOf(worldmapcatInfo.children[i]) == -1)
            {
               this._worldmapCatInfosDisplayed.insertAt(parentIndex + 1 + i,worldmapcatInfo.children[i]);
            }
         }
      }
      
      private function removeSubCategories(worldmapcatInfo:WorldmapCatInfo) : void
      {
         var parentIndex:int = this._worldmapCatInfosDisplayed.indexOf(worldmapcatInfo);
         this._worldmapCatInfosDisplayed.splice(parentIndex + 1,worldmapcatInfo.children.length);
      }
      
      private function updateWorldmapGridHeight() : void
      {
         this.gd_worldmaps.dataProvider = this._worldmapCatInfosDisplayed;
         var height:int = Math.min(this.gd_worldmaps.dataProvider.length,MAX_WORLDMAP_DISPLAYED) * this.gd_worldmaps.slotHeight + (Math.min(this.gd_worldmaps.dataProvider.length,MAX_WORLDMAP_DISPLAYED) - 1) * 2;
         this.gd_worldmaps.height = height;
         this.ctr_worldmapMenu.height = height;
         this.tx_bgWorldmapMenu.height = height + 15;
      }
      
      private function selectWorldmapCatInfoById(worldmapId:uint) : WorldmapCatInfo
      {
         var info:WorldmapCatInfo = null;
         var childInfo:WorldmapCatInfo = null;
         for each(info in this.gd_worldmaps.dataProvider)
         {
            if(info.children.length > 0)
            {
               for each(childInfo in info.children)
               {
                  if(childInfo.worldmap)
                  {
                     if(worldmapId == childInfo.worldmap.id && this.gd_worldmaps.dataProvider.indexOf(childInfo) != -1)
                     {
                        return childInfo;
                     }
                     if(worldmapId == childInfo.id)
                     {
                        return childInfo.parentCat;
                     }
                  }
               }
            }
            if(info.worldmap && worldmapId == info.worldmap.id)
            {
               return info;
            }
         }
         return null;
      }
      
      public function showPlayerFlag(show:Boolean) : void
      {
         this.btn_player.disabled = !show;
         if(show)
         {
            this.displayPlayerPosition();
         }
         else
         {
            removeFlag("flag_playerPosition");
         }
      }
      
      private function displayPlayerPosition() : void
      {
         var breachWorldMapCoordinate:BreachWorldMapCoordinate = !breachApi.breachFrame ? null : dataApi.getBreachWorldMapCoordinate(Math.max(dataApi.getBreachMinStageWorldMapCoordinate().mapStage,Math.min(breachApi.getFloor(),dataApi.getBreachMaxStageWorldMapCoordinate().mapStage)));
         var outdoorCoordinateX:int = __playerPos.outdoorX;
         var outdoorCoordinateY:int = __playerPos.outdoorY;
         if(breachWorldMapCoordinate && playerApi.isInBreach())
         {
            outdoorCoordinateX = breachWorldMapCoordinate.mapCoordinateX;
            outdoorCoordinateY = breachWorldMapCoordinate.mapCoordinateY;
         }
         mapViewer.moveTo(outdoorCoordinateX,outdoorCoordinateY);
         if(!mapViewer.getMapElement("flag_playerPosition") && _currentWorldId == PlayedCharacterManager.getInstance().currentWorldMapId)
         {
            addFlag("flag_playerPosition",uiApi.getText("ui.cartography.yourposition"),outdoorCoordinateX,outdoorCoordinateY,39423,false,true,false);
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var searchVisible:Boolean = false;
         var menu:Array = null;
         var worldmapCatInfo:WorldmapCatInfo = null;
         var worldmapSelected:WorldmapCatInfo = null;
         super.onRelease(target);
         switch(target)
         {
            case this.btn_player:
               if(mapViewer.zoomFactor >= mapViewer.minScale)
               {
                  this.displayPlayerPosition();
               }
               break;
            case this.btn_close:
               soundApi.playSound(SoundTypeEnum.MAP_CLOSE);
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.tiSearch:
               if(uiApi.getText("ui.map.search") == this.tiSearch.text)
               {
                  this.tiSearch.text = "";
               }
               break;
            case this.btn_openConfig:
               if(!uiApi.getUi("cartographyTool"))
               {
                  uiApi.loadUi("cartographyTool","cartographyTool",[__worldMapInfo.id]);
               }
               break;
            case this.btnFilterTemple:
            case this.btnFilterBidHouse:
            case this.btnFilterCraftHouse:
            case this.btnFilterMisc:
            case this.btnFilterConquest:
            case this.btnFilterDungeon:
            case this.btnFilterPrivate:
            case this.btnFilterFlags:
            case this.btnFilterTransport:
            case this.btnFilterQuest:
            case this.btnFilterAnomaly:
               this.updateMapFilter(target as ButtonContainer);
               break;
            case this.btnFilterAll:
               this.updateAllFilters();
               break;
            case this.territory_filter_close:
               this._rewardMode = false;
               this._conquestMode = false;
               this.switchTo();
               hintsApi.closeSubHints();
               break;
            case this.btnReward:
               this._rewardMode = !this._rewardMode;
               this._conquestMode = false;
               this.conquest_content.visible = false;
               this.reward_content.visible = true;
               this.switchTo();
               uiApi.hideTooltip();
               hintsApi.uiTutoTabLaunch();
               break;
            case this.btnConquest:
               this.conquest_content.visible = true;
               this.reward_content.visible = false;
               this._conquestMode = !this._conquestMode;
               this._rewardMode = false;
               this.switchTo();
               uiApi.hideTooltip();
               hintsApi.uiTutoTabLaunch();
               break;
            case this.btnBestiary:
               sysApi.sendAction(new OpenBookAction(["bestiaryTab"]));
               break;
            case this.btn_closeSearch:
               searchVisible = this.removeSearchMapElements();
               this.gdSearchAll.visible = this.ctr_search_bg.visible = this.ctr_quantity.visible = false;
               this.tiSearch.text = uiApi.getText("ui.map.search");
               this.btn_closeSearch.visible = false;
               if(searchVisible)
               {
                  this.showHints(__hintCategoryFiltersList);
                  mapViewer.updateMapElements();
               }
               this._searchSelectedItem = null;
               this._lastSearchSubAreaId = -1;
               clearTimeout(this._searchTimeoutId);
               this._searchCriteria = null;
               if(this.cbx_territory_type.selectedItem && this.cbx_territory_type.selectedItem is AreaGroup && this.cbx_territory_type.selectedItem.children)
               {
                  this._dataProvider = this.cbx_territory_type.selectedItem as AreaGroup;
               }
               else
               {
                  this._dataProvider = __allAreas;
               }
               if(this._dataProvider == null)
               {
                  this._dataProvider = new AreaGroup("","","","");
               }
               this.searchFilter();
               break;
            case this.btn_sortConquests:
               menu = [];
               menu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.sortBy.alpha"),this.onSortSubarea,[SORT_BY_NAME],false,null,this.currentSorting == SORT_BY_NAME || this.currentSorting == 0));
               if(this._conquestMode)
               {
                  menu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.prism.sortByVulnerabilityDate"),this.onSortSubarea,[SORT_BY_VULNERABILITY_DATE],false,null,this.currentSorting == SORT_BY_VULNERABILITY_DATE));
               }
               else if(this._rewardMode)
               {
                  menu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.sortBy.bonus"),this.onSortSubarea,[SORT_BY_PERCENT],false,null,this.currentSorting == SORT_BY_PERCENT));
               }
               modContextMenu.createContextMenu(menu);
               break;
            case this.btn_tabName:
               this.onSortSubarea(SORT_BY_NAME);
               break;
            case this.btn_tabPercent:
               this.onSortSubarea(SORT_BY_PERCENT);
               break;
            case this.btn_showOnlyCurrentMapSubareas:
               this._showOnlyCurrentMapSubareas = !this._showOnlyCurrentMapSubareas;
               this.showOnlyCurrentMapSubareas();
               break;
            case this.btn_help:
               hintsApi.showSubHints(this.currentTabName);
               break;
            case this.btn_worldmap:
               this.ctr_worldmapMenu.visible = !this.ctr_worldmapMenu.visible;
               sysApi.setData("worldmapMenuIsHidden",this.ctr_worldmapMenu.visible,DataStoreEnum.BIND_ACCOUNT);
               break;
            default:
               if(target.name.indexOf("btn_worldmapCat") != -1 || target.name.indexOf("btn_worldmapSubCat") != -1)
               {
                  worldmapCatInfo = this._componentList[target.name];
                  if(worldmapCatInfo.worldmap)
                  {
                     if(worldmapCatInfo.worldmap.id != _currentWorldId)
                     {
                        sysApi.dispatchHook(HookList.DisplayWorldmap,worldmapCatInfo.worldmap);
                     }
                     openNewMap(worldmapCatInfo.worldmap,MAP_TYPE_SUPERAREA,worldmapCatInfo.areaInfo);
                     zoom = parseFloat(worldmapCatInfo.worldmap.zoom[worldmapCatInfo.worldmap.zoom.length - 1]);
                     worldmapSelected = this.selectWorldmapCatInfoById(_currentWorldId);
                     if(worldmapSelected)
                     {
                        this.gd_worldmaps.selectedItem = worldmapSelected;
                     }
                  }
               }
               else if(target.name.indexOf("btn_deployWorldmapCat") != -1)
               {
                  worldmapCatInfo = this._componentList[target.name];
                  this.displayCategories(worldmapCatInfo);
               }
         }
         if(target != this.tiSearch && this.tiSearch && this.tiSearch.text.length == 0)
         {
            this.tiSearch.text = uiApi.getText("ui.map.search");
            this.btn_closeSearch.visible = false;
         }
      }
      
      override public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         super.onKeyUp(target,keyCode);
         if(this.tiSearch.haveFocus)
         {
            this._searchCriteria = this.tiSearch.text.toLowerCase();
            if(!this._searchCriteria.length)
            {
               this._searchCriteria = null;
               this.btn_closeSearch.visible = false;
            }
            else
            {
               this.btn_closeSearch.visible = true;
            }
            if(this._conquestMode)
            {
               this.searchFilter();
            }
            else if(keyCode != Keyboard.ENTER)
            {
               clearTimeout(this._searchTimeoutId);
               if(this._lastSearch && this._searchCriteria == this._lastSearch)
               {
                  this.gdSearchAll.visible = this.ctr_search_bg.visible = true;
               }
               else
               {
                  this._searchTimeoutId = setTimeout(this.searchAll,500,this._searchCriteria);
               }
            }
         }
      }
      
      public function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         var selectedIndex:int = 0;
         if(this.tiSearch.haveFocus && !this._conquestMode && this.gdSearchAll.dataProvider.length > 0)
         {
            selectedIndex = this.gdSearchAll.selectedIndex;
            if(keyCode == Keyboard.UP)
            {
               this._removeEntryHighlight = true;
               this.gdSearchAll.updateItem(selectedIndex);
               selectedIndex--;
               if(selectedIndex < 0)
               {
                  selectedIndex = 0;
               }
               this.gdSearchAll.selectedIndex = selectedIndex;
            }
            else if(keyCode == Keyboard.DOWN)
            {
               this._removeEntryHighlight = true;
               this.gdSearchAll.updateItem(selectedIndex);
               selectedIndex++;
               if(selectedIndex > this.gdSearchAll.dataProvider.length - 1)
               {
                  selectedIndex = this.gdSearchAll.dataProvider.length - 1;
               }
               this.gdSearchAll.selectedIndex = selectedIndex;
            }
            else if(keyCode == Keyboard.ENTER && this._lastSearch && this._searchCriteria == this._lastSearch)
            {
               this.onSelectItem(this.gdSearchAll,SelectMethodEnum.CLICK,false);
            }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, method:uint, isNew:Boolean) : void
      {
         var item:Object = null;
         var itemLabel:String = null;
         var subAreaCenter:Point = null;
         var subAreaId:int = 0;
         var hint:Object = null;
         var sa:SuperArea = null;
         var lineColor:uint = 0;
         var fillColor:uint = 0;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var alliance:AllianceWrapper = null;
         var len:uint = 0;
         var resourceQuantity:uint = 0;
         var shapeColor:uint = 0;
         var i:int = 0;
         var subAreasIds:Object = null;
         var l:uint = 0;
         var numSubAreas:int = 0;
         var endIndex:int = 0;
         var j:int = 0;
         if(target is ComboBox)
         {
            item = (target as ComboBox).selectedItem;
         }
         else if(target is Grid)
         {
            item = (target as Grid).selectedItem;
         }
         var searchEntrySelected:Boolean = target == this.gdSearchAll && method == SelectMethodEnum.CLICK;
         if(target == this.cbx_territory_type)
         {
            this._dataProvider = item is AreaGroup ? item as AreaGroup : new AreaGroup("","","","");
            this.searchFilter();
            this.onSortSubarea(this.currentSorting,true);
         }
         if(searchEntrySelected)
         {
            this.removeSearchMapElements();
            __areaShapeDisplayed.length = 0;
            itemLabel = item.name.indexOf("\n") != -1 ? item.name.split("\n")[0] : item["name"];
            this.tiSearch.text = itemLabel;
            this.tiSearch.caretIndex = -1;
            this.gdSearchAll.visible = this.ctr_search_bg.visible = this.ctr_quantity.visible = false;
            this.showHints(this._hintCategoryFiltersListSearch);
            this._searchSelectedItem = item;
            this._lastSearchSubAreaId = -1;
         }
         if(method == SelectMethodEnum.DOUBLE_CLICK || searchEntrySelected)
         {
            switch(item.type)
            {
               case "superarea":
                  saveCurrentMapPreset();
                  openNewMap(item.data.worldmap,MAP_TYPE_SUPERAREA,item.data);
                  break;
               case "subarea":
                  saveCurrentMapPreset();
                  if(!item.data.hasCustomWorldMap)
                  {
                     sa = dataApi.getArea(item.data.areaId).superArea;
                     if(_currentWorldId != sa.worldmapId)
                     {
                        openNewMap(sa.worldmap,MAP_TYPE_SUPERAREA,sa);
                        __areaShapeDisplayed = [];
                        this.showConquestAreaShapes(item.parent.layer);
                        __lastHighlightElement = "shape" + item.data.id;
                        if(__areaShapeDisplayed.indexOf(item.parent.layer) == -1)
                        {
                           mapViewer.areaShapeColorTransform(mapViewer.getMapElement(__lastHighlightElement) as MapAreaShape,100,1,1,1,1);
                        }
                        else
                        {
                           mapViewer.areaShapeColorTransform(mapViewer.getMapElement(__lastHighlightElement) as MapAreaShape,100,1.2,1.2,1.2,2);
                        }
                     }
                  }
                  if(!openNewMap(item.data.worldmap,MAP_TYPE_SUBAREA,item.data))
                  {
                     subAreaCenter = mapApi.getSubAreaCenter(item.data.id);
                     if(subAreaCenter)
                     {
                        mapViewer.moveTo(subAreaCenter.x,subAreaCenter.y);
                     }
                  }
                  break;
               case HINT_SEARCH_TYPE:
               case SUBAREA_SEARCH_TYPE:
                  if(item.data is Hint)
                  {
                     mapViewer.addIcon(SEARCH_HINTS,"search_hint" + item.data.id,__hintIconsRootPath + item.data.gfx + ".png",item.data.x,item.data.y,__iconScale,item.data.name,true);
                     mapViewer.updateMapElements();
                     mapViewer.moveTo(item.data.x,item.data.y);
                  }
                  else if(item.data is SubArea)
                  {
                     subAreaCenter = mapApi.getSubAreaCenter(item.data.id);
                     if(subAreaCenter)
                     {
                        lineColor = 3355443;
                        fillColor = 1096297;
                        prismSubAreaInfo = socialApi.getPrismSubAreaById(item.data.id);
                        if(prismSubAreaInfo && prismSubAreaInfo.mapId != -1)
                        {
                           alliance = !!prismSubAreaInfo.alliance ? prismSubAreaInfo.alliance : socialApi.getAlliance();
                           lineColor = fillColor = alliance.backEmblem.color;
                        }
                        this.showSearchSubArea(item.data.id,lineColor,fillColor);
                        showAreaShape(SEARCH_AREAS,true);
                        mapViewer.updateMapElements();
                        mapViewer.moveTo(subAreaCenter.x,subAreaCenter.y);
                     }
                  }
                  break;
               case MONSTER_SEARCH_TYPE:
               case ITEM_SEARCH_TYPE:
                  if(item.resourceSubAreaIds)
                  {
                     this.ctr_quantity.visible = true;
                     len = item.resourceSubAreaIds.length;
                     for(i = 0; i < len; i += 2)
                     {
                        subAreaId = item.resourceSubAreaIds[i];
                        resourceQuantity = item.resourceSubAreaIds[i + 1];
                        if(resourceQuantity <= 5)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[0];
                        }
                        else if(resourceQuantity <= 10)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[1];
                        }
                        else if(resourceQuantity <= 25)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[2];
                        }
                        else if(resourceQuantity <= 50)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[3];
                        }
                        else if(resourceQuantity <= 100)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[4];
                        }
                        else if(resourceQuantity <= 250)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[5];
                        }
                        else if(resourceQuantity <= 500)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[6];
                        }
                        else if(resourceQuantity > 500)
                        {
                           shapeColor = RESOURCES_QUANTITY_COLOR[7];
                        }
                        this.showSearchSubArea(subAreaId,7039851,shapeColor,1,0.8);
                     }
                  }
                  else if(item.subAreasIds)
                  {
                     subAreasIds = item.type == MONSTER_SEARCH_TYPE ? item.subAreasIds : null;
                     if(!subAreasIds)
                     {
                        l = item.subAreasIds.length;
                        for(i = 0; i < l; i += 2)
                        {
                           numSubAreas = item.subAreasIds[i + 1];
                           endIndex = i + 2 + numSubAreas;
                           for(j = i + 2; j < endIndex; j++)
                           {
                              this.showSearchSubArea(item.subAreasIds[j]);
                           }
                           i += numSubAreas;
                        }
                     }
                     else
                     {
                        for each(subAreaId in subAreasIds)
                        {
                           this.showSearchSubArea(subAreaId);
                        }
                     }
                  }
                  showAreaShape(SEARCH_AREAS,true);
                  mapViewer.updateMapElements();
                  break;
               case HINT_GROUP_SEARCH_TYPE:
                  for each(hint in item.data)
                  {
                     mapViewer.addIcon(SEARCH_HINTS,"search_hint" + hint.id,__hintIconsRootPath + hint.gfx + ".png",hint.x,hint.y,__iconScale,hint.name,true);
                  }
                  mapViewer.updateMapElements();
            }
         }
         else if(target == this.gdSearchAll && (method == SelectMethodEnum.MANUAL || method == SelectMethodEnum.AUTO))
         {
            this._addEntryHighlight = true;
            this.gdSearchAll.updateItem(this.gdSearchAll.selectedIndex);
         }
         else if(item && item is AreaGroup && (item.type == "areaShape" || item.type == "dungeon"))
         {
            if(this._lastLayer != item.layer)
            {
               this.updateLayerAreaShapes(item.layer);
            }
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var currentMapElement:String = null;
         var subArea:SubArea = null;
         var anomaly:MapIconElement = null;
         var coord:MapPosition = null;
         var prismInfo:PrismSubAreaWrapper = null;
         var alliance:AllianceWrapper = null;
         var tooltipText:* = null;
         var mapElement:MapIconElement = null;
         uiApi.hideTooltip();
         if(item.data && item.data.data && item.data.type == "subarea")
         {
            subArea = item.data.data;
            currentMapElement = "shape" + subArea.id;
            if(currentMapElement != __lastHighlightElement)
            {
               __lastHighlightElement = currentMapElement;
               rollOverMapAreaShape(__lastHighlightElement);
               if(item.data.hasAnomaly)
               {
                  __lastHighlightAnomaly = "anomaly_" + subArea.id;
                  anomaly = mapViewer.getMapElement(__lastHighlightAnomaly) as MapIconElement;
                  if(anomaly)
                  {
                     anomaly.highlight(true);
                  }
                  coord = subArea.zaapMapPosition;
                  uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.zaap.associatedZaap") + " : " + subArea.name + " [" + coord.posX + "," + coord.posY + "]"),item.container,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP);
               }
            }
            if(this._conquestMode)
            {
               prismInfo = socialApi.getPrismSubAreaById(subArea.id);
               if(prismInfo && (prismInfo.mapId != -1 || prismInfo.alliance))
               {
                  alliance = !prismInfo.alliance ? socialApi.getAlliance() : prismInfo.alliance;
                  tooltipText = "[" + alliance.allianceTag + "]";
                  if(prismInfo.state == PrismStateEnum.PRISM_STATE_WEAKENED || prismInfo.state == PrismStateEnum.PRISM_STATE_SABOTAGED)
                  {
                     tooltipText += " " + uiApi.getText("ui.prism.startVulnerability") + uiApi.getText("ui.common.colon") + timeApi.getDate(prismInfo.nextVulnerabilityDate * 1000) + " " + prismInfo.vulnerabilityHourString;
                  }
                  uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),item.container,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"ConquestPrismInfo");
               }
            }
         }
         else if(item.data && item.data.data && item.data.type == "dungeon")
         {
            currentMapElement = "dungeon_" + item.data.data.id;
            if(currentMapElement != __lastHighlightElement)
            {
               __lastHighlightElement = currentMapElement;
               mapElement = mapViewer.getMapElement(__lastHighlightElement) as MapIconElement;
               if(mapElement)
               {
                  mapElement.highlight(true);
               }
            }
         }
         else
         {
            __lastHighlightElement = "";
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         var anomaly:MapIconElement = null;
         var mapElement:MapIconElement = null;
         if(__lastHighlightElement.indexOf("shape") != -1)
         {
            rollOutMapAreaShape(__lastHighlightElement);
            if(__lastHighlightAnomaly)
            {
               anomaly = mapViewer.getMapElement(__lastHighlightAnomaly) as MapIconElement;
               if(anomaly)
               {
                  anomaly.highlight(false);
               }
               __lastHighlightAnomaly = "";
            }
         }
         else if(__lastHighlightElement.indexOf("dungeon") != -1)
         {
            mapElement = mapViewer.getMapElement(__lastHighlightElement) as MapIconElement;
            if(mapElement)
            {
               mapElement.highlight(false);
            }
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var width:int = 0;
         var sector:BreachWorldMapSector = null;
         super.onRollOver(target);
         var point:uint = LocationEnum.POINT_BOTTOM;
         var relPoint:uint = LocationEnum.POINT_TOP;
         var maxWidth:int = 400;
         switch(target)
         {
            case this.btn_player:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               tooltipText = uiApi.getText("ui.map.player");
               break;
            case this.btnReward:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               if(!this._rewardMode)
               {
                  tooltipText = uiApi.getText("ui.map.showLoot");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.map.hideLoot");
               }
               break;
            case this.btnConquest:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               if(!this._conquestMode)
               {
                  tooltipText = uiApi.getText("ui.map.showConquest");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.map.hideConquest");
               }
               break;
            case this.btnBestiary:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               tooltipText = uiApi.getText("ui.common.bestiary");
               break;
            case btn_zoomIn:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               tooltipText = uiApi.getText("ui.common.zoomin");
               break;
            case btn_zoomOut:
               point = LocationEnum.POINT_BOTTOMRIGHT;
               relPoint = LocationEnum.POINT_TOPRIGHT;
               tooltipText = uiApi.getText("ui.common.zoomout");
               break;
            case this.btnFilterTemple:
            case this.btnFilterBidHouse:
            case this.btnFilterCraftHouse:
            case this.btnFilterMisc:
            case this.btnFilterConquest:
            case this.btnFilterDungeon:
            case this.btnFilterPrivate:
            case this.btnFilterFlags:
            case this.btnFilterTransport:
            case this.btnFilterQuest:
            case this.btnFilterAnomaly:
            case this.btnFilterAll:
            case this.tx_filter_bg:
               width = uiApi.me().getConstant("filter_menu_opened_width");
               this.tx_filter_bg.width = width;
               this.setLblFilterWidth(width - 50);
               this.lblbtnFilterFlags.text = uiApi.getText("ui.cartography.flags");
               this.lblbtnFilterPrivate.text = uiApi.getText("ui.common.possessions");
               this.lblbtnFilterTemple.text = uiApi.getText("ui.map.temple");
               this.lblbtnFilterBidHouse.text = uiApi.getText("ui.map.bidHouse");
               this.lblbtnFilterCraftHouse.text = uiApi.getText("ui.map.craftHouse");
               this.lblbtnFilterMisc.text = uiApi.getText("ui.common.misc");
               this.lblbtnFilterTransport.text = uiApi.getText("ui.cartography.transport");
               this.lblbtnFilterConquest.text = uiApi.getText("ui.map.conquest");
               this.lblbtnFilterDungeon.text = uiApi.getText("ui.map.dungeon");
               this.lblbtnFilterQuest.text = uiApi.getText("ui.cartography.availableQuests");
               this.lblbtnFilterAnomaly.text = uiApi.getText("ui.common.anomalies");
               this.lblbtnFilterAll.text = !!this.btnFilterAll.selected ? uiApi.getText("ui.map.hideAll") : uiApi.getText("ui.map.displayAll");
               break;
            case this.gdSearchAll:
            case this.ctr_search_bg:
            case this.ctr_quantity:
               rollOutMapAreaShape(__lastHighlightElement);
               if(target == this.ctr_quantity)
               {
                  tooltipText = uiApi.getText("ui.search.resourceEstimatedQuantity");
                  maxWidth = 500;
               }
               break;
            default:
               if(target.name.indexOf("btn_breachSector") != -1)
               {
                  sector = this._componentList[target.name];
                  this.highlightBreachZone(sector.id);
               }
         }
         if(target.name.indexOf("tx_itemType") != -1 && (target as Texture).uri)
         {
            if((target as Texture).uri.fileName == "success_cat_5.png")
            {
               tooltipText = uiApi.getText("ui.common.collectableResource");
            }
            else if((target as Texture).uri.fileName == "success_cat_6.png")
            {
               tooltipText = uiApi.getText("ui.common.questItem");
            }
         }
         if(tooltipText)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText,null,null,maxWidth),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         var hintUri:String = null;
         var mapElement:MapElement = null;
         var coordinate:BreachWorldMapCoordinate = null;
         var breachIconId:int = 0;
         super.onRollOut(target);
         switch(target)
         {
            case this.btnBestiary:
            case this.btnReward:
            case this.btnConquest:
               break;
            case this.btnFilterTemple:
            case this.btnFilterBidHouse:
            case this.btnFilterCraftHouse:
            case this.btnFilterMisc:
            case this.btnFilterConquest:
            case this.btnFilterDungeon:
            case this.btnFilterPrivate:
            case this.btnFilterFlags:
            case this.btnFilterTransport:
            case this.btnFilterQuest:
            case this.btnFilterAnomaly:
            case this.btnFilterAll:
            case this.tx_filter_bg:
               this.tx_filter_bg.width = uiApi.me().getConstant("filter_menu_closed_width");
               this.lblbtnFilterFlags.text = "";
               this.lblbtnFilterPrivate.text = "";
               this.lblbtnFilterTemple.text = "";
               this.lblbtnFilterBidHouse.text = "";
               this.lblbtnFilterCraftHouse.text = "";
               this.lblbtnFilterMisc.text = "";
               this.lblbtnFilterTransport.text = "";
               this.lblbtnFilterConquest.text = "";
               this.lblbtnFilterDungeon.text = "";
               this.lblbtnFilterQuest.text = "";
               this.lblbtnFilterAnomaly.text = "";
               this.lblbtnFilterAll.text = "";
               this.setLblFilterWidth(1);
               break;
            default:
               if(target.name.indexOf("btn_breachSector") != -1)
               {
                  hintUri = uiApi.me().getConstant("hintIcons");
                  for each(mapElement in mapViewer.getMapElementsByLayer(MAP_LAYER_BREACH_HIGHLIGHT))
                  {
                     mapViewer.removeMapElement(mapElement);
                  }
                  for each(coordinate in dataApi.getAllBreachWorldMapCoordinate())
                  {
                     breachIconId = this.getBreachIconByFloor(coordinate);
                     if(!mapViewer.getMapElement("breachIcon_" + coordinate.mapStage + "hightlight") && breachIconId > 0)
                     {
                        mapViewer.addBreachIcon(MAP_LAYER_BREACH_HIGHLIGHT,"breachIcon_" + coordinate.mapStage + "highlight",hintUri + breachIconId + ".png",coordinate.mapCoordinateX,coordinate.mapCoordinateY,1.5,coordinate.mapStage < 200 ? uiApi.getText("ui.breach.floors",breachMinStage,coordinate.mapStage) : uiApi.getText("ui.breach.floor",coordinate.mapStage),false,-1,false,HintPriorityEnum.FLAGS);
                     }
                  }
                  mapViewer.updateMapElements();
               }
         }
      }
      
      override protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean) : void
      {
         var btn:* = undefined;
         super.onMapHintsFilter(layerId,displayed,fromCartography);
         if(!fromCartography)
         {
            for(btn in this._filterCat)
            {
               if(this._filterCat[btn] == "layer_" + layerId)
               {
                  btn.selected = displayed;
               }
            }
         }
      }
      
      override protected function toggleHints() : void
      {
         var btn:* = undefined;
         super.toggleHints();
         var allLayersVisible:Boolean = mapViewer.allLayersVisible;
         for(btn in this._filterCat)
         {
            btn.selected = allLayersVisible;
         }
      }
      
      override public function onFocusChange(pTarget:Object) : void
      {
         super.onFocusChange(pTarget);
         if(pTarget && this.gdSearchAll.visible && pTarget != this.tiSearch && (!pTarget || !(this.gdSearchAll as Object).contains(pTarget)))
         {
            this.onRelease(this.btn_closeSearch);
         }
      }
      
      public function updateSearchEntryLine(result:Object, components:*, selected:Boolean) : void
      {
         components.btn_line.y = 1;
         if(result)
         {
            if(this._removeEntryHighlight)
            {
               components.btn_line.state = StatesEnum.STATE_NORMAL;
               this._removeEntryHighlight = false;
               return;
            }
            if(this._addEntryHighlight)
            {
               components.btn_line.state = StatesEnum.STATE_OVER;
               this._addEntryHighlight = false;
               return;
            }
            components.btn_line.state = StatesEnum.STATE_NORMAL;
            if(result.uri)
            {
               components.tx_result_icon.x = components.tx_result_icon.y = 5;
               components.tx_result_icon.uri = uiApi.createUri(result.uri);
            }
            components.lbl_result_name.text = result.label;
            if(result.typeUri)
            {
               components.tx_itemType.uri = uiApi.createUri(result.typeUri);
            }
            else
            {
               components.tx_itemType.uri = null;
            }
         }
         else
         {
            components.btn_line.state = StatesEnum.STATE_NORMAL;
            components.tx_result_icon.uri = null;
            components.lbl_result_name.text = "";
            components.tx_itemType.uri = null;
         }
      }
      
      override public function onMapRollOver(pTarget:MapViewer, pX:int, pY:int, pSearchSubArea:SubArea = null) : void
      {
         var searchSubArea:SubArea = null;
         var hintSubArea:SubArea = null;
         var subAreaName:String = null;
         var subAreaInfo:Array = null;
         var searchInfo:String = null;
         if(this._searchSelectedItem && (this._searchSelectedItem.type == MONSTER_SEARCH_TYPE || this._searchSelectedItem.type == ITEM_SEARCH_TYPE))
         {
            subAreaInfo = getSubAreaFromCoords(pX,pY);
            if(subAreaInfo && mapViewer.getMapElement("search_shape" + subAreaInfo[0].id))
            {
               searchSubArea = subAreaInfo[0];
               subAreaName = subAreaInfo[1];
            }
            if(__currentMapElement)
            {
               if(__currentMapElement.id.indexOf("search_hint") != -1)
               {
                  hintSubArea = dataApi.getSubArea(__currentMapElement.id.split("search_hint")[1]);
               }
            }
         }
         super.onMapRollOver(pTarget,pX,pY,searchSubArea);
         var searchSubAreaText:String = "";
         if(searchSubArea && !hintSubArea)
         {
            searchInfo = this._lastSearchSubAreaId == searchSubArea.id ? this._lastSearchSubAreaInfo : null;
            if(!searchInfo)
            {
               searchInfo = this.getSubAreaInfoStr(searchSubArea,subAreaName);
               this._lastSearchSubAreaId = searchSubArea.id;
               this._lastSearchSubAreaInfo = searchInfo;
            }
            searchSubAreaText += searchInfo;
         }
         if(hintSubArea)
         {
            searchSubAreaText += this.getSubAreaInfoStr(hintSubArea,hintSubArea.name);
         }
         if(searchSubArea || hintSubArea)
         {
            tooltipApi.update("cartographyCurrentSubArea","search",this._searchSelectedItem,null,searchSubAreaText);
         }
      }
      
      override public function onCloseUi(pShortCut:String) : Boolean
      {
         if(this.gdSearchAll.visible)
         {
            this.onRelease(this.btn_closeSearch);
            sysApi.removeFocus();
            return true;
         }
         return super.onCloseUi(pShortCut);
      }
      
      public function traceShortcuts() : void
      {
         var shortcuts:Array = null;
         var i:int = 0;
         var shortcut:Object = null;
         if(mapViewer.hasLayer("shortcuts"))
         {
            __layersToShow["shortcuts"] = MapApi.DEBUG_WORLD_GRAPH_SHORTCUTS;
         }
         else if(MapApi.DEBUG_WORLD_GRAPH_SHORTCUTS)
         {
            mapViewer.addLayer("shortcuts");
            __layersToShow["shortcuts"] = true;
            shortcuts = mapApi.getShortcuts(_currentWorldId);
            i = 0;
            for each(shortcut in shortcuts)
            {
               mapViewer.addLine("shortcuts",(i++).toString(),shortcut.from.posX,shortcut.from.posY,shortcut.to.posX,shortcut.to.posY,"\\\\bise\\dofus2-resources\\content\\gfx\\icons\\hintsShadow\\flag.png","[" + shortcut.from.posX + "," + shortcut.from.posY + "] > [" + shortcut.to.posX + "," + shortcut.to.posY + "] | " + shortcut.from.id + "|" + shortcut.fromRp + (!!shortcut.from.outdoor ? "" : "(indoor)") + " > " + shortcut.to.id + "|" + shortcut.toRp + (!!shortcut.to.outdoor ? "" : "(indoor)") + " | " + shortcut.transitionText);
            }
         }
         mapViewer.showLayer("shortcuts",MapApi.DEBUG_WORLD_GRAPH_SHORTCUTS);
         mapViewer.updateMapElements();
         mapViewer.updateIconSize(true);
      }
      
      private function setLblFilterWidth(width:Number) : void
      {
         this.lblbtnFilterFlags.width = width;
         this.lblbtnFilterPrivate.width = width;
         this.lblbtnFilterTemple.width = width;
         this.lblbtnFilterBidHouse.width = width;
         this.lblbtnFilterCraftHouse.width = width;
         this.lblbtnFilterMisc.width = width;
         this.lblbtnFilterTransport.width = width;
         this.lblbtnFilterConquest.width = width;
         this.lblbtnFilterDungeon.width = width;
         this.lblbtnFilterQuest.width = width;
         this.lblbtnFilterAnomaly.width = width;
         this.lblbtnFilterAll.width = width;
      }
      
      private function someFilterSelected() : Boolean
      {
         return this.btnFilterTemple.selected || this.btnFilterBidHouse.selected || this.btnFilterCraftHouse.selected || this.btnFilterMisc.selected || this.btnFilterConquest.selected || this.btnFilterDungeon.selected || this.btnFilterPrivate.selected || this.btnFilterFlags.selected || this.btnFilterAnomaly.selected || this.btnFilterQuest.selected || this.btnFilterTransport.selected;
      }
      
      private function switchTo() : void
      {
         this.tiSearch.text = "";
         this.btn_closeSearch.visible = false;
         this.ctr_locTree.visible = this._conquestMode || this._rewardMode;
         this.currentTabName = !!this._conquestMode ? "ctr_locTree_conquest_content" : (!!this._rewardMode ? "ctr_locTree_reward_content" : "");
         this.switchMode();
      }
      
      private function switchMode() : void
      {
         __areaShapeDisplayed = [];
         __lastHighlightElement = "";
         if(this._conquestMode || this._rewardMode)
         {
            this.onRelease(this.btn_closeSearch);
            if(this._conquestMode)
            {
               if(this._updateConquestAreas)
               {
                  this.updateConquestSubarea();
               }
               this._dataProvider = __allAreas;
               this.showHints(this._hintCategoryFiltersListConquest);
               this.cbx_territory_type.dataProvider = this._gdConquestProvider.concat();
               this.lbl_title.text = uiApi.getText("ui.common.territory") + " (" + __allAreas.children.length + ")";
            }
            else if(this._rewardMode)
            {
               if(this._updateRewardAreas)
               {
                  this.updateRewardSubarea();
               }
               this._dataProvider = __allRewardAreas;
               this.showHints(this._hintCategoryFiltersListReward);
               this.cbx_territory_type.dataProvider = this._gdRewardProvider.concat();
               this.lbl_title.text = uiApi.getText("ui.common.rewards");
            }
            this.cbx_territory_type.selectedIndex = 0;
            this.searchFilter();
            this._lastLayer = ALL_AREAS;
            this.showConquestAreaShapes(ALL_AREAS,false);
            this.showConquestAreaShapes(ALL_AREAS,true);
         }
         else
         {
            this._lastLayer = "";
            this.showConquestAreaShapes(ALL_AREAS,false);
            this.showHints(__hintCategoryFiltersList);
         }
         this.showDungeonFilter(this.btnFilterDungeon.selected);
         mapViewer.updateMapElements();
      }
      
      private function showDungeonFilter(show:Boolean) : void
      {
         mapViewer.showLayer(this._filterCat[this.btnFilterDungeon],show && !this._rewardMode);
         mapViewer.showLayer(BONUS_DUNGEONS,show && this._rewardMode && (!this._lastLayer || this._lastLayer == ALL_AREAS || this._lastLayer == BONUS_DUNGEONS));
         mapViewer.showLayer(MALUS_DUNGEONS,show && this._rewardMode && (!this._lastLayer || this._lastLayer == ALL_AREAS || this._lastLayer == MALUS_DUNGEONS));
      }
      
      private function showConquestAreaShapes(pLayer:String, show:Boolean = true) : void
      {
         if(pLayer == ALL_AREAS)
         {
            if(this._conquestMode || !show)
            {
               showAreaShape(NORMAL_AREAS,show);
               showAreaShape(WEAKENED_AREAS,show);
               showAreaShape(VULNERABLE_AREAS,show);
               showAreaShape(VILLAGES_AREAS,show);
               showAreaShape(CAPTURABLE_AREAS,show);
               showAreaShape(SABOTAGED_AREAS,show);
            }
            if(this._rewardMode || !show)
            {
               showAreaShape(BONUS_AREAS,show);
               showAreaShape(MALUS_AREAS,show);
               showAreaShape(ANOMALY_AREAS,show);
            }
         }
         else
         {
            showAreaShape(pLayer,show);
         }
      }
      
      private function updateLayerAreaShapes(pLayer:String) : void
      {
         var layer:String = null;
         var nb:int = 0;
         var k:int = 0;
         this._lastLayer = pLayer;
         var lastAreaShapeDisplayed:Array = __areaShapeDisplayed;
         __areaShapeDisplayed = [];
         if(pLayer == MALUS_DUNGEONS || pLayer == BONUS_DUNGEONS)
         {
            mapViewer.showLayer(MALUS_DUNGEONS,pLayer == MALUS_DUNGEONS);
            mapViewer.showLayer(BONUS_DUNGEONS,pLayer == BONUS_DUNGEONS);
            for each(layer in lastAreaShapeDisplayed)
            {
               showAreaShape(layer,false);
            }
         }
         else
         {
            mapViewer.showLayer(MALUS_DUNGEONS,pLayer == ALL_AREAS);
            mapViewer.showLayer(BONUS_DUNGEONS,pLayer == ALL_AREAS);
            this.showConquestAreaShapes(pLayer);
            nb = lastAreaShapeDisplayed.length;
            for(k = 0; k < nb; k++)
            {
               if(__areaShapeDisplayed.indexOf(lastAreaShapeDisplayed[k]) == -1)
               {
                  showAreaShape(lastAreaShapeDisplayed[k],false);
               }
            }
         }
         mapViewer.updateMapElements();
      }
      
      private function addAreaShapesFromData(pData:AreaGroup) : void
      {
         var alliance:AllianceWrapper = null;
         var areaInfo:AreaInfo = null;
         var sa:SubArea = null;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         for each(areaInfo in pData.children)
         {
            sa = areaInfo.data;
            prismSubAreaInfo = socialApi.getPrismSubAreaById(sa.id);
            if(prismSubAreaInfo && prismSubAreaInfo.mapId != -1)
            {
               alliance = !prismSubAreaInfo.alliance ? socialApi.getAlliance() : prismSubAreaInfo.alliance;
               mapViewer.addAreaShape(pData.layer,"shape" + sa.id,mapApi.getSubAreaShape(sa.id),alliance.backEmblem.color,0.6,alliance.backEmblem.color,0.4,4);
            }
         }
      }
      
      protected function updateRewardSubareaStatus(subArea:SubArea, percent:int, infoType:String, hasAnomaly:Boolean) : void
      {
         var uri:String = null;
         var areaGroup:AreaGroup = null;
         var dungeonId:int = 0;
         var iconUri:* = null;
         var dungeon:Dungeon = null;
         var pos:MapPosition = null;
         var legend:* = null;
         if(!subArea || !subArea.name || !subArea.worldmap)
         {
            return;
         }
         if(infoType == "dungeon")
         {
            uri = "icon_simple_dungeon_uri";
         }
         else
         {
            uri = "icon_simple_chest_uri";
         }
         var currentAreaInfo:AreaInfo = new AreaInfo(subArea.name,infoType,uri,__allRewardAreas,subArea,_textCss,"bonus",percent,hasAnomaly);
         this.addAreaInfo(__allRewardAreas,currentAreaInfo);
         var color:int = uiApi.me().getConstant(!!hasAnomaly ? "anomaly_areas_color" : (percent > 0 ? "bonus_areas_color" : "malus_areas_color"));
         switch(infoType)
         {
            case "subarea":
               if(percent > 0)
               {
                  areaGroup = __bonusAreas;
               }
               else
               {
                  areaGroup = __malusAreas;
               }
               if(hasAnomaly)
               {
                  this.addAreaInfo(areaGroup,currentAreaInfo);
                  areaGroup = __anomalyAreas;
               }
               this.addAreaInfo(areaGroup,currentAreaInfo);
               if(subArea.worldmap.id == _currentWorldId)
               {
                  mapViewer.addAreaShape(areaGroup.layer,"shape" + subArea.id,mapApi.getSubAreaShape(subArea.id),color,0.6,color,0.4,4,false);
               }
               break;
            case "dungeon":
               dungeonId = mapApi.isDungeonSubArea(subArea.id);
               if(dungeonId != -1)
               {
                  if(percent > 0)
                  {
                     areaGroup = __bonusDungeon;
                     iconUri = sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterDungeon_On_Green.png";
                  }
                  else
                  {
                     areaGroup = __malusDungeon;
                     iconUri = sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterDungeon_On.png";
                  }
                  this.addAreaInfo(areaGroup,currentAreaInfo);
                  dungeon = dataApi.getDungeon(dungeonId);
                  pos = mapApi.getMapPositionById(dungeon.entranceMapId);
                  legend = subArea.name + " (" + uiApi.getText("ui.common.short.level") + " " + dungeon.optimalPlayerLevel + ")";
                  if(subArea.worldmap.id == _currentWorldId)
                  {
                     mapViewer.addIcon(areaGroup.layer,"dungeon_" + subArea.id,iconUri,pos.posX,pos.posY,1,legend,false,-1,true,true,null,true,false,HintPriorityEnum.DUNGEONS);
                  }
               }
         }
      }
      
      private function updateRewardSubarea() : void
      {
         var subInfo:AnomalySubareaInformation = null;
         var group:AreaGroup = null;
         var subArea:SubArea = null;
         var dungeonId:int = 0;
         var infoType:String = null;
         if(!__allRewardAreas)
         {
            this._gdRewardProvider = new Vector.<AreaGroup>(0);
            __allRewardAreas = new AreaGroup(uiApi.getText("ui.map.allTerritories"),"areaShape","icon_simple_chest_uri",ALL_AREAS,"all_areas_color");
            __bonusAreas = new AreaGroup(uiApi.getText("ui.common.territory") + " (" + uiApi.getText("ui.common.bonus") + ")","areaShape","icon_simple_chest_uri",BONUS_AREAS,"capturable_areas_color");
            __malusAreas = new AreaGroup(uiApi.getText("ui.common.territory") + " (" + uiApi.getText("ui.common.malus") + ")","areaShape","icon_simple_chest_uri",MALUS_AREAS,"normal_areas_color");
            __bonusDungeon = new AreaGroup(uiApi.getText("ui.map.dungeon") + " (" + uiApi.getText("ui.common.bonus") + ")","dungeon","icon_simple_dungeon_uri",BONUS_DUNGEONS,"capturable_areas_color");
            __malusDungeon = new AreaGroup(uiApi.getText("ui.map.dungeon") + " (" + uiApi.getText("ui.common.malus") + ")","dungeon","icon_simple_dungeon_uri",MALUS_DUNGEONS,"normal_areas_color");
            __anomalyAreas = new AreaGroup(uiApi.getText("ui.common.anomalies"),"areaShape","icon_simple_anomaly_uri",ANOMALY_AREAS,"normal_areas_color");
            this._gdRewardProvider.push(__allRewardAreas);
            this._gdRewardProvider.push(__bonusAreas);
            this._gdRewardProvider.push(__malusAreas);
            this._gdRewardProvider.push(__bonusDungeon);
            this._gdRewardProvider.push(__malusDungeon);
            this._gdRewardProvider.push(__anomalyAreas);
         }
         for each(subInfo in __subAreasInfos)
         {
            subArea = mapApi.getSubArea(subInfo.subAreaId);
            if(subArea)
            {
               dungeonId = mapApi.isDungeonSubArea(subArea.id);
               infoType = dungeonId == -1 ? "subarea" : "dungeon";
               this.updateRewardSubareaStatus(subArea,subInfo.rewardRate,infoType,subInfo.hasAnomaly);
            }
         }
         for each(group in this._gdRewardProvider)
         {
            group.children.sort(this.compareSubAreaItem);
         }
         this._updateRewardAreas = false;
      }
      
      private function updateConquestSubarea(pUpdateConquestModeData:Boolean = true) : void
      {
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var group:AreaGroup = null;
         if(!__conquestSubAreasInfos)
         {
            return;
         }
         if(!__allAreas)
         {
            this._gdConquestProvider = new Vector.<AreaGroup>(0);
            __allAreas = new AreaGroup(uiApi.getText("ui.pvp.conquestAllAreas"),"areaShape","icon_multi_prism_uri",ALL_AREAS,"all_areas_color");
            __normalAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.normal"),"areaShape","icon_simple_prism_uri",NORMAL_AREAS,"normal_areas_color");
            __weakenedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.weakened"),"areaShape","icon_simple_prism_uri",WEAKENED_AREAS,"weakened_areas_color");
            __vulnerableAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.vulnerable"),"areaShape","icon_simple_prism_uri",VULNERABLE_AREAS,"vulnerable_areas_color");
            __capturableAreas = new AreaGroup(uiApi.getText("ui.pvp.conquestCapturableAreas"),"areaShape","icon_simple_prism_uri",CAPTURABLE_AREAS,"capturable_areas_color");
            __sabotagedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.sabotaged"),"areaShape","icon_simple_prism_uri",SABOTAGED_AREAS,"sabotaged_areas_color");
            this._gdConquestProvider.push(__allAreas);
            this._gdConquestProvider.push(__capturableAreas);
            this._gdConquestProvider.push(__normalAreas);
            this._gdConquestProvider.push(__weakenedAreas);
            this._gdConquestProvider.push(__vulnerableAreas);
            this._gdConquestProvider.push(__sabotagedAreas);
         }
         for each(prismSubAreaInfo in __conquestSubAreasInfos)
         {
            updatePrismAndSubareaStatus(prismSubAreaInfo,pUpdateConquestModeData);
         }
         for each(group in this._gdConquestProvider)
         {
            group.children.sort(this.compareSubAreaItem);
         }
         if(__weakenedAreas.children.length > 0)
         {
            __weakenedAreas.children.sortOn("vulnerabilityDate");
         }
         this._updateConquestAreas = false;
      }
      
      private function compareSubAreaItem(pItemA:AreaInfo, pItemB:AreaInfo) : int
      {
         var labelA:String = utilApi.noAccent(pItemA.label);
         var labelB:String = utilApi.noAccent(pItemB.label);
         if(labelA > labelB)
         {
            return 1;
         }
         if(labelA < labelB)
         {
            return -1;
         }
         return 0;
      }
      
      private function searchFilter() : void
      {
         var grid:Grid = null;
         if(this._conquestMode)
         {
            grid = this.gdZone;
         }
         else
         {
            if(!this._rewardMode)
            {
               return;
            }
            grid = this.gdZoneReward;
         }
         if(this._searchCriteria)
         {
            this._searchCriteria = utilApi.noAccent(this._searchCriteria).toLowerCase();
            grid.dataProvider = this.filterSubArea(this._searchCriteria,this._dataProvider.children);
         }
         else
         {
            grid.dataProvider = this._dataProvider.children;
         }
         this.showOnlyCurrentMapSubareas();
      }
      
      private function filterSubArea(searchedText:String, a:Array) : Array
      {
         var item:AreaInfo = null;
         var res:Array = [];
         for each(item in a)
         {
            if(utilApi.noAccent(item.label).toLowerCase().indexOf(searchedText) != -1)
            {
               res.push(item);
            }
         }
         return res;
      }
      
      override protected function showHints(pFiltersList:Array) : void
      {
         super.showHints(pFiltersList);
         this.btnFilterTemple.selected = pFiltersList[1];
         this.btnFilterBidHouse.selected = pFiltersList[2];
         this.btnFilterCraftHouse.selected = pFiltersList[3];
         this.btnFilterMisc.selected = pFiltersList[4];
         this.btnFilterConquest.selected = pFiltersList[5];
         this.btnFilterDungeon.selected = pFiltersList[6];
         this.btnFilterPrivate.selected = pFiltersList[7];
         this.btnFilterFlags.selected = pFiltersList[8];
         this.btnFilterTransport.selected = pFiltersList[9];
         this.btnFilterAnomaly.selected = pFiltersList[10];
         this.btnFilterQuest.selected = pFiltersList[11];
      }
      
      private function onSortSubarea(pSortType:uint, newDataProvider:Boolean = false) : void
      {
         var grid:Grid = null;
         var subareaItem:AreaInfo = null;
         if(this._conquestMode)
         {
            grid = this.gdZone;
         }
         else
         {
            if(!this._rewardMode)
            {
               return;
            }
            grid = this.gdZoneReward;
         }
         if(pSortType == SORT_BY_VULNERABILITY_DATE)
         {
            for each(subareaItem in grid.dataProvider)
            {
               subareaItem.sortLabel = subareaItem.data.undiatricalName;
               subareaItem.vulnerabilityDate = socialApi.getPrismSubAreaById(subareaItem.data.id).nextVulnerabilityDate;
            }
         }
         if(!newDataProvider && this.currentSorting == pSortType)
         {
            grid.dataProvider.reverse();
         }
         else if(pSortType == SORT_BY_NAME)
         {
            utilApi.sortOnString(grid.dataProvider,"label");
         }
         else if(pSortType == SORT_BY_VULNERABILITY_DATE)
         {
            grid.dataProvider.sortOn(["vulnerabilityDate","sortLabel"],[Array.NUMERIC]);
         }
         else if(pSortType == SORT_BY_PERCENT)
         {
            grid.dataProvider.sortOn("percent",Array.DESCENDING | Array.NUMERIC);
         }
         grid.updateItems();
         this.currentSorting = pSortType;
      }
      
      public function showOnlyCurrentMapSubareas() : void
      {
         if(!this._rewardMode)
         {
            return;
         }
         if(!this._showOnlyCurrentMapSubareas)
         {
            this.gdZoneReward.dataProvider = this._dataProvider.children;
         }
         else
         {
            this.gdZoneReward.dataProvider = this.gdZoneReward.dataProvider.filter(function(area:AreaInfo, index:int, array:Array):Boolean
            {
               return area.data.worldmap.id == _currentWorldId;
            });
         }
      }
      
      private function searchAll(pSearch:String) : void
      {
         var result:Object = null;
         var searchIndex:int = 0;
         var height:Number = NaN;
         var resultsText:String = null;
         if(pSearch && pSearch.length > 0)
         {
            result = mapApi.getSearchAllResults(pSearch);
            this._hasResultsInOtherWorldMap = result.hasResultsInOtherWorldMap;
            if(this._perceptorsHintGroup && this._perceptorsHintGroup.data.length > 0)
            {
               searchIndex = utilApi.noAccent(this._perceptorsHintGroup.name).toLowerCase().indexOf(utilApi.noAccent(pSearch).toLowerCase());
               if(searchIndex != -1)
               {
                  this._perceptorsHintGroup.label = this._perceptorsHintGroup.name.substring(0,searchIndex) + "<b>" + this._perceptorsHintGroup.name.substring(searchIndex,pSearch.length) + "</b>" + this._perceptorsHintGroup.name.substring(searchIndex + pSearch.length);
                  result.results.push(this._perceptorsHintGroup);
               }
            }
            if(this._prismsHintGroup && this._prismsHintGroup.data.length > 0)
            {
               searchIndex = utilApi.noAccent(this._prismsHintGroup.name).toLowerCase().indexOf(utilApi.noAccent(pSearch).toLowerCase());
               if(searchIndex != -1)
               {
                  this._prismsHintGroup.label = this._prismsHintGroup.name.substring(0,searchIndex) + "<b>" + this._prismsHintGroup.name.substring(searchIndex,pSearch.length) + "</b>" + this._prismsHintGroup.name.substring(searchIndex + pSearch.length);
                  result.results.push(this._prismsHintGroup);
               }
            }
            height = result.results.length * uiApi.me().getConstant("gdSearchAll_slot_height");
            this.gdSearchAll.finalized = false;
            this.gdSearchAll.height = height > uiApi.me().getConstant("gdSearchAll_max_height") ? Number(uiApi.me().getConstant("gdSearchAll_max_height")) : Number(height);
            this.gdSearchAll.dataProvider = result.results;
            this.gdSearchAll.selectedIndex = 0;
            this.ctr_search_bg.height = this.gdSearchAll.height + this.gdSearchAll.slotHeight;
            this.ctr_search_bg.width = this.gdSearchAll.height == uiApi.me().getConstant("gdSearchAll_max_height") ? Number(this.gdSearchAll.width) : Number(this.gdSearchAll.slotWidth);
            if(this.gdSearchAll.dataProvider.length == 0)
            {
               this.lbl_results.text = !this._hasResultsInOtherWorldMap ? uiApi.getText("ui.search.noResult") : uiApi.getText("ui.search.resultsInOtherWorldMap");
            }
            else
            {
               resultsText = uiApi.processText(uiApi.getText("ui.search.results",this.gdSearchAll.dataProvider.length),"n",this.gdSearchAll.dataProvider.length <= 1,this.gdSearchAll.dataProvider.length == 0);
               if(this._hasResultsInOtherWorldMap)
               {
                  resultsText += "\n" + uiApi.getText("ui.search.resultsInOtherWorldMap");
               }
               this.lbl_results.text = resultsText;
            }
            this.lbl_results.y = this.ctr_search_bg.height - this.lbl_results.textHeight - (this.gdSearchAll.slotHeight / 2 - this.lbl_results.textHeight / 2) - 4;
            this.tx_bg_results.y = this.ctr_search_bg.height;
            this.gdSearchAll.visible = this.ctr_search_bg.visible = true;
            this._lastSearch = pSearch;
         }
         else
         {
            this.gdSearchAll.visible = this.ctr_search_bg.visible = false;
         }
      }
      
      private function getSubAreaInfoStr(pSubArea:SubArea, pSubAreaName:String) : String
      {
         var i:int = 0;
         var j:int = 0;
         var len:int = 0;
         var itemQty:uint = 0;
         var monsterId:int = 0;
         var numSubAreas:int = 0;
         var endIndex:int = 0;
         var searchInfo:String = "";
         if(this._searchSelectedItem.resourceSubAreaIds)
         {
            len = this._searchSelectedItem.resourceSubAreaIds.length;
            for(i = 0; i < len; i += 2)
            {
               if(this._searchSelectedItem.resourceSubAreaIds[i] == pSubArea.id)
               {
                  itemQty = this._searchSelectedItem.resourceSubAreaIds[i + 1];
                  break;
               }
            }
            searchInfo += uiApi.getText("ui.common.quantity") + uiApi.getText("ui.common.colon") + itemQty;
         }
         else if(this._searchSelectedItem.type == ITEM_SEARCH_TYPE && this._searchSelectedItem.subAreasIds)
         {
            len = this._searchSelectedItem.subAreasIds.length;
            for(i = 0; i < len; i += 2)
            {
               monsterId = this._searchSelectedItem.subAreasIds[i];
               numSubAreas = this._searchSelectedItem.subAreasIds[i + 1];
               endIndex = i + 2 + numSubAreas;
               for(j = i + 2; j < endIndex; j++)
               {
                  if(this._searchSelectedItem.subAreasIds[j] == pSubArea.id)
                  {
                     searchInfo += "\n • " + dataApi.getMonsterFromId(monsterId).name;
                     break;
                  }
               }
               i += numSubAreas;
            }
            searchInfo = searchInfo.substr(1,searchInfo.length - 1);
         }
         return searchInfo;
      }
      
      private function showSearchSubArea(pSubAreaId:int, pLineColor:uint = 3355443, pFillColor:uint = 1096297, pLineAlpha:Number = 0.6, pFillAlpha:Number = 0.4) : void
      {
         var dungeon:Dungeon = null;
         var mapPos:MapPosition = null;
         var hintId:int = 0;
         var hint:Hint = null;
         var center:Point = null;
         var subArea:SubArea = dataApi.getSubArea(pSubAreaId);
         var subAreaName:String = subArea.undiatricalName;
         var dungeonId:int = this.getDungeonId(subAreaName);
         if(dungeonId > 0)
         {
            if(!mapViewer.getMapElement("search_hint" + pSubAreaId))
            {
               dungeon = dataApi.getDungeon(dungeonId);
               mapPos = dataApi.getMapInfo(dungeon.entranceMapId);
               if(mapPos)
               {
                  mapViewer.addIcon(SEARCH_HINTS,"search_hint" + pSubAreaId,__hintIconsRootPath + "422.png",mapPos.posX,mapPos.posY,__iconScale,dungeon.name + " (" + uiApi.getText("ui.common.short.level") + " " + dungeon.optimalPlayerLevel + ")",true);
               }
            }
         }
         else
         {
            hintId = this.getHintId(subAreaName);
            if(!subArea.displayOnWorldMap && hintId > 0)
            {
               if(!mapViewer.getMapElement("search_hint" + pSubAreaId))
               {
                  hint = dataApi.getHintById(hintId);
                  mapViewer.addIcon(SEARCH_HINTS,"search_hint" + pSubAreaId,__hintIconsRootPath + hint.gfx + ".png",hint.x,hint.y,__iconScale,hint.name,true);
               }
            }
            else if(!mapViewer.getMapElement("search_shape" + pSubAreaId))
            {
               mapViewer.addAreaShape(SEARCH_AREAS,"search_shape" + pSubAreaId,mapApi.getSubAreaShape(pSubAreaId),pLineColor,pLineAlpha,pFillColor,pFillAlpha,4);
               center = mapApi.getSubAreaCenter(pSubAreaId);
               mapViewer.addIcon(SEARCH_AREAS_FLAGS,"search_flag" + pSubAreaId,null,center.x,center.y,2,subArea.area.name + " - " + subArea.name,true,pFillColor,true,false);
            }
         }
      }
      
      private function removeSearchMapElements() : Boolean
      {
         var element:MapElement = null;
         var searchAreaElements:Array = mapViewer.getMapElementsByLayer(SEARCH_AREAS);
         var searchHintsElements:Array = mapViewer.getMapElementsByLayer(SEARCH_HINTS);
         for each(element in searchAreaElements)
         {
            mapViewer.removeMapElement(element);
            mapViewer.removeMapElement(mapViewer.getMapElement("search_flag" + element.id.split("search_shape")[1]));
         }
         for each(element in searchHintsElements)
         {
            mapViewer.removeMapElement(element);
         }
         return searchAreaElements.length > 0 || searchHintsElements.length > 0;
      }
      
      private function createPrismsSearchGroup(pPrisms:Dictionary) : void
      {
         var prismWrapper:PrismSubAreaWrapper = null;
         var prism:PrismSubAreaWrapper = null;
         var hint:Object = null;
         if(!this._prismsHintGroup)
         {
            this._prismsHintGroup = {};
            this._prismsHintGroup.type = HINT_GROUP_SEARCH_TYPE;
            this._prismsHintGroup.name = uiApi.getText("ui.prism.prisms");
            this._prismsHintGroup.data = [];
            this._prismsHintGroup.uri = uiApi.me().getConstant("hintIcons") + "420.png";
         }
         this._prismsHintGroup.data.length = 0;
         for each(prism in pPrisms)
         {
            prismWrapper = prism;
            if(__hintCaptions["prism_" + prismWrapper.subAreaId])
            {
               hint = {};
               hint.id = "_prism_" + prismWrapper.subAreaId;
               hint.gfx = modCartography.getPrismStateInfo(prismWrapper.state).icon;
               hint.x = prismWrapper.worldX;
               hint.y = prismWrapper.worldY;
               hint.name = __hintCaptions["prism_" + prismWrapper.subAreaId];
               this._prismsHintGroup.data.push(hint);
            }
         }
      }
      
      private function updatePrismsSearchGroup(pPrismsIds:Array) : void
      {
         var searchHints:Array = null;
         var element:MapElement = null;
         var prismId:uint = 0;
         var prismWrapper:PrismSubAreaWrapper = null;
         if(this._searchSelectedItem && this._searchSelectedItem.type == HINT_GROUP_SEARCH_TYPE && this._searchSelectedItem.name == uiApi.getText("ui.prism.prisms"))
         {
            searchHints = mapViewer.getMapElementsByLayer(SEARCH_HINTS);
            for each(prismId in pPrismsIds)
            {
               prismWrapper = socialApi.getPrismSubAreaById(prismId);
               for each(element in searchHints)
               {
                  if(element.id.indexOf("prism_" + prismId) != -1)
                  {
                     mapViewer.removeMapElement(element);
                     mapViewer.addIcon(SEARCH_HINTS,"search_hint_prism_" + prismId,__hintIconsRootPath + modCartography.getPrismStateInfo(prismWrapper.state).icon + ".png",prismWrapper.worldX,prismWrapper.worldY,__iconScale,__hintCaptions["prism_" + prismId],true);
                  }
               }
            }
            mapViewer.updateMapElements();
         }
      }
      
      private function getDungeonId(pDungeonName:String) : int
      {
         var dungeons:Vector.<uint> = dataApi.queryString(Dungeon,"name",pDungeonName);
         if(dungeons.length > 0)
         {
            return dungeons[0];
         }
         return 0;
      }
      
      private function getHintId(pHintName:String) : int
      {
         var hints:Vector.<uint> = dataApi.queryString(Hint,"name",pHintName);
         if(hints.length > 0)
         {
            return hints[0];
         }
         return 0;
      }
      
      private function initBreachSectors() : void
      {
         var sectors:Array = dataApi.getAllBreachWorldMapSector();
         sectors.sort(this.sortBreachSectorsByLevel);
         this.gd_sectors.dataProvider = sectors;
         this.tx_caption_bg.height = this.ctr_breach.height = sectors.length * uiApi.me().getConstant("breachSector_line_height") + 40;
      }
      
      private function sortBreachSectorsByLevel(sector1:BreachWorldMapSector, sector2:BreachWorldMapSector) : int
      {
         var levelSector1:uint = sector1.minStage;
         var levelSector2:uint = sector2.minStage;
         if(levelSector1 > levelSector2)
         {
            return 1;
         }
         if(levelSector1 < levelSector2)
         {
            return -1;
         }
         return 0;
      }
      
      private function highlightBreachZone(zoneId:int) : void
      {
         var mapElement:MapElement = null;
         var coordinate:BreachWorldMapCoordinate = null;
         var hintUri:String = uiApi.me().getConstant("hintIcons");
         var sector:BreachWorldMapSector = dataApi.getBreachWorldMapSector(zoneId);
         var minStage:int = sector.minStage;
         var maxStage:int = sector.maxStage == 0 ? int(minStage) : int(sector.maxStage);
         for each(mapElement in mapViewer.getMapElementsByLayer(MAP_LAYER_BREACH_HIGHLIGHT))
         {
            mapViewer.removeMapElement(mapElement);
         }
         for each(coordinate in dataApi.getAllBreachWorldMapCoordinate())
         {
            if(!mapViewer.getMapElement("breachIcon_" + coordinate.mapStage + "_highlight") && coordinate.mapStage >= minStage && coordinate.mapStage <= maxStage)
            {
               mapViewer.addBreachIcon(MAP_LAYER_BREACH_HIGHLIGHT,"breachIcon_" + coordinate.mapStage + "_highlight",hintUri + coordinate.exploredMapIcon + ".png",coordinate.mapCoordinateX,coordinate.mapCoordinateY,1.5,coordinate.mapStage < 200 ? uiApi.getText("ui.breach.floors",breachMinStage,coordinate.mapStage) : uiApi.getText("ui.breach.floor",coordinate.mapStage),false,-1,false,HintPriorityEnum.FLAGS);
            }
         }
         mapViewer.updateMapElements();
      }
   }
}

import com.ankamagames.dofus.datacenter.world.Area;
import com.ankamagames.dofus.datacenter.world.SubArea;
import com.ankamagames.dofus.datacenter.world.WorldMap;

class WorldmapInfo
{
    
   
   public var worldmap:WorldMap;
   
   public var superAreaWithWorldmapIds:Vector.<uint>;
   
   public var areaWithWorldmapIds:Vector.<uint>;
   
   public var subAreaWithWorldmapIds:Vector.<uint>;
   
   public var parentSuperAreaId:int = -1;
   
   public var parentAreaId:int = -1;
   
   public var subAreaId:int = -1;
   
   function WorldmapInfo(worldmap:WorldMap)
   {
      super();
      this.worldmap = worldmap;
   }
   
   public function setup() : void
   {
      var subArea:SubArea = null;
      var area:Area = null;
      if(this.superAreaWithWorldmapIds.length > 0)
      {
         this.parentSuperAreaId = this.superAreaWithWorldmapIds[0];
      }
      else if(this.areaWithWorldmapIds.length > 0)
      {
         area = Area.getAreaById(this.areaWithWorldmapIds[0]);
         if(area)
         {
            this.parentSuperAreaId = area.superAreaId;
         }
      }
      else if(this.subAreaWithWorldmapIds.length > 0)
      {
         this.subAreaId = this.subAreaWithWorldmapIds[0];
         subArea = SubArea.getSubAreaById(this.subAreaWithWorldmapIds[0]);
         if(subArea)
         {
            this.parentAreaId = subArea.areaId;
         }
         area = Area.getAreaById(this.parentAreaId);
         if(area)
         {
            this.parentSuperAreaId = area.superArea.id;
         }
      }
   }
}

import com.ankamagames.dofus.datacenter.world.WorldMap;

class WorldmapCatInfo
{
    
   
   public var id:uint;
   
   public var worldmap:WorldMap;
   
   public var isSubCat:Boolean;
   
   public var name:String;
   
   public var parentCat:WorldmapCatInfo;
   
   public var areaInfo:Object;
   
   public var children:Array;
   
   function WorldmapCatInfo(id:uint, worldmap:WorldMap, isSubCat:Boolean, areaInfo:Object = null, parentCat:WorldmapCatInfo = null)
   {
      this.children = [];
      super();
      this.id = id;
      this.worldmap = worldmap;
      this.isSubCat = isSubCat;
      this.parentCat = parentCat;
      this.areaInfo = areaInfo;
      if(worldmap)
      {
         this.name = worldmap.name;
      }
   }
}
