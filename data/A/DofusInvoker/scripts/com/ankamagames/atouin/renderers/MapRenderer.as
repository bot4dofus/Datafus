package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.AnimatedGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BlendedGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BoundingBoxGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Fixture;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.atouin.enums.GroundCache;
   import com.ankamagames.atouin.managers.AlwaysAnimatedElementManager;
   import com.ankamagames.atouin.managers.AnimatedElementManager;
   import com.ankamagames.atouin.managers.DataGroundMapManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.pools.WorldEntityPool;
   import com.ankamagames.atouin.types.BitmapCellContainer;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.types.CellReference;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.ICellContainer;
   import com.ankamagames.atouin.types.InteractiveCell;
   import com.ankamagames.atouin.types.LayerContainer;
   import com.ankamagames.atouin.types.MapGfxBitmap;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.atouin.types.WorldEntitySprite;
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.tiphon.display.RasterizedAnimation;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.PixelSnapping;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [Event(name="MAP_RENDER_START",type="com.ankamagames.atouin.types.events.RenderMapEvent")]
   public class MapRenderer extends EventDispatcher
   {
      
      public static var cachedAsBitmapElement:Array = [];
      
      public static var boundingBoxElements:Array;
      
      public static var MEMORY_LOG_1:Dictionary = new Dictionary(true);
      
      public static var MEMORY_LOG_2:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapRenderer));
      
      private static var _groundGlobalScaleRatio:Number;
      
      private static var bitmapSize:Point = new Point();
       
      
      public var useDefautState:Boolean;
      
      private var _container:DisplayObjectContainer;
      
      private var _elements:Elements;
      
      private var _gfxLoader:IResourceLoader;
      
      private var _swfLoader:IResourceLoader;
      
      private var _map:Map;
      
      private var _useSmooth:Boolean;
      
      private var _bitmapsGfx:Array;
      
      private var _swfGfx:Array;
      
      private var _swfApplicationDomain:Array;
      
      private var _dataMapContainer:DataMapContainer;
      
      private var _icm:InteractiveCellManager;
      
      private var _hideForeground:Boolean;
      
      private var _identifiedElements:Dictionary;
      
      private var _gfxPath:String;
      
      private var _gfxPathSwf:String;
      
      private var _hasSwfGfx:Boolean;
      
      private var _hasBitmapGfx:Boolean;
      
      private var _loadedGfxListCount:uint = 0;
      
      private var _pictoAsBitmap:Boolean;
      
      private var _mapLoaded:Boolean = true;
      
      private var _hasGroundJPG:Boolean = false;
      
      private var _skipGroundCache:Boolean = false;
      
      private var _forceReloadWithoutCache:Boolean = false;
      
      private var _groundIsLoaded:Boolean = false;
      
      private var _mapIsReady:Boolean = false;
      
      private var _allowAnimatedGfx:Boolean;
      
      private var _allowParticlesFx:Boolean;
      
      private var _gfxMemorySize:uint = 0;
      
      private var _renderId:uint = 0;
      
      private var _extension:String;
      
      private var _renderFixture:Boolean = true;
      
      private var _renderBackgroundColor:Boolean = true;
      
      private var _displayWorld:Boolean = true;
      
      private var _progressBarCtr:Sprite;
      
      private var _downloadProgressBar:Shape;
      
      private var _downloadTimer:BenchmarkTimer;
      
      private var _filesToLoad:uint;
      
      private var _filesLoaded:uint;
      
      private var _cancelRender:Boolean;
      
      private var _groundBitmap:Bitmap;
      
      private var _foregroundBitmap:Bitmap;
      
      private var _layersData:Array;
      
      private var _tacticModeActivated:Boolean = false;
      
      private var _renderScale:int = 1;
      
      private var _frustumX:Number;
      
      private var _screenResolutionOffset:Point;
      
      private var _previousGroundCacheMode:int = -1;
      
      private var colorTransform:ColorTransform;
      
      private var _m:Matrix;
      
      private var _srcRect:Rectangle;
      
      private var _destPoint:Point;
      
      private var _cellBitmapData:BitmapData;
      
      private var _clTrans:ColorTransform;
      
      public function MapRenderer(container:DisplayObjectContainer, elements:Elements)
      {
         var val:* = undefined;
         this._bitmapsGfx = [];
         this._swfGfx = [];
         this._swfApplicationDomain = [];
         this._hideForeground = Atouin.getInstance().options.getOption("hideForeground");
         this._downloadTimer = new BenchmarkTimer(2500,0,"MapRenderer._downloadTimer");
         this.colorTransform = new ColorTransform();
         this._m = new Matrix();
         this._srcRect = new Rectangle();
         this._destPoint = new Point();
         this._clTrans = new ColorTransform();
         super();
         this._container = container;
         if(isNaN(_groundGlobalScaleRatio))
         {
            val = XmlConfig.getInstance().getEntry("config.gfx.world.scaleRatio");
            _groundGlobalScaleRatio = val == null ? Number(1) : Number(parseFloat(val));
         }
         bitmapSize.x = AtouinConstants.WIDESCREEN_BITMAP_WIDTH;
         bitmapSize.y = StageShareManager.startHeight;
         this._screenResolutionOffset = new Point();
         this._screenResolutionOffset.x = (bitmapSize.x - StageShareManager.startWidth) / 2;
         this._screenResolutionOffset.y = (bitmapSize.y - StageShareManager.startHeight) / 2;
         this._elements = elements;
         this._icm = InteractiveCellManager.getInstance();
         this._gfxPath = Atouin.getInstance().options.getOption("elementsPath");
         this._gfxPathSwf = Atouin.getInstance().options.getOption("swfPath");
         this._extension = Atouin.DEFAULT_MAP_EXTENSION;
         var downloadProgressBarBorder:Shape = new Shape();
         downloadProgressBarBorder.graphics.lineStyle(1,8947848);
         downloadProgressBarBorder.graphics.beginFill(2236962);
         downloadProgressBarBorder.graphics.drawRect(0,0,600,10);
         downloadProgressBarBorder.x = 0;
         downloadProgressBarBorder.y = 0;
         this._downloadProgressBar = new Shape();
         this._downloadProgressBar.graphics.beginFill(10077440);
         this._downloadProgressBar.graphics.drawRect(0,0,597,7);
         this._downloadProgressBar.graphics.endFill();
         this._downloadProgressBar.x = 2;
         this._downloadProgressBar.y = 2;
         this._progressBarCtr = new Sprite();
         this._progressBarCtr.name = "progressBar";
         this._progressBarCtr.addChild(downloadProgressBarBorder);
         this._progressBarCtr.addChild(this._downloadProgressBar);
         this._progressBarCtr.x = (StageShareManager.startWidth - this._progressBarCtr.width) / 2;
         this._progressBarCtr.y = (StageShareManager.startHeight - this._progressBarCtr.height) / 2;
         this.initGfxLoader();
         this.initSwfLoader();
      }
      
      public function get displayWorld() : Boolean
      {
         return this._displayWorld;
      }
      
      public function set displayWorld(value:Boolean) : void
      {
         this._displayWorld = value;
      }
      
      public function get gfxMemorySize() : uint
      {
         return this._gfxMemorySize;
      }
      
      public function get foregroundBitmap() : Bitmap
      {
         return this._foregroundBitmap;
      }
      
      public function get backgroundBitmap() : Bitmap
      {
         return this._groundBitmap;
      }
      
      public function get renderScale() : int
      {
         return this._renderScale;
      }
      
      public function get identifiedElements() : Dictionary
      {
         return this._identifiedElements;
      }
      
      public function get gfxLoader() : IResourceLoader
      {
         return this._gfxLoader;
      }
      
      public function initRenderContainer(container:DisplayObjectContainer) : void
      {
         this._container = container;
      }
      
      public function render(dataContainer:DataMapContainer, forceReloadWithoutCache:Boolean = false, renderId:uint = 0, renderFixture:Boolean = true, displayWorld:Boolean = true) : void
      {
         var uri:Uri = null;
         var isJpg:Boolean = false;
         var applicationDomain:ApplicationDomain = null;
         var nged:NormalGraphicalElementData = null;
         var cacheStatus:int = 0;
         var fixture:Fixture = null;
         this._cancelRender = false;
         this._renderFixture = renderFixture;
         this._renderBackgroundColor = renderFixture;
         this._displayWorld = displayWorld;
         this._gfxMemorySize = 0;
         this._filesLoaded = 0;
         this._frustumX = FrustumManager.getInstance().frustum.x;
         this._renderId = renderId;
         Atouin.getInstance().cancelZoom();
         AnimatedElementManager.reset();
         AlwaysAnimatedElementManager.reset();
         boundingBoxElements = [];
         this._allowAnimatedGfx = Atouin.getInstance().options.getOption("allowAnimatedGfx");
         this._allowParticlesFx = Atouin.getInstance().options.getOption("allowParticlesFx");
         var newLoader:* = !this._mapLoaded;
         this._mapLoaded = false;
         this._groundIsLoaded = false;
         this._mapIsReady = false;
         this._map = dataContainer.dataMap;
         this._downloadProgressBar.scaleX = 0;
         this._forceReloadWithoutCache = forceReloadWithoutCache;
         var groundCacheMode:int = Atouin.getInstance().options.getOption("groundCacheMode");
         if(forceReloadWithoutCache)
         {
            this._skipGroundCache = true;
            this._hasGroundJPG = false;
         }
         else
         {
            this._skipGroundCache = DataGroundMapManager.mapsCurrentlyRendered() > AtouinConstants.MAX_GROUND_CACHE_MEMORY || groundCacheMode == 0;
            this._map.groundCacheCurrentlyUsed = groundCacheMode;
            if(groundCacheMode && !this._skipGroundCache)
            {
               cacheStatus = DataGroundMapManager.loadGroundMap(this._map,this.groundMapLoaded,this.groundMapNotLoaded);
               if(cacheStatus == GroundCache.GROUND_CACHE_AVAILABLE)
               {
                  this._hasGroundJPG = true;
               }
               else if(cacheStatus == GroundCache.GROUND_CACHE_NOT_AVAILABLE)
               {
                  this._hasGroundJPG = false;
               }
               else if(cacheStatus == GroundCache.GROUND_CACHE_ERROR)
               {
                  this._hasGroundJPG = false;
                  Atouin.getInstance().options.setOption("groundCacheMode",0);
               }
               else if(cacheStatus == GroundCache.GROUND_CACHE_SKIP)
               {
                  this._skipGroundCache = true;
                  this._hasGroundJPG = false;
               }
            }
            else
            {
               this._hasGroundJPG = false;
            }
         }
         if(this._hasGroundJPG)
         {
            Atouin.getInstance().worldContainer.visible = false;
         }
         var bitmapsGfx:Array = [];
         this._useSmooth = Atouin.getInstance().options.getOption("useSmooth");
         this._dataMapContainer = dataContainer;
         this._identifiedElements = new Dictionary(true);
         this._loadedGfxListCount = 0;
         this._hasSwfGfx = false;
         this._hasBitmapGfx = false;
         var gfxUri:Array = [];
         var swfUri:Array = [];
         var gfxList:Vector.<NormalGraphicalElementData> = this._map.getGfxList(this._hasGroundJPG);
         for each(nged in gfxList)
         {
            if(nged is AnimatedGraphicalElementData)
            {
               applicationDomain = new ApplicationDomain();
               uri = new Uri(this._gfxPath + "/swf/" + nged.gfxId + ".swf");
               uri.tag = nged.gfxId;
               uri.loaderContext = new LoaderContext(false,applicationDomain);
               AirScanner.allowByteCodeExecution(uri.loaderContext,true);
               swfUri.push(uri);
               this._hasSwfGfx = true;
               this._swfApplicationDomain[nged.gfxId] = applicationDomain;
            }
            else if(this._bitmapsGfx[nged.gfxId])
            {
               bitmapsGfx[nged.gfxId] = this._bitmapsGfx[nged.gfxId];
            }
            else
            {
               isJpg = Elements.getInstance().isJpg(nged.gfxId);
               if(this._renderScale != 1)
               {
                  uri = new Uri(this._gfxPathSwf + "/" + nged.gfxId + ".swf");
               }
               else
               {
                  uri = new Uri(this._gfxPath + "/" + (!!isJpg ? "jpg" : "png") + "/" + nged.gfxId + "." + (!!isJpg ? "jpg" : this._extension));
               }
               uri.tag = nged.gfxId;
               gfxUri.push(uri);
               this._hasBitmapGfx = true;
            }
         }
         if(renderFixture)
         {
            if(!this._hasGroundJPG)
            {
               for each(fixture in this._map.backgroundFixtures)
               {
                  if(this._bitmapsGfx[fixture.fixtureId])
                  {
                     bitmapsGfx[fixture.fixtureId] = this._bitmapsGfx[fixture.fixtureId];
                  }
                  else
                  {
                     isJpg = Elements.getInstance().isJpg(fixture.fixtureId);
                     if(this._renderScale != 1)
                     {
                        uri = new Uri(this._gfxPathSwf + "/" + fixture.fixtureId + ".swf");
                     }
                     else
                     {
                        uri = new Uri(this._gfxPath + "/" + (!!isJpg ? "jpg" : "png") + "/" + fixture.fixtureId + "." + (!!isJpg ? "jpg" : this._extension));
                     }
                     uri.tag = fixture.fixtureId;
                     gfxUri.push(uri);
                     this._hasBitmapGfx = true;
                  }
               }
            }
            for each(fixture in this._map.foregroundFixtures)
            {
               if(this._bitmapsGfx[fixture.fixtureId])
               {
                  bitmapsGfx[fixture.fixtureId] = this._bitmapsGfx[fixture.fixtureId];
               }
               else
               {
                  isJpg = Elements.getInstance().isJpg(fixture.fixtureId);
                  if(this._renderScale != 1)
                  {
                     uri = new Uri(this._gfxPathSwf + "/" + fixture.fixtureId + ".swf");
                  }
                  else
                  {
                     uri = new Uri(this._gfxPath + "/" + (!!isJpg ? "jpg" : "png") + "/" + fixture.fixtureId + "." + (!!isJpg ? "jpg" : this._extension));
                  }
                  uri.tag = fixture.fixtureId;
                  gfxUri.push(uri);
                  this._hasBitmapGfx = true;
               }
            }
         }
         dispatchEvent(new RenderMapEvent(RenderMapEvent.GFX_LOADING_START,false,false,this._map.id,this._renderId));
         this._bitmapsGfx = bitmapsGfx;
         this._swfGfx = [];
         if(newLoader)
         {
            this.initGfxLoader();
            this.initSwfLoader();
         }
         else
         {
            if(!this.hasGfxLoaderListeners())
            {
               this.addGfxLoaderListeners();
            }
            if(!this.hasSwfLoaderListeners())
            {
               this.addSwfLoaderListeners();
            }
         }
         this._filesToLoad = gfxUri.length + swfUri.length;
         if(this._renderScale == 1)
         {
            this._gfxLoader.load(gfxUri);
         }
         else
         {
            this._gfxLoader.load(gfxUri,null,AdvancedSwfAdapter);
         }
         this._swfLoader.load(swfUri,null,AdvancedSwfAdapter);
         if(Atouin.getInstance().options.getOption("showProgressBar") && !this._downloadTimer.running)
         {
            this.delayProgressBarAdded();
         }
         if(gfxUri.length == 0 && swfUri.length == 0)
         {
            this.onAllGfxLoaded(null);
         }
      }
      
      private function delayProgressBarAdded() : void
      {
         this._downloadTimer.start();
         this._downloadTimer.addEventListener(TimerEvent.TIMER,this.onDownloadTimer);
      }
      
      private function stopDelayProgressBar() : void
      {
         this._downloadTimer.reset();
         this._downloadTimer.removeEventListener(TimerEvent.TIMER,this.onDownloadTimer);
      }
      
      public function unload() : void
      {
         var child:DisplayObject = null;
         this._cancelRender = true;
         this._mapLoaded = true;
         this._gfxLoader.cancel();
         this.removeGfxLoaderListeners();
         this._swfLoader.cancel();
         this.removeSwfLoaderListeners();
         this._filesToLoad = 0;
         this._filesLoaded = 0;
         this.stopDelayProgressBar();
         RasterizedAnimation.optimize(1);
         AnimatedElementManager.reset();
         AlwaysAnimatedElementManager.reset();
         while(cachedAsBitmapElement.length)
         {
            cachedAsBitmapElement.shift().cacheAsBitmap = false;
         }
         this._map = null;
         if(this._dataMapContainer)
         {
            this._dataMapContainer.removeContainer();
         }
         while(this._container.numChildren)
         {
            child = this._container.removeChildAt(0);
            if(child is Bitmap && Bitmap(child).bitmapData)
            {
               Bitmap(child).bitmapData.dispose();
            }
            child = null;
         }
         this._foregroundBitmap = null;
         this._groundBitmap = null;
      }
      
      public function modeTactic(activated:Boolean, backgroundColor:uint) : void
      {
         var o:Object = null;
         var i:int = 0;
         if(activated && this._container.opaqueBackground != backgroundColor)
         {
            this._container.opaqueBackground = backgroundColor;
         }
         else if(!activated && this._map)
         {
            if(this._renderBackgroundColor)
            {
               this._container.opaqueBackground = this._map.backgroundColor;
            }
         }
         this._tacticModeActivated = activated;
         if(!activated && this._layersData && this._layersData.length > 0)
         {
            for each(o in this._layersData)
            {
               o.data.visible = true;
            }
            this._layersData = null;
         }
         else if(activated && this._groundIsLoaded)
         {
            this._layersData = [];
            o = {
               "data":this._container.getChildAt(0),
               "index":0
            };
            this._layersData.push(o);
            o.data.visible = false;
         }
         else if(activated)
         {
            this._layersData = [];
            i = 0;
            while(!(this._container.getChildAt(i) is LayerContainer))
            {
               o = {
                  "data":this._container.getChildAt(i),
                  "index":i
               };
               this._layersData.push(o);
               o.data.visible = false;
               i++;
            }
         }
         if(activated && this._foregroundBitmap != null)
         {
            this._foregroundBitmap.visible = false;
         }
         else if(!activated && this._foregroundBitmap != null)
         {
            this._foregroundBitmap.visible = true;
         }
      }
      
      public function isCellUnderFixture(pCellId:uint) : Boolean
      {
         var cellRef:CellReference = this._dataMapContainer.getCellReference(pCellId);
         return this._foregroundBitmap && this._foregroundBitmap.bitmapData.hitTest(new Point(this._foregroundBitmap.x,this._foregroundBitmap.y),255,new Rectangle(cellRef.x,cellRef.y,AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT));
      }
      
      public function setRenderScale(scale:int) : Boolean
      {
         if(this._gfxPathSwf && this._gfxPathSwf.charAt(0) != "!")
         {
            this._swfGfx = [];
            this._bitmapsGfx = [];
            if(scale != -1)
            {
               this._previousGroundCacheMode = Atouin.getInstance().options.getOption("groundCacheMode");
               Atouin.getInstance().options.setOption("groundCacheMode",0);
            }
            else if(this._previousGroundCacheMode != -1)
            {
               Atouin.getInstance().options.setOption("groundCacheMode",this._previousGroundCacheMode);
            }
            this._renderScale = scale;
            return true;
         }
         return false;
      }
      
      public function getAllGfx() : Array
      {
         var key:* = null;
         var gfxList:Array = [];
         for(key in this._bitmapsGfx)
         {
            if(!gfxList[key])
            {
               gfxList[key] = this._bitmapsGfx[key];
            }
         }
         for(key in this._swfGfx)
         {
            if(!gfxList[key])
            {
               if(this._swfGfx[key] is ASwf)
               {
                  gfxList[key] = this.rasterizeSwf((this._swfGfx[key] as ASwf).content,this.renderScale);
               }
               else
               {
                  gfxList[key] = this.rasterizeSwf(this._swfGfx[key],this.renderScale);
               }
            }
         }
         return gfxList;
      }
      
      private function makeMap() : void
      {
         var layerCtr:DisplayObjectContainer = null;
         var cellInteractionCtr:DisplayObjectContainer = null;
         var cellCtr:ICellContainer = null;
         var cellPnt:Point = null;
         var layerId:uint = 0;
         var cellDisabled:Boolean = false;
         var hideFg:Boolean = false;
         var skipLayer:Boolean = false;
         var currentLayerIsGround:* = false;
         var i:uint = 0;
         var nbCell:uint = 0;
         var cell:Cell = null;
         var cellRef:CellReference = null;
         var layer:Layer = null;
         var cellData:CellData = null;
         var cellElevation:int = 0;
         var finalGroundBitmapData:BitmapData = null;
         var finalGroundBitmap:Bitmap = null;
         this._downloadTimer.stop();
         if(this._progressBarCtr.parent)
         {
            this._progressBarCtr.parent.removeChild(this._progressBarCtr);
         }
         this._pictoAsBitmap = Atouin.getInstance().options.getOption("useCacheAsBitmap");
         var aInteractiveCell:Array = [];
         this._screenResolutionOffset = new Point();
         this._screenResolutionOffset.x = (bitmapSize.x - StageShareManager.startWidth) / 2;
         this._screenResolutionOffset.y = (bitmapSize.y - StageShareManager.startHeight) / 2;
         dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_START,false,false,this._map.id,this._renderId));
         if(!this._hasGroundJPG)
         {
            this.createGroundBitmap();
         }
         InteractiveCellManager.getInstance().initManager();
         EntitiesManager.getInstance().initManager();
         if(this._renderBackgroundColor)
         {
            this._container.opaqueBackground = this._map.backgroundColor;
         }
         var groundOnly:Boolean = OptionManager.getOptionManager("atouin").getOption("groundOnly");
         var lastCellId:int = 0;
         var currentCellId:uint = 0;
         for each(layer in this._map.layers)
         {
            if(layer.cellsCount != 0)
            {
               layerId = layer.layerId;
               layerCtr = null;
               currentLayerIsGround = layer.layerId == Layer.LAYER_GROUND;
               if(!currentLayerIsGround)
               {
                  layerCtr = this._dataMapContainer.getLayer(layerId);
               }
               hideFg = layerId && this._hideForeground;
               skipLayer = groundOnly;
               i = 0;
               nbCell = layer.cells.length;
               while(i < nbCell)
               {
                  cell = layer.cells[i];
                  currentCellId = cell.cellId;
                  if(layerId == Layer.LAYER_GROUND)
                  {
                     if(currentCellId - lastCellId > 1)
                     {
                        currentCellId = lastCellId + 1;
                        cell = null;
                     }
                     else
                     {
                        i++;
                     }
                  }
                  else
                  {
                     i++;
                  }
                  if(currentLayerIsGround)
                  {
                     cellCtr = new BitmapCellContainer(currentCellId);
                  }
                  else
                  {
                     cellCtr = new CellContainer(currentCellId);
                  }
                  cellCtr.layerId = layerId;
                  cellCtr.mouseEnabled = false;
                  if(cell)
                  {
                     cellPnt = cell.pixelCoords;
                     cellCtr.x = cellCtr.startX = int(Math.round(cellPnt.x)) * (cellCtr is CellContainer ? _groundGlobalScaleRatio : 1);
                     cellCtr.y = cellCtr.startY = int(Math.round(cellPnt.y)) * (cellCtr is CellContainer ? _groundGlobalScaleRatio : 1);
                     if(!skipLayer)
                     {
                        if(!this._hasGroundJPG || !currentLayerIsGround)
                        {
                           cellDisabled = this.addCellBitmapsElements(cell,cellCtr,hideFg,currentLayerIsGround);
                        }
                     }
                  }
                  else
                  {
                     cellDisabled = false;
                     cellPnt = Cell.cellPixelCoords(currentCellId);
                     cellCtr.x = cellCtr.startX = cellPnt.x;
                     cellCtr.y = cellCtr.startY = cellPnt.y;
                  }
                  if(!currentLayerIsGround)
                  {
                     layerCtr.addChild(cellCtr as DisplayObject);
                  }
                  else if(!this._hasGroundJPG)
                  {
                     this.drawCellOnGroundBitmap(this._groundBitmap,cellCtr as BitmapCellContainer);
                  }
                  cellRef = this._dataMapContainer.getCellReference(currentCellId);
                  cellRef.addSprite(cellCtr as DisplayObject);
                  cellRef.x = cellCtr.x;
                  cellRef.y = cellCtr.y;
                  cellRef.isDisabled = cellDisabled;
                  if(layerId != Layer.LAYER_ADDITIONAL_DECOR && !aInteractiveCell[currentCellId])
                  {
                     aInteractiveCell[currentCellId] = true;
                     cellInteractionCtr = this._icm.getCell(currentCellId);
                     cellData = this._map.cells[currentCellId] as CellData;
                     cellElevation = !!this._tacticModeActivated ? 0 : int(cellData.floor);
                     cellInteractionCtr.x = cellCtr.x;
                     cellInteractionCtr.y = cellCtr.y - cellElevation;
                     if(!this._dataMapContainer.getChildByName(currentCellId.toString()))
                     {
                        DataMapContainer.interactiveCell[currentCellId] = new InteractiveCell(currentCellId,cellInteractionCtr,cellInteractionCtr.x,cellInteractionCtr.y);
                     }
                     cellRef.elevation = cellInteractionCtr.y;
                     cellRef.mov = cellData.mov;
                  }
                  lastCellId = currentCellId;
               }
               if(!currentLayerIsGround)
               {
                  layerCtr.mouseEnabled = false;
                  layerCtr.scaleX = layerCtr.scaleY = 1 / _groundGlobalScaleRatio;
                  this._container.addChild(layerCtr);
               }
               else if(!this._hasGroundJPG)
               {
                  finalGroundBitmapData = new BitmapData(AtouinConstants.RESOLUTION_HIGH_QUALITY.x * this._renderScale,AtouinConstants.RESOLUTION_HIGH_QUALITY.y * this._renderScale,!this._renderBackgroundColor,!!this._renderBackgroundColor ? uint(this._map.backgroundColor) : uint(0));
                  this._m.identity();
                  this._m.scale(1 / _groundGlobalScaleRatio,1 / _groundGlobalScaleRatio);
                  finalGroundBitmapData.lock();
                  finalGroundBitmapData.draw(this._groundBitmap.bitmapData,this._m,null,null,null,true);
                  finalGroundBitmapData.unlock();
                  finalGroundBitmap = new Bitmap(finalGroundBitmapData,PixelSnapping.AUTO,true);
                  finalGroundBitmap.name = "finalGroundBitmap";
                  this._container.addChild(finalGroundBitmap);
               }
               if(!this._skipGroundCache && !this._hasGroundJPG && layerId == Layer.LAYER_GROUND && Capabilities.os.indexOf(OperatingSystem.MAC_OS) == -1)
               {
                  EnterFrameDispatcher.worker.addSingleTreatment(this,this.cacheMap,[]);
               }
            }
         }
         if(this.hasToRenderForegroundFixtures)
         {
            this.createForegroundBitmap();
            this._foregroundBitmap.visible = !this._tacticModeActivated;
            this._container.addChild(this._foregroundBitmap);
         }
         if(finalGroundBitmap)
         {
            if(this._groundBitmap && this._groundBitmap.bitmapData)
            {
               this._groundBitmap.bitmapData.dispose();
            }
            this._groundBitmap = finalGroundBitmap;
         }
         if(this._groundBitmap)
         {
            this._groundBitmap.x = -this._frustumX - this._screenResolutionOffset.x;
            this._groundBitmap.y = -this._screenResolutionOffset.y;
            this._groundBitmap.scaleX = this._groundBitmap.scaleY = this._groundBitmap.scaleY / this._renderScale;
         }
         var selectionContainer:Sprite = new Sprite();
         selectionContainer.name = "selectionCtr";
         this._container.addChild(selectionContainer);
         selectionContainer.mouseEnabled = false;
         selectionContainer.mouseChildren = false;
         if(!this._hasGroundJPG || this._groundIsLoaded)
         {
            dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_END,false,false,this._map.id,this._renderId));
            if(this._displayWorld)
            {
               Atouin.getInstance().worldContainer.visible = true;
            }
         }
         Atouin.getInstance().applyMapZoomScale(this._map);
         this._mapIsReady = true;
      }
      
      private function cacheMap() : void
      {
         var tsJpeg:uint = 0;
         try
         {
            tsJpeg = getTimer();
            DataGroundMapManager.saveGroundMap(this._groundBitmap.bitmapData,this._map);
            _log.info("Temps d\'encodage jpeg : " + (getTimer() - tsJpeg) + " ms");
         }
         catch(e:Error)
         {
            _log.fatal("Impossible de sauvegarder le sol de la map " + _map.id + " sous forme JPEG\n" + e.getStackTrace());
         }
      }
      
      private function createGroundBitmap() : void
      {
         var bitmapFinalWidth:uint = 0;
         var bitmapFinalHeight:uint = 0;
         var groundBitmapData:BitmapData = null;
         var finalScale:Number = _groundGlobalScaleRatio * this._renderScale;
         bitmapFinalWidth = bitmapSize.x * finalScale;
         bitmapFinalHeight = bitmapSize.y * finalScale;
         var bitmapBackgroundColor:uint = !!this._renderBackgroundColor ? uint(this._map.backgroundColor) : uint(0);
         try
         {
            groundBitmapData = new BitmapData(bitmapFinalWidth,bitmapFinalHeight,!this._renderBackgroundColor,bitmapBackgroundColor);
         }
         catch(e:ArgumentError)
         {
            _log.error("Not enough memory to create BitmapData. (size : " + bitmapFinalWidth + "x" + bitmapFinalHeight);
            return;
         }
         this._groundBitmap = new Bitmap(groundBitmapData,PixelSnapping.AUTO,true);
         this._groundBitmap.name = "ground";
         this._groundBitmap.x = -this._frustumX * finalScale;
         this.renderFixture(this._map.backgroundFixtures,this._groundBitmap);
      }
      
      private function createForegroundBitmap() : void
      {
         var foregroundBitmapData:BitmapData = null;
         try
         {
            foregroundBitmapData = new BitmapData(bitmapSize.x * this.renderScale,bitmapSize.y * this.renderScale,true,0);
         }
         catch(e:ArgumentError)
         {
            _log.error("Not enough memory to create BitmapData. (size : " + bitmapSize.x * renderScale + "x" + bitmapSize.y * renderScale);
            return;
         }
         this._foregroundBitmap = new Bitmap(foregroundBitmapData,PixelSnapping.AUTO,true);
         this._foregroundBitmap.name = "foreground";
         this._foregroundBitmap.x = -this._frustumX;
         if(bitmapSize.x != StageShareManager.startWidth)
         {
            this._foregroundBitmap.x -= this._screenResolutionOffset.x;
            this._foregroundBitmap.y -= this._screenResolutionOffset.y;
         }
         this._foregroundBitmap.scaleX = this._foregroundBitmap.scaleY = this._foregroundBitmap.scaleY / this.renderScale;
         this.renderFixture(this._map.foregroundFixtures,this._foregroundBitmap);
      }
      
      private function get hasToRenderForegroundFixtures() : Boolean
      {
         return this._renderFixture && this._map.foregroundFixtures && this._map.foregroundFixtures.length != 0;
      }
      
      private function drawCellOnGroundBitmap(groundLayerCtr:Bitmap, cellCtr:BitmapCellContainer) : void
      {
         var data:Object = null;
         var bmpdt:BitmapData = null;
         var hasColorTransform:Boolean = false;
         var i:int = 0;
         var ground:BitmapData = groundLayerCtr.bitmapData;
         var len:int = cellCtr.numChildren;
         ground.lock();
         for(i = 0; i < len; i++)
         {
            if(!(cellCtr.bitmaps[i] is BitmapData || cellCtr.bitmaps[i] is Bitmap))
            {
               _log.error("Attention, un élément non bitmap tente d\'être ajouter au sol " + cellCtr.bitmaps[i]);
            }
            else
            {
               bmpdt = cellCtr.bitmaps[i] is Bitmap ? Bitmap(cellCtr.bitmaps[i]).bitmapData : cellCtr.bitmaps[i];
               data = cellCtr.datas[i];
               if(!(bmpdt == null || data == null))
               {
                  if(cellCtr.colorTransforms[i] != null)
                  {
                     hasColorTransform = true;
                     this.colorTransform.redMultiplier = cellCtr.colorTransforms[i].red;
                     this.colorTransform.greenMultiplier = cellCtr.colorTransforms[i].green;
                     this.colorTransform.blueMultiplier = cellCtr.colorTransforms[i].blue;
                     this.colorTransform.alphaMultiplier = cellCtr.colorTransforms[i].alpha;
                  }
                  else
                  {
                     hasColorTransform = false;
                  }
                  this._destPoint.x = data.x + cellCtr.x;
                  if(_groundGlobalScaleRatio != 1)
                  {
                     this._destPoint.x *= _groundGlobalScaleRatio;
                  }
                  this._destPoint.x += this._frustumX;
                  this._destPoint.y = data.y + cellCtr.y;
                  if(_groundGlobalScaleRatio != 1)
                  {
                     this._destPoint.y *= _groundGlobalScaleRatio;
                  }
                  this._destPoint.x *= this._renderScale;
                  this._destPoint.y *= this._renderScale;
                  this._srcRect.width = bmpdt.width;
                  this._srcRect.height = bmpdt.height;
                  data.scaleX *= this._renderScale;
                  data.scaleY *= this._renderScale;
                  if(data.scaleX != 1 || data.scaleY != 1 || hasColorTransform)
                  {
                     this._m.identity();
                     this._m.scale(data.scaleX,data.scaleY);
                     this._m.translate(this._destPoint.x,this._destPoint.y);
                     this._m.translate(this._screenResolutionOffset.x,this._screenResolutionOffset.y);
                     ground.draw(bmpdt,this._m,this.colorTransform,null,null,false);
                  }
                  else
                  {
                     this._destPoint.x += this._screenResolutionOffset.x;
                     this._destPoint.y += this._screenResolutionOffset.y;
                     ground.copyPixels(bmpdt,this._srcRect,this._destPoint);
                  }
               }
            }
         }
         ground.unlock();
      }
      
      private function groundMapLoaded(ground:Bitmap) : void
      {
         this._groundIsLoaded = true;
         if(this._mapIsReady)
         {
            dispatchEvent(new RenderMapEvent(RenderMapEvent.MAP_RENDER_END,false,false,this._map.id,this._renderId));
            if(this._displayWorld)
            {
               Atouin.getInstance().worldContainer.visible = true;
            }
         }
         if(!this._tacticModeActivated)
         {
            ground.x -= this._frustumX;
            this._container.addChildAt(ground,0);
         }
         ground.smoothing = true;
         this._groundBitmap = ground;
         this._groundBitmap.x = -this._frustumX - this._screenResolutionOffset.x;
         this._groundBitmap.y = -this._screenResolutionOffset.y;
         this._groundBitmap.scaleX = this._groundBitmap.scaleY = this._groundBitmap.scaleY / this._renderScale;
      }
      
      private function groundMapNotLoaded(mapId:Number) : void
      {
         var mapDisplayManager:MapDisplayManager = null;
         if(this._map.id == mapId)
         {
            mapDisplayManager = MapDisplayManager.getInstance();
            mapDisplayManager.display(mapDisplayManager.currentMapPoint,true);
         }
      }
      
      public function addCellBitmapsElements(cell:Cell, cellCtr:ICellContainer, transparent:Boolean = false, ground:Boolean = false) : Boolean
      {
         var elementDo:Object = null;
         var data:VisualData = null;
         var colors:Object = null;
         var ge:GraphicalElement = null;
         var ed:GraphicalElementData = null;
         var element:BasicElement = null;
         var ged:NormalGraphicalElementData = null;
         var eed:EntityGraphicalElementData = null;
         var elementLook:TiphonEntityLook = null;
         var ts:WorldEntitySprite = null;
         var objectInfo:Object = null;
         var applicationDomain:ApplicationDomain = null;
         var ra:RasterizedAnimation = null;
         var ie:Object = null;
         var namedSprite:Sprite = null;
         var elementDOC:DisplayObjectContainer = null;
         var bmp:Bitmap = null;
         var shape:Shape = null;
         var disabled:Boolean = false;
         var mouseChildren:Boolean = false;
         var cacheAsBitmap:Boolean = true;
         var hasBlendMode:Boolean = false;
         var useWorldEntityPool:Boolean = Atouin.getInstance().options.getOption("useWorldEntityPool");
         var lsElements:Vector.<BasicElement> = cell.elements;
         var nbElements:int = lsElements.length;
         for(var i:int = 0; i < nbElements; i++)
         {
            data = new VisualData();
            element = lsElements[i];
            switch(element.elementType)
            {
               case ElementTypesEnum.GRAPHICAL:
                  ge = GraphicalElement(element);
                  ed = this._elements.getElementData(ge.elementId);
                  if(ed)
                  {
                     switch(true)
                     {
                        case ed is NormalGraphicalElementData:
                           ged = ed as NormalGraphicalElementData;
                           if(ged is AnimatedGraphicalElementData)
                           {
                              objectInfo = this._swfGfx[ged.gfxId];
                              applicationDomain = this._swfApplicationDomain[ged.gfxId];
                              if(objectInfo == null)
                              {
                                 _log.fatal("Impossible d\'afficher l\'élément " + ged.gfxId + " : instance non trouvée");
                                 break;
                              }
                              if(applicationDomain.hasDefinition("FX_0"))
                              {
                                 elementDo = new applicationDomain.getDefinition("FX_0")() as Sprite;
                              }
                              else if(this._map.getGfxCount(ged.gfxId) > 1)
                              {
                                 if(ASwf(objectInfo).content == null)
                                 {
                                    _log.fatal("Impossible d\'afficher le picto " + ged.gfxId + " (format swf), le swf est probablement compilé en AS2");
                                    continue;
                                 }
                                 if(this._renderScale != 1)
                                 {
                                    ASwf(objectInfo).content.scaleX = this._renderScale;
                                    ASwf(objectInfo).content.scaleY = this._renderScale;
                                 }
                                 ra = new RasterizedAnimation(ASwf(objectInfo).content as MovieClip,String(ged.gfxId));
                                 ra.gotoAndStop("1");
                                 ra.smoothing = true;
                                 elementDo = FpsControler.controlFps(ra,uint.MAX_VALUE);
                                 cacheAsBitmap = false;
                              }
                              else
                              {
                                 elementDo = ASwf(objectInfo).content;
                                 if(elementDo is MovieClip)
                                 {
                                    if(!MovieClipUtils.isSingleFrame(elementDo as MovieClip))
                                    {
                                       cacheAsBitmap = false;
                                    }
                                 }
                              }
                              data.scaleX = 1;
                              data.x = data.y = 0;
                           }
                           else if(ground)
                           {
                              elementDo = this._bitmapsGfx[ged.gfxId];
                           }
                           else
                           {
                              elementDo = new MapGfxBitmap(this._bitmapsGfx[ged.gfxId],"never",this._useSmooth,ge.identifier);
                              elementDo.name = "mapGfx::" + ge.elementId + "::" + ged.gfxId;
                              elementDo.cacheAsBitmap = this._pictoAsBitmap;
                              if(this._pictoAsBitmap)
                              {
                                 cachedAsBitmapElement.push(elementDo);
                              }
                           }
                           data.x -= ged.origin.x;
                           data.y -= ged.origin.y;
                           if(ged.horizontalSymmetry)
                           {
                              data.scaleX *= -1;
                              if(ged is AnimatedGraphicalElementData)
                              {
                                 data.x += ASwf(this._swfGfx[ged.gfxId]).loaderWidth;
                              }
                              else if(elementDo)
                              {
                                 data.x += elementDo.width / this._renderScale;
                              }
                           }
                           if(this._renderScale != 1)
                           {
                              if(!(ged is AnimatedGraphicalElementData && this._map.getGfxCount(ged.gfxId) == 1))
                              {
                                 data.scaleX /= this._renderScale;
                                 data.scaleY /= this._renderScale;
                              }
                           }
                           if(ged is BoundingBoxGraphicalElementData)
                           {
                              data.alpha = 0;
                              boundingBoxElements[ge.identifier] = true;
                           }
                           if(elementDo is InteractiveObject)
                           {
                              (elementDo as InteractiveObject).mouseEnabled = false;
                              if(elementDo is DisplayObjectContainer)
                              {
                                 (elementDo as DisplayObjectContainer).mouseChildren = false;
                              }
                           }
                           if(ed is BlendedGraphicalElementData && elementDo.hasOwnProperty("blendMode"))
                           {
                              elementDo.blendMode = (ed as BlendedGraphicalElementData).blendMode;
                              elementDo.cacheAsBitmap = false;
                              hasBlendMode = true;
                           }
                           break;
                        case ed is EntityGraphicalElementData:
                           eed = ed as EntityGraphicalElementData;
                           elementLook = null;
                           try
                           {
                              elementLook = TiphonEntityLook.fromString(eed.entityLook);
                           }
                           catch(e:Error)
                           {
                              _log.warn("Error in the Entity Element " + ed.id + "; misconstructed look string.");
                              break;
                           }
                           if(useWorldEntityPool)
                           {
                              ts = WorldEntityPool.checkOut(elementLook,cell.cellId,ge.identifier) as WorldEntitySprite;
                           }
                           else
                           {
                              ts = new WorldEntitySprite(elementLook,cell.cellId,ge.identifier);
                           }
                           ts.setDirection(0);
                           ts.mouseChildren = false;
                           ts.mouseEnabled = false;
                           ts.cacheAsBitmap = this._pictoAsBitmap;
                           if(this._pictoAsBitmap)
                           {
                              cachedAsBitmapElement.push(ts);
                           }
                           if(this.useDefautState)
                           {
                              ts.setAnimationAndDirection("AnimState0",0);
                           }
                           if(eed.horizontalSymmetry)
                           {
                              data.scaleX *= -1;
                           }
                           this._dataMapContainer.addAnimatedElement(ts,eed);
                           elementDo = ts;
                     }
                     if(elementDo == null)
                     {
                        _log.warn("A graphical element was missed (Element ID " + ge.elementId + "; Cell " + ge.cell.cellId + ").");
                        break;
                     }
                     if(!ge.colorMultiplicator.isOne())
                     {
                        colors = {
                           "red":ge.colorMultiplicator.red / 255,
                           "green":ge.colorMultiplicator.green / 255,
                           "blue":ge.colorMultiplicator.blue / 255,
                           "alpha":data.alpha
                        };
                     }
                     if(transparent)
                     {
                        data.alpha = 0.5;
                     }
                  }
                  continue;
                  if(ge.identifier > 0)
                  {
                     if(ground)
                     {
                        _log.warn("Will not render elementId " + ed.id + " since it\'s an interactive one (identifier: " + ge.identifier + "), on the ground layer!");
                        continue;
                     }
                     if((!(elementDo is InteractiveObject) || elementDo is DisplayObjectContainer) && elementDo is DisplayObject)
                     {
                        namedSprite = new SpriteWrapper(elementDo as DisplayObject,ge.identifier);
                        namedSprite.alpha = elementDo.alpha;
                        elementDo.alpha = 1;
                        if(colors.alpha > 0)
                        {
                           elementDo.transform.colorTransform = new ColorTransform(colors.red,colors.green,colors.blue,colors.alpha);
                        }
                        colors = null;
                        elementDo = namedSprite;
                     }
                     mouseChildren = true;
                     elementDo.cacheAsBitmap = true;
                     cachedAsBitmapElement.push(elementDo);
                     if(elementDo is DisplayObjectContainer)
                     {
                        elementDOC = elementDo as DisplayObjectContainer;
                        elementDOC.mouseChildren = false;
                     }
                     ie = {
                        "sprite":elementDo,
                        "position":MapPoint.fromCellId(cell.cellId)
                     };
                     this._identifiedElements[ge.identifier] = ie;
                  }
                  data.x += Math.round(AtouinConstants.CELL_HALF_WIDTH + ge.pixelOffset.x);
                  data.y += Math.round(AtouinConstants.CELL_HALF_HEIGHT - ge.altitude * 10 + ge.pixelOffset.y);
                  break;
            }
            if(elementDo)
            {
               cellCtr.addFakeChild(elementDo,data,colors);
            }
            else if(element.elementType != ElementTypesEnum.SOUND)
            {
               if(this._cellBitmapData == null)
               {
                  this._cellBitmapData = new BitmapData(AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT,false,13369548);
                  shape = new Shape();
                  shape.graphics.beginFill(13369548);
                  shape.graphics.drawRect(0,0,AtouinConstants.CELL_WIDTH,AtouinConstants.CELL_HEIGHT);
                  shape.graphics.endFill();
                  this._cellBitmapData.draw(shape);
               }
               bmp = new Bitmap(this._cellBitmapData);
               cellCtr.addFakeChild(bmp,null,null);
            }
         }
         if(this._pictoAsBitmap && !hasBlendMode)
         {
            cellCtr.cacheAsBitmap = cacheAsBitmap;
            if(cacheAsBitmap)
            {
               cachedAsBitmapElement.push(cellCtr);
            }
         }
         else
         {
            cellCtr.cacheAsBitmap = false;
         }
         cellCtr.mouseChildren = mouseChildren;
         return disabled;
      }
      
      private function renderFixture(fixtures:Vector.<Fixture>, container:Bitmap) : void
      {
         var bmpdt:BitmapData = null;
         var fixture:Fixture = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var halfWidth:Number = NaN;
         var halfHeight:Number = NaN;
         if(fixtures == null || fixtures.length == 0 || !this._renderFixture)
         {
            return;
         }
         var smoothing:Boolean = OptionManager.getOptionManager("atouin").getOption("useSmooth");
         var l:int = fixtures.length;
         container.bitmapData.lock();
         for(var i:int = 0; i < l; i++)
         {
            fixture = fixtures[i];
            bmpdt = this._bitmapsGfx[fixture.fixtureId];
            if(!bmpdt)
            {
               _log.error("Fixture " + fixture.fixtureId + " file is missing ");
            }
            else
            {
               width = bmpdt.width;
               height = bmpdt.height;
               halfWidth = width * 0.5;
               halfHeight = height * 0.5;
               this._m.identity();
               this._m.translate(-halfWidth,-halfHeight);
               this._m.scale(fixture.xScale / 1000,fixture.yScale / 1000);
               this._m.rotate(fixture.rotation / 100 * (Math.PI / 180));
               this._m.translate((fixture.offset.x + AtouinConstants.CELL_HALF_WIDTH + this._frustumX) * this.renderScale + halfWidth,(fixture.offset.y + AtouinConstants.CELL_HEIGHT) * this.renderScale + halfHeight);
               this._m.translate(this._screenResolutionOffset.x,this._screenResolutionOffset.y);
               if(int(fixture.redMultiplier) || int(fixture.greenMultiplier) || fixture.blueMultiplier || fixture.alpha != 1)
               {
                  this._clTrans.redMultiplier = fixture.redMultiplier / 127 + 1;
                  this._clTrans.greenMultiplier = fixture.greenMultiplier / 127 + 1;
                  this._clTrans.blueMultiplier = fixture.blueMultiplier / 127 + 1;
                  this._clTrans.alphaMultiplier = fixture.alpha / 255;
                  container.bitmapData.draw(bmpdt,this._m,this._clTrans,null,null,smoothing);
               }
               else
               {
                  container.bitmapData.draw(bmpdt,this._m,null,null,null,smoothing);
               }
            }
         }
         container.bitmapData.unlock();
      }
      
      public function get container() : DisplayObjectContainer
      {
         return this._container;
      }
      
      private function onAllGfxLoaded(e:ResourceLoaderProgressEvent) : void
      {
         if(this._cancelRender || this._mapIsReady)
         {
            return;
         }
         ++this._loadedGfxListCount;
         if(this._hasBitmapGfx && this._hasSwfGfx && this._loadedGfxListCount != 2)
         {
            return;
         }
         this._mapLoaded = true;
         dispatchEvent(new Event(RenderMapEvent.GFX_LOADING_END));
         this.makeMap();
      }
      
      private function onBitmapGfxLoaded(e:ResourceLoadedEvent) : void
      {
         var mc:MovieClip = null;
         var bd:BitmapData = null;
         if(this._cancelRender)
         {
            return;
         }
         ++this._filesLoaded;
         this._downloadProgressBar.scaleX = this._filesLoaded / this._filesToLoad;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,this._filesLoaded,this._filesToLoad));
         if(e.resource is BitmapData)
         {
            this._bitmapsGfx[e.uri.tag] = e.resource;
            this._gfxMemorySize += BitmapData(e.resource).width * BitmapData(e.resource).height * 4;
         }
         else if(e.resource.content is MovieClip)
         {
            mc = e.resource.content as MovieClip;
            bd = this.rasterizeSwf(mc,this.renderScale);
            this._bitmapsGfx[e.uri.tag] = bd;
            this._gfxMemorySize += bd.width * bd.height * 4;
         }
         else
         {
            _log.warn("SWF " + e.uri.tag + " (type: " + e.resource.content + ") cannot be converted to BitmapData!");
         }
         MEMORY_LOG_1[e.resource] = 1;
      }
      
      private function onSwfGfxLoaded(e:ResourceLoadedEvent) : void
      {
         ++this._filesLoaded;
         this._downloadProgressBar.scaleX = this._filesLoaded / this._filesToLoad;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,this._filesLoaded,this._filesToLoad));
         this._swfGfx[e.uri.tag] = e.resource;
         MEMORY_LOG_2[e.resource] = 1;
      }
      
      private function onGfxError(e:ResourceErrorEvent) : void
      {
         _log.error("Unable to load " + e.uri + " : #" + e.errorCode + " : " + e.errorMsg);
      }
      
      private function onDownloadTimer(e:TimerEvent) : void
      {
         this.stopDelayProgressBar();
         if(Atouin.getInstance().options.getOption("showProgressBar"))
         {
            this._container.addChild(this._progressBarCtr);
         }
      }
      
      private function initGfxLoader() : void
      {
         if(this._gfxLoader)
         {
            this.removeGfxLoaderListeners();
            this._gfxLoader.cancel();
         }
         this._gfxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this.addGfxLoaderListeners();
      }
      
      private function addGfxLoaderListeners() : void
      {
         this._gfxLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
         this._gfxLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onBitmapGfxLoaded,false,0,true);
         this._gfxLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
      }
      
      private function hasGfxLoaderListeners() : Boolean
      {
         return this._gfxLoader.hasEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE);
      }
      
      private function removeGfxLoaderListeners() : void
      {
         this._gfxLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
         this._gfxLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onBitmapGfxLoaded);
         this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
      }
      
      private function initSwfLoader() : void
      {
         if(this._swfLoader)
         {
            this.removeSwfLoaderListeners();
            this._swfLoader.cancel();
         }
         this._swfLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this.addSwfLoaderListeners();
      }
      
      private function addSwfLoaderListeners() : void
      {
         this._swfLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
         this._swfLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onSwfGfxLoaded,false,0,true);
         this._swfLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
      }
      
      private function hasSwfLoaderListeners() : Boolean
      {
         return this._swfLoader.hasEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE);
      }
      
      private function removeSwfLoaderListeners() : void
      {
         this._swfLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
         this._swfLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onSwfGfxLoaded);
         this._swfLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
      }
      
      private function rasterizeSwf(swf:DisplayObject, scale:int = 1) : BitmapData
      {
         var bd2:BitmapData = null;
         var mat:Matrix = new Matrix();
         var bounds:Rectangle = swf.getBounds(swf);
         mat.scale(this._renderScale,this._renderScale);
         mat.translate(-bounds.x * this._renderScale,-bounds.y * this._renderScale);
         var bd:BitmapData = new BitmapData(swf.width * this._renderScale,swf.height * this._renderScale,true,0);
         bd.draw(swf,mat);
         mat.identity();
         var rect:Rectangle = bd.getColorBoundsRect(4278190080,0,false);
         if(rect.width > 0 && rect.height > 0)
         {
            mat.translate(-rect.x,-rect.y);
            bd2 = new BitmapData(rect.width,rect.height,true,0);
            bd2.draw(bd,mat);
            bd.dispose();
         }
         else
         {
            bd2 = bd;
         }
         return bd2;
      }
   }
}

class VisualData
{
    
   
   public var scaleX:Number = 1;
   
   public var scaleY:Number = 1;
   
   public var x:Number = 0;
   
   public var y:Number = 0;
   
   public var width:Number = 0;
   
   public var height:Number = 0;
   
   public var alpha:Number = 1;
   
   function VisualData()
   {
      super();
   }
}
