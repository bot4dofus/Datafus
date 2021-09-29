package com.ankamagames.atouin
{
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOverMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.atouin.resources.adapters.ElementsAdapter;
   import com.ankamagames.atouin.resources.adapters.MapsAdapter;
   import com.ankamagames.atouin.types.AtouinOptions;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.atouin.utils.errors.AtouinError;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class Atouin
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Atouin));
      
      private static var _self:Atouin;
       
      
      private var _worldContainer:DisplayObjectContainer;
      
      private var _overlayContainer:Sprite;
      
      private var _spMapContainer:Sprite;
      
      private var _spGfxContainer:Sprite;
      
      private var _spChgMapContainer:Sprite;
      
      private var _worldMask:Sprite;
      
      private var _currentZoom:Number = 1;
      
      private var _zoomPosX:int;
      
      private var _zoomPosY:int;
      
      private var _movementListeners:Array;
      
      private var _handler:MessageHandler;
      
      private var _aSprites:Array;
      
      private var _aoOptions:AtouinOptions;
      
      private var _cursorUpdateSprite:Sprite;
      
      private var _worldVisible:Boolean = true;
      
      public function Atouin()
      {
         super();
         if(_self)
         {
            throw new AtouinError("Atouin is a singleton class. Please acces it through getInstance()");
         }
         AdapterFactory.addAdapter("ele",ElementsAdapter);
         AdapterFactory.addAdapter("dlm",MapsAdapter);
         this._cursorUpdateSprite = new Sprite();
         this._cursorUpdateSprite.graphics.beginFill(65280,0);
         this._cursorUpdateSprite.graphics.drawRect(0,0,6,6);
         this._cursorUpdateSprite.graphics.endFill();
         this._cursorUpdateSprite.useHandCursor = true;
      }
      
      public static function getInstance() : Atouin
      {
         if(!_self)
         {
            _self = new Atouin();
         }
         return _self;
      }
      
      public function get worldVisible() : Boolean
      {
         return this._worldVisible;
      }
      
      public function get movementListeners() : Array
      {
         return this._movementListeners;
      }
      
      public function get worldContainer() : DisplayObjectContainer
      {
         return this._spMapContainer;
      }
      
      public function get selectionContainer() : DisplayObjectContainer
      {
         var ctr:DisplayObjectContainer = null;
         var i:int = 0;
         if(this._spMapContainer == null)
         {
            return null;
         }
         var len:Number = this._spMapContainer.numChildren;
         if(len > 1)
         {
            i = 1;
            while(!ctr && i < len)
            {
               ctr = this._spMapContainer.getChildAt(i) as DisplayObjectContainer;
               i++;
            }
         }
         return ctr;
      }
      
      public function get chgMapContainer() : DisplayObjectContainer
      {
         return this._spChgMapContainer;
      }
      
      public function get gfxContainer() : DisplayObjectContainer
      {
         return this._spGfxContainer;
      }
      
      public function get overlayContainer() : DisplayObjectContainer
      {
         return this._overlayContainer;
      }
      
      public function get worldMask() : DisplayObjectContainer
      {
         return this._worldMask;
      }
      
      public function get handler() : MessageHandler
      {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void
      {
         this._handler = value;
      }
      
      public function get options() : AtouinOptions
      {
         return this._aoOptions;
      }
      
      public function set options(options:AtouinOptions) : void
      {
         this._aoOptions = options;
      }
      
      public function get currentZoom() : Number
      {
         return this._currentZoom;
      }
      
      public function set currentZoom(value:Number) : void
      {
         this._currentZoom = value;
      }
      
      public function get cellOverEnabled() : Boolean
      {
         return InteractiveCellManager.getInstance().cellOverEnabled;
      }
      
      public function set cellOverEnabled(value:Boolean) : void
      {
         InteractiveCellManager.getInstance().cellOverEnabled = value;
      }
      
      public function get rootContainer() : DisplayObjectContainer
      {
         return this._worldContainer;
      }
      
      public function get worldIsVisible() : Boolean
      {
         return this._worldContainer.contains(this._spMapContainer);
      }
      
      public function setDisplayOptions(ao:AtouinOptions) : void
      {
         var m:Sprite = null;
         this._aoOptions = ao;
         this._worldContainer = ao.container;
         this._handler = ao.handler;
         this._aoOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChange);
         for(var i:uint = 0; i < this._worldContainer.numChildren; i++)
         {
            this._worldContainer.removeChildAt(i);
         }
         this._overlayContainer = new Sprite();
         this._spMapContainer = new Sprite();
         this._spChgMapContainer = new Sprite();
         this._spGfxContainer = new Sprite();
         this._worldMask = new Sprite();
         this._worldContainer.mouseEnabled = false;
         this._spMapContainer.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutMapContainer);
         this._spMapContainer.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapContainer);
         this._spMapContainer.tabChildren = false;
         this._spMapContainer.mouseEnabled = false;
         this._spChgMapContainer.tabChildren = false;
         this._spChgMapContainer.mouseEnabled = false;
         this._spGfxContainer.tabChildren = false;
         this._spGfxContainer.mouseEnabled = false;
         this._spGfxContainer.mouseChildren = false;
         this._overlayContainer.tabChildren = false;
         this._overlayContainer.mouseEnabled = false;
         this._worldMask.mouseEnabled = false;
         this._worldContainer.addChild(this._spMapContainer);
         this._worldContainer.addChild(this._spChgMapContainer);
         this._worldContainer.addChild(this._worldMask);
         this._worldContainer.addChild(this._spGfxContainer);
         this._worldContainer.addChild(this._overlayContainer);
         FrustumManager.getInstance().init(this._spChgMapContainer);
         this._worldContainer.name = "worldContainer";
         this._spMapContainer.name = "mapContainer";
         this._worldMask.name = "worldMask";
         this._spChgMapContainer.name = "chgMapContainer";
         this._spGfxContainer.name = "gfxContainer";
         this._overlayContainer.name = "overlayContainer";
         this.computeWideScreenBitmapWidth(ao.getOption("frustum"));
         this.setWorldMaskDimensions(AtouinConstants.WIDESCREEN_BITMAP_WIDTH);
         var hideBlackBorderValue:Boolean = this._aoOptions.getOption("hideBlackBorder");
         if(!hideBlackBorderValue)
         {
            this.setWorldMaskDimensions(StageShareManager.startWidth,0,0,1,"blackBorder");
            this.getWorldMask("blackBorder",false).mouseEnabled = true;
         }
         else
         {
            m = this.getWorldMask("blackBorder",false);
            if(m)
            {
               m.parent.removeChild(m);
            }
         }
         this.setFrustrum(ao.getOption("frustum"));
         this.init();
      }
      
      protected function onPropertyChange(e:PropertyChangeEvent) : void
      {
         var m:Sprite = null;
         switch(e.propertyName)
         {
            case "hideBlackBorder":
               if(!e.propertyValue)
               {
                  this.setWorldMaskDimensions(StageShareManager.startWidth,0,0,1,"blackBorder");
                  this.getWorldMask("blackBorder",false).mouseEnabled = true;
               }
               else
               {
                  m = this.getWorldMask("blackBorder",false);
                  if(m)
                  {
                     m.parent.removeChild(m);
                  }
               }
         }
      }
      
      private function computeWideScreenBitmapWidth(frustum:Frustum) : void
      {
         var RIGHT_GAME_MARGIN:int = (AtouinConstants.ADJACENT_CELL_LEFT_MARGIN - 1) * AtouinConstants.CELL_WIDTH;
         var LEFT_GAME_MARGIN:int = (AtouinConstants.ADJACENT_CELL_RIGHT_MARGIN - 1) * AtouinConstants.CELL_WIDTH;
         var MAP_IMAGE_WIDTH:uint = AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH + AtouinConstants.CELL_WIDTH;
         AtouinConstants.WIDESCREEN_BITMAP_WIDTH = MAP_IMAGE_WIDTH + RIGHT_GAME_MARGIN + LEFT_GAME_MARGIN;
         StageShareManager.stageLogicalBounds = new Rectangle(-(AtouinConstants.WIDESCREEN_BITMAP_WIDTH - StageShareManager.startWidth) / 2,0,AtouinConstants.WIDESCREEN_BITMAP_WIDTH,StageShareManager.startHeight);
      }
      
      public function setWorldMaskDimensions(width:uint, height:uint = 0, color:uint = 0, alpha:Number = 1.0, name:String = "default") : void
      {
         var w:int = 0;
         var h:int = 0;
         var x:int = 0;
         var m:Sprite = this.getWorldMask(name);
         if(m)
         {
            m.graphics.clear();
            m.graphics.beginFill(color,alpha);
            w = width;
            h = StageShareManager.startHeight - height;
            x = StageShareManager.startWidth - w;
            if(x)
            {
               x /= 2;
            }
            m.graphics.drawRect(-2000,-2000,4000 + w,4000 + h);
            m.graphics.drawRect(x,0,w,h);
            m.graphics.endFill();
         }
      }
      
      public function toggleWorldMask(name:String = "default", visible:* = null) : void
      {
         var m:Sprite = this.getWorldMask(name);
         if(m)
         {
            m.visible = visible === null ? !m.visible : Boolean(visible);
         }
      }
      
      public function getWorldMask(name:String, createIfNeeded:Boolean = true) : Sprite
      {
         for(var i:uint = 0; i < this._worldMask.numChildren; i++)
         {
            if(this._worldMask.getChildAt(i).name == name)
            {
               return this._worldMask.getChildAt(i) as Sprite;
            }
         }
         if(!createIfNeeded)
         {
            return null;
         }
         var m:Sprite = new Sprite();
         this._worldMask.addChild(m);
         m.name = name;
         m.mouseEnabled = false;
         m.mouseChildren = false;
         return m;
      }
      
      public function onRollOverMapContainer(event:Event) : void
      {
         var msg:MapContainerRollOverMessage = new MapContainerRollOverMessage();
         Atouin.getInstance().handler.process(msg);
      }
      
      private function onRollOutMapContainer(event:Event) : void
      {
         var msg:MapContainerRollOutMessage = new MapContainerRollOutMessage();
         Atouin.getInstance().handler.process(msg);
      }
      
      public function updateCursor() : void
      {
         this._cursorUpdateSprite.x = StageShareManager.stage.mouseX - 3;
         this._cursorUpdateSprite.y = StageShareManager.stage.mouseY - 3;
         StageShareManager.stage.addChild(this._cursorUpdateSprite);
         EnterFrameDispatcher.addEventListener(this.removeUpdateCursorSprite,EnterFrameConst.UPDATE_CURSOR_SPRITE,50);
      }
      
      public function showWorld(b:Boolean) : void
      {
         this._spMapContainer.visible = b;
         this._spChgMapContainer.visible = b;
         this._spGfxContainer.visible = b;
         this._overlayContainer.visible = b;
         this._worldVisible = b;
      }
      
      public function setFrustrum(f:Frustum) : void
      {
         if(!this._aoOptions)
         {
            _log.error("Please call setDisplayOptions once before calling setFrustrum");
            return;
         }
         this._aoOptions.setOption("frustum",f);
         this.worldContainer.scaleX = f.scale;
         this.worldContainer.scaleY = f.scale;
         this.worldContainer.x = f.x;
         this.worldContainer.y = f.y;
         this.gfxContainer.scaleX = f.scale;
         this.gfxContainer.scaleY = f.scale;
         this.gfxContainer.x = f.x;
         this.gfxContainer.y = f.y;
         this.overlayContainer.x = f.x;
         this.overlayContainer.y = f.y;
         this.overlayContainer.scaleX = f.scale;
         this.overlayContainer.scaleY = f.scale;
         FrustumManager.getInstance().frustum = f;
      }
      
      public function initPreDisplay(wp:WorldPoint) : void
      {
         if(wp && MapDisplayManager.getInstance() && MapDisplayManager.getInstance().currentMapPoint && MapDisplayManager.getInstance().currentMapPoint.mapId == wp.mapId)
         {
            return;
         }
         MapDisplayManager.getInstance().capture();
      }
      
      public function display(wpMap:WorldPoint, decryptionKey:ByteArray = null, displayWorld:Boolean = true) : uint
      {
         return MapDisplayManager.getInstance().display(wpMap,false,decryptionKey,true,displayWorld);
      }
      
      public function getEntity(id:Number) : IEntity
      {
         return EntitiesManager.getInstance().getEntity(id);
      }
      
      public function getEntityOnCell(cellId:uint, oClass:* = null) : IEntity
      {
         return EntitiesManager.getInstance().getEntityOnCell(cellId,oClass);
      }
      
      public function clearEntities() : void
      {
         EntitiesManager.getInstance().clearEntities();
      }
      
      public function reset() : void
      {
         InteractiveCellManager.getInstance().clean();
         MapDisplayManager.getInstance().reset();
         EntitiesManager.getInstance().clearEntities();
         this.cancelZoom();
         if(this._spMapContainer && this._spMapContainer.parent)
         {
            this._worldContainer.removeChild(this._spMapContainer);
            this._spMapContainer.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutMapContainer);
            this._spMapContainer.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapContainer);
            this._spMapContainer = null;
         }
         if(this._spChgMapContainer.parent)
         {
            this._worldContainer.removeChild(this._spChgMapContainer);
            this._spChgMapContainer = null;
         }
         if(this._spGfxContainer.parent)
         {
            this._worldContainer.removeChild(this._spGfxContainer);
            this._spGfxContainer = null;
         }
         if(this._overlayContainer.parent)
         {
            this._worldContainer.removeChild(this._overlayContainer);
            this._overlayContainer = null;
         }
      }
      
      public function displayGrid(b:Boolean, pIsInFight:Boolean = false) : void
      {
         InteractiveCellManager.getInstance().show(b,pIsInFight);
         if(b != this.options.getOption("alwaysShowGrid"))
         {
            this.options.setOption("alwaysShowGrid",b);
         }
      }
      
      public function getIdentifiedElement(id:uint) : InteractiveObject
      {
         return MapDisplayManager.getInstance().getIdentifiedElement(id);
      }
      
      public function getIdentifiedElementPosition(id:uint) : MapPoint
      {
         return MapDisplayManager.getInstance().getIdentifiedElementPosition(id);
      }
      
      public function addListener(pListener:ISoundPositionListener) : void
      {
         if(this._movementListeners == null)
         {
            this._movementListeners = new Array();
         }
         this._movementListeners.push(pListener);
      }
      
      public function removeListener(pListener:ISoundPositionListener) : void
      {
         var index:int = Atouin.getInstance()._movementListeners.indexOf(pListener);
         if(index)
         {
            Atouin.getInstance()._movementListeners.splice(index,1);
         }
      }
      
      public function zoom(value:Number, posX:int = 0, posY:int = 0) : void
      {
         var lastZoom:Number = NaN;
         if(value == 1)
         {
            this._worldContainer.scaleX = 1;
            this._worldContainer.scaleY = 1;
            this._worldContainer.x = 0;
            this._worldContainer.y = 0;
            this._currentZoom = 1;
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(true);
         }
         else
         {
            if(value < 1)
            {
               value = 1;
            }
            else if(value > AtouinConstants.MAX_ZOOM)
            {
               value = AtouinConstants.MAX_ZOOM;
            }
            lastZoom = this._currentZoom;
            this._currentZoom = value;
            if(lastZoom == this._currentZoom)
            {
               return;
            }
            if(this._currentZoom != 1)
            {
               MapDisplayManager.getInstance().cacheAsBitmapEnabled(false);
            }
            if(posX)
            {
               this._zoomPosX = posX;
            }
            else
            {
               posX = this._zoomPosX;
            }
            if(posY)
            {
               this._zoomPosY = posY;
            }
            else
            {
               posY = this._zoomPosY;
            }
            this._worldContainer.x -= posX * this._currentZoom - posX * this._worldContainer.scaleX;
            this._worldContainer.y -= posY * this._currentZoom - posY * this._worldContainer.scaleY;
            this._worldContainer.scaleX = this._currentZoom;
            this._worldContainer.scaleY = this._currentZoom;
            if(this._worldContainer.x > 0)
            {
               this._worldContainer.x = 0;
            }
            else if(this._worldContainer.x < 1276 - 1276 * this._currentZoom)
            {
               this._worldContainer.x = 1276 - 1276 * this._currentZoom;
            }
            if(this._worldContainer.y > 0)
            {
               this._worldContainer.y = 0;
            }
            else if(this._worldContainer.y < 876 - 876 * this._currentZoom)
            {
               this._worldContainer.y = 876 - 876 * this._currentZoom;
            }
         }
         var mzm:MapZoomMessage = new MapZoomMessage(value,posX,posY);
         Atouin.getInstance().handler.process(mzm);
      }
      
      public function cancelZoom() : void
      {
         if(this._currentZoom != 1)
         {
            this.zoom(1);
         }
      }
      
      public function applyMapZoomScale(map:Map) : void
      {
         if(map.zoomScale != 1 && this._aoOptions.getOption("useInsideAutoZoom"))
         {
            this._currentZoom = map.zoomScale;
            this._worldContainer.x = map.zoomOffsetX;
            this._worldContainer.y = map.zoomOffsetY;
            this._worldContainer.scaleX = map.zoomScale;
            this._worldContainer.scaleY = map.zoomScale;
         }
         else
         {
            this.zoom(1);
         }
      }
      
      public function loadElementsFile() : void
      {
         var elementsLoader:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         elementsLoader.addEventListener(ResourceErrorEvent.ERROR,this.onElementsError,false,0,true);
         elementsLoader.load(new Uri(Atouin.getInstance().options.getOption("elementsIndexPath")));
      }
      
      private function removeUpdateCursorSprite(e:Event) : void
      {
         EnterFrameDispatcher.removeEventListener(this.removeUpdateCursorSprite);
         if(this._cursorUpdateSprite.parent)
         {
            this._cursorUpdateSprite.parent.removeChild(this._cursorUpdateSprite);
         }
      }
      
      private function init() : void
      {
         this._aSprites = [];
         if(!Elements.getInstance().parsed)
         {
            this.loadElementsFile();
         }
      }
      
      private function onElementsError(e:ResourceErrorEvent) : void
      {
         e.currentTarget.removeEventListener(ResourceErrorEvent.ERROR,this.onElementsError);
         _log.error("Atouin was unable to retrieve the elements directory (" + e.errorMsg + ")");
      }
   }
}
