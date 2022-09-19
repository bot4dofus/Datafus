package Ankama_Cartography.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_Cartography.ui.type.Flag;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.MapAreaShape;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AnomalySubareaInformation;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AbstractCartographyUi
   {
      
      private static const MAX_CUSTOM_FLAGS:int = 6;
      
      protected static var _nbCustomFlags:Array = [];
      
      protected static var __currentMapTooltip:UiRootContainer;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      public var mapViewer:MapViewer;
      
      public var btn_zoomIn:ButtonContainer;
      
      public var btn_zoomOut:ButtonContainer;
      
      protected var _currentSuperarea:SuperArea;
      
      protected var _currentWorldId:int;
      
      protected var __currentMapElement:MapIconElement;
      
      protected var __areaShapeDisplayed:Array;
      
      protected var __lastHighlightElement:String = "";
      
      protected var __lastHighlightAnomaly:String = "";
      
      protected var __conquestSubAreasInfos:Dictionary;
      
      protected var __subAreasInfos:Vector.<AnomalySubareaInformation>;
      
      protected var __hintCaptions:Dictionary;
      
      protected var __contextMenuIsActive:Boolean;
      
      protected var __lastMx:Number;
      
      protected var __lastMy:Number;
      
      private var _lastSubAreaId:int;
      
      private var _mouseOnMapViewer:Boolean;
      
      protected var _showMapCoords:Boolean = true;
      
      private var _zoomValue:Number = 1;
      
      private var _initialZoom:Boolean = true;
      
      protected var minValue:Number = 0.2;
      
      protected var maxValue:Number = 1;
      
      public function AbstractCartographyUi()
      {
         this.__areaShapeDisplayed = [];
         this.__hintCaptions = new Dictionary();
         super();
      }
      
      public function get currentSuperarea() : SuperArea
      {
         return this._currentSuperarea;
      }
      
      public function main(params:Object = null) : void
      {
         __currentMapTooltip = this.uiApi.loadUi("cartographyTooltip","cartographyCurrentMapTooltip",{
            "mapX":0,
            "mapY":0,
            "subAreaId":-1,
            "mapElements":[],
            "mouseOnArrow":this.mapViewer.mouseOnArrow,
            "showMapCoords":this._showMapCoords
         },StrataEnum.STRATA_TOOLTIP,null,true);
         __currentMapTooltip.visible = false;
         this._lastSubAreaId = -1;
         this.__contextMenuIsActive = false;
         this.sysApi.addHook(CustomUiHookList.FlagRemoved,this.onFlagRemoved);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONRIGHTCLICK);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK);
         this.uiApi.addComponentHook(this.mapViewer,ComponentHookList.ON_MAP_ELEMENT_ROLL_OVER);
         this.uiApi.addComponentHook(this.mapViewer,ComponentHookList.ON_MAP_ELEMENT_ROLL_OUT);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONDOUBLECLICK);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONMAPMOVE);
         this.uiApi.addComponentHook(this.mapViewer,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mapViewer,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONMAPROLLOVER);
         this.uiApi.addComponentHook(this.mapViewer,EventEnums.EVENT_ONMAPROLLOUT);
         this.uiApi.addComponentHook(this.mapViewer,ComponentHookList.ON_PRESS);
         this.uiApi.addComponentHook(this.btn_zoomIn,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_zoomIn,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_zoomIn,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_zoomOut,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_zoomOut,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_zoomOut,ComponentHookList.ON_ROLL_OUT);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onCloseUi);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
      }
      
      public function get superAreaId() : int
      {
         if(this._currentSuperarea)
         {
            return this._currentSuperarea.id;
         }
         return -1;
      }
      
      public function get currentWorldId() : int
      {
         return this._currentWorldId;
      }
      
      public function unload() : void
      {
         this.hideCurrentMapTooltip();
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var shortcut:Shortcut = null;
         if(__currentMapTooltip && __currentMapTooltip.visible)
         {
            shortcut = this.bindsApi.getShortcutsFromKeyCode(keyCode);
            if(shortcut && shortcut.name == ShortcutHookListEnum.CAPTURE_SCREEN)
            {
               return;
            }
         }
         this.hideCurrentMapTooltip();
      }
      
      protected function addCustomFlag(pX:int, pY:int) : void
      {
         var flag:Flag = null;
         var flagExists:Boolean = false;
         this.mapViewer.enabledDrag = true;
         this.mapViewer.useFlagCursor = false;
         var flagId:String = "flag_custom_" + pX + "_" + pY;
         var flags:Array = this.modCartography.getFlags(this._currentWorldId);
         for each(flag in flags)
         {
            if(flag.id == flagId)
            {
               flagExists = true;
               break;
            }
         }
         if(!flagExists)
         {
            if(!_nbCustomFlags[this._currentWorldId])
            {
               _nbCustomFlags[this._currentWorldId] = 1;
            }
            else
            {
               if(_nbCustomFlags[this._currentWorldId] >= MAX_CUSTOM_FLAGS)
               {
                  return;
               }
               ++_nbCustomFlags[this._currentWorldId];
            }
         }
         this.sysApi.dispatchHook(HookList.AddMapFlag,flagId,this.uiApi.getText("ui.cartography.customFlag") + " (" + pX + "," + pY + ")",this._currentWorldId,pX,pY,16768256);
      }
      
      protected function addCustomFlagWithRightClick(pX:Number, pY:Number) : void
      {
         this.mapViewer.enabledDrag = false;
         this.addCustomFlag(pX,pY);
      }
      
      protected function createContextMenu(contextMenu:Array = null) : void
      {
         var flagActionText:String = null;
         var flagAction:Function = null;
         var flagActionParams:Array = null;
         var flag:Flag = null;
         if(!contextMenu)
         {
            contextMenu = [];
         }
         contextMenu.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.map.removeAllFlags"),this.removeAllFlags,[]));
         var flagId:String = "flag_custom_" + this.mapViewer.currentMouseMapX + "_" + this.mapViewer.currentMouseMapY;
         var flagExists:Boolean = false;
         var flagList:Array = this.modCartography.getFlags(this._currentWorldId);
         for each(flag in flagList)
         {
            if(flag.id == flagId)
            {
               flagExists = true;
               break;
            }
         }
         if(!flagExists)
         {
            flagActionText = this.uiApi.getText("ui.map.flag");
            flagAction = this.addCustomFlagWithRightClick;
            flagActionParams = [this.mapViewer.currentMouseMapX,this.mapViewer.currentMouseMapY];
         }
         else
         {
            flagActionText = this.uiApi.getText("ui.map.removeFlag");
            flagAction = this.sysApi.dispatchHook;
            flagActionParams = ["RemoveMapFlag",flagId,this._currentWorldId];
         }
         contextMenu.unshift(this.modContextMenu.createContextMenuItemObject(flagActionText,flagAction,flagActionParams,_nbCustomFlags[this._currentWorldId] && _nbCustomFlags[this._currentWorldId] >= MAX_CUSTOM_FLAGS));
         this.modContextMenu.createContextMenu(contextMenu,null,this.onContextMenuClose);
      }
      
      public function removeFlag(flagId:String) : void
      {
         var flag:MapElement = this.mapViewer.getMapElement(flagId);
         if(flag)
         {
            this.mapViewer.removeMapElement(flag);
         }
      }
      
      private function removeAllFlags() : void
      {
         this.sysApi.dispatchHook(HookList.RemoveAllFlags);
      }
      
      protected function getSubAreaFromCoords(pX:int, pY:int) : Array
      {
         var mapId:Number = NaN;
         var mapPosition:MapPosition = null;
         var subArea:SubArea = null;
         var mapSubArea:SubArea = null;
         var subAreaName:String = null;
         var subAreaInfo:Array = null;
         var mapIds:Vector.<Number> = this.mapApi.getMapIdByCoord(pX,pY);
         for each(mapId in mapIds)
         {
            mapPosition = this.mapApi.getMapPositionById(mapId);
            if(mapPosition.worldMap != -1 && (!subArea || mapPosition.hasPriorityOnWorldmap))
            {
               mapSubArea = mapPosition.subArea;
               if(mapSubArea && mapSubArea.worldmap && mapSubArea.worldmap.id == this._currentWorldId)
               {
                  subArea = mapSubArea;
                  if(mapPosition.name && mapPosition.name.length > 0)
                  {
                     subAreaName = mapPosition.name;
                  }
                  else
                  {
                     subAreaName = subArea.name;
                  }
               }
            }
         }
         if(subArea)
         {
            subAreaInfo = [subArea,subAreaName];
         }
         return subAreaInfo;
      }
      
      protected function rollOutMapAreaShape(pAreaShape:String) : void
      {
         var mapAreaShape:MapElement = this.mapViewer.getMapElement(pAreaShape);
         if(mapAreaShape && mapAreaShape.classType == "MapAreaShape")
         {
            if(this.__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
            {
               this.mapViewer.areaShapeColorTransform(mapAreaShape as MapAreaShape,100,1,1,1,0);
            }
            else
            {
               this.mapViewer.areaShapeColorTransform(mapAreaShape as MapAreaShape,100,1,1,1,1);
            }
         }
      }
      
      protected function rollOverMapAreaShape(pAreaShape:String) : void
      {
         var mapAreaShape:MapElement = this.mapViewer.getMapElement(pAreaShape);
         if(mapAreaShape && mapAreaShape.classType == "MapAreaShape")
         {
            if(this.__areaShapeDisplayed.indexOf(mapAreaShape.layer) == -1)
            {
               this.mapViewer.areaShapeColorTransform(mapAreaShape as MapAreaShape,100,1,1,1,1);
            }
            else
            {
               this.mapViewer.areaShapeColorTransform(mapAreaShape as MapAreaShape,100,1.2,1.2,1.2,1.5);
            }
         }
      }
      
      protected function onFlagRemoved(pFlagId:String, pWorldMapId:int) : void
      {
         if(pFlagId.indexOf("flag_custom") != -1 && _nbCustomFlags[pWorldMapId] && _nbCustomFlags[pWorldMapId] > 0)
         {
            --_nbCustomFlags[pWorldMapId];
         }
         var tooltip:UiRootContainer = this.uiApi.getUi("cartographyCurrentMapTooltip");
         if(tooltip && tooltip.uiClass.hasElement(pFlagId))
         {
            this.onMapRollOver(null,this.__lastMx,this.__lastMy);
         }
      }
      
      protected function onContextMenuClose() : void
      {
         this.__contextMenuIsActive = false;
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         __currentMapTooltip.visible = false;
         if(target == this.mapViewer)
         {
            this.sysApi.dispatchHook(HookList.CloseContextMenu);
         }
      }
      
      public function onMapMove(target:MapViewer) : void
      {
         this.zoom = this.mapViewer.zoomFactor;
         this.__currentMapElement = null;
      }
      
      protected function get zoom() : Number
      {
         return this._zoomValue;
      }
      
      protected function set zoom(v:Number) : void
      {
         this.normalizeValue(v);
      }
      
      private function normalizeValue(forceValue:Number = NaN) : void
      {
         var v:Number = !!isNaN(forceValue) ? Number(this._zoomValue) : Number(forceValue);
         if(this.minValue < this.maxValue)
         {
            if(v > this.maxValue)
            {
               v = this.maxValue;
            }
            if(v < this.minValue)
            {
               v = this.minValue;
            }
         }
         else
         {
            if(v < this.maxValue)
            {
               v = this.maxValue;
            }
            if(v > this.minValue)
            {
               v = this.minValue;
            }
         }
         if(this._initialZoom || v != this._zoomValue)
         {
            this._initialZoom = false;
            this._zoomValue = v;
            try
            {
               this.mapViewer.zoom(this._zoomValue);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_zoomIn:
               this.zoom += (this.mapViewer.maxScale - this.mapViewer.minScale) / 5;
               break;
            case this.btn_zoomOut:
               this.zoom -= (this.mapViewer.maxScale - this.mapViewer.minScale) / 5;
         }
      }
      
      public function onCloseUi(pShortCut:String) : Boolean
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
         return true;
      }
      
      public function onDoubleClick(target:MapViewer) : void
      {
         switch(target)
         {
            case this.mapViewer:
               if(this.sysApi.hasRight())
               {
                  this.mapApi.movePlayer(this.mapViewer.currentMouseMapX,this.mapViewer.currentMouseMapY,this._currentWorldId);
               }
         }
      }
      
      public function onRightClick(pTarget:MapViewer) : void
      {
         if(pTarget == this.mapViewer)
         {
            this.createContextMenu();
            this.__contextMenuIsActive = true;
            this.hideCurrentMapTooltip();
         }
      }
      
      public function onMapElementRightClick(pMap:MapViewer, pTarget:MapIconElement) : void
      {
         if(pTarget.id.indexOf("flag_playerPosition") != -1)
         {
            return;
         }
         var contextMenu:ContextMenuData = this.menuApi.create(pTarget,"mapFlag",[this._currentWorldId]);
         if(contextMenu.content.length > 0)
         {
            this.modContextMenu.createContextMenu(contextMenu,null,this.onContextMenuClose);
            this.__contextMenuIsActive = true;
         }
      }
      
      public function onMapElementRollOut(pMap:MapViewer, target:MapIconElement) : void
      {
         this.__currentMapElement = null;
         if(this._mouseOnMapViewer)
         {
            this.onMapRollOver(pMap,pMap.currentMouseMapX,pMap.currentMouseMapY);
         }
      }
      
      public function onMapElementRollOver(map:MapViewer, target:MapIconElement) : void
      {
         if(this.__currentMapElement != target)
         {
            this.__currentMapElement = target;
            this.onMapRollOver(map,target.x,target.y);
         }
      }
      
      public function onMapRollOver(target:MapViewer, x:int, y:int, searchSubArea:SubArea = null) : void
      {
         var currentAreaShape:String = null;
         var elementList:Object = null;
         var subAreaInfo:Array = null;
         var shapeName:String = null;
         if(this.__lastMx == x && this.__lastMy == y || this.uiApi.getMouseDown())
         {
            return;
         }
         this.__lastMx = x;
         this.__lastMy = y;
         var mapElements:Array = [];
         var currentMapElements:Array = this.mapViewer.getMapElementsAtCoordinates(x,y);
         if(currentMapElements.length)
         {
            for each(elementList in currentMapElements)
            {
               if(this.mapViewer.isLayerVisible(elementList.layer))
               {
                  mapElements.push({
                     "element":elementList,
                     "text":(!!this.__hintCaptions[elementList.id] ? this.__hintCaptions[elementList.id] : elementList.legend)
                  });
               }
            }
         }
         var subArea:SubArea = searchSubArea;
         if(!subArea)
         {
            subAreaInfo = this.getSubAreaFromCoords(x,y);
            if(subAreaInfo)
            {
               subArea = subAreaInfo[0];
            }
         }
         if(subArea && subArea.worldmap && subArea.worldmap.id == this._currentWorldId)
         {
            if(subArea.id != this._lastSubAreaId)
            {
               this._lastSubAreaId = subArea.id;
            }
            shapeName = !!searchSubArea ? "search_shape" : "shape";
            currentAreaShape = shapeName + subArea.id;
            if(currentAreaShape != this.__lastHighlightElement)
            {
               this.rollOutMapAreaShape(this.__lastHighlightElement);
               this.__lastHighlightElement = currentAreaShape;
               this.rollOverMapAreaShape(currentAreaShape);
            }
         }
         else
         {
            this.rollOutMapAreaShape(this.__lastHighlightElement);
            this.__lastHighlightElement = "";
         }
         if(!subArea && this._lastSubAreaId != -1)
         {
            this._lastSubAreaId = -1;
         }
         this.showCurrentMapTooltip(mapElements);
      }
      
      public function onMapRollOut(target:MapViewer) : void
      {
         this.__currentMapElement = null;
         this.hideCurrentMapTooltip();
      }
      
      protected function showCurrentMapTooltip(mapElements:Array) : void
      {
         var stageVisibleBounds:Rectangle = null;
         var mapBounds:Rectangle = null;
         var tooltipX:Number = NaN;
         var tooltipY:Number = NaN;
         if(__currentMapTooltip)
         {
            __currentMapTooltip.visible = true;
            __currentMapTooltip.uiClass.update({
               "mapX":this.__lastMx,
               "mapY":this.__lastMy,
               "subAreaId":this._lastSubAreaId,
               "mapElements":mapElements,
               "mouseOnArrow":this.mapViewer.mouseOnArrow,
               "showMapCoords":this._showMapCoords
            });
            stageVisibleBounds = this.uiApi.getVisibleStageBounds();
            mapBounds = this.mapViewer.currentMapBounds;
            tooltipX = mapBounds.x + mapBounds.width + 4;
            tooltipY = mapBounds.y + mapBounds.height + 4;
            if(-stageVisibleBounds.x + tooltipX + __currentMapTooltip.width > stageVisibleBounds.width)
            {
               tooltipX = mapBounds.x - __currentMapTooltip.width;
            }
            if(-stageVisibleBounds.y + tooltipY + __currentMapTooltip.uiClass.totalHeight > stageVisibleBounds.height)
            {
               tooltipY = mapBounds.y - __currentMapTooltip.uiClass.totalHeight;
            }
            __currentMapTooltip.x = tooltipX < stageVisibleBounds.x ? Number(stageVisibleBounds.x) : Number(tooltipX);
            __currentMapTooltip.y = tooltipY < stageVisibleBounds.y ? Number(stageVisibleBounds.y) : Number(tooltipY);
         }
      }
      
      protected function showAreaShape(layer:String, display:Boolean) : void
      {
         var i:int = 0;
         var elements:Array = this.mapViewer.getMapElementsByLayer(layer);
         var nb:int = elements.length;
         if(display)
         {
            if(layer == "bonusAreas")
            {
               this.showAreaShape("anomalyAreas",display);
            }
            if(this.__areaShapeDisplayed.indexOf(layer) == -1 && elements && elements.length != 0)
            {
               this.__areaShapeDisplayed.push(layer);
               for(i = 0; i < nb; i++)
               {
                  if(elements[i] is MapAreaShape)
                  {
                     this.mapViewer.areaShapeColorTransform(elements[i],100,1,1,1,1);
                  }
               }
            }
         }
         else
         {
            nb = elements.length;
            for(i = 0; i < nb; i++)
            {
               if(elements[i] is MapAreaShape)
               {
                  this.mapViewer.areaShapeColorTransform(elements[i],100,1,1,1,0);
               }
            }
         }
      }
      
      protected function hideCurrentMapTooltip() : void
      {
         if(__currentMapTooltip)
         {
            __currentMapTooltip.visible = false;
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         if(target == this.mapViewer)
         {
            this._mouseOnMapViewer = false;
            this.__lastMx = Number.NaN;
            this.__lastMy = Number.NaN;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target == this.mapViewer)
         {
            this._mouseOnMapViewer = true;
         }
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == "Ankama_ContextMenu" && this._mouseOnMapViewer)
         {
            this.__contextMenuIsActive = true;
         }
      }
   }
}
