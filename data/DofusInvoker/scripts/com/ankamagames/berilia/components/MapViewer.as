package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.MapElementRightClickMessage;
   import com.ankamagames.berilia.components.messages.MapElementRollOutMessage;
   import com.ankamagames.berilia.components.messages.MapElementRollOverMessage;
   import com.ankamagames.berilia.components.messages.MapMoveMessage;
   import com.ankamagames.berilia.components.messages.MapRollOutMessage;
   import com.ankamagames.berilia.components.messages.MapRollOverMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.MapElementManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.data.Map;
   import com.ankamagames.berilia.types.data.MapArea;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.LinkedMapIconElement;
   import com.ankamagames.berilia.types.graphic.MapAreaShape;
   import com.ankamagames.berilia.types.graphic.MapDisplayableElement;
   import com.ankamagames.berilia.types.graphic.MapGroupElement;
   import com.ankamagames.berilia.types.graphic.MapIconElement;
   import com.ankamagames.berilia.types.graphic.MapRouteShape;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.CursorSpriteManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class MapViewer extends GraphicContainer implements FinalizableUIComponent
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapViewer));
      
      private static var _iconUris:Dictionary = new Dictionary();
      
      public static var FLAG_CURSOR:Class;
       
      
      private var _showGrid:Boolean = false;
      
      private var _mapBitmapContainer:Sprite;
      
      private var _mapContainer:Sprite;
      
      private var _arrowContainer:Sprite;
      
      private var _grid:Shape;
      
      private var _areaShapesContainer:Sprite;
      
      private var _routeShapesContainer:Sprite;
      
      private var _groupsContainer:Sprite;
      
      private var _layersContainer:Sprite;
      
      private var _currentMapContainer:Sprite;
      
      private var _openedMapGroupElement:MapGroupElement;
      
      private var _elementsListsByCoordinates:Dictionary;
      
      private var _elementsByElementTexture:Dictionary;
      
      private var _elementTexturesByElement:Dictionary;
      
      private var _linkedElementByLayer:Dictionary;
      
      private var _lastMx:int;
      
      private var _lastMy:int;
      
      private var _currentMapRect:Rectangle;
      
      private var _currentMapPos:Point;
      
      private var _viewRect:Rectangle;
      
      private var _layers:Array;
      
      private var _mapElements:Dictionary;
      
      private var _dragging:Boolean;
      
      private var _currentMap:Map;
      
      private var _availableMaps:Array;
      
      private var _arrowPool:Array;
      
      private var _arrowsByElementTexture:Dictionary;
      
      private var _elementTexturesByArrow:Dictionary;
      
      private var _mapGroupElements:Dictionary;
      
      private var _lastScaleIconUpdate:Number = -1;
      
      private var _flagCursor:Sprite;
      
      private var _flagCursorVisible:Boolean;
      
      private var _mouseOnArrow:Boolean = false;
      
      private var _zoomLevels:Array;
      
      private var _visibleMapAreas:Vector.<MapArea>;
      
      private var _mapToClear:Map;
      
      private var _lastWheelZoom:Number;
      
      private var _currentZoomStep:Number;
      
      private var _currentMapIcon:Texture;
      
      private var _onMapElementsUpdated:Function;
      
      private var _lastIconScale:Number;
      
      private var _needIconResize:Boolean;
      
      public var mapWidth:Number;
      
      public var mapHeight:Number;
      
      public var origineX:int;
      
      public var origineY:int;
      
      public var maxScale:Number = 2;
      
      public var minScale:Number = 0.5;
      
      public var startScale:Number = 0.8;
      
      public var enabledDrag:Boolean = true;
      
      public var autoSizeIcon:Boolean = false;
      
      public var gridLineThickness:Number = 0.5;
      
      public var needMask:Boolean = true;
      
      private var _isMouseOver:Boolean = false;
      
      private var _lastMouseX:Number = 0;
      
      private var _lastMouseY:Number = 0;
      
      private var _openMapGroupElementIndex:int;
      
      public function MapViewer()
      {
         this._linkedElementByLayer = new Dictionary();
         this._availableMaps = [];
         this._arrowPool = [];
         this._arrowsByElementTexture = new Dictionary();
         this._elementTexturesByArrow = new Dictionary();
         this._mapGroupElements = new Dictionary();
         this._zoomLevels = [];
         super();
         MEMORY_LOG[this] = 1;
         if(StageShareManager.stage)
         {
            StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
      }
      
      private static function checkDuplicate(pElement:MapIconElement, pElements:Vector.<MapElement>) : Boolean
      {
         var elem:MapElement = null;
         var iconElem:MapIconElement = null;
         if(pElement.allowDuplicate || !pElement.legend)
         {
            return false;
         }
         for each(elem in pElements)
         {
            iconElem = elem as MapIconElement;
            if(iconElem && iconElem.legend == pElement.legend && iconElem.layer == pElement.layer)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function removeCustomCursor() : void
      {
         CursorSpriteManager.resetCursor();
      }
      
      public function set onMapElementsUpdated(pCallBack:Function) : void
      {
         this._onMapElementsUpdated = pCallBack;
      }
      
      public function get mapContainerBounds() : Rectangle
      {
         return new Rectangle(this._mapContainer.x,this._mapContainer.y,this._mapContainer.width,this._mapContainer.height);
      }
      
      public function get showGrid() : Boolean
      {
         return this._showGrid;
      }
      
      public function set showGrid(b:Boolean) : void
      {
         this._showGrid = b;
         this.drawGrid();
      }
      
      public function get isDragging() : Boolean
      {
         return this._dragging;
      }
      
      public function get visibleMaps() : Rectangle
      {
         var vX:Number = -(this._mapContainer.x / this._mapContainer.scaleX + this.origineX) / this.mapWidth;
         var vY:Number = -(this._mapContainer.y / this._mapContainer.scaleY + this.origineY) / this.mapHeight;
         var vWidth:Number = width / (this.mapWidth * this._mapContainer.scaleX);
         var vHeight:Number = height / (this.mapHeight * this._mapContainer.scaleY);
         var w:Number = Math.ceil(vWidth);
         var h:Number = Math.ceil(vHeight);
         return new Rectangle(vX,vY,w < 1 ? Number(1) : Number(w),h < 1 ? Number(1) : Number(h));
      }
      
      public function get currentMouseMapX() : int
      {
         return this._lastMx;
      }
      
      public function get currentMouseMapY() : int
      {
         return this._lastMy;
      }
      
      public function get currentMapBounds() : Rectangle
      {
         return this.getMapBounds(this._lastMx,this._lastMy);
      }
      
      public function getMapBounds(pX:int, pY:int) : Rectangle
      {
         if(!this._currentMapRect)
         {
            this._currentMapRect = new Rectangle();
         }
         if(!this._currentMapPos)
         {
            this._currentMapPos = new Point();
         }
         this._currentMapPos.x = pX * this.mapWidth + this.origineX;
         this._currentMapPos.y = pY * this.mapHeight + this.origineY;
         var p:Point = this._mapContainer.localToGlobal(this._currentMapPos);
         this._currentMapRect.x = p.x;
         this._currentMapRect.y = p.y;
         this._currentMapRect.width = this.mapWidth * this._mapContainer.scaleX;
         this._currentMapRect.height = this.mapHeight * this._mapContainer.scaleY;
         return this._currentMapRect;
      }
      
      public function get mapBounds() : Rectangle
      {
         var rect:Rectangle = new Rectangle();
         rect.x = Math.floor(-this.origineX / this.mapWidth);
         rect.y = Math.floor(-this.origineY / this.mapHeight);
         if(this._currentMap)
         {
            rect.width = Math.round(this._currentMap.initialWidth / this.mapWidth);
            rect.height = Math.round(this._currentMap.initialHeight / this.mapHeight);
         }
         else
         {
            rect.width = Math.round(this._mapBitmapContainer.width / this.mapWidth);
            rect.height = Math.round(this._mapBitmapContainer.height / this.mapHeight);
         }
         return rect;
      }
      
      public function set mapAlpha(value:Number) : void
      {
         this._mapBitmapContainer.alpha = value;
      }
      
      public function get mapPixelPosition() : Point
      {
         return new Point(this._mapContainer.x,this._mapContainer.y);
      }
      
      public function get zoomFactor() : Number
      {
         return this._mapContainer.scaleX;
      }
      
      override public function set width(nW:Number) : void
      {
         var update:* = false;
         if(!nW)
         {
            return;
         }
         update = nW != super.width;
         super.width = nW;
         if(finalized && update)
         {
            this.initMask();
            this.zoom(this._mapContainer.scaleX);
            this.updateVisibleChunck(false);
         }
      }
      
      override public function set height(nH:Number) : void
      {
         if(!nH)
         {
            return;
         }
         var update:* = nH != super.height;
         super.height = nH;
         if(finalized && update)
         {
            this.initMask();
            this.zoom(this._mapContainer.scaleX);
            this.updateVisibleChunck(false);
         }
      }
      
      public function setSize(w:Number, h:Number) : void
      {
         var update:Boolean = h != super.height || w != super.width;
         super.width = w;
         super.height = h;
         if(finalized && update)
         {
            this.initMask();
            this.zoom(this._mapContainer.scaleX);
            this.updateVisibleChunck(false);
         }
      }
      
      public function get zoomStep() : Number
      {
         return this._availableMaps.length > 0 ? Number(this.maxScale / (this._availableMaps.length * 2)) : Number(NaN);
      }
      
      public function get zoomLevels() : Array
      {
         return this._zoomLevels;
      }
      
      public function get allLayersVisible() : Boolean
      {
         var layer:Sprite = null;
         for each(layer in this._layers)
         {
            if(!layer.visible)
            {
               return false;
            }
         }
         return true;
      }
      
      public function isLayerVisible(pLayerName:String) : Boolean
      {
         return !!this._layers[pLayerName] ? Boolean(this._layers[pLayerName].visible) : false;
      }
      
      public function hasLayer(layerName:String) : Boolean
      {
         return this._layers[layerName] != null;
      }
      
      public function set mapScale(pScale:Number) : void
      {
         this._mapContainer.scaleX = this._mapContainer.scaleY = pScale;
      }
      
      public function get mouseOnArrow() : Boolean
      {
         return this._mouseOnArrow;
      }
      
      public function set currentMapIconVisible(pValue:Boolean) : void
      {
         this._currentMapIcon.visible = pValue;
      }
      
      public function get currentMapIconVisible() : Boolean
      {
         return this._currentMapIcon.visible;
      }
      
      override public function finalize() : void
      {
         var arrow:Texture = null;
         var child:InteractiveObject = null;
         destroy(this._mapBitmapContainer);
         destroy(this._mapContainer);
         destroy(this._areaShapesContainer);
         destroy(this._routeShapesContainer);
         destroy(this._groupsContainer);
         destroy(this._layersContainer);
         destroy(this._currentMapContainer);
         if(this._arrowPool && this._arrowsByElementTexture)
         {
            for each(arrow in this._arrowsByElementTexture)
            {
               this._arrowPool.push(arrow);
            }
            this._arrowsByElementTexture = new Dictionary();
         }
         MapElementManager.getInstance().removeAllElements(this);
         this._mapBitmapContainer = new Sprite();
         this._mapBitmapContainer.doubleClickEnabled = true;
         this._mapBitmapContainer.mouseChildren = false;
         this._mapBitmapContainer.mouseEnabled = false;
         this._mapBitmapContainer.name = "mapBitmapContainer";
         this._viewRect = new Rectangle();
         this.initMap();
         _finalized = true;
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i) as InteractiveObject;
            if(child)
            {
               child.doubleClickEnabled = true;
            }
         }
         super.finalize();
         getUi().iAmFinalized(this);
      }
      
      public function addLayer(name:String) : void
      {
         var s:Sprite = null;
         if(!this._layers[name])
         {
            s = new Sprite();
            s.name = "layer_" + name;
            s.mouseEnabled = false;
            s.doubleClickEnabled = true;
            this._layers[name] = s;
         }
         this._layersContainer.addChildAt(this._layers[name],0);
      }
      
      private function addMapElement(elem:MapElement) : void
      {
         if(!this._mapElements[elem.x])
         {
            this._mapElements[elem.x] = new Dictionary();
         }
         if(!this._mapElements[elem.x][elem.y])
         {
            this._mapElements[elem.x][elem.y] = new Vector.<MapElement>();
         }
         if(!(elem is MapIconElement) || !checkDuplicate(elem as MapIconElement,this._mapElements[elem.x][elem.y]))
         {
            this._mapElements[elem.x][elem.y].push(elem);
         }
      }
      
      private function addMapIconElementToListByCoordinate(elem:MapIconElement) : void
      {
         if(!this._elementsListsByCoordinates[elem.x])
         {
            this._elementsListsByCoordinates[elem.x] = new Dictionary(true);
         }
         if(!this._elementsListsByCoordinates[elem.x][elem.y])
         {
            this._elementsListsByCoordinates[elem.x][elem.y] = [];
         }
         this._elementsListsByCoordinates[elem.x][elem.y].push(elem);
      }
      
      private function getIconUri(uriPath:String) : Uri
      {
         if(!_iconUris[uriPath])
         {
            _iconUris[uriPath] = new Uri(uriPath);
         }
         return _iconUris[uriPath];
      }
      
      public function updateIconUri(mapIconElement:MapIconElement, uriPath:String) : void
      {
         if(mapIconElement.texture && mapIconElement.uri !== uriPath)
         {
            mapIconElement.texture.uri = this.getIconUri(uriPath);
         }
      }
      
      public function addIcon(layer:String, id:String, rawUri:String, x:int, y:int, scale:Number = 1, legend:String = null, follow:Boolean = false, color:int = -1, canBeGrouped:Boolean = true, canBeManuallyRemoved:Boolean = true, hitArea:Rectangle = null, mouseEnabled:Boolean = false, allowDuplicate:Boolean = false, priority:uint = 0) : MapIconElement
      {
         var uri:Uri = null;
         var t:TextureBase = null;
         var mie:MapIconElement = null;
         var hit:Sprite = null;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         var ct:ColorTransform = null;
         if(this._layers[layer] && this.mapBounds.contains(x,y))
         {
            uri = this.getIconUri(rawUri);
            t = uri.path && uri.fileType.toLowerCase() == "png" ? new TextureBitmap() : new Texture();
            t.mouseChildren = false;
            t.autoCenterBitmap = true;
            if(t is TextureBitmap)
            {
               TextureBitmap(t).smooth = true;
            }
            else if(t is Texture)
            {
               Texture(t).dispatchMessages = true;
            }
            if(uri.path)
            {
               t.uri = uri;
            }
            if(hitArea)
            {
               hit = new Sprite();
               hit.graphics.beginFill(0,0);
               hit.graphics.drawRect(hitArea.x,hitArea.y,hitArea.width,hitArea.height);
               hit.mouseEnabled = false;
               t.addChildAt(hit,0);
               t.hitArea = hit;
            }
            t.scaleX = t.scaleY = this._lastIconScale * MapDisplayableElement.SCALE_FACTOR;
            if(color != -1)
            {
               R = color >> 16 & 255;
               V = color >> 8 & 255;
               B = color >> 0 & 255;
               ct = new ColorTransform(0.6,0.6,0.6,1,R - 80,V - 80,B - 80);
               t.transform.colorTransform = ct;
            }
            mie = new MapIconElement(id,x,y,layer,t,color,legend,this,canBeManuallyRemoved,mouseEnabled,allowDuplicate,priority);
            mie.canBeGrouped = canBeGrouped;
            mie.follow = follow;
            this.addMapElement(mie);
            this._elementsByElementTexture[t] = mie;
            this._elementTexturesByElement[mie] = t;
            this.addMapIconElementToListByCoordinate(mie);
            mie.textureScale = this._lastIconScale;
            return mie;
         }
         return null;
      }
      
      public function addBreachIcon(layer:String, id:String, rawUri:String, x:int, y:int, scale:Number = 1, legend:String = null, follow:Boolean = false, color:int = -1, mouseEnabled:Boolean = false, priority:uint = 0) : MapIconElement
      {
         var uri:Uri = null;
         var t:TextureBase = null;
         var mie:MapIconElement = null;
         var hit:Sprite = null;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         var ct:ColorTransform = null;
         if(this._layers[layer] && this.mapBounds.contains(x,y))
         {
            if(!_iconUris[rawUri])
            {
               _iconUris[rawUri] = new Uri(rawUri);
            }
            uri = _iconUris[rawUri];
            t = uri.path && uri.fileType.toLowerCase() == "png" ? new TextureBitmap() : new Texture();
            t.mouseChildren = false;
            t.autoCenterBitmap = true;
            if(t is TextureBitmap)
            {
               TextureBitmap(t).smooth = true;
            }
            else if(t is Texture)
            {
               Texture(t).dispatchMessages = true;
            }
            if(uri.path)
            {
               t.uri = uri;
            }
            if(hitArea)
            {
               hit = new Sprite();
               hit.graphics.beginFill(0,0);
               hit.graphics.drawRect(hitArea.x,hitArea.y,hitArea.width,hitArea.height);
               hit.mouseEnabled = false;
               t.addChildAt(hit,0);
               t.hitArea = hit;
            }
            t.scale = scale;
            if(color != -1)
            {
               R = color >> 16 & 255;
               V = color >> 8 & 255;
               B = color >> 0 & 255;
               ct = new ColorTransform(0.6,0.6,0.6,1,R - 80,V - 80,B - 80);
               t.transform.colorTransform = ct;
            }
            mie = new MapIconElement(id,x,y,layer,t,color,legend,this,false,mouseEnabled,false,priority);
            mie.canBeGrouped = false;
            mie.canBeAutoSize = false;
            mie.follow = follow;
            this.addMapElement(mie);
            this._elementsByElementTexture[t] = mie;
            this._elementTexturesByElement[mie] = t;
            this.addMapIconElementToListByCoordinate(mie);
            mie.setScale(scale);
            return mie;
         }
         return null;
      }
      
      public function addLine(layer:String, id:String, fromX:int, fromY:int, toX:int, toY:int, rawUri:String, text:String = "", color:uint = 16711680) : MapIconElement
      {
         if(this._layers[layer] == null)
         {
            return null;
         }
         if(!_iconUris[rawUri])
         {
            _iconUris[rawUri] = new Uri(rawUri);
         }
         var uri:Uri = _iconUris[rawUri];
         var uriFileType:String = uri.fileType.toLowerCase();
         var uriPath:String = uri.path;
         var t:TextureBase = uriPath && uriFileType == "png" ? new TextureBitmap() : new Texture();
         t.mouseChildren = false;
         t.autoCenterBitmap = true;
         if(t is TextureBitmap)
         {
            TextureBitmap(t).smooth = true;
         }
         else if(t is Texture)
         {
            Texture(t).dispatchMessages = true;
         }
         if(uriPath)
         {
            t.uri = uri;
         }
         var mie:LinkedMapIconElement = new LinkedMapIconElement(null,id,fromX,fromY,layer,t,-1,text,this);
         this.addMapElement(mie);
         this._elementsByElementTexture[t] = mie;
         this._elementTexturesByElement[mie] = t;
         this.addMapIconElementToListByCoordinate(mie);
         t = uriPath && uriFileType == "png" ? new TextureBitmap() : new Texture();
         t.mouseChildren = false;
         t.autoCenterBitmap = true;
         if(t is TextureBitmap)
         {
            TextureBitmap(t).smooth = true;
         }
         else if(t is Texture)
         {
            Texture(t).dispatchMessages = true;
         }
         if(uriPath)
         {
            t.uri = uri;
         }
         mie = new LinkedMapIconElement(mie,id + "_link",toX,toY,layer,t,color,text,this);
         this.addMapElement(mie);
         if(this._linkedElementByLayer[mie.layer] == null)
         {
            this._linkedElementByLayer[mie.layer] = [];
         }
         this._linkedElementByLayer[mie.layer].push(mie);
         this._elementsByElementTexture[t] = mie;
         this._elementTexturesByElement[mie] = t;
         this.addMapIconElementToListByCoordinate(mie);
         return mie;
      }
      
      public function addRouteShape(layer:String, id:String, coordList:Vector.<int>, lineColor:uint = 0, lineAlpha:Number = 1, thickness:int = 4, completionColor:uint = 0, completionAlpha:Number = 0.5) : MapRouteShape
      {
         var oldRouteShape:MapRouteShape = null;
         var routeTexture:Texture = null;
         var graphic:Graphics = null;
         var coordCount:int = 0;
         var i:int = 0;
         var posX:int = 0;
         var posY:int = 0;
         var mapRouteShape:MapRouteShape = null;
         var cellElems:Vector.<MapElement> = null;
         if(this._layers[layer] && coordList)
         {
            oldRouteShape = MapElementManager.getInstance().getElementById(id,this) as MapRouteShape;
            if(oldRouteShape)
            {
               oldRouteShape.remove();
               cellElems = this._mapElements[oldRouteShape.x][oldRouteShape.y];
               cellElems.splice(cellElems.indexOf(oldRouteShape),1);
            }
            routeTexture = new Texture();
            routeTexture.mouseEnabled = false;
            routeTexture.mouseChildren = false;
            graphic = routeTexture.graphics;
            graphic.lineStyle(thickness,lineColor,lineAlpha,true);
            coordCount = coordList.length;
            if(coordCount > 1)
            {
               graphic.moveTo(coordList[0] * this.mapWidth + this.mapWidth / 2,coordList[1] * this.mapHeight + this.mapHeight / 2);
            }
            for(i = 2; i < coordCount; i += 2)
            {
               posX = coordList[i];
               posY = coordList[i + 1];
               graphic.lineTo(posX * this.mapWidth + this.mapWidth / 2,posY * this.mapHeight + this.mapHeight / 2);
            }
            mapRouteShape = new MapRouteShape(id,layer,routeTexture,this.origineX,this.origineY,coordList,this,lineColor,lineAlpha,thickness,completionColor,completionAlpha);
            this.addMapElement(mapRouteShape);
            return mapRouteShape;
         }
         return null;
      }
      
      public function updateRouteShapeCompletion(routeShapeName:String, posX:int, posY:int) : void
      {
         var routeShape:MapRouteShape = MapElementManager.getInstance().getElementById(routeShapeName,this) as MapRouteShape;
         if(!routeShape)
         {
            return;
         }
         routeShape.updateCompletion(posX,posY,this.mapWidth,this.mapHeight);
      }
      
      public function addAreaShape(layer:String, id:String, coordList:Vector.<int>, lineColor:uint = 0, lineAlpha:Number = 1, fillColor:uint = 0, fillAlpha:Number = 0.4, thickness:int = 4, removeFromOtherLayer:Boolean = true) : MapAreaShape
      {
         var oldAreaShape:MapAreaShape = null;
         var shapeZone:Texture = null;
         var graphic:Graphics = null;
         var nCoords:int = 0;
         var i:int = 0;
         var mapAreaShape:MapAreaShape = null;
         var cellElems:Vector.<MapElement> = null;
         var posX:int = 0;
         var posY:int = 0;
         if(this._layers[layer] && coordList)
         {
            oldAreaShape = MapAreaShape(MapElementManager.getInstance().getElementById(id,this));
            if(oldAreaShape)
            {
               if(oldAreaShape.lineColor == lineColor && oldAreaShape.fillColor == fillColor)
               {
                  return oldAreaShape;
               }
               if(removeFromOtherLayer || oldAreaShape.layer == layer)
               {
                  oldAreaShape.remove();
                  cellElems = this._mapElements[oldAreaShape.x][oldAreaShape.y];
                  cellElems.splice(cellElems.indexOf(oldAreaShape),1);
               }
            }
            shapeZone = new Texture();
            shapeZone.mouseEnabled = false;
            shapeZone.mouseChildren = false;
            graphic = shapeZone.graphics;
            graphic.lineStyle(thickness,lineColor,lineAlpha,true);
            graphic.beginFill(fillColor,fillAlpha);
            nCoords = coordList.length;
            for(i = 0; i < nCoords; i += 2)
            {
               posX = coordList[i];
               posY = coordList[i + 1];
               if(posX > 10000)
               {
                  graphic.moveTo((posX - 11000) * this.mapWidth,(posY - 11000) * this.mapHeight);
               }
               else
               {
                  graphic.lineTo(posX * this.mapWidth,posY * this.mapHeight);
               }
            }
            mapAreaShape = new MapAreaShape(id,layer,shapeZone,this.origineX,this.origineY,lineColor,fillColor,this);
            this.addMapElement(mapAreaShape);
            return mapAreaShape;
         }
         return null;
      }
      
      public function areaShapeColorTransform(me:MapAreaShape, duration:int, rM:Number = 1, gM:Number = 1, bM:Number = 1, aM:Number = 1, rO:Number = 0, gO:Number = 0, bO:Number = 0, aO:Number = 0) : void
      {
         me.colorTransform(duration,rM,gM,bM,aM,rO,gO,bO,aO);
      }
      
      public function getMapElement(id:String) : MapElement
      {
         var elem:MapElement = null;
         var line:Dictionary = null;
         var elems:Vector.<MapElement> = null;
         if(id == "")
         {
            return null;
         }
         var mapElem:MapElement = MapElementManager.getInstance().getElementById(id,this);
         if(!mapElem)
         {
            for each(line in this._mapElements)
            {
               for each(elems in line)
               {
                  for each(elem in elems)
                  {
                     if(elem.id == id)
                     {
                        mapElem = elem;
                        break;
                     }
                  }
               }
            }
         }
         return mapElem;
      }
      
      public function getMapElementsByLayer(layerId:String) : Array
      {
         var line:Dictionary = null;
         var elems:Vector.<MapElement> = null;
         var elem:MapElement = null;
         var elements:Array = [];
         for each(line in this._mapElements)
         {
            for each(elems in line)
            {
               for each(elem in elems)
               {
                  if(elem.layer == layerId)
                  {
                     elements.push(elem);
                  }
               }
            }
         }
         return elements;
      }
      
      public function getMapElementsAtCoordinates(x:int, y:int) : Array
      {
         if(!this._elementsListsByCoordinates[x] || !this._elementsListsByCoordinates[x][y])
         {
            return [];
         }
         return (this._elementsListsByCoordinates[x][y] as Array).sortOn("priority");
      }
      
      public function removeMapElement(me:MapElement, deleteME:Boolean = true) : void
      {
         var mie:MapIconElement = null;
         var iconTexture:TextureBase = null;
         var index2:int = 0;
         if(!me || !this._mapElements[me.x] || !this._mapElements[me.x][me.y])
         {
            return;
         }
         var cellElements:Vector.<MapElement> = this._mapElements[me.x][me.y];
         var index:int = cellElements.indexOf(me);
         if(index != -1)
         {
            mie = me as MapIconElement;
            if(mie)
            {
               iconTexture = this._elementTexturesByElement[mie];
               if(this._mapGroupElements[mie])
               {
                  if(mie.group)
                  {
                     mie.group.removeElement(mie);
                     mie.group = null;
                  }
                  this._mapGroupElements[mie].display();
                  delete this._mapGroupElements[mie];
               }
               if(this._arrowsByElementTexture[iconTexture] && this._arrowsByElementTexture[iconTexture].parent)
               {
                  this._arrowsByElementTexture[iconTexture].parent.removeChild(this._arrowsByElementTexture[iconTexture]);
                  this._arrowPool.push(this._arrowsByElementTexture[iconTexture]);
                  delete this._elementTexturesByArrow[this._arrowsByElementTexture[iconTexture]];
                  delete this._arrowsByElementTexture[iconTexture];
               }
               if(this._elementsListsByCoordinates[mie.x] && this._elementsListsByCoordinates[mie.x][mie.y])
               {
                  index2 = this._elementsListsByCoordinates[mie.x][mie.y].indexOf(mie);
                  if(index2 != -1)
                  {
                     this._elementsListsByCoordinates[mie.x][mie.y].splice(index2,1);
                  }
               }
               delete this._elementTexturesByElement[mie];
            }
            if(deleteME)
            {
               me.remove();
            }
            cellElements.splice(index,1);
         }
      }
      
      public function updateOneMapElement(elemId:String, x:int, y:int, legend:String = null) : Boolean
      {
         var mie:MapIconElement = null;
         var me:MapElement = this.getMapElement(elemId);
         if(me)
         {
            this.removeMapElement(me,false);
            me.x = x;
            me.y = y;
            this.addMapElement(me);
            if(me is MapIconElement)
            {
               mie = me as MapIconElement;
               this.addMapIconElementToListByCoordinate(mie);
               if(legend)
               {
                  mie.legend = legend;
               }
            }
            this.updateMapElements();
            return true;
         }
         return false;
      }
      
      public function updateMapElements() : void
      {
         EnterFrameDispatcher.addEventListener(this.processUpdateMapElements,EnterFrameConst.UPDATE_MAP_VIEWER);
      }
      
      private function processUpdateMapElements(e:Event) : void
      {
         var elemsArray:Dictionary = null;
         var elems:Vector.<MapElement> = null;
         EnterFrameDispatcher.removeEventListener(this.processUpdateMapElements);
         this.updateIconSize();
         for each(elemsArray in this._mapElements)
         {
            for each(elems in elemsArray)
            {
               this.updateMapCellElements(elems);
            }
         }
         this.updateIcons();
         if(this._onMapElementsUpdated != null)
         {
            this._onMapElementsUpdated.call();
         }
      }
      
      public function updateMapCellElements(elems:Vector.<MapElement>) : void
      {
         var icon:MapIconElement = null;
         var elem:MapElement = null;
         var group:MapGroupElement = null;
         var updateGroup:Boolean = false;
         var numGroupableIcons:int = 0;
         var lastNullGroupIcon:MapIconElement = null;
         for each(elem in elems)
         {
            icon = elem as MapIconElement;
            if(icon && icon.canBeGrouped)
            {
               if(icon.group != null)
               {
                  group = icon.group;
                  break;
               }
               lastNullGroupIcon = icon;
               numGroupableIcons++;
            }
         }
         if(numGroupableIcons > 1 && group == null)
         {
            group = new MapGroupElement(this);
            group.x = lastNullGroupIcon.x * this.mapWidth + this.origineX + this.mapWidth / 2;
            group.y = lastNullGroupIcon.y * this.mapHeight + this.origineY + this.mapHeight / 2;
            this._groupsContainer.addChild(group);
         }
         for each(elem in elems)
         {
            switch(true)
            {
               case elem is MapIconElement:
                  icon = elem as MapIconElement;
                  if(group && icon.canBeGrouped)
                  {
                     if(icon.group == group)
                     {
                        continue;
                     }
                     if(icon.group != null)
                     {
                        icon.group.removeElement(icon);
                     }
                     this._mapGroupElements[icon] = group;
                     icon.setTexturePosition(0,0);
                     group.addElement(icon);
                     updateGroup = true;
                  }
                  else
                  {
                     icon.group = null;
                     icon.setTexturePosition(icon.x * this.mapWidth + this.origineX + this.mapWidth / 2,icon.y * this.mapHeight + this.origineY + this.mapHeight / 2);
                     icon.setTextureParent(this._layers[elem.layer]);
                  }
                  break;
               case elem is MapAreaShape:
                  this.updateMapAreaShape(elem as MapAreaShape);
                  break;
               case elem is MapRouteShape:
                  this.updateMapRouteShape(elem as MapRouteShape);
                  break;
            }
         }
         if(updateGroup)
         {
            group.display();
         }
      }
      
      public function updateMapAreaShape(pShape:MapAreaShape) : void
      {
         var container:Sprite = this._layers[pShape.layer];
         if(container.parent != this._areaShapesContainer)
         {
            this._areaShapesContainer.addChild(container);
         }
         pShape.setTextureParent(container);
         pShape.setTexturePosition(pShape.x,pShape.y);
      }
      
      public function updateMapRouteShape(pShape:MapRouteShape) : void
      {
         var container:Sprite = this._layers[pShape.layer];
         if(container.parent != this._routeShapesContainer)
         {
            this._routeShapesContainer.addChild(container);
         }
         pShape.setTextureParent(container);
         pShape.setTexturePosition(pShape.x,pShape.y);
      }
      
      public function showLayer(name:String, display:Boolean = true) : void
      {
         var elem:LinkedMapIconElement = null;
         if(this._layers[name])
         {
            this._layers[name].visible = display;
            if(this._linkedElementByLayer[name] != null)
            {
               for each(elem in this._linkedElementByLayer[name])
               {
                  elem.showLines(display);
               }
            }
         }
      }
      
      public function showAllLayers(visible:Boolean = true) : void
      {
         var layer:Sprite = null;
         for each(layer in this._layers)
         {
            layer.visible = visible;
         }
         this.updateMapElements();
      }
      
      public function moveToPixel(x:int, y:int, zoomFactor:Number) : void
      {
         this._mapContainer.x = x;
         this._mapContainer.y = y;
         this._mapContainer.scaleX = zoomFactor;
         this._mapContainer.scaleY = zoomFactor;
         this.updateVisibleChunck();
      }
      
      public function moveTo(x:Number, y:Number, width:uint = 1, height:uint = 1, center:Boolean = true, autoZoom:Boolean = true) : void
      {
         var zoneWidth:int = 0;
         var zoneHeight:int = 0;
         var newX:int = 0;
         var newY:int = 0;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var diffX:Number = NaN;
         var diffY:Number = NaN;
         var viewRect:Rectangle = this.mapBounds;
         if(viewRect.left > x)
         {
            x = viewRect.left;
         }
         if(viewRect.top > y)
         {
            y = viewRect.top;
         }
         if(center)
         {
            zoneWidth = width * this.mapWidth * this._mapContainer.scaleX;
            if(zoneWidth > this.width && autoZoom)
            {
               this._mapContainer.scaleX = this.width / (this.mapWidth * width);
               this._mapContainer.scaleY = this._mapContainer.scaleX;
            }
            zoneHeight = height * this.mapHeight * this._mapContainer.scaleY;
            if(zoneHeight > this.height && autoZoom)
            {
               this._mapContainer.scaleY = this.height / (this.mapHeight * height);
               this._mapContainer.scaleX = this._mapContainer.scaleY;
            }
            newX = -(x * this.mapWidth + this.origineX) * this._mapContainer.scaleX - this.mapWidth / 2 * this._mapContainer.scaleX;
            newY = -(y * this.mapHeight + this.origineY) * this._mapContainer.scaleY - this.mapHeight / 2 * this._mapContainer.scaleY;
            offsetX = this.width / 2;
            offsetY = this.height / 2;
            diffX = Math.abs(-this._mapContainer.width - newX);
            if(diffX < offsetX)
            {
               offsetX += offsetX - diffX;
            }
            diffY = Math.abs(-this._mapContainer.height - newY);
            if(diffY < offsetY)
            {
               offsetY += offsetY - diffY;
            }
            this._mapContainer.x = newX + offsetX;
            this._mapContainer.y = newY + offsetY;
         }
         else
         {
            this._mapContainer.x = -(x * this.mapWidth + this.origineX) * this._mapContainer.scaleX;
            this._mapContainer.y = -(y * this.mapHeight + this.origineY) * this._mapContainer.scaleY;
         }
         var w:Number = !!this._currentMap ? Number(this._currentMap.initialWidth) : Number(this._mapBitmapContainer.width);
         var h:Number = !!this._currentMap ? Number(this._currentMap.initialHeight) : Number(this._mapBitmapContainer.height);
         if(this._mapContainer.x < width - w)
         {
            if(!center)
            {
               this._mapContainer.x = width - w;
            }
            else
            {
               this._mapContainer.x = 0;
            }
         }
         if(this._mapContainer.y < height - h)
         {
            if(!center)
            {
               this._mapContainer.y = height - h;
            }
            else
            {
               this._mapContainer.y = 0;
            }
         }
         if(this._mapContainer.x > 0)
         {
            this._mapContainer.x = 0;
         }
         if(this._mapContainer.y > 0)
         {
            this._mapContainer.y = 0;
         }
         this.updateVisibleChunck();
         Berilia.getInstance().handler.process(new MapMoveMessage(this));
         this._mouseOnArrow = false;
      }
      
      private function zoomWithScalePercent(scalePercent:int, coord:Point = null) : void
      {
         this.zoom(scalePercent / 100,coord);
      }
      
      public function zoom(scale:Number, coord:Point = null) : void
      {
         var w:Number = NaN;
         var h:Number = NaN;
         var r:Rectangle = null;
         var p:Point = null;
         if(scale > this.maxScale)
         {
            scale = this.maxScale;
         }
         if(scale < this.minScale)
         {
            scale = this.minScale;
         }
         if(this._currentMap)
         {
            if(this._currentMap.initialWidth * scale < width)
            {
               scale = width / this._currentMap.initialWidth;
            }
            if(this._currentMap.initialHeight * scale < height)
            {
               scale = height / this._currentMap.initialHeight;
            }
         }
         if(coord)
         {
            if(this._currentMap)
            {
               this._currentMap.currentScale = NaN;
            }
            this._mapContainer.x -= coord.x * scale - coord.x * this._mapContainer.scaleX;
            this._mapContainer.y -= coord.y * scale - coord.y * this._mapContainer.scaleY;
            this._mapContainer.scaleX = this._mapContainer.scaleY = scale;
            this._needIconResize = 62 * MapDisplayableElement.SCALE_FACTOR > this.mapWidth * scale || 62 * MapDisplayableElement.SCALE_FACTOR > this.mapHeight * scale;
            w = !!this._currentMap ? Number(this._currentMap.initialWidth) : Number(this._mapBitmapContainer.width);
            h = !!this._currentMap ? Number(this._currentMap.initialHeight) : Number(this._mapBitmapContainer.height);
            if(this._mapContainer.x < width - w * scale)
            {
               this._mapContainer.x = width - w * scale;
            }
            if(this._mapContainer.y < height - h * scale)
            {
               this._mapContainer.y = height - h * scale;
            }
            if(this._mapContainer.x > 0)
            {
               this._mapContainer.x = 0;
            }
            if(this._mapContainer.y > 0)
            {
               this._mapContainer.y = 0;
            }
            this.updateIconSize();
            this.processMapInfo();
            return;
         }
         r = this.visibleMaps;
         p = new Point((r.x + r.width / 2) * this.mapWidth + this.origineX,(r.y + r.height / 2) * this.mapHeight + this.origineY);
         this.zoom(scale,p);
      }
      
      public function addMap(zoom:Number, src:String, unscaleWitdh:uint, unscaleHeight:uint, chunckWidth:uint, chunckHeight:uint) : void
      {
         this._availableMaps.push(new Map(zoom,src,new Sprite(),unscaleWitdh,unscaleHeight,chunckWidth,chunckHeight));
         if(this._zoomLevels.indexOf(zoom) == -1)
         {
            this._zoomLevels.push(zoom);
            this._zoomLevels.sort(Array.NUMERIC);
         }
      }
      
      public function removeAllMap() : void
      {
         var map:Map = null;
         var area:MapArea = null;
         for each(map in this._availableMaps)
         {
            for each(area in map.areas)
            {
               area.free(true);
            }
         }
         this._availableMaps = [];
         this._zoomLevels.length = 0;
      }
      
      public function getOrigineFromPos(x:int, y:int) : Point
      {
         return new Point(-this._mapContainer.x / this._mapContainer.scaleX - x * this.mapWidth,-this._mapContainer.y / this._mapContainer.scaleY - y * this.mapHeight);
      }
      
      public function set useFlagCursor(pValue:Boolean) : void
      {
         if(!FLAG_CURSOR)
         {
            return;
         }
         if(pValue)
         {
            if(!this._flagCursor)
            {
               this._flagCursor = new Sprite();
               this._flagCursor.addChild(new FLAG_CURSOR());
            }
            CursorSpriteManager.displaySpecificCursor("mapViewerCursor",this._flagCursor);
         }
         else
         {
            CursorSpriteManager.resetCursor();
         }
         this._flagCursorVisible = pValue;
      }
      
      public function get useFlagCursor() : Boolean
      {
         return this._flagCursorVisible;
      }
      
      public function get allChunksLoaded() : Boolean
      {
         var mapArea:MapArea = null;
         if(!this._visibleMapAreas || !this._visibleMapAreas.length)
         {
            return false;
         }
         for each(mapArea in this._visibleMapAreas)
         {
            if(!mapArea.isLoaded)
            {
               return false;
            }
         }
         return true;
      }
      
      override public function remove() : void
      {
         var elements:Dictionary = null;
         var me:MapElement = null;
         Mouse.cursor = MouseCursor.AUTO;
         if(!__removed)
         {
            if(this._grid)
            {
               this._grid.cacheAsBitmap = false;
               if(this._mapContainer.contains(this._grid))
               {
                  this._mapContainer.removeChild(this._grid);
               }
            }
            if(this._mapToClear)
            {
               this.clearMap(this._mapToClear);
               this._mapToClear = null;
            }
            this.removeAllMap();
            elements = MapElementManager.getInstance().getOwnerElements(this);
            for each(me in elements)
            {
               if(this._mapGroupElements[me])
               {
                  delete this._mapGroupElements[me];
               }
               me.remove();
            }
            this._mapElements = null;
            this._elementsByElementTexture = null;
            this._elementTexturesByElement = null;
            this._elementsListsByCoordinates = null;
            this._mapGroupElements = null;
            this._visibleMapAreas = null;
            MapElementManager.getInstance().removeAllElements(this);
            EnterFrameDispatcher.removeEventListener(this.onMapEnterFrame);
            removeCustomCursor();
            EnterFrameDispatcher.removeEventListener(this.processUpdateMapElements);
            StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         }
         super.remove();
      }
      
      private function getIconTextureGlobalCoords(pMapIconElement:MapIconElement) : Point
      {
         var p:Point = null;
         var pp:PoolablePoint = null;
         var layer:Sprite = this._layers[pMapIconElement.layer] as Sprite;
         if(this._mapGroupElements[pMapIconElement])
         {
            pp = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
            p = layer.localToGlobal(pp.renew(this._mapGroupElements[pMapIconElement].x,this._mapGroupElements[pMapIconElement].y));
         }
         else
         {
            p = layer.localToGlobal(pMapIconElement.getTexturePosition());
         }
         return p;
      }
      
      private function updateIcons() : void
      {
         var iconTexture:TextureBase = null;
         var mie:MapIconElement = null;
         var iconVisible:Boolean = false;
         var elemsArray:Dictionary = null;
         var arrow:Texture = null;
         var angle:Number = NaN;
         var a:Number = NaN;
         var res:Number = NaN;
         var icon:* = undefined;
         var elems:Vector.<MapElement> = null;
         var me:MapElement = null;
         var tempArrow:Texture = null;
         var vr:Number = NaN;
         var iconRect:Rectangle = new Rectangle(0,0,1,1);
         var visibleMaps:Rectangle = this.visibleMaps;
         var currentPosition:Point = new Point(Math.floor(visibleMaps.x + visibleMaps.width / 2),Math.floor(visibleMaps.y + visibleMaps.height / 2));
         var globalPos:Point = parent.localToGlobal(new Point(x,y));
         var globalRect:Rectangle = new Rectangle(globalPos.x,globalPos.y,width,height);
         for each(elemsArray in this._mapElements)
         {
            for each(elems in elemsArray)
            {
               for each(me in elems)
               {
                  mie = me as MapIconElement;
                  if(mie)
                  {
                     iconRect.x = mie.x;
                     iconRect.y = mie.y;
                     iconTexture = this._elementTexturesByElement[mie];
                     if(iconTexture)
                     {
                        if(mie.follow)
                        {
                           iconVisible = !iconTexture.uri || !iconTexture.finalized || !iconTexture.parent ? Boolean(visibleMaps.intersects(iconRect)) : Boolean(globalRect.intersects(mie.getRealBounds));
                        }
                        else
                        {
                           iconVisible = true;
                        }
                        iconTexture.visible = this._layers[mie.layer].visible != false && iconVisible;
                        if(mie.group)
                        {
                           mie.group.setIconVisibility(mie,iconTexture.visible);
                        }
                        if(iconTexture is Texture)
                        {
                           if(iconTexture.visible && !iconTexture.finalized)
                           {
                              iconTexture.finalize();
                           }
                           Texture(iconTexture).gotoAndPlay = 1;
                        }
                        if(mie.follow)
                        {
                           if(iconTexture.visible && this._arrowsByElementTexture[iconTexture])
                           {
                              this._arrowContainer.removeChild(this._arrowsByElementTexture[iconTexture]);
                              this._arrowPool.push(this._arrowsByElementTexture[iconTexture]);
                              mie.boundsRef = null;
                              delete this._elementTexturesByArrow[this._arrowsByElementTexture[iconTexture]];
                              delete this._arrowsByElementTexture[iconTexture];
                           }
                           else if(mie.follow && !iconTexture.visible)
                           {
                              tempArrow = this.getIconArrow(iconTexture);
                              tempArrow.visible = this._layers[mie.layer].visible;
                              this._arrowContainer.addChild(tempArrow);
                              this._elementsByElementTexture[tempArrow] = mie;
                              mie.boundsRef = tempArrow;
                           }
                        }
                     }
                  }
               }
            }
         }
         angle = Math.atan2(0,-width / 2);
         for(icon in this._arrowsByElementTexture)
         {
            arrow = this._arrowsByElementTexture[icon];
            mie = this._elementsByElementTexture[icon];
            vr = Math.atan2(-mie.y + currentPosition.y,-mie.x + currentPosition.x);
            arrow.x = Math.cos(angle + vr) * width / 2;
            arrow.y = Math.sin(angle + vr) * height / 2;
            arrow.rotation = vr * (180 / Math.PI);
            a = arrow.y / arrow.x;
            vr += Math.PI;
            if(vr < Math.PI / 4 || vr > Math.PI * 7 / 4)
            {
               res = width / 2 * a + height / 2;
               if(res > 0 && res < height)
               {
                  arrow.x = width;
                  arrow.y = res;
                  continue;
               }
            }
            else if(vr < Math.PI * 3 / 4)
            {
               res = height / 2 / a + width / 2;
               res = res > width ? Number(width) : Number(res);
               if(res > 0)
               {
                  arrow.x = res;
                  arrow.y = height;
                  continue;
               }
            }
            else if(vr < Math.PI * 5 / 4)
            {
               res = -width / 2 * a + height / 2;
               if(res > 0 && res < height)
               {
                  arrow.x = 0;
                  arrow.y = res;
                  continue;
               }
            }
            else
            {
               res = -height / 2 / a + width / 2;
               res = res > width ? Number(width) : (res < 0 ? Number(0) : Number(res));
               if(res >= 0)
               {
                  arrow.x = res;
                  arrow.y = 0;
                  continue;
               }
            }
            if(arrow.rotation == -45)
            {
               arrow.x = 0;
               arrow.y = res;
            }
         }
      }
      
      private function getIconArrow(icon:TextureBase) : Texture
      {
         var arrow:Texture = null;
         if(this._arrowsByElementTexture[icon])
         {
            return this._arrowsByElementTexture[icon];
         }
         if(this._arrowPool.length)
         {
            this._arrowsByElementTexture[icon] = this._arrowPool.pop();
         }
         else
         {
            arrow = new Texture();
            arrow.uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "icons/assets.swf|arrow0");
            arrow.mouseEnabled = true;
            arrow.buttonMode = arrow.useHandCursor = true;
            arrow.finalize();
            this._arrowsByElementTexture[icon] = arrow;
         }
         this._elementTexturesByArrow[this._arrowsByElementTexture[icon]] = icon;
         Texture(this._arrowsByElementTexture[icon]).transform.colorTransform = icon.transform.colorTransform;
         return this._arrowsByElementTexture[icon];
      }
      
      private function processMapInfo() : void
      {
         var choosenMap:Map = null;
         var tmpZoomDist:Number = NaN;
         var map:Map = null;
         if(!this._availableMaps.length)
         {
            return;
         }
         this._lastScaleIconUpdate = -1;
         var zoomDist:Number = 10000;
         for each(map in this._availableMaps)
         {
            tmpZoomDist = Math.abs(this._mapContainer.scaleX - map.zoom);
            if(tmpZoomDist < zoomDist && this._mapContainer.scaleX <= map.zoom)
            {
               choosenMap = map;
               zoomDist = tmpZoomDist;
            }
         }
         if(choosenMap && (!this._currentMap || choosenMap != this._currentMap))
         {
            if(this._currentMap)
            {
               if(this._mapToClear)
               {
                  this.clearMap(this._mapToClear);
               }
               this._mapToClear = this._currentMap;
            }
            this._currentMap = choosenMap;
            this._mapBitmapContainer.graphics.beginFill(0,0);
            this._mapBitmapContainer.graphics.drawRect(0,0,this._currentMap.initialWidth,this._currentMap.initialHeight);
            this._mapBitmapContainer.graphics.endFill();
            this._mapBitmapContainer.addChild(this._currentMap.container);
            this._viewRect.width = width;
            this._viewRect.height = height;
         }
         this.updateVisibleChunck();
      }
      
      private function updateVisibleChunck(refreshIcons:Boolean = true) : void
      {
         if(!this._currentMap || !this._currentMap.areas)
         {
            return;
         }
         if(refreshIcons)
         {
            this.updateIcons();
         }
         var marge:uint = 100;
         this._viewRect.x = -this._mapContainer.x / this._mapContainer.scaleX - marge;
         this._viewRect.y = -this._mapContainer.y / this._mapContainer.scaleY - marge;
         this._viewRect.width = width / this._mapContainer.scaleX + marge * 2;
         this._viewRect.height = height / this._mapContainer.scaleY + marge * 2;
         this._visibleMapAreas = this._currentMap.loadAreas(this._viewRect);
      }
      
      private function initMask() : void
      {
         if(!this.needMask)
         {
            return;
         }
         if(this._mapContainer.mask)
         {
            this._mapContainer.mask.parent.removeChild(this._mapContainer.mask);
         }
         var maskCtr:Sprite = new Sprite();
         maskCtr.name = "maskCtr";
         maskCtr.doubleClickEnabled = true;
         maskCtr.graphics.beginFill(7798784,0.3);
         maskCtr.graphics.drawRect(0,0,width,height);
         addChild(maskCtr);
         this._mapContainer.mask = maskCtr;
      }
      
      private function initMap() : void
      {
         var mapRef:Map = null;
         this._mapContainer = new Sprite();
         this._mapContainer.name = "mapContainer";
         this._mapContainer.doubleClickEnabled = true;
         this.initMask();
         this._mapContainer.addChild(this._mapBitmapContainer);
         this._grid = new Shape();
         this.drawGrid();
         this._mapContainer.addChild(this._grid);
         this._areaShapesContainer = new Sprite();
         this._areaShapesContainer.name = "areaShapesContainer";
         this._areaShapesContainer.mouseEnabled = false;
         this._mapContainer.addChild(this._areaShapesContainer);
         this._routeShapesContainer = new Sprite();
         this._routeShapesContainer.name = "routeShapesContainer";
         this._routeShapesContainer.mouseEnabled = false;
         this._mapContainer.addChild(this._routeShapesContainer);
         this._layersContainer = new Sprite();
         this._layersContainer.name = "layersContainer";
         this._layersContainer.mouseEnabled = false;
         this._mapContainer.addChild(this._layersContainer);
         this._groupsContainer = new Sprite();
         this._groupsContainer.name = "groupsContainer";
         this._groupsContainer.mouseEnabled = false;
         this._mapContainer.addChild(this._groupsContainer);
         this._currentMapContainer = new Sprite();
         this._currentMapContainer.name = "currentMapContainer";
         this._currentMapContainer.mouseEnabled = false;
         this._mapContainer.addChild(this._currentMapContainer);
         this._currentMapIcon = new Texture();
         this._currentMapIcon.mouseEnabled = false;
         this._currentMapIcon.uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "icons/assets.swf|currenMapHighlight");
         this._currentMapIcon.finalize();
         this._currentMapContainer.addChild(this._currentMapIcon);
         addChild(this._mapContainer);
         this._arrowContainer = new Sprite();
         this._arrowContainer.name = "arrowContainer";
         this._arrowContainer.mouseEnabled = false;
         addChild(this._arrowContainer);
         this._mapElements = new Dictionary();
         this._layers = [];
         this._elementsByElementTexture = new Dictionary(true);
         this._elementTexturesByElement = new Dictionary(true);
         this._elementsListsByCoordinates = new Dictionary(true);
         if(this._availableMaps && this._availableMaps.length)
         {
            mapRef = Map(this._availableMaps[0]);
            this.minScale = Math.min(width / mapRef.initialWidth,height / mapRef.initialHeight);
            this.maxScale = this._zoomLevels[this._zoomLevels.length - 1];
            this.startScale = Math.min(width / (this.mapWidth * 3),height / (this.mapHeight * 3));
         }
         this.zoom(this.startScale);
      }
      
      private function drawGrid() : void
      {
         var offsetX:int = 0;
         var offsetY:int = 0;
         var i:uint = 0;
         var coordinate:Number = NaN;
         var verticalLineCount:uint = 0;
         var horizontalLineCount:uint = 0;
         if(!this._showGrid)
         {
            this._grid.graphics.clear();
         }
         else
         {
            offsetX = this.origineX % this.mapWidth;
            offsetY = this.origineY % this.mapHeight;
            this._grid.cacheAsBitmap = false;
            this._grid.graphics.lineStyle(1,7829367,this.gridLineThickness);
            verticalLineCount = this._mapBitmapContainer.width / this.mapWidth;
            for(i = 0; i < verticalLineCount; i++)
            {
               coordinate = i * this.mapWidth + offsetX;
               this._grid.graphics.moveTo(coordinate,0);
               this._grid.graphics.lineTo(coordinate,this._mapBitmapContainer.height);
            }
            horizontalLineCount = this._mapBitmapContainer.height / this.mapHeight;
            for(i = 0; i < horizontalLineCount; i++)
            {
               coordinate = i * this.mapHeight + offsetY;
               this._grid.graphics.moveTo(0,coordinate);
               this._grid.graphics.lineTo(this._mapBitmapContainer.width,coordinate);
            }
         }
      }
      
      public function updateIconSize(forceRefresh:Boolean = false) : void
      {
         var mie:MapIconElement = null;
         var elemsArray:Dictionary = null;
         var elems:Vector.<MapElement> = null;
         var me:MapElement = null;
         if(!forceRefresh && (!this.autoSizeIcon || this._lastScaleIconUpdate == this._mapContainer.scaleX))
         {
            return;
         }
         this._lastScaleIconUpdate = this._mapContainer.scaleX;
         var currentDo:DisplayObject = this._mapContainer;
         var realScale:Number = this._mapContainer.scaleX;
         while(currentDo && currentDo.parent)
         {
            currentDo = currentDo.parent;
            realScale *= currentDo.scaleX;
         }
         this._lastIconScale = 1 / realScale;
         this._lastIconScale = !!this._needIconResize ? Number(this._lastIconScale * 0.6) : Number(this._lastIconScale);
         for each(elemsArray in this._mapElements)
         {
            for each(elems in elemsArray)
            {
               for each(me in elems)
               {
                  mie = me as MapIconElement;
                  if(!(!mie || !mie.canBeAutoSize))
                  {
                     mie.textureScale = this._lastIconScale;
                  }
               }
            }
         }
      }
      
      private function clearMap(map:Map) : void
      {
         var i:uint = 0;
         var l:uint = map.areas.length;
         for(i = 0; i < l; i++)
         {
            map.areas[i].free();
         }
         if(map.container.parent == this._mapBitmapContainer)
         {
            this._mapBitmapContainer.removeChild(map.container);
         }
         map = null;
      }
      
      override public function process(msg:Message) : Boolean
      {
         var preventMsgToContinue:* = false;
         var trmsg:TextureReadyMessage = null;
         var movmsg:MouseOverMessage = null;
         var currentTarget:DisplayObjectContainer = null;
         var moumsg:MouseOutMessage = null;
         var isMouseOver:Boolean = false;
         var mdmsg:MouseDownMessage = null;
         var evilMacUser:* = false;
         var mcmsg:MouseClickMessage = null;
         var mwmsg:MouseWheelMessage = null;
         var zoomPoint:Point = null;
         var scaleAsPercent:int = 0;
         var mrcmsg:MouseRightClickMessage = null;
         var mapElement:MapElement = null;
         var me:MapElement = null;
         switch(true)
         {
            case msg is TextureReadyMessage:
               trmsg = msg as TextureReadyMessage;
               trmsg.texture.gotoAndPlay = 1;
               break;
            case msg is MouseOverMessage:
               movmsg = msg as MouseOverMessage;
               preventMsgToContinue = Boolean(this._isMouseOver);
               this._isMouseOver = mouseX >= 0 && mouseY >= 0 && mouseX <= width && mouseY <= height;
               Mouse.cursor = MouseCursor.HAND;
               this._currentMapIcon.visible = true;
               currentTarget = movmsg.target as DisplayObjectContainer;
               while(currentTarget)
               {
                  if(currentTarget == this)
                  {
                     EnterFrameDispatcher.addEventListener(this.onMapEnterFrame,EnterFrameConst.MAP_MOUSE);
                     break;
                  }
                  currentTarget = currentTarget.parent;
               }
               if(currentTarget != this)
               {
                  preventMsgToContinue = true;
                  this._isMouseOver = false;
               }
               this._mouseOnArrow = movmsg.target.parent == this._arrowContainer;
               if(movmsg.target is MapGroupElement)
               {
                  this._openedMapGroupElement = MapGroupElement(movmsg.target);
               }
               else if(movmsg.target.parent is MapGroupElement)
               {
                  this._openedMapGroupElement = MapGroupElement(movmsg.target.parent);
               }
               else if(!this._mouseOnArrow && this._mapGroupElements[this._elementsByElementTexture[movmsg.target]] is MapGroupElement)
               {
                  this._openedMapGroupElement = this._mapGroupElements[this._elementsByElementTexture[movmsg.target]];
               }
               if(this._elementsByElementTexture[movmsg.target])
               {
                  Berilia.getInstance().handler.process(new MapElementRollOverMessage(this,this._elementsByElementTexture[movmsg.target]));
               }
               else if(this._elementTexturesByArrow[movmsg.target] && this._elementsByElementTexture[this._elementTexturesByArrow[movmsg.target]])
               {
                  Berilia.getInstance().handler.process(new MapElementRollOverMessage(this,this._elementsByElementTexture[this._elementTexturesByArrow[movmsg.target]]));
               }
               return preventMsgToContinue;
            case msg is MouseOutMessage:
               moumsg = msg as MouseOutMessage;
               isMouseOver = mouseX >= 0 && mouseY >= 0 && mouseX <= width && mouseY <= height;
               preventMsgToContinue = this._isMouseOver == isMouseOver;
               this._isMouseOver = isMouseOver;
               Mouse.cursor = MouseCursor.AUTO;
               if(!moumsg.mouseEvent.relatedObject || !contains(moumsg.mouseEvent.relatedObject))
               {
                  this._currentMapIcon.visible = false;
                  Berilia.getInstance().handler.process(new MapRollOutMessage(this));
               }
               currentTarget = moumsg.target as DisplayObjectContainer;
               while(currentTarget)
               {
                  if(currentTarget == this)
                  {
                     if(!this._dragging)
                     {
                        EnterFrameDispatcher.removeEventListener(this.onMapEnterFrame);
                     }
                     break;
                  }
                  currentTarget = currentTarget.parent;
               }
               if(currentTarget != this)
               {
                  preventMsgToContinue = false;
                  this._isMouseOver = false;
               }
               this._mouseOnArrow = false;
               if(this._openedMapGroupElement)
               {
                  if(this._openedMapGroupElement.opened)
                  {
                     this._openedMapGroupElement.close();
                     this._openedMapGroupElement = null;
                  }
               }
               if(this._elementsByElementTexture[moumsg.target])
               {
                  Berilia.getInstance().handler.process(new MapElementRollOutMessage(this,this._elementsByElementTexture[moumsg.target]));
               }
               else if(this._elementTexturesByArrow[moumsg.target] && this._elementsByElementTexture[this._elementTexturesByArrow[moumsg.target]])
               {
                  Berilia.getInstance().handler.process(new MapElementRollOutMessage(this,this._elementsByElementTexture[this._elementTexturesByArrow[moumsg.target]]));
               }
               return preventMsgToContinue;
            case msg is MouseDownMessage:
               mdmsg = msg as MouseDownMessage;
               if(ShortcutsFrame.shiftKey)
               {
                  mapElement = !!this._elementsByElementTexture[mdmsg.target] ? this._elementsByElementTexture[mdmsg.target] : this._elementsByElementTexture[this._elementTexturesByArrow[mdmsg.target]];
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick,{
                     "data":this,
                     "params":{
                        "x":this._lastMx,
                        "y":this._lastMy,
                        "element":mapElement as MapIconElement
                     }
                  });
               }
               evilMacUser = SystemManager.getSingleton().os == OperatingSystem.MAC_OS;
               if(ShortcutsFrame.altKeyDown && !evilMacUser)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseAltClick,{
                     "data":this,
                     "params":{}
                  });
               }
               if(ShortcutsFrame.ctrlKeyDown || evilMacUser && ShortcutsFrame.altKeyDown)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseCtrlClick,{
                     "data":this,
                     "params":{
                        "x":this._lastMx,
                        "y":this._lastMy
                     }
                  });
               }
               if(!this.enabledDrag)
               {
                  return false;
               }
               this._dragging = true;
               return false;
               break;
            case msg is MouseClickMessage:
               mcmsg = msg as MouseClickMessage;
               if(this._elementTexturesByArrow[mcmsg.target])
               {
                  TooltipManager.hide();
                  me = this._elementsByElementTexture[this._elementTexturesByArrow[mcmsg.target]];
                  this.moveTo(me.x,me.y);
               }
               break;
            case msg is MouseReleaseOutsideMessage:
            case msg is MouseUpMessage:
               this._dragging = false;
               this._lastMouseX = 0;
               this.updateVisibleChunck();
               Berilia.getInstance().handler.process(new MapMoveMessage(this));
               return false;
            case msg is MouseWheelMessage:
               mwmsg = msg as MouseWheelMessage;
               if(getTimer() - this._lastWheelZoom < 100)
               {
                  this._currentZoomStep += this.zoomStep;
               }
               else
               {
                  this._currentZoomStep = this.zoomStep;
               }
               currentTarget = mwmsg.target as DisplayObjectContainer;
               while(currentTarget)
               {
                  if(currentTarget == this._mapContainer)
                  {
                     zoomPoint = new Point(currentTarget.mouseX,currentTarget.mouseY);
                     break;
                  }
                  currentTarget = currentTarget.parent;
               }
               if(!zoomPoint)
               {
                  return true;
               }
               scaleAsPercent = this._mapContainer.scaleX * 100 + (mwmsg.mouseEvent.delta > 0 ? 100 : -100) * this._currentZoomStep;
               this.zoomWithScalePercent(scaleAsPercent,zoomPoint);
               Berilia.getInstance().handler.process(new MapMoveMessage(this));
               this._lastWheelZoom = getTimer();
               return true;
               break;
            case msg is MouseRightClickMessage:
               mrcmsg = msg as MouseRightClickMessage;
               if(this._elementsByElementTexture[mrcmsg.target])
               {
                  Berilia.getInstance().handler.process(new MapElementRightClickMessage(this,this._elementsByElementTexture[mrcmsg.target]));
               }
               else if(this._elementTexturesByArrow[mrcmsg.target] && this._elementsByElementTexture[this._elementTexturesByArrow[mrcmsg.target]])
               {
                  Berilia.getInstance().handler.process(new MapElementRightClickMessage(this,this._elementsByElementTexture[this._elementTexturesByArrow[mrcmsg.target]]));
               }
               return false;
         }
         return false;
      }
      
      private function onMapEnterFrame(e:Event) : void
      {
         var newX:Number = NaN;
         var newY:Number = NaN;
         var mx:int = 0;
         var my:int = 0;
         if(!stage)
         {
            return;
         }
         if(this._mapToClear && this.allChunksLoaded)
         {
            this.clearMap(this._mapToClear);
            this._mapToClear = null;
         }
         var stageMouseX:Number = stage.mouseX;
         var stageMouseY:Number = stage.mouseY;
         if(this._dragging && (this._lastMouseX != stageMouseX || this._lastMouseY != stageMouseY))
         {
            newX = this._mapContainer.x + stageMouseX - this._lastMouseX;
            newY = this._mapContainer.y + stageMouseY - this._lastMouseY;
            if(this._lastMouseX && (newX <= 0 && Math.round(newX + this._currentMap.initialWidth * this._mapContainer.scaleX) >= width))
            {
               this._mapContainer.x = newX;
            }
            if(this._lastMouseX && (newY <= 0 && Math.round(newY + this._currentMap.initialHeight * this._mapContainer.scaleY) >= height))
            {
               this._mapContainer.y = newY;
            }
            this.updateVisibleChunck();
            this._lastMouseX = stageMouseX;
            this._lastMouseY = stageMouseY;
         }
         var posX:int = this.mouseX;
         var posY:int = this.mouseY;
         if(posX > 0 && posX < __width && posY > 0 && posY < __height)
         {
            mx = Math.floor((this._mapBitmapContainer.mouseX - this.origineX) / this.mapWidth);
            my = Math.floor((this._mapBitmapContainer.mouseY - this.origineY) / this.mapHeight);
            if(!this._mouseOnArrow && (mx != this._lastMx || my != this._lastMy))
            {
               this._lastMx = mx;
               this._lastMy = my;
               this.onRollOverChunk();
            }
         }
         else
         {
            this._lastMx = Number.NaN;
            this._lastMy = Number.NaN;
         }
      }
      
      private function onRollOverChunk() : void
      {
         var currentMapGroupElement:MapGroupElement = null;
         var currentMapIcons:Array = null;
         this._currentMapIcon.x = this._lastMx * this.mapWidth + this.origineX + this.mapWidth / 2;
         this._currentMapIcon.y = this._lastMy * this.mapHeight + this.origineY + this.mapHeight / 2;
         this._currentMapIcon.scaleX = this._currentMapIcon.scaleY = this.mapWidth / this._currentMapIcon.width;
         if(this._openedMapGroupElement && this._openedMapGroupElement.parent)
         {
            this._openedMapGroupElement.parent.setChildIndex(this._openedMapGroupElement,this._openMapGroupElementIndex);
            this._openedMapGroupElement.close();
            this._openedMapGroupElement = null;
         }
         if(this._elementsListsByCoordinates[this._lastMx])
         {
            currentMapIcons = this._elementsListsByCoordinates[this._lastMx][this._lastMy];
            if(currentMapIcons && currentMapIcons.length > 1)
            {
               currentMapGroupElement = this._mapGroupElements[currentMapIcons[0]];
               if(currentMapGroupElement && !this._openedMapGroupElement)
               {
                  this._openMapGroupElementIndex = currentMapGroupElement.parent.getChildIndex(currentMapGroupElement);
                  currentMapGroupElement.parent.setChildIndex(currentMapGroupElement,currentMapGroupElement.parent.numChildren - 1);
                  currentMapGroupElement.open();
                  this._openedMapGroupElement = currentMapGroupElement;
               }
            }
         }
         Berilia.getInstance().handler.process(new MapRollOverMessage(this,this._lastMx,this._lastMy));
      }
      
      private function onWindowDeactivate(pEvent:Event) : void
      {
         if(this._dragging)
         {
            this.process(new MouseUpMessage());
         }
      }
   }
}
