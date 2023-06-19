package com.ankamagames.tiphon.display
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class RasterizedAnimation extends TiphonAnimation
   {
      
      public static var FRAMES:Dictionary = new Dictionary(false);
       
      
      protected var _target:MovieClip;
      
      private var _targetName:String;
      
      private var _bitmap:Bitmap;
      
      private var _smoothing:Boolean;
      
      protected var _totalFrames:uint;
      
      private var _currentIndex:int = -1;
      
      public function RasterizedAnimation(target:MovieClip, lookCode:String)
      {
         super();
         this._target = target;
         this._targetName = "[" + this._target.scaleX + "," + this._target.scaleY + "]" + target.toString() + " [" + lookCode + "]";
         this._totalFrames = this._target.totalFrames;
         var rfl:RasterizedFrameList = FRAMES[this._targetName];
         if(rfl)
         {
            rfl.death = 0;
            rfl.life += 2;
            if(rfl.life > rfl.maxLife)
            {
               rfl.life = rfl.maxLife;
            }
         }
         else
         {
            FRAMES[this._targetName] = new RasterizedFrameList(this._targetName,5);
         }
      }
      
      public static function countFrames() : Object
      {
         var rfl:RasterizedFrameList = null;
         var num:int = 0;
         var i:int = 0;
         var animations:int = 0;
         var frames:int = 0;
         for each(rfl in FRAMES)
         {
            animations++;
            num = rfl.frameList.length;
            for(i = 0; i < num; i++)
            {
               if(rfl.frameList[i])
               {
                  frames++;
               }
            }
         }
         return {
            "animations":animations,
            "frames":frames
         };
      }
      
      public static function optimize(val:int = 1) : void
      {
         var rfl:RasterizedFrameList = null;
         for each(rfl in FRAMES)
         {
            rfl.death += val;
            rfl.life -= rfl.death;
            if(rfl.life < 1)
            {
               delete FRAMES[rfl.key];
            }
         }
      }
      
      override public function get totalFrames() : int
      {
         return this._totalFrames;
      }
      
      override public function get currentFrame() : int
      {
         return this._currentIndex + 1;
      }
      
      public function get smoothing() : Boolean
      {
         return this._smoothing;
      }
      
      public function set smoothing(value:Boolean) : void
      {
         this._smoothing = value;
         if(this._bitmap)
         {
            this._bitmap.smoothing = value;
         }
      }
      
      override public function gotoAndStop(frame:Object, scene:String = null) : void
      {
         var targetFrame:uint = frame as uint;
         if(targetFrame > 0)
         {
            targetFrame--;
         }
         this.displayFrame(targetFrame % this._totalFrames);
      }
      
      override public function gotoAndPlay(frame:Object, scene:String = null) : void
      {
         this.gotoAndStop(frame,scene);
         this.play();
      }
      
      override public function play() : void
      {
      }
      
      override public function stop() : void
      {
      }
      
      override public function nextFrame() : void
      {
         this.displayFrame((this._currentIndex + 1) % this._totalFrames);
      }
      
      override public function prevFrame() : void
      {
         this.displayFrame(this._currentIndex > 0 ? uint(this._currentIndex - 1) : uint(this._totalFrames - 1));
      }
      
      protected function displayFrame(frameIndex:uint) : Boolean
      {
         if(frameIndex == this._currentIndex)
         {
            return false;
         }
         var frameList:Array = FRAMES[this._targetName].frameList;
         var rf:RasterizedFrame = frameList[frameIndex] as RasterizedFrame;
         if(!rf)
         {
            rf = new RasterizedFrame(this._target,frameIndex);
            frameList[frameIndex] = rf;
         }
         if(!this._bitmap)
         {
            this._bitmap = new Bitmap(rf.bitmapData);
            this._bitmap.smoothing = this._smoothing;
            addChild(this._bitmap);
         }
         else
         {
            this._bitmap.bitmapData = rf.bitmapData;
         }
         this._bitmap.x = rf.x;
         this._bitmap.y = rf.y;
         this._currentIndex = frameIndex;
         return true;
      }
   }
}
