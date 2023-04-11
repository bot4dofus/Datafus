package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public final class TextFieldOldScrollBarH extends Sprite
   {
      
      public static const HEIGHT:int = 10;
       
      
      private var _textField:TextField;
      
      private var _power:int = 4;
      
      private var _backgroundColor:uint;
      
      private var _color:uint;
      
      private var _background:Shape;
      
      private var _scrollBar:Sprite;
      
      private var offsetX:int;
      
      public function TextFieldOldScrollBarH(textField:TextField, power:int, backgroundColor:uint, color:uint)
      {
         super();
         this._textField = textField;
         this._power = power;
         this._backgroundColor = backgroundColor;
         this._color = color;
         this._textField.mouseEnabled = true;
         this.createUI();
      }
      
      public function resize() : void
      {
         this._background.graphics.clear();
         this._background.graphics.beginFill(this._backgroundColor);
         this._background.graphics.drawRoundRect(0,0,this._textField.width,HEIGHT,5);
         this._background.graphics.endFill();
         x = this._textField.x;
         y = this._textField.y + this._textField.height;
         this.drawScrollBar();
      }
      
      private function updateTextPosition() : void
      {
         var p:Number = this._scrollBar.x / (this._textField.width - this._scrollBar.width);
         this._textField.scrollH = this._textField.maxScrollH * p;
      }
      
      private function drawScrollBar() : void
      {
         if(this._textField.maxScrollH <= 1)
         {
            visible = false;
            return;
         }
         visible = true;
         var pWidth:Number = this._textField.width / this._textField.textWidth;
         var vWidth:int = int(this._textField.width * pWidth);
         if(vWidth < 40)
         {
            vWidth = 40;
         }
         this._scrollBar.graphics.clear();
         this._scrollBar.graphics.beginFill(this._color);
         this._scrollBar.graphics.drawRoundRect(0,0,vWidth,HEIGHT,5);
         this._scrollBar.graphics.endFill();
         this._scrollBar.x = this._textField.scrollH * (this._textField.width - this._scrollBar.width) / this._textField.maxScrollH;
      }
      
      private function createUI() : void
      {
         if(this._background)
         {
            throw new Error();
         }
         this._background = new Shape();
         this._scrollBar = new Sprite();
         this._scrollBar.mouseChildren = false;
         LogInFile.getInstance().logLine("TextFieldOldScrollbarH _scrollBar.addEventListener onScrollBarMouseDown",FileLoggerEnum.EVENTLISTENERS);
         this._scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollBarMouseDown,false,0,true);
         addChild(this._background);
         addChild(this._scrollBar);
         this.resize();
      }
      
      private function onScrollBarMouseDown(mouseEvent:MouseEvent) : void
      {
         LogInFile.getInstance().logLine("TextFieldOldScrollbarH onScrollBarMouseDown",FileLoggerEnum.EVENTLISTENERS);
         this.offsetX = this._scrollBar.mouseX;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
      }
      
      private function onMouseUp(mouseEvent:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseMove(mouseEvent:MouseEvent) : void
      {
         var value:int = stage.mouseX - this.offsetX;
         var maxValue:int = this._textField.width - this._scrollBar.width;
         if(value < 0)
         {
            value = 0;
         }
         else if(value > maxValue)
         {
            value = maxValue;
         }
         this._scrollBar.x = value;
         this.updateTextPosition();
         mouseEvent.updateAfterEvent();
      }
   }
}
