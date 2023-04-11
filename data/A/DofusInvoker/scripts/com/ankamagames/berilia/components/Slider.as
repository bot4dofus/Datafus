package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class Slider extends GraphicContainer implements FinalizableUIComponent
   {
       
      
      protected var _cursor:Sprite;
      
      protected var _cursorTexture:Texture;
      
      protected var _cursorDragRegion:Rectangle;
      
      protected var _cursorUri:Uri;
      
      protected var _backgroundUri:Uri;
      
      protected var _value:Number = 5;
      
      protected var _minValue:Number = 0;
      
      protected var _maxValue:Number = 10;
      
      protected var _step:Number;
      
      public var background:Texture;
      
      public var backgroundPosition:Rectangle;
      
      public function Slider()
      {
         this._cursor = new Sprite();
         this._cursorTexture = new Texture();
         this._cursorDragRegion = new Rectangle();
         this._backgroundUri = new Uri();
         this.background = new Texture();
         super();
         this.background.autoGrid = true;
         addChild(this.background);
         addChild(this._cursor);
         this._cursor.addChild(this._cursorTexture);
         this.background.dispatchMessages = true;
         this._cursorTexture.dispatchMessages = true;
         this._cursor.visible = false;
      }
      
      public function get step() : Number
      {
         return !!isNaN(this._step) ? Number(this.computeStep()) : Number(this._step);
      }
      
      public function set step(value:Number) : void
      {
         this._step = value;
      }
      
      override public function set name(n:String) : void
      {
         super.name = n;
         this._cursor.name = "__" + n + "_cursor";
         this.background.name = "__" + n + "_background";
      }
      
      override public function set width(w:Number) : void
      {
         super.width = w;
         this.background.width = width;
         this.updatePositionFromValue();
      }
      
      override public function set height(h:Number) : void
      {
         super.height = h;
         this.background.height = height;
         this.updatePositionFromValue();
      }
      
      public function get maxValue() : Number
      {
         return this._maxValue;
      }
      
      public function set maxValue(max:Number) : void
      {
         this._maxValue = max;
         this.normalizeValue();
         if(_finalized)
         {
            this.updatePositionFromValue();
         }
      }
      
      public function get minValue() : Number
      {
         return this._minValue;
      }
      
      public function set minValue(min:Number) : void
      {
         this._minValue = min;
         this.normalizeValue();
         if(_finalized)
         {
            this.updatePositionFromValue();
         }
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(v:Number) : void
      {
         this.normalizeValue(v);
      }
      
      public function get cursorUri() : Uri
      {
         return this._cursorUri;
      }
      
      public function set cursorUri(value:Uri) : void
      {
         this._cursorUri = value;
         this._cursorTexture.uri = value;
      }
      
      public function get backgroundUri() : Uri
      {
         return this._backgroundUri;
      }
      
      public function set backgroundUri(uri:Uri) : void
      {
         this._backgroundUri = uri;
         this.background.uri = uri;
         this.background.width = width;
         this.background.height = height;
      }
      
      override public function finalize() : void
      {
         this.updatePositionFromValue();
         this._cursor.mouseEnabled = true;
         this._cursor.useHandCursor = true;
         this._cursorTexture.finalize();
         this.background.mouseEnabled = true;
         this.background.finalize();
         super.finalize();
         _finalized = true;
      }
      
      override public function process(msg:Message) : Boolean
      {
         var bounds:Rectangle = null;
         switch(true)
         {
            case msg is MouseDownMessage:
               EnterFrameDispatcher.addEventListener(this.updateFromDrag,EnterFrameConst.SLIDER_DRAG_UPDATER);
               break;
            case msg is MouseReleaseOutsideMessage:
            case msg is MouseClickMessage:
               this._cursor.stopDrag();
               EnterFrameDispatcher.removeEventListener(this.updateFromDrag);
               this.updateValueFromPosition();
               break;
            case msg is TextureReadyMessage:
               if(TextureReadyMessage(msg).target == this._cursorTexture)
               {
                  this._cursorTexture.x = 0;
                  this._cursorTexture.y = 0;
                  bounds = this._cursorTexture.getBounds(this._cursor);
                  this._cursorTexture.x = -bounds.left - this._cursorTexture.width / 2;
                  this._cursorTexture.y = -bounds.top - this._cursorTexture.height / 2;
                  this.background.width = width;
                  this.background.height = height;
                  this.updatePositionFromValue();
                  this.normalizeValue();
                  this._cursor.visible = true;
               }
         }
         return super.process(msg);
      }
      
      override public function remove() : void
      {
         EnterFrameDispatcher.removeEventListener(this.updateFromDrag);
         super.remove();
      }
      
      private function computeStep() : Number
      {
         return (this.maxValue - this.minValue) / (width > height ? width - this._cursor.width / 2 : height - this._cursor.height / 2);
      }
      
      private function normalizeValue(forceValue:Number = NaN) : void
      {
         var v:Number = !!isNaN(forceValue) ? Number(this._value) : Number(forceValue);
         var s:Number = this._step;
         if(isNaN(this._step))
         {
            s = this.computeStep();
         }
         v = Math.round(v / s) * s;
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
         if(v != this._value)
         {
            this._value = v;
            Berilia.getInstance().handler.process(new ChangeMessage(this));
         }
         this.updatePositionFromValue();
      }
      
      private function updateValueFromPosition() : void
      {
         var v:Number = NaN;
         if(width > height)
         {
            v = (this._cursor.x - this._cursor.width / 2) / ((width - this._cursor.width) / (this.maxValue - this.minValue)) + this.minValue;
         }
         else
         {
            v = (this._cursor.y - this._cursor.height / 2) / ((height - this._cursor.height) / (this.maxValue - this.minValue)) + this.minValue;
         }
         this.value = v;
      }
      
      private function updatePositionFromValue() : void
      {
         if(width > height)
         {
            this._cursor.x = (width - this._cursor.width) / (this.maxValue - this.minValue) * (this.value - this.minValue) + this._cursor.width / 2;
            this._cursor.y = height / 2;
         }
         else
         {
            this._cursor.y = (height - this._cursor.height) / (this.maxValue - this.minValue) * (this.value - this.minValue) + this._cursor.height / 2;
            this._cursor.x = width / 2;
         }
      }
      
      private function updateFromDrag(e:Event) : void
      {
         if(width > height)
         {
            this._cursor.x = mouseX;
         }
         else
         {
            this._cursor.y = mouseY;
         }
         this.updateValueFromPosition();
      }
   }
}
