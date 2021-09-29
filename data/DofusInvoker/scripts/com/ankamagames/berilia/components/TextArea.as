package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowBoundsEvent;
   import flash.utils.getQualifiedClassName;
   
   public class TextArea extends Label implements FinalizableUIComponent
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TextArea));
       
      
      private var _sbScrollBar:ScrollBar;
      
      private var _bFinalized:Boolean;
      
      private var _nScrollPos:int = 5;
      
      private var _bHideScroll:Boolean = false;
      
      private var _scrollTopMargin:int = 0;
      
      private var _scrollBottomMargin:int = 0;
      
      private var _scrollXOffset:int = 10;
      
      private var _skipScrollUpdate:Boolean = false;
      
      private var _bResetScroll:Boolean = false;
      
      private var _dropValidator:Function;
      
      private var _unboxedDropValidator:Function;
      
      private var _processDrop:Function;
      
      private var _unboxedProcessDrop:Function;
      
      protected var ___width:uint;
      
      public function TextArea()
      {
         super();
         this._sbScrollBar = new ScrollBar();
         this._sbScrollBar.min = 1;
         this._sbScrollBar.max = 1;
         this._sbScrollBar.step = 1;
         this._sbScrollBar.scrollSpeed = 1 / 6;
         this._sbScrollBar.addEventListener(Event.CHANGE,this.onScroll);
         _tText.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTextWheel);
         addChild(this._sbScrollBar);
         _tText.wordWrap = true;
         _tText.multiline = true;
         _tText.mouseEnabled = true;
         _tText.mouseWheelEnabled = false;
         StageShareManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onWindowResize);
      }
      
      public function get resetScroll() : Boolean
      {
         return this._bResetScroll;
      }
      
      public function set resetScroll(b:Boolean) : void
      {
         this._bResetScroll = b;
      }
      
      public function get scrollBarValue() : int
      {
         return this._sbScrollBar.value;
      }
      
      public function set scrollBarValue(v:int) : void
      {
         this._sbScrollBar.value = v;
      }
      
      public function get scrollBarY() : int
      {
         return this._sbScrollBar.y;
      }
      
      public function set scrollBarY(pY:int) : void
      {
         this._sbScrollBar.y = pY;
      }
      
      public function get scrollBarX() : int
      {
         return this._sbScrollBar.x;
      }
      
      public function set scrollBarX(pX:int) : void
      {
         this._sbScrollBar.x = pX;
      }
      
      public function get scrollBottomMargin() : int
      {
         return this._scrollBottomMargin;
      }
      
      public function set scrollBottomMargin(value:int) : void
      {
         this._scrollBottomMargin = value;
         this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function get scrollTopMargin() : int
      {
         return this._scrollTopMargin;
      }
      
      public function set scrollTopMargin(value:int) : void
      {
         this._scrollTopMargin = value;
         this._sbScrollBar.y = this._scrollTopMargin;
         this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      [Uri]
      public function set scrollCss(sUrl:Uri) : void
      {
         this._sbScrollBar.css = sUrl;
      }
      
      [Uri]
      public function get scrollCss() : Uri
      {
         return this._sbScrollBar.css;
      }
      
      override public function set width(nW:Number) : void
      {
         if(!nW)
         {
            return;
         }
         var currentScroll:uint = _tText.maxScrollV;
         _nWidth = nW;
         __width = nW;
         this.___width = nW;
         if(this._bFinalized && _autoResize)
         {
            resizeText();
         }
         _tText.textWidth;
         if(this._bFinalized)
         {
            this.updateScrollBarPos();
            _tText.scrollV = currentScroll;
            this._sbScrollBar.value = currentScroll;
         }
      }
      
      override public function get width() : Number
      {
         return this.___width;
      }
      
      override public function set height(nH:Number) : void
      {
         if(!nH)
         {
            return;
         }
         if(nH != super.height || nH != this._sbScrollBar.height - this._scrollTopMargin - this._scrollBottomMargin)
         {
            super.height = nH;
            _tText.textWidth;
            this._sbScrollBar.height = nH - this._scrollTopMargin - this._scrollBottomMargin;
            if(this._bFinalized)
            {
               this.updateScrollBar();
            }
         }
      }
      
      override public function set text(sValue:String) : void
      {
         super.text = sValue;
         if(this._bFinalized)
         {
            this._skipScrollUpdate = true;
            this.updateScrollBar(this._bResetScroll);
         }
      }
      
      public function set scrollPos(nValue:int) : void
      {
         this._nScrollPos = nValue;
      }
      
      [Uri]
      override public function set css(sValue:Uri) : void
      {
         super.css = sValue;
      }
      
      override public function set scrollV(nVal:int) : void
      {
         super.scrollV = nVal;
         if(this._bFinalized)
         {
            this.updateScrollBar();
         }
      }
      
      override public function get scrollV() : int
      {
         return super.scrollV;
      }
      
      override public function get finalized() : Boolean
      {
         return this._bFinalized && super.finalized;
      }
      
      override public function set finalized(b:Boolean) : void
      {
         this._bFinalized = b;
      }
      
      public function get hideScroll() : Boolean
      {
         return this._bHideScroll;
      }
      
      public function set hideScroll(hideScroll:Boolean) : void
      {
         this._bHideScroll = hideScroll;
      }
      
      override public function get htmlText() : String
      {
         return super.htmlText;
      }
      
      override public function set htmlText(pHtmlText:String) : void
      {
         super.htmlText = pHtmlText;
         if(this._bFinalized)
         {
            this._skipScrollUpdate = true;
            this.updateScrollBar();
         }
      }
      
      override public function set dropValidator(dv:Function) : void
      {
         this._dropValidator = dv;
         this._unboxedDropValidator = null;
      }
      
      override public function get dropValidator() : Function
      {
         if(this._dropValidator == null)
         {
            return super.dropValidator;
         }
         if(this._unboxedDropValidator == null)
         {
            this._unboxedDropValidator = this._dropValidator;
         }
         return this._unboxedDropValidator;
      }
      
      override public function set processDrop(pd:Function) : void
      {
         this._processDrop = pd;
         this._unboxedProcessDrop = null;
      }
      
      override public function get processDrop() : Function
      {
         if(this._processDrop == null)
         {
            return super.processDrop;
         }
         if(this._unboxedProcessDrop == null)
         {
            this._unboxedProcessDrop = this._processDrop;
         }
         return this._unboxedProcessDrop;
      }
      
      override public function appendText(sTxt:String, style:String = null) : void
      {
         super.appendText(sTxt,style);
         if(this._bFinalized)
         {
            this._skipScrollUpdate = true;
            this.updateScrollBar();
         }
      }
      
      override public function finalize() : void
      {
         this._sbScrollBar.finalize();
         this.updateScrollBarPos();
         this.updateScrollBar();
         this._bFinalized = true;
         super.finalize();
      }
      
      override public function free() : void
      {
         super.free();
         this._bFinalized = false;
         this._nScrollPos = 5;
         this.___width = 0;
         this._sbScrollBar.min = 1;
         this._sbScrollBar.max = 1;
         this._sbScrollBar.step = 1;
         _tText.wordWrap = true;
         _tText.multiline = true;
      }
      
      override public function remove() : void
      {
         if(this._sbScrollBar)
         {
            this._sbScrollBar.removeEventListener(Event.CHANGE,this.onScroll);
            this._sbScrollBar.remove();
         }
         this._sbScrollBar = null;
         if(_tText)
         {
            _tText.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onTextWheel);
         }
         StageShareManager.stage.nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZE,this.onWindowResize);
         super.remove();
      }
      
      override public function process(msg:Message) : Boolean
      {
         if(msg is MouseWheelMessage && (this._sbScrollBar && this._sbScrollBar.visible))
         {
            return true;
         }
         return super.process(msg);
      }
      
      public function hideScrollBar() : void
      {
         this._sbScrollBar.visible = false;
      }
      
      protected function updateScrollBar(reset:Boolean = false, resetToTop:Boolean = true) : void
      {
         _tText.getCharBoundaries(0);
         var finalizedVal:Boolean = this._sbScrollBar.finalized;
         if(_tText.scrollV == 1 && _tText.bottomScrollV == _tText.numLines)
         {
            this._sbScrollBar.disabled = true;
            if(this._bHideScroll)
            {
               this._sbScrollBar.visible = false;
            }
            else
            {
               this._sbScrollBar.finalized = false;
               this._sbScrollBar.total = _tText.numLines;
               this._sbScrollBar.finalized = finalizedVal;
               this._sbScrollBar.max = _tText.maxScrollV;
               this._sbScrollBar.value = 0;
            }
         }
         else
         {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            if(_tText.height)
            {
               this._sbScrollBar.finalized = false;
               this._sbScrollBar.total = _tText.numLines;
               this._sbScrollBar.finalized = finalizedVal;
               this._sbScrollBar.max = _tText.maxScrollV;
               if(reset)
               {
                  if(resetToTop)
                  {
                     _tText.scrollV = 0;
                     this._sbScrollBar.value = 0;
                  }
                  else
                  {
                     _tText.scrollV = _tText.maxScrollV;
                     this._sbScrollBar.value = _tText.maxScrollV;
                  }
               }
               else if(!this._skipScrollUpdate)
               {
                  _tText.scrollV = _tText.maxScrollV;
                  this._sbScrollBar.value = _tText.maxScrollV;
               }
               else
               {
                  this._sbScrollBar.value = _tText.scrollV;
               }
            }
         }
         this._skipScrollUpdate = false;
         var ui:UiRootContainer = getUi();
         if(ui && ui.ready && ui.uiClass && ui.uiClass.hasOwnProperty("scrollBarUpdate"))
         {
            ui.uiClass.scrollBarUpdate();
         }
      }
      
      protected function updateScrollBarPos() : void
      {
         _tText.width = this.width - this._sbScrollBar.width - this._scrollXOffset;
         if(this._nScrollPos >= 0)
         {
            this._sbScrollBar.x = this.width - this._sbScrollBar.width;
            _tText.x = 0;
         }
         else
         {
            this._sbScrollBar.x = 0;
            _tText.x = this._sbScrollBar.width + this._scrollXOffset;
         }
      }
      
      override protected function updateAlign() : void
      {
         if(!this._sbScrollBar || this._sbScrollBar.disabled)
         {
            super.updateAlign();
         }
      }
      
      private function onTextWheel(e:MouseEvent) : void
      {
         e.delta *= 3;
         this._sbScrollBar.onWheel(e);
      }
      
      private function onScroll(e:Event) : void
      {
         _tText.scrollV = this._sbScrollBar.value / this._sbScrollBar.max * _tText.maxScrollV;
         Berilia.getInstance().handler.process(new ChangeMessage(this));
      }
      
      private function onWindowResize(pEvent:NativeWindowBoundsEvent) : void
      {
         var ge:GraphicElement = null;
         var ui:UiRootContainer = getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ge.locations && ge.locations.length > 1)
            {
               return;
            }
         }
      }
   }
}
