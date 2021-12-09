package Ankama_Cartography.ui
{
   import Ankama_Cartography.ui.type.AreaGroup;
   import Ankama_Cartography.ui.type.AreaInfo;
   import Ankama_Cartography.ui.type.Flag;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.HintCategory;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.PrismListenEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AnomalySubareaInformation;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.types.enums.HintPriorityEnum;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class CartographyBase extends AbstractCartographyUi
   {
      
      public static const MODE_MOVE:String = "move";
      
      public static const MODE_FLAG:String = "flag";
      
      public static const QUEST_ICON:String = "quest.png";
      
      protected static const ALL_AREAS:String = "AllAreas";
      
      protected static const NO_PRISM_AREAS:String = "noPrismAreas";
      
      protected static const NORMAL_AREAS:String = "normalAreas";
      
      protected static const WEAKENED_AREAS:String = "weakenedAreas";
      
      protected static const VULNERABLE_AREAS:String = "vulnerableAreas";
      
      protected static const VILLAGES_AREAS:String = "villagesAreas";
      
      protected static const CAPTURABLE_AREAS:String = "capturableAreas";
      
      protected static const SABOTAGED_AREAS:String = "sabotagedAreas";
      
      protected static const BONUS_AREAS:String = "bonusAreas";
      
      protected static const MALUS_AREAS:String = "malusAreas";
      
      protected static const BONUS_DUNGEONS:String = "bonusDungeons";
      
      protected static const MALUS_DUNGEONS:String = "malusDungeons";
      
      protected static const ANOMALY_AREAS:String = "anomalyAreas";
      
      protected static const PLAYER_POSITION_LAYER:String = "playerPositionLayer";
      
      protected static const MOUNT_TRIP_LAYER:String = "mountTripLayer";
      
      protected static const MAP_LAYER_CLASS_TEMPLES:String = "layer_1";
      
      protected static const MAP_LAYER_BIDHOUSES:String = "layer_2";
      
      protected static const MAP_LAYER_CRAFT_HOUSES:String = "layer_3";
      
      protected static const MAP_LAYER_MISC:String = "layer_4";
      
      protected static const MAP_LAYER_PRISMS:String = "layer_5";
      
      protected static const MAP_LAYER_DUNGEONS:String = "layer_6";
      
      protected static const MAP_LAYER_PRIVATE:String = "layer_7";
      
      protected static const MAP_LAYER_FLAGS:String = "layer_8";
      
      protected static const MAP_LAYER_TRANSPORTS:String = "layer_9";
      
      protected static const MAP_LAYER_ANOMALIES:String = "layer_10";
      
      protected static const MAP_LAYER_BREACH:String = "layer_12";
      
      protected static const MAP_LAYER_QUEST:String = "layer_11";
      
      protected static const MAP_LAYER_BREACH_HIGHLIGHT:String = "layer_13";
      
      protected static const MAP_FILTERS:String = "mapFilters";
      
      private static const MAP_PRESET_DATA_NAME:String = "mapPresets";
      
      protected static const KNOWN_ZAAP_ICON_ID:uint = 410;
      
      protected static const UNKNOWN_ZAAP_ICON_ID:uint = 1004;
      
      protected static const WORLD_MAP:int = 1;
      
      protected static const WORLD_OF_INCARNAM:int = 2;
      
      protected static const DEPTHS_OF_SUFOKIA:int = 17;
      
      public static const MAP_TYPE_SUPERAREA:uint = 0;
      
      public static const MAP_TYPE_SUBAREA:uint = 1;
      
      public static var questIcons:Array = [];
       
      
      protected var gridDisplayed:Boolean = false;
      
      private var _oldIcons:Array;
      
      protected var breachMinStage:uint = 50;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      protected var __mapMode:String = "move";
      
      protected var __iconScale:Number;
      
      protected var __playerPos:WorldPointWrapper;
      
      protected var __startWorldMapInfo:WorldMap;
      
      protected var __worldMapInfo:Object;
      
      protected var __hintCategoryFiltersList:Array;
      
      protected var __layersToShow:Array;
      
      protected var __allAreas:AreaGroup;
      
      protected var __capturableAreas:AreaGroup;
      
      protected var __sabotagedAreas:AreaGroup;
      
      protected var __noPrismAreas:AreaGroup;
      
      protected var __normalAreas:AreaGroup;
      
      protected var __weakenedAreas:AreaGroup;
      
      protected var __vulnerableAreas:AreaGroup;
      
      protected var __allRewardAreas:AreaGroup;
      
      protected var __bonusDungeon:AreaGroup;
      
      protected var __malusDungeon:AreaGroup;
      
      protected var __bonusAreas:AreaGroup;
      
      protected var __malusAreas:AreaGroup;
      
      protected var __anomalyAreas:AreaGroup;
      
      protected var __subAreaList:Array;
      
      protected var __switchingMapUi:Boolean;
      
      protected var __lastSubArea:SubArea;
      
      protected var __subAreaTooltipPosition:Point;
      
      protected var __displaySubAreaToolTip:Boolean = true;
      
      protected var __animatedPlayerPosition:Boolean = true;
      
      private var _flags:Array;
      
      private var _currentSubarea:SubArea;
      
      protected var _textCss:String;
      
      private var _waitingForSocialUpdate:int;
      
      private var _mapChanged:Boolean;
      
      private var _myAlliance:AllianceWrapper;
      
      private var _lastWorldId:int = -1;
      
      private var _lastMapId:Number = -1;
      
      private var _mapPreset:Array;
      
      protected var __hintIconsRootPath:String;
      
      protected var __centerOnPlayer:Boolean;
      
      public function CartographyBase()
      {
         this._oldIcons = [];
         this.__hintCategoryFiltersList = [];
         this.__subAreaTooltipPosition = new Point();
         this._mapPreset = [];
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         this.__hintIconsRootPath = sysApi.getConfigEntry("config.gfx.path") + "icons/hintsShadow/";
         this.__switchingMapUi = params.switchingMapUi;
         uiApi.addComponentHook(mapViewer,ComponentHookList.ON_RELEASE);
         sysApi.addHook(HookList.SubareaList,this.onAreaListInformation);
         sysApi.addHook(SocialHookList.GuildInformationsFarms,this.onGuildInformationsFarms);
         sysApi.addHook(SocialHookList.GuildHousesUpdate,this.onGuildHousesUpdate);
         sysApi.addHook(SocialHookList.TaxCollectorListUpdate,this.onTaxCollectorListUpdate);
         sysApi.addHook(CustomUiHookList.MapHintsFilter,this.onMapHintsFilter);
         sysApi.addHook(SocialHookList.GuildPaddockAdd,this.onGuildPaddockAdd);
         sysApi.addHook(SocialHookList.GuildPaddockRemoved,this.onGuildPaddockRemoved);
         sysApi.addHook(SocialHookList.GuildTaxCollectorAdd,this.onGuildTaxCollectorAdd);
         sysApi.addHook(SocialHookList.GuildTaxCollectorRemoved,this.onGuildTaxCollectorRemoved);
         sysApi.addHook(SocialHookList.GuildHouseAdd,this.onGuildHouseAdd);
         sysApi.addHook(SocialHookList.GuildHouseRemoved,this.onGuildHouseRemoved);
         sysApi.addHook(HookList.RemoveMapFlag,this.onRemoveMapFlag);
         sysApi.addHook(PrismHookList.PrismsList,this.onPrismsListInformation);
         sysApi.addHook(PrismHookList.PrismsListUpdate,this.onPrismsInfoUpdate);
         sysApi.addHook(BeriliaHookList.FocusChange,this.onFocusChange);
         sysApi.addHook(BeriliaHookList.MouseShiftClick,this.onMouseShiftClick);
         sysApi.addHook(BeriliaHookList.MouseAltClick,this.onMouseAltClick);
         sysApi.addHook(BeriliaHookList.MouseCtrlClick,this.onMouseCtrlClick);
         sysApi.addHook(HookList.HouseInformations,this.onHouseInformations);
         sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         sysApi.addHook(HookList.AnomalyState,this.onAnomalyState);
         this._textCss = uiApi.me().getConstant("css") + "normal.css";
         this.__playerPos = params.currentMap;
         this._flags = params.flags;
         var subArea:SubArea = !!sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea();
         if(!subArea.hasCustomWorldMap)
         {
            this.__startWorldMapInfo = subArea.area.superArea.worldmap;
         }
         else
         {
            this.__startWorldMapInfo = subArea.worldmap;
         }
         var mapPresets:Array = this.getMapPresetsData();
         if(mapPresets)
         {
            this.setMapPresets(mapPresets);
         }
         this.openPlayerCurrentMap();
      }
      
      public function refreshQuests(questIcons:Array) : void
      {
         var icon:MapIconElement = null;
         var subArea:SubArea = null;
         var questIcon:* = undefined;
         for each(icon in this._oldIcons)
         {
            mapViewer.removeMapElement(icon);
         }
         subArea = !!sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea();
         if(subArea.area.superArea.worldmap.id != this.__worldMapInfo.id)
         {
            return;
         }
         this._oldIcons = [];
         var uri:String = sysApi.getConfigEntry("config.gfx.path") + "icons/hints/" + QUEST_ICON;
         for each(questIcon in questIcons)
         {
            this._oldIcons.push(mapViewer.addIcon(MAP_LAYER_QUEST,questIcon.id,uri,questIcon.x,questIcon.y,this.__iconScale,uiApi.getText("ui.cartography.availableQuests") + " (" + questIcon.nb + ")"));
         }
      }
      
      public function addFlag(flagId:String, flagLegend:String, x:int, y:int, color:int = -1, playSound:Boolean = true, needMapUpdate:Boolean = true, canBeManuallyRemoved:Boolean = true, allowDuplicate:Boolean = false) : void
      {
         var uri:* = null;
         var flag:MapIconElement = null;
         if(playSound)
         {
            sysApi.sendAction(new PlaySoundAction(["16039"]));
         }
         var layer:String = MAP_LAYER_FLAGS;
         var priority:uint = HintPriorityEnum.FLAGS;
         switch(flagId)
         {
            case "flag_playerPosition":
               uri = !!this.__animatedPlayerPosition ? sysApi.getConfigEntry("config.gfx.path") + "icons/assets.swf|myPosition" : this.__hintIconsRootPath + "character.png";
               layer = PLAYER_POSITION_LAYER;
               priority = HintPriorityEnum.PLAYER;
               break;
            case "Phoenix":
               uri = this.__hintIconsRootPath + "phoenix.png";
               break;
            default:
               uri = this.__hintIconsRootPath + "flag.png";
         }
         if(this.playerApi.isInBreach() || this.playerApi.currentSubArea().id == 904 && flagId == "flag_playerPosition")
         {
            flag = mapViewer.addBreachIcon(layer,flagId,uri,x,y,this.__iconScale * 0.25,flagLegend,false,color,true,priority);
         }
         else
         {
            flag = mapViewer.addIcon(layer,flagId,uri,x,y,this.__iconScale,flagLegend,true,color,true,canBeManuallyRemoved,null,true,allowDuplicate,priority);
         }
         if(flag && needMapUpdate)
         {
            this.updateMap();
         }
      }
      
      public function updateFlag(flagId:String, x:int, y:int, legend:String) : Boolean
      {
         return mapViewer.updateOneMapElement(flagId,x,y,legend);
      }
      
      override public function unload() : void
      {
         super.unload();
         if(!sysApi.getOption("cacheMapEnabled","dofus"))
         {
            _currentWorldId = -1;
         }
         this.saveMapFilters(this.__hintCategoryFiltersList,MAP_FILTERS);
         this.saveCurrentMapPreset();
         sysApi.sendAction(new PrismsListRegisterAction(["cartography.Cartography",PrismListenEnum.PRISM_LISTEN_NONE]));
      }
      
      public function openNewMap(worldmapInfo:Object, mode:uint, areaInfo:Object, forceReload:Boolean = false) : Boolean
      {
         var zoom:String = null;
         var i:int = 0;
         var nbZooms:int = 0;
         var z:Number = NaN;
         if(!forceReload && worldmapInfo.id == _currentWorldId)
         {
            return false;
         }
         switch(mode)
         {
            case MAP_TYPE_SUPERAREA:
               this._currentSubarea = null;
               _currentSuperarea = areaInfo as SuperArea;
               break;
            case MAP_TYPE_SUBAREA:
               this._currentSubarea = areaInfo as SubArea;
               _currentSuperarea = areaInfo.area.superArea;
         }
         var id:uint = this._currentSubarea != null && this._currentSubarea.customWorldMap.length > 0 ? uint(this._currentSubarea.customWorldMap[0]) : uint(worldmapInfo.id);
         if(_currentWorldId != 0 && id != _currentWorldId)
         {
            this._flags = modCartography.getFlags(id);
         }
         this._mapChanged = this._lastWorldId != -1 && id != this._lastWorldId;
         this._lastWorldId = _currentWorldId = id;
         mapApi.setCurrentCartographyWorldmapId(_currentWorldId);
         if(this is CartographyUi)
         {
            (this as CartographyUi).showPlayerFlag(_currentWorldId == PlayedCharacterManager.getInstance().currentWorldMapId);
         }
         this.__worldMapInfo = worldmapInfo;
         mapViewer.origineX = worldmapInfo.origineX;
         mapViewer.origineY = worldmapInfo.origineY;
         mapViewer.mapWidth = worldmapInfo.mapWidth;
         mapViewer.mapHeight = worldmapInfo.mapHeight;
         mapViewer.minScale = worldmapInfo.minScale;
         mapViewer.maxScale = worldmapInfo.maxScale;
         if(this.getMapPresets()[_currentWorldId])
         {
            mapViewer.startScale = this.getPresetScale();
         }
         else
         {
            mapViewer.startScale = worldmapInfo.startScale;
         }
         var folder:* = sysApi.getConfigEntry("config.gfx.path.maps") + id + "/";
         mapViewer.removeAllMap();
         for each(zoom in worldmapInfo.zoom)
         {
            z = parseFloat(zoom);
            mapViewer.addMap(z,folder + zoom + "/",worldmapInfo.totalWidth,worldmapInfo.totalHeight,250,250);
         }
         mapViewer.startScale = Number(mapViewer.startScale.toFixed(2));
         nbZooms = mapViewer.zoomLevels.length;
         if(mapViewer.zoomLevels.indexOf(mapViewer.startScale) == -1)
         {
            for(i = 0; i < nbZooms; i++)
            {
               if(mapViewer.startScale < mapViewer.zoomLevels[i])
               {
                  if(i == 0)
                  {
                     mapViewer.startScale = mapViewer.zoomLevels[i];
                  }
                  else
                  {
                     mapViewer.startScale = mapViewer.zoomLevels[i - 1];
                  }
                  break;
               }
            }
         }
         mapViewer.finalize();
         this.__iconScale = Math.min(worldmapInfo.mapWidth / 31.5,3);
         this.initMap();
         return true;
      }
      
      protected function getPresetScale() : Number
      {
         return this.getMapPresets()[_currentWorldId].zoomFactor;
      }
      
      protected function openPlayerCurrentMap() : void
      {
         var subArea:SubArea = !!sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea();
         if(!subArea.hasCustomWorldMap && !this.playerApi.isInBreach())
         {
            this.openNewMap(subArea.area.superArea.worldmap,MAP_TYPE_SUPERAREA,subArea.area.superArea);
         }
         else if(this.playerApi.isInBreach())
         {
            this.openNewMap(this.dataApi.getWorldMap(23),MAP_TYPE_SUBAREA,this.dataApi.getSubArea(904));
         }
         else
         {
            this.openNewMap(subArea.worldmap,MAP_TYPE_SUBAREA,subArea);
         }
      }
      
      protected function initMap() : void
      {
         var layerName:String = null;
         var hint:Hint = null;
         var hintLegend:String = null;
         var layerId:* = null;
         var mapMoved:Boolean = false;
         var prismSubAreaInformation:PrismSubAreaWrapper = null;
         var layerVisible:Boolean = false;
         var flag:Flag = null;
         var playerSubarea:SubArea = null;
         var playerPosition:Object = null;
         var mapBounds:Rectangle = null;
         _showMapCoords = true;
         mapViewer.showGrid = this.gridDisplayed;
         mapViewer.autoSizeIcon = true;
         minValue = mapViewer.maxScale;
         maxValue = mapViewer.minScale;
         zoom = mapViewer.startScale;
         mapViewer.addLayer(MOUNT_TRIP_LAYER);
         mapViewer.addLayer(PLAYER_POSITION_LAYER);
         mapViewer.addLayer(NO_PRISM_AREAS);
         mapViewer.addLayer(NORMAL_AREAS);
         mapViewer.addLayer(WEAKENED_AREAS);
         mapViewer.addLayer(VULNERABLE_AREAS);
         mapViewer.addLayer(VILLAGES_AREAS);
         mapViewer.addLayer(CAPTURABLE_AREAS);
         mapViewer.addLayer(SABOTAGED_AREAS);
         mapViewer.addLayer(BONUS_AREAS);
         mapViewer.addLayer(MALUS_AREAS);
         mapViewer.addLayer(BONUS_DUNGEONS);
         mapViewer.addLayer(MALUS_DUNGEONS);
         mapViewer.addLayer(ANOMALY_AREAS);
         this.__subAreaList = mapApi.getAllSubArea();
         var hints:Array = mapApi.getHints();
         this.__layersToShow = [];
         var hintLevelText:* = " (" + uiApi.getText("ui.common.short.level") + " ";
         var iconPath:* = null;
         var playedCharacterManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         for each(hint in hints)
         {
            if(hint.worldMapId == _currentWorldId)
            {
               layerName = "layer_" + hint.categoryId;
               if(!this.__layersToShow[layerName])
               {
                  this.__layersToShow[layerName] = true;
                  mapViewer.addLayer(layerName);
               }
               hintLegend = hint.name;
               if(hint.level)
               {
                  hintLegend += hintLevelText + hint.level + ")";
               }
               if(hint.gfx === KNOWN_ZAAP_ICON_ID && !playedCharacterManager.isZaapKnown(hint.mapId))
               {
                  iconPath = this.__hintIconsRootPath + UNKNOWN_ZAAP_ICON_ID + ".png";
               }
               else
               {
                  iconPath = this.__hintIconsRootPath + hint.gfx + ".png";
               }
               mapViewer.addIcon(layerName,"hint_" + hint.id,iconPath,hint.x,hint.y,this.__iconScale,hintLegend,false,-1,true,true,null,true,false,hint.priority);
            }
         }
         mapViewer.addLayer(MAP_LAYER_PRISMS);
         this.__layersToShow[MAP_LAYER_PRISMS] = true;
         mapViewer.addLayer(MAP_LAYER_PRIVATE);
         this.__layersToShow[MAP_LAYER_PRIVATE] = true;
         mapViewer.addLayer(MAP_LAYER_FLAGS);
         this.__layersToShow[MAP_LAYER_FLAGS] = true;
         mapViewer.addLayer(MAP_LAYER_ANOMALIES);
         this.__layersToShow[MAP_LAYER_ANOMALIES] = true;
         mapViewer.addLayer(MAP_LAYER_BREACH_HIGHLIGHT);
         this.__layersToShow[MAP_LAYER_BREACH_HIGHLIGHT] = true;
         mapViewer.addLayer(MAP_LAYER_BREACH);
         this.__layersToShow[MAP_LAYER_BREACH] = true;
         mapViewer.addLayer(MAP_LAYER_QUEST);
         this.__layersToShow[MAP_LAYER_QUEST] = true;
         this.refreshQuests(questIcons);
         for(layerId in this.__hintCategoryFiltersList)
         {
            layerName = "layer_" + layerId;
            layerVisible = !!this.__layersToShow[layerName] ? Boolean(this.__hintCategoryFiltersList[layerId]) : false;
            mapViewer.showLayer(layerName,layerVisible);
         }
         mapMoved = !this.__switchingMapUi && !this._mapChanged ? Boolean(this.restoreCurrentMapPreset()) : false;
         this._lastMapId = this.playerApi.currentMap().mapId;
         var flagsList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_FLAGS);
         var nFlag:int = flagsList.length;
         for(var p:int = 0; p < nFlag; p++)
         {
            mapViewer.removeMapElement(flagsList[p]);
         }
         if(this._flags)
         {
            _nbCustomFlags[_currentWorldId] = 0;
            for each(flag in this._flags)
            {
               this.addFlag(flag.id,flag.legend,flag.position.x,flag.position.y,flag.color,false,false,flag.canBeManuallyRemoved,flag.allowDuplicate);
               ++_nbCustomFlags[_currentWorldId];
            }
         }
         this.onHouseInformations();
         if(this is CartographyUi)
         {
            (this as CartographyUi).traceShortcuts();
         }
         for each(prismSubAreaInformation in __conquestSubAreasInfos)
         {
            this.updatePrismIcon(prismSubAreaInformation);
            if(!this.__allAreas)
            {
               this.updatePrismAndSubareaStatus(prismSubAreaInformation,false);
            }
         }
         this.addSubAreasShapes();
         if(this.__playerPos)
         {
            playerSubarea = !!sysApi.getPlayerManager().isMapInHavenbag(this.playerApi.currentMap().mapId) ? this.playerApi.previousSubArea() : this.playerApi.currentSubArea();
            if(playerSubarea.area.superArea.id == _currentSuperarea.id || this.playerApi.isInBreach())
            {
               playerPosition = this.getPlayerPosition();
               if(!mapViewer.getMapElement("flag_playerPosition") && _currentWorldId == PlayedCharacterManager.getInstance().currentWorldMapId && (!this._currentSubarea || playerSubarea.id == this._currentSubarea.id || this.playerApi.isInBreach()))
               {
                  this.addFlag("flag_playerPosition",uiApi.getText("ui.cartography.yourposition"),playerPosition.x,playerPosition.y,-1,this.playerApi.isInBreach(),false,false);
               }
               mapBounds = mapViewer.mapBounds;
               if(!(mapBounds.left > playerPosition.x || mapBounds.right < playerPosition.x || mapBounds.bottom < playerPosition.y || mapBounds.top > playerPosition.y) && mapViewer.zoomFactor >= mapViewer.minScale)
               {
                  if(!mapMoved)
                  {
                     mapViewer.moveTo(playerPosition.x,playerPosition.y);
                  }
               }
               else if(!mapMoved)
               {
                  mapViewer.moveTo(0,0);
               }
            }
            else if(!mapMoved)
            {
               mapViewer.moveTo(0,0);
            }
         }
         else if(!mapMoved)
         {
            mapViewer.moveTo(0,0);
         }
         if(socialApi.hasGuild())
         {
            ++this._waitingForSocialUpdate;
            sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY]));
            if(!socialApi.guildHousesUpdateNeeded() && (!socialApi.getGuildHouses() || socialApi.getGuildHouses().length == 0))
            {
               ++this._waitingForSocialUpdate;
               sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_HOUSES]));
            }
            else
            {
               this.onGuildHousesUpdate();
            }
            if(!socialApi.getGuildPaddocks() || socialApi.getGuildPaddocks().length == 0)
            {
               ++this._waitingForSocialUpdate;
               sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_PADDOCKS]));
            }
            else
            {
               this.onGuildInformationsFarms();
            }
         }
         else
         {
            this.updateMap();
         }
      }
      
      protected function addSubAreasShapes() : void
      {
         var subArea:SubArea = null;
         this.__noPrismAreas = new AreaGroup("","","","");
         for each(subArea in this.__subAreaList)
         {
            if(subArea.displayOnWorldMap && subArea.worldmap && !mapViewer.getMapElement("shape" + subArea.id))
            {
               if(subArea.worldmap.id == _currentWorldId)
               {
                  mapViewer.addAreaShape(NO_PRISM_AREAS,"shape" + subArea.id,mapApi.getSubAreaShape(subArea.id),3355443,0.2,1096297,0.2);
               }
               this.__noPrismAreas.children.push(new AreaInfo("","","",null,subArea));
            }
         }
      }
      
      protected function saveCurrentMapPreset() : void
      {
         if(this.__worldMapInfo)
         {
            this.getMapPresets()[_currentWorldId] = new MapPreset(mapViewer.mapPixelPosition,mapViewer.zoomFactor);
            sysApi.setData(MAP_PRESET_DATA_NAME + this.playerApi.id(),this.getMapPresets(),DataStoreEnum.BIND_CHARACTER);
         }
      }
      
      override protected function addCustomFlag(pX:int, pY:int) : void
      {
         super.addCustomFlag(pX,pY);
         this.__mapMode = MODE_MOVE;
      }
      
      override protected function addCustomFlagWithRightClick(pX:Number, pY:Number) : void
      {
         this.__mapMode = MODE_FLAG;
         super.addCustomFlagWithRightClick(pX,pY);
      }
      
      protected function updatePrismIcon(pPrismSubAreaInformation:PrismSubAreaWrapper) : void
      {
         var prismStateInfo:Object = null;
         var prismDateText:* = null;
         var prismModulesText:String = null;
         var itemw:ItemWrapper = null;
         var mo:ObjectItem = null;
         var subArea:SubArea = this.dataApi.getSubArea(pPrismSubAreaInformation.subAreaId);
         var prismId:String = "prism_" + pPrismSubAreaInformation.subAreaId;
         var me:MapElement = mapViewer.getMapElement(prismId);
         if(pPrismSubAreaInformation.mapId != -1 && subArea.worldmap && subArea.worldmap.id == _currentWorldId && (pPrismSubAreaInformation.alliance || this._myAlliance))
         {
            prismStateInfo = modCartography.getPrismStateInfo(pPrismSubAreaInformation.state);
            prismDateText = "";
            prismModulesText = "";
            switch(pPrismSubAreaInformation.state)
            {
               case PrismStateEnum.PRISM_STATE_NORMAL:
                  prismDateText = uiApi.getText("ui.prism.vulnerabilityHour") + " :";
                  break;
               case PrismStateEnum.PRISM_STATE_WEAKENED:
               case PrismStateEnum.PRISM_STATE_SABOTAGED:
                  prismDateText = uiApi.getText("ui.prism.startVulnerability") + uiApi.getText("ui.common.colon") + this.timeApi.getDate(pPrismSubAreaInformation.nextVulnerabilityDate * 1000);
            }
            if(pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_NORMAL || pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_WEAKENED || pPrismSubAreaInformation.state == PrismStateEnum.PRISM_STATE_SABOTAGED)
            {
               prismDateText += " " + pPrismSubAreaInformation.vulnerabilityHourString;
            }
            if(this._myAlliance && pPrismSubAreaInformation.alliance.allianceId == this._myAlliance.allianceId && pPrismSubAreaInformation.modulesObjects && pPrismSubAreaInformation.modulesObjects.length > 0)
            {
               for each(mo in pPrismSubAreaInformation.modulesObjects)
               {
                  itemw = this.dataApi.getItemWrapper(mo.objectGID,0,0,1);
                  prismModulesText += itemw.name + "\n";
               }
               prismModulesText = prismModulesText.substr(0,prismModulesText.length - 1);
            }
            __hintCaptions["prism_" + pPrismSubAreaInformation.subAreaId] = prismStateInfo.text;
            if(prismDateText.length > 0)
            {
               __hintCaptions["prism_" + pPrismSubAreaInformation.subAreaId] += " <i>( " + prismDateText + " )</i>";
            }
            if(prismModulesText.length > 0)
            {
               __hintCaptions["prism_" + pPrismSubAreaInformation.subAreaId] += " <i>( " + prismModulesText + " )</i>";
            }
            if(me)
            {
               mapViewer.removeMapElement(me);
            }
            mapViewer.addIcon(MAP_LAYER_PRISMS,prismId,this.__hintIconsRootPath + prismStateInfo.icon + ".png",pPrismSubAreaInformation.worldX,pPrismSubAreaInformation.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.CONQUEST);
         }
         else if(pPrismSubAreaInformation.mapId == -1 && me)
         {
            mapViewer.removeMapElement(me);
         }
      }
      
      protected function updatePrismAndSubareaStatus(prismSubAreaInformation:PrismSubAreaWrapper, pUpdateConquestModeData:Boolean = true) : void
      {
         var currentAreaItem:AreaInfo = null;
         var lineColor:uint = 0;
         var fillColor:uint = 0;
         var layer:String = null;
         var alliance:AllianceWrapper = null;
         var prismState:uint = 0;
         var subArea:SubArea = mapApi.getSubArea(prismSubAreaInformation.subAreaId);
         if(!subArea || !subArea.name || !subArea.worldmap || subArea.worldmap.id != _currentWorldId)
         {
            return;
         }
         if(pUpdateConquestModeData)
         {
            currentAreaItem = new AreaInfo(subArea.name,"subarea","icon_simple_prism_uri",this.__allAreas,subArea);
            this.addAreaInfo(this.__allAreas,currentAreaItem);
         }
         var lineAlpha:Number = 0.6;
         var fillAlpha:Number = 0.4;
         if(prismSubAreaInformation.mapId != -1 || prismSubAreaInformation.alliance)
         {
            alliance = !prismSubAreaInformation.alliance ? this._myAlliance : prismSubAreaInformation.alliance;
            if(currentAreaItem && this._myAlliance && this._myAlliance.allianceId == alliance.allianceId)
            {
               currentAreaItem.css = this._textCss;
               currentAreaItem.cssClass = "bonus";
            }
            fillColor = lineColor = alliance.backEmblem.color;
            prismState = prismSubAreaInformation.mapId != -1 ? uint(prismSubAreaInformation.state) : uint(PrismStateEnum.PRISM_STATE_NORMAL);
            switch(prismState)
            {
               case PrismStateEnum.PRISM_STATE_INVULNERABLE:
               case PrismStateEnum.PRISM_STATE_NORMAL:
                  layer = NORMAL_AREAS;
                  if(currentAreaItem)
                  {
                     this.addAreaInfo(this.__normalAreas,currentAreaItem);
                  }
                  break;
               case PrismStateEnum.PRISM_STATE_WEAKENED:
                  layer = WEAKENED_AREAS;
                  if(currentAreaItem)
                  {
                     currentAreaItem.vulnerabilityDate = prismSubAreaInformation.nextVulnerabilityDate;
                     currentAreaItem.label += " - " + prismSubAreaInformation.vulnerabilityHourString;
                     this.addAreaInfo(this.__weakenedAreas,currentAreaItem);
                  }
                  break;
               case PrismStateEnum.PRISM_STATE_SABOTAGED:
                  layer = SABOTAGED_AREAS;
                  if(currentAreaItem)
                  {
                     currentAreaItem.vulnerabilityDate = prismSubAreaInformation.nextVulnerabilityDate;
                     currentAreaItem.label += " - " + prismSubAreaInformation.vulnerabilityHourString;
                     this.addAreaInfo(this.__sabotagedAreas,currentAreaItem);
                  }
                  break;
               case PrismStateEnum.PRISM_STATE_VULNERABLE:
                  layer = VULNERABLE_AREAS;
                  if(currentAreaItem)
                  {
                     this.addAreaInfo(this.__vulnerableAreas,currentAreaItem);
                  }
            }
         }
         else
         {
            layer = CAPTURABLE_AREAS;
            fillColor = lineColor = 1096297;
            if(currentAreaItem)
            {
               this.addAreaInfo(this.__capturableAreas,currentAreaItem);
            }
         }
         mapViewer.addAreaShape(layer,"shape" + prismSubAreaInformation.subAreaId,mapApi.getSubAreaShape(prismSubAreaInformation.subAreaId),lineColor,lineAlpha,fillColor,fillAlpha,4,false);
      }
      
      protected function addAreaInfo(pList:AreaGroup, pItem:AreaInfo) : void
      {
         var item:AreaInfo = null;
         if(pList)
         {
            for each(item in pList.children)
            {
               if(item.data.id == pItem.data.id)
               {
                  pList.children[pList.children.indexOf(item)] = pItem;
                  return;
               }
            }
            pList.children.push(pItem);
            pItem.parent = pList;
         }
      }
      
      protected function loadMapFilters(pFiltersList:Array, pMapFilterId:String) : void
      {
         var hintCat:HintCategory = null;
         var filterValue:int = this.configApi.getConfigProperty("dofus",pMapFilterId);
         var hintCategories:Array = this.dataApi.getHintCategories();
         for each(hintCat in hintCategories)
         {
            pFiltersList[hintCat.id] = (filterValue & Math.pow(2,hintCat.id)) > 0;
         }
      }
      
      protected function saveMapFilters(pFiltersList:Array, pMapFilterId:String) : void
      {
         var hintCatId:* = null;
         var filterValue:int = 0;
         for(hintCatId in pFiltersList)
         {
            if(pFiltersList[hintCatId])
            {
               filterValue += Math.pow(2,int(hintCatId));
            }
         }
         this.configApi.setConfigProperty("dofus",pMapFilterId,filterValue);
      }
      
      protected function getSubAreaTooltipPosition() : Point
      {
         return this.__subAreaTooltipPosition;
      }
      
      protected function getMapPresets() : Array
      {
         return this._mapPreset;
      }
      
      protected function setMapPresets(presets:Array) : void
      {
         this._mapPreset = presets;
      }
      
      protected function getMapPresetsData() : Array
      {
         return sysApi.getData(MAP_PRESET_DATA_NAME + this.playerApi.id(),DataStoreEnum.BIND_CHARACTER);
      }
      
      public function onFocusChange(pTarget:Object) : void
      {
         if(pTarget && pTarget != mapViewer && pTarget != uiApi.getUi("cartographyCurrentMapTooltip") && !(mapViewer as Object).contains(pTarget))
         {
            rollOutMapAreaShape(__lastHighlightElement);
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         super.onRelease(target);
         switch(target)
         {
            case mapViewer:
               if(this.__mapMode == MODE_FLAG)
               {
                  this.addCustomFlag(mapViewer.currentMouseMapX,mapViewer.currentMouseMapY);
               }
         }
      }
      
      override public function onMapRollOver(target:MapViewer, x:int, y:int, searchSubArea:SubArea = null) : void
      {
         var alliance:AllianceWrapper = null;
         var subAreaInfo:Array = null;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var tooltip:UiRootContainer = null;
         super.onMapRollOver(target,x,y,searchSubArea);
         var subArea:SubArea = searchSubArea;
         if(!subArea)
         {
            subAreaInfo = getSubAreaFromCoords(x,y);
            if(subAreaInfo)
            {
               subArea = subAreaInfo[0];
            }
         }
         this.__lastSubArea = subArea;
         if(!subArea)
         {
            return;
         }
         if(subArea && subArea.worldmap && subArea.worldmap.id == _currentWorldId)
         {
            prismSubAreaInfo = __conquestSubAreasInfos && !searchSubArea ? __conquestSubAreasInfos[subArea.id] : null;
            if(prismSubAreaInfo && (prismSubAreaInfo.mapId != -1 || prismSubAreaInfo.alliance))
            {
               alliance = !prismSubAreaInfo.alliance ? socialApi.getAlliance() : prismSubAreaInfo.alliance;
            }
         }
         if(this.__displaySubAreaToolTip)
         {
            tooltip = uiApi.getUi("tooltip_cartographyCurrentSubArea");
            if(!tooltip)
            {
               uiApi.showTooltip({
                  "mapX":x,
                  "mapY":y,
                  "mapElementText":null,
                  "subArea":subArea,
                  "subAreaLevel":(!!subArea ? subArea.level : 0),
                  "alliance":alliance,
                  "updatePositionFunction":this.updateSubAreaTooltipPosition
               },new Rectangle(),false,"cartographyCurrentSubArea",0,0,0,"cartography",null,null,"cartographyCurrentSubArea");
            }
            else
            {
               tooltipApi.update("cartographyCurrentSubArea","subAreaInfo",x,y,null,subArea,!!subArea ? subArea.level : 0,alliance);
               this.updateSubAreaTooltipPosition();
            }
         }
      }
      
      override public function onMapRollOut(target:MapViewer) : void
      {
         super.onMapRollOut(target);
         rollOutMapAreaShape(__lastHighlightElement);
         __lastHighlightElement = "";
         if(this.__displaySubAreaToolTip)
         {
            uiApi.unloadUi("tooltip_cartographyCurrentSubArea");
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         super.onRollOver(target);
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case mapViewer:
               if(this.__mapMode == MODE_FLAG)
               {
                  if(!mapViewer.useFlagCursor)
                  {
                     mapViewer.useFlagCursor = true;
                  }
               }
               else if(mapViewer.useFlagCursor)
               {
                  mapViewer.useFlagCursor = false;
               }
               return;
            default:
               if(tooltipText)
               {
                  uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
               }
               return;
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         super.onRollOut(target);
         switch(target)
         {
            case mapViewer:
               if(this.__mapMode == MODE_FLAG)
               {
                  mapViewer.useFlagCursor = false;
               }
               return;
            default:
               uiApi.hideTooltip();
               return;
         }
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         var mapElemList:Array = null;
         var nElems:int = 0;
         var i:int = 0;
         if(!hasGuild)
         {
            mapElemList = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
            nElems = mapElemList.length;
            for(i = 0; i < nElems; i++)
            {
               if(mapElemList[i].id.indexOf("guildPaddock_") == 0)
               {
                  mapViewer.removeMapElement(mapElemList[i]);
               }
            }
         }
      }
      
      private function onGuildInformationsFarms() : void
      {
         var paddock:PaddockContentInformations = null;
         var subArea:SubArea = null;
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildPaddock_") == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         var farmsList:Vector.<PaddockContentInformations> = socialApi.getGuildPaddocks();
         for each(paddock in farmsList)
         {
            subArea = this.dataApi.getSubArea(paddock.subAreaId);
            if(subArea && subArea.area.superAreaId == superAreaId && subArea.worldmap.id == _currentWorldId)
            {
               __hintCaptions["guildPaddock_" + paddock.paddockId] = uiApi.processText(uiApi.getText("ui.guild.paddock",paddock.maxOutdoorMount),"",paddock.maxOutdoorMount == 1,paddock.maxOutdoorMount == 0);
               mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildPaddock_" + paddock.paddockId,this.__hintIconsRootPath + "1002.png",paddock.worldX,paddock.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            }
         }
         if(this._waitingForSocialUpdate <= 1)
         {
            this._waitingForSocialUpdate = 0;
            this.updateMap();
         }
         else
         {
            --this._waitingForSocialUpdate;
         }
      }
      
      private function onGuildPaddockAdd(paddockInfo:PaddockContentInformations) : void
      {
         var subArea:SubArea = this.dataApi.getSubArea(paddockInfo.subAreaId);
         if(subArea.area.superAreaId == superAreaId && subArea.worldmap.id == _currentWorldId)
         {
            __hintCaptions["guildPaddock_" + paddockInfo.paddockId] = uiApi.processText(uiApi.getText("ui.guild.paddock",paddockInfo.maxOutdoorMount),"",paddockInfo.maxOutdoorMount == 1,paddockInfo.maxOutdoorMount == 0);
            mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildPaddock_" + paddockInfo.paddockId,this.__hintIconsRootPath + "1002.png",paddockInfo.worldX,paddockInfo.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            this.updateMap();
         }
      }
      
      private function onGuildPaddockRemoved(paddockId:Number) : void
      {
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildPaddock_" + paddockId) == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         this.updateMap();
      }
      
      private function onGuildHousesUpdate() : void
      {
         var house:GuildHouseWrapper = null;
         var subArea:SubArea = null;
         var housesList:Vector.<GuildHouseWrapper> = socialApi.getGuildHouses();
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildHouse_") == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         for each(house in housesList)
         {
            subArea = this.dataApi.getSubArea(house.subareaId);
            if(subArea.area.superAreaId == superAreaId && subArea.worldmap.id == _currentWorldId)
            {
               __hintCaptions["guildHouse_" + house.houseId] = uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon") + house.houseName;
               mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildHouse_" + house.houseId,this.__hintIconsRootPath + "1001.png",house.worldX,house.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            }
         }
         if(this._waitingForSocialUpdate <= 1)
         {
            this._waitingForSocialUpdate = 0;
            this.updateMap();
         }
         else
         {
            --this._waitingForSocialUpdate;
         }
      }
      
      private function onGuildHouseAdd(house:GuildHouseWrapper) : void
      {
         var subArea:SubArea = this.dataApi.getSubArea(house.subareaId);
         if(subArea.area.superAreaId == superAreaId && subArea.worldmap.id == _currentWorldId)
         {
            __hintCaptions["guildHouse_" + house.houseId] = uiApi.getText("ui.common.guildHouse") + uiApi.getText("ui.common.colon") + house.houseName;
            mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildHouse_" + house.houseId,this.__hintIconsRootPath + "1001.png",house.worldX,house.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            this.updateMap();
         }
      }
      
      private function onGuildHouseRemoved(houseId:uint) : void
      {
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildHouse_" + houseId) == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         this.updateMap();
      }
      
      protected function onTaxCollectorListUpdate(infoType:uint = 0) : void
      {
         var taxCollector:TaxCollectorWrapper = null;
         var subArea:SubArea = null;
         if(infoType == GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_ALLIANCE)
         {
            return;
         }
         var sh:Boolean = this.configApi.isFeatureWithKeywordEnabled("server.heroic");
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildPony_") == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         var taxCollectorsList:Dictionary = socialApi.getTaxCollectors();
         for each(taxCollector in taxCollectorsList)
         {
            subArea = this.dataApi.getSubArea(taxCollector.subareaId);
            if(subArea.area.superAreaId == superAreaId && (subArea.worldmap.id == _currentWorldId || subArea.worldmap.id == DEPTHS_OF_SUFOKIA && _currentWorldId == WORLD_MAP))
            {
               if(!sh)
               {
                  __hintCaptions["guildPony_" + taxCollector.uniqueId] = uiApi.getText("ui.guild.taxCollectorFullInformations",taxCollector.firstName,taxCollector.lastName,taxCollector.additionalInformation.collectorCallerName,taxCollector.kamas,taxCollector.pods,this.utilApi.kamasToString(taxCollector.itemsValue,""),taxCollector.experience);
               }
               else if(taxCollector.pods > 0)
               {
                  __hintCaptions["guildPony_" + taxCollector.uniqueId] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.full",taxCollector.firstName,taxCollector.lastName,taxCollector.additionalInformation.collectorCallerName,taxCollector.pods,this.utilApi.kamasToString(taxCollector.itemsValue,""));
               }
               else
               {
                  __hintCaptions["guildPony_" + taxCollector.uniqueId] = uiApi.getText("ui.guild.taxCollectorHardcoreInformations.empty",taxCollector.firstName,taxCollector.lastName,taxCollector.additionalInformation.collectorCallerName);
               }
               mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildPony_" + taxCollector.uniqueId,this.__hintIconsRootPath + "1003.png",taxCollector.mapWorldX,taxCollector.mapWorldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            }
         }
         if(this._waitingForSocialUpdate <= 1)
         {
            this._waitingForSocialUpdate = 0;
            this.updateMap();
         }
         else
         {
            --this._waitingForSocialUpdate;
         }
      }
      
      private function onGuildTaxCollectorAdd(taxCollector:TaxCollectorWrapper) : void
      {
         var firstName:String = null;
         var lastName:String = null;
         if(this.dataApi.getSubArea(taxCollector.subareaId).area.superAreaId == superAreaId)
         {
            firstName = taxCollector.firstName;
            lastName = taxCollector.lastName;
            __hintCaptions["guildPony_" + taxCollector.uniqueId] = uiApi.getText("ui.guild.taxCollectorFullInformations",firstName,lastName,taxCollector.additionalInformation.collectorCallerName,taxCollector.kamas,taxCollector.pods,taxCollector.itemsValue,taxCollector.experience);
            mapViewer.addIcon(MAP_LAYER_PRIVATE,"guildPony_" + taxCollector.uniqueId,this.__hintIconsRootPath + "1003.png",taxCollector.mapWorldX,taxCollector.mapWorldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            this.updateMap();
         }
      }
      
      private function onGuildTaxCollectorRemoved(taxCollectorId:Number) : void
      {
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("guildPony_" + taxCollectorId) == 0)
            {
               mapViewer.removeMapElement(mapElemList[i]);
            }
         }
         this.updateMap();
      }
      
      private function onRemoveMapFlag(flagId:String, worldMapId:int) : void
      {
         if(flagId == "flag_playerPosition")
         {
            removeFlag(flagId);
         }
      }
      
      protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean) : void
      {
         if(!fromCartography)
         {
            this.__hintCategoryFiltersList[layerId] = displayed;
            mapViewer.showLayer("layer_" + layerId,displayed);
            this.updateMap();
         }
      }
      
      protected function onPrismsListInformation(pPrismsInfo:Dictionary) : void
      {
         var prismSubAreaInformation:PrismSubAreaWrapper = null;
         this._myAlliance = socialApi.getAlliance();
         var prismList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRISMS);
         var nPrism:int = prismList.length;
         for(var p:int = 0; p < nPrism; p++)
         {
            mapViewer.removeMapElement(prismList[p]);
         }
         __conquestSubAreasInfos = pPrismsInfo as Dictionary;
         for each(prismSubAreaInformation in pPrismsInfo)
         {
            this.updatePrismIcon(prismSubAreaInformation);
            if(!this.__allAreas)
            {
               this.updatePrismAndSubareaStatus(prismSubAreaInformation,false);
            }
         }
         this.__normalAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.normal"),"areaShape","icon_simple_prism_uri",NORMAL_AREAS);
         this.__weakenedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.weakened"),"areaShape","icon_simple_prism_uri",WEAKENED_AREAS);
         this.__vulnerableAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.vulnerable"),"areaShape","icon_simple_prism_uri",VULNERABLE_AREAS);
         this.__capturableAreas = new AreaGroup(uiApi.getText("ui.pvp.conquestCapturableAreas"),"areaShape","icon_simple_prism_uri",CAPTURABLE_AREAS);
         this.__sabotagedAreas = new AreaGroup(uiApi.getText("ui.prism.cartography.sabotaged"),"areaShape","icon_simple_prism_uri",SABOTAGED_AREAS);
         this.addSubAreasShapes();
         this.updateMap();
         if(this.__allAreas)
         {
            this.__allAreas = null;
         }
      }
      
      protected function onPrismsInfoUpdate(pPrismSubAreaIds:Array) : void
      {
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var subAreaId:int = 0;
         this._myAlliance = socialApi.getAlliance();
         for each(subAreaId in pPrismSubAreaIds)
         {
            prismSubAreaInfo = socialApi.getPrismSubAreaById(subAreaId);
            this.updatePrismIcon(prismSubAreaInfo);
            this.updatePrismAndSubareaStatus(prismSubAreaInfo);
         }
         this.updateMap();
      }
      
      private function onAreaListInformation(areasInfo:Vector.<AnomalySubareaInformation>) : void
      {
         var subInfo:AnomalySubareaInformation = null;
         var subArea:SubArea = null;
         var mapPos:MapPosition = null;
         var iconUri:* = null;
         var legend:String = null;
         __subAreasInfos = areasInfo;
         for each(subInfo in __subAreasInfos)
         {
            if(subInfo.hasAnomaly && !this.playerApi.isInBreach())
            {
               subArea = mapApi.getSubArea(subInfo.subAreaId);
               if(subArea && subArea.worldmap.id == mapApi.getCurrentWorldMap().id)
               {
                  mapPos = subArea.zaapMapPosition;
                  iconUri = sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterSpiral_On.png";
                  legend = uiApi.getText("ui.zaap.anomaly") + " - " + subArea.name;
                  mapViewer.addIcon(MAP_LAYER_ANOMALIES,"anomaly_" + subArea.id,iconUri,mapPos.posX,mapPos.posY,1,legend,true,-1,true,true,null,true,false,HintPriorityEnum.FLAGS);
               }
            }
         }
         this.addSubAreasShapes();
         mapViewer.updateMapElements();
         if(this.__allAreas)
         {
            this.__allAreas = null;
         }
      }
      
      protected function onAnomalyState(open:Boolean, closingTime:Number, subAreaId:int) : void
      {
         var mapPos:MapPosition = null;
         var iconUri:* = null;
         var legend:String = null;
         var subArea:SubArea = mapApi.getSubArea(subAreaId);
         if(open && subArea && subArea.worldmap.id == mapApi.getCurrentWorldMap().id)
         {
            mapPos = subArea.zaapMapPosition;
            iconUri = sysApi.getConfigEntry("config.ui.skin") + "texture/map/filterSpiral_On.png";
            legend = uiApi.getText("ui.zaap.anomaly") + " - " + subArea.name;
            mapViewer.addIcon(MAP_LAYER_ANOMALIES,"anomaly_" + subArea.id,iconUri,mapPos.posX,mapPos.posY,1,legend,true,-1,true,true,null,true,false,HintPriorityEnum.FLAGS);
         }
         else if(!open)
         {
            mapViewer.removeMapElement(mapViewer.getMapElement("anomaly_" + subAreaId));
         }
      }
      
      protected function onHouseInformations(pHouses:Vector.<HouseWrapper> = null) : void
      {
         var daHouse:HouseWrapper = null;
         var hasHouse:Boolean = false;
         var houseElementId:String = null;
         var subArea:SubArea = null;
         var houses:Vector.<HouseWrapper> = !pHouses ? this.playerApi.getPlayerHouses() : pHouses;
         var mapElemList:Array = mapViewer.getMapElementsByLayer(MAP_LAYER_PRIVATE);
         var nElems:int = mapElemList.length;
         for(var i:int = 0; i < nElems; i++)
         {
            if(mapElemList[i].id.indexOf("myHouse") == 0)
            {
               hasHouse = false;
               for each(daHouse in houses)
               {
                  if(daHouse.houseId == parseInt(mapElemList[i].id.substr(mapElemList[i].id.indexOf("_") + 1)))
                  {
                     hasHouse = true;
                  }
               }
               if(!hasHouse)
               {
                  mapViewer.removeMapElement(mapElemList[i]);
               }
            }
         }
         this.updateMap();
         for each(daHouse in houses)
         {
            houseElementId = "myHouse_" + daHouse.houseId;
            subArea = this.dataApi.getSubArea(daHouse.subAreaId);
            if(subArea.area.superAreaId == superAreaId && subArea.worldmap.id == _currentWorldId && !mapViewer.getMapElement(houseElementId))
            {
               __hintCaptions[houseElementId] = uiApi.getText("ui.common.myHouse");
               mapViewer.addIcon(MAP_LAYER_PRIVATE,houseElementId,this.__hintIconsRootPath + "1000.png",daHouse.worldX,daHouse.worldY,this.__iconScale,null,false,-1,true,true,null,true,false,HintPriorityEnum.PLAYER_POSSESSIONS);
            }
         }
      }
      
      public function onMouseShiftClick(target:Object) : void
      {
         var elementName:* = null;
         var params:Object = null;
         if(target.data == mapViewer)
         {
            elementName = !!target.params.element ? (!!__hintCaptions[target.params.element.id] ? __hintCaptions[target.params.element.id] : target.params.element.legend) : "";
            if(elementName.length)
            {
               elementName = elementName.split("\n").join(" ") + " ";
            }
            params = {
               "x":target.params.x,
               "y":target.params.y,
               "worldMapId":this.playerApi.currentSubArea().worldmap.id,
               "elementName":elementName
            };
            sysApi.dispatchHook(BeriliaHookList.MouseShiftClick,{
               "data":"Map",
               "params":params
            });
         }
      }
      
      public function onMouseAltClick(target:Object) : void
      {
         if(target.data == mapViewer)
         {
            this.centerOnPlayer();
         }
      }
      
      public function onMouseCtrlClick(target:Object) : void
      {
         if(target.data == mapViewer)
         {
            if(this.hasAutoPilot())
            {
               MountAutoTripManager.getInstance().skipNextConfirmationPopup();
            }
            this.mountRunToThisPosition(target.params.x,target.params.y,_currentWorldId);
         }
      }
      
      override public function onMapMove(target:MapViewer) : void
      {
         super.onMapMove(target);
         this.saveCurrentMapPreset();
      }
      
      protected function shouldRestorePosition() : Boolean
      {
         return true;
      }
      
      private function restoreCurrentMapPreset() : Boolean
      {
         var mapPreset:Object = this.getMapPresets()[_currentWorldId];
         if(!mapPreset)
         {
            this.__centerOnPlayer = true;
            return false;
         }
         if(this._lastMapId != -1 && this._lastMapId != this.playerApi.currentMap().mapId || !this.shouldRestorePosition())
         {
            zoom = mapViewer.mapScale = this.getPresetScale();
            return false;
         }
         mapViewer.moveToPixel(mapPreset.mapPixelPosition.x,mapPreset.mapPixelPosition.y,mapPreset.zoomFactor);
         this.__centerOnPlayer = false;
         zoom = mapViewer.zoomFactor;
         return true;
      }
      
      private function updateSubAreaTooltipPosition() : void
      {
         var pos:Point = null;
         if(!uiApi)
         {
            return;
         }
         var tooltip:UiRootContainer = uiApi.getUi("tooltip_cartographyCurrentSubArea");
         if(tooltip)
         {
            tooltip.visible = this.__lastSubArea != null;
            pos = this.getSubAreaTooltipPosition();
            tooltip.x = pos.x;
            tooltip.y = pos.y;
         }
      }
      
      protected function updateMap() : void
      {
         mapViewer.updateMapElements();
      }
      
      protected function toggleHints() : void
      {
         var layerId:* = null;
         var allLayersVisible:* = !mapViewer.allLayersVisible;
         for(layerId in this.__hintCategoryFiltersList)
         {
            this.__hintCategoryFiltersList[layerId] = allLayersVisible;
         }
         mapViewer.showAllLayers(allLayersVisible);
      }
      
      protected function insertMapCoordinates(pMapX:int, pMapY:int, pMapElement:MapIconElement) : void
      {
         this.onMouseShiftClick({
            "data":mapViewer,
            "params":{
               "x":pMapX,
               "y":pMapY,
               "element":pMapElement
            }
         });
      }
      
      protected function mountRunToThisPosition(pMapX:int, pMapY:int, worldId:int = -1) : void
      {
         mapApi.autoTravel(pMapX,pMapY,worldId);
      }
      
      override protected function createContextMenu(contextMenu:Array = null) : void
      {
         if(!contextMenu)
         {
            contextMenu = [];
         }
         if(this.hasAutoPilot())
         {
            contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.mountTrip.travel"),this.mountRunToThisPosition,[mapViewer.currentMouseMapX,mapViewer.currentMouseMapY,_currentWorldId]));
         }
         contextMenu.unshift(modContextMenu.createContextMenuSeparatorObject());
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.chat.insertCoordinates"),this.insertMapCoordinates,[mapViewer.currentMouseMapX,mapViewer.currentMouseMapY,__currentMapElement]));
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.centerOnPlayer"),this.centerOnPlayer));
         contextMenu.unshift(modContextMenu.createContextMenuSeparatorObject());
         var gridTextKey:String = !!mapViewer.showGrid ? "ui.option.hideGrid" : "ui.option.displayGrid";
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText(gridTextKey),this.toggleDisplayGrid));
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.map.toggleAllHints"),this.toggleHints));
         super.createContextMenu(contextMenu);
      }
      
      protected function showHints(pFiltersList:Array) : void
      {
         var layerId:* = null;
         for(layerId in pFiltersList)
         {
            mapViewer.showLayer("layer_" + layerId,pFiltersList[layerId]);
         }
      }
      
      private function getPlayerPosition() : Object
      {
         var outdoorCoordinateX:int = 0;
         var outdoorCoordinateY:int = 0;
         var breachWorldMapCoordinate:BreachWorldMapCoordinate = !this.breachApi.breachFrame ? null : this.dataApi.getBreachWorldMapCoordinate(Math.max(this.dataApi.getBreachMinStageWorldMapCoordinate().mapStage,Math.min(this.breachApi.getFloor(),this.dataApi.getBreachMaxStageWorldMapCoordinate().mapStage)));
         if(breachWorldMapCoordinate && this.playerApi.isInBreach())
         {
            outdoorCoordinateX = breachWorldMapCoordinate.mapCoordinateX;
            outdoorCoordinateY = breachWorldMapCoordinate.mapCoordinateY;
         }
         else
         {
            outdoorCoordinateX = this.__playerPos.outdoorX;
            outdoorCoordinateY = this.__playerPos.outdoorY;
         }
         return {
            "x":outdoorCoordinateX,
            "y":outdoorCoordinateY
         };
      }
      
      private function centerOnPlayer() : void
      {
         var playerPos:Object = this.getPlayerPosition();
         mapViewer.moveTo(playerPos.x,playerPos.y);
      }
      
      private function toggleDisplayGrid() : void
      {
         mapViewer.showGrid = !mapViewer.showGrid;
         this.configApi.setConfigProperty("dofus",this is BannerMap ? "showMiniMapGrid" : "showMapGrid",mapViewer.showGrid);
      }
      
      private function hasAutoPilot() : Boolean
      {
         var capacityCount:int = 0;
         var i:int = 0;
         var eff:EffectInstance = null;
         var mountInfo:MountData = this.playerApi.getMount();
         var petsMountInfo:ItemWrapper = this.playerApi.getPetsMount();
         if(this.playerApi.isRidding() && mountInfo || this.playerApi.isPetsMounting() && petsMountInfo)
         {
            if(sysApi.getPlayerManager().hasFreeAutopilot)
            {
               return true;
            }
            if(this.playerApi.isRidding())
            {
               capacityCount = mountInfo.ability.length;
               i = 0;
               if(capacityCount)
               {
                  for(i = 0; i < capacityCount; i++)
                  {
                     if(mountInfo.ability[i].id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
                     {
                        return true;
                     }
                  }
               }
            }
            else if(this.playerApi.isPetsMounting())
            {
               if(petsMountInfo.effects.length)
               {
                  for each(eff in petsMountInfo.effects)
                  {
                     if(eff.effectId == ActionIds.ACTION_SELF_PILOTING)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
   }
}

import flash.geom.Point;

class MapPreset
{
    
   
   public var mapPixelPosition:Point;
   
   public var zoomFactor:Number;
   
   function MapPreset(mapPixelPosition:Point, zoomFactor:Number)
   {
      super();
      this.mapPixelPosition = mapPixelPosition;
      this.zoomFactor = zoomFactor;
   }
}
