package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class MapAreaShape extends MapDisplayableElement
   {
      
      private static const DEFAULT_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,0);
       
      
      private var _lineColor:uint;
      
      private var _fillColor:uint;
      
      private var _duration:int;
      
      private var _t0:int;
      
      private var _redMultiplier:Number = 1;
      
      private var _greenMultiplier:Number = 1;
      
      private var _blueMultiplier:Number = 1;
      
      private var _alphaMultiplier:Number = 0;
      
      private var _redOffset:Number = 0;
      
      private var _greenOffset:Number = 0;
      
      private var _blueOffset:Number = 0;
      
      private var _alphaOffset:Number = 0;
      
      private var _lastRedMultiplier:Number;
      
      private var _lastGreenMultiplier:Number;
      
      private var _lastBlueMultiplier:Number;
      
      private var _lastAlphaMultiplier:Number;
      
      private var _lastRedOffset:Number;
      
      private var _lastGreenOffset:Number;
      
      private var _lastBlueOffset:Number;
      
      private var _lastAlphaOffset:Number;
      
      public function MapAreaShape(id:String, layer:String, texture:Texture, x:int, y:int, lineColor:uint, fillColor:uint, owner:*)
      {
         this._lineColor = lineColor;
         this._fillColor = fillColor;
         super(id,x,y,layer,owner,texture);
         _texture.transform.colorTransform = DEFAULT_COLOR_TRANSFORM;
      }
      
      public function get lineColor() : uint
      {
         return this._lineColor;
      }
      
      public function get fillColor() : uint
      {
         return this._fillColor;
      }
      
      override public function get classType() : String
      {
         return "MapAreaShape";
      }
      
      public function colorTransform(duration:int, rM:Number = 1, gM:Number = 1, bM:Number = 1, aM:Number = 1, rO:Number = 0, gO:Number = 0, bO:Number = 0, aO:Number = 0) : void
      {
         this._lastAlphaMultiplier = this._alphaMultiplier;
         this._lastAlphaOffset = this._alphaOffset;
         this._lastBlueMultiplier = this._blueMultiplier;
         this._lastBlueOffset = this._blueOffset;
         this._lastGreenMultiplier = this._greenMultiplier;
         this._lastGreenOffset = this._greenOffset;
         this._lastRedMultiplier = this._redMultiplier;
         this._lastRedOffset = this._redOffset;
         this._redMultiplier = rM;
         this._blueMultiplier = bM;
         this._greenMultiplier = gM;
         this._alphaMultiplier = aM;
         this._redOffset = rO;
         this._greenOffset = gO;
         this._blueOffset = bO;
         this._alphaOffset = aO;
         this._duration = duration;
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         if(this._alphaMultiplier != 0)
         {
            if(this._duration == 0)
            {
               _texture.transform.colorTransform = new ColorTransform(rM,gM,bM,aM,rO,gO,bO,aO);
               _texture.visible = true;
            }
            else
            {
               this._t0 = getTimer();
               EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.AREA_SHAPE_COLOR_TRANSFORM,20);
            }
         }
         else
         {
            _texture.visible = false;
         }
      }
      
      override public function remove() : void
      {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         super.remove();
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var percent:Number = (getTimer() - this._t0) / this._duration;
         if(_texture)
         {
            if(percent >= 1)
            {
               EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
               _texture.visible = this._alphaMultiplier != 0;
               _texture.transform.colorTransform = new ColorTransform(this._redMultiplier,this._greenMultiplier,this._blueMultiplier,this._alphaMultiplier,this._redOffset,this._greenOffset,this._blueOffset,this._alphaOffset);
            }
            else
            {
               _texture.transform.colorTransform = new ColorTransform(this._lastRedMultiplier + (this._redMultiplier - this._lastRedMultiplier) * percent,this._lastGreenMultiplier + (this._greenMultiplier - this._lastGreenMultiplier) * percent,this._lastBlueMultiplier + (this._blueMultiplier - this._lastBlueMultiplier) * percent,this._lastAlphaMultiplier + (this._alphaMultiplier - this._lastAlphaMultiplier) * percent,this._lastRedOffset + (this._redOffset - this._lastRedOffset) * percent,this._lastGreenOffset + (this._greenOffset - this._lastGreenOffset) * percent,this._lastBlueOffset + (this._blueOffset - this._lastBlueOffset) * percent,this._lastAlphaOffset + (this._alphaOffset - this._lastAlphaOffset) * percent);
               if(this._alphaMultiplier != 0 && !_texture.visible)
               {
                  _texture.visible = true;
               }
            }
         }
      }
   }
}
