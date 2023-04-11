package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pools.PoolableRectangle;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ScrollBar extends GraphicContainer implements FinalizableUIComponent
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ScrollBar));
      
      private static const MAX_DECELERATE_FACTOR:uint = 4;
      
      private static const FIRST_MAX_DECELERATE_FACTOR:uint = 16;
       
      
      private var _nWidth:uint = 10;
      
      private var _nHeight:uint = 200;
      
      private var _sCss:Uri;
      
      private var _nMin:int;
      
      private var _nMax:int;
      
      private var _nTotal:int = 1;
      
      private var _nStep:uint = 1;
      
      private var _nCurrentValue:int = 0;
      
      private var _bDisabled:Boolean = false;
      
      private var _texBack:GraphicContainer;
      
      private var _texBox:GraphicContainer;
      
      private var _texMin:GraphicContainer;
      
      private var _texMax:GraphicContainer;
      
      private var _gcMin:GraphicContainer;
      
      private var _gcMax:GraphicContainer;
      
      private var _gcBox:GraphicContainer;
      
      private var _nBoxSize:Number;
      
      private var _nBoxPosMin:Number;
      
      private var _nBoxPosMax:Number;
      
      private var _nCurrentPos:Number = 0;
      
      private var _nLastPos:Number = 0;
      
      private var _nScrollStep:Number;
      
      private var _nScrollSpeed:Number = 0.3333333333333333;
      
      private var _squareEdge:uint;
      
      private var _bVertical:Boolean;
      
      private var _bFinalized:Boolean = false;
      
      private var _nDecelerateScroll:uint = 1;
      
      private var _nAcelerateScroll:uint = 0;
      
      private var _nMaxDecelerateFactor:uint;
      
      private var _bOnDrag:Boolean = false;
      
      private var _firstScrollUpdate:Boolean;
      
      public function ScrollBar()
      {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      override public function get width() : Number
      {
         return this._nWidth;
      }
      
      override public function set width(nValue:Number) : void
      {
         this._nWidth = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      override public function get height() : Number
      {
         return this._nHeight;
      }
      
      override public function set height(nValue:Number) : void
      {
         this._nHeight = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      [Uri]
      public function get css() : Uri
      {
         return this._sCss;
      }
      
      [Uri]
      public function set css(sValue:Uri) : void
      {
         if(sValue == null)
         {
            return;
         }
         if(sValue != this._sCss)
         {
            this._sCss = sValue;
         }
      }
      
      public function get min() : int
      {
         return this._nMin;
      }
      
      public function set min(nValue:int) : void
      {
         this._nMin = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      public function get max() : int
      {
         return this._nMax;
      }
      
      public function set max(nValue:int) : void
      {
         this._nMax = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      public function get total() : int
      {
         return this._nTotal;
      }
      
      public function set total(nValue:int) : void
      {
         this._nTotal = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      public function get step() : uint
      {
         return this._nStep;
      }
      
      public function set step(nValue:uint) : void
      {
         this._nStep = nValue;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      public function get value() : int
      {
         return Math.min(Math.round((this._nCurrentPos - this._nBoxPosMin) / this._nScrollStep) * this._nStep + this._nMin,this._nMax);
      }
      
      public function set value(nValue:int) : void
      {
         if(nValue > this._nMax)
         {
            nValue = this._nMax;
         }
         if(nValue < this._nMin)
         {
            nValue = this._nMin;
         }
         this._nCurrentValue = nValue;
         if(finalized)
         {
            this._nCurrentPos = (this._nCurrentValue - this._nMin) * (this._nStep * this._nScrollStep) + this._nBoxPosMin;
            this.updateDisplayFromCurrentPos();
         }
      }
      
      public function set scrollSpeed(nValue:Number) : void
      {
         this._nScrollSpeed = nValue;
      }
      
      public function get scrollSpeed() : Number
      {
         return this._nScrollSpeed;
      }
      
      public function get boxSize() : Number
      {
         return this._nBoxSize;
      }
      
      public function set vertical(b:Boolean) : void
      {
         this._bVertical = b;
         if(finalized)
         {
            this.scrollBarProcess();
         }
      }
      
      public function get vertical() : Boolean
      {
         return this._bVertical;
      }
      
      override public function set disabled(bool:Boolean) : void
      {
         if(bool == this._bDisabled)
         {
            return;
         }
         if(bool)
         {
            if(this._texBox)
            {
               this._texBox.visible = false;
            }
            if(this._texMin && this._texMax)
            {
               if(this._texMax is Texture)
               {
                  Texture(this._texMax).gotoAndStop = StatesEnum.STATE_DISABLED_STRING;
                  Texture(this._texMin).gotoAndStop = StatesEnum.STATE_DISABLED_STRING;
               }
            }
            mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            if(this._texBox)
            {
               this._texBox.visible = true;
            }
            if(this._texMin && this._texMax)
            {
               if(this._texMax is Texture)
               {
                  Texture(this._texMax).gotoAndStop = StatesEnum.STATE_NORMAL_STRING;
                  Texture(this._texMin).gotoAndStop = StatesEnum.STATE_NORMAL_STRING;
               }
            }
            mouseEnabled = true;
            mouseChildren = true;
         }
         this._bDisabled = bool;
      }
      
      override public function finalize() : void
      {
         if(this._sCss)
         {
            if(this._nHeight > this._nWidth)
            {
               this._bVertical = true;
            }
            else
            {
               this._bVertical = false;
            }
            CssManager.getInstance().askCss(this._sCss.uri,new Callback(this.onCssLoaded));
         }
      }
      
      private function scrollBarInit() : void
      {
         var stateChangingProperties1:Array = null;
         var stateChangingProperties2:Array = null;
         var stateChangingProperties3:Array = null;
         if(!this._gcBox)
         {
            this._gcBox = new ButtonContainer();
            this._texBox.name = name + "_scrollBar_buttonBox";
            getUi().registerId(this._texBox.name,new GraphicElement(this._texBox,null,"buttonBox"));
            this._gcBox.addChild(this._texBox);
            stateChangingProperties1 = new Array();
            stateChangingProperties1[StatesEnum.STATE_OVER] = new Array();
            stateChangingProperties1[StatesEnum.STATE_OVER][this._texBox.name] = new Array();
            if(this._texBox is Texture)
            {
               stateChangingProperties1[StatesEnum.STATE_OVER][this._texBox.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            }
            else if(this._texBox is TextureBitmap && this._texBox.themeDataId)
            {
               stateChangingProperties1[StatesEnum.STATE_OVER][this._texBox.name]["themeDataId"] = this._texBox.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            }
            stateChangingProperties1[StatesEnum.STATE_CLICKED] = new Array();
            stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texBox.name] = new Array();
            if(this._texBox is Texture)
            {
               stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texBox.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            }
            else if(this._texBox is TextureBitmap && this._texBox.themeDataId)
            {
               stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texBox.name]["themeDataId"] = this._texBox.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            }
            ButtonContainer(this._gcBox).changingStateData = stateChangingProperties1;
            if(this._texMin)
            {
               this._gcMin = new ButtonContainer();
               (this._gcMin as ButtonContainer).soundId = "-1";
               this._texMin.name = name + "_scrollBar_buttonMin";
               if(this._texMin is Texture)
               {
                  Texture(this._texMin).keepRatio = true;
               }
               getUi().registerId(this._texMin.name,new GraphicElement(this._texMin,null,"buttonMin"));
               this._gcMin.addChild(this._texMin);
               stateChangingProperties2 = new Array();
               stateChangingProperties2[StatesEnum.STATE_OVER] = new Array();
               stateChangingProperties2[StatesEnum.STATE_OVER][this._texMin.name] = new Array();
               if(this._texMin is Texture)
               {
                  stateChangingProperties2[StatesEnum.STATE_OVER][this._texMin.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
               }
               else if(this._texMin is TextureBitmap && this._texMin.themeDataId)
               {
                  stateChangingProperties1[StatesEnum.STATE_OVER][this._texMin.name]["themeDataId"] = this._texMin.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
               }
               stateChangingProperties2[StatesEnum.STATE_CLICKED] = new Array();
               stateChangingProperties2[StatesEnum.STATE_CLICKED][this._texMin.name] = new Array();
               if(this._texMin is Texture)
               {
                  stateChangingProperties2[StatesEnum.STATE_CLICKED][this._texMin.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
               }
               else if(this._texMin is TextureBitmap && this._texMin.themeDataId)
               {
                  stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texMin.name]["themeDataId"] = this._texMin.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
               }
               ButtonContainer(this._gcMin).changingStateData = stateChangingProperties2;
            }
            if(this._texMax)
            {
               this._gcMax = new ButtonContainer();
               (this._gcMax as ButtonContainer).soundId = "-1";
               this._texMax.name = name + "_scrollBar_buttonMax";
               if(this._texMax is Texture)
               {
                  Texture(this._texMax).keepRatio = true;
               }
               getUi().registerId(this._texMax.name,new GraphicElement(this._texMax,null,"buttonMax"));
               this._gcMax.addChild(this._texMax);
               stateChangingProperties3 = new Array();
               stateChangingProperties3[StatesEnum.STATE_OVER] = new Array();
               stateChangingProperties3[StatesEnum.STATE_OVER][this._texMax.name] = new Array();
               if(this._texMax is Texture)
               {
                  stateChangingProperties3[StatesEnum.STATE_OVER][this._texMax.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
               }
               else if(this._texMax is TextureBitmap && this._texMax.themeDataId)
               {
                  stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texMax.name]["themeDataId"] = this._texMax.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
               }
               stateChangingProperties3[StatesEnum.STATE_CLICKED] = new Array();
               stateChangingProperties3[StatesEnum.STATE_CLICKED][this._texMax.name] = new Array();
               if(this._texMax is Texture)
               {
                  stateChangingProperties3[StatesEnum.STATE_CLICKED][this._texMax.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
               }
               else if(this._texMax is TextureBitmap && this._texMax.themeDataId)
               {
                  stateChangingProperties1[StatesEnum.STATE_CLICKED][this._texMax.name]["themeDataId"] = this._texMax.themeDataId.replace("_normal","") + "_" + StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
               }
               ButtonContainer(this._gcMax).changingStateData = stateChangingProperties3;
            }
         }
         finalized = true;
         this.scrollBarProcess();
         super.finalize();
         getUi().iAmFinalized(this);
      }
      
      private function scrollBarProcess() : void
      {
         var maxWL:int = Math.max(this._nWidth,this._nHeight);
         this._squareEdge = Math.min(this._nWidth,this._nHeight);
         var arrowEdge:uint = this._squareEdge;
         if(!this._texMin && !this._texMax)
         {
            arrowEdge = 0;
         }
         if(!this._texBack.stage || !this._texBack.finalized)
         {
            if(this._texBack is Texture)
            {
               Texture(this._texBack).autoGrid = true;
            }
            this._texBack.width = this._nWidth;
            this._texBack.height = this._nHeight - arrowEdge * 0.4;
            this._texBack.x = 0;
            this._texBack.y = 0;
            this._texBack.finalize();
            addChildAt(this._texBack,0);
         }
         else
         {
            this._texBack.width = this._nWidth;
            this._texBack.height = this._nHeight - arrowEdge * 0.4;
         }
         this._texBack.mouseEnabled = true;
         if(this._texMin)
         {
            if(!this._texMin.finalized)
            {
               if(this._bVertical)
               {
                  this._texMin.width = arrowEdge;
               }
               else
               {
                  this._texMin.height = arrowEdge;
               }
               if(this._texMin is Texture)
               {
                  Texture(this._texMin).dispatchMessages = true;
               }
               this._texMin.finalize();
               addChild(this._gcMin);
            }
            else if(this._bVertical)
            {
               this._texMin.width = arrowEdge;
            }
            else
            {
               this._texMin.height = arrowEdge;
            }
         }
         if(this._texMax)
         {
            if(!this._texMax.finalized)
            {
               if(this._bVertical)
               {
                  this._texMax.width = arrowEdge;
               }
               else
               {
                  this._texMax.height = arrowEdge;
               }
               if(this._texMax is Texture)
               {
                  Texture(this._texMax).dispatchMessages = true;
               }
               this._texMax.finalize();
               this._gcMax.x = !!this._bVertical ? Number(0) : Number(this._nWidth - arrowEdge);
               this._gcMax.y = !!this._bVertical ? Number(this._nHeight - arrowEdge) : Number(0);
               addChild(this._gcMax);
            }
            else
            {
               if(this._bVertical)
               {
                  this._texMax.width = arrowEdge;
               }
               else
               {
                  this._texMax.height = arrowEdge;
               }
               this._gcMax.x = !!this._bVertical ? Number(0) : Number(this._nWidth - arrowEdge);
               this._gcMax.y = !!this._bVertical ? Number(this._nHeight - arrowEdge) : Number(0);
            }
         }
         this._nBoxSize = (maxWL - 2 * arrowEdge) * ((this._nTotal - this._nMax) / (this._nTotal == 0 ? 1 : this._nTotal));
         this._nBoxSize = Math.max(this._squareEdge,this._nBoxSize);
         var cheatToAvoidAGapAndWeShouldGetRidOfIt:int = 0;
         if(this._texMin)
         {
            cheatToAvoidAGapAndWeShouldGetRidOfIt = 6;
            this._nBoxPosMin = arrowEdge - cheatToAvoidAGapAndWeShouldGetRidOfIt;
         }
         else
         {
            this._nBoxPosMin = 0;
         }
         this._nBoxPosMax = Math.ceil(maxWL - arrowEdge - this._nBoxSize);
         this._nScrollStep = (maxWL - 2 * arrowEdge + cheatToAvoidAGapAndWeShouldGetRidOfIt - this._nBoxSize) / (this._nMax - this._nMin);
         this._nLastPos = this._nCurrentPos;
         if(this._nCurrentValue > this._nMax)
         {
            this._nCurrentValue = this._nMax;
         }
         if(this._nCurrentValue < this._nMin)
         {
            this._nCurrentValue = this._nMin;
         }
         this._nCurrentPos = (this._nCurrentValue - this._nMin) / this._nStep * this._nScrollStep + this._nBoxPosMin;
         if(this._nCurrentValue != 0)
         {
            this.updateDisplayFromCurrentPos();
         }
         if(!this._texBox.finalized || !this._gcBox.parent)
         {
            this._texBox.width = !!this._bVertical ? Number(this._squareEdge) : Number(this._nBoxSize);
            this._texBox.height = !!this._bVertical ? Number(this._nBoxSize) : Number(this._squareEdge);
            if(this._texBox is Texture)
            {
               Texture(this._texBox).autoGrid = true;
            }
            this._texBox.finalize();
            this._gcBox.x = !!this._bVertical ? Number(0) : Number(this._nCurrentPos);
            this._gcBox.y = !!this._bVertical ? Number(this._nCurrentPos) : Number(0);
            addChild(this._gcBox);
         }
         else
         {
            this._texBox.finalized = false;
            this._texBox.width = !!this._bVertical ? Number(this._squareEdge) : Number(this._nBoxSize);
            this._texBox.height = !!this._bVertical ? Number(this._nBoxSize) : Number(this._squareEdge);
            if(this._texBox is Texture)
            {
               Texture(this._texBox).autoGrid = true;
            }
            this._texBox.finalize();
            this._gcBox.x = !!this._bVertical ? Number(0) : Number(this._nCurrentPos);
            this._gcBox.y = !!this._bVertical ? Number(this._nCurrentPos) : Number(0);
         }
         if(this._nMax <= this._nMin)
         {
            this._texBox.visible = false;
         }
         else
         {
            this._texBox.visible = true;
         }
         if(this._texMin && this._texMin is Texture)
         {
            if(Texture(this._texMin).loading)
            {
               this._texMin.addEventListener(Event.COMPLETE,this.eventOnTextureReady);
            }
            else
            {
               Texture(this._texMin).gotoAndStop = !!this._bDisabled ? StatesEnum.STATE_DISABLED_STRING : StatesEnum.STATE_NORMAL_STRING;
            }
         }
         if(this._texMax is Texture)
         {
            if(Texture(this._texMax).loading)
            {
               this._texMax.addEventListener(Event.COMPLETE,this.eventOnTextureReady);
            }
            else
            {
               Texture(this._texMax).gotoAndStop = !!this._bDisabled ? StatesEnum.STATE_DISABLED_STRING : StatesEnum.STATE_NORMAL_STRING;
            }
         }
      }
      
      private function updateDisplayFromCurrentPos() : void
      {
         if(this._texMin && this._texMax)
         {
            if(this._bVertical)
            {
               this._texMin.width = this._squareEdge;
            }
            else
            {
               this._texMin.height = this._squareEdge;
            }
            if(this._bVertical)
            {
               this._texMax.width = this._squareEdge;
            }
            else
            {
               this._texMax.height = this._squareEdge;
            }
         }
         if(this._gcBox)
         {
            if(this._bVertical)
            {
               this._gcBox.y = this._nCurrentPos;
            }
            else
            {
               this._gcBox.x = this._nCurrentPos;
            }
         }
      }
      
      private function approximate(nValue:Number) : Number
      {
         return nValue + this._nMin;
      }
      
      private function valueOfPos(nPos:Number) : int
      {
         return Math.min(Math.ceil((nPos - this._nBoxPosMin) / this._nScrollStep) * this._nStep + this._nMin,this._nBoxPosMax);
      }
      
      override public function remove() : void
      {
         if(!__removed)
         {
            EnterFrameDispatcher.removeEventListener(this.onDragRunning);
            EnterFrameDispatcher.removeEventListener(this.onBottomArrowDown);
            EnterFrameDispatcher.removeEventListener(this.onTopArrowDown);
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onWheel);
            if(this._texMax)
            {
               this._texMax.removeEventListener(Event.COMPLETE,this.eventOnTextureReady);
            }
            if(this._texMin)
            {
               this._texMin.removeEventListener(Event.COMPLETE,this.eventOnTextureReady);
            }
            this.clear();
         }
         super.remove();
      }
      
      private function clear() : void
      {
         if(this._gcBox != null && contains(this._gcBox))
         {
            this._texBox.remove();
            getUi().removeFromRenderList(this._texBox.name);
            this._gcBox.remove();
         }
         if(this._gcMax != null && contains(this._gcMax))
         {
            this._texMax.remove();
            getUi().removeFromRenderList(this._texMax.name);
            this._gcMax.remove();
         }
         if(this._gcMin != null && contains(this._gcMin))
         {
            this._texMin.remove();
            getUi().removeFromRenderList(this._texMin.name);
            this._gcMin.remove();
         }
         if(this._texBack != null)
         {
            this._texBack.remove();
         }
      }
      
      override public function process(msg:Message) : Boolean
      {
         var ncp:Number = NaN;
         var listener:IInterfaceListener = null;
         var listener2:IInterfaceListener = null;
         var curr:int = this._nCurrentPos;
         var pr:PoolableRectangle = PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle;
         switch(true)
         {
            case msg is MouseDownMessage:
               switch(MouseDownMessage(msg).target)
               {
                  case this._gcMax:
                     for each(listener in Berilia.getInstance().UISoundListeners)
                     {
                        listener.playUISound("16015");
                     }
                     if(this._nCurrentPos + this._nScrollStep <= this._nBoxPosMax)
                     {
                        this._nCurrentPos += this._nScrollStep;
                     }
                     else
                     {
                        this._nCurrentPos = this._nBoxPosMax;
                     }
                     if(curr != this._nCurrentPos)
                     {
                        this.updateDisplayFromCurrentPos();
                        dispatchEvent(new Event(Event.CHANGE));
                     }
                     this._nDecelerateScroll = 1;
                     this._nAcelerateScroll = 0;
                     this._nMaxDecelerateFactor = FIRST_MAX_DECELERATE_FACTOR;
                     this._firstScrollUpdate = true;
                     EnterFrameDispatcher.addEventListener(this.onBottomArrowDown,EnterFrameConst.SCROLL_BAR_BOTTOM_ARROW);
                     break;
                  case this._gcMin:
                     for each(listener2 in Berilia.getInstance().UISoundListeners)
                     {
                        listener2.playUISound("16014");
                     }
                     if(this._nCurrentPos - this._nScrollStep >= this._nBoxPosMin)
                     {
                        this._nCurrentPos -= this._nScrollStep;
                     }
                     else
                     {
                        this._nCurrentPos = this._nBoxPosMin;
                     }
                     if(curr != this._nCurrentPos)
                     {
                        this.updateDisplayFromCurrentPos();
                        dispatchEvent(new Event(Event.CHANGE));
                     }
                     this._nDecelerateScroll = 1;
                     this._nAcelerateScroll = 0;
                     this._nMaxDecelerateFactor = FIRST_MAX_DECELERATE_FACTOR;
                     this._firstScrollUpdate = true;
                     EnterFrameDispatcher.addEventListener(this.onTopArrowDown,EnterFrameConst.SCROLL_BAR_TOP_ARROW);
                     break;
                  case this._texBack:
                     if(this._bVertical)
                     {
                        this._nCurrentPos = this.approximate(int(this._texBack.mouseY));
                     }
                     else
                     {
                        this._nCurrentPos = this.approximate(int(this._texBack.mouseX));
                     }
                     ncp = this._nCurrentPos - this._nCurrentPos % this._nScrollStep;
                     this._nCurrentPos = ncp - this._squareEdge / 2;
                     if(this._nCurrentPos > this._nBoxPosMax || this._nCurrentPos > this._nBoxPosMax - this._nScrollStep)
                     {
                        this._nCurrentPos = this._nBoxPosMax;
                     }
                     if(this._nCurrentPos < this._nBoxPosMin)
                     {
                        this._nCurrentPos = this._nBoxPosMin;
                     }
                     this.updateDisplayFromCurrentPos();
                     dispatchEvent(new Event(Event.CHANGE));
                     break;
                  case this._gcBox:
                     if(this._bVertical)
                     {
                        this._bOnDrag = true;
                        this._gcBox.startDrag(false,pr.renew(this._texBack.x,this._texBack.y + this._nBoxPosMin,0,Math.ceil(this._nBoxPosMax - this._nBoxPosMin)));
                     }
                     else
                     {
                        this._bOnDrag = true;
                        this._gcBox.startDrag(false,pr.renew(this._texBack.x + this._nBoxPosMin,this._texBack.y,this._nBoxPosMax - this._nBoxPosMin,0));
                     }
                     EnterFrameDispatcher.addEventListener(this.onDragRunning,EnterFrameConst.SCROLLBAR_DRAG_RUNNING);
               }
               PoolsManager.getInstance().getRectanglePool().checkIn(pr);
               return true;
            case msg is MouseUpMessage:
               switch(MouseUpMessage(msg).target)
               {
                  case this._gcMax:
                     EnterFrameDispatcher.removeEventListener(this.onBottomArrowDown);
                     break;
                  case this._gcMin:
                     EnterFrameDispatcher.removeEventListener(this.onTopArrowDown);
                     break;
                  case this._gcBox:
                     if(this._bOnDrag)
                     {
                        this._gcBox.stopDrag();
                        this._bOnDrag = false;
                        EnterFrameDispatcher.removeEventListener(this.onDragRunning);
                        dispatchEvent(new Event(Event.CHANGE));
                     }
               }
               PoolsManager.getInstance().getRectanglePool().checkIn(pr);
               return true;
            case msg is MouseReleaseOutsideMessage:
               if(this._bOnDrag)
               {
                  this._gcBox.stopDrag();
                  this._bOnDrag = false;
                  this._nCurrentPos = !!this._bVertical ? Number(this._gcBox.y) : Number(this._gcBox.x);
                  dispatchEvent(new Event(Event.CHANGE));
                  EnterFrameDispatcher.removeEventListener(this.onDragRunning);
               }
               EnterFrameDispatcher.removeEventListener(this.onBottomArrowDown);
               EnterFrameDispatcher.removeEventListener(this.onTopArrowDown);
               PoolsManager.getInstance().getRectanglePool().checkIn(pr);
               return true;
            case msg is MouseWheelMessage:
               addEventListener(MouseEvent.MOUSE_WHEEL,this.onWheel);
               return true;
            default:
               PoolsManager.getInstance().getRectanglePool().checkIn(pr);
               return false;
         }
      }
      
      private function onDragRunning(e:Event) : void
      {
         var newCoord:int = 0;
         var max:int = 0;
         var curr:int = this.value;
         if(this._bVertical)
         {
            newCoord = int(this._gcBox.y);
            if(curr != this.valueOfPos(newCoord))
            {
               this._nCurrentPos = newCoord;
               max = this._nHeight - this._nBoxSize;
               if(this._nCurrentPos > max)
               {
                  this._nCurrentPos = max;
               }
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
         else
         {
            newCoord = this.approximate(int(this._gcBox.x));
            if(curr != this.valueOfPos(newCoord))
            {
               this._nCurrentPos = newCoord;
               max = this._nWidth - this._nBoxSize;
               if(this._nCurrentPos > max)
               {
                  this._nCurrentPos = max;
               }
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
      }
      
      private function onTopArrowDown(e:Event) : void
      {
         var oldPos:Number = this._nCurrentPos;
         if(this._nDecelerateScroll >= this._nMaxDecelerateFactor)
         {
            if(this._firstScrollUpdate)
            {
               this._firstScrollUpdate = false;
               this._nMaxDecelerateFactor = MAX_DECELERATE_FACTOR;
            }
            if(this._nCurrentPos - this._nScrollStep >= this._nBoxPosMin)
            {
               this._nCurrentPos -= this._nScrollStep;
            }
            else
            {
               this._nCurrentPos = this._nBoxPosMin;
            }
            this._nDecelerateScroll = this._nAcelerateScroll < this._nMaxDecelerateFactor ? uint(this._nAcelerateScroll++) : uint(this._nMaxDecelerateFactor - 1);
            if(oldPos != this._nCurrentPos)
            {
               this.updateDisplayFromCurrentPos();
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
         ++this._nDecelerateScroll;
      }
      
      private function onBottomArrowDown(e:Event) : void
      {
         var oldPos:Number = this._nCurrentPos;
         if(this._nDecelerateScroll >= this._nMaxDecelerateFactor)
         {
            if(this._firstScrollUpdate)
            {
               this._firstScrollUpdate = false;
               this._nMaxDecelerateFactor = MAX_DECELERATE_FACTOR;
            }
            if(this._nCurrentPos + this._nScrollStep <= this._nBoxPosMax)
            {
               this._nCurrentPos += this._nScrollStep;
            }
            else
            {
               this._nCurrentPos = this._nBoxPosMax;
            }
            this._nDecelerateScroll = this._nAcelerateScroll < this._nMaxDecelerateFactor ? uint(this._nAcelerateScroll++) : uint(this._nMaxDecelerateFactor - 1);
            if(oldPos != this._nCurrentPos)
            {
               this.updateDisplayFromCurrentPos();
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
         ++this._nDecelerateScroll;
      }
      
      public function onWheel(e:Object, dispatchEvt:Boolean = true) : void
      {
         this._nCurrentPos -= this._nScrollStep * (e.delta * this._nScrollSpeed);
         if(this._nCurrentPos > this._nBoxPosMax)
         {
            this._nCurrentPos = Math.floor(this._nBoxPosMax);
         }
         if(this._nCurrentPos < this._nBoxPosMin)
         {
            this._nCurrentPos = this._nBoxPosMin;
         }
         this.updateDisplayFromCurrentPos();
         if(dispatchEvt)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      private function fakeCssLoaded() : void
      {
      }
      
      private function onCssLoaded() : void
      {
         var _ssSheet:ExtendedStyleSheet = null;
         var styleObj:Object = null;
         if(!this._gcBox)
         {
            _ssSheet = CssManager.getInstance().getCss(this._sCss.uri);
            styleObj = _ssSheet.getStyle(".skin");
            this._texBack = this.initTexture("Back",styleObj);
            this._texBox = this.initTexture("Box",styleObj);
            this._texMax = this.initTexture("Max",styleObj);
            this._texMin = this.initTexture("Min",styleObj);
         }
         this.scrollBarInit();
      }
      
      private function initTexture(param1:String, param2:Object) : GraphicContainer
      {
         var _loc3_:TextureBitmap = null;
         var _loc4_:Texture = null;
         param1 = "texture" + param1;
         if(param2[param1 + "Type"] && String(param2[param1 + "Type"]).toLowerCase() == "texturebitmap")
         {
            _loc3_ = new TextureBitmap();
            if(param2[param1])
            {
               _loc3_.uri = new Uri(LangManager.getInstance().replaceKey(unescape(param2[param1])));
            }
            if(param2[param1 + "ThemeDataId"])
            {
               _loc3_.themeDataId = param2[param1 + "ThemeDataId"];
            }
            return _loc3_;
         }
         if(!param2[param1])
         {
            return null;
         }
         _loc4_ = new Texture();
         _loc4_.uri = new Uri(LangManager.getInstance().replaceKey(unescape(param2[param1])));
         return _loc4_;
      }
      
      public function eventOnTextureReady(e:Event) : void
      {
         if(e.target == this._texMin && this._texMin is Texture)
         {
            Texture(this._texMin).gotoAndStop = !!this._bDisabled ? StatesEnum.STATE_DISABLED_STRING.toLowerCase() : StatesEnum.STATE_NORMAL_STRING.toLowerCase();
         }
         else if(e.target == this._texMax && this._texMax is Texture)
         {
            Texture(this._texMax).gotoAndStop = !!this._bDisabled ? StatesEnum.STATE_DISABLED_STRING.toLowerCase() : StatesEnum.STATE_NORMAL_STRING.toLowerCase();
         }
      }
   }
}
