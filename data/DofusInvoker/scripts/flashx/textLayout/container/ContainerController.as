package flashx.textLayout.container
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IMEEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuClipboardItems;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flashx.textLayout.compose.FloatCompositionData;
   import flashx.textLayout.compose.FlowDamageType;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.compose.TextFlowTableBlock;
   import flashx.textLayout.compose.TextLineRecycler;
   import flashx.textLayout.edit.EditingMode;
   import flashx.textLayout.edit.IInteractionEventHandler;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.edit.SelectionFormat;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.elements.CellCoordinates;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.FlowValueHolder;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TableBlockContainer;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.events.FlowElementMouseEventManager;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.events.ScrollEvent;
   import flashx.textLayout.events.ScrollEventDirection;
   import flashx.textLayout.events.TextLayoutEvent;
   import flashx.textLayout.events.UpdateCompleteEvent;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class ContainerController implements IInteractionEventHandler, ITextLayoutFormat, ISandboxSupport
   {
      
      tlf_internal static var usesDiscretionaryHyphens:Boolean = true;
      
      private static var _containerControllerInitialFormat:ITextLayoutFormat = createContainerControllerInitialFormat();
      
      private static var scratchRectangle:Rectangle = new Rectangle();
       
      
      private var _textFlowCache:TextFlow;
      
      private var _rootElement:ContainerFormattedElement;
      
      private var _absoluteStart:int;
      
      private var _textLength:int;
      
      private var _container:Sprite;
      
      private var _mouseEventManager:FlowElementMouseEventManager;
      
      protected var _computedFormat:TextLayoutFormat;
      
      private var _columnState:ColumnState;
      
      private var _compositionWidth:Number = 0;
      
      private var _compositionHeight:Number = 0;
      
      private var _measureWidth:Boolean;
      
      private var _measureHeight:Boolean;
      
      private var _contentLeft:Number;
      
      private var _contentTop:Number;
      
      private var _contentWidth:Number;
      
      private var _contentHeight:Number;
      
      private var _uncomposedTextLength:int;
      
      private var _finalParcelStart:int;
      
      private var _horizontalScrollPolicy:String;
      
      private var _verticalScrollPolicy:String;
      
      private var _xScroll:Number;
      
      private var _yScroll:Number;
      
      private var _minListenersAttached:Boolean = false;
      
      private var _allListenersAttached:Boolean = false;
      
      private var _selectListenersAttached:Boolean = false;
      
      tlf_internal var _mouseWheelListenerAttached:Boolean = false;
      
      private var _shapesInvalid:Boolean = false;
      
      private var _backgroundShape:Shape;
      
      private var _scrollTimer:Timer = null;
      
      protected var _hasScrollRect:Boolean;
      
      private var _linesInView:Array;
      
      private var _updateStart:int;
      
      private var _tableBlocksInView:Array;
      
      private var _composedFloats:Array;
      
      private var _floatsInContainer:Array;
      
      private var _interactiveObjects:Dictionary;
      
      private var _oldInteractiveObjects:Array;
      
      private var _shapeChildren:Array;
      
      private var _format:FlowValueHolder;
      
      private var _containerRoot:DisplayObject;
      
      private var _transparentBGX:Number;
      
      private var _transparentBGY:Number;
      
      private var _transparentBGWidth:Number;
      
      private var _transparentBGHeight:Number;
      
      private var blinkTimer:Timer;
      
      private var blinkObject:DisplayObject;
      
      private var _selectionSprite:Sprite;
      
      public function ContainerController(container:Sprite, compositionWidth:Number = 100, compositionHeight:Number = 100)
      {
         this._interactiveObjects = new Dictionary(true);
         this._oldInteractiveObjects = new Array();
         super();
         this.initialize(container,compositionWidth,compositionHeight);
      }
      
      private static function pinValue(value:Number, minimum:Number, maximum:Number) : Number
      {
         return Math.min(Math.max(value,minimum),maximum);
      }
      
      tlf_internal static function createDefaultContextMenu() : ContextMenu
      {
         var contextMenu:ContextMenu = new ContextMenu();
         contextMenu.clipboardMenu = true;
         contextMenu.clipboardItems.clear = true;
         contextMenu.clipboardItems.copy = true;
         contextMenu.clipboardItems.cut = true;
         contextMenu.clipboardItems.paste = true;
         contextMenu.clipboardItems.selectAll = true;
         return contextMenu;
      }
      
      private static function createContainerControllerInitialFormat() : ITextLayoutFormat
      {
         var ccif:TextLayoutFormat = new TextLayoutFormat();
         ccif.columnCount = FormatValue.INHERIT;
         ccif.columnGap = FormatValue.INHERIT;
         ccif.columnWidth = FormatValue.INHERIT;
         ccif.verticalAlign = FormatValue.INHERIT;
         return ccif;
      }
      
      public static function get containerControllerInitialFormat() : ITextLayoutFormat
      {
         return _containerControllerInitialFormat;
      }
      
      public static function set containerControllerInitialFormat(val:ITextLayoutFormat) : void
      {
         _containerControllerInitialFormat = val;
      }
      
      tlf_internal function get allListenersAttached() : Boolean
      {
         return this._allListenersAttached;
      }
      
      tlf_internal function get interactiveObjects() : Dictionary
      {
         return this._interactiveObjects;
      }
      
      tlf_internal function get oldInteractiveObjects() : Array
      {
         return this._oldInteractiveObjects;
      }
      
      tlf_internal function get hasScrollRect() : Boolean
      {
         return this._hasScrollRect;
      }
      
      private function initialize(container:Sprite, compositionWidth:Number, compositionHeight:Number) : void
      {
         this._container = container;
         this._containerRoot = null;
         this._textLength = 0;
         this._absoluteStart = -1;
         this._columnState = new ColumnState(null,null,null,0,0);
         this._xScroll = this._yScroll = 0;
         this._contentWidth = this._contentHeight = 0;
         this._uncomposedTextLength = 0;
         this._container.doubleClickEnabled = true;
         this._horizontalScrollPolicy = this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
         this._hasScrollRect = false;
         this._shapeChildren = [];
         this._linesInView = [];
         this._tableBlocksInView = [];
         this.setCompositionSize(compositionWidth,compositionHeight);
         this.format = _containerControllerInitialFormat;
      }
      
      tlf_internal function get effectiveBlockProgression() : String
      {
         return !!this._rootElement ? this._rootElement.computedFormat.blockProgression : BlockProgression.TB;
      }
      
      tlf_internal function getContainerRoot() : DisplayObject
      {
         var x:int = 0;
         if(this._containerRoot == null && this._container && this._container.stage)
         {
            try
            {
               x = this._container.stage.numChildren;
               this._containerRoot = this._container.stage;
            }
            catch(e:Error)
            {
               _containerRoot = _container.root;
            }
         }
         return this._containerRoot;
      }
      
      public function get flowComposer() : IFlowComposer
      {
         return !!this.textFlow ? this.textFlow.flowComposer : null;
      }
      
      tlf_internal function get shapesInvalid() : Boolean
      {
         return this._shapesInvalid;
      }
      
      tlf_internal function set shapesInvalid(val:Boolean) : void
      {
         this._shapesInvalid = val;
      }
      
      public function get columnState() : ColumnState
      {
         if(this._rootElement == null)
         {
            return null;
         }
         if(this._computedFormat == null)
         {
            this.computedFormat;
         }
         this._columnState.computeColumns();
         return this._columnState;
      }
      
      public function get container() : Sprite
      {
         return this._container;
      }
      
      public function get compositionWidth() : Number
      {
         return this._compositionWidth;
      }
      
      public function get compositionHeight() : Number
      {
         return this._compositionHeight;
      }
      
      tlf_internal function get measureWidth() : Boolean
      {
         return this._measureWidth;
      }
      
      tlf_internal function get measureHeight() : Boolean
      {
         return this._measureHeight;
      }
      
      public function setCompositionSize(w:Number, h:Number) : void
      {
         var widthChanged:* = !(this._compositionWidth == w || isNaN(this._compositionWidth) && isNaN(w));
         var heightChanged:* = !(this._compositionHeight == h || isNaN(this._compositionHeight) && isNaN(h));
         if(widthChanged || heightChanged)
         {
            this._compositionHeight = h;
            this._measureHeight = isNaN(this._compositionHeight);
            this._compositionWidth = w;
            this._measureWidth = isNaN(this._compositionWidth);
            if(this._computedFormat)
            {
               this.resetColumnState();
            }
            if(this.effectiveBlockProgression == BlockProgression.TB ? Boolean(widthChanged) : Boolean(heightChanged))
            {
               if(this.textFlow && this._textLength)
               {
                  this.textFlow.damage(this.absoluteStart,this._textLength,TextLineValidity.INVALID,false);
               }
            }
            else
            {
               this.invalidateContents();
            }
            this.attachTransparentBackgroundForHit(false);
         }
      }
      
      public function get textFlow() : TextFlow
      {
         if(!this._textFlowCache && this._rootElement)
         {
            this._textFlowCache = this._rootElement.getTextFlow();
         }
         return this._textFlowCache;
      }
      
      public function get rootElement() : ContainerFormattedElement
      {
         return this._rootElement;
      }
      
      tlf_internal function setRootElement(value:ContainerFormattedElement) : void
      {
         if(this._rootElement != value)
         {
            if(this._mouseEventManager)
            {
               this._mouseEventManager.stopHitTests();
            }
            if(!value)
            {
               this._mouseEventManager = null;
            }
            else if(!this._mouseEventManager)
            {
               this._mouseEventManager = new FlowElementMouseEventManager(this.container,null);
            }
            this.clearCompositionResults();
            this.detachContainer();
            this._rootElement = value;
            this._textFlowCache = null;
            this._textLength = 0;
            this._absoluteStart = -1;
            this.attachContainer();
            if(this._rootElement)
            {
               this.formatChanged();
            }
            if(Configuration.playerEnablesSpicyFeatures)
            {
               this._container["needsSoftKeyboard"] = this.interactionManager && this.interactionManager.editingMode == EditingMode.READ_WRITE;
            }
         }
      }
      
      public function get interactionManager() : ISelectionManager
      {
         return !!this.textFlow ? this.textFlow.interactionManager : null;
      }
      
      tlf_internal function get uncomposedTextLength() : int
      {
         return this._uncomposedTextLength;
      }
      
      tlf_internal function get finalParcelStart() : int
      {
         return this._finalParcelStart;
      }
      
      tlf_internal function set finalParcelStart(val:int) : void
      {
         this._finalParcelStart = val;
      }
      
      public function get absoluteStart() : int
      {
         var stopIdx:int = 0;
         var prevController:ContainerController = null;
         if(this._absoluteStart != -1)
         {
            return this._absoluteStart;
         }
         var rslt:int = 0;
         var composer:IFlowComposer = this.flowComposer;
         if(composer)
         {
            stopIdx = composer.getControllerIndex(this);
            if(stopIdx != 0)
            {
               prevController = composer.getControllerAt(stopIdx - 1);
               rslt = prevController.absoluteStart + prevController.textLength;
            }
         }
         this._absoluteStart = rslt;
         return rslt;
      }
      
      public function get textLength() : int
      {
         return this._textLength;
      }
      
      tlf_internal function setTextLengthOnly(numChars:int) : void
      {
         var composer:IFlowComposer = null;
         var idx:int = 0;
         var controller:ContainerController = null;
         if(this._textLength != numChars)
         {
            this._textLength = numChars;
            this._uncomposedTextLength = 0;
            if(this._absoluteStart != -1)
            {
               composer = this.flowComposer;
               if(composer)
               {
                  idx = composer.getControllerIndex(this) + 1;
                  while(idx < this.flowComposer.numControllers)
                  {
                     controller = composer.getControllerAt(idx++);
                     if(controller._absoluteStart == -1)
                     {
                        break;
                     }
                     controller._absoluteStart = -1;
                     controller._uncomposedTextLength = 0;
                  }
               }
            }
         }
      }
      
      tlf_internal function setTextLength(numChars:int) : void
      {
         var verticalText:* = false;
         var flowComposer:IFlowComposer = null;
         var containerAbsoluteStart:int = 0;
         var uncomposedTextLength:int = 0;
         if(this.textFlow)
         {
            verticalText = this.effectiveBlockProgression == BlockProgression.RL;
            flowComposer = this.textFlow.flowComposer;
            if(numChars != 0 && flowComposer.getControllerIndex(this) == flowComposer.numControllers - 1 && (!verticalText && this._verticalScrollPolicy != ScrollPolicy.OFF || verticalText && this._horizontalScrollPolicy != ScrollPolicy.OFF))
            {
               containerAbsoluteStart = this.absoluteStart;
               uncomposedTextLength = this.textFlow.textLength - (numChars + containerAbsoluteStart);
               numChars = this.textFlow.textLength - containerAbsoluteStart;
            }
         }
         this.setTextLengthOnly(numChars);
         this._uncomposedTextLength = uncomposedTextLength;
      }
      
      public function isDamaged() : Boolean
      {
         return this.flowComposer.isPotentiallyDamaged(this.absoluteStart + this._textLength);
      }
      
      tlf_internal function formatChanged() : void
      {
         this._computedFormat = null;
         this.invalidateContents();
      }
      
      tlf_internal function styleSelectorChanged() : void
      {
         this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED,this,0,this._textLength);
         this._computedFormat = null;
      }
      
      tlf_internal function modelChanged(changeType:String, element:ContainerController, changeStart:int, changeLen:int, needNormalize:Boolean = true, bumpGeneration:Boolean = true) : void
      {
         var tf:TextFlow = this._rootElement.getTextFlow();
         if(tf)
         {
            tf.processModelChanged(changeType,element,this.absoluteStart + changeStart,changeLen,needNormalize,bumpGeneration);
         }
      }
      
      tlf_internal function gatherVisibleLines(wmode:String, createShape:Boolean) : void
      {
         var width:Number = NaN;
         var height:Number = NaN;
         var adjustX:Number = NaN;
         var adjustY:Number = NaN;
         var scrollAdjustXTW:int = 0;
         var scrollAdjustYTW:int = 0;
         var scrollAdjustWidthTW:int = 0;
         var scrollAdjustHeightTW:int = 0;
         var flowComposer:IFlowComposer = null;
         var firstLine:int = 0;
         var lastLine:int = 0;
         var curLine:TextFlowLine = null;
         var textLine:TextLine = null;
         var lineIndex:int = 0;
         var testRslt:* = undefined;
         var testPos:int = 0;
         var hi:int = 0;
         var mid:int = 0;
         var tempLine:TextFlowLine = null;
         if(this._textLength != 0)
         {
            width = !!this._measureWidth ? Number(this._contentWidth) : Number(this._compositionWidth);
            height = !!this._measureHeight ? Number(this._contentHeight) : Number(this._compositionHeight);
            adjustX = wmode == BlockProgression.RL ? Number(this._xScroll - width) : Number(this._xScroll);
            adjustY = this._yScroll;
            scrollAdjustXTW = Twips.roundTo(adjustX);
            scrollAdjustYTW = Twips.roundTo(adjustY);
            scrollAdjustWidthTW = Twips.to(width);
            scrollAdjustHeightTW = Twips.to(height);
            flowComposer = this.flowComposer;
            firstLine = flowComposer.findLineIndexAtPosition(this.absoluteStart);
            lastLine = flowComposer.findLineIndexAtPosition(this.absoluteStart + this._textLength - 1);
            if(this.columnCount == 1)
            {
               testPos = firstLine;
               curLine = flowComposer.getLineAt(testPos++);
               while(curLine && curLine is TextFlowTableBlock)
               {
                  curLine = flowComposer.getLineAt(testPos++);
               }
               testRslt = this.testLineVisible(wmode,scrollAdjustXTW,scrollAdjustYTW,scrollAdjustWidthTW,scrollAdjustHeightTW,curLine,null);
               textLine = testRslt as TextLine;
               firstLine++;
               if(textLine)
               {
                  if(createShape)
                  {
                     curLine.createShape(wmode,textLine);
                  }
                  this._linesInView.push(textLine);
               }
               else
               {
                  hi = lastLine;
                  while(firstLine <= hi)
                  {
                     mid = (firstLine + hi) / 2;
                     curLine = flowComposer.getLineAt(mid);
                     testRslt = this.testLineVisible(wmode,scrollAdjustXTW,scrollAdjustYTW,scrollAdjustWidthTW,scrollAdjustHeightTW,curLine,null);
                     if(testRslt && testRslt is TextLine)
                     {
                        textLine = testRslt as TextLine;
                        tempLine = flowComposer.getLineAt(mid - 1);
                        if(!(this.testLineVisible(wmode,scrollAdjustXTW,scrollAdjustYTW,scrollAdjustWidthTW,scrollAdjustHeightTW,tempLine,null) is TextLine))
                        {
                           if(createShape)
                           {
                              curLine.createShape(wmode,textLine);
                           }
                           this._linesInView.push(textLine);
                           firstLine = mid + 1;
                           break;
                        }
                        testRslt = -1;
                     }
                     if(testRslt < 0 || testRslt == 2)
                     {
                        hi = mid - 1;
                     }
                     else
                     {
                        firstLine = mid + 1;
                     }
                  }
               }
               for(lineIndex = firstLine; lineIndex <= lastLine; lineIndex++)
               {
                  curLine = flowComposer.getLineAt(lineIndex);
                  testRslt = this.testLineVisible(wmode,scrollAdjustXTW,scrollAdjustYTW,scrollAdjustWidthTW,scrollAdjustHeightTW,curLine,null);
                  if(!(testRslt is TableBlockContainer))
                  {
                     textLine = testRslt as TextLine;
                     if(!textLine)
                     {
                        break;
                     }
                     if(createShape)
                     {
                        curLine.createShape(wmode,textLine);
                     }
                     this._linesInView.push(textLine);
                  }
               }
            }
            else
            {
               for(lineIndex = firstLine; lineIndex <= lastLine; lineIndex++)
               {
                  curLine = flowComposer.getLineAt(lineIndex);
                  if(!(curLine == null || curLine.controller != this))
                  {
                     textLine = this.oldTestLineVisible(wmode,scrollAdjustXTW,scrollAdjustYTW,scrollAdjustWidthTW,scrollAdjustHeightTW,curLine,null);
                     if(textLine)
                     {
                        if(createShape)
                        {
                           curLine.createShape(wmode,textLine);
                        }
                        this._linesInView.push(textLine);
                     }
                  }
               }
            }
         }
         this._updateStart = this.absoluteStart;
      }
      
      tlf_internal function fillShapeChildren() : void
      {
         var width:Number = NaN;
         var height:Number = NaN;
         var adjustX:Number = NaN;
         var adjustY:Number = NaN;
         var textLine:TextLine = null;
         if(this._textLength == 0)
         {
            return;
         }
         var wmode:String = this.effectiveBlockProgression;
         if(this._linesInView.length == 0)
         {
            this.gatherVisibleLines(wmode,true);
         }
         var adjustLines:Boolean = wmode == BlockProgression.RL && (this._horizontalScrollPolicy == ScrollPolicy.OFF && this._verticalScrollPolicy == ScrollPolicy.OFF);
         if(adjustLines)
         {
            width = !!this._measureWidth ? Number(this._contentWidth) : Number(this._compositionWidth);
            height = !!this._measureHeight ? Number(this._contentHeight) : Number(this._compositionHeight);
            adjustX = this._xScroll - width;
            adjustY = this._yScroll;
            if(adjustX != 0 || adjustY != 0)
            {
               for each(textLine in this._linesInView)
               {
                  if(textLine)
                  {
                     if(adjustLines)
                     {
                        textLine.x -= adjustX;
                        textLine.y -= adjustY;
                     }
                  }
               }
               this._contentLeft -= adjustX;
               this._contentTop -= adjustY;
            }
         }
      }
      
      public function get horizontalScrollPolicy() : String
      {
         return this._horizontalScrollPolicy;
      }
      
      public function set horizontalScrollPolicy(scrollPolicy:String) : void
      {
         var newScrollPolicy:String = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._horizontalScrollPolicy,scrollPolicy) as String;
         if(newScrollPolicy != this._horizontalScrollPolicy)
         {
            this._horizontalScrollPolicy = newScrollPolicy;
            if(this._horizontalScrollPolicy == ScrollPolicy.OFF)
            {
               this.horizontalScrollPosition = 0;
            }
            this.formatChanged();
         }
      }
      
      tlf_internal function checkScrollBounds() : void
      {
         var newHeight:Number = NaN;
         var visibleHeight:Number = NaN;
         var measuring:Boolean = false;
         var needToScroll:Boolean = false;
         if(this.effectiveBlockProgression == BlockProgression.RL)
         {
            newHeight = this._contentWidth;
            visibleHeight = this.compositionWidth;
            measuring = this._measureWidth;
         }
         else
         {
            newHeight = this._contentHeight;
            visibleHeight = this.compositionHeight;
            measuring = this._measureHeight;
         }
         if(this.textFlow && !this._minListenersAttached)
         {
            needToScroll = !measuring && newHeight > visibleHeight;
            if(needToScroll != this._mouseWheelListenerAttached)
            {
               if(this._mouseWheelListenerAttached)
               {
                  this.removeMouseWheelListener();
               }
               else
               {
                  this.addMouseWheelListener();
               }
            }
         }
      }
      
      public function get verticalScrollPolicy() : String
      {
         return this._verticalScrollPolicy;
      }
      
      public function set verticalScrollPolicy(scrollPolicy:String) : void
      {
         var newScrollPolicy:String = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._verticalScrollPolicy,scrollPolicy) as String;
         if(newScrollPolicy != this._verticalScrollPolicy)
         {
            this._verticalScrollPolicy = newScrollPolicy;
            if(this._verticalScrollPolicy == ScrollPolicy.OFF)
            {
               this.verticalScrollPosition = 0;
            }
            this.formatChanged();
         }
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._xScroll;
      }
      
      public function set horizontalScrollPosition(x:Number) : void
      {
         if(!this._rootElement)
         {
            return;
         }
         if(this._horizontalScrollPolicy == ScrollPolicy.OFF)
         {
            this._xScroll = 0;
            return;
         }
         var oldScroll:Number = this._xScroll;
         var newScroll:Number = this.computeHorizontalScrollPosition(x,true);
         if(newScroll != oldScroll)
         {
            this._shapesInvalid = true;
            this._xScroll = newScroll;
            this.updateForScroll(ScrollEventDirection.HORIZONTAL,newScroll - oldScroll);
         }
      }
      
      private function computeHorizontalScrollPosition(x:Number, okToCompose:Boolean) : Number
      {
         var wmode:String = this.effectiveBlockProgression;
         var curEstimatedWidth:Number = this.contentWidth;
         var newScroll:Number = 0;
         if(curEstimatedWidth > this._compositionWidth && !this._measureWidth)
         {
            if(wmode == BlockProgression.RL)
            {
               newScroll = pinValue(x,this._contentLeft + this._compositionWidth,this._contentLeft + curEstimatedWidth);
               if(okToCompose && this._uncomposedTextLength != 0 && newScroll != this._xScroll)
               {
                  this._xScroll = x;
                  if(this._xScroll > this._contentLeft + this._contentWidth)
                  {
                     this._xScroll = this._contentLeft + this._contentWidth;
                  }
                  this.flowComposer.composeToController(this.flowComposer.getControllerIndex(this));
                  newScroll = pinValue(x,this._contentLeft + this._compositionWidth,this._contentLeft + this._contentWidth);
               }
            }
            else
            {
               newScroll = pinValue(x,this._contentLeft,this._contentLeft + curEstimatedWidth - this._compositionWidth);
            }
         }
         return newScroll;
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._yScroll;
      }
      
      public function set verticalScrollPosition(y:Number) : void
      {
         if(!this._rootElement)
         {
            return;
         }
         if(this._verticalScrollPolicy == ScrollPolicy.OFF)
         {
            this._yScroll = 0;
            return;
         }
         var oldScroll:Number = this._yScroll;
         var newScroll:Number = this.computeVerticalScrollPosition(y,true);
         if(newScroll != oldScroll)
         {
            this._shapesInvalid = true;
            this._yScroll = newScroll;
            this.updateForScroll(ScrollEventDirection.VERTICAL,newScroll - oldScroll);
         }
      }
      
      private function computeVerticalScrollPosition(y:Number, okToCompose:Boolean) : Number
      {
         var newScroll:Number = 0;
         var curcontentHeight:Number = this.contentHeight;
         var wmode:String = this.effectiveBlockProgression;
         if(curcontentHeight > this._compositionHeight)
         {
            newScroll = pinValue(y,this._contentTop,this._contentTop + (curcontentHeight - this._compositionHeight));
            if(okToCompose && this._uncomposedTextLength != 0 && wmode == BlockProgression.TB)
            {
               this._yScroll = y;
               if(this._yScroll < this._contentTop)
               {
                  this._yScroll = this._contentTop;
               }
               this.flowComposer.composeToController(this.flowComposer.getControllerIndex(this));
               newScroll = pinValue(y,this._contentTop,this._contentTop + (curcontentHeight - this._compositionHeight));
            }
         }
         return newScroll;
      }
      
      public function getContentBounds() : Rectangle
      {
         return new Rectangle(this._contentLeft,this._contentTop,this.contentWidth,this.contentHeight);
      }
      
      tlf_internal function get contentLeft() : Number
      {
         return this._contentLeft;
      }
      
      tlf_internal function get contentTop() : Number
      {
         return this._contentTop;
      }
      
      tlf_internal function computeScaledContentMeasure(measure:Number) : Number
      {
         var charsInFinalParcel:int = this.textFlow.textLength - this._finalParcelStart;
         var composeCompleteRatio:Number = charsInFinalParcel / (charsInFinalParcel - this._uncomposedTextLength);
         return measure * composeCompleteRatio;
      }
      
      tlf_internal function get contentHeight() : Number
      {
         if(this._uncomposedTextLength == 0 || this.effectiveBlockProgression != BlockProgression.TB)
         {
            return this._contentHeight;
         }
         return this.computeScaledContentMeasure(this._contentHeight);
      }
      
      tlf_internal function get contentWidth() : Number
      {
         if(this._uncomposedTextLength == 0 || this.effectiveBlockProgression != BlockProgression.RL)
         {
            return this._contentWidth;
         }
         return this.computeScaledContentMeasure(this._contentWidth);
      }
      
      tlf_internal function setContentBounds(contentLeft:Number, contentTop:Number, contentWidth:Number, contentHeight:Number) : void
      {
         this._contentWidth = contentWidth;
         this._contentHeight = contentHeight;
         this._contentLeft = contentLeft;
         this._contentTop = contentTop;
         this.checkScrollBounds();
      }
      
      private function updateForScroll(direction:String, delta:Number) : void
      {
         this._linesInView.length = 0;
         var flowComposer:IFlowComposer = this.textFlow.flowComposer;
         flowComposer.updateToController(flowComposer.getControllerIndex(this));
         this.attachTransparentBackgroundForHit(false);
         if(this.textFlow.hasEventListener(TextLayoutEvent.SCROLL))
         {
            this.textFlow.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL,false,false,direction,delta));
         }
      }
      
      private function get containerScrollRectLeft() : Number
      {
         var rslt:Number = NaN;
         if(this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
         {
            rslt = 0;
         }
         else
         {
            rslt = this.effectiveBlockProgression == BlockProgression.RL ? Number(this.horizontalScrollPosition - this.compositionWidth) : Number(this.horizontalScrollPosition);
         }
         return rslt;
      }
      
      private function get containerScrollRectRight() : Number
      {
         return Number(this.containerScrollRectLeft + this.compositionWidth);
      }
      
      private function get containerScrollRectTop() : Number
      {
         var rslt:Number = NaN;
         if(this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
         {
            rslt = 0;
         }
         else
         {
            rslt = this.verticalScrollPosition;
         }
         return rslt;
      }
      
      private function get containerScrollRectBottom() : Number
      {
         return Number(this.containerScrollRectTop + this.compositionHeight);
      }
      
      public function scrollToRange(activePosition:int, anchorPosition:int) : void
      {
         var lastVisibleLine:TextFlowLine = null;
         var horizontalScrollOK:Boolean = false;
         var verticalScrollOK:Boolean = false;
         if(!this._hasScrollRect || !this.flowComposer || this.flowComposer.getControllerAt(this.flowComposer.numControllers - 1) != this)
         {
            return;
         }
         var controllerStart:int = this.absoluteStart;
         var lastPosition:int = Math.min(controllerStart + this._textLength,this.textFlow.textLength - 1);
         activePosition = Math.max(controllerStart,Math.min(activePosition,lastPosition));
         anchorPosition = Math.max(controllerStart,Math.min(anchorPosition,lastPosition));
         var verticalText:* = this.effectiveBlockProgression == BlockProgression.RL;
         var begPos:int = Math.min(activePosition,anchorPosition);
         var endPos:int = Math.max(activePosition,anchorPosition);
         var begLineIndex:int = this.flowComposer.findLineIndexAtPosition(begPos,begPos == this.textFlow.textLength);
         var endLineIndex:int = this.flowComposer.findLineIndexAtPosition(endPos,endPos == this.textFlow.textLength);
         var scrollRectLeft:Number = this.containerScrollRectLeft;
         var scrollRectTop:Number = this.containerScrollRectTop;
         var scrollRectRight:Number = this.containerScrollRectRight;
         var scrollRectBottom:Number = this.containerScrollRectBottom;
         if(this.flowComposer.damageAbsoluteStart <= endPos)
         {
            endPos = Math.min(begPos + 100,endPos + 1);
            this.flowComposer.composeToPosition(endPos);
            begLineIndex = this.flowComposer.findLineIndexAtPosition(begPos,begPos == this.textFlow.textLength);
            endLineIndex = this.flowComposer.findLineIndexAtPosition(endPos,endPos == this.textFlow.textLength);
         }
         var rect:Rectangle = this.rangeToRectangle(begPos,endPos,begLineIndex,endLineIndex);
         if(rect)
         {
            if(verticalText)
            {
               horizontalScrollOK = rect.left < scrollRectLeft || rect.right > scrollRectLeft;
               if(horizontalScrollOK)
               {
                  if(rect.left < scrollRectLeft)
                  {
                     this.horizontalScrollPosition = rect.left + this._compositionWidth;
                  }
                  if(rect.right > scrollRectRight)
                  {
                     this.horizontalScrollPosition = rect.right;
                  }
               }
               if(rect.top < scrollRectTop)
               {
                  this.verticalScrollPosition = rect.top;
               }
               if(activePosition == anchorPosition)
               {
                  rect.bottom += 2;
               }
               if(rect.bottom > scrollRectBottom)
               {
                  this.verticalScrollPosition = rect.bottom - this._compositionHeight;
               }
            }
            else
            {
               verticalScrollOK = rect.top > scrollRectTop || rect.bottom < scrollRectBottom;
               if(verticalScrollOK)
               {
                  if(rect.top < scrollRectTop)
                  {
                     this.verticalScrollPosition = rect.top;
                  }
                  if(rect.bottom > scrollRectBottom)
                  {
                     this.verticalScrollPosition = rect.bottom - this._compositionHeight;
                  }
               }
               if(activePosition == anchorPosition)
               {
                  rect.right += 2;
               }
               horizontalScrollOK = rect.left > scrollRectLeft || rect.right < scrollRectRight;
               if(horizontalScrollOK && rect.left < scrollRectLeft)
               {
                  this.horizontalScrollPosition = rect.left - this._compositionWidth / 2;
               }
               if(horizontalScrollOK && rect.right > scrollRectRight)
               {
                  this.horizontalScrollPosition = rect.right - this._compositionWidth / 2;
               }
            }
         }
      }
      
      private function rangeToRectangle(start:int, end:int, startLineIndex:int, endLineIndex:int) : Rectangle
      {
         var bbox:Rectangle = null;
         var line:TextFlowLine = null;
         var textLine:TextLine = null;
         var paragraphStart:int = 0;
         var isTCY:* = false;
         var minAtomIndex:int = 0;
         var maxAtomIndex:int = 0;
         var leafElement:FlowLeafElement = null;
         var atomIndex:int = 0;
         var lastPosition:int = 0;
         var pos:int = 0;
         var startLine:TextFlowLine = null;
         var endLine:TextFlowLine = null;
         var blockProgression:String = this.effectiveBlockProgression;
         var flowComposer:IFlowComposer = this.textFlow.flowComposer;
         if(!this.container || !flowComposer)
         {
            return null;
         }
         if(startLineIndex == endLineIndex)
         {
            line = flowComposer.getLineAt(startLineIndex);
            if(line.isDamaged())
            {
               return null;
            }
            textLine = line.getTextLine(true);
            paragraphStart = line.paragraph.getAbsoluteStart();
            isTCY = false;
            if(blockProgression == BlockProgression.RL)
            {
               leafElement = this._rootElement.getTextFlow().findLeaf(start);
               isTCY = leafElement.getParentByType(TCYElement) != null;
            }
            minAtomIndex = textLine.atomCount;
            maxAtomIndex = 0;
            if(start == end)
            {
               minAtomIndex = textLine.getAtomIndexAtCharIndex(start - paragraphStart);
               maxAtomIndex = minAtomIndex;
            }
            else
            {
               lastPosition = end - paragraphStart;
               for(pos = start - paragraphStart; pos < lastPosition; pos++)
               {
                  atomIndex = textLine.getAtomIndexAtCharIndex(pos);
                  if(atomIndex < minAtomIndex)
                  {
                     minAtomIndex = atomIndex;
                  }
                  if(atomIndex > maxAtomIndex)
                  {
                     maxAtomIndex = atomIndex;
                  }
               }
            }
            bbox = this.atomToRectangle(minAtomIndex,line,textLine,blockProgression,isTCY);
            if(minAtomIndex != maxAtomIndex)
            {
               bbox = bbox.union(this.atomToRectangle(maxAtomIndex,line,textLine,blockProgression,isTCY));
            }
         }
         else
         {
            bbox = new Rectangle(this._contentLeft,this._contentTop,this._contentWidth,this._contentHeight);
            startLine = flowComposer.getLineAt(startLineIndex);
            endLine = flowComposer.getLineAt(endLineIndex);
            if(blockProgression == BlockProgression.TB)
            {
               bbox.top = startLine.y;
               bbox.bottom = endLine.y + endLine.textHeight;
            }
            else
            {
               bbox.right = startLine.x + startLine.textHeight;
               bbox.left = endLine.x;
            }
         }
         return bbox;
      }
      
      private function atomToRectangle(atomIdx:int, line:TextFlowLine, textLine:TextLine, blockProgression:String, isTCY:Boolean) : Rectangle
      {
         var atomBounds:Rectangle = null;
         if(atomIdx > -1)
         {
            atomBounds = textLine.getAtomBounds(atomIdx);
         }
         if(blockProgression == BlockProgression.RL)
         {
            if(isTCY)
            {
               return new Rectangle(line.x + atomBounds.x,line.y + atomBounds.y,atomBounds.width,atomBounds.height);
            }
            return new Rectangle(line.x,line.y + atomBounds.y,line.height,atomBounds.height);
         }
         return new Rectangle(line.x + atomBounds.x,line.y - line.height + line.ascent,atomBounds.width,line.height + textLine.descent);
      }
      
      tlf_internal function resetColumnState() : void
      {
         if(this._rootElement)
         {
            this._columnState.updateInputs(this.effectiveBlockProgression,this._rootElement.computedFormat.direction,this,this._compositionWidth,this._compositionHeight);
         }
      }
      
      public function invalidateContents() : void
      {
         if(this.textFlow)
         {
            this.textFlow.damage(this.absoluteStart,Math.min(this._textLength,1),FlowDamageType.GEOMETRY,false);
         }
      }
      
      tlf_internal function attachTransparentBackgroundForHit(justClear:Boolean) : void
      {
         var s:Sprite = null;
         var bgwidth:Number = NaN;
         var bgheight:Number = NaN;
         var adjustHorizontalScroll:Boolean = false;
         var bgx:Number = NaN;
         var bgy:Number = NaN;
         if((this._minListenersAttached || this._mouseWheelListenerAttached) && this.attachTransparentBackground)
         {
            s = this._container;
            if(justClear)
            {
               s.graphics.clear();
               this._transparentBGX = this._transparentBGY = this._transparentBGWidth = this._transparentBGHeight = NaN;
            }
            else
            {
               bgwidth = !!this._measureWidth ? Number(this._contentWidth) : Number(this._compositionWidth);
               bgheight = !!this._measureHeight ? Number(this._contentHeight) : Number(this._compositionHeight);
               adjustHorizontalScroll = this.effectiveBlockProgression == BlockProgression.RL && this._horizontalScrollPolicy != ScrollPolicy.OFF;
               bgx = !!adjustHorizontalScroll ? Number(this._xScroll - bgwidth) : Number(this._xScroll);
               bgy = this._yScroll;
               if(bgx != this._transparentBGX || bgy != this._transparentBGY || bgwidth != this._transparentBGWidth || bgheight != this._transparentBGHeight)
               {
                  s.graphics.clear();
                  if(bgwidth != 0 && bgheight != 0)
                  {
                     s.graphics.beginFill(0,0);
                     s.graphics.drawRect(bgx,bgy,bgwidth,bgheight);
                     s.graphics.endFill();
                  }
                  this._transparentBGX = bgx;
                  this._transparentBGY = bgy;
                  this._transparentBGWidth = bgwidth;
                  this._transparentBGHeight = bgheight;
               }
            }
         }
      }
      
      tlf_internal function interactionManagerChanged(newInteractionManager:ISelectionManager) : void
      {
         if(!newInteractionManager)
         {
            this.detachContainer();
         }
         this.attachContainer();
         this.checkScrollBounds();
         if(this._mouseEventManager)
         {
            this._mouseEventManager.needsCtrlKey = this.interactionManager != null && this.interactionManager.editingMode == EditingMode.READ_WRITE;
         }
         if(Configuration.playerEnablesSpicyFeatures)
         {
            this._container["needsSoftKeyboard"] = this.interactionManager && this.interactionManager.editingMode == EditingMode.READ_WRITE;
         }
      }
      
      tlf_internal function attachContainer() : void
      {
         if(!this._minListenersAttached && this.textFlow && this.textFlow.interactionManager)
         {
            this._minListenersAttached = true;
            this._container.addEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.addEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
            this.attachTransparentBackgroundForHit(false);
            if(this._container.stage && this._container.stage.focus == this._container)
            {
               this.attachAllListeners();
            }
         }
      }
      
      tlf_internal function attachInteractionHandlers() : void
      {
         var receiver:IInteractionEventHandler = this.getInteractionHandler();
         this._container.addEventListener(MouseEvent.MOUSE_DOWN,this.requiredMouseDownHandler);
         this._container.addEventListener(FocusEvent.FOCUS_OUT,this.requiredFocusOutHandler);
         this._container.addEventListener(MouseEvent.DOUBLE_CLICK,receiver.mouseDoubleClickHandler);
         this._container.addEventListener(Event.ACTIVATE,receiver.activateHandler);
         this._container.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,receiver.focusChangeHandler);
         this._container.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,receiver.focusChangeHandler);
         this._container.addEventListener(TextEvent.TEXT_INPUT,receiver.textInputHandler);
         this._container.addEventListener(MouseEvent.MOUSE_OUT,receiver.mouseOutHandler);
         this.addMouseWheelListener();
         this._container.addEventListener(Event.DEACTIVATE,receiver.deactivateHandler);
         this._container.addEventListener("imeStartComposition",receiver.imeStartCompositionHandler);
         if(this._container.contextMenu)
         {
            this._container.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,receiver.menuSelectHandler);
         }
         this._container.addEventListener(Event.COPY,receiver.editHandler);
         this._container.addEventListener(Event.SELECT_ALL,receiver.editHandler);
         this._container.addEventListener(Event.CUT,receiver.editHandler);
         this._container.addEventListener(Event.PASTE,receiver.editHandler);
         this._container.addEventListener(Event.CLEAR,receiver.editHandler);
      }
      
      tlf_internal function removeInteractionHandlers() : void
      {
         var receiver:IInteractionEventHandler = this.getInteractionHandler();
         this._container.removeEventListener(MouseEvent.MOUSE_DOWN,this.requiredMouseDownHandler);
         this._container.removeEventListener(FocusEvent.FOCUS_OUT,this.requiredFocusOutHandler);
         this._container.removeEventListener(MouseEvent.DOUBLE_CLICK,receiver.mouseDoubleClickHandler);
         this._container.removeEventListener(Event.ACTIVATE,receiver.activateHandler);
         this._container.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,receiver.focusChangeHandler);
         this._container.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,receiver.focusChangeHandler);
         this._container.removeEventListener(TextEvent.TEXT_INPUT,receiver.textInputHandler);
         this._container.removeEventListener(MouseEvent.MOUSE_OUT,receiver.mouseOutHandler);
         this.removeMouseWheelListener();
         this._container.removeEventListener(Event.DEACTIVATE,receiver.deactivateHandler);
         this._container.removeEventListener("imeStartComposition",receiver.imeStartCompositionHandler);
         if(this._container.contextMenu)
         {
            this._container.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,receiver.menuSelectHandler);
         }
         this._container.removeEventListener(Event.COPY,receiver.editHandler);
         this._container.removeEventListener(Event.SELECT_ALL,receiver.editHandler);
         this._container.removeEventListener(Event.CUT,receiver.editHandler);
         this._container.removeEventListener(Event.PASTE,receiver.editHandler);
         this._container.removeEventListener(Event.CLEAR,receiver.editHandler);
         this.clearSelectHandlers();
      }
      
      private function detachContainer() : void
      {
         if(this._minListenersAttached)
         {
            this._container.removeEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
            if(this._allListenersAttached)
            {
               this.removeInteractionHandlers();
               this.removeContextMenu();
               this.attachTransparentBackgroundForHit(true);
               this._allListenersAttached = false;
            }
            this._minListenersAttached = false;
         }
         this.removeMouseWheelListener();
      }
      
      private function attachAllListeners() : void
      {
         if(!this._allListenersAttached && this.textFlow && this.textFlow.interactionManager)
         {
            this._allListenersAttached = true;
            this.attachContextMenu();
            this.attachInteractionHandlers();
         }
      }
      
      tlf_internal function addMouseWheelListener() : void
      {
         if(!this._mouseWheelListenerAttached)
         {
            this._container.addEventListener(MouseEvent.MOUSE_WHEEL,this.getInteractionHandler().mouseWheelHandler);
            this._mouseWheelListenerAttached = true;
         }
      }
      
      tlf_internal function removeMouseWheelListener() : void
      {
         if(this._mouseWheelListenerAttached)
         {
            this._container.removeEventListener(MouseEvent.MOUSE_WHEEL,this.getInteractionHandler().mouseWheelHandler);
            this._mouseWheelListenerAttached = false;
         }
      }
      
      tlf_internal function attachContextMenu() : void
      {
         this._container.contextMenu = this.createContextMenu();
      }
      
      tlf_internal function removeContextMenu() : void
      {
         this._container.contextMenu = null;
      }
      
      protected function createContextMenu() : ContextMenu
      {
         return createDefaultContextMenu();
      }
      
      public function dispose() : void
      {
         this.stopMouseSelectionScrolling();
         this.clearSelectionShapes();
         this.setRootElement(null);
      }
      
      private function stopMouseSelectionScrolling(containerRoot:IEventDispatcher = null) : void
      {
         if(this._scrollTimer)
         {
            this._scrollTimer.stop();
            this._scrollTimer.removeEventListener(TimerEvent.TIMER,this.scrollTimerHandler);
            if(!containerRoot)
            {
               containerRoot = this.getContainerRoot();
            }
            if(containerRoot)
            {
               containerRoot.removeEventListener(MouseEvent.MOUSE_UP,this.scrollTimerHandler);
            }
            this._scrollTimer = null;
         }
      }
      
      tlf_internal function scrollTimerHandler(event:Event) : void
      {
         var containerPoint:Point = null;
         var scrollChange:int = 0;
         var mouseEvent:MouseEvent = null;
         var stashedScrollTimer:Timer = null;
         if(!this._scrollTimer)
         {
            return;
         }
         if(this.textFlow.interactionManager == null || this.textFlow.interactionManager.activePosition < this.absoluteStart || this.textFlow.interactionManager.activePosition > this.absoluteStart + this.textLength)
         {
            var event:Event = null;
         }
         if(event is MouseEvent)
         {
            this.stopMouseSelectionScrolling(event.currentTarget as IEventDispatcher);
         }
         else if(!event)
         {
            this.stopMouseSelectionScrolling();
         }
         else if(!this._container.stage)
         {
         }
      }
      
      public function autoScrollIfNecessary(mouseX:int, mouseY:int) : void
      {
         var verticalText:* = false;
         var lastController:ContainerController = null;
         var r:Rectangle = null;
         if(this.flowComposer.getControllerAt(this.flowComposer.numControllers - 1) != this)
         {
            verticalText = this.effectiveBlockProgression == BlockProgression.RL;
            lastController = this.flowComposer.getControllerAt(this.flowComposer.numControllers - 1);
            if(verticalText && this._horizontalScrollPolicy == ScrollPolicy.OFF || !verticalText && this._verticalScrollPolicy == ScrollPolicy.OFF)
            {
               return;
            }
            r = lastController.container.getBounds(this._container.stage);
            if(verticalText)
            {
               if(mouseY >= r.top && mouseY <= r.bottom)
               {
                  lastController.autoScrollIfNecessary(mouseX,mouseY);
               }
            }
            else if(mouseX >= r.left && mouseX <= r.right)
            {
               lastController.autoScrollIfNecessary(mouseX,mouseY);
            }
         }
         if(!this._hasScrollRect)
         {
            return;
         }
         var containerPoint:Point = new Point(mouseX,mouseY);
         containerPoint = this._container.globalToLocal(containerPoint);
         this.autoScrollIfNecessaryInternal(containerPoint);
      }
      
      private function autoScrollIfNecessaryInternal(extreme:Point) : int
      {
         var scrollDirection:int = 0;
         if(extreme.y - this.containerScrollRectBottom > 0)
         {
            this.verticalScrollPosition += this.textFlow.configuration.scrollDragPixels;
            scrollDirection = 1;
         }
         else if(extreme.y - this.containerScrollRectTop < 0)
         {
            this.verticalScrollPosition -= this.textFlow.configuration.scrollDragPixels;
            scrollDirection = -1;
         }
         if(extreme.x - this.containerScrollRectRight > 0)
         {
            this.horizontalScrollPosition += this.textFlow.configuration.scrollDragPixels;
            scrollDirection = -1;
         }
         else if(extreme.x - this.containerScrollRectLeft < 0)
         {
            this.horizontalScrollPosition -= this.textFlow.configuration.scrollDragPixels;
            scrollDirection = 1;
         }
         if(scrollDirection != 0 && !this._scrollTimer)
         {
            this._scrollTimer = new Timer(this.textFlow.configuration.scrollDragDelay);
            this._scrollTimer.addEventListener(TimerEvent.TIMER,this.scrollTimerHandler,false,0,true);
            if(this.getContainerRoot())
            {
               this.getContainerRoot().addEventListener(MouseEvent.MOUSE_UP,this.scrollTimerHandler,false,0,true);
               this.beginMouseCapture();
            }
            this._scrollTimer.start();
         }
         return scrollDirection;
      }
      
      tlf_internal function getFirstVisibleLine() : TextFlowLine
      {
         return !!this._shapeChildren.length ? this._shapeChildren[0].userData : null;
      }
      
      tlf_internal function getLastVisibleLine() : TextFlowLine
      {
         return !!this._shapeChildren.length ? this._shapeChildren[this._shapeChildren.length - 1].userData : null;
      }
      
      public function getScrollDelta(numLines:int) : Number
      {
         var newLineIndex:int = 0;
         var lineIndex:int = 0;
         var newScrollPosition:Number = NaN;
         var lastTextLine:TextLine = null;
         var previousDamageStart:int = 0;
         var leaf:FlowLeafElement = null;
         var paragraph:ParagraphElement = null;
         var flowComposer:IFlowComposer = this.textFlow.flowComposer;
         if(flowComposer.numLines == 0)
         {
            return 0;
         }
         var firstVisibleLine:TextFlowLine = this.getFirstVisibleLine();
         if(!firstVisibleLine)
         {
            return 0;
         }
         var lastVisibleLine:TextFlowLine = this.getLastVisibleLine();
         if(numLines > 0)
         {
            lineIndex = flowComposer.findLineIndexAtPosition(lastVisibleLine.absoluteStart);
            lastTextLine = lastVisibleLine.getTextLine(true);
            if(this.effectiveBlockProgression == BlockProgression.TB)
            {
               if(lastTextLine.y + lastTextLine.descent - this.containerScrollRectBottom > 2)
               {
                  lineIndex--;
               }
            }
            else if(this.containerScrollRectLeft - (lastTextLine.x - lastTextLine.descent) > 2)
            {
               lineIndex--;
            }
            while(lineIndex + numLines > flowComposer.numLines - 1 && flowComposer.damageAbsoluteStart < this.textFlow.textLength)
            {
               previousDamageStart = flowComposer.damageAbsoluteStart;
               flowComposer.composeToPosition(flowComposer.damageAbsoluteStart + 1000);
               if(flowComposer.damageAbsoluteStart == previousDamageStart)
               {
                  return 0;
               }
            }
            newLineIndex = Math.min(flowComposer.numLines - 1,lineIndex + numLines);
         }
         if(numLines < 0)
         {
            lineIndex = flowComposer.findLineIndexAtPosition(firstVisibleLine.absoluteStart);
            if(this.effectiveBlockProgression == BlockProgression.TB)
            {
               if(firstVisibleLine.y + 2 < this.containerScrollRectTop)
               {
                  lineIndex++;
               }
            }
            else if(firstVisibleLine.x + firstVisibleLine.ascent > this.containerScrollRectRight + 2)
            {
               lineIndex++;
            }
            newLineIndex = Math.max(0,lineIndex + numLines);
         }
         var line:TextFlowLine = flowComposer.getLineAt(newLineIndex);
         if(line.absoluteStart < this.absoluteStart)
         {
            return 0;
         }
         if(line.validity != TextLineValidity.VALID)
         {
            leaf = this.textFlow.findLeaf(line.absoluteStart);
            paragraph = leaf.getParagraph();
            this.textFlow.flowComposer.composeToPosition(paragraph.getAbsoluteStart() + paragraph.textLength);
            line = flowComposer.getLineAt(newLineIndex);
         }
         var verticalText:* = this.effectiveBlockProgression == BlockProgression.RL;
         if(verticalText)
         {
            newScrollPosition = numLines < 0 ? Number(line.x + line.textHeight) : Number(line.x - line.descent + this._compositionWidth);
            return newScrollPosition - this.horizontalScrollPosition;
         }
         newScrollPosition = numLines < 0 ? Number(line.y) : Number(line.y + line.textHeight - this._compositionHeight);
         return newScrollPosition - this.verticalScrollPosition;
      }
      
      public function mouseOverHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.mouseOverHandler(event);
         }
      }
      
      tlf_internal function requiredMouseOverHandler(event:MouseEvent) : void
      {
         this.attachAllListeners();
         this.getInteractionHandler().mouseOverHandler(event);
      }
      
      public function mouseOutHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.mouseOutHandler(event);
         }
      }
      
      public function mouseWheelHandler(event:MouseEvent) : void
      {
         if(event.isDefaultPrevented())
         {
            return;
         }
         var verticalText:* = this.effectiveBlockProgression == BlockProgression.RL;
         if(verticalText)
         {
            if(this.contentWidth > this._compositionWidth && !this._measureWidth)
            {
               this.horizontalScrollPosition += event.delta * this.textFlow.configuration.scrollMouseWheelMultiplier;
               event.preventDefault();
            }
         }
         else if(this.contentHeight > this._compositionHeight && !this._measureHeight)
         {
            this.verticalScrollPosition -= event.delta * this.textFlow.configuration.scrollMouseWheelMultiplier;
            event.preventDefault();
         }
      }
      
      public function mouseDownHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.mouseDownHandler(event);
            if(this.interactionManager.hasSelection())
            {
               this.setFocus();
            }
         }
      }
      
      tlf_internal function requiredMouseDownHandler(event:MouseEvent) : void
      {
         var containerRoot:DisplayObject = null;
         if(!this._selectListenersAttached)
         {
            containerRoot = this.getContainerRoot();
            if(containerRoot)
            {
               containerRoot.addEventListener(MouseEvent.MOUSE_MOVE,this.rootMouseMoveHandler,false,0,true);
               containerRoot.addEventListener(MouseEvent.MOUSE_UP,this.rootMouseUpHandler,false,0,true);
               this.beginMouseCapture();
               this._selectListenersAttached = true;
            }
         }
         this.getInteractionHandler().mouseDownHandler(event);
      }
      
      public function mouseUpHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && event && !event.isDefaultPrevented())
         {
            this.interactionManager.mouseUpHandler(event);
         }
      }
      
      tlf_internal function rootMouseUpHandler(event:MouseEvent) : void
      {
         this.clearSelectHandlers();
         this.getInteractionHandler().mouseUpHandler(event);
      }
      
      private function clearSelectHandlers() : void
      {
         if(this._selectListenersAttached)
         {
            this.getContainerRoot().removeEventListener(MouseEvent.MOUSE_MOVE,this.rootMouseMoveHandler);
            this.getContainerRoot().removeEventListener(MouseEvent.MOUSE_UP,this.rootMouseUpHandler);
            this.endMouseCapture();
            this._selectListenersAttached = false;
         }
      }
      
      public function beginMouseCapture() : void
      {
         var sandboxManager:ISandboxSupport = this.getInteractionHandler() as ISandboxSupport;
         if(sandboxManager && sandboxManager != this)
         {
            sandboxManager.beginMouseCapture();
         }
      }
      
      public function endMouseCapture() : void
      {
         var sandboxManager:ISandboxSupport = this.getInteractionHandler() as ISandboxSupport;
         if(sandboxManager && sandboxManager != this)
         {
            sandboxManager.endMouseCapture();
         }
      }
      
      public function mouseUpSomewhere(event:Event) : void
      {
         this.rootMouseUpHandler(null);
         this.scrollTimerHandler(null);
      }
      
      public function mouseMoveSomewhere(event:Event) : void
      {
      }
      
      private function hitOnMyFlowExceptLastContainer(event:MouseEvent) : Boolean
      {
         var tfl:TextFlowLine = null;
         var para:ParagraphElement = null;
         var idx:int = 0;
         if(event.target is TextLine)
         {
            tfl = TextLine(event.target).userData as TextFlowLine;
            if(tfl)
            {
               para = tfl.paragraph;
               if(para.getTextFlow() == this.textFlow)
               {
                  return true;
               }
            }
         }
         else if(event.target is Sprite)
         {
            for(idx = 0; idx < this.textFlow.flowComposer.numControllers - 1; idx++)
            {
               if(this.textFlow.flowComposer.getControllerAt(idx).container == event.target)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function mouseMoveHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            if(event.buttonDown && !this.hitOnMyFlowExceptLastContainer(event))
            {
               this.autoScrollIfNecessary(event.stageX,event.stageY);
            }
            this.interactionManager.mouseMoveHandler(event);
         }
      }
      
      tlf_internal function rootMouseMoveHandler(event:MouseEvent) : void
      {
         this.getInteractionHandler().mouseMoveHandler(event);
      }
      
      public function mouseDoubleClickHandler(event:MouseEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.mouseDoubleClickHandler(event);
            if(this.interactionManager.hasSelection())
            {
               this.setFocus();
            }
         }
      }
      
      tlf_internal function setFocus() : void
      {
         if(this._container.stage)
         {
            this._container.stage.focus = this._container;
         }
      }
      
      tlf_internal function getContainerController(container:DisplayObject) : ContainerController
      {
         var flowComposer:IFlowComposer = null;
         var i:int = 0;
         var controller:ContainerController = null;
         try
         {
            while(container)
            {
               flowComposer = this.flowComposer;
               for(i = 0; i < flowComposer.numControllers; i++)
               {
                  controller = flowComposer.getControllerAt(i);
                  if(controller.container == container)
                  {
                     return controller;
                  }
               }
               container = container.parent;
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function focusChangeHandler(event:FocusEvent) : void
      {
         var focusController:ContainerController = this.getContainerController(DisplayObject(event.target));
         var newFocusController:ContainerController = this.getContainerController(event.relatedObject);
         if(newFocusController == focusController)
         {
            event.preventDefault();
         }
      }
      
      public function focusInHandler(event:FocusEvent) : void
      {
         var blinkRate:int = 0;
         if(this.interactionManager)
         {
            this.interactionManager.focusInHandler(event);
            if(this.interactionManager.editingMode == EditingMode.READ_WRITE)
            {
               blinkRate = this.interactionManager.focusedSelectionFormat.pointBlinkRate;
            }
         }
         this.setBlinkInterval(blinkRate);
      }
      
      tlf_internal function requiredFocusInHandler(event:FocusEvent) : void
      {
         this.attachAllListeners();
         this._container.addEventListener(KeyboardEvent.KEY_DOWN,this.getInteractionHandler().keyDownHandler);
         this._container.addEventListener(KeyboardEvent.KEY_UP,this.getInteractionHandler().keyUpHandler);
         this._container.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.getInteractionHandler().keyFocusChangeHandler);
         if(Configuration.playerEnablesSpicyFeatures && Configuration.hasTouchScreen)
         {
            this._container.addEventListener("softKeyboardActivating",this.getInteractionHandler().softKeyboardActivatingHandler);
         }
         this.getInteractionHandler().focusInHandler(event);
      }
      
      public function focusOutHandler(event:FocusEvent) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.focusOutHandler(event);
            this.setBlinkInterval(this.interactionManager.unfocusedSelectionFormat.pointBlinkRate);
         }
         else
         {
            this.setBlinkInterval(0);
         }
      }
      
      tlf_internal function requiredFocusOutHandler(event:FocusEvent) : void
      {
         this._container.removeEventListener(KeyboardEvent.KEY_DOWN,this.getInteractionHandler().keyDownHandler);
         this._container.removeEventListener(KeyboardEvent.KEY_UP,this.getInteractionHandler().keyUpHandler);
         this._container.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.getInteractionHandler().keyFocusChangeHandler);
         if(Configuration.playerEnablesSpicyFeatures && Configuration.hasTouchScreen)
         {
            this._container.removeEventListener("softKeyboardActivating",this.getInteractionHandler().softKeyboardActivatingHandler);
         }
         this.getInteractionHandler().focusOutHandler(event);
      }
      
      public function activateHandler(event:Event) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.activateHandler(event);
         }
      }
      
      public function deactivateHandler(event:Event) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.deactivateHandler(event);
         }
      }
      
      public function keyDownHandler(event:KeyboardEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.keyDownHandler(event);
         }
      }
      
      public function keyUpHandler(event:KeyboardEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.keyUpHandler(event);
         }
      }
      
      public function keyFocusChangeHandler(event:FocusEvent) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.keyFocusChangeHandler(event);
         }
      }
      
      public function textInputHandler(event:TextEvent) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.textInputHandler(event);
         }
      }
      
      public function softKeyboardActivatingHandler(event:Event) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.softKeyboardActivatingHandler(event);
         }
      }
      
      public function imeStartCompositionHandler(event:IMEEvent) : void
      {
         if(this.interactionManager)
         {
            this.interactionManager.imeStartCompositionHandler(event);
         }
      }
      
      public function menuSelectHandler(event:ContextMenuEvent) : void
      {
         var contextMenu:ContextMenu = null;
         var cbItems:ContextMenuClipboardItems = null;
         if(this.interactionManager)
         {
            this.interactionManager.menuSelectHandler(event);
         }
         else
         {
            contextMenu = this._container.contextMenu;
            if(contextMenu)
            {
               cbItems = contextMenu.clipboardItems;
               cbItems.copy = false;
               cbItems.cut = false;
               cbItems.paste = false;
               cbItems.selectAll = false;
               cbItems.clear = false;
            }
         }
      }
      
      public function editHandler(event:Event) : void
      {
         if(this.interactionManager && !event.isDefaultPrevented())
         {
            this.interactionManager.editHandler(event);
         }
         var contextMenu:ContextMenu = this._container.contextMenu;
         if(contextMenu)
         {
            contextMenu.clipboardItems.clear = true;
            contextMenu.clipboardItems.copy = true;
            contextMenu.clipboardItems.cut = true;
            contextMenu.clipboardItems.paste = true;
            contextMenu.clipboardItems.selectAll = true;
         }
      }
      
      public function selectRange(anchorIndex:int, activeIndex:int) : void
      {
         if(this.interactionManager && this.interactionManager.editingMode != EditingMode.READ_ONLY)
         {
            this.interactionManager.selectRange(anchorIndex,activeIndex);
         }
      }
      
      private function startBlinkingCursor(obj:DisplayObject, blinkInterval:int) : void
      {
         if(!this.blinkTimer)
         {
            this.blinkTimer = new Timer(blinkInterval,0);
         }
         this.blinkObject = obj;
         this.blinkTimer.addEventListener(TimerEvent.TIMER,this.blinkTimerHandler,false,0,true);
         this.blinkTimer.start();
      }
      
      protected function stopBlinkingCursor() : void
      {
         if(this.blinkTimer)
         {
            this.blinkTimer.stop();
         }
         this.blinkObject = null;
      }
      
      private function blinkTimerHandler(event:TimerEvent) : void
      {
         this.blinkObject.alpha = this.blinkObject.alpha == 1 ? Number(0) : Number(1);
      }
      
      protected function setBlinkInterval(intervalMS:int) : void
      {
         var blinkInterval:int = intervalMS;
         if(blinkInterval == 0)
         {
            if(this.blinkTimer)
            {
               this.blinkTimer.stop();
            }
            if(this.blinkObject)
            {
               this.blinkObject.alpha = 1;
            }
         }
         else if(this.blinkTimer)
         {
            this.blinkTimer.delay = blinkInterval;
            if(this.blinkObject)
            {
               this.blinkTimer.start();
            }
         }
      }
      
      tlf_internal function drawPointSelection(selFormat:SelectionFormat, x:Number, y:Number, w:Number, h:Number) : void
      {
         var selObj:Shape = new Shape();
         if(this._hasScrollRect)
         {
            if(this.effectiveBlockProgression == BlockProgression.TB)
            {
               if(x >= this.containerScrollRectRight)
               {
                  x -= w;
               }
            }
            else if(y >= this.containerScrollRectBottom)
            {
               y -= h;
            }
         }
         selObj.graphics.beginFill(selFormat.pointColor);
         selObj.graphics.drawRect(int(x),int(y),w,h);
         selObj.graphics.endFill();
         if(selFormat.pointBlinkRate != 0 && this.interactionManager.editingMode == EditingMode.READ_WRITE)
         {
            this.startBlinkingCursor(selObj,selFormat.pointBlinkRate);
         }
         this.addSelectionChild(selObj);
      }
      
      tlf_internal function addCellSelectionShapes(color:uint, tableBlock:TextFlowTableBlock, startCoords:CellCoordinates, endCoords:CellCoordinates) : void
      {
         var cell:TableCellElement = null;
         var row:TableRowElement = null;
         var r:Rectangle = null;
         if(!tableBlock)
         {
            return;
         }
         if(!startCoords.isValid() || !endCoords.isValid())
         {
            return;
         }
         var cells:Vector.<TableCellElement> = tableBlock.getCellsInRange(startCoords,endCoords);
         var selObj:Shape = new Shape();
         selObj.graphics.beginFill(color);
         for each(cell in cells)
         {
            row = cell.getRow();
            r = new Rectangle(cell.x,cell.y + tableBlock.y,cell.width,row.composedHeight);
            selObj.graphics.drawRect(r.x,r.y,r.width,r.height);
         }
         this.addSelectionChild(selObj);
      }
      
      tlf_internal function addCellSelections(cells:Array, color:uint, tableBlock:TextFlowTableBlock) : void
      {
         var cell:TableCellElement = null;
         var row:TableRowElement = null;
         var rectangle:Rectangle = null;
         var shape:Shape = new Shape();
         shape.graphics.beginFill(color);
         for each(cell in cells)
         {
            row = cell.getRow();
            rectangle = new Rectangle(cell.x,cell.y + tableBlock.y,cell.width,row.composedHeight);
            shape.graphics.drawRect(rectangle.x,rectangle.y,rectangle.width,rectangle.height);
         }
         this.addSelectionChild(shape);
      }
      
      tlf_internal function addSelectionShapes(selFormat:SelectionFormat, selectionAbsoluteStart:int, selectionAbsoluteEnd:int) : void
      {
         var prevLine:TextFlowLine = null;
         var nextLine:TextFlowLine = null;
         var absoluteControllerStart:int = 0;
         var absoluteControllerEnd:int = 0;
         var begLine:int = 0;
         var endLine:int = 0;
         var selObj:Shape = null;
         var line:TextFlowLine = null;
         var idx:int = 0;
         var temp:TextFlowLine = null;
         var lineIdx:int = 0;
         if(!this.interactionManager || this._textLength == 0 || selectionAbsoluteStart == -1 || selectionAbsoluteEnd == -1)
         {
            return;
         }
         if(selectionAbsoluteStart != selectionAbsoluteEnd)
         {
            absoluteControllerStart = this.absoluteStart;
            absoluteControllerEnd = this.absoluteStart + this.textLength;
            if(selectionAbsoluteStart < absoluteControllerStart)
            {
               selectionAbsoluteStart = absoluteControllerStart;
            }
            else if(selectionAbsoluteStart >= absoluteControllerEnd)
            {
               return;
            }
            if(selectionAbsoluteEnd > absoluteControllerEnd)
            {
               selectionAbsoluteEnd = absoluteControllerEnd;
            }
            else if(selectionAbsoluteEnd < absoluteControllerStart)
            {
               return;
            }
            begLine = this.flowComposer.findLineIndexAtPosition(selectionAbsoluteStart);
            endLine = selectionAbsoluteStart == selectionAbsoluteEnd ? int(begLine) : int(this.flowComposer.findLineIndexAtPosition(selectionAbsoluteEnd));
            if(endLine >= this.flowComposer.numLines)
            {
               endLine = this.flowComposer.numLines - 1;
            }
            selObj = new Shape();
            prevLine = !!begLine ? this.flowComposer.getLineAt(begLine - 1) : null;
            line = this.flowComposer.getLineAt(begLine);
            for(idx = begLine; idx <= endLine; idx++)
            {
               nextLine = idx != this.flowComposer.numLines - 1 ? this.flowComposer.getLineAt(idx + 1) : null;
               line.hiliteBlockSelection(selObj,selFormat,this._container,selectionAbsoluteStart < line.absoluteStart ? int(line.absoluteStart) : int(selectionAbsoluteStart),selectionAbsoluteEnd > line.absoluteStart + line.textLength ? int(line.absoluteStart + line.textLength) : int(selectionAbsoluteEnd),prevLine,nextLine);
               temp = line;
               line = nextLine;
               prevLine = temp;
            }
            this.addSelectionChild(selObj);
         }
         else
         {
            lineIdx = this.flowComposer.findLineIndexAtPosition(selectionAbsoluteStart);
            if(lineIdx == this.flowComposer.numLines)
            {
               lineIdx--;
            }
            if(this.flowComposer.getLineAt(lineIdx).controller == this)
            {
               prevLine = lineIdx != 0 ? this.flowComposer.getLineAt(lineIdx - 1) : null;
               nextLine = lineIdx != this.flowComposer.numLines - 1 ? this.flowComposer.getLineAt(lineIdx + 1) : null;
               this.flowComposer.getLineAt(lineIdx).hilitePointSelection(selFormat,selectionAbsoluteStart,this._container,prevLine,nextLine);
            }
         }
      }
      
      tlf_internal function clearSelectionShapes() : void
      {
         this.stopBlinkingCursor();
         var selectionSprite:DisplayObjectContainer = this.getSelectionSprite(false);
         if(selectionSprite != null)
         {
            if(selectionSprite.parent)
            {
               this.removeSelectionContainer(selectionSprite);
            }
            while(selectionSprite.numChildren > 0)
            {
               selectionSprite.removeChildAt(0);
            }
            return;
         }
      }
      
      tlf_internal function addSelectionChild(child:DisplayObject) : void
      {
         var selectionSprite:DisplayObjectContainer = this.getSelectionSprite(true);
         if(selectionSprite == null)
         {
            return;
         }
         var selFormat:SelectionFormat = this.interactionManager.currentSelectionFormat;
         var curBlendMode:String = this.interactionManager.activePosition == this.interactionManager.anchorPosition ? selFormat.pointBlendMode : selFormat.rangeBlendMode;
         var curAlpha:Number = this.interactionManager.activePosition == this.interactionManager.anchorPosition ? Number(selFormat.pointAlpha) : Number(selFormat.rangeAlpha);
         if(selectionSprite.blendMode != curBlendMode)
         {
            selectionSprite.blendMode = curBlendMode;
         }
         if(selectionSprite.alpha != curAlpha)
         {
            selectionSprite.alpha = 1;
         }
         if(selectionSprite.numChildren == 0)
         {
            this.addSelectionContainer(selectionSprite);
         }
         selectionSprite.addChild(child);
      }
      
      tlf_internal function containsSelectionChild(child:DisplayObject) : Boolean
      {
         var selectionSprite:DisplayObjectContainer = this.getSelectionSprite(false);
         if(selectionSprite == null)
         {
            return false;
         }
         return selectionSprite.contains(child);
      }
      
      tlf_internal function getBackgroundShape() : Shape
      {
         if(!this._backgroundShape)
         {
            this._backgroundShape = new Shape();
            this.addBackgroundShape(this._backgroundShape);
         }
         return this._backgroundShape;
      }
      
      tlf_internal function getEffectivePaddingLeft() : Number
      {
         return this.computedFormat.paddingLeft == FormatValue.AUTO ? Number(this.computedFormat.borderLeftWidth + this.computedFormat.marginLeft) : Number(this.computedFormat.paddingLeft + this.computedFormat.borderLeftWidth + this.computedFormat.marginLeft);
      }
      
      tlf_internal function getEffectivePaddingRight() : Number
      {
         return this.computedFormat.paddingRight == FormatValue.AUTO ? Number(this.computedFormat.borderRightWidth + this.computedFormat.marginRight) : Number(this.computedFormat.paddingRight + this.computedFormat.borderRightWidth + this.computedFormat.marginRight);
      }
      
      tlf_internal function getEffectivePaddingTop() : Number
      {
         return this.computedFormat.paddingTop == FormatValue.AUTO ? Number(this.computedFormat.borderTopWidth + this.computedFormat.marginTop) : Number(this.computedFormat.paddingTop + this.computedFormat.borderTopWidth + this.computedFormat.marginTop);
      }
      
      tlf_internal function getEffectivePaddingBottom() : Number
      {
         return this.computedFormat.paddingBottom == FormatValue.AUTO ? Number(this.computedFormat.borderBottomWidth + this.computedFormat.marginBottom) : Number(this.computedFormat.paddingBottom + this.computedFormat.borderBottomWidth + this.computedFormat.marginBottom);
      }
      
      tlf_internal function getTotalPaddingLeft() : Number
      {
         return this.getEffectivePaddingLeft() + (!!this._rootElement ? this._rootElement.getEffectivePaddingLeft() : 0);
      }
      
      tlf_internal function getTotalPaddingRight() : Number
      {
         return this.getEffectivePaddingRight() + (!!this._rootElement ? this._rootElement.getEffectivePaddingRight() : 0);
      }
      
      tlf_internal function getTotalPaddingTop() : Number
      {
         return this.getEffectivePaddingTop() + (!!this._rootElement ? this._rootElement.getEffectivePaddingTop() : 0);
      }
      
      tlf_internal function getTotalPaddingBottom() : Number
      {
         return this.getEffectivePaddingBottom() + (!!this._rootElement ? this._rootElement.getEffectivePaddingBottom() : 0);
      }
      
      tlf_internal function getSelectionSprite(createForDrawing:Boolean) : DisplayObjectContainer
      {
         if(createForDrawing)
         {
            if(this._selectionSprite == null)
            {
               this._selectionSprite = new Sprite();
               this._selectionSprite.mouseEnabled = false;
               this._selectionSprite.mouseChildren = false;
            }
         }
         return this._selectionSprite;
      }
      
      protected function get attachTransparentBackground() : Boolean
      {
         return true;
      }
      
      tlf_internal function clearCompositionResults() : void
      {
         var line:* = undefined;
         this.setTextLength(0);
         for each(line in this._shapeChildren)
         {
            if(line is TextLine)
            {
               this.removeTextLine(line as TextLine);
            }
            else
            {
               this.removeTableBlock(line as TableBlockContainer);
            }
         }
         this._shapeChildren.length = 0;
         this._linesInView.length = 0;
         if(this._floatsInContainer)
         {
            this._floatsInContainer.length = 0;
         }
         if(this._composedFloats)
         {
            this._composedFloats.length = 0;
         }
      }
      
      private function intersperseTableBlocks(targetArray:Array) : void
      {
         if(this._tableBlocksInView.length == 0)
         {
            return;
         }
         var blockIdx:int = 0;
         var startLoc:int = (this._tableBlocksInView[0] as TableBlockContainer).userData.parentTable.getAbsoluteStart();
         for(var i:int = 0; i < targetArray.length; i++)
         {
            if(targetArray[i].userData.absoluteStart >= startLoc)
            {
               targetArray.splice(i,0,this._tableBlocksInView[blockIdx++]);
               if(blockIdx == this._tableBlocksInView.length)
               {
                  break;
               }
            }
         }
         while(blockIdx < this._tableBlocksInView.length)
         {
            targetArray.push(this._tableBlocksInView[blockIdx++]);
         }
      }
      
      tlf_internal function updateCompositionShapes() : void
      {
         var firstLine:TextFlowLine = null;
         var prevLine:TextFlowLine = null;
         var prevTextLine:TextLine = null;
         var newChild:* = undefined;
         var newChildIdx:int = 0;
         if(!this.shapesInvalid)
         {
            return;
         }
         var originalYScroll:Number = this._yScroll;
         if(this.verticalScrollPolicy != ScrollPolicy.OFF && !this._measureHeight)
         {
            this._yScroll = this.computeVerticalScrollPosition(this._yScroll,false);
         }
         var originalXScroll:Number = this._xScroll;
         if(this.horizontalScrollPolicy != ScrollPolicy.OFF && !this._measureWidth)
         {
            this._xScroll = this.computeHorizontalScrollPosition(this._xScroll,false);
         }
         var scrolled:Boolean = originalYScroll != this._yScroll || originalXScroll != this._xScroll;
         if(scrolled)
         {
            this._linesInView.length = 0;
         }
         this.fillShapeChildren();
         var newShapeChildren:Array = this._linesInView;
         this.intersperseTableBlocks(newShapeChildren);
         var childIdx:int = this.getFirstTextLineChildIndex();
         var newIdx:int = 0;
         var shapeChildrenStartIdx:int = 0;
         if(this._updateStart > this.absoluteStart && newShapeChildren.length > 0)
         {
            firstLine = TextFlowLine(newShapeChildren[0].userData);
            prevLine = this.flowComposer.findLineAtPosition(firstLine.absoluteStart - 1);
            if(prevLine is TextFlowTableBlock)
            {
               shapeChildrenStartIdx = this._shapeChildren.indexOf((prevLine as TextFlowTableBlock).container);
            }
            else
            {
               prevTextLine = prevLine.peekTextLine();
               shapeChildrenStartIdx = this._shapeChildren.indexOf(prevTextLine);
            }
            if(shapeChildrenStartIdx >= 0)
            {
               shapeChildrenStartIdx++;
               childIdx += shapeChildrenStartIdx;
            }
            else
            {
               shapeChildrenStartIdx = 0;
            }
         }
         var oldIdx:int = shapeChildrenStartIdx;
         while(newIdx != newShapeChildren.length)
         {
            newChild = newShapeChildren[newIdx];
            if(newChild == this._shapeChildren[oldIdx])
            {
               childIdx++;
               newIdx++;
               oldIdx++;
               if(newChild is TableBlockContainer)
               {
                  (newChild as TableBlockContainer).userData.updateCompositionShapes();
               }
            }
            else
            {
               newChildIdx = this._shapeChildren.indexOf(newChild);
               if(newChild is TextLine)
               {
                  if(newChildIdx == -1)
                  {
                     this.addTextLine(newChild as TextLine,childIdx++);
                     newIdx++;
                  }
                  else
                  {
                     this.removeAndRecycleTextLines(oldIdx,newChildIdx);
                     oldIdx = newChildIdx;
                  }
               }
               else if(newChildIdx == -1)
               {
                  this.addTableBlock(newChild as TableBlockContainer,childIdx++);
                  newIdx++;
               }
               else
               {
                  (newChild as TableBlockContainer).userData.updateCompositionShapes();
                  this.removeAndRecycleTextLines(oldIdx,newChildIdx);
                  oldIdx = newChildIdx;
               }
            }
         }
         this.removeAndRecycleTextLines(oldIdx,this._shapeChildren.length);
         if(shapeChildrenStartIdx > 0)
         {
            this._shapeChildren.length = shapeChildrenStartIdx;
            this._shapeChildren = this._shapeChildren.concat(newShapeChildren);
            this._linesInView.length = 0;
         }
         else
         {
            this._linesInView = this._shapeChildren;
            this._linesInView.length = 0;
            this._shapeChildren = newShapeChildren;
         }
         if(this._floatsInContainer && this._floatsInContainer.length > 0 || this._composedFloats && this._composedFloats.length > 0)
         {
            this.updateGraphics(this._updateStart);
         }
         this.shapesInvalid = false;
         this.updateVisibleRectangle();
         var tf:TextFlow = this.textFlow;
         var needsCtrlKey:Boolean = this.interactionManager != null && this.interactionManager.editingMode == EditingMode.READ_WRITE;
         var firstVisibleLine:TextFlowLine = this.getFirstVisibleLine();
         var lastVisibleLine:TextFlowLine = this.getLastVisibleLine();
         scratchRectangle.left = this._contentLeft;
         scratchRectangle.top = this._contentTop;
         scratchRectangle.width = this._contentWidth;
         scratchRectangle.height = this._contentHeight;
         this._mouseEventManager.updateHitTests(this.effectiveBlockProgression == BlockProgression.RL && this._hasScrollRect ? Number(this._contentWidth) : Number(0),scratchRectangle,tf,!!firstVisibleLine ? int(firstVisibleLine.absoluteStart) : int(this._absoluteStart),!!lastVisibleLine ? int(lastVisibleLine.absoluteStart + lastVisibleLine.textLength - 1) : int(this._absoluteStart),this,needsCtrlKey);
         this._updateStart = this._rootElement.textLength;
         if(this._measureWidth || this._measureHeight)
         {
            this.attachTransparentBackgroundForHit(false);
         }
         if(tf.backgroundManager)
         {
            tf.backgroundManager.onUpdateComplete(this);
         }
         if(scrolled && tf.hasEventListener(TextLayoutEvent.SCROLL))
         {
            if(originalYScroll != this._yScroll)
            {
               tf.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL,false,false,ScrollEventDirection.VERTICAL,this._yScroll - originalYScroll));
            }
            if(originalXScroll != this._xScroll)
            {
               tf.dispatchEvent(new ScrollEvent(TextLayoutEvent.SCROLL,false,false,ScrollEventDirection.HORIZONTAL,this._xScroll - originalXScroll));
            }
         }
         if(tf.hasEventListener(UpdateCompleteEvent.UPDATE_COMPLETE))
         {
            tf.dispatchEvent(new UpdateCompleteEvent(UpdateCompleteEvent.UPDATE_COMPLETE,false,false,tf,this));
         }
      }
      
      tlf_internal function updateGraphics(updateStart:int) : void
      {
         var inlineHolder:DisplayObjectContainer = null;
         var floatInfo:FloatCompositionData = null;
         var float:DisplayObject = null;
         var m:int = 0;
         var parent:DisplayObjectContainer = null;
         var shouldDisplayGraphic:Boolean = false;
         var index:int = 0;
         var tl:TextLine = null;
         var tfl:TextFlowLine = null;
         var i:int = 0;
         var floatToRemove:DisplayObject = null;
         var visibleFloats:Array = [];
         var firstLine:TextFlowLine = this.getFirstVisibleLine();
         var lastLine:TextFlowLine = this.getLastVisibleLine();
         var firstVisiblePosition:int = !!firstLine ? int(firstLine.absoluteStart) : int(this.absoluteStart);
         var lastVisiblePosition:int = !!lastLine ? int(lastLine.absoluteStart + lastLine.textLength) : int(this.absoluteStart + this.textLength);
         var followingLine:TextFlowLine = this.flowComposer.findLineAtPosition(lastVisiblePosition);
         var lastPossibleFloatPosition:int = !!followingLine ? int(followingLine.absoluteStart + followingLine.textLength) : int(this.absoluteStart + this.textLength);
         lastPossibleFloatPosition = Math.min(lastPossibleFloatPosition,this.absoluteStart + this.textLength);
         lastPossibleFloatPosition = Math.min(lastPossibleFloatPosition,lastVisiblePosition + 2000);
         lastPossibleFloatPosition = Math.min(lastPossibleFloatPosition,this.flowComposer.damageAbsoluteStart);
         var wmode:String = this.effectiveBlockProgression;
         var width:Number = !!this._measureWidth ? Number(this._contentWidth) : Number(this._compositionWidth);
         var height:Number = !!this._measureHeight ? Number(this._contentHeight) : Number(this._compositionHeight);
         var adjustX:Number = wmode == BlockProgression.RL ? Number(this._xScroll - width) : Number(this._xScroll);
         var adjustY:Number = this._yScroll;
         var floatIndex:int = this.findFloatIndexAtOrAfter(updateStart);
         var containerListIndex:int = 0;
         var childIdx:int = this.getFirstTextLineChildIndex();
         if(floatIndex > 0)
         {
            floatInfo = this._composedFloats[floatIndex - 1];
            containerListIndex = this._floatsInContainer.indexOf(floatInfo.graphic);
            while(containerListIndex == -1 && floatIndex > 0)
            {
               floatIndex--;
               floatInfo = this._composedFloats[floatIndex];
               containerListIndex = this._floatsInContainer.indexOf(floatInfo.graphic);
            }
            containerListIndex++;
            for(m = 0; m < floatIndex; m++)
            {
               if(this._composedFloats[m].absolutePosition >= this.absoluteStart)
               {
                  visibleFloats.push(this._composedFloats[m].graphic);
               }
            }
         }
         var firstContainerListIndex:int = containerListIndex;
         if(!this._floatsInContainer)
         {
            this._floatsInContainer = [];
         }
         var numContainerList:int = this._floatsInContainer.length;
         var numFloats:int = this._composedFloats.length;
         while(floatIndex < numFloats)
         {
            floatInfo = this._composedFloats[floatIndex];
            float = floatInfo.graphic;
            parent = floatInfo.parent;
            if(!float)
            {
               shouldDisplayGraphic = false;
            }
            else if(floatInfo.floatType == Float.NONE)
            {
               shouldDisplayGraphic = floatInfo.absolutePosition >= firstVisiblePosition && floatInfo.absolutePosition < lastVisiblePosition;
            }
            else
            {
               shouldDisplayGraphic = this.floatIsVisible(wmode,adjustX,adjustY,width,height,floatInfo) && floatInfo.absolutePosition < lastPossibleFloatPosition && floatInfo.absolutePosition >= this.absoluteStart;
            }
            if(!shouldDisplayGraphic)
            {
               if(floatInfo.absolutePosition >= lastPossibleFloatPosition)
               {
                  break;
               }
               floatIndex++;
            }
            else
            {
               if(visibleFloats.indexOf(float) < 0)
               {
                  visibleFloats.push(float);
               }
               if(floatInfo.floatType == Float.NONE)
               {
                  tl = parent as TextLine;
                  if(tl)
                  {
                     tfl = tl.userData as TextFlowLine;
                     if(!tfl || floatInfo.absolutePosition < tfl.absoluteStart || floatInfo.absolutePosition >= tfl.absoluteStart + tfl.textLength || tl.parent == null || tl.validity == TextLineValidity.INVALID)
                     {
                        tfl = this.flowComposer.findLineAtPosition(floatInfo.absolutePosition);
                        for(i = 0; i < this._shapeChildren.length; i++)
                        {
                           if((this._shapeChildren[i] as TextLine).userData == tfl)
                           {
                              break;
                           }
                        }
                        parent = i < this._shapeChildren.length ? this._shapeChildren[i] : null;
                     }
                  }
               }
               inlineHolder = float.parent;
               if(containerListIndex < numContainerList && floatInfo.parent == this._container && inlineHolder && inlineHolder.parent == this._container && float == this._floatsInContainer[containerListIndex])
               {
                  if(floatInfo.matrix)
                  {
                     inlineHolder.transform.matrix = floatInfo.matrix;
                  }
                  else
                  {
                     inlineHolder.x = 0;
                     inlineHolder.y = 0;
                  }
                  inlineHolder.alpha = floatInfo.alpha;
                  inlineHolder.x += floatInfo.x;
                  inlineHolder.y += floatInfo.y;
                  floatIndex++;
                  containerListIndex++;
               }
               else
               {
                  index = this._floatsInContainer.indexOf(float);
                  if(index > containerListIndex && parent == this._container)
                  {
                     floatToRemove = this._floatsInContainer[containerListIndex++];
                     if(floatToRemove.parent)
                     {
                        this.removeInlineGraphicElement(floatInfo.parent,floatToRemove.parent);
                     }
                  }
                  else
                  {
                     if(containerListIndex < numContainerList && float == this._floatsInContainer[containerListIndex])
                     {
                        containerListIndex++;
                     }
                     inlineHolder = new Sprite();
                     if(floatInfo.matrix)
                     {
                        inlineHolder.transform.matrix = floatInfo.matrix;
                     }
                     inlineHolder.alpha = floatInfo.alpha;
                     inlineHolder.x += floatInfo.x;
                     inlineHolder.y += floatInfo.y;
                     inlineHolder.addChild(float);
                     if(parent == this._container)
                     {
                        childIdx = Math.min(childIdx,this._container.numChildren);
                        this.addInlineGraphicElement(this._container,inlineHolder,childIdx++);
                     }
                     else
                     {
                        this.addInlineGraphicElement(parent,inlineHolder,0);
                     }
                     floatIndex++;
                  }
               }
            }
         }
         while(containerListIndex < this._floatsInContainer.length)
         {
            float = this._floatsInContainer[containerListIndex++];
            if(float.parent && visibleFloats.indexOf(float) < 0)
            {
               this.removeInlineGraphicElement(float.parent.parent,float.parent);
            }
         }
         this._floatsInContainer = visibleFloats;
      }
      
      private function floatIsVisible(wmode:String, scrollX:Number, scrollY:Number, scrollWidth:Number, scrollHeight:Number, floatInfo:FloatCompositionData) : Boolean
      {
         var inlineGraphicElement:InlineGraphicElement = this.textFlow.findLeaf(floatInfo.absolutePosition) as InlineGraphicElement;
         return wmode == BlockProgression.TB ? floatInfo.y + inlineGraphicElement.elementHeight >= scrollY && floatInfo.y <= scrollY + scrollHeight : floatInfo.x + inlineGraphicElement.elementWidth >= scrollX && floatInfo.x <= scrollX + scrollWidth;
      }
      
      private function releaseLinesInBlock(textBlock:TextBlock) : void
      {
         var para:ParagraphElement = null;
         var line:TextFlowLine = null;
         var textLine:TextLine = textBlock.firstLine;
         while(textLine && textLine.parent == null)
         {
            textLine = textLine.nextLine;
         }
         if(!textLine && textBlock.firstLine)
         {
            line = textBlock.firstLine.userData as TextFlowLine;
            if(line)
            {
               para = line.paragraph;
            }
            textBlock.releaseLines(textBlock.firstLine,textBlock.lastLine);
            if(para)
            {
               para.releaseTextBlock();
            }
         }
      }
      
      private function removeAndRecycleTextLines(beginIndex:int, endIndex:int) : void
      {
         var child:TextLine = null;
         var textBlock:TextBlock = null;
         var tfl:TextFlowLine = null;
         var backgroundManager:BackgroundManager = this.textFlow.backgroundManager;
         for(var index:int = beginIndex; index < endIndex; index++)
         {
            if(!(this._shapeChildren[index] is TextLine))
            {
               this.removeTableBlock(this._shapeChildren[index]);
               child = null;
            }
            else
            {
               child = this._shapeChildren[index];
               this.removeTextLine(child);
               if(child.textBlock != textBlock)
               {
                  if(textBlock)
                  {
                     this.releaseLinesInBlock(textBlock);
                  }
                  textBlock = child.textBlock;
               }
            }
         }
         if(textBlock && (textBlock.lastLine == child || this.flowComposer.getControllerAt(this.flowComposer.numControllers - 1) == this))
         {
            this.releaseLinesInBlock(textBlock);
         }
         if(TextLineRecycler.textLineRecyclerEnabled)
         {
            while(beginIndex < endIndex)
            {
               if(!(this._shapeChildren[beginIndex] is TextLine))
               {
                  beginIndex++;
               }
               else
               {
                  child = this._shapeChildren[beginIndex++];
                  if(!child.parent)
                  {
                     if(child.userData == null)
                     {
                        TextLineRecycler.addLineForReuse(child);
                        if(backgroundManager)
                        {
                           backgroundManager.removeLineFromCache(child);
                        }
                     }
                     else
                     {
                        tfl = child.userData as TextFlowLine;
                        if(!(tfl && tfl.controller != this))
                        {
                           if(child.validity == TextLineValidity.INVALID || child.nextLine == null && child.previousLine == null && (!child.textBlock || child.textBlock.firstLine != child))
                           {
                              child.userData = null;
                              TextLineRecycler.addLineForReuse(child);
                              if(backgroundManager)
                              {
                                 backgroundManager.removeLineFromCache(child);
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      protected function getFirstTextLineChildIndex() : int
      {
         var firstTextLine:int = 0;
         for(firstTextLine = 0; firstTextLine < this._container.numChildren; firstTextLine++)
         {
            if(this._container.getChildAt(firstTextLine) is TextLine)
            {
               break;
            }
            if(this._container.getChildAt(firstTextLine) is TableBlockContainer)
            {
               break;
            }
         }
         return firstTextLine;
      }
      
      protected function addTextLine(textLine:TextLine, index:int) : void
      {
         if(index > this._container.numChildren)
         {
            index = this._container.numChildren;
         }
         this._container.addChildAt(textLine,index);
      }
      
      protected function removeTextLine(textLine:TextLine) : void
      {
         if(this._container.contains(textLine))
         {
            this._container.removeChild(textLine);
         }
      }
      
      protected function addTableBlock(block:TableBlockContainer, index:int) : void
      {
         if(index > this._container.numChildren)
         {
            index = this._container.numChildren;
         }
         this._container.addChildAt(block,index);
         block.userData.updateCompositionShapes();
      }
      
      protected function removeTableBlock(block:TableBlockContainer) : void
      {
         if(this._container.contains(block))
         {
            this._container.removeChild(block);
         }
      }
      
      protected function addBackgroundShape(shape:Shape) : void
      {
         this._container.addChildAt(this._backgroundShape,this.getFirstTextLineChildIndex());
      }
      
      protected function removeBackgroundShape(shape:Shape) : void
      {
         if(shape.parent)
         {
            shape.parent.removeChild(shape);
         }
      }
      
      protected function addSelectionContainer(selectionContainer:DisplayObjectContainer) : void
      {
         if(selectionContainer.blendMode == BlendMode.NORMAL && selectionContainer.alpha == 1)
         {
            this._container.addChildAt(selectionContainer,this.getFirstTextLineChildIndex());
         }
         else
         {
            this._container.addChild(selectionContainer);
         }
      }
      
      protected function removeSelectionContainer(selectionContainer:DisplayObjectContainer) : void
      {
         selectionContainer.parent.removeChild(selectionContainer);
      }
      
      protected function addInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject, index:int) : void
      {
         if(parent)
         {
            parent.addChildAt(inlineGraphicElement,index);
         }
      }
      
      protected function removeInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject) : void
      {
         if(null != parent && inlineGraphicElement.parent == parent)
         {
            parent.removeChild(inlineGraphicElement);
         }
      }
      
      tlf_internal function get textLines() : Array
      {
         return this._shapeChildren;
      }
      
      protected function updateVisibleRectangle() : void
      {
         var contentRight:Number = NaN;
         var contentBottom:Number = NaN;
         var width:Number = NaN;
         var compositionRight:Number = NaN;
         var height:Number = NaN;
         var compositionBottom:Number = NaN;
         var xOrigin:Number = NaN;
         var xpos:int = 0;
         var ypos:int = 0;
         var rect:Rectangle = null;
         if(this.horizontalScrollPolicy == ScrollPolicy.OFF && this.verticalScrollPolicy == ScrollPolicy.OFF)
         {
            if(this._hasScrollRect)
            {
               this._container.scrollRect = null;
               this._hasScrollRect = false;
            }
         }
         else
         {
            contentRight = this._contentLeft + this.contentWidth;
            contentBottom = this._contentTop + this.contentHeight;
            if(this._measureWidth)
            {
               width = this.contentWidth;
               compositionRight = this._contentLeft + width;
            }
            else
            {
               width = this._compositionWidth;
               compositionRight = width;
            }
            if(this._measureHeight)
            {
               height = this.contentHeight;
               compositionBottom = this._contentTop + height;
            }
            else
            {
               height = this._compositionHeight;
               compositionBottom = height;
            }
            xOrigin = this.effectiveBlockProgression == BlockProgression.RL ? Number(-width) : Number(0);
            xpos = this.horizontalScrollPosition + xOrigin;
            ypos = this.verticalScrollPosition;
            if(!this._hasScrollRect)
            {
               this._container.scrollRect = null;
            }
            if(this.textLength == 0 || xpos == 0 && ypos == 0 && this._contentLeft >= xOrigin && this._contentTop >= 0 && contentRight <= compositionRight && contentBottom <= compositionBottom)
            {
               if(this._hasScrollRect)
               {
                  this._container.scrollRect = null;
                  this._hasScrollRect = false;
               }
            }
            else
            {
               rect = this._container.scrollRect;
               if(!rect || rect.x != xpos || rect.y != ypos || rect.width != width || rect.height != height)
               {
                  this._container.scrollRect = new Rectangle(xpos,ypos,width,height);
                  this._hasScrollRect = true;
               }
            }
         }
         this.attachTransparentBackgroundForHit(false);
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get columnBreakBefore() : *
      {
         return !!this._format ? this._format.columnBreakBefore : undefined;
      }
      
      public function set columnBreakBefore(columnBreakBeforeValue:*) : void
      {
         this.writableTextLayoutFormat().columnBreakBefore = columnBreakBeforeValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get columnBreakAfter() : *
      {
         return !!this._format ? this._format.columnBreakAfter : undefined;
      }
      
      public function set columnBreakAfter(columnBreakAfterValue:*) : void
      {
         this.writableTextLayoutFormat().columnBreakAfter = columnBreakAfterValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get containerBreakBefore() : *
      {
         return !!this._format ? this._format.containerBreakBefore : undefined;
      }
      
      public function set containerBreakBefore(containerBreakBeforeValue:*) : void
      {
         this.writableTextLayoutFormat().containerBreakBefore = containerBreakBeforeValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get containerBreakAfter() : *
      {
         return !!this._format ? this._format.containerBreakAfter : undefined;
      }
      
      public function set containerBreakAfter(containerBreakAfterValue:*) : void
      {
         this.writableTextLayoutFormat().containerBreakAfter = containerBreakAfterValue;
         this.formatChanged();
      }
      
      public function get color() : *
      {
         return !!this._format ? this._format.color : undefined;
      }
      
      public function set color(colorValue:*) : void
      {
         this.writableTextLayoutFormat().color = colorValue;
         this.formatChanged();
      }
      
      public function get backgroundColor() : *
      {
         return !!this._format ? this._format.backgroundColor : undefined;
      }
      
      public function set backgroundColor(backgroundColorValue:*) : void
      {
         this.writableTextLayoutFormat().backgroundColor = backgroundColorValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="true,false,inherit")]
      public function get lineThrough() : *
      {
         return !!this._format ? this._format.lineThrough : undefined;
      }
      
      public function set lineThrough(lineThroughValue:*) : void
      {
         this.writableTextLayoutFormat().lineThrough = lineThroughValue;
         this.formatChanged();
      }
      
      public function get textAlpha() : *
      {
         return !!this._format ? this._format.textAlpha : undefined;
      }
      
      public function set textAlpha(textAlphaValue:*) : void
      {
         this.writableTextLayoutFormat().textAlpha = textAlphaValue;
         this.formatChanged();
      }
      
      public function get backgroundAlpha() : *
      {
         return !!this._format ? this._format.backgroundAlpha : undefined;
      }
      
      public function set backgroundAlpha(backgroundAlphaValue:*) : void
      {
         this.writableTextLayoutFormat().backgroundAlpha = backgroundAlphaValue;
         this.formatChanged();
      }
      
      public function get fontSize() : *
      {
         return !!this._format ? this._format.fontSize : undefined;
      }
      
      public function set fontSize(fontSizeValue:*) : void
      {
         this.writableTextLayoutFormat().fontSize = fontSizeValue;
         this.formatChanged();
      }
      
      public function get baselineShift() : *
      {
         return !!this._format ? this._format.baselineShift : undefined;
      }
      
      public function set baselineShift(baselineShiftValue:*) : void
      {
         this.writableTextLayoutFormat().baselineShift = baselineShiftValue;
         this.formatChanged();
      }
      
      public function get trackingLeft() : *
      {
         return !!this._format ? this._format.trackingLeft : undefined;
      }
      
      public function set trackingLeft(trackingLeftValue:*) : void
      {
         this.writableTextLayoutFormat().trackingLeft = trackingLeftValue;
         this.formatChanged();
      }
      
      public function get trackingRight() : *
      {
         return !!this._format ? this._format.trackingRight : undefined;
      }
      
      public function set trackingRight(trackingRightValue:*) : void
      {
         this.writableTextLayoutFormat().trackingRight = trackingRightValue;
         this.formatChanged();
      }
      
      public function get lineHeight() : *
      {
         return !!this._format ? this._format.lineHeight : undefined;
      }
      
      public function set lineHeight(lineHeightValue:*) : void
      {
         this.writableTextLayoutFormat().lineHeight = lineHeightValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="all,any,auto,none,inherit")]
      public function get breakOpportunity() : *
      {
         return !!this._format ? this._format.breakOpportunity : undefined;
      }
      
      public function set breakOpportunity(breakOpportunityValue:*) : void
      {
         this.writableTextLayoutFormat().breakOpportunity = breakOpportunityValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="default,lining,oldStyle,inherit")]
      public function get digitCase() : *
      {
         return !!this._format ? this._format.digitCase : undefined;
      }
      
      public function set digitCase(digitCaseValue:*) : void
      {
         this.writableTextLayoutFormat().digitCase = digitCaseValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="default,proportional,tabular,inherit")]
      public function get digitWidth() : *
      {
         return !!this._format ? this._format.digitWidth : undefined;
      }
      
      public function set digitWidth(digitWidthValue:*) : void
      {
         this.writableTextLayoutFormat().digitWidth = digitWidthValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="auto,roman,ascent,descent,ideographicTop,ideographicCenter,ideographicBottom,inherit")]
      public function get dominantBaseline() : *
      {
         return !!this._format ? this._format.dominantBaseline : undefined;
      }
      
      public function set dominantBaseline(dominantBaselineValue:*) : void
      {
         this.writableTextLayoutFormat().dominantBaseline = dominantBaselineValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="on,off,auto,inherit")]
      public function get kerning() : *
      {
         return !!this._format ? this._format.kerning : undefined;
      }
      
      public function set kerning(kerningValue:*) : void
      {
         this.writableTextLayoutFormat().kerning = kerningValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="minimum,common,uncommon,exotic,inherit")]
      public function get ligatureLevel() : *
      {
         return !!this._format ? this._format.ligatureLevel : undefined;
      }
      
      public function set ligatureLevel(ligatureLevelValue:*) : void
      {
         this.writableTextLayoutFormat().ligatureLevel = ligatureLevelValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="roman,ascent,descent,ideographicTop,ideographicCenter,ideographicBottom,useDominantBaseline,inherit")]
      public function get alignmentBaseline() : *
      {
         return !!this._format ? this._format.alignmentBaseline : undefined;
      }
      
      public function set alignmentBaseline(alignmentBaselineValue:*) : void
      {
         this.writableTextLayoutFormat().alignmentBaseline = alignmentBaselineValue;
         this.formatChanged();
      }
      
      public function get locale() : *
      {
         return !!this._format ? this._format.locale : undefined;
      }
      
      public function set locale(localeValue:*) : void
      {
         this.writableTextLayoutFormat().locale = localeValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="default,capsToSmallCaps,uppercase,lowercase,lowercaseToSmallCaps,inherit")]
      public function get typographicCase() : *
      {
         return !!this._format ? this._format.typographicCase : undefined;
      }
      
      public function set typographicCase(typographicCaseValue:*) : void
      {
         this.writableTextLayoutFormat().typographicCase = typographicCaseValue;
         this.formatChanged();
      }
      
      public function get fontFamily() : *
      {
         return !!this._format ? this._format.fontFamily : undefined;
      }
      
      public function set fontFamily(fontFamilyValue:*) : void
      {
         this.writableTextLayoutFormat().fontFamily = fontFamilyValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="none,underline,inherit")]
      public function get textDecoration() : *
      {
         return !!this._format ? this._format.textDecoration : undefined;
      }
      
      public function set textDecoration(textDecorationValue:*) : void
      {
         this.writableTextLayoutFormat().textDecoration = textDecorationValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="normal,bold,inherit")]
      public function get fontWeight() : *
      {
         return !!this._format ? this._format.fontWeight : undefined;
      }
      
      public function set fontWeight(fontWeightValue:*) : void
      {
         this.writableTextLayoutFormat().fontWeight = fontWeightValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="normal,italic,inherit")]
      public function get fontStyle() : *
      {
         return !!this._format ? this._format.fontStyle : undefined;
      }
      
      public function set fontStyle(fontStyleValue:*) : void
      {
         this.writableTextLayoutFormat().fontStyle = fontStyleValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="preserve,collapse,inherit")]
      public function get whiteSpaceCollapse() : *
      {
         return !!this._format ? this._format.whiteSpaceCollapse : undefined;
      }
      
      public function set whiteSpaceCollapse(whiteSpaceCollapseValue:*) : void
      {
         this.writableTextLayoutFormat().whiteSpaceCollapse = whiteSpaceCollapseValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="normal,cff,inherit")]
      public function get renderingMode() : *
      {
         return !!this._format ? this._format.renderingMode : undefined;
      }
      
      public function set renderingMode(renderingModeValue:*) : void
      {
         this.writableTextLayoutFormat().renderingMode = renderingModeValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="none,horizontalStem,inherit")]
      public function get cffHinting() : *
      {
         return !!this._format ? this._format.cffHinting : undefined;
      }
      
      public function set cffHinting(cffHintingValue:*) : void
      {
         this.writableTextLayoutFormat().cffHinting = cffHintingValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="device,embeddedCFF,inherit")]
      public function get fontLookup() : *
      {
         return !!this._format ? this._format.fontLookup : undefined;
      }
      
      public function set fontLookup(fontLookupValue:*) : void
      {
         this.writableTextLayoutFormat().fontLookup = fontLookupValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="rotate0,rotate180,rotate270,rotate90,auto,inherit")]
      public function get textRotation() : *
      {
         return !!this._format ? this._format.textRotation : undefined;
      }
      
      public function set textRotation(textRotationValue:*) : void
      {
         this.writableTextLayoutFormat().textRotation = textRotationValue;
         this.formatChanged();
      }
      
      public function get textIndent() : *
      {
         return !!this._format ? this._format.textIndent : undefined;
      }
      
      public function set textIndent(textIndentValue:*) : void
      {
         this.writableTextLayoutFormat().textIndent = textIndentValue;
         this.formatChanged();
      }
      
      public function get paragraphStartIndent() : *
      {
         return !!this._format ? this._format.paragraphStartIndent : undefined;
      }
      
      public function set paragraphStartIndent(paragraphStartIndentValue:*) : void
      {
         this.writableTextLayoutFormat().paragraphStartIndent = paragraphStartIndentValue;
         this.formatChanged();
      }
      
      public function get paragraphEndIndent() : *
      {
         return !!this._format ? this._format.paragraphEndIndent : undefined;
      }
      
      public function set paragraphEndIndent(paragraphEndIndentValue:*) : void
      {
         this.writableTextLayoutFormat().paragraphEndIndent = paragraphEndIndentValue;
         this.formatChanged();
      }
      
      public function get paragraphSpaceBefore() : *
      {
         return !!this._format ? this._format.paragraphSpaceBefore : undefined;
      }
      
      public function set paragraphSpaceBefore(paragraphSpaceBeforeValue:*) : void
      {
         this.writableTextLayoutFormat().paragraphSpaceBefore = paragraphSpaceBeforeValue;
         this.formatChanged();
      }
      
      public function get paragraphSpaceAfter() : *
      {
         return !!this._format ? this._format.paragraphSpaceAfter : undefined;
      }
      
      public function set paragraphSpaceAfter(paragraphSpaceAfterValue:*) : void
      {
         this.writableTextLayoutFormat().paragraphSpaceAfter = paragraphSpaceAfterValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="left,right,center,justify,start,end,inherit")]
      public function get textAlign() : *
      {
         return !!this._format ? this._format.textAlign : undefined;
      }
      
      public function set textAlign(textAlignValue:*) : void
      {
         this.writableTextLayoutFormat().textAlign = textAlignValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="left,right,center,justify,start,end,inherit")]
      public function get textAlignLast() : *
      {
         return !!this._format ? this._format.textAlignLast : undefined;
      }
      
      public function set textAlignLast(textAlignLastValue:*) : void
      {
         this.writableTextLayoutFormat().textAlignLast = textAlignLastValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="interWord,distribute,inherit")]
      public function get textJustify() : *
      {
         return !!this._format ? this._format.textJustify : undefined;
      }
      
      public function set textJustify(textJustifyValue:*) : void
      {
         this.writableTextLayoutFormat().textJustify = textJustifyValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="eastAsian,space,auto,inherit")]
      public function get justificationRule() : *
      {
         return !!this._format ? this._format.justificationRule : undefined;
      }
      
      public function set justificationRule(justificationRuleValue:*) : void
      {
         this.writableTextLayoutFormat().justificationRule = justificationRuleValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="prioritizeLeastAdjustment,pushInKinsoku,pushOutOnly,auto,inherit")]
      public function get justificationStyle() : *
      {
         return !!this._format ? this._format.justificationStyle : undefined;
      }
      
      public function set justificationStyle(justificationStyleValue:*) : void
      {
         this.writableTextLayoutFormat().justificationStyle = justificationStyleValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="ltr,rtl,inherit")]
      public function get direction() : *
      {
         return !!this._format ? this._format.direction : undefined;
      }
      
      public function set direction(directionValue:*) : void
      {
         this.writableTextLayoutFormat().direction = directionValue;
         this.formatChanged();
      }
      
      public function get wordSpacing() : *
      {
         return !!this._format ? this._format.wordSpacing : undefined;
      }
      
      public function set wordSpacing(wordSpacingValue:*) : void
      {
         this.writableTextLayoutFormat().wordSpacing = wordSpacingValue;
         this.formatChanged();
      }
      
      public function get tabStops() : *
      {
         return !!this._format ? this._format.tabStops : undefined;
      }
      
      public function set tabStops(tabStopsValue:*) : void
      {
         this.writableTextLayoutFormat().tabStops = tabStopsValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="romanUp,ideographicTopUp,ideographicCenterUp,ideographicTopDown,ideographicCenterDown,approximateTextField,ascentDescentUp,box,auto,inherit")]
      public function get leadingModel() : *
      {
         return !!this._format ? this._format.leadingModel : undefined;
      }
      
      public function set leadingModel(leadingModelValue:*) : void
      {
         this.writableTextLayoutFormat().leadingModel = leadingModelValue;
         this.formatChanged();
      }
      
      public function get columnGap() : *
      {
         return !!this._format ? this._format.columnGap : undefined;
      }
      
      public function set columnGap(columnGapValue:*) : void
      {
         this.writableTextLayoutFormat().columnGap = columnGapValue;
         this.formatChanged();
      }
      
      public function get paddingLeft() : *
      {
         return !!this._format ? this._format.paddingLeft : undefined;
      }
      
      public function set paddingLeft(paddingLeftValue:*) : void
      {
         this.writableTextLayoutFormat().paddingLeft = paddingLeftValue;
         this.formatChanged();
      }
      
      public function get paddingTop() : *
      {
         return !!this._format ? this._format.paddingTop : undefined;
      }
      
      public function set paddingTop(paddingTopValue:*) : void
      {
         this.writableTextLayoutFormat().paddingTop = paddingTopValue;
         this.formatChanged();
      }
      
      public function get paddingRight() : *
      {
         return !!this._format ? this._format.paddingRight : undefined;
      }
      
      public function set paddingRight(paddingRightValue:*) : void
      {
         this.writableTextLayoutFormat().paddingRight = paddingRightValue;
         this.formatChanged();
      }
      
      public function get paddingBottom() : *
      {
         return !!this._format ? this._format.paddingBottom : undefined;
      }
      
      public function set paddingBottom(paddingBottomValue:*) : void
      {
         this.writableTextLayoutFormat().paddingBottom = paddingBottomValue;
         this.formatChanged();
      }
      
      public function get columnCount() : *
      {
         return !!this._format ? this._format.columnCount : undefined;
      }
      
      public function set columnCount(columnCountValue:*) : void
      {
         this.writableTextLayoutFormat().columnCount = columnCountValue;
         this.formatChanged();
      }
      
      public function get columnWidth() : *
      {
         return !!this._format ? this._format.columnWidth : undefined;
      }
      
      public function set columnWidth(columnWidthValue:*) : void
      {
         this.writableTextLayoutFormat().columnWidth = columnWidthValue;
         this.formatChanged();
      }
      
      public function get firstBaselineOffset() : *
      {
         return !!this._format ? this._format.firstBaselineOffset : undefined;
      }
      
      public function set firstBaselineOffset(firstBaselineOffsetValue:*) : void
      {
         this.writableTextLayoutFormat().firstBaselineOffset = firstBaselineOffsetValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="top,middle,bottom,justify,inherit")]
      public function get verticalAlign() : *
      {
         return !!this._format ? this._format.verticalAlign : undefined;
      }
      
      public function set verticalAlign(verticalAlignValue:*) : void
      {
         this.writableTextLayoutFormat().verticalAlign = verticalAlignValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="rl,tb,inherit")]
      public function get blockProgression() : *
      {
         return !!this._format ? this._format.blockProgression : undefined;
      }
      
      public function set blockProgression(blockProgressionValue:*) : void
      {
         this.writableTextLayoutFormat().blockProgression = blockProgressionValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="explicit,toFit,inherit")]
      public function get lineBreak() : *
      {
         return !!this._format ? this._format.lineBreak : undefined;
      }
      
      public function set lineBreak(lineBreakValue:*) : void
      {
         this.writableTextLayoutFormat().lineBreak = lineBreakValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="upperAlpha,lowerAlpha,upperRoman,lowerRoman,none,disc,circle,square,box,check,diamond,hyphen,arabicIndic,bengali,decimal,decimalLeadingZero,devanagari,gujarati,gurmukhi,kannada,persian,thai,urdu,cjkEarthlyBranch,cjkHeavenlyStem,hangul,hangulConstant,hiragana,hiraganaIroha,katakana,katakanaIroha,lowerAlpha,lowerGreek,lowerLatin,upperAlpha,upperGreek,upperLatin,inherit")]
      public function get listStyleType() : *
      {
         return !!this._format ? this._format.listStyleType : undefined;
      }
      
      public function set listStyleType(listStyleTypeValue:*) : void
      {
         this.writableTextLayoutFormat().listStyleType = listStyleTypeValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="inside,outside,inherit")]
      public function get listStylePosition() : *
      {
         return !!this._format ? this._format.listStylePosition : undefined;
      }
      
      public function set listStylePosition(listStylePositionValue:*) : void
      {
         this.writableTextLayoutFormat().listStylePosition = listStylePositionValue;
         this.formatChanged();
      }
      
      public function get listAutoPadding() : *
      {
         return !!this._format ? this._format.listAutoPadding : undefined;
      }
      
      public function set listAutoPadding(listAutoPaddingValue:*) : void
      {
         this.writableTextLayoutFormat().listAutoPadding = listAutoPaddingValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="start,end,left,right,both,none,inherit")]
      public function get clearFloats() : *
      {
         return !!this._format ? this._format.clearFloats : undefined;
      }
      
      public function set clearFloats(clearFloatsValue:*) : void
      {
         this.writableTextLayoutFormat().clearFloats = clearFloatsValue;
         this.formatChanged();
      }
      
      public function get styleName() : *
      {
         return !!this._format ? this._format.styleName : undefined;
      }
      
      public function set styleName(styleNameValue:*) : void
      {
         this.writableTextLayoutFormat().styleName = styleNameValue;
         this.styleSelectorChanged();
      }
      
      public function get linkNormalFormat() : *
      {
         return !!this._format ? this._format.linkNormalFormat : undefined;
      }
      
      public function set linkNormalFormat(linkNormalFormatValue:*) : void
      {
         this.writableTextLayoutFormat().linkNormalFormat = linkNormalFormatValue;
         this.formatChanged();
      }
      
      public function get linkActiveFormat() : *
      {
         return !!this._format ? this._format.linkActiveFormat : undefined;
      }
      
      public function set linkActiveFormat(linkActiveFormatValue:*) : void
      {
         this.writableTextLayoutFormat().linkActiveFormat = linkActiveFormatValue;
         this.formatChanged();
      }
      
      public function get linkHoverFormat() : *
      {
         return !!this._format ? this._format.linkHoverFormat : undefined;
      }
      
      public function set linkHoverFormat(linkHoverFormatValue:*) : void
      {
         this.writableTextLayoutFormat().linkHoverFormat = linkHoverFormatValue;
         this.formatChanged();
      }
      
      public function get listMarkerFormat() : *
      {
         return !!this._format ? this._format.listMarkerFormat : undefined;
      }
      
      public function set listMarkerFormat(listMarkerFormatValue:*) : void
      {
         this.writableTextLayoutFormat().listMarkerFormat = listMarkerFormatValue;
         this.formatChanged();
      }
      
      public function get borderLeftWidth() : *
      {
         return !!this._format ? this._format.borderLeftWidth : undefined;
      }
      
      public function set borderLeftWidth(borderLeftWidthValue:*) : void
      {
         this.writableTextLayoutFormat().borderLeftWidth = borderLeftWidthValue;
         this.formatChanged();
      }
      
      public function get borderRightWidth() : *
      {
         return !!this._format ? this._format.borderRightWidth : undefined;
      }
      
      public function set borderRightWidth(borderRightWidthValue:*) : void
      {
         this.writableTextLayoutFormat().borderRightWidth = borderRightWidthValue;
         this.formatChanged();
      }
      
      public function get borderTopWidth() : *
      {
         return !!this._format ? this._format.borderTopWidth : undefined;
      }
      
      public function set borderTopWidth(borderTopWidthValue:*) : void
      {
         this.writableTextLayoutFormat().borderTopWidth = borderTopWidthValue;
         this.formatChanged();
      }
      
      public function get borderBottomWidth() : *
      {
         return !!this._format ? this._format.borderBottomWidth : undefined;
      }
      
      public function set borderBottomWidth(borderBottomWidthValue:*) : void
      {
         this.writableTextLayoutFormat().borderBottomWidth = borderBottomWidthValue;
         this.formatChanged();
      }
      
      public function get borderLeftColor() : *
      {
         return !!this._format ? this._format.borderLeftColor : undefined;
      }
      
      public function set borderLeftColor(borderLeftColorValue:*) : void
      {
         this.writableTextLayoutFormat().borderLeftColor = borderLeftColorValue;
         this.formatChanged();
      }
      
      public function get borderRightColor() : *
      {
         return !!this._format ? this._format.borderRightColor : undefined;
      }
      
      public function set borderRightColor(borderRightColorValue:*) : void
      {
         this.writableTextLayoutFormat().borderRightColor = borderRightColorValue;
         this.formatChanged();
      }
      
      public function get borderTopColor() : *
      {
         return !!this._format ? this._format.borderTopColor : undefined;
      }
      
      public function set borderTopColor(borderTopColorValue:*) : void
      {
         this.writableTextLayoutFormat().borderTopColor = borderTopColorValue;
         this.formatChanged();
      }
      
      public function get borderBottomColor() : *
      {
         return !!this._format ? this._format.borderBottomColor : undefined;
      }
      
      public function set borderBottomColor(borderBottomColorValue:*) : void
      {
         this.writableTextLayoutFormat().borderBottomColor = borderBottomColorValue;
         this.formatChanged();
      }
      
      public function get borderLeftPriority() : *
      {
         return !!this._format ? this._format.borderLeftPriority : undefined;
      }
      
      public function set borderLeftPriority(value:*) : void
      {
         this.writableTextLayoutFormat().borderLeftPriority = value;
         this.formatChanged();
      }
      
      public function get borderRightPriority() : *
      {
         return !!this._format ? this._format.borderRightPriority : undefined;
      }
      
      public function set borderRightPriority(value:*) : void
      {
         this.writableTextLayoutFormat().borderRightPriority = value;
         this.formatChanged();
      }
      
      public function get borderTopPriority() : *
      {
         return !!this._format ? this._format.borderTopPriority : undefined;
      }
      
      public function set borderTopPriority(value:*) : void
      {
         this.writableTextLayoutFormat().borderTopPriority = value;
         this.formatChanged();
      }
      
      public function get borderBottomPriority() : *
      {
         return !!this._format ? this._format.borderBottomPriority : undefined;
      }
      
      public function set borderBottomPriority(value:*) : void
      {
         this.writableTextLayoutFormat().borderBottomPriority = value;
         this.formatChanged();
      }
      
      public function get marginLeft() : *
      {
         return !!this._format ? this._format.marginLeft : undefined;
      }
      
      public function set marginLeft(marginLeftValue:*) : void
      {
         this.writableTextLayoutFormat().marginLeft = marginLeftValue;
         this.formatChanged();
      }
      
      public function get marginRight() : *
      {
         return !!this._format ? this._format.marginRight : undefined;
      }
      
      public function set marginRight(marginRightValue:*) : void
      {
         this.writableTextLayoutFormat().marginRight = marginRightValue;
         this.formatChanged();
      }
      
      public function get marginTop() : *
      {
         return !!this._format ? this._format.marginTop : undefined;
      }
      
      public function set marginTop(marginTopValue:*) : void
      {
         this.writableTextLayoutFormat().marginTop = marginTopValue;
         this.formatChanged();
      }
      
      public function get marginBottom() : *
      {
         return !!this._format ? this._format.marginBottom : undefined;
      }
      
      public function set marginBottom(marginBottomValue:*) : void
      {
         this.writableTextLayoutFormat().marginBottom = marginBottomValue;
         this.formatChanged();
      }
      
      public function get cellSpacing() : *
      {
         return !!this._format ? this._format.cellSpacing : undefined;
      }
      
      public function set cellSpacing(cellSpacingValue:*) : void
      {
         this.writableTextLayoutFormat().cellSpacing = cellSpacingValue;
         this.formatChanged();
      }
      
      public function get cellPadding() : *
      {
         return !!this._format ? this._format.cellPadding : undefined;
      }
      
      public function set cellPadding(cellPaddingValue:*) : void
      {
         this.writableTextLayoutFormat().cellPadding = cellPaddingValue;
         this.formatChanged();
      }
      
      public function get tableWidth() : *
      {
         return !!this._format ? this._format.tableWidth : undefined;
      }
      
      public function set tableWidth(tableWidthValue:*) : void
      {
         this.writableTextLayoutFormat().tableWidth = tableWidthValue;
         this.formatChanged();
      }
      
      public function get tableColumnWidth() : *
      {
         return !!this._format ? this._format.tableColumnWidth : undefined;
      }
      
      public function set tableColumnWidth(tableColumnWidthValue:*) : void
      {
         this.writableTextLayoutFormat().tableColumnWidth = tableColumnWidthValue;
         this.formatChanged();
      }
      
      public function get minCellHeight() : *
      {
         return !!this._format ? this._format.minCellHeight : undefined;
      }
      
      public function set minCellHeight(value:*) : void
      {
         this.writableTextLayoutFormat().minCellHeight = value;
         this.formatChanged();
      }
      
      public function get maxCellHeight() : *
      {
         return !!this._format ? this._format.maxCellHeight : undefined;
      }
      
      public function set maxCellHeight(value:*) : void
      {
         this.writableTextLayoutFormat().maxCellHeight = value;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="void,above,below,hsides,vsides,lhs,rhs,box,border,inherit")]
      public function get frame() : *
      {
         return !!this._format ? this._format.frame : undefined;
      }
      
      public function set frame(frameValue:*) : void
      {
         this.writableTextLayoutFormat().frame = frameValue;
         this.formatChanged();
      }
      
      [Inspectable(enumeration="none,groups,rows,cols,all,inherit")]
      public function get rules() : *
      {
         return !!this._format ? this._format.rules : undefined;
      }
      
      public function set rules(rulesValue:*) : void
      {
         this.writableTextLayoutFormat().rules = rulesValue;
         this.formatChanged();
      }
      
      public function get userStyles() : Object
      {
         return !!this._format ? this._format.userStyles : null;
      }
      
      public function set userStyles(styles:Object) : void
      {
         var val:* = null;
         for(val in this.userStyles)
         {
            this.setStyle(val,undefined);
         }
         for(val in styles)
         {
            this.setStyle(val,styles[val]);
         }
      }
      
      public function get coreStyles() : Object
      {
         return !!this._format ? this._format.coreStyles : null;
      }
      
      public function get styles() : Object
      {
         return !!this._format ? this._format.styles : null;
      }
      
      public function get format() : ITextLayoutFormat
      {
         return this._format;
      }
      
      public function set format(value:ITextLayoutFormat) : void
      {
         if(value == this._format)
         {
            return;
         }
         var oldStyleName:String = this.styleName;
         if(value == null)
         {
            this._format.clearStyles();
         }
         else
         {
            this.writableTextLayoutFormat().copy(value);
         }
         this.formatChanged();
         if(oldStyleName != this.styleName)
         {
            this.styleSelectorChanged();
         }
      }
      
      private function writableTextLayoutFormat() : FlowValueHolder
      {
         if(this._format == null)
         {
            this._format = new FlowValueHolder();
         }
         return this._format;
      }
      
      public function getStyle(styleProp:String) : *
      {
         if(TextLayoutFormat.description.hasOwnProperty(styleProp))
         {
            return this.computedFormat.getStyle(styleProp);
         }
         var tf:TextFlow = this._rootElement.getTextFlow();
         if(!tf || !tf.formatResolver)
         {
            return this.computedFormat.getStyle(styleProp);
         }
         return this.getUserStyleWorker(styleProp);
      }
      
      tlf_internal function getUserStyleWorker(styleProp:String) : *
      {
         var userStyle:* = this._format.getStyle(styleProp);
         if(userStyle !== undefined)
         {
            return userStyle;
         }
         var tf:TextFlow = !!this._rootElement ? this._rootElement.getTextFlow() : null;
         if(tf && tf.formatResolver)
         {
            userStyle = tf.formatResolver.resolveUserFormat(this,styleProp);
            if(userStyle !== undefined)
            {
               return userStyle;
            }
         }
         return !!this._rootElement ? this._rootElement.getUserStyleWorker(styleProp) : undefined;
      }
      
      public function setStyle(styleProp:String, newValue:*) : void
      {
         if(TextLayoutFormat.description[styleProp])
         {
            this[styleProp] = newValue;
         }
         else
         {
            this.writableTextLayoutFormat().setStyle(styleProp,newValue);
            this.formatChanged();
         }
      }
      
      public function clearStyle(styleProp:String) : void
      {
         this.setStyle(styleProp,undefined);
      }
      
      public function get computedFormat() : ITextLayoutFormat
      {
         var parentPrototype:TextLayoutFormat = null;
         if(!this._computedFormat)
         {
            parentPrototype = !!this._rootElement ? TextLayoutFormat(this._rootElement.computedFormat) : null;
            this._computedFormat = FlowElement.createTextLayoutFormatPrototype(this.formatForCascade,parentPrototype);
            this.resetColumnState();
         }
         return this._computedFormat;
      }
      
      tlf_internal function get formatForCascade() : ITextLayoutFormat
      {
         var tf:TextFlow = null;
         var elemStyle:TextLayoutFormat = null;
         var localFormat:ITextLayoutFormat = null;
         var rslt:TextLayoutFormat = null;
         if(this._rootElement)
         {
            tf = this._rootElement.getTextFlow();
            if(tf)
            {
               elemStyle = tf.getTextLayoutFormatStyle(this);
               if(elemStyle)
               {
                  localFormat = this._format;
                  if(localFormat == null)
                  {
                     return elemStyle;
                  }
                  rslt = new TextLayoutFormat(elemStyle);
                  rslt.apply(localFormat);
                  return rslt;
               }
            }
         }
         return this._format;
      }
      
      tlf_internal function testLineVisible(wmode:String, scrollXTW:int, scrollYTW:int, scrollWidthTW:int, scrollHeightTW:int, textFlowLine:TextFlowLine, textLine:TextLine) : *
      {
         var ilgs:Array = null;
         var ilg:InlineGraphicElement = null;
         var idx:int = 0;
         var lineBounds:Rectangle = null;
         if(textFlowLine is TextFlowTableBlock)
         {
            if(textFlowLine.controller == this)
            {
               return TextFlowTableBlock(textFlowLine).container;
            }
            return null;
         }
         if(textFlowLine.controller == null)
         {
            ilgs = this.textFlow.getElementsByTypeName("img");
            for(idx = 0; idx < ilgs.length; idx++)
            {
               ilg = ilgs[idx] as InlineGraphicElement;
               if(!(ilg && ilg.getAbsoluteStart() < textFlowLine.absoluteStart))
               {
                  break;
               }
               if(wmode == BlockProgression.TB)
               {
                  if(ilg.height == undefined || ilg.height == "auto")
                  {
                     return 2;
                  }
               }
               else if(ilg.width == undefined || ilg.width == "auto")
               {
                  return 2;
               }
            }
         }
         if(textFlowLine.controller != this)
         {
            return textFlowLine.absoluteStart < this.absoluteStart ? -1 : 1;
         }
         if(!textFlowLine.hasLineBounds())
         {
            if(!textLine)
            {
               textLine = textFlowLine.getTextLine(true);
            }
            textFlowLine.createShape(wmode,textLine);
            if(textLine.numChildren == 0)
            {
               if(wmode == BlockProgression.TB)
               {
                  textFlowLine.cacheLineBounds(wmode,textLine.x,textLine.y - textLine.ascent,textLine.textWidth,textLine.textHeight);
               }
               else
               {
                  textFlowLine.cacheLineBounds(wmode,textLine.x - textLine.descent,textLine.y,textLine.textHeight,textLine.textWidth);
               }
            }
            else
            {
               lineBounds = this.getPlacedTextLineBounds(textLine);
               if(textLine.hasGraphicElement)
               {
                  lineBounds = this.computeLineBoundsWithGraphics(textFlowLine,textLine,lineBounds);
               }
               textFlowLine.cacheLineBounds(wmode,lineBounds.x,lineBounds.y,lineBounds.width,lineBounds.height);
            }
         }
         var rslt:* = (wmode == BlockProgression.TB ? Boolean(this._measureHeight) : Boolean(this._measureWidth)) ? 0 : textFlowLine.testLineVisible(wmode,scrollXTW,scrollYTW,scrollWidthTW,scrollHeightTW);
         return rslt == 0 ? (!!textLine ? textLine : textFlowLine.getTextLine(true)) : rslt;
      }
      
      tlf_internal function oldTestLineVisible(wmode:String, scrollXTW:int, scrollYTW:int, scrollWidthTW:int, scrollHeightTW:int, textFlowLine:TextFlowLine, textLine:TextLine) : TextLine
      {
         var lineBounds:Rectangle = null;
         if(textFlowLine is TextFlowTableBlock)
         {
            return null;
         }
         if(!textFlowLine.hasLineBounds())
         {
            if(!textLine)
            {
               textLine = textFlowLine.getTextLine(true);
            }
            textFlowLine.createShape(wmode,textLine);
            if(textLine.numChildren == 0)
            {
               if(wmode == BlockProgression.TB)
               {
                  textFlowLine.cacheLineBounds(wmode,textLine.x,textLine.y - textLine.ascent,textLine.textWidth,textLine.textHeight);
               }
               else
               {
                  textFlowLine.cacheLineBounds(wmode,textLine.x - textLine.descent,textLine.y,textLine.textHeight,textLine.textWidth);
               }
            }
            else
            {
               lineBounds = this.getPlacedTextLineBounds(textLine);
               if(textLine.hasGraphicElement)
               {
                  lineBounds = this.computeLineBoundsWithGraphics(textFlowLine,textLine,lineBounds);
               }
               textFlowLine.cacheLineBounds(wmode,lineBounds.x,lineBounds.y,lineBounds.width,lineBounds.height);
            }
         }
         if((wmode == BlockProgression.TB ? Boolean(this._measureHeight) : Boolean(this._measureWidth)) || textFlowLine.oldTestLineVisible(wmode,scrollXTW,scrollYTW,scrollWidthTW,scrollHeightTW))
         {
            return !!textLine ? textLine : textFlowLine.getTextLine(true);
         }
         return null;
      }
      
      private function computeLineBoundsWithGraphics(line:TextFlowLine, textLine:TextLine, boundsRect:Rectangle) : Rectangle
      {
         var floatIndex:int = 0;
         var lastFloatIndex:int = 0;
         var inlineRect:Rectangle = null;
         var topLeft:Point = null;
         var floatInfo:FloatCompositionData = null;
         var inlineGraphicElement:InlineGraphicElement = null;
         var inlineHolder:DisplayObject = null;
         if(this._composedFloats)
         {
            floatIndex = this.findFloatIndexAtOrAfter(line.absoluteStart);
            lastFloatIndex = this.findFloatIndexAtOrAfter(line.absoluteStart + line.textLength);
            inlineRect = new Rectangle();
            topLeft = new Point();
            while(floatIndex < lastFloatIndex)
            {
               floatInfo = this._composedFloats[floatIndex];
               if(floatInfo.floatType == Float.NONE)
               {
                  inlineGraphicElement = this.textFlow.findLeaf(floatInfo.absolutePosition) as InlineGraphicElement;
                  inlineHolder = inlineGraphicElement.placeholderGraphic.parent;
                  if(inlineHolder)
                  {
                     inlineRect.x = textLine.x + inlineHolder.x;
                     inlineRect.y = textLine.y + inlineHolder.y;
                     inlineRect.width = inlineGraphicElement.elementWidth;
                     inlineRect.height = inlineGraphicElement.elementHeight;
                     boundsRect = boundsRect.union(inlineRect);
                  }
               }
               floatIndex++;
            }
         }
         return boundsRect;
      }
      
      tlf_internal function findCellAtPosition(point:Point) : CellCoordinates
      {
         var chld:Object = null;
         var block:TableBlockContainer = null;
         var cells:Vector.<TableCellElement> = null;
         var cell:TableCellElement = null;
         point = point.clone();
         for each(chld in this._shapeChildren)
         {
            if(chld is TableBlockContainer)
            {
               block = chld as TableBlockContainer;
               if(block.y <= point.y)
               {
                  if(block.x <= point.x)
                  {
                     if(block.y + block.height >= point.y)
                     {
                        if(block.x + block.getTableWidth() >= point.x)
                        {
                           point.x -= block.x;
                           point.y -= block.y;
                           cells = block.userData.getTableCells();
                           for each(cell in cells)
                           {
                              if(cell.x + cell.width >= point.x)
                              {
                                 if(cell.y + cell.getRow().composedHeight >= point.y)
                                 {
                                    if(cell.x <= point.x)
                                    {
                                       if(cell.y <= point.y)
                                       {
                                          return new CellCoordinates(cell.rowIndex,cell.colIndex,cell.getTable());
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return null;
      }
      
      tlf_internal function getPlacedTextLineBounds(textLine:TextLine) : Rectangle
      {
         var curBounds:Rectangle = null;
         curBounds = textLine.getBounds(textLine);
         curBounds.x += textLine.x;
         curBounds.y += textLine.y;
         return curBounds;
      }
      
      tlf_internal function addComposedLine(textLine:TextLine) : void
      {
         this._linesInView.push(textLine);
      }
      
      tlf_internal function addComposedTableBlock(block:TableBlockContainer) : void
      {
         var idx:int = this._tableBlocksInView.indexOf(block);
         if(idx >= 0)
         {
            this._tableBlocksInView.splice(idx,1);
         }
         else
         {
            this._tableBlocksInView.push(block);
         }
      }
      
      tlf_internal function get composedLines() : Array
      {
         if(!this._linesInView)
         {
            this._linesInView = [];
         }
         var arr:Array = this._linesInView.slice();
         this.intersperseTableBlocks(arr);
         return arr;
      }
      
      tlf_internal function clearComposedLines(pos:int) : void
      {
         var textLine:TextLine = null;
         var tbc:TableBlockContainer = null;
         var tfl:TextFlowLine = null;
         var tftb:TextFlowTableBlock = null;
         var index:int = 0;
         for each(textLine in this._linesInView)
         {
            tfl = textLine.userData as TextFlowLine;
            if(tfl.absoluteStart >= pos)
            {
               break;
            }
            index++;
         }
         this._linesInView.length = index;
         index = 0;
         for each(tbc in this._tableBlocksInView)
         {
            tftb = tbc.userData;
            if(tbc.userData.absoluteStart >= pos)
            {
               break;
            }
            index++;
         }
         this._tableBlocksInView.length = index;
         this._updateStart = Math.min(this._updateStart,pos);
      }
      
      tlf_internal function get numFloats() : int
      {
         return !!this._composedFloats ? int(this._composedFloats.length) : 0;
      }
      
      tlf_internal function getFloatAt(index:int) : FloatCompositionData
      {
         return this._composedFloats[index];
      }
      
      tlf_internal function getFloatAtPosition(absolutePosition:int) : FloatCompositionData
      {
         if(!this._composedFloats)
         {
            return null;
         }
         var i:int = this.findFloatIndexAtOrAfter(absolutePosition);
         return i < this._composedFloats.length ? this._composedFloats[i] : null;
      }
      
      tlf_internal function addFloatAt(absolutePosition:int, float:DisplayObject, floatType:String, x:Number, y:Number, alpha:Number, matrix:Matrix, depth:Number, knockOutWidth:Number, columnIndex:int, parent:DisplayObjectContainer) : void
      {
         var index:int = 0;
         if(!this._composedFloats)
         {
            this._composedFloats = [];
         }
         var floatInfo:FloatCompositionData = new FloatCompositionData(absolutePosition,float,floatType,x,y,alpha,matrix,depth,knockOutWidth,columnIndex,parent);
         if(this._composedFloats.length > 0 && this._composedFloats[this._composedFloats.length - 1] < absolutePosition)
         {
            this._composedFloats.push(floatInfo);
         }
         else
         {
            index = this.findFloatIndexAtOrAfter(absolutePosition);
            this._composedFloats.splice(index,0,floatInfo);
         }
      }
      
      tlf_internal function clearFloatsAt(absolutePosition:int) : void
      {
         if(this._composedFloats)
         {
            if(absolutePosition == this.absoluteStart)
            {
               this._composedFloats.length = 0;
            }
            else
            {
               this._composedFloats.length = this.findFloatIndexAtOrAfter(absolutePosition);
            }
         }
      }
      
      tlf_internal function findFloatIndexAfter(absolutePosition:int) : int
      {
         var i:int = 0;
         while(i < this._composedFloats.length && this._composedFloats[i].absolutePosition <= absolutePosition)
         {
            i++;
         }
         return i;
      }
      
      tlf_internal function findFloatIndexAtOrAfter(absolutePosition:int) : int
      {
         var i:int = 0;
         while(i < this._composedFloats.length && this._composedFloats[i].absolutePosition < absolutePosition)
         {
            i++;
         }
         return i;
      }
      
      tlf_internal function getInteractionHandler() : IInteractionEventHandler
      {
         return this;
      }
   }
}

import flash.display.InteractiveObject;
import flash.events.MouseEvent;

class PsuedoMouseEvent extends MouseEvent
{
    
   
   function PsuedoMouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false)
   {
      super(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown);
   }
   
   override public function get currentTarget() : Object
   {
      return relatedObject;
   }
   
   override public function get target() : Object
   {
      return relatedObject;
   }
}
