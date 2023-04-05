package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.TextureLoadFailMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.UriCacheFactory;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Texture extends TextureBase implements FinalizableUIComponent, IRectangle
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      private var _log:Logger;
      
      private var _realUri:Uri;
      
      var _child:DisplayObject;
      
      private var _startedWidth:Number;
      
      private var _startedHeight:Number;
      
      private var _forcedHeight:Number;
      
      private var _forcedWidth:Number;
      
      private var _keepRatio:Boolean;
      
      private var _dispatchMessages:Boolean;
      
      private var _autoGrid:Boolean;
      
      private var _forceReload:Boolean = false;
      
      private var _gotoFrame;
      
      private var _loader:IResourceLoader;
      
      private var _startBounds:Rectangle;
      
      private var _disableAnimation:Boolean = false;
      
      private var _roundCornerRadius:int = -1;
      
      private var _playOnce:Boolean = false;
      
      private var _bitmap:Bitmap;
      
      public var defaultBitmapData:BitmapData;
      
      private var rle_uri_path;
      
      public function Texture()
      {
         this._log = Log.getLogger(getQualifiedClassName(Texture));
         super();
         mouseEnabled = false;
         mouseChildren = false;
         _smooth = true;
         MEMORY_LOG[this] = 1;
      }
      
      [Uri]
      override public function set uri(value:Uri) : void
      {
         if(value != _uri || this._forceReload)
         {
            _uri = value;
            if(_finalized)
            {
               this.reload();
            }
            return;
         }
      }
      
      public function set disableAnimation(value:Boolean) : void
      {
         this._disableAnimation = value;
         if(_finalized)
         {
            MovieClipUtils.stopMovieClip(this);
         }
      }
      
      override public function get height() : Number
      {
         return !isNaN(this._forcedHeight) ? Number(this._forcedHeight) : (!!this._child ? Number(this._child.height) : Number(0));
      }
      
      override public function set height(value:Number) : void
      {
         if(this._forcedHeight == value)
         {
            return;
         }
         this._forcedHeight = value;
         if(_finalized)
         {
            this.organize();
         }
      }
      
      override public function get width() : Number
      {
         return !isNaN(this._forcedWidth) ? Number(this._forcedWidth) : (!!this._child ? Number(this._child.width) : Number(0));
      }
      
      override public function set width(value:Number) : void
      {
         if(this._forcedWidth == value)
         {
            return;
         }
         this._forcedWidth = value;
         if(_finalized)
         {
            this.organize();
         }
      }
      
      public function get keepRatio() : Boolean
      {
         return this._keepRatio;
      }
      
      public function set keepRatio(value:Boolean) : void
      {
         this._keepRatio = value;
         if(_finalized)
         {
            this.organize();
         }
      }
      
      override public function get scale9Grid() : Rectangle
      {
         if(this._child)
         {
            return this._child.scale9Grid;
         }
         return null;
      }
      
      override public function set scale9Grid(value:Rectangle) : void
      {
         if(this._child)
         {
            this._child.scale9Grid = value;
         }
      }
      
      public function vFlip() : void
      {
         var tempX:Number = x;
         var tempY:Number = y;
         scaleX = -1;
         x = tempX + this.width;
      }
      
      public function hFlip() : void
      {
         var tempX:Number = x;
         var tempY:Number = y;
         scaleY = -1;
         y = tempY + this.height;
      }
      
      public function get autoGrid() : Boolean
      {
         return this._autoGrid;
      }
      
      public function set autoGrid(value:Boolean) : void
      {
         if(value)
         {
            this._autoGrid = true;
         }
         else
         {
            this._autoGrid = false;
            if(this._child)
            {
               this._child.scale9Grid = null;
            }
         }
         if(_finalized)
         {
            this.organize();
         }
      }
      
      public function set gotoAndStop(value:*) : void
      {
         var mv:MovieClip = null;
         mv = this._child as MovieClip;
         if(mv != null)
         {
            try
            {
               mv.gotoAndStop(value);
            }
            catch(error:ArgumentError)
            {
               mv.stop();
            }
         }
         this._gotoFrame = value;
      }
      
      public function get gotoAndStop() : *
      {
         if(this._child && this._child is MovieClip)
         {
            return (this._child as MovieClip).currentFrame.toString();
         }
         return this._gotoFrame;
      }
      
      private function hasLabel(mv:MovieClip, lbl:String) : Boolean
      {
         var label:FrameLabel = null;
         var labels:Array = mv.currentLabels;
         for each(label in labels)
         {
            if(lbl == label.name)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set gotoAndPlay(value:*) : void
      {
         if(this._child && this._child is MovieClip)
         {
            if(value)
            {
               (this._child as MovieClip).gotoAndPlay(value);
            }
            else
            {
               (this._child as MovieClip).gotoAndPlay(1);
            }
         }
      }
      
      public function get totalFrames() : uint
      {
         if(this._child && this._child is MovieClip)
         {
            return (this._child as MovieClip).totalFrames;
         }
         return 1;
      }
      
      public function get currentFrame() : uint
      {
         if(this._child && this._child is MovieClip)
         {
            return (this._child as MovieClip).currentFrame;
         }
         return 1;
      }
      
      public function get dispatchMessages() : Boolean
      {
         return this._dispatchMessages;
      }
      
      public function set dispatchMessages(value:Boolean) : void
      {
         this._dispatchMessages = value;
      }
      
      public function get forceReload() : Boolean
      {
         return this._forceReload;
      }
      
      public function set forceReload(value:Boolean) : void
      {
         this._forceReload = value;
      }
      
      public function get loading() : Boolean
      {
         return this._loader != null;
      }
      
      public function get child() : DisplayObject
      {
         return this._child;
      }
      
      override public function loadBitmapData(bmpdt:BitmapData) : void
      {
         this._bitmap = new Bitmap(bmpdt,"auto",_smooth);
         if(_finalized)
         {
            this.reload();
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         if(this._bitmap != null)
         {
            return this._bitmap.bitmapData.clone();
         }
         return null;
      }
      
      public function stopAllAnimation() : void
      {
         var doc:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(doc)
         {
            MovieClipUtils.stopMovieClip(doc);
         }
      }
      
      public function getChildDuration() : uint
      {
         var i:uint = 0;
         var o:DisplayObject = null;
         var mc:MovieClip = null;
         var t:uint = 0;
         var doc:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(doc)
         {
            for(i = 0; i < doc.numChildren; i++)
            {
               o = DisplayObjectContainer(this._child).getChildAt(i);
               if(o is MovieClip && MovieClip(o).totalFrames && MovieClip(o).totalFrames > t)
               {
                  t = MovieClip(o).totalFrames;
               }
            }
         }
         else if(this._child is MovieClip)
         {
            mc = this._child as MovieClip;
            t = mc.totalFrames;
         }
         return t;
      }
      
      public function gotoAndPayChild(frameNumber:uint) : void
      {
         var i:uint = 0;
         var o:DisplayObject = null;
         var mc:MovieClip = null;
         var doc:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(doc)
         {
            for(i = 0; i < doc.numChildren; i++)
            {
               o = DisplayObjectContainer(this._child).getChildAt(i);
               if(o is MovieClip)
               {
                  (o as MovieClip).gotoAndPlay(frameNumber);
               }
            }
         }
         else if(this._child is MovieClip)
         {
            mc = this._child as MovieClip;
            mc.gotoAndPlay(frameNumber);
         }
      }
      
      public function get roundCornerRadius() : uint
      {
         return this._roundCornerRadius;
      }
      
      public function set roundCornerRadius(v:uint) : void
      {
         this._roundCornerRadius = v;
         this.initMask();
      }
      
      public function get playOnce() : Boolean
      {
         return this._playOnce;
      }
      
      public function set playOnce(v:Boolean) : void
      {
         if(this._child && this._child is MovieClip)
         {
            MovieClip(this._child).addFrameScript(MovieClip(this._child).totalFrames - 1,!!v ? this.stopAllAnimation : null);
         }
         this._playOnce = v;
      }
      
      override public function finalize() : void
      {
         this.reload();
      }
      
      override public function free() : void
      {
         super.free();
         _finalized = false;
         _uri = null;
         this._child = null;
         this._startedWidth = 0;
         this._startedHeight = 0;
         this._forcedHeight = 0;
         this._forcedWidth = 0;
         this._keepRatio = false;
         this._dispatchMessages = false;
         this._autoGrid = false;
         this._forceReload = false;
         this._gotoFrame = null;
         this._loader = null;
         this._startBounds = null;
         this._playOnce = false;
      }
      
      override public function getChildByName(name:String) : DisplayObject
      {
         if(this._child && this._child is DisplayObjectContainer)
         {
            return DisplayObjectContainer(this._child).getChildByName(name);
         }
         return null;
      }
      
      public function nextFrame() : void
      {
         var frame:int = 0;
         var child:MovieClip = this._child as MovieClip;
         if(child)
         {
            if(child.currentFrame == child.totalFrames)
            {
               child.gotoAndStop(1);
            }
            else
            {
               child.gotoAndStop(child.currentFrame + 1);
            }
         }
      }
      
      private function reload() : void
      {
         var realUri:Uri = null;
         var forcedAdapter:Class = null;
         var singleFile:Boolean = false;
         if(_uri)
         {
            applyUserColor(_uri.path,this);
         }
         if(this._bitmap != null && this._child != this._bitmap)
         {
            if(this._child && this._child.parent)
            {
               this.stopAllAnimation();
               this._child.parent.removeChild(this._child);
               this._child = null;
            }
            this._child = addChild(this._bitmap);
            this._startBounds = this._child.getBounds(this);
            this._startedWidth = this._child.width;
            this._startedHeight = this._child.height;
            this.organize();
            if(this._disableAnimation)
            {
               MovieClipUtils.stopMovieClip(this);
            }
            if(this._dispatchMessages && Berilia.getInstance() && Berilia.getInstance().handler)
            {
               dispatchEvent(new Event(Event.COMPLETE));
               Berilia.getInstance().handler.process(new TextureReadyMessage(this));
            }
         }
         else if(_uri)
         {
            if(!this._loader)
            {
               this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
               this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded,false,0,true);
               this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed,false,0,true);
            }
            else
            {
               this._loader.cancel();
            }
            if(_uri.subPath)
            {
               if(_uri.protocol == "mod" || _uri.protocol == "theme" || _uri.protocol == "pak" || _uri.protocol == "d2p" || _uri.protocol == "pak2" || _uri.protocol == "d2pOld")
               {
                  realUri = new Uri(_uri.normalizedUri);
               }
               else
               {
                  realUri = new Uri(_uri.path);
               }
               realUri.loaderContext = _uri.loaderContext;
               this._realUri = realUri;
               if(!(_uri.protocol == "pak" || _uri.protocol == "d2p" || _uri.protocol == "pak2" || _uri.protocol == "dp2Old"))
               {
                  forcedAdapter = AdvancedSwfAdapter;
               }
            }
            else
            {
               realUri = _uri;
            }
            if(hasEventListener(Event.INIT))
            {
               dispatchEvent(new Event(Event.INIT));
            }
            singleFile = false;
            if(!_useCache && !_uri.subPath)
            {
               singleFile = true;
            }
            if(realUri.fileType.toLowerCase() != "swf")
            {
               _useCache = false;
            }
            else
            {
               _useCache = _useCacheTmp;
            }
            this._loader.load(realUri,!!_useCache ? UriCacheFactory.getCacheFromUri(realUri) : null,forcedAdapter,singleFile);
         }
         else
         {
            if(this._child)
            {
               while(numChildren)
               {
                  removeChildAt(0);
               }
               this._child = null;
            }
            super.finalize();
            _finalized = true;
            if(getUi())
            {
               getUi().iAmFinalized(this);
            }
         }
      }
      
      private function organize() : void
      {
         var rec:Rectangle = null;
         var ratio:Number = NaN;
         if(!this._child)
         {
            return;
         }
         var rerender:Boolean = false;
         if(this._gotoFrame && this._child is MovieClip)
         {
            this.gotoAndStop = this._gotoFrame;
         }
         else
         {
            this.gotoAndStop = "0";
         }
         this.playOnce = this._playOnce;
         if(this._autoGrid)
         {
            rec = new Rectangle(this._startedWidth / 3,int(this._startedHeight / 3),this._startedWidth / 3,int(this._startedHeight / 3));
            try
            {
               this._child.scale9Grid = rec;
            }
            catch(e:Error)
            {
               _log.error("Erreur de scale9grid avec " + _uri + ", rect : " + rec);
            }
         }
         if(this._keepRatio)
         {
            ratio = 1;
            if(isNaN(this._forcedWidth) && isNaN(this._forcedHeight))
            {
               this._log.warn("Cannot keep the ratio with no forced dimension.");
            }
            else
            {
               if(isNaN(this._forcedWidth))
               {
                  ratio = this._forcedHeight / this._child.height;
               }
               else if(isNaN(this._forcedHeight))
               {
                  ratio = this._forcedWidth / this._child.width;
               }
               else if(this._forcedHeight > this._forcedWidth)
               {
                  ratio = this._child.width / this._forcedWidth;
               }
               else if(this._forcedHeight < this._forcedWidth)
               {
                  ratio = this._child.height / this._forcedHeight;
               }
               this._child.scaleX = this._child.scaleY = ratio;
            }
         }
         else
         {
            if(!isNaN(this._forcedHeight) && this._forcedHeight != 0 && this._forcedHeight != this._child.height)
            {
               this._child.height = this._forcedHeight;
            }
            else
            {
               rerender = true;
            }
            if(!isNaN(this._forcedWidth))
            {
               this._child.width = this._forcedWidth;
            }
            else
            {
               rerender = true;
            }
         }
         if(!_finalized)
         {
            super.finalize();
            _finalized = true;
            if(getUi())
            {
               getUi().iAmFinalized(this);
            }
         }
         else if(rerender || true)
         {
            super.finalize();
            if(getUi())
            {
               getUi().iAmFinalized(this);
            }
         }
      }
      
      private function initMask() : void
      {
         if(this._roundCornerRadius == -1)
         {
            return;
         }
         if(mask && mask.parent == this)
         {
            removeChild(mask);
         }
         if(this._roundCornerRadius == 0)
         {
            mask = null;
            return;
         }
         var maskCtr:Shape = new Shape();
         maskCtr.graphics.beginFill(7798784);
         maskCtr.graphics.drawRoundRectComplex(0,0,this.width,this.height,this._roundCornerRadius,this._roundCornerRadius,this._roundCornerRadius,this._roundCornerRadius);
         addChild(maskCtr);
         mask = maskCtr;
      }
      
      override protected function onLoaded(rle:ResourceLoadedEvent) : void
      {
         var aswf:ASwf = null;
         var error:ResourceErrorEvent = null;
         if(__removed)
         {
            return;
         }
         if(this._bitmap != null)
         {
            if(this._bitmap.parent == this)
            {
               removeChild(this._bitmap);
            }
            this._bitmap = null;
         }
         if(_uri == null || _uri.path != rle.uri.path && _uri.normalizedUri != rle.uri.path)
         {
            this.rle_uri_path = rle.uri.path;
            return;
         }
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onFailed);
         this._loader = null;
         if(this._child && this._child.parent)
         {
            this.stopAllAnimation();
            this._child.parent.removeChild(this._child);
            this._child = null;
         }
         if(rle.resourceType == ResourceType.RESOURCE_SWF)
         {
            if(!rle.resource)
            {
               this._log.warn("Empty SWF : " + rle.uri + " in " + getUi().name);
               return;
            }
            this._child = addChild(rle.resource);
            if(this._child is MovieClip)
            {
               (this._child as MovieClip).stop();
            }
         }
         else if(rle.resourceType == ResourceType.RESOURCE_BITMAP)
         {
            this._child = addChild(new Bitmap(rle.resource,"auto",true));
            if(autoCenterBitmap)
            {
               this._child.x -= this._child.width / 2;
               this._child.y -= this._child.height / 2;
            }
         }
         else
         {
            if(rle.resourceType != ResourceType.RESOURCE_ASWF)
            {
               throw new IllegalOperationError("A Texture component can\'t display a non-displayable resource.");
            }
            aswf = ASwf(rle.resource);
            if(_uri.subPath)
            {
               try
               {
                  this._child = addChild(new (aswf.applicationDomain.getDefinition(_uri.subPath) as Class)() as DisplayObject);
               }
               catch(e:Error)
               {
                  error = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
                  error.errorCode = ResourceErrorCode.SUB_RESOURCE_NOT_FOUND;
                  error.uri = _uri;
                  error.errorMsg = "Sub ressource \'" + _uri.subPath + "\' not found";
                  onFailed(error);
                  return;
               }
            }
            else
            {
               this._child = addChild(aswf.content);
               if(this._child is MovieClip)
               {
                  (this._child as MovieClip).stop();
               }
            }
         }
         if(this._child != null)
         {
            this._startBounds = this._child.getBounds(this);
            this._startedWidth = this._child.width;
            this._startedHeight = this._child.height;
         }
         this.organize();
         if(this._disableAnimation)
         {
            MovieClipUtils.stopMovieClip(this);
         }
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         if(this._dispatchMessages && Berilia.getInstance() && Berilia.getInstance().handler)
         {
            (Berilia.getInstance().handler as Worker).processImmediately(new TextureReadyMessage(this));
         }
         this.initMask();
      }
      
      override protected function onFailed(ree:ResourceErrorEvent) : void
      {
         var shp:Shape = null;
         if(__removed)
         {
            return;
         }
         var behavior:DynamicSecureObject = new DynamicSecureObject();
         behavior.cancel = false;
         if(KernelEventsManager.getInstance().isRegisteredEvent(BeriliaHookList.TextureLoadFailed))
         {
            _finalized = true;
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.TextureLoadFailed,this,behavior);
         }
         else
         {
            this._log.error("UI " + (!!getUi() ? getUi().name : "unknow") + "/" + name + ", texture resource not found: " + (!!ree ? ree.errorMsg : "No ressource specified.") + ", requested uri : " + ree.uri);
         }
         dispatchEvent(new TextureLoadFailedEvent(this,behavior));
         Berilia.getInstance().handler.process(new TextureLoadFailMessage(this));
         if(!behavior.cancel && ree.uri == _uri)
         {
            this._loader = null;
            if(ree.uri == _uri)
            {
               if(this._child)
               {
                  while(numChildren)
                  {
                     removeChildAt(0);
                  }
                  this._child = null;
                  this._bitmap = null;
               }
               if(_showLoadingError)
               {
                  shp = new Shape();
                  shp.graphics.beginFill(16711935);
                  shp.graphics.drawRect(0,0,!isNaN(this._forcedWidth) && this._forcedWidth != 0 ? Number(this._forcedWidth) : Number(10),!isNaN(this._forcedHeight) && this._forcedHeight != 0 ? Number(this._forcedHeight) : Number(10));
                  shp.graphics.endFill();
                  this._child = addChild(shp);
               }
            }
         }
         _finalized = true;
         super.finalize();
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      override public function remove() : void
      {
         if(!__removed)
         {
            __removed = true;
            if(this._child)
            {
               this._child.width = this._startedWidth;
               this._child.height = this._startedHeight;
               this._child.scaleX = 1;
               this._child.scaleY = 1;
               if(this._child is MovieClip)
               {
                  MovieClipUtils.stopMovieClip(this._child as MovieClip);
               }
               if(this._child.parent)
               {
                  this._child.parent.removeChild(this._child);
               }
            }
            if(parent && parent.contains(this))
            {
               parent.removeChild(this);
            }
            if(this._loader)
            {
               this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
               this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onFailed);
            }
         }
         super.remove();
      }
   }
}
