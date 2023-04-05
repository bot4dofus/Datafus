package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.TextureLoadFailMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.Margin;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.types.graphic.GraphicLocation;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TextureBitmap extends TextureBase implements FinalizableUIComponent
   {
      
      private static const RENDER_MODE_FIT:uint = 0;
      
      private static const RENDER_MODE_SCALE9:uint = 1;
      
      private static const RENDER_MODE_CROP:uint = 2;
      
      private static const RENDER_MODE_TILE:uint = 3;
      
      private static const RENDER_MODE_DYNAMIC:uint = 4;
       
      
      private var _bitmapData:BitmapData;
      
      private var _align:String;
      
      private var _autoFit:Boolean = false;
      
      private var _scale9Grid:Rectangle;
      
      private var _margin:Margin;
      
      private var _loader:IResourceLoader;
      
      private var _nextUri:Uri;
      
      private var _fillMatrix:Matrix;
      
      private var _dynamicRender:Boolean = false;
      
      private var _tileRender:Boolean = false;
      
      private var _renderMode:uint = 0;
      
      public function TextureBitmap()
      {
         this._margin = new Margin();
         this._fillMatrix = new Matrix();
         super();
      }
      
      override public function set shadowColor(nColor:int) : void
      {
      }
      
      public function get dynamicRender() : Boolean
      {
         return this._dynamicRender;
      }
      
      public function set dynamicRender(value:Boolean) : void
      {
         this._dynamicRender = value;
         this.invalidate();
      }
      
      public function get tileRender() : Boolean
      {
         return this._tileRender;
      }
      
      public function set tileRender(value:Boolean) : void
      {
         this._tileRender = value;
         this.invalidate();
      }
      
      public function get margin() : Margin
      {
         return this._margin;
      }
      
      public function set margin(value:Margin) : void
      {
         this._margin = value;
         this.invalidate();
      }
      
      override public function set width(w:Number) : void
      {
         super.width = w;
         this.invalidate();
      }
      
      override public function set height(h:Number) : void
      {
         super.height = h;
         this.invalidate();
      }
      
      [Uri]
      override public function set uri(uri:Uri) : void
      {
         super.uri = uri;
         if(_uri == uri || uri && uri.path == "null" || _uri && uri && _uri.path == uri.path && _uri.subPath == uri.subPath)
         {
            return;
         }
         _uri = uri;
         if(_uri == null)
         {
            this._bitmapData = null;
            this.invalidate();
            return;
         }
         _finalized = false;
         this._bitmapData = getBitmapDataFromCache(_uri.path);
         if(!this._bitmapData)
         {
            if(!this._loader)
            {
               this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
               this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
               this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed);
               this._loader.load(_uri);
            }
            else
            {
               this._nextUri = uri;
            }
         }
         else
         {
            this.destroyLoader();
            this.finalize();
         }
      }
      
      public function set align(str:String) : void
      {
         if(str == this._align)
         {
            return;
         }
         var validAlign:Array = [null,"TOPLEFT","TOP","TOPRIGHT","LEFT","CENTER","RIGHT","BOTTOMLEFT","BOTTOM","BOTTOMRIGHT"];
         if(validAlign.indexOf(str.toUpperCase()) == -1)
         {
            _log.warn("[" + str + "] is not a valid align value, please use one of those : " + validAlign.join(","));
            return;
         }
         this._align = str;
         this.invalidate();
      }
      
      public function get align() : String
      {
         return this._align;
      }
      
      override public function get scale9Grid() : Rectangle
      {
         return this._scale9Grid;
      }
      
      override public function set scale9Grid(value:Rectangle) : void
      {
         this._scale9Grid = value;
         this.invalidate();
      }
      
      override public function set smooth(value:Boolean) : void
      {
         super.smooth = value;
         this.invalidate();
      }
      
      public function invalidate() : void
      {
         if(_finalized)
         {
            this.finalize();
         }
      }
      
      override public function finalize() : void
      {
         graphics.clear();
         if(this._bitmapData)
         {
            this._fillMatrix.identity();
            this.updateRenderMode();
            switch(this._renderMode)
            {
               case RENDER_MODE_SCALE9:
                  this.drawScale9();
                  break;
               case RENDER_MODE_CROP:
                  this.drawCrop();
                  break;
               case RENDER_MODE_FIT:
                  this.drawFit();
                  break;
               case RENDER_MODE_DYNAMIC:
                  this.drawDynamic();
                  break;
               case RENDER_MODE_TILE:
                  this.drawTile();
            }
         }
         super.finalize();
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      override public function remove() : void
      {
         super.remove();
         this.destroyLoader();
         graphics.clear();
         this._bitmapData = null;
         _uri = null;
      }
      
      override public function loadBitmapData(bmpdt:BitmapData) : void
      {
         this._bitmapData = bmpdt;
         this.finalize();
      }
      
      private function drawDynamic() : void
      {
         var p:Point = localToGlobal(new Point(x,y));
         var m:Matrix = new Matrix();
         m.translate(-p.x,-p.y);
         if(_autoCenterBitmap)
         {
            m.translate(-width / 2,-height / 2);
         }
         graphics.clear();
         graphics.beginBitmapFill(this._bitmapData,m,true,_smooth);
         if(_autoCenterBitmap)
         {
            graphics.drawRect(-width / 2,-height / 2,width,height);
         }
         else
         {
            graphics.drawRect(0,0,width,height);
         }
         graphics.endFill();
      }
      
      private function drawTile() : void
      {
         graphics.clear();
         graphics.beginBitmapFill(this._bitmapData,null,true,_smooth);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
      }
      
      private function drawScale9() : void
      {
         var x:int = 0;
         var y:int = 0;
         var oy:Number = NaN;
         var dy:Number = NaN;
         var wid:Number = NaN;
         var hei:Number = NaN;
         var dwid:Number = NaN;
         var dhei:Number = NaN;
         if(this.width < this._bitmapData.width)
         {
            this.drawFit();
            return;
         }
         var usedWidth:uint = Math.abs(!!this.width ? Number(this.width) : Number(this._bitmapData.width));
         var usedHeight:uint = Math.abs(!!this.height ? Number(this.height) : Number(this._bitmapData.height));
         var ox:Number = 0;
         var dx:Number = 0;
         var sw:int = this._bitmapData.width;
         var sh:int = this._bitmapData.height;
         var inner:Rectangle = this.scale9Grid && !this.scale9Grid.isEmpty() ? this.scale9Grid : new Rectangle(Math.floor(this._bitmapData.width / 3 - 1),Math.floor(this._bitmapData.height / 3 - 1),3,3);
         var widths:Array = [inner.left + 1,inner.width - 2,sw - inner.right + 1];
         var heights:Array = [inner.top + 1,inner.height - 2,sh - inner.bottom + 1];
         var rx:Number = usedWidth - widths[0] - widths[2] - this._margin.right - this._margin.left;
         var ry:Number = usedHeight - heights[0] - heights[2] - this._margin.bottom - this._margin.top;
         var ol:Number = this._margin.left;
         var ot:Number = this._margin.top;
         for(x = 0; x < 3; x++)
         {
            wid = widths[x];
            dwid = x == 1 ? Number(rx) : Number(wid);
            dy = oy = 0;
            this._fillMatrix.a = dwid / wid;
            for(y = 0; y < 3; y++)
            {
               hei = heights[y];
               dhei = y == 1 ? Number(ry) : Number(hei);
               if(dwid > 0 && dhei > 0)
               {
                  this._fillMatrix.d = dhei / hei;
                  this._fillMatrix.tx = -ox * this._fillMatrix.a + dx;
                  this._fillMatrix.ty = -oy * this._fillMatrix.d + dy;
                  this._fillMatrix.translate(ol,ot);
                  graphics.beginBitmapFill(this._bitmapData,this._fillMatrix,false,_smooth);
                  graphics.drawRect(dx + ol,dy + ot,dwid,dhei);
               }
               oy += hei;
               dy += dhei;
            }
            ox += wid;
            dx += dwid;
         }
         graphics.endFill();
      }
      
      private function drawCrop() : void
      {
         var usedWidth:uint = !!this.width ? uint(this.width) : uint(this._bitmapData.width);
         var usedHeight:uint = !!this.height ? uint(this.height) : uint(this._bitmapData.height);
         switch(GraphicLocation.convertPointStringToInt(this._align.toUpperCase()))
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               this._fillMatrix.translate((usedWidth - this._bitmapData.width) / 2,0);
               break;
            case LocationEnum.POINT_TOPRIGHT:
               this._fillMatrix.translate(usedWidth - this._bitmapData.width,0);
               break;
            case LocationEnum.POINT_LEFT:
               this._fillMatrix.translate(0,(usedHeight - this._bitmapData.height) / 2);
               break;
            case LocationEnum.POINT_CENTER:
               this._fillMatrix.translate((usedWidth - this._bitmapData.width) / 2,(usedHeight - this._bitmapData.height) / 2);
               break;
            case LocationEnum.POINT_RIGHT:
               this._fillMatrix.translate(usedWidth - this._bitmapData.width,(usedHeight - this._bitmapData.height) / 2);
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               this._fillMatrix.translate(0,usedHeight - this._bitmapData.height);
               break;
            case LocationEnum.POINT_BOTTOM:
               this._fillMatrix.translate((usedWidth - this._bitmapData.width) / 2,usedHeight - this._bitmapData.height);
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               this._fillMatrix.translate(usedWidth - this._bitmapData.width,usedHeight - this._bitmapData.height);
         }
         this._fillMatrix.translate(this._margin.left,this._margin.top);
         graphics.beginBitmapFill(this._bitmapData,this._fillMatrix,false,_smooth);
         graphics.drawRect(this._margin.left,this._margin.top,usedWidth - this._margin.left - this._margin.right,usedHeight - this._margin.top - this._margin.bottom);
         graphics.endFill();
      }
      
      private function drawFit() : void
      {
         var usedWidth:int = !!this.width ? int(this.width) : int(this._bitmapData.width);
         var usedHeight:int = !!this.height ? int(this.height) : int(this._bitmapData.height);
         var usedWidthAbs:int = Math.abs(usedWidth);
         var usedHeightAbs:int = Math.abs(usedHeight);
         var sX:Number = usedWidthAbs / (this._bitmapData.width - this._margin.left - this._margin.right);
         var sY:Number = usedHeightAbs / (this._bitmapData.height - this._margin.top - this._margin.bottom);
         this._fillMatrix.scale(sX,sY);
         var xOffset:Number = 0;
         var yOffset:Number = 0;
         if(usedWidth < 0)
         {
            xOffset = usedWidth;
         }
         if(usedHeight < 0)
         {
            yOffset = usedHeight;
         }
         this._fillMatrix.translate(-this._margin.left * sX + xOffset,-this.margin.top * sY + yOffset);
         if(_autoCenterBitmap)
         {
            this._fillMatrix.translate(-usedWidthAbs / 2,-usedHeightAbs / 2);
         }
         graphics.beginBitmapFill(this._bitmapData,this._fillMatrix,false,_smooth);
         if(_autoCenterBitmap)
         {
            graphics.drawRect(xOffset - usedWidthAbs / 2,yOffset - usedHeightAbs / 2,usedWidthAbs,usedHeightAbs);
         }
         else
         {
            graphics.drawRect(xOffset,yOffset,usedWidthAbs,usedHeightAbs);
         }
         graphics.endFill();
      }
      
      private function destroyLoader() : void
      {
         if(!this._loader)
         {
            return;
         }
         this._loader.cancel();
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onFailed);
         this._loader = null;
      }
      
      private function updateRenderMode() : void
      {
         this._renderMode = RENDER_MODE_FIT;
         if(this._scale9Grid)
         {
            this._renderMode = RENDER_MODE_SCALE9;
         }
         if(this._align)
         {
            this._renderMode = RENDER_MODE_CROP;
         }
         if(this._dynamicRender)
         {
            this._renderMode = RENDER_MODE_DYNAMIC;
         }
         if(this._tileRender)
         {
            this._renderMode = RENDER_MODE_TILE;
         }
      }
      
      function drawErrorTexture() : void
      {
         graphics.beginFill(16711935);
         graphics.drawRect(0,0,width != 0 ? Number(width) : Number(10),height != 0 ? Number(height) : Number(10));
         graphics.endFill();
      }
      
      override protected function onLoaded(event:ResourceLoadedEvent) : void
      {
         super.onLoaded(event);
         if(event.resource is BitmapData)
         {
            this._bitmapData = event.resource;
         }
         else
         {
            _log.error("Failed to load " + event.uri + ", resource type not supported! (component name : " + name + ")");
         }
         this.destroyLoader();
         if(this._nextUri)
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed);
            this._loader.load(this._nextUri);
            this._nextUri = null;
         }
         else
         {
            this.finalize();
         }
      }
      
      override protected function onFailed(event:ResourceErrorEvent) : void
      {
         this.destroyLoader();
         if(this._nextUri)
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed);
            this._loader.load(this._nextUri);
            this._nextUri = null;
         }
         else
         {
            this.finalize();
         }
         if(_showLoadingError)
         {
            this.drawErrorTexture();
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
            _log.error("UI " + (!!getUi() ? getUi().name : "unknow") + "/" + name + ", TextureBitmap resource not found: " + (!!event ? event.errorMsg : "No ressource specified.") + ", requested uri : " + event.uri);
         }
         this.drawErrorTexture();
         dispatchEvent(new TextureLoadFailedEvent(this,behavior));
         Berilia.getInstance().handler.process(new TextureLoadFailMessage(this));
      }
   }
}
