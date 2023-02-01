package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.ScrollBar;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.ui.Keyboard;
   
   public class ScrollContainer extends GraphicContainer implements FinalizableUIComponent
   {
      
      public static const BASE_SCROLL_VALUE:int = 100;
       
      
      private var _mask:Shape;
      
      private var _content:DisplayObjectContainer;
      
      private var _hScrollbar:ScrollBar;
      
      private var _vScrollbar:ScrollBar;
      
      private var _hScrollbarSpeed:Number = 1;
      
      private var _vScrollbarSpeed:Number = 1;
      
      private var _useHorizontalScroll:Boolean = true;
      
      private var _useVerticalScroll:Boolean = true;
      
      private var _scrollBarCss:Uri;
      
      private var _scrollBarSize:uint = 10;
      
      private var _scrollbarOffset:int = 0;
      
      private var _mouseEventCatcher:Shape;
      
      private var _lastVerticalScrollValue:int;
      
      public function ScrollContainer()
      {
         super();
         mouseEnabled = true;
         this._mask = new Shape();
         this._mask.graphics.beginFill(16776960);
         this._mask.graphics.drawRect(0,0,1,1);
         this._content = new Sprite();
         this._content.mask = this._mask;
         this._mouseEventCatcher = new Shape();
         super.addChild(this._content);
         super.addChild(this._mask);
      }
      
      override public function set width(n:Number) : void
      {
         super.width = n;
         this._mask.width = n;
         if(this._vScrollbar)
         {
            this._vScrollbar.x = width - this._vScrollbar.width;
         }
      }
      
      override public function set height(n:Number) : void
      {
         super.height = n;
         this._mask.height = n;
      }
      
      [Uri]
      public function set scrollbarCss(sValue:Uri) : void
      {
         this._scrollBarCss = sValue;
      }
      
      public function get verticalScrollSpeed() : Number
      {
         if(this._vScrollbar)
         {
            return this._vScrollbar.scrollSpeed;
         }
         return this._vScrollbarSpeed;
      }
      
      public function set verticalScrollSpeed(speed:Number) : void
      {
         if(this._vScrollbar)
         {
            this._vScrollbar.scrollSpeed = speed;
         }
         this._vScrollbarSpeed = speed;
      }
      
      public function set verticalScrollbarValue(value:int) : void
      {
         if(this._vScrollbar)
         {
            this._vScrollbar.value = value;
            this.onVerticalScroll(null);
         }
      }
      
      public function get verticalScrollbarValue() : int
      {
         if(this._vScrollbar)
         {
            return this._vScrollbar.value;
         }
         return -1;
      }
      
      public function get useHorizontalScroll() : Boolean
      {
         return this._useHorizontalScroll;
      }
      
      public function set useHorizontalScroll(yes:Boolean) : void
      {
         this._useHorizontalScroll = yes;
      }
      
      public function get useVerticalScroll() : Boolean
      {
         return this._useVerticalScroll;
      }
      
      public function set useVerticalScroll(yes:Boolean) : void
      {
         this._useVerticalScroll = yes;
      }
      
      public function get horizontalScrollSpeed() : Number
      {
         if(this._hScrollbar)
         {
            return this._hScrollbar.scrollSpeed;
         }
         return this._hScrollbarSpeed;
      }
      
      public function set horizontalScrollSpeed(speed:Number) : void
      {
         if(this._hScrollbar)
         {
            this._hScrollbar.scrollSpeed = speed;
         }
         this._hScrollbarSpeed = speed;
      }
      
      public function set horizontalScrollbarValue(value:int) : void
      {
         if(this._hScrollbar)
         {
            this._hScrollbar.value = value;
            this.onHorizontalScroll(null);
         }
      }
      
      public function get horizontalScrollbarValue() : int
      {
         if(this._hScrollbar)
         {
            return this._hScrollbar.value;
         }
         return -1;
      }
      
      public function set scrollbarOffset(sValue:int) : void
      {
         this._scrollbarOffset = sValue;
      }
      
      public function get scrollbarOffset() : int
      {
         return this._scrollbarOffset;
      }
      
      public function get lastVerticalScrollValue() : int
      {
         return this._lastVerticalScrollValue;
      }
      
      public function get hasVerticalScrollBar() : Boolean
      {
         return this._vScrollbar && this._vScrollbar.parent == this;
      }
      
      public function get verticalScrollBar() : ScrollBar
      {
         return this._vScrollbar;
      }
      
      public function get horizontalScrollBar() : ScrollBar
      {
         return this._hScrollbar;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         child.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(child);
         this.finalize();
         child.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return child;
      }
      
      override public function addContent(child:GraphicContainer, index:int = -1) : GraphicContainer
      {
         child.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(child);
         this.finalize();
         child.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return child;
      }
      
      override public function finalize() : void
      {
         var hScroll:Boolean = width < Math.floor(this._content.width) && this._useHorizontalScroll;
         var vScroll:Boolean = height < Math.floor(this._content.height) && this._useVerticalScroll;
         this._mask.height = height;
         this._mask.width = width;
         this._content.x = 0;
         this._content.y = 0;
         if(hScroll)
         {
            if(!this._hScrollbar)
            {
               this._hScrollbar = new ScrollBar();
               this._hScrollbar.vertical = false;
               this._hScrollbar.addEventListener(Event.CHANGE,this.onHorizontalScroll);
               this._hScrollbar.css = this._scrollBarCss;
               this._hScrollbar.min = 0;
               this._hScrollbar.height = this._scrollBarSize;
               this._hScrollbar.y = height - this._hScrollbar.height;
               this._hScrollbar.step = 1;
               this._hScrollbar.scrollSpeed = this._hScrollbarSpeed;
               super.addChild(this._hScrollbar);
               this._hScrollbar.finalize();
            }
            else
            {
               super.addChild(this._hScrollbar);
            }
            this._mask.height = height - (this._scrollBarSize + this._scrollbarOffset);
            this._hScrollbar.width = width - (!!vScroll ? this._scrollBarSize : 0);
            this._hScrollbar.max = this._content.width - width + (!!vScroll ? this._scrollBarSize : 0);
         }
         else if(this._hScrollbar && contains(this._hScrollbar))
         {
            removeChild(this._hScrollbar);
         }
         if(vScroll)
         {
            if(!this._vScrollbar)
            {
               this._vScrollbar = new ScrollBar();
               this._vScrollbar.addEventListener(Event.CHANGE,this.onVerticalScroll);
               this._vScrollbar.css = this._scrollBarCss;
               this._vScrollbar.min = 0;
               this._vScrollbar.width = this._scrollBarSize;
               this._vScrollbar.x = width - this._vScrollbar.width;
               this._vScrollbar.vertical = false;
               this._vScrollbar.step = 1;
               this._vScrollbar.scrollSpeed = this._vScrollbarSpeed;
               super.addChild(this._vScrollbar);
               this._vScrollbar.finalize();
            }
            else
            {
               super.addChild(this._vScrollbar);
            }
            this._vScrollbar.total = this._content.height;
            this._mask.width = width - this._scrollbarOffset - this._scrollBarSize;
            this._vScrollbar.height = height - (!!hScroll ? this._scrollBarSize : 0);
            this._vScrollbar.max = this._content.height - height + (!!hScroll ? this._scrollBarSize : 0);
         }
         else if(this._vScrollbar && contains(this._vScrollbar))
         {
            removeChild(this._vScrollbar);
         }
         _finalized = true;
         this._mouseEventCatcher.graphics.clear();
         this._mouseEventCatcher.graphics.beginFill(0,0);
         this._mouseEventCatcher.graphics.drawRect(0,0,__width,__height);
         super.addChild(this._mouseEventCatcher);
         super.finalize();
         getUi().iAmFinalized(this);
      }
      
      override public function process(msg:Message) : Boolean
      {
         var kdmsg:KeyboardKeyDownMessage = null;
         loop0:
         switch(true)
         {
            case msg is MouseWheelMessage:
               if(this._vScrollbar && this._vScrollbar.parent != null)
               {
                  this._vScrollbar.onWheel(MouseWheelMessage(msg).mouseEvent);
               }
               else if(this._hScrollbar && this._hScrollbar.parent != null)
               {
                  this._hScrollbar.onWheel(MouseWheelMessage(msg).mouseEvent);
               }
               return true;
            case msg is KeyboardKeyDownMessage:
               kdmsg = msg as KeyboardKeyDownMessage;
               switch(kdmsg.keyboardEvent.keyCode)
               {
                  case Keyboard.PAGE_DOWN:
                     if(this.hasVerticalScrollBar)
                     {
                        this._vScrollbar.value += BASE_SCROLL_VALUE * 3;
                        this.onVerticalScroll(null);
                        return true;
                     }
                     break loop0;
                  case Keyboard.PAGE_UP:
                     if(this.hasVerticalScrollBar)
                     {
                        this._vScrollbar.value -= BASE_SCROLL_VALUE * 3;
                        this.onVerticalScroll(null);
                        return true;
                     }
                     break loop0;
                  case Keyboard.UP:
                     if(this.hasVerticalScrollBar)
                     {
                        this._vScrollbar.value -= BASE_SCROLL_VALUE;
                        this.onVerticalScroll(null);
                        return true;
                     }
                     break loop0;
                  case Keyboard.DOWN:
                     if(this.hasVerticalScrollBar)
                     {
                        this._vScrollbar.value += BASE_SCROLL_VALUE;
                        this.onVerticalScroll(null);
                        return true;
                     }
                     break loop0;
               }
         }
         return false;
      }
      
      override public function remove() : void
      {
         if(this._hScrollbar)
         {
            this._hScrollbar.removeEventListener(Event.CHANGE,this.onHorizontalScroll);
         }
         if(this._vScrollbar)
         {
            this._vScrollbar.removeEventListener(Event.CHANGE,this.onVerticalScroll);
         }
         super.remove();
      }
      
      override public function getStrata(nStrata:int) : Sprite
      {
         var nIndex:uint = 0;
         var i:uint = 0;
         if(_aStrata[nStrata] != null)
         {
            return _aStrata[nStrata];
         }
         _aStrata[nStrata] = new Sprite();
         _aStrata[nStrata].name = "strata_" + nStrata;
         _aStrata[nStrata].mouseEnabled = mouseEnabled;
         nIndex = 0;
         for(i = 0; i < _aStrata.length; i++)
         {
            if(_aStrata[i] != null)
            {
               this._content.addChildAt(_aStrata[i],nIndex++);
            }
         }
         return _aStrata[nStrata];
      }
      
      private function onVerticalScroll(e:Event) : void
      {
         this._content.y = -this._vScrollbar.value;
         this._lastVerticalScrollValue = this._vScrollbar.value;
      }
      
      private function onHorizontalScroll(e:Event) : void
      {
         this._content.x = -this._hScrollbar.value;
      }
      
      private function onChildFinalized(e:Event) : void
      {
         e.target.removeEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         this.finalize();
      }
      
      private function onChildRemoved(e:Event) : void
      {
         e.currentTarget.removeEventListener(Event.REMOVED,this.onChildRemoved);
      }
   }
}
