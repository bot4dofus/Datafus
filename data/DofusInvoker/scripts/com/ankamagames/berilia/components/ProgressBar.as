package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.Shape;
   import flash.events.Event;
   
   public class ProgressBar extends GraphicContainer implements UIComponent
   {
       
      
      private var _barColor:int;
      
      private var _barAlpha:Number;
      
      private var _innerBarColor:int;
      
      private var _innerBarAlpha:Number;
      
      private var _separatorColor:int;
      
      private var _bar:Shape;
      
      private var _innerBar:Shape;
      
      private var _barPadding:int = 1;
      
      private var _barForeground:TextureBitmap;
      
      private var _barBackground:TextureBitmap;
      
      private var _numberOfSeparators:uint;
      
      private var _separators:Shape;
      
      private var _value:Number = 0;
      
      private var _innerValue:Number = 0;
      
      private var _clickable:Boolean;
      
      public var snapToSeparators:Boolean = false;
      
      public function ProgressBar()
      {
         super();
         _bgColor = XmlConfig.getInstance().getEntry("colors.progressbar.background");
         _bgAlpha = 1;
         this._barColor = 16711935;
         this._barAlpha = 1;
         this._innerBarColor = 16711935;
         this._innerBarAlpha = 1;
         this._separatorColor = XmlConfig.getInstance().getEntry("colors.progressbar.separator");
         this._innerBar = new Shape();
         this._innerBar.x = this._barPadding;
         this._innerBar.y = this._barPadding;
         addChild(this._innerBar);
         this._bar = new Shape();
         this._bar.x = this._barPadding;
         this._bar.y = this._barPadding;
         addChild(this._bar);
         this._clickable = false;
         mouseEnabled = true;
      }
      
      public function set value(v:Number) : void
      {
         this._value = Math.max(Math.min(v,1),0);
         if(this.snapToSeparators && this._numberOfSeparators)
         {
            this._value = Math.ceil(width * this._value / (width / (this._numberOfSeparators + 1))) * (width / (this._numberOfSeparators + 1)) / width;
            this._value = Math.round(this._value * 100) / 100;
         }
         this.draw();
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set innerValue(v:Number) : void
      {
         this._innerValue = Math.max(Math.min(v,1),0);
         this.draw();
      }
      
      public function get innerValue() : Number
      {
         return this._innerValue;
      }
      
      public function get barPadding() : int
      {
         return this._barPadding;
      }
      
      public function set barPadding(value:int) : void
      {
         this._barPadding = value;
         this._bar.x = this._barPadding;
         this._bar.y = this._barPadding;
         this._innerBar.x = this._barPadding;
         this._innerBar.y = this._barPadding;
         if(_finalized)
         {
            this.finalize();
         }
      }
      
      override public function set width(v:Number) : void
      {
         super.width = v;
         if(_finalized)
         {
            this.finalize();
         }
      }
      
      override public function set height(v:Number) : void
      {
         super.height = v;
         if(_finalized)
         {
            this.finalize();
         }
      }
      
      override public function set bgColor(v:*) : void
      {
         setColorVar(v);
      }
      
      public function set barColor(v:*) : void
      {
         var newBarColor:int = 0;
         var base:uint = 0;
         var newBarAlpha:Number = this._barAlpha;
         if(v is String)
         {
            base = String(v).substr(0,2) == "0x" ? uint(16) : uint(10);
            v = parseInt(v,base);
         }
         if(v is int || v is uint)
         {
            newBarColor = v;
            newBarColor = newBarColor < 0 ? int(newBarColor) : newBarColor & 16777215;
            if(v & 4278190080 && newBarColor != -1)
            {
               newBarAlpha = ((v & 4278190080) >> 24) / 255;
            }
         }
         else
         {
            newBarColor = -1;
         }
         if(newBarColor != this._barColor || newBarAlpha != this._barAlpha)
         {
            this._barColor = newBarColor;
            this._barAlpha = newBarAlpha;
            if(finalized)
            {
               this.finalize();
            }
         }
      }
      
      public function set innerBarColor(v:*) : void
      {
         var newBarColor:int = 0;
         var base:uint = 0;
         var newBarAlpha:Number = this._innerBarAlpha;
         if(v is String)
         {
            base = String(v).substr(0,2) == "0x" ? uint(16) : uint(10);
            v = parseInt(v,base);
         }
         if(v is int || v is uint)
         {
            newBarColor = v;
            newBarColor = newBarColor < 0 ? int(newBarColor) : newBarColor & 16777215;
            if(v & 4278190080 && newBarColor != -1)
            {
               newBarAlpha = ((v & 4278190080) >> 24) / 255;
            }
         }
         else
         {
            newBarColor = -1;
         }
         if(newBarColor != this._innerBarColor || newBarAlpha != this._innerBarAlpha)
         {
            this._innerBarColor = newBarColor;
            this._innerBarAlpha = newBarAlpha;
            if(finalized)
            {
               this.finalize();
            }
         }
      }
      
      public function set innerBarAlpha(v:Number) : void
      {
         this._innerBarAlpha = v;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function set separators(numberOfSeparator:uint) : void
      {
         this._numberOfSeparators = numberOfSeparator;
         if(this._numberOfSeparators && !this._separators)
         {
            this._separators = new Shape();
            addChild(this._separators);
         }
         else if(!this._numberOfSeparators && this._separators)
         {
            removeChild(this._separators);
            this._separators = null;
         }
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function set clickable(v:Boolean) : void
      {
         this._clickable = v;
         buttonMode = this._clickable;
      }
      
      public function set barForegroundThemeData(themeDataId:String) : void
      {
         if(!this._barForeground)
         {
            this._barForeground = new TextureBitmap();
            addChildAt(this._barForeground,2);
         }
         this._barForeground.addEventListener(Event.COMPLETE,this.onForegroundCompleted);
         this._barForeground.themeDataId = themeDataId;
      }
      
      public function set barBackgroundThemeData(themeDataId:String) : void
      {
         if(!this._barBackground)
         {
            this._barBackground = new TextureBitmap();
            addChildAt(this._barBackground,0);
            _bgColor = -1;
         }
         this._barBackground.themeDataId = themeDataId;
      }
      
      public function set barBgAlpha(v:Number) : void
      {
         _bgAlpha = v;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      private function onForegroundCompleted(e:Event) : void
      {
         this._barForeground.removeEventListener(Event.COMPLETE,this.onForegroundCompleted);
         this.finalize();
      }
      
      override public function finalize() : void
      {
         var totalBlocks:uint = 0;
         var widthBetweenSeparators:Number = NaN;
         var i:int = 0;
         var x:Number = NaN;
         if(this._barForeground && !this._barForeground.finalized)
         {
            return;
         }
         graphics.clear();
         if(_bgColor > -1)
         {
            graphics.beginFill(_bgColor,_bgAlpha);
            graphics.drawRect(0,0,width,height);
            graphics.endFill();
         }
         if(this._barBackground)
         {
            this._barBackground.width = width;
            this._barBackground.height = height;
         }
         if(this._barForeground)
         {
            this._barForeground.finalized = false;
            this._barForeground.height = height;
         }
         this.draw();
         if(this._barForeground)
         {
            this._barForeground.finalize();
         }
         if(this._numberOfSeparators)
         {
            totalBlocks = this._numberOfSeparators + 1;
            this._separators.graphics.clear();
            widthBetweenSeparators = width / totalBlocks;
            for(i = 1; i < totalBlocks; i++)
            {
               x = i * widthBetweenSeparators;
               with(this._separators.graphics)
               {
                  
                  beginFill(_separatorColor,0.95);
                  drawRect(x,1,1,height - 2);
                  endFill();
                  beginFill(_separatorColor,0.51);
                  drawRect(x - 1,1,1,height - 2);
                  endFill();
                  beginFill(_separatorColor,0.24);
                  drawRect(x + 1,1,1,height - 2);
                  endFill();
               }
            }
            this._separators.graphics.endFill();
         }
         super.finalize();
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      protected function draw() : void
      {
         var actualWidth:Number = width * this._value;
         actualWidth = actualWidth < 1 && this._value != 0 ? Number(1) : Number(actualWidth);
         var actualInnerWidth:Number = width * this._innerValue;
         actualInnerWidth = actualInnerWidth < 1 && this._innerValue != 0 ? Number(1) : Number(actualInnerWidth);
         this._innerBar.graphics.clear();
         if(actualInnerWidth)
         {
            this._innerBar.graphics.beginFill(this._innerBarColor,this._innerBarAlpha);
            this._innerBar.graphics.drawRect(0,0,actualInnerWidth - this._barPadding * 2,height - this._barPadding * 2);
            this._innerBar.graphics.endFill();
         }
         this._bar.graphics.clear();
         if(actualWidth)
         {
            this._bar.graphics.beginFill(this._barColor,this._barAlpha);
            this._bar.graphics.drawRect(0,0,actualWidth - this._barPadding * 2,height - this._barPadding * 2);
            this._bar.graphics.endFill();
         }
         if(this._barForeground)
         {
            if(actualWidth)
            {
               this._barForeground.width = actualWidth;
               this._barForeground.visible = true;
            }
            else
            {
               this._barForeground.visible = false;
            }
         }
      }
      
      override public function process(msg:Message) : Boolean
      {
         super.process(msg);
         var mouseClickMsg:MouseClickMessage = msg as MouseClickMessage;
         if(this._clickable && mouseClickMsg && !isNaN(mouseClickMsg.mouseEvent.localX))
         {
            this.value = mouseClickMsg.mouseEvent.localX / width;
         }
         return false;
      }
      
      override public function remove() : void
      {
         if(this._barForeground)
         {
            this._barForeground.removeEventListener(Event.COMPLETE,this.onForegroundCompleted);
         }
         super.remove();
         this._bar = null;
         this._innerBar = null;
         this._barForeground = null;
         this._separators = null;
      }
   }
}
