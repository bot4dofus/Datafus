package Ankama_Cartography.ui
{
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.dofus.datacenter.breach.BreachWorldMapCoordinate;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismsListRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.AnomalySubareaInformationRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.HighlightInteractiveElementsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowFightPositionsAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.PrismListenEnum;
   import com.ankamagames.dofus.types.enums.HintPriorityEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class BannerMap extends CartographyBase
   {
      
      private static var _nFightCount:uint = 0;
      
      private static var _shortcutColor:String;
      
      private static const MAP_PRESET_DATA_NAME:String = "mapZoom_miniMap";
       
      
      public var tx_separator:TextureBitmap;
      
      public var btn_showEntitiesTooltips:ButtonContainer;
      
      public var btn_highlightInteractiveElements:ButtonContainer;
      
      public var btn_viewFights:ButtonContainer;
      
      public var btn_showFightPositions:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      private var _entitiesTooltipsVisible:Boolean;
      
      private var _interactiveElementsHighlighted:Boolean;
      
      private var _fightPositionsVisible:Boolean;
      
      private var _hintCategoryNames:Array;
      
      private var _refreshTimer:BenchmarkTimer;
      
      public function BannerMap()
      {
         this._refreshTimer = new BenchmarkTimer(2000,1,"BannerMap._refreshTimer");
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         this._hintCategoryNames = [uiApi.getText("ui.map.temple"),uiApi.getText("ui.map.bidHouse"),uiApi.getText("ui.map.craftHouse"),uiApi.getText("ui.common.misc"),uiApi.getText("ui.map.conquest"),uiApi.getText("ui.map.dungeon"),uiApi.getText("ui.common.possessions"),uiApi.getText("ui.cartography.flags"),uiApi.getText("ui.cartography.transport"),uiApi.getText("ui.common.anomalies"),uiApi.getText("ui.cartography.availableQuests")];
         __animatedPlayerPosition = false;
         __displaySubAreaToolTip = false;
         mapViewer.finalized = false;
         mapViewer.gridLineThickness = 1;
         gridDisplayed = configApi.getConfigProperty("dofus","showMiniMapGrid");
         this.loadMapFilters(__hintCategoryFiltersList,"mapFilters_miniMap");
         super.main(params);
         uiApi.addComponentHook(this.btn_showEntitiesTooltips,"onPress");
         uiApi.addComponentHook(this.btn_showEntitiesTooltips,"onMouseUp");
         uiApi.addComponentHook(this.btn_showEntitiesTooltips,"onRollOver");
         uiApi.addComponentHook(this.btn_showEntitiesTooltips,"onRollOut");
         uiApi.addComponentHook(this.btn_highlightInteractiveElements,"onPress");
         uiApi.addComponentHook(this.btn_highlightInteractiveElements,"onMouseUp");
         uiApi.addComponentHook(this.btn_highlightInteractiveElements,"onRollOver");
         uiApi.addComponentHook(this.btn_highlightInteractiveElements,"onRollOut");
         uiApi.addComponentHook(this.btn_viewFights,"onRollOver");
         uiApi.addComponentHook(this.btn_viewFights,"onRollOut");
         uiApi.addComponentHook(this.btn_showFightPositions,"onPress");
         uiApi.addComponentHook(this.btn_showFightPositions,"onMouseUp");
         uiApi.addComponentHook(this.btn_showFightPositions,"onRollOver");
         uiApi.addComponentHook(this.btn_showFightPositions,"onRollOut");
         sysApi.addHook(HookList.MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         sysApi.addHook(HookList.ShowEntitiesTooltips,this.onShowEntitiesTooltips);
         sysApi.addHook(HookList.HighlightInteractiveElements,this.onHighlightInteractiveElements);
         sysApi.addHook(HookList.MapFightCount,this.onMapFightCount);
         sysApi.addHook(HookList.ConfigPropertyChange,this.onConfigPropertyChange);
         sysApi.addHook(HookList.ShowFightPositions,this.onShowFightPositions);
         sysApi.addHook(HookList.UpdateKnownZaaps,this.onUpdateKnownZaaps);
         uiApi.addShortcutHook("flagCurrentMap",this.onShortcut);
         sysApi.sendAction(new PrismsListRegisterAction(["BannerMap",PrismListenEnum.PRISM_LISTEN_ALL]));
         if(!__subAreasInfos)
         {
            sysApi.sendAction(new AnomalySubareaInformationRequestAction(["cartography.Cartography"]));
         }
         this.btn_viewFights.softDisabled = _nFightCount == 0;
         this.btn_viewFights.mouseEnabled = !this.btn_viewFights.softDisabled;
      }
      
      public function hide() : void
      {
         sysApi.sendAction(new PrismsListRegisterAction(["BannerMap",PrismListenEnum.PRISM_LISTEN_NONE]));
         this.mainCtr.visible = false;
      }
      
      public function show() : void
      {
         this.mainCtr.visible = true;
         sysApi.sendAction(new PrismsListRegisterAction(["BannerMap",PrismListenEnum.PRISM_LISTEN_ALL]));
      }
      
      public function set activated(value:Boolean) : void
      {
         if(value)
         {
            sysApi.sendAction(new PrismsListRegisterAction(["BannerMap",PrismListenEnum.PRISM_LISTEN_ALL]));
         }
         else
         {
            sysApi.sendAction(new PrismsListRegisterAction(["BannerMap",PrismListenEnum.PRISM_LISTEN_NONE]));
         }
         uiApi.me().visible = value;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_viewFights:
               if(!uiApi.getUi(UIEnum.SPECTATOR_UI))
               {
                  if(_nFightCount > 0)
                  {
                     sysApi.sendAction(new OpenCurrentFightAction([]));
                  }
               }
               else
               {
                  uiApi.unloadUi(UIEnum.SPECTATOR_UI);
               }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var p:MapPosition = null;
         var flagId:String = null;
         switch(s)
         {
            case "flagCurrentMap":
               p = dataApi.getMapInfo(playerApi.currentMap().mapId);
               flagId = "flag_custom_" + p.posX + "_" + p.posY;
               sysApi.dispatchHook(HookList.AddMapFlag,flagId,uiApi.getText("ui.cartography.customFlag") + " (" + p.posX + "," + p.posY + ")",p.worldMap,p.posX,p.posY,16768256,true);
               return true;
            default:
               return false;
         }
      }
      
      override public function onCloseUi(pShortCut:String) : Boolean
      {
         return false;
      }
      
      override public function onPress(target:GraphicContainer) : void
      {
         super.onPress(target);
         switch(target)
         {
            case this.btn_showEntitiesTooltips:
               if(!this._entitiesTooltipsVisible)
               {
                  sysApi.sendAction(new ShowEntitiesTooltipsAction([false]));
               }
               break;
            case this.btn_highlightInteractiveElements:
               if(!this._interactiveElementsHighlighted)
               {
                  sysApi.sendAction(new HighlightInteractiveElementsAction([false]));
               }
               break;
            case this.btn_showFightPositions:
               if(!this._fightPositionsVisible)
               {
                  sysApi.sendAction(new ShowFightPositionsAction([false]));
               }
         }
      }
      
      public function onMouseUp(target:ButtonContainer) : void
      {
         switch(target)
         {
            case this.btn_showEntitiesTooltips:
               if(this._entitiesTooltipsVisible)
               {
                  sysApi.sendAction(new ShowEntitiesTooltipsAction([false]));
               }
               break;
            case this.btn_highlightInteractiveElements:
               if(this._interactiveElementsHighlighted)
               {
                  sysApi.sendAction(new HighlightInteractiveElementsAction([false]));
               }
               break;
            case this.btn_showFightPositions:
               if(this._fightPositionsVisible)
               {
                  sysApi.sendAction(new ShowFightPositionsAction([false]));
               }
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var textKey:String = null;
         var data:TextTooltipInfo = null;
         var text:String = null;
         var m:Array = null;
         if(!this.mainCtr.visible)
         {
            return;
         }
         super.onRollOver(target);
         var point:uint = 7;
         var relPoint:uint = 1;
         var shortcutKey:* = null;
         switch(target)
         {
            case this.btn_showEntitiesTooltips:
               textKey = "ui.option.entitiesTooltips.hold";
               shortcutKey = bindsApi.getShortcutBindStr("showEntitiesTooltips");
               break;
            case this.btn_highlightInteractiveElements:
               textKey = "ui.option.highlightInteractiveElements.hold";
               shortcutKey = bindsApi.getShortcutBindStr("highlightInteractiveElements");
               break;
            case this.btn_viewFights:
               tooltipText = uiApi.getText("ui.fightsOnMap",_nFightCount);
               tooltipText = uiApi.processText(tooltipText,"m",_nFightCount < 2,_nFightCount == 0);
               break;
            case this.btn_showFightPositions:
               textKey = "ui.option.fightPositions.hold";
               shortcutKey = bindsApi.getShortcutBindStr("showFightPositions");
         }
         if(tooltipText || textKey)
         {
            if(shortcutKey)
            {
               if(!_shortcutColor)
               {
                  _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                  _shortcutColor = _shortcutColor.replace("0x","#");
               }
               shortcutKey = "<font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
            }
            else
            {
               shortcutKey = "";
            }
            if(shortcutKey != null)
            {
               if(tooltipText)
               {
                  data = uiApi.textTooltipInfo(tooltipText + (!!shortcutKey.length ? " " + shortcutKey : ""));
               }
               else if(textKey)
               {
                  text = uiApi.getText(textKey,shortcutKey);
                  m = text.match(/(?:\s)\s/g);
                  if(m.length)
                  {
                     text = text.replace(m[0]," ");
                  }
                  data = uiApi.textTooltipInfo(text);
               }
            }
            else
            {
               data = uiApi.textTooltipInfo(tooltipText);
            }
            uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         if(!this.mainCtr.visible)
         {
            return;
         }
         super.onRollOut(target);
      }
      
      override public function onMapRollOver(target:MapViewer, x:int, y:int, searchSubArea:SubArea = null) : void
      {
         if(!this.mainCtr.visible)
         {
            return;
         }
         if(!this._refreshTimer.running)
         {
            sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_GUILD_ONLY]));
            this._refreshTimer.start();
         }
         super.onMapRollOver(target,x,y,searchSubArea);
      }
      
      override public function onMapRollOut(target:MapViewer) : void
      {
         if(!this.mainCtr.visible)
         {
            return;
         }
         super.onMapRollOut(target);
      }
      
      override public function onMapElementRollOut(map:MapViewer, target:MapIconElement) : void
      {
         if(!this.mainCtr.visible)
         {
            return;
         }
         super.onMapElementRollOut(map,target);
      }
      
      override public function onMapElementRollOver(map:MapViewer, target:MapIconElement) : void
      {
         if(!this.mainCtr.visible)
         {
            return;
         }
         super.onMapElementRollOver(map,target);
      }
      
      override protected function createContextMenu(contextMenu:Array = null) : void
      {
         if(!contextMenu)
         {
            contextMenu = [];
         }
         var hintsFilters:Array = [];
         for(var i:int = 0; i < this._hintCategoryNames.length; i++)
         {
            hintsFilters.push(modContextMenu.createContextMenuItemObject(this._hintCategoryNames[i],this.showFilter,[i + 1],false,null,__hintCategoryFiltersList[i + 1],false));
         }
         contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.map.mapFilters"),null,null,false,hintsFilters));
         super.createContextMenu(contextMenu);
      }
      
      override protected function getMapPresetsData() : Array
      {
         return sysApi.getData(MAP_PRESET_DATA_NAME,DataStoreEnum.BIND_ACCOUNT);
      }
      
      override protected function saveCurrentMapPreset() : void
      {
         if(__worldMapInfo)
         {
            getMapPresets()[_currentWorldId] = mapViewer.zoomFactor;
            sysApi.setData(MAP_PRESET_DATA_NAME,getMapPresets(),DataStoreEnum.BIND_ACCOUNT);
         }
      }
      
      override protected function getPresetScale() : Number
      {
         return getMapPresets()[_currentWorldId];
      }
      
      override protected function shouldRestorePosition() : Boolean
      {
         return false;
      }
      
      override protected function onMapHintsFilter(layerId:int, displayed:Boolean, fromCartography:Boolean) : void
      {
      }
      
      override protected function loadMapFilters(pFiltersList:Array, pMapFilterId:String) : void
      {
         super.loadMapFilters(pFiltersList,"mapFilters_miniMap");
      }
      
      override protected function saveMapFilters(pFiltersList:Array, pMapFilterId:String) : void
      {
         super.saveMapFilters(pFiltersList,"mapFilters_miniMap");
      }
      
      private function showFilter(pFilterId:uint) : void
      {
         __hintCategoryFiltersList[pFilterId] = !__hintCategoryFiltersList[pFilterId];
         showHints(__hintCategoryFiltersList);
         mapViewer.updateMapElements();
         this.saveMapFilters(__hintCategoryFiltersList,"mapFilters_miniMap");
      }
      
      private function onMapComplementaryInformationsData(map:WorldPointWrapper, subAreaId:int, displayInfo:Boolean) : void
      {
         var worldMap:WorldMap = null;
         var outdoorCoordinateX:int = 0;
         var outdoorCoordinateY:int = 0;
         var mapElement:MapElement = null;
         var hintUri:String = null;
         var coordinate:BreachWorldMapCoordinate = null;
         if(sysApi.getPlayerManager().isMapInHavenbag(map.mapId))
         {
            return;
         }
         var hasChangedWorldMap:Boolean = false;
         var subArea:SubArea = dataApi.getSubArea(subAreaId);
         if(subArea)
         {
            worldMap = subArea.worldmap;
            if(worldMap && worldMap.id != _currentWorldId)
            {
               __switchingMapUi = false;
               if(!subArea.hasCustomWorldMap && !playerApi.isInBreach())
               {
                  openNewMap(subArea.area.superArea.worldmap,MAP_TYPE_SUPERAREA,subArea.area.superArea);
               }
               else if(playerApi.isInBreach())
               {
                  openNewMap(dataApi.getWorldMap(23),MAP_TYPE_SUBAREA,dataApi.getSubArea(904));
               }
               else
               {
                  openNewMap(subArea.worldmap,MAP_TYPE_SUBAREA,subArea);
               }
               hasChangedWorldMap = true;
            }
         }
         var newPlayerPos:WorldPointWrapper = playerApi.currentMap();
         var breachWorldMapCoordinate:BreachWorldMapCoordinate = !breachApi.breachFrame ? null : dataApi.getBreachWorldMapCoordinate(Math.max(dataApi.getBreachMinStageWorldMapCoordinate().mapStage,Math.min(breachApi.getFloor(),dataApi.getBreachMaxStageWorldMapCoordinate().mapStage)));
         if(__centerOnPlayer || hasChangedWorldMap || (newPlayerPos.outdoorX != __playerPos.outdoorX || newPlayerPos.outdoorY != __playerPos.outdoorY) || breachWorldMapCoordinate || playerApi.isInHouse() || playerApi.isIndoor() || playerApi.isInBreachSubArea())
         {
            __centerOnPlayer = false;
            __playerPos = playerApi.currentMap();
            removeFlag("flag_playerPosition");
            outdoorCoordinateX = __playerPos.outdoorX;
            outdoorCoordinateY = __playerPos.outdoorY;
            if(breachWorldMapCoordinate && playerApi.isInBreach())
            {
               outdoorCoordinateX = breachWorldMapCoordinate.mapCoordinateX;
               outdoorCoordinateY = breachWorldMapCoordinate.mapCoordinateY;
            }
            if(playerApi.isInBreach() || playerApi.isInBreachSubArea())
            {
               _showMapCoords = false;
               for each(mapElement in mapViewer.getMapElementsByLayer(MAP_LAYER_BREACH))
               {
                  mapViewer.removeMapElement(mapElement);
               }
               hintUri = uiApi.me().getConstant("hintIcons");
               for each(coordinate in dataApi.getAllBreachWorldMapCoordinate())
               {
                  if(!mapViewer.getMapElement("breachIcon_" + coordinate.mapStage))
                  {
                     mapViewer.addBreachIcon(MAP_LAYER_BREACH,"breachIcon_" + coordinate.mapStage,hintUri + this.getBreachIconByFloor(coordinate) + ".png",coordinate.mapCoordinateX,coordinate.mapCoordinateY,1.5,coordinate.mapStage < 200 ? uiApi.getText("ui.breach.floors",breachMinStage,coordinate.mapStage) : uiApi.getText("ui.breach.floor",coordinate.mapStage),false,-1,false,HintPriorityEnum.FLAGS);
                  }
               }
            }
            addFlag("flag_playerPosition",uiApi.getText("ui.cartography.yourposition"),outdoorCoordinateX,outdoorCoordinateY,39423,false,true,false);
            mapViewer.moveTo(outdoorCoordinateX,outdoorCoordinateY);
         }
      }
      
      private function getBreachIconByFloor(coord:BreachWorldMapCoordinate) : int
      {
         if(!breachApi.breachFrame || !breachApi.getFloor() || coord.mapStage > breachApi.getFloor())
         {
            return coord.unexploredMapIcon;
         }
         return coord.exploredMapIcon;
      }
      
      private function onShowEntitiesTooltips(pVisible:Boolean) : void
      {
         this._entitiesTooltipsVisible = this.btn_showEntitiesTooltips.selected = pVisible;
      }
      
      private function onHighlightInteractiveElements(pVisible:Boolean) : void
      {
         this._interactiveElementsHighlighted = this.btn_highlightInteractiveElements.selected = pVisible;
      }
      
      private function onMapFightCount(fightCount:uint) : void
      {
         _nFightCount = fightCount;
         this.btn_viewFights.softDisabled = _nFightCount == 0;
         this.btn_viewFights.mouseEnabled = !this.btn_viewFights.softDisabled;
      }
      
      private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*) : void
      {
         gridDisplayed = configApi.getConfigProperty("dofus","showMiniMapGrid");
      }
      
      private function onShowFightPositions(pVisible:Boolean) : void
      {
         this._fightPositionsVisible = pVisible;
      }
      
      private function onUpdateKnownZaaps(knownZaaps:Vector.<Number>) : void
      {
         var worldPoint:WorldPointWrapper = null;
         var mapIconElements:Array = null;
         var mapIconElement:MapIconElement = null;
         var mapId:Number = NaN;
         if(knownZaaps === null || knownZaaps.length <= 0)
         {
            return;
         }
         for each(mapId in knownZaaps)
         {
            worldPoint = new WorldPointWrapper(mapId);
            mapIconElements = mapViewer.getMapElementsAtCoordinates(worldPoint.outdoorX,worldPoint.outdoorY);
            if(mapIconElements !== null && mapIconElements.length > 0)
            {
               for each(mapIconElement in mapIconElements)
               {
                  mapViewer.updateIconUri(mapIconElement,__hintIconsRootPath + KNOWN_ZAAP_ICON_ID + ".png");
               }
            }
         }
      }
   }
}
