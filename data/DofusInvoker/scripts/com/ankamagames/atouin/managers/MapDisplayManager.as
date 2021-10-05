package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.DefaultMap;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapLoadingFailedMessage;
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.atouin.messages.MapsLoadingCompleteMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.atouin.renderers.MapRenderer;
   import com.ankamagames.atouin.resources.adapters.MapsAdapter;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.utils.map.getMapUriFromId;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class MapDisplayManager
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapDisplayManager));
      
      private static var _self:MapDisplayManager;
       
      
      private var _currentMap:WorldPoint;
      
      private var _currentRenderId:uint;
      
      private var _isDefaultMap:Boolean;
      
      private var _mapInstanceId:Number = 0;
      
      private var _lastMap:WorldPoint;
      
      private var _loader:IResourceLoader;
      
      private var _currentDataMap:DataMapContainer;
      
      private var _currentMapRendered:Boolean = true;
      
      private var _forceReloadWithoutCache:Boolean;
      
      private var _renderRequestStack:Array;
      
      private var _renderer:MapRenderer;
      
      private var _screenshot:Bitmap;
      
      private var _screenshotData:BitmapData;
      
      private var _nMapLoadStart:uint;
      
      private var _nMapLoadEnd:uint;
      
      private var _nGfxLoadStart:uint;
      
      private var _nGfxLoadEnd:uint;
      
      private var _nRenderMapStart:uint;
      
      private var _nRenderMapEnd:uint;
      
      private var matrix:Matrix;
      
      public function MapDisplayManager()
      {
         this.matrix = new Matrix();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this.init();
      }
      
      public static function getInstance() : MapDisplayManager
      {
         if(!_self)
         {
            _self = new MapDisplayManager();
         }
         return _self;
      }
      
      public function get isDefaultMap() : Boolean
      {
         return this._isDefaultMap;
      }
      
      public function get renderer() : MapRenderer
      {
         return this._renderer;
      }
      
      public function get currentRenderId() : uint
      {
         return this._currentRenderId;
      }
      
      public function fromMap(map:Map, decryptionKey:ByteArray = null, renderFixture:Boolean = true) : uint
      {
         this._currentMap = WorldPoint.fromMapId(map.id);
         var request:RenderRequest = new RenderRequest(this._currentMap,false,decryptionKey,renderFixture);
         this._renderRequestStack.push(request);
         this._currentRenderId = request.renderId;
         Atouin.getInstance().showWorld(true);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         Atouin.getInstance().options.setOption("groundCacheMode",0);
         var rle:ResourceLoadedEvent = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
         rle.resource = map;
         this.onMapLoaded(rle);
         return this._currentRenderId;
      }
      
      public function display(pMap:WorldPoint, forceReloadWithoutCache:Boolean = false, decryptionKey:ByteArray = null, renderFixture:Boolean = true, displayWorld:Boolean = true) : uint
      {
         var request:RenderRequest = new RenderRequest(pMap,forceReloadWithoutCache,decryptionKey,renderFixture,displayWorld);
         _log.debug("Ask render map " + pMap.mapId + ", renderRequestID: " + request.renderId);
         this._renderRequestStack.push(request);
         this.checkForRender(displayWorld);
         return request.renderId;
      }
      
      public function isBoundingBox(pictoId:int) : Boolean
      {
         if(MapRenderer.boundingBoxElements[pictoId])
         {
            return true;
         }
         return false;
      }
      
      public function cacheAsBitmapEnabled(yes:Boolean) : void
      {
         var ls:Array = MapRenderer.cachedAsBitmapElement;
         var num:int = ls.length;
         for(var i:int = 0; i < num; i++)
         {
            ls[i].cacheAsBitmap = yes;
         }
      }
      
      public function get currentMapPoint() : WorldPoint
      {
         return this._currentMap;
      }
      
      public function get currentMapRendered() : Boolean
      {
         return this._currentMapRendered;
      }
      
      public function getDataMapContainer() : DataMapContainer
      {
         return this._currentDataMap;
      }
      
      public function get mapInstanceId() : Number
      {
         return this._mapInstanceId;
      }
      
      public function set mapInstanceId(mapId:Number) : void
      {
         _log.debug("mapInstanceId " + mapId);
         this._mapInstanceId = mapId;
      }
      
      public function activeIdentifiedElements(active:Boolean) : void
      {
         var ie:Object = null;
         var identifiedElements:Dictionary = this._renderer.identifiedElements;
         for each(ie in identifiedElements)
         {
            ie.sprite.mouseEnabled = active;
         }
      }
      
      public function unloadMap() : void
      {
         this._renderer.unload();
      }
      
      public function capture() : void
      {
         var ctr:DisplayObjectContainer = null;
         if(Atouin.getInstance().options.getOption(EnterFrameConst.TWEENT_INTER_MAP) || Atouin.getInstance().options.getOption("hideInterMap"))
         {
            if(this._screenshotData == null)
            {
               this._screenshotData = new BitmapData(StageShareManager.startWidth,StageShareManager.startHeight,true,0);
               this._screenshot = new Bitmap(this._screenshotData);
               this._screenshot.smoothing = true;
            }
            ctr = Atouin.getInstance().rootContainer;
            this.matrix.identity();
            this.matrix.scale(ctr.scaleX,ctr.scaleY);
            this.matrix.translate(ctr.x,ctr.y);
            this._screenshotData.draw(ctr,this.matrix,null,null,null,true);
            ctr.addChild(this._screenshot);
         }
      }
      
      public function getIdentifiedEntityElement(id:uint) : TiphonSprite
      {
         if(this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[id])
         {
            if(this._renderer.identifiedElements[id].sprite is TiphonSprite)
            {
               return this._renderer.identifiedElements[id].sprite as TiphonSprite;
            }
         }
         return null;
      }
      
      public function getIdentifiedElement(id:uint) : InteractiveObject
      {
         if(this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[id])
         {
            return this._renderer.identifiedElements[id].sprite;
         }
         return null;
      }
      
      public function getIdentifiedElementPosition(id:uint) : MapPoint
      {
         if(this._renderer && this._renderer.identifiedElements && this._renderer.identifiedElements[id])
         {
            return this._renderer.identifiedElements[id].position;
         }
         return null;
      }
      
      public function reset() : void
      {
         this.unloadMap();
         this._currentMap = null;
         _log.debug("mapInstanceId reset 0");
         this._mapInstanceId = 0;
         this._currentMapRendered = true;
         this._lastMap = null;
         this._renderRequestStack = [];
      }
      
      public function hideBackgroundForTacticMode(yes:Boolean, backgroundColor:uint = 0) : void
      {
         this._renderer.modeTactic(yes,backgroundColor);
      }
      
      private function init() : void
      {
         this._renderRequestStack = [];
         this._renderer = new MapRenderer(Atouin.getInstance().worldContainer,Elements.getInstance());
         AdapterFactory.addAdapter("dlm",MapsAdapter);
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
      }
      
      private function mapDisplayed() : void
      {
         this._currentMapRendered = true;
         InteractiveCellManager.getInstance().updateInteractiveCell(this._currentDataMap);
         this._renderRequestStack.shift();
         var msg:MapsLoadingCompleteMessage = new MapsLoadingCompleteMessage(this._currentMap,MapDisplayManager.getInstance().getDataMapContainer().dataMap);
         msg.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(msg);
         this.checkForRender();
      }
      
      private function checkForRender(displayWorld:Boolean = true) : void
      {
         var dataMap:Map = null;
         var msg:MapsLoadingCompleteMessage = null;
         var atouin:Atouin = null;
         if(!this._currentMapRendered && this._currentMap)
         {
            return;
         }
         if(this._renderRequestStack.length == 0)
         {
            return;
         }
         var request:RenderRequest = RenderRequest(this._renderRequestStack[0]);
         var pMap:WorldPoint = request.map;
         var forceReloadWithoutCache:Boolean = request.forceReloadWithoutCache;
         Atouin.getInstance().showWorld(displayWorld);
         this._renderer.initRenderContainer(Atouin.getInstance().worldContainer);
         if(!forceReloadWithoutCache && this._currentMap && this._currentMap.mapId == pMap.mapId && !Atouin.getInstance().options.getOption("reloadLoadedMap"))
         {
            this._renderRequestStack.shift();
            _log.debug("Map " + pMap.mapId + " is the same, renderRequestID: " + request.renderId);
            dataMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            msg = new MapsLoadingCompleteMessage(this._currentMap,dataMap);
            atouin = Atouin.getInstance();
            atouin.handler.process(msg);
            msg.renderRequestId = request.renderId;
            atouin.applyMapZoomScale(dataMap);
            this.checkForRender();
            return;
         }
         this._currentMapRendered = false;
         this._lastMap = this._currentMap;
         this._currentMap = pMap;
         this._currentRenderId = request.renderId;
         this._forceReloadWithoutCache = forceReloadWithoutCache;
         var msg2:MapsLoadingStartedMessage = new MapsLoadingStartedMessage();
         msg2.id = this._currentMap.mapId;
         Atouin.getInstance().handler.process(msg2);
         this._nMapLoadStart = getTimer();
         this._loader.cancel();
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onMapLoaded,false,0,true);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onMapFailed,false,0,true);
         this._loader.load(new Uri(getMapUriFromId(pMap.mapId)),null);
      }
      
      private function onMapLoaded(e:ResourceLoadedEvent) : void
      {
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onMapLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onMapFailed);
         var request:RenderRequest = RenderRequest(this._renderRequestStack[0]);
         this._nMapLoadEnd = getTimer();
         var map:Map = new Map();
         if(e.resource is Map)
         {
            map = e.resource;
         }
         else
         {
            try
            {
               map.fromRaw(e.resource,request.decryptionKey);
            }
            catch(err:Error)
            {
               _log.fatal("Exception sur le parsing du fichier de map :\n" + err.getStackTrace());
               map = new DefaultMap();
            }
         }
         this._isDefaultMap = map is DefaultMap;
         this.unloadMap();
         DataMapProvider.getInstance().resetUpdatedCell();
         DataMapProvider.getInstance().resetSpecialEffects();
         if(!request)
         {
            return;
         }
         this._currentDataMap = new DataMapContainer(map);
         MEMORY_LOG[DataMapContainer] = 1;
         this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_START,this.logGfxLoadTime,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.GFX_LOADING_END,this.logGfxLoadTime,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_START,this.mapRendered,false,0,true);
         this._renderer.addEventListener(RenderMapEvent.MAP_RENDER_END,this.mapRendered,false,0,true);
         this._renderer.addEventListener(ProgressEvent.PROGRESS,this.mapRenderProgress,false,0,true);
         this._renderer.render(this._currentDataMap,this._forceReloadWithoutCache,request.renderId,request.renderFixture,request.displayWorld);
         FrustumManager.getInstance().updateMap();
      }
      
      private function onMapFailed(e:ResourceErrorEvent) : void
      {
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onMapLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onMapFailed);
         _log.error("Impossible de charger la map " + e.uri + " : " + e.errorMsg);
         this._currentMapRendered = true;
         this._renderRequestStack.shift();
         this.checkForRender();
         this.signalMapLoadingFailure(MapLoadingFailedMessage.NO_FILE);
      }
      
      private function logGfxLoadTime(e:Event) : void
      {
         if(e.type == RenderMapEvent.GFX_LOADING_START)
         {
            this._nGfxLoadStart = getTimer();
         }
         if(e.type == RenderMapEvent.GFX_LOADING_END)
         {
            this._nGfxLoadEnd = getTimer();
         }
      }
      
      private function tweenInterMap(e:Event) : void
      {
         this._screenshot.alpha -= this._screenshot.alpha / 3;
         if(this._screenshot.alpha < 0.01)
         {
            Atouin.getInstance().worldContainer.cacheAsBitmap = false;
            this.removeScreenShot();
            EnterFrameDispatcher.removeEventListener(this.tweenInterMap);
         }
      }
      
      private function mapRenderProgress(e:ProgressEvent) : void
      {
         if(!this._currentMap)
         {
            this._currentMapRendered = true;
            this.unloadMap();
            this.signalMapLoadingFailure(MapLoadingFailedMessage.CLIENT_SHUTDOWN);
            return;
         }
         var msg:MapRenderProgressMessage = new MapRenderProgressMessage(e.bytesLoaded / e.bytesTotal * 100);
         msg.id = this._currentMap.mapId;
         msg.renderRequestId = this._currentRenderId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function signalMapLoadingFailure(errorReasonId:uint) : void
      {
         var msg:MapLoadingFailedMessage = new MapLoadingFailedMessage();
         if(!this._currentMap)
         {
            msg.id = 0;
         }
         else
         {
            msg.id = this._currentMap.mapId;
         }
         msg.errorReason = errorReasonId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mapRendered(e:RenderMapEvent) : void
      {
         var tt:uint = 0;
         var tml:uint = 0;
         var tgl:int = 0;
         var msg:MapLoadedMessage = null;
         if(e.type == RenderMapEvent.MAP_RENDER_START)
         {
            this._nRenderMapStart = getTimer();
         }
         if(e.type == RenderMapEvent.MAP_RENDER_END)
         {
            this.removeRendererListeners();
            this.mapDisplayed();
            this._nRenderMapEnd = getTimer();
            tt = this._nRenderMapEnd - this._nMapLoadStart;
            tml = this._nMapLoadEnd - this._nMapLoadStart;
            tgl = this._nGfxLoadEnd - this._nGfxLoadStart;
            msg = new MapLoadedMessage();
            msg.dataLoadingTime = tml;
            msg.gfxLoadingTime = tgl;
            msg.renderingTime = this._nRenderMapEnd - this._nRenderMapStart;
            msg.globalRenderingTime = tt;
            _log.info("map rendered [total : " + tt + "ms, " + (tt < 100 ? " " + (tt < 10 ? " " : "") : "") + "map load : " + tml + "ms, " + (tml < 100 ? " " + (tml < 10 ? " " : "") : "") + "gfx load : " + tgl + "ms, " + (tgl < 100 ? " " + (tgl < 10 ? " " : "") : "") + "render : " + (this._nRenderMapEnd - this._nRenderMapStart) + "ms] file : " + (!!this._currentMap ? this._currentMap.mapId.toString() : "???") + ".dlm" + (!!this._isDefaultMap ? " (/!\\ DEFAULT MAP) " : "") + " / renderRequestID #" + this._currentRenderId);
            if(this._screenshot && this._screenshot.parent)
            {
               if(Atouin.getInstance().options.getOption(EnterFrameConst.TWEENT_INTER_MAP))
               {
                  Atouin.getInstance().worldContainer.cacheAsBitmap = true;
                  EnterFrameDispatcher.addEventListener(this.tweenInterMap,EnterFrameConst.TWEENT_INTER_MAP);
               }
               else
               {
                  this.removeScreenShot();
               }
            }
            msg.id = this._currentMap.mapId;
            Atouin.getInstance().handler.process(msg);
         }
      }
      
      private function removeRendererListeners() : void
      {
         this._renderer.removeEventListener(RenderMapEvent.GFX_LOADING_START,this.logGfxLoadTime);
         this._renderer.removeEventListener(RenderMapEvent.GFX_LOADING_END,this.logGfxLoadTime);
         this._renderer.removeEventListener(RenderMapEvent.MAP_RENDER_START,this.mapRendered);
         this._renderer.removeEventListener(RenderMapEvent.MAP_RENDER_END,this.mapRendered);
         this._renderer.removeEventListener(ProgressEvent.PROGRESS,this.mapRenderProgress);
      }
      
      private function removeScreenShot() : void
      {
         this._screenshot.parent.removeChild(this._screenshot);
         this._screenshotData.fillRect(new Rectangle(0,0,this._screenshotData.width,this._screenshotData.height),4278190080);
      }
   }
}

import com.ankamagames.jerakine.types.positions.WorldPoint;
import flash.utils.ByteArray;

class RenderRequest
{
   
   private static var RENDER_ID:uint = 0;
    
   
   public var renderId:uint;
   
   public var map:WorldPoint;
   
   public var forceReloadWithoutCache:Boolean;
   
   public var decryptionKey:ByteArray;
   
   public var renderFixture:Boolean;
   
   public var displayWorld:Boolean;
   
   function RenderRequest(map:WorldPoint, forceReloadWithoutCache:Boolean, decryptionKey:ByteArray, renderFixture:Boolean = true, displayWorld:Boolean = true)
   {
      super();
      this.renderId = RENDER_ID++;
      this.map = map;
      this.forceReloadWithoutCache = forceReloadWithoutCache;
      this.decryptionKey = decryptionKey;
      this.renderFixture = renderFixture;
      this.displayWorld = displayWorld;
   }
}
