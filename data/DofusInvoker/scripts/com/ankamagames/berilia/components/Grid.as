package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.gridRenderer.EntityGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.InlineXmlGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.LabelGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.MultiGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.XmlUiGridRenderer;
   import com.ankamagames.berilia.components.messages.ItemRightClickMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.utils.ObjectUtil;
   
   public class Grid extends GraphicContainer implements FinalizableUIComponent
   {
      
      private static var _include_XmlUiGridRenderer:XmlUiGridRenderer = null;
      
      private static var _include_LabelGridRenderer:LabelGridRenderer = null;
      
      private static var _include_SlotGridRenderer:SlotGridRenderer = null;
      
      private static var _include_EntityGridRenderer:EntityGridRenderer = null;
      
      private static var _include_InlineXmlGridRenderer:InlineXmlGridRenderer = null;
      
      private static var _include_MultiGridRenderer:MultiGridRenderer = null;
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Grid));
      
      public static const AUTOSELECT_NONE:int = 0;
      
      public static const AUTOSELECT_BY_INDEX:int = 1;
      
      public static const AUTOSELECT_BY_ITEM:int = 2;
       
      
      public var mouseClickEnabled:Boolean = true;
      
      protected var _dataProvider;
      
      protected var _renderer:IGridRenderer;
      
      protected var _items:Vector.<GridItem>;
      
      protected var _scrollBarV:ScrollBar;
      
      protected var _scrollBarH:ScrollBar;
      
      protected var _scrollbarOffset:int = 0;
      
      protected var _horizontalScrollSpeed:Number = 1;
      
      protected var _verticalScrollSpeed:Number = 1;
      
      protected var _slotWidth:uint = 50;
      
      protected var _slotHeight:uint = 50;
      
      protected var _sRendererName:String;
      
      protected var _sRendererArgs:String;
      
      protected var _verticalScroll:Boolean = true;
      
      protected var _pageXOffset:int = 0;
      
      protected var _pageYOffset:int = 0;
      
      protected var _nSelectedIndex:int = 0;
      
      protected var _nSelectedItem:WeakReference;
      
      protected var _sVScrollCss:Uri;
      
      protected var _sHScrollCss:Uri;
      
      protected var _scrollBarSize:uint = 10;
      
      protected var _eventCatcher:Shape;
      
      protected var _displayScrollbar:String = "auto";
      
      protected var _autoSelect:int = 1;
      
      protected var _sortProperty:String;
      
      protected var _autoPosition:Boolean = false;
      
      protected var _slotByRow:uint;
      
      protected var _slotByCol:uint;
      
      protected var _totalSlotByRow:uint;
      
      protected var _totalSlotByCol:uint;
      
      protected var _avaibleSpaceX:int;
      
      protected var _avaibleSpaceY:int;
      
      protected var _hiddenRow:uint = 0;
      
      protected var _hiddenCol:uint = 0;
      
      protected var _mask:Shape;
      
      protected var _hPadding:uint = 0;
      
      protected var _vPadding:uint = 0;
      
      protected var _allowLastToFirst:Boolean = false;
      
      protected var _useLeftRightToSelect:Boolean = false;
      
      protected var _ignoreConfigVar:Boolean = false;
      
      protected var _scrollBarHYOffset:Number = 0;
      
      protected var _scrollBarHXOffset:Number = 0;
      
      protected var _scrollBarHWidthOffset:Number = 0;
      
      protected var _isStaticGap:Boolean = false;
      
      protected var _staticGap:Number = 0;
      
      public var selectWithArrows:Boolean = true;
      
      public var _forceRefresh:Boolean = false;
      
      public var keyboardIndexHandler:Function;
      
      public var silent:Boolean;
      
      public function Grid()
      {
         super();
         this._items = new Vector.<GridItem>();
         this._dataProvider = new Array();
         this._eventCatcher = new Shape();
         this._eventCatcher.alpha = 0;
         this._eventCatcher.graphics.beginFill(16711680);
         this._eventCatcher.graphics.drawRect(0,0,1,1);
         addChild(this._eventCatcher);
         mouseEnabled = true;
         useHandCursor = false;
         MEMORY_LOG[this] = 1;
      }
      
      public function set hPadding(value:int) : void
      {
         this._hPadding = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get hPadding() : int
      {
         return this._hPadding;
      }
      
      public function set vPadding(value:int) : void
      {
         this._vPadding = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get vPadding() : int
      {
         return this._vPadding;
      }
      
      public function set allowLastToFirst(value:Boolean) : void
      {
         this._allowLastToFirst = value;
      }
      
      public function get allowLastToFirst() : Boolean
      {
         return this._allowLastToFirst;
      }
      
      public function set useLeftRightToSelect(value:Boolean) : void
      {
         this._useLeftRightToSelect = value;
      }
      
      public function get useLeftRightToSelect() : Boolean
      {
         return this._useLeftRightToSelect;
      }
      
      public function set isStaticGap(isStaticGap:Boolean) : void
      {
         this._isStaticGap = isStaticGap;
      }
      
      public function set staticGap(staticGap:Number) : void
      {
         this._staticGap = !!isNaN(staticGap) ? Number(0) : Number(staticGap);
      }
      
      public function get staticGap() : Number
      {
         return this._staticGap;
      }
      
      override public function set width(nW:Number) : void
      {
         if(super.width == nW)
         {
            return;
         }
         super.width = nW;
         this._eventCatcher.width = nW;
         if(finalized)
         {
            this.finalize();
            this.initSlot();
         }
      }
      
      override public function set height(nH:Number) : void
      {
         if(super.height == nH)
         {
            return;
         }
         super.height = nH;
         this._eventCatcher.height = nH;
         if(this._scrollBarV)
         {
            this._scrollBarV.height = nH;
         }
         if(finalized)
         {
            this.finalize();
            this.initSlot();
         }
      }
      
      public function get scrollBarSize() : uint
      {
         return this._scrollBarSize;
      }
      
      public function set rendererName(value:String) : void
      {
         if(value.indexOf(".") == -1)
         {
            value = "com.ankamagames.berilia.components.gridRenderer." + value;
         }
         this._sRendererName = value;
      }
      
      public function get rendererName() : String
      {
         return this._sRendererName;
      }
      
      public function set rendererArgs(value:String) : void
      {
         this._sRendererArgs = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get rendererArgs() : String
      {
         return this._sRendererArgs;
      }
      
      public function set autoPosition(value:Boolean) : void
      {
         this._autoPosition = value;
      }
      
      public function get autoPosition() : Boolean
      {
         return this._autoPosition;
      }
      
      public function get renderer() : IGridRenderer
      {
         return this._renderer;
      }
      
      public function set dataProvider(data:*) : void
      {
         if(!data)
         {
            return;
         }
         if(!this.isIterable(data))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         this._dataProvider = data;
         this.finalize();
         this.initSlot();
      }
      
      public function get dataProvider() : *
      {
         return this._dataProvider;
      }
      
      public function resetScrollBar() : void
      {
         if(this._scrollBarH && this._scrollBarH.visible)
         {
            this._scrollBarH.value = this._pageXOffset;
         }
         if(this._scrollBarV && this._scrollBarV.visible)
         {
            this._scrollBarV.value = this._pageYOffset;
         }
      }
      
      [Uri]
      public function set horizontalScrollbarCss(sValue:Uri) : void
      {
         this._sHScrollCss = sValue;
      }
      
      [Uri]
      public function get horizontalScrollbarCss() : Uri
      {
         return this._sHScrollCss;
      }
      
      [Uri]
      public function set verticalScrollbarCss(sValue:Uri) : void
      {
         this._sVScrollCss = sValue;
      }
      
      [Uri]
      public function get verticalScrollbarCss() : Uri
      {
         return this._sVScrollCss;
      }
      
      public function set scrollbarOffset(sValue:int) : void
      {
         this._scrollbarOffset = sValue;
      }
      
      public function get scrollbarOffset() : int
      {
         return this._scrollbarOffset;
      }
      
      public function set forceRefresh(sValue:Boolean) : void
      {
         this._forceRefresh = sValue;
      }
      
      public function set scrollBarHWidthOffset(sValue:int) : void
      {
         this._scrollBarHWidthOffset = sValue;
      }
      
      public function get selectedIndex() : int
      {
         return this._nSelectedIndex;
      }
      
      public function set selectedIndex(i:int) : void
      {
         this.setSelectedIndex(i,SelectMethodEnum.MANUAL);
      }
      
      public function set verticalScroll(b:Boolean) : void
      {
         if(this._verticalScroll != b)
         {
            this._verticalScroll = b;
            if(_finalized)
            {
               this.finalize();
            }
         }
      }
      
      public function get verticalScroll() : Boolean
      {
         return this._verticalScroll;
      }
      
      public function get pageYOffset() : int
      {
         return this._pageYOffset;
      }
      
      public function set autoSelect(b:Boolean) : void
      {
         this._autoSelect = AUTOSELECT_BY_INDEX;
         if(this._dataProvider.length && this._autoSelect == AUTOSELECT_BY_INDEX)
         {
            this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
         }
      }
      
      public function get autoSelect() : Boolean
      {
         return this._autoSelect == AUTOSELECT_BY_INDEX;
      }
      
      public function set autoSelectMode(mode:int) : void
      {
         this._autoSelect = mode;
         if(this._autoSelect == AUTOSELECT_NONE)
         {
            this._nSelectedIndex = -1;
         }
         if(this._dataProvider.length)
         {
            if(this._autoSelect == AUTOSELECT_BY_INDEX)
            {
               this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
            }
            else if(this._autoSelect == AUTOSELECT_BY_ITEM)
            {
               if(this._nSelectedItem)
               {
                  this.selectedItem = this._nSelectedItem.object;
                  if(this.selectedItem != this._nSelectedItem.object)
                  {
                     this._nSelectedItem = null;
                  }
               }
            }
         }
      }
      
      public function get autoSelectMode() : int
      {
         return this._autoSelect;
      }
      
      public function get scrollDisplay() : String
      {
         return this._displayScrollbar;
      }
      
      public function set scrollDisplay(sValue:String) : void
      {
         this._displayScrollbar = sValue;
      }
      
      public function get pagesCount() : uint
      {
         var count:int = 0;
         if(this._verticalScroll)
         {
            count = this._totalSlotByCol - this._slotByCol;
         }
         else
         {
            count = this._totalSlotByRow - this._slotByRow;
         }
         if(count < 0)
         {
            count = 0;
         }
         return count;
      }
      
      public function get selectedItem() : *
      {
         if(!this._dataProvider)
         {
            return null;
         }
         if(this._nSelectedIndex < 0)
         {
            return null;
         }
         if(this._nSelectedIndex >= this._dataProvider.length)
         {
            return null;
         }
         return this._dataProvider[this._nSelectedIndex];
      }
      
      public function set selectedItem(o:*) : void
      {
         var isSet:Boolean = false;
         var i:uint = 0;
         var data:* = undefined;
         if(this._dataProvider)
         {
            isSet = false;
            for(i = 0; i < this._dataProvider.length; i++)
            {
               data = this._dataProvider[i];
               if(data === o)
               {
                  this.setSelectedIndex(i,SelectMethodEnum.MANUAL);
                  isSet = true;
                  break;
               }
            }
         }
      }
      
      public function get slotWidth() : uint
      {
         return this._slotWidth;
      }
      
      public function set slotWidth(value:uint) : void
      {
         this._slotWidth = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get slotHeight() : uint
      {
         return this._slotHeight;
      }
      
      public function set slotHeight(value:uint) : void
      {
         this._slotHeight = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get slotByRow() : uint
      {
         return this._slotByRow;
      }
      
      public function get slotByCol() : uint
      {
         return this._slotByCol;
      }
      
      public function get scrollBarV() : ScrollBar
      {
         return this._scrollBarV;
      }
      
      public function get verticalScrollValue() : int
      {
         if(this._scrollBarV)
         {
            return this._scrollBarV.value;
         }
         return 0;
      }
      
      public function set verticalScrollValue(value:int) : void
      {
         if(this._scrollBarV)
         {
            this._scrollBarV.value = value;
            if(this._scrollBarV.value < 0)
            {
               this.updateFromIndex(0);
            }
            else
            {
               this.updateFromIndex(this._scrollBarV.value);
            }
         }
      }
      
      public function get verticalScrollSpeed() : Number
      {
         return this._verticalScrollSpeed;
      }
      
      public function get horizontalScrollSpeed() : Number
      {
         return this._horizontalScrollSpeed;
      }
      
      public function set verticalScrollSpeed(speed:Number) : void
      {
         this._verticalScrollSpeed = speed;
         if(this._scrollBarV)
         {
            this._scrollBarV.scrollSpeed = speed;
         }
      }
      
      public function set horizontalScrollSpeed(speed:Number) : void
      {
         this._horizontalScrollSpeed = speed;
         if(this._scrollBarH)
         {
            this._scrollBarH.scrollSpeed = speed;
         }
      }
      
      public function get hiddenRow() : uint
      {
         return this._hiddenRow;
      }
      
      public function get hiddenCol() : uint
      {
         return this._hiddenCol;
      }
      
      public function set hiddenRow(v:uint) : void
      {
         this._hiddenRow = v;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function set hiddenCol(v:uint) : void
      {
         this._hiddenCol = v;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function set slotByRow(v:uint) : void
      {
         this._slotByRow = v;
      }
      
      public function set totalSlotByRow(v:int) : void
      {
         this._totalSlotByRow = v;
      }
      
      public function set ignoreConfigVar(v:Boolean) : void
      {
         this._ignoreConfigVar = v;
      }
      
      public function set avaibleSpaceX(v:Number) : void
      {
         this._avaibleSpaceX = v;
      }
      
      public function set avaibleSpaceY(v:Number) : void
      {
         this._avaibleSpaceY = v;
      }
      
      public function set scrollBarHYOffset(v:Number) : void
      {
         this._scrollBarHYOffset = v;
      }
      
      public function set scrollBarHXOffset(v:Number) : void
      {
         this._scrollBarHXOffset = v;
      }
      
      public function renderModificator(childs:Array, accessKey:Object) : Array
      {
         var cRenderer:Class = null;
         if(accessKey != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         if(this._sRendererName)
         {
            if(!this._renderer)
            {
               cRenderer = getDefinitionByName(this._sRendererName) as Class;
               if(!cRenderer)
               {
                  _log.error("Invalid renderer specified for this grid.");
                  return childs;
               }
               this._renderer = new cRenderer(this._sRendererArgs);
               this._renderer.grid = this;
            }
            this.configVar();
            return this._renderer.renderModificator(childs);
         }
         _log.error("No renderer specified for grid " + name + " " + parent + " son.");
         return childs;
      }
      
      override public function finalize() : void
      {
         var maxValue:int = 0;
         if(!this._ignoreConfigVar)
         {
            this.configVar();
         }
         if(this._slotByRow < this._totalSlotByRow && this._displayScrollbar != "never")
         {
            if(!this._scrollBarH)
            {
               this._verticalScroll = false;
               this._scrollBarH = new ScrollBar();
               addChild(this._scrollBarH);
               this._scrollBarH.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
               this._scrollBarH.css = this._sHScrollCss;
               this._scrollBarH.min = 0;
               this._scrollBarH.max = this._totalSlotByRow - this._slotByRow;
               this._scrollBarH.total = this._totalSlotByRow;
               this._scrollBarH.width = width + this._scrollBarHWidthOffset;
               this._scrollBarH.height = this._scrollBarSize;
               this._scrollBarH.y = height - this._scrollBarH.height + this._scrollBarHYOffset;
               this._scrollBarH.x = this._scrollBarHXOffset - this._scrollBarHWidthOffset / 2;
               this._scrollBarH.step = 1;
               this._scrollBarH.scrollSpeed = this._horizontalScrollSpeed;
               this._scrollBarH.finalize();
            }
            else
            {
               this._scrollBarH.max = this._totalSlotByRow - this._slotByRow;
               addChild(this._scrollBarH);
            }
         }
         else if(this._slotByCol < this._totalSlotByCol && this._displayScrollbar != "never" || this._displayScrollbar == "always")
         {
            if(!this._scrollBarV)
            {
               this._scrollBarV = new ScrollBar();
               addChild(this._scrollBarV);
               this._scrollBarV.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
               this._scrollBarV.css = this._sVScrollCss;
               this._scrollBarV.min = 0;
               maxValue = this._totalSlotByCol - this._slotByCol;
               if(maxValue < 0)
               {
                  this._scrollBarV.max = 0;
               }
               else
               {
                  this._scrollBarV.max = maxValue;
               }
               this._scrollBarV.total = this._totalSlotByCol;
               this._scrollBarV.width = this._scrollBarSize;
               this._scrollBarV.height = height;
               this._scrollBarV.x = width - this._scrollBarV.width;
               this._scrollBarV.step = 1;
               this._scrollBarV.scrollSpeed = this._verticalScrollSpeed;
               this._scrollBarV.finalize();
            }
            else
            {
               this._scrollBarV.finalized = false;
               maxValue = this._totalSlotByCol - this._slotByCol;
               if(maxValue < 0)
               {
                  this._scrollBarV.max = 0;
               }
               else
               {
                  this._scrollBarV.max = maxValue;
               }
               this._scrollBarV.total = this._totalSlotByCol;
               addChild(this._scrollBarV);
               this._scrollBarV.x = width - this._scrollBarV.width;
               this._scrollBarV.finalize();
            }
         }
         else
         {
            if(this._scrollBarV && this._scrollBarV.parent)
            {
               removeChild(this._scrollBarV);
               this._scrollBarV.finalized = false;
               this._scrollBarV.max = 0;
               this._scrollBarV.finalize();
            }
            if(this._scrollBarH && this._scrollBarH.parent)
            {
               removeChild(this._scrollBarH);
               this._scrollBarH.finalized = false;
               this._scrollBarH.max = 0;
               this._scrollBarH.finalize();
            }
         }
         if(this._hiddenCol || this._hiddenRow)
         {
            if(!this._mask)
            {
               this._mask = new Shape();
            }
            if(this._mask.width != width || this._mask.height != height)
            {
               this._mask.graphics.clear();
               this._mask.graphics.beginFill(16776960);
               this._mask.graphics.drawRect(0,0,width,height);
               addChild(this._mask);
               mask = this._mask;
            }
         }
         super.finalize();
         _finalized = true;
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      public function moveToPage(page:uint) : void
      {
         if(page > this.pagesCount)
         {
            page = this.pagesCount;
         }
         this.updateFromIndex(page);
      }
      
      public function updateItem(index:uint) : void
      {
         var item:GridItem = null;
         var currenItem:GridItem = null;
         for each(item in this._items)
         {
            if(item.index == index)
            {
               currenItem = item;
               break;
            }
         }
         if(!currenItem)
         {
            return;
         }
         if(currenItem.index == this._nSelectedIndex)
         {
            this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,true);
         }
         else
         {
            this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,false);
         }
         currenItem.data = this._dataProvider[currenItem.index];
         var scrollValue:int = this.verticalScrollValue;
         this.finalize();
         this.verticalScrollValue = scrollValue;
      }
      
      public function updateItems() : void
      {
         var currenItem:GridItem = null;
         for(var index:uint = 0; index < this._items.length; index++)
         {
            currenItem = this._items[index];
            if(!(!currenItem || this._nSelectedIndex < 0))
            {
               if(currenItem.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,true);
               }
               else
               {
                  this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,false);
               }
               currenItem.data = this._dataProvider[currenItem.index];
            }
         }
         this.finalize();
      }
      
      public function get selectedSlot() : DisplayObject
      {
         var currentItem:GridItem = null;
         if(this._items == null || this._nSelectedIndex < 0 || this._nSelectedIndex >= this.dataProvider.length)
         {
            return null;
         }
         for(var i:uint = 0; i < this._items.length; i++)
         {
            currentItem = this._items[i];
            if(currentItem.data == this.selectedItem)
            {
               return currentItem.container;
            }
         }
         return null;
      }
      
      public function get slots() : Array
      {
         if(this._items == null || this.dataProvider.length == 0)
         {
            return new Array();
         }
         var slots:Array = new Array();
         for(var i:uint = 0; i < this._items.length; i++)
         {
            if(this._items[i])
            {
               slots.push(this._items[i].container);
            }
         }
         return slots;
      }
      
      public function get items() : Vector.<GridItem>
      {
         return this._items;
      }
      
      public function get firstItemDisplayedIndex() : Number
      {
         return this._pageYOffset * this._slotByRow + this._pageXOffset * this._slotByCol;
      }
      
      override public function remove() : void
      {
         var currentItem:GridItem = null;
         var i:uint = 0;
         if(!__removed)
         {
            if(this._renderer)
            {
               for(i = 0; i < this._items.length; i++)
               {
                  currentItem = this._items[i];
                  this._renderer.remove(currentItem.container);
               }
               this._renderer.destroy();
            }
            this._items = null;
            if(this._scrollBarH)
            {
               this._scrollBarH.removeEventListener(Event.CHANGE,this.onScroll);
            }
            if(this._scrollBarV)
            {
               this._scrollBarV.removeEventListener(Event.CHANGE,this.onScroll);
            }
         }
         super.remove();
      }
      
      public function removeItems() : void
      {
         var i:int = 0;
         if(this._renderer)
         {
            for(i = 0; i < this._items.length; i++)
            {
               this._renderer.remove(this._items[i].container);
            }
            this._items = new Vector.<GridItem>();
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function indexIsInvisibleSlot(index:uint) : Boolean
      {
         if(this._verticalScroll)
         {
            return index / this._totalSlotByRow - this._pageYOffset >= this._slotByCol + this.hiddenRow || index / this._totalSlotByRow - this._pageYOffset < 0 - this.hiddenRow;
         }
         return index % this._totalSlotByRow - this._pageXOffset >= this._slotByRow || index % this._totalSlotByRow - this._pageXOffset < 0;
      }
      
      public function moveTo(index:uint, force:Boolean = false) : void
      {
         if(this.indexIsInvisibleSlot(index) || force)
         {
            if(this._scrollBarV)
            {
               this._scrollBarV.value = Math.floor(index / this._totalSlotByRow);
               if(this._scrollBarV.value < 0)
               {
                  this.updateFromIndex(0);
               }
               else
               {
                  this.updateFromIndex(this._scrollBarV.value);
               }
            }
            else if(this._scrollBarH)
            {
               this._scrollBarH.value = index % this._totalSlotByRow;
               if(this._scrollBarH.value < 0)
               {
                  this.updateFromIndex(0);
               }
               else
               {
                  this.updateFromIndex(this._scrollBarH.value);
               }
            }
         }
      }
      
      public function getIndex() : uint
      {
         if(this._scrollBarV)
         {
            return Math.floor(this._scrollBarV.value * this._totalSlotByRow);
         }
         return 0;
      }
      
      public function sortOn(col:String, options:int = 0) : void
      {
         this._sortProperty = col;
         if(this._dataProvider is Array)
         {
            this._dataProvider.sortOn(col,options);
         }
         else if(this._dataProvider is Vector.<*>)
         {
            this._dataProvider.sort(function(param1:*, param2:*):int
            {
               if(!param1.hasOwnProperty(col) || !param2.hasOwnProperty(col))
               {
                  return 0;
               }
               var a:* = param1[col];
               var b:* = param2[col];
               if(a == null)
               {
                  return b == null ? 0 : -1;
               }
               if(options & Array.CASEINSENSITIVE && a is String)
               {
                  a = a.toLowerCase();
               }
               if(options & Array.CASEINSENSITIVE && b is String)
               {
                  b = b.toLowerCase();
               }
               var cmpRes:int = ObjectUtil.compare(a,b);
               if(options & Array.DESCENDING && cmpRes != 0)
               {
                  return -cmpRes;
               }
               return cmpRes;
            });
         }
         this.finalize();
         this.initSlot();
      }
      
      public function sortBy(sortFunction:Function) : void
      {
         this._dataProvider.sort(sortFunction);
         this.finalize();
         this.initSlot();
      }
      
      public function getItemIndex(item:*) : int
      {
         var res:GridItem = this.getGridItem(item);
         if(res)
         {
            return res.index;
         }
         return -1;
      }
      
      private function itemExists(o:*) : Boolean
      {
         var i:int = 0;
         var len:int = 0;
         var data:* = undefined;
         if(this._dataProvider)
         {
            len = this._dataProvider.length;
            for(i = 0; i < len; i++)
            {
               data = this._dataProvider[i];
               if(data === o)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function initSlot() : void
      {
         var item:GridItem = null;
         var j:int = 0;
         var i:int = 0;
         var slotX:Number = NaN;
         var slotY:Number = NaN;
         var totalSlot:uint = 0;
         if(this._items == null)
         {
            this._items = new Vector.<GridItem>();
         }
         var dataPos:int = 0;
         if(this._dataProvider.length && !this._autoPosition)
         {
            for(totalSlot = this._slotByCol * this._slotByRow; this._pageYOffset >= 0; )
            {
               while(this._pageXOffset >= 0)
               {
                  dataPos = this._pageXOffset * this._slotByCol + this._pageYOffset * this._slotByRow;
                  if(dataPos <= this._dataProvider.length - totalSlot)
                  {
                     break;
                  }
                  --this._pageXOffset;
               }
               if(dataPos <= this._dataProvider.length - totalSlot)
               {
                  break;
               }
               this._pageXOffset = 0;
               --this._pageYOffset;
            }
            if(this._pageYOffset < 0)
            {
               this._pageYOffset = 0;
            }
            if(this._pageXOffset < 0)
            {
               this._pageXOffset = 0;
            }
            if(this._scrollBarH && this._scrollBarH.visible)
            {
               this._scrollBarH.value = this._pageXOffset;
            }
            if(this._scrollBarV && this._scrollBarV.visible)
            {
               this._scrollBarV.value = this._pageYOffset;
            }
         }
         var slotIndex:uint = 0;
         if(!this._verticalScroll)
         {
            for(j = -this._hiddenCol; j < this._slotByRow + this._hiddenCol; j++)
            {
               for(i = -this._hiddenRow; i < this._slotByCol + this._hiddenRow; i++)
               {
                  dataPos = i + this._pageYOffset * this._slotByRow + j * this._totalSlotByCol + this._pageXOffset * this._slotByCol;
                  if(this._isStaticGap)
                  {
                     slotX = j * this._slotWidth + j * this._staticGap;
                     slotY = i * this._slotHeight + i * this._staticGap;
                  }
                  else
                  {
                     slotX = j * this._slotWidth + j * (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow;
                     slotY = i * this._slotHeight + i * (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol;
                  }
                  this.createOrUpdateSlotAtIndex(slotIndex,dataPos,slotX,slotY);
                  slotIndex++;
               }
            }
         }
         else
         {
            for(j = -this._hiddenRow; j < this._slotByCol + this._hiddenRow; j++)
            {
               for(i = -this._hiddenCol; i < this._slotByRow + this._hiddenCol; i++)
               {
                  dataPos = i + this._pageXOffset * this._slotByCol + j * this._totalSlotByRow + this._pageYOffset * this._slotByRow;
                  if(this._isStaticGap)
                  {
                     slotX = i * this._slotWidth + i * this._staticGap;
                     slotY = j * this._slotHeight + j * this._staticGap;
                  }
                  else
                  {
                     slotX = i * this._slotWidth + i * (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow;
                     slotY = j * this._slotHeight + j * (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol;
                  }
                  this.createOrUpdateSlotAtIndex(slotIndex,dataPos,slotX,slotY);
                  slotIndex++;
               }
            }
         }
         while(this._items.length > slotIndex)
         {
            item = this._items.pop();
            this._renderer.remove(item.container);
            if(item.container.parent)
            {
               item.container.parent.removeChild(item.container);
            }
         }
         if(this._autoSelect == AUTOSELECT_BY_INDEX)
         {
            if(this._nSelectedItem && this.itemExists(this._nSelectedItem.object) && this._verticalScroll && this._scrollBarV && this._scrollBarV.value >= 0)
            {
               this.updateFromIndex(this._scrollBarV.value);
            }
            else
            {
               this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
            }
         }
         else if(this._autoSelect == AUTOSELECT_BY_ITEM)
         {
            if(this._nSelectedItem)
            {
               this.selectedItem = this._nSelectedItem.object;
               if(this.selectedItem != this._nSelectedItem.object)
               {
                  this._nSelectedItem = null;
               }
            }
         }
      }
      
      private function createOrUpdateSlotAtIndex(index:int, indexData:int, slotX:Number, slotY:Number) : void
      {
         var slot:DisplayObject = null;
         var item:GridItem = null;
         var isSelected:Boolean = this._nSelectedIndex == indexData && this._autoSelect > 0 && this._dataProvider.length > 0 && indexData < this._dataProvider.length && this._dataProvider[indexData] != null;
         if(this._items.length > index)
         {
            item = this._items[index];
            item.index = indexData;
            slot = item.container;
            if(this._dataProvider.length > indexData)
            {
               item.data = this._dataProvider[indexData];
               this._renderer.update(this._dataProvider[indexData],indexData,item.container,isSelected);
            }
            else
            {
               item.data = null;
               this._renderer.update(null,indexData,item.container,isSelected);
            }
         }
         else
         {
            if(this._dataProvider.length > indexData)
            {
               slot = this._renderer.render(this._dataProvider[indexData],indexData,isSelected);
            }
            else
            {
               slot = this._renderer.render(null,indexData,isSelected);
            }
            if(indexData < this._dataProvider.length)
            {
               this._items.push(new GridItem(indexData,slot,this._dataProvider[indexData]));
            }
            else
            {
               this._items.push(new GridItem(indexData,slot,null));
            }
         }
         slot.x = slotX;
         slot.y = slotY;
         addChildAt(slot,0);
      }
      
      private function updateFromIndex(newIndex:uint) : void
      {
         var i:int = 0;
         var j:int = 0;
         var currentItem:GridItem = null;
         var currIndex:uint = 0;
         var pos:int = 0;
         var diff:int = newIndex - (!!this._verticalScroll ? this._pageYOffset : this._pageXOffset);
         if(!diff)
         {
            return;
         }
         if(this._verticalScroll)
         {
            this._pageYOffset = newIndex;
         }
         else
         {
            this._pageXOffset = newIndex;
         }
         var aAvaibleSlot:Array = new Array();
         var aOkSlot:Array = new Array();
         var nAvaible:uint = 0;
         for(i = 0; i < this._items.length; i++)
         {
            currentItem = this._items[i];
            if(this._forceRefresh || this.indexIsInvisibleSlot(currentItem.index))
            {
               aAvaibleSlot.push(currentItem);
               nAvaible++;
            }
            else
            {
               aOkSlot[currentItem.index] = currentItem;
            }
         }
         for(j = -this._hiddenRow; j < this._slotByCol + this._hiddenRow; j++)
         {
            for(i = -this._hiddenCol; i < this._slotByRow + this._hiddenCol; i++)
            {
               pos = this._totalSlotByRow * j + i + this._pageXOffset;
               currIndex = pos + this._pageYOffset * this._totalSlotByRow;
               currentItem = aOkSlot[currIndex];
               if(!currentItem)
               {
                  currentItem = aAvaibleSlot.shift();
                  currentItem.index = currIndex;
                  if(currIndex < this._dataProvider.length)
                  {
                     currentItem.data = this._dataProvider[currIndex];
                  }
                  else
                  {
                     currentItem.data = null;
                  }
                  if(this._dataProvider.length > currIndex)
                  {
                     this._renderer.update(this._dataProvider[currIndex],currIndex,currentItem.container,currIndex == this._nSelectedIndex);
                  }
                  else
                  {
                     this._renderer.update(null,currIndex,currentItem.container,currIndex == this._nSelectedIndex);
                  }
               }
               if(this._verticalScroll)
               {
                  currentItem.container.y = Math.floor(currentItem.index / this._totalSlotByRow - newIndex) * (this._slotHeight + (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol);
               }
               else
               {
                  currentItem.container.x = Math.floor(currentItem.index % this._totalSlotByRow - newIndex) * (this._slotWidth + (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow);
               }
            }
         }
      }
      
      public function setSelectedIndex(index:int, method:uint) : void
      {
         var lastIndex:int = 0;
         var currenItem:GridItem = null;
         var iDes:* = undefined;
         if(this._allowLastToFirst)
         {
            if(index >= this._dataProvider.length)
            {
               index = 0;
            }
            if(index < 0)
            {
               index = this._dataProvider.length - 1;
            }
         }
         if(method != SelectMethodEnum.MANUAL && index < 0 || index >= this._dataProvider.length)
         {
            return;
         }
         if(index < 0)
         {
            lastIndex = this._nSelectedIndex;
            this._nSelectedIndex = index;
            if(index >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[index]);
            }
            for each(iDes in this._items)
            {
               if(iDes.index == lastIndex && lastIndex < this._dataProvider.length)
               {
                  this._renderer.update(this._dataProvider[lastIndex],lastIndex,iDes.container,false);
               }
            }
            this.dispatchMessage(new SelectItemMessage(this,method,lastIndex != this._nSelectedIndex));
         }
         else
         {
            if(this._nSelectedIndex > 0)
            {
               lastIndex = this._nSelectedIndex;
            }
            this._nSelectedIndex = index;
            if(index >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[index]);
            }
            for(index = 0; index < this._items.length; index++)
            {
               currenItem = this._items[index];
               if(currenItem.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[this._nSelectedIndex],this._nSelectedIndex,currenItem.container,true);
               }
               else if(currenItem.index == lastIndex)
               {
                  if(lastIndex < this._dataProvider.length)
                  {
                     this._renderer.update(this._dataProvider[lastIndex],lastIndex,currenItem.container,false);
                  }
                  else
                  {
                     this._renderer.update(null,lastIndex,currenItem.container,false);
                  }
               }
            }
            this.afterIndexSelection(lastIndex,method);
         }
      }
      
      protected function afterIndexSelection(lastIndex:int, method:uint) : void
      {
         this.moveTo(this._nSelectedIndex,this is ComboBoxGrid);
         if(this.selectWithArrows || method == SelectMethodEnum.CLICK || !(method == SelectMethodEnum.DOWN_ARROW || method == SelectMethodEnum.UP_ARROW))
         {
            this.dispatchMessage(new SelectItemMessage(this,method,lastIndex != this._nSelectedIndex));
         }
      }
      
      private function configVar() : void
      {
         var useScrollBar:Boolean = false;
         if(this._autoPosition)
         {
            this._pageXOffset = 0;
            this._pageYOffset = 0;
         }
         for(var i:uint = 0; i < 2; i++)
         {
            useScrollBar = i && this._displayScrollbar == "auto" && (this._totalSlotByCol * this._slotHeight > height || this._totalSlotByRow * this._slotWidth > width) || this._displayScrollbar == "always";
            this._avaibleSpaceX = width - (this._verticalScroll && useScrollBar ? this._scrollBarSize + this._scrollbarOffset : 0);
            this._avaibleSpaceY = height - (!this._verticalScroll && useScrollBar ? this._scrollBarSize + this._scrollbarOffset : 0);
            if(this._avaibleSpaceX < 0)
            {
               this._avaibleSpaceX = 0;
            }
            if(this._avaibleSpaceY < 0)
            {
               this._avaibleSpaceY = 0;
            }
            this._slotByRow = Math.floor(this._avaibleSpaceX / (this._slotWidth + this._hPadding));
            this._slotByCol = Math.floor(this._avaibleSpaceY / (this._slotHeight + this._vPadding));
            if(this._slotByRow <= 0)
            {
               this._slotByRow = 1;
            }
            if(this._slotByCol <= 0)
            {
               this._slotByCol = 1;
            }
            if(this._verticalScroll)
            {
               this._totalSlotByRow = this._slotByRow;
               this._totalSlotByCol = Math.ceil(this._dataProvider.length / this._slotByRow);
            }
            else
            {
               this._totalSlotByCol = this._slotByCol;
               this._totalSlotByRow = Math.ceil(this._dataProvider.length / this._slotByCol);
            }
         }
      }
      
      private function isIterable(obj:*) : Boolean
      {
         if(obj is Array)
         {
            return true;
         }
         if(obj is Vector.<*>)
         {
            return true;
         }
         if(!obj)
         {
            return false;
         }
         if(obj["length"] != null && obj["length"] != 0 && !isNaN(obj["length"]) && obj[0] != null && !(obj is String))
         {
            return true;
         }
         return false;
      }
      
      protected function getGridItem(item:DisplayObject) : GridItem
      {
         var currentItem:GridItem = null;
         if(!this._items)
         {
            return null;
         }
         var currentDo:DisplayObject = item;
         while(currentDo && currentDo.parent != this)
         {
            currentDo = currentDo.parent;
         }
         for(var i:uint = 0; i < this._items.length; i++)
         {
            currentItem = this._items[i];
            if(currentItem.container === currentDo)
            {
               return currentItem;
            }
         }
         return null;
      }
      
      private function getNearestSlot(mouseEvent:MouseEvent) : Slot
      {
         var nextSlotIndexX:int = 0;
         var nextSlot:Slot = null;
         var nextDiffX:Number = NaN;
         var nextDiffY:Number = NaN;
         var index:int = 0;
         var mouseEventX:Number = mouseEvent.localX;
         var mouseEventY:Number = mouseEvent.localY;
         var currentSlotIndexX:int = 0;
         var currentSlot:Slot = Slot(GridItem(this._items[0]).container);
         var currentDiffX:Number = Math.abs(mouseEventX - (currentSlot.x + this.slotWidth));
         var currentDiffY:Number = Math.abs(mouseEventY - (currentSlot.y + this.slotHeight));
         var xLimit:int = Math.max(1,this.slotByRow - 1);
         var yLimit:int = Math.max(1,this.slotByCol - 1);
         for(var x:int = 1; x <= xLimit; x += 1)
         {
            nextSlotIndexX = GridItem(this._items[x]).index;
            nextSlot = Slot(GridItem(this._items[x]).container);
            nextDiffX = Math.abs(mouseEventX - nextSlot.x);
            if(nextDiffX >= currentDiffX)
            {
               break;
            }
            currentSlotIndexX = nextSlotIndexX;
            currentSlot = nextSlot;
            currentDiffX = Math.abs(mouseEventX - (currentSlot.x + this.slotWidth));
         }
         for(var y:int = 1; y <= yLimit; y += 1)
         {
            index = currentSlotIndexX + y * this.slotByRow;
            if(index >= this._items.length)
            {
               break;
            }
            nextSlot = Slot(GridItem(this._items[index]).container);
            nextDiffY = Math.abs(mouseEventY - nextSlot.y);
            if(nextDiffY >= currentDiffY)
            {
               break;
            }
            currentSlot = nextSlot;
            currentDiffY = Math.abs(mouseEventY - (currentSlot.y + this.slotHeight));
         }
         return currentSlot;
      }
      
      protected function onScroll(e:Event) : void
      {
         var i:int = 0;
         if(this._scrollBarV && this._scrollBarV.visible)
         {
            i = this._scrollBarV.value;
         }
         if(this._scrollBarH && this._scrollBarH.visible)
         {
            i = this._scrollBarH.value;
         }
         if(!isNaN(i))
         {
            this.updateFromIndex(i);
         }
      }
      
      private function onListWheel(e:MouseEvent) : void
      {
         if(this._verticalScroll)
         {
            if(this._scrollBarV && this._scrollBarV.visible)
            {
               this._scrollBarV.onWheel(e);
            }
            else
            {
               this.moveTo(this._pageYOffset + e.delta);
            }
         }
         else if(this._scrollBarH && this._scrollBarH.visible)
         {
            this._scrollBarH.onWheel(e);
         }
         else
         {
            this.moveTo(this._pageXOffset + e.delta);
         }
      }
      
      override public function process(msg:Message) : Boolean
      {
         var currentItem:GridItem = null;
         var mrcm:MouseRightClickMessage = null;
         var mom:MouseOverMessage = null;
         var mom2:MouseOutMessage = null;
         var scrollIndex:int = 0;
         var mmsg:MouseMessage = null;
         var mummsg:MouseUpMessage = null;
         var kdmsg:KeyboardKeyDownMessage = null;
         var newIndex:int = 0;
         var method:int = 0;
         var p:PoolablePoint = null;
         var i:int = 0;
         switch(true)
         {
            case msg is MouseRightClickMessage:
               mrcm = msg as MouseRightClickMessage;
               currentItem = this.getGridItem(mrcm.target);
               if(currentItem)
               {
                  if(UIEventManager.getInstance().isRegisteredInstance(this,ItemRightClickMessage))
                  {
                     this.dispatchMessage(new ItemRightClickMessage(this,currentItem));
                  }
               }
               break;
            case msg is MouseOverMessage:
               mom = msg as MouseOverMessage;
               currentItem = this.getGridItem(mom.target);
               if(currentItem)
               {
                  if(UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage) || parent && parent is ComboBox)
                  {
                     if(parent && parent is ComboBox)
                     {
                        this.dispatchMessage(new ItemRollOverMessage(parent as ComboBox,currentItem));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOverMessage(this,currentItem));
                     }
                  }
               }
               break;
            case msg is MouseOutMessage:
               mom2 = msg as MouseOutMessage;
               currentItem = this.getGridItem(mom2.target);
               if(currentItem)
               {
                  if(UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage) || parent && parent is ComboBox)
                  {
                     if(parent && parent is ComboBox)
                     {
                        this.dispatchMessage(new ItemRollOutMessage(parent as ComboBox,currentItem));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOutMessage(this,currentItem));
                     }
                  }
               }
               break;
            case msg is MouseWheelMessage:
               if(this._scrollBarH)
               {
                  scrollIndex = this._scrollBarH.value;
               }
               if(this._scrollBarV)
               {
                  scrollIndex = this._scrollBarV.value;
               }
               this.onListWheel(MouseWheelMessage(msg).mouseEvent);
               if(this._scrollBarH && this._scrollBarH.value != scrollIndex || this._scrollBarV && this._scrollBarV.value != scrollIndex)
               {
                  MouseWheelMessage(msg).canceled = true;
                  return true;
               }
               break;
            case msg is MouseDoubleClickMessage:
            case msg is MouseClickMessage:
               if(!this.mouseClickEnabled)
               {
                  return true;
               }
               mmsg = MouseMessage(msg);
               if(mmsg.target == this)
               {
                  p = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
                  for(i = 0; i < this._items.length; i++)
                  {
                     if(this._items[i].container.getBounds(StageShareManager.stage).containsPoint(p.renew(mmsg.mouseEvent.stageX,mmsg.mouseEvent.stageY)))
                     {
                        currentItem = this._items[i];
                        break;
                     }
                  }
                  PoolsManager.getInstance().getPointPool().checkIn(p);
               }
               else
               {
                  currentItem = this.getGridItem(mmsg.target);
               }
               if(currentItem)
               {
                  if(!(msg is MouseClickMessage))
                  {
                     if(KeyPoll.getInstance().isDown(Keyboard.CONTROL) == true || KeyPoll.getInstance().isDown(15) == true)
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.CTRL_DOUBLE_CLICK);
                     }
                     else if(KeyPoll.getInstance().isDown(Keyboard["ALTERNATE"]) == true)
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.ALT_DOUBLE_CLICK);
                     }
                     else
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.DOUBLE_CLICK);
                     }
                     return true;
                  }
                  if(!currentItem.data)
                  {
                     if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
                     {
                        this.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
                     }
                     this.setSelectedIndex(-1,SelectMethodEnum.CLICK);
                  }
                  this.setSelectedIndex(currentItem.index,SelectMethodEnum.CLICK);
               }
               break;
            case msg is MouseUpMessage:
               mummsg = MouseUpMessage(msg);
               currentItem = this.getGridItem(mummsg.target);
               if(this._items && this._items.length > 0 && this._items[0] is GridItem && GridItem(this._items[0]).container is Slot && !currentItem)
               {
                  if(this._items.length > 1 && this._items[1] && this._items[1] is GridItem)
                  {
                     this.dispatchMessage(mummsg,this.getNearestSlot(mummsg.mouseEvent));
                  }
                  else
                  {
                     this.dispatchMessage(mummsg,GridItem(this._items[0]).container as Slot);
                  }
               }
               break;
            case msg is KeyboardKeyDownMessage:
               kdmsg = msg as KeyboardKeyDownMessage;
               method = -1;
               switch(kdmsg.keyboardEvent.keyCode)
               {
                  case Keyboard.UP:
                     if(kdmsg.target.hasEventListener(KeyboardEvent.KEY_UP))
                     {
                        return true;
                     }
                     newIndex = this.selectedIndex - this._totalSlotByRow;
                     method = SelectMethodEnum.UP_ARROW;
                     break;
                  case Keyboard.DOWN:
                     if(kdmsg.target.hasEventListener(KeyboardEvent.KEY_DOWN))
                     {
                        return true;
                     }
                     newIndex = this.selectedIndex + this._totalSlotByRow;
                     method = SelectMethodEnum.DOWN_ARROW;
                     break;
                  case Keyboard.RIGHT:
                     if(this._useLeftRightToSelect)
                     {
                        newIndex = this.selectedIndex + 1;
                        method = SelectMethodEnum.RIGHT_ARROW;
                     }
                     break;
                  case Keyboard.LEFT:
                     if(this._useLeftRightToSelect)
                     {
                        newIndex = this.selectedIndex - 1;
                        method = SelectMethodEnum.LEFT_ARROW;
                     }
                     break;
                  case Keyboard.PAGE_DOWN:
                     if(this._scrollBarV)
                     {
                        this._scrollBarV.value += this._slotByCol - 1;
                        this.onScroll(null);
                        return true;
                     }
                     break;
                  case Keyboard.PAGE_UP:
                     if(this._scrollBarV)
                     {
                        this._scrollBarV.value -= this._slotByCol - 1;
                        this.onScroll(null);
                        return true;
                     }
                     break;
                  case Keyboard.ENTER:
                  case Keyboard.NUMPAD_ENTER:
                     this.onEnter();
               }
               if(method != -1)
               {
                  if(this.keyboardIndexHandler != null)
                  {
                     newIndex = this.keyboardIndexHandler(this.selectedIndex,newIndex);
                  }
                  this.setSelectedIndex(newIndex,method);
                  this.moveTo(this.selectedIndex);
                  return true;
               }
               break;
         }
         return false;
      }
      
      protected function onEnter() : void
      {
         if(this.selectWithArrows)
         {
            return;
         }
         this.moveTo(this._nSelectedIndex,this is ComboBoxGrid);
         this.dispatchMessage(new SelectItemMessage(this,0,false));
      }
      
      protected function dispatchMessage(msg:Message, handler:MessageHandler = null) : void
      {
         if(!this.silent)
         {
            if(!handler)
            {
               handler = Berilia.getInstance().handler;
            }
            handler.process(msg);
         }
      }
   }
}
