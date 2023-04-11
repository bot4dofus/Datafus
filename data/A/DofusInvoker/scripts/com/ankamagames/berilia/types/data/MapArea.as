package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.PixelSnapping;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   
   public class MapArea extends Rectangle
   {
      
      private static var _freeBitmap:Array = [];
       
      
      public var parent:Map;
      
      private var _bitmap:Bitmap;
      
      private var _active:Boolean;
      
      private var _freeTimer:BenchmarkTimer;
      
      private var _isLoaded:Boolean;
      
      private var _srcPath:String;
      
      private var _src:Uri;
      
      public function MapArea(path:String, x:Number, y:Number, width:Number, height:Number, parent:Map)
      {
         this.parent = parent;
         this._srcPath = path;
         this._isLoaded = false;
         super(x,y,width,height);
      }
      
      public function get src() : Uri
      {
         if(!this._src)
         {
            this._src = new Uri(this._srcPath);
            this._srcPath = null;
         }
         return this._src;
      }
      
      public function get isUsed() : Boolean
      {
         return this._active;
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function getBitmap() : DisplayObject
      {
         this._active = true;
         if(this._freeTimer)
         {
            this._freeTimer.removeEventListener(TimerEvent.TIMER,this.onDeathCountDown);
            this._freeTimer.stop();
            this._freeTimer = null;
         }
         if(!this._bitmap || !this._bitmap.bitmapData)
         {
            if(_freeBitmap.length)
            {
               this._bitmap = _freeBitmap.pop();
            }
            else
            {
               this._bitmap = new Bitmap(null,PixelSnapping.AUTO,true);
            }
            this._bitmap.x = x;
            this._bitmap.y = y;
         }
         return this._bitmap;
      }
      
      public function setBitmap(pResource:*) : void
      {
         var checkScale:* = false;
         var currentScale:Number = NaN;
         if(this._active)
         {
            this._isLoaded = true;
            this._bitmap.bitmapData = pResource;
            this._bitmap.smoothing = true;
            checkScale = this._bitmap.width != this._bitmap.height;
            this._bitmap.width = width + 1;
            this._bitmap.height = height + 1;
            if(!checkScale)
            {
               return;
            }
            currentScale = this.parent.currentScale;
            if(isNaN(currentScale))
            {
               if(this._bitmap.scaleX == this._bitmap.scaleY)
               {
                  currentScale = this._bitmap.scaleX;
               }
               else if(x + width > this.parent.initialWidth)
               {
                  currentScale = this._bitmap.scaleY;
               }
               else if(y + height > this.parent.initialHeight)
               {
                  currentScale = this._bitmap.scaleX;
               }
            }
            if(this._bitmap.scaleX != this._bitmap.scaleY && currentScale)
            {
               this._bitmap.scaleX = this._bitmap.scaleY = currentScale;
            }
         }
      }
      
      public function free(force:Boolean = false) : void
      {
         this._active = false;
         if(force)
         {
            this.onDeathCountDown(null);
            return;
         }
         if(!this._freeTimer)
         {
            this._freeTimer = new BenchmarkTimer(3000,0,"MapArea._freeTimer");
            this._freeTimer.addEventListener(TimerEvent.TIMER,this.onDeathCountDown,false,0,true);
         }
         this._freeTimer.start();
      }
      
      private function onDeathCountDown(e:Event) : void
      {
         if(this._freeTimer)
         {
            this._freeTimer.removeEventListener(TimerEvent.TIMER,this.onDeathCountDown);
            this._freeTimer.stop();
            this._freeTimer = null;
         }
         if(this._active)
         {
            return;
         }
         if(this._bitmap)
         {
            if(this._bitmap.parent)
            {
               this._bitmap.parent.removeChild(this._bitmap);
            }
            this._bitmap.bitmapData = null;
            _freeBitmap.push(this._bitmap);
            this._bitmap = null;
            this._isLoaded = false;
         }
      }
   }
}
