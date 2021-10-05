package flashx.textLayout.container
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.FocusEvent;
   import flash.events.IMEEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuClipboardItems;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.BaseCompose;
   import flashx.textLayout.compose.ISWFContext;
   import flashx.textLayout.compose.SimpleCompose;
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.compose.TextLineRecycler;
   import flashx.textLayout.edit.EditManager;
   import flashx.textLayout.edit.EditingMode;
   import flashx.textLayout.edit.IEditManager;
   import flashx.textLayout.edit.IInteractionEventHandler;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.edit.SelectionFormat;
   import flashx.textLayout.edit.SelectionManager;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.IConfiguration;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.events.CompositionCompleteEvent;
   import flashx.textLayout.events.DamageEvent;
   import flashx.textLayout.events.FlowOperationEvent;
   import flashx.textLayout.events.SelectionEvent;
   import flashx.textLayout.events.StatusChangeEvent;
   import flashx.textLayout.events.TextLayoutEvent;
   import flashx.textLayout.events.UpdateCompleteEvent;
   import flashx.textLayout.factory.StringTextLineFactory;
   import flashx.textLayout.factory.TextLineFactoryBase;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   import flashx.undo.IUndoManager;
   import flashx.undo.UndoManager;
   
   use namespace tlf_internal;
   
   [Exclude(kind="method",name="callInContext")]
   [Exclude(kind="method",name="getBaseSWFContext")]
   [Event(name="updateComplete",type="flashx.textLayout.events.UpdateCompleteEvent")]
   [Event(name="damage",type="flashx.textLayout.events.DamageEvent")]
   [Event(name="scroll",type="flashx.textLayout.events.TextLayoutEvent")]
   [Event(name="inlineGraphicStatusChanged",type="flashx.textLayout.events.StatusChangeEvent")]
   [Event(name="click",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOut",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOver",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseMove",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseUp",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseDown",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="compositionComplete",type="flashx.textLayout.events.CompositionCompleteEvent")]
   [Event(name="selectionChange",type="flashx.textLayout.events.SelectionEvent")]
   [Event(name="flowOperationComplete",type="flashx.textLayout.events.FlowOperationEvent")]
   [Event(name="flowOperationEnd",type="flashx.textLayout.events.FlowOperationEvent")]
   [Event(name="flowOperationBegin",type="flashx.textLayout.events.FlowOperationEvent")]
   public class TextContainerManager extends EventDispatcher implements ISWFContext, IInteractionEventHandler, ISandboxSupport
   {
      
      private static const eventList:Array = [FlowOperationEvent.FLOW_OPERATION_BEGIN,FlowOperationEvent.FLOW_OPERATION_END,FlowOperationEvent.FLOW_OPERATION_COMPLETE,SelectionEvent.SELECTION_CHANGE,CompositionCompleteEvent.COMPOSITION_COMPLETE,MouseEvent.CLICK,MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_OUT,MouseEvent.MOUSE_UP,MouseEvent.MOUSE_OVER,MouseEvent.MOUSE_OUT,StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,TextLayoutEvent.SCROLL,DamageEvent.DAMAGE,UpdateCompleteEvent.UPDATE_COMPLETE];
      
      private static var _defaultConfiguration:IConfiguration = null;
      
      private static var _inputManagerTextFlowFactory:TCMTextFlowTextLineFactory;
      
      private static var stringFactoryDictionary:Dictionary;
      
      tlf_internal static const editingModePropertyDefinition:Property = Property.NewEnumStringProperty("editingMode",EditingMode.READ_WRITE,false,null,EditingMode.READ_WRITE,EditingMode.READ_ONLY,EditingMode.READ_SELECT);
      
      tlf_internal static const SOURCE_STRING:int = 0;
      
      tlf_internal static const SOURCE_TEXTFLOW:int = 1;
      
      tlf_internal static const COMPOSE_FACTORY:int = 0;
      
      tlf_internal static const COMPOSE_COMPOSER:int = 1;
      
      tlf_internal static const HANDLERS_NOTADDED:int = 0;
      
      tlf_internal static const HANDLERS_NONE:int = 1;
      
      tlf_internal static const HANDLERS_CREATION:int = 2;
      
      tlf_internal static const HANDLERS_ACTIVE:int = 3;
      
      tlf_internal static const HANDLERS_MOUSEWHEEL:int = 4;
      
      private static var _expectedFactoryCompose:SimpleCompose;
       
      
      private var _container:Sprite;
      
      private var _compositionWidth:Number;
      
      private var _compositionHeight:Number;
      
      private var _text:String;
      
      private var _textDamaged:Boolean;
      
      private var _lastSeparator:String;
      
      private var _hostFormat:ITextLayoutFormat;
      
      private var _stringFactoryTextFlowFormat:ITextLayoutFormat;
      
      private var _contentTop:Number;
      
      private var _contentLeft:Number;
      
      private var _contentHeight:Number;
      
      private var _contentWidth:Number;
      
      private var _horizontalScrollPolicy:String;
      
      private var _verticalScrollPolicy:String;
      
      private var _swfContext:ISWFContext;
      
      private var _config:IConfiguration;
      
      private var _preserveSelectionOnSetText:Boolean = false;
      
      private var _sourceState:int;
      
      private var _composeState:int;
      
      private var _handlersState:int;
      
      private var _hasFocus:Boolean;
      
      private var _editingMode:String;
      
      private var _ibeamCursorSet:Boolean;
      
      private var _interactionCount:int;
      
      private var _damaged:Boolean;
      
      private var _textFlow:TextFlow;
      
      private var _needsRedraw:Boolean;
      
      tlf_internal var _composedLines:Array;
      
      private var _composeRecycledInPlaceLines:int;
      
      private var _composePushedLines:int;
      
      private var _contextMenu;
      
      private var _hasScrollRect:Boolean = false;
      
      public function TextContainerManager(container:Sprite, configuration:IConfiguration = null)
      {
         this._composedLines = [];
         super();
         this._container = container;
         this._compositionWidth = 100;
         this._compositionHeight = 100;
         this._config = !!configuration ? customizeConfiguration(configuration) : defaultConfiguration;
         this._config = (this._config as Configuration).getImmutableClone();
         this._horizontalScrollPolicy = this._verticalScrollPolicy = String(ScrollPolicy.scrollPolicyPropertyDefinition.defaultValue);
         this._damaged = true;
         this._needsRedraw = false;
         this._text = "";
         this._textDamaged = false;
         this._sourceState = tlf_internal::SOURCE_STRING;
         this._composeState = tlf_internal::COMPOSE_FACTORY;
         this._handlersState = tlf_internal::HANDLERS_NOTADDED;
         this._hasFocus = false;
         this._editingMode = tlf_internal::editingModePropertyDefinition.defaultValue as String;
         this._ibeamCursorSet = false;
         this._interactionCount = 0;
         if(this._container is InteractiveObject)
         {
            this._container.doubleClickEnabled = true;
            this._container.mouseChildren = false;
            this._container.focusRect = false;
         }
      }
      
      public static function get defaultConfiguration() : IConfiguration
      {
         if(_defaultConfiguration == null)
         {
            _defaultConfiguration = customizeConfiguration(null);
         }
         return _defaultConfiguration;
      }
      
      tlf_internal static function customizeConfiguration(config:IConfiguration) : IConfiguration
      {
         var newConfig:Configuration = null;
         if(config)
         {
            if(config.flowComposerClass == TextLineFactoryBase.getDefaultFlowComposerClass())
            {
               return config;
            }
            newConfig = (config as Configuration).clone();
         }
         else
         {
            newConfig = new Configuration();
         }
         newConfig.flowComposerClass = TextLineFactoryBase.getDefaultFlowComposerClass();
         return newConfig;
      }
      
      private static function inputManagerTextFlowFactory() : TCMTextFlowTextLineFactory
      {
         if(!_inputManagerTextFlowFactory)
         {
            _inputManagerTextFlowFactory = new TCMTextFlowTextLineFactory();
         }
         return _inputManagerTextFlowFactory;
      }
      
      private static function inputManagerStringFactory(config:IConfiguration) : StringTextLineFactory
      {
         if(!stringFactoryDictionary)
         {
            stringFactoryDictionary = new Dictionary(true);
         }
         var factory:StringTextLineFactory = stringFactoryDictionary[config];
         if(factory == null)
         {
            factory = new StringTextLineFactory(config);
            stringFactoryDictionary[config] = factory;
         }
         return factory;
      }
      
      tlf_internal static function releaseReferences() : void
      {
         stringFactoryDictionary = null;
         _inputManagerTextFlowFactory = null;
      }
      
      tlf_internal function get sourceState() : int
      {
         return this._sourceState;
      }
      
      tlf_internal function get composeState() : int
      {
         return this._composeState;
      }
      
      tlf_internal function get handlersState() : int
      {
         return this._handlersState;
      }
      
      public function get container() : Sprite
      {
         return this._container;
      }
      
      public function isDamaged() : Boolean
      {
         return this._composeState == tlf_internal::COMPOSE_FACTORY ? Boolean(this._damaged) : Boolean(this._textFlow.flowComposer.isPotentiallyDamaged(this._textFlow.textLength));
      }
      
      public function get editingMode() : String
      {
         return this._editingMode;
      }
      
      public function set editingMode(val:String) : void
      {
         var newMode:String = tlf_internal::editingModePropertyDefinition.setHelper(this._editingMode,val) as String;
         if(newMode != this._editingMode)
         {
            if(this.composeState == tlf_internal::COMPOSE_COMPOSER)
            {
               this._editingMode = newMode;
               this.invalidateInteractionManager();
            }
            else
            {
               this.removeActivationEventListeners();
               this._editingMode = newMode;
               if(this._editingMode == EditingMode.READ_ONLY)
               {
                  this.removeIBeamCursor();
               }
               this.addActivationEventListeners();
            }
         }
      }
      
      public function getText(separator:String = " ") : String
      {
         var firstLeaf:FlowLeafElement = null;
         var para:ParagraphElement = null;
         var nextPara:ParagraphElement = null;
         if(this._sourceState == tlf_internal::SOURCE_STRING)
         {
            return this._text;
         }
         if(this._textDamaged || this._lastSeparator != separator)
         {
            this._text = "";
            firstLeaf = this._textFlow.getFirstLeaf();
            if(firstLeaf != null)
            {
               para = firstLeaf.getParagraph();
               while(para)
               {
                  nextPara = para.getNextParagraph();
                  this._text += para.getText();
                  this._text += !!nextPara ? separator : "";
                  para = nextPara;
               }
            }
            this._textDamaged = false;
            this._lastSeparator = separator;
         }
         return this._text;
      }
      
      public function setText(text:String) : void
      {
         var hadPreviousSelection:Boolean = false;
         var selectionChanged:Boolean = false;
         var selectionState:SelectionState = null;
         var oldAnchorPosition:int = -1;
         var oldActivePosition:int = -1;
         if(this._sourceState == tlf_internal::SOURCE_TEXTFLOW)
         {
            if(this._textFlow.interactionManager && this._textFlow.interactionManager.hasSelection())
            {
               hadPreviousSelection = true;
               if(this._preserveSelectionOnSetText && text != null)
               {
                  oldAnchorPosition = Math.min(this._textFlow.interactionManager.anchorPosition,text.length);
                  oldActivePosition = Math.min(this._textFlow.interactionManager.activePosition,text.length);
                  if(oldAnchorPosition != this._textFlow.interactionManager.anchorPosition || oldActivePosition != this._textFlow.interactionManager.activePosition)
                  {
                     selectionChanged = true;
                  }
               }
            }
            this.removeTextFlowListeners();
            if(this._textFlow.flowComposer)
            {
               this._textFlow.flowComposer.removeAllControllers();
            }
            this._textFlow.unloadGraphics();
            this._textFlow = null;
            this._sourceState = tlf_internal::SOURCE_STRING;
            this._composeState = tlf_internal::COMPOSE_FACTORY;
            if(this._container is InteractiveObject)
            {
               this._container.mouseChildren = false;
            }
            this.addActivationEventListeners();
         }
         this._text = !!text ? text : "";
         this._damaged = true;
         this._textDamaged = false;
         if(hasEventListener(DamageEvent.DAMAGE))
         {
            this.dispatchEvent(new DamageEvent(DamageEvent.DAMAGE,false,false,null,0,this._text.length));
         }
         if(hadPreviousSelection)
         {
            if(this._preserveSelectionOnSetText)
            {
               if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
               {
                  this.convertToTextFlowWithComposer();
               }
               if(this._textFlow.interactionManager)
               {
                  this._textFlow.interactionManager.setSelectionState(new SelectionState(this._textFlow,oldAnchorPosition,oldActivePosition));
                  if(selectionChanged)
                  {
                     this._textFlow.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE,false,false,this._textFlow.interactionManager.getSelectionState()));
                  }
               }
            }
            else if(hasEventListener(SelectionEvent.SELECTION_CHANGE))
            {
               this.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE,false,false,null));
            }
         }
         if(this._hasFocus)
         {
            this.requiredFocusInHandler(null);
         }
      }
      
      public function get hostFormat() : ITextLayoutFormat
      {
         return this._hostFormat;
      }
      
      public function set hostFormat(val:ITextLayoutFormat) : void
      {
         this._hostFormat = val;
         this._stringFactoryTextFlowFormat = null;
         if(this._sourceState == tlf_internal::SOURCE_TEXTFLOW)
         {
            this._textFlow.hostFormat = this._hostFormat;
         }
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this._damaged = true;
         }
      }
      
      public function get compositionWidth() : Number
      {
         return this._compositionWidth;
      }
      
      public function set compositionWidth(val:Number) : void
      {
         if(this._compositionWidth == val || isNaN(this._compositionWidth) && isNaN(val))
         {
            return;
         }
         this._compositionWidth = val;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().setCompositionSize(this._compositionWidth,this._compositionHeight);
         }
         else
         {
            this._damaged = true;
         }
      }
      
      public function get compositionHeight() : Number
      {
         return this._compositionHeight;
      }
      
      public function set compositionHeight(val:Number) : void
      {
         if(this._compositionHeight == val || isNaN(this._compositionHeight) && isNaN(val))
         {
            return;
         }
         this._compositionHeight = val;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().setCompositionSize(this._compositionWidth,this._compositionHeight);
         }
         else
         {
            this._damaged = true;
         }
      }
      
      public function get configuration() : IConfiguration
      {
         return this._config;
      }
      
      public function getContentBounds() : Rectangle
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            return new Rectangle(this._contentLeft,this._contentTop,this._contentWidth,this._contentHeight);
         }
         var controller:ContainerController = this.getController();
         return controller.getContentBounds();
      }
      
      public function getTextFlow() : TextFlow
      {
         var wasDamaged:Boolean = false;
         if(this._sourceState != tlf_internal::SOURCE_TEXTFLOW)
         {
            wasDamaged = this.isDamaged();
            this.convertToTextFlow();
            if(!wasDamaged)
            {
               this.updateContainer();
            }
         }
         return this._textFlow;
      }
      
      public function setTextFlow(textFlow:TextFlow) : void
      {
         var controller:TMContainerController = null;
         if(textFlow == this._textFlow)
         {
            return;
         }
         if(textFlow == null)
         {
            this.setText(null);
            return;
         }
         if(textFlow.flowComposer && textFlow.flowComposer.numControllers > 0 && textFlow.flowComposer.getControllerAt(0) is TMContainerController)
         {
            controller = textFlow.flowComposer.getControllerAt(0) as TMContainerController;
            if(controller.textContainerManager && controller.textContainerManager.getTextFlow() == textFlow)
            {
               controller.textContainerManager.setTextFlow(null);
            }
         }
         if(this._sourceState == tlf_internal::SOURCE_TEXTFLOW)
         {
            this.removeTextFlowListeners();
            if(this._textFlow.flowComposer)
            {
               this._textFlow.flowComposer.removeAllControllers();
            }
            this._textFlow.unloadGraphics();
            this._textFlow = null;
         }
         this._textFlow = textFlow;
         this._textFlow.hostFormat = this.hostFormat;
         this._sourceState = tlf_internal::SOURCE_TEXTFLOW;
         this._composeState = textFlow.interactionManager || textFlow.mustUseComposer() ? int(tlf_internal::COMPOSE_COMPOSER) : int(tlf_internal::COMPOSE_FACTORY);
         this._textDamaged = true;
         this.addTextFlowListeners();
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this._container.mouseChildren = true;
            this.clearContainerChildren(true);
            this.clearComposedLines();
            this._textFlow.flowComposer = new StandardFlowComposer();
            this._textFlow.flowComposer.swfContext = this._swfContext;
            this._textFlow.flowComposer.addController(new TMContainerController(this._container,this._compositionWidth,this._compositionHeight,this));
            this.invalidateInteractionManager();
            if(this._textFlow.interactionManager)
            {
               this._textFlow.interactionManager.selectRange(-1,-1);
            }
         }
         else
         {
            this._damaged = true;
         }
         if(this._hasFocus)
         {
            this.requiredFocusInHandler(null);
         }
         this.addActivationEventListeners();
      }
      
      public function get horizontalScrollPolicy() : String
      {
         return this._horizontalScrollPolicy;
      }
      
      public function set horizontalScrollPolicy(scrollPolicy:String) : void
      {
         this._horizontalScrollPolicy = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._horizontalScrollPolicy,scrollPolicy) as String;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().horizontalScrollPolicy = this._horizontalScrollPolicy;
         }
         else
         {
            this._damaged = true;
         }
      }
      
      public function get verticalScrollPolicy() : String
      {
         return this._verticalScrollPolicy;
      }
      
      public function set verticalScrollPolicy(scrollPolicy:String) : void
      {
         this._verticalScrollPolicy = ScrollPolicy.scrollPolicyPropertyDefinition.setHelper(this._verticalScrollPolicy,scrollPolicy) as String;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().verticalScrollPolicy = this._verticalScrollPolicy;
         }
         else
         {
            this._damaged = true;
         }
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._composeState == tlf_internal::COMPOSE_COMPOSER ? Number(this.getController().horizontalScrollPosition) : Number(0);
      }
      
      public function set horizontalScrollPosition(val:Number) : void
      {
         if(val == 0 && this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            return;
         }
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         this.getController().horizontalScrollPosition = val;
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._composeState == tlf_internal::COMPOSE_COMPOSER ? Number(this.getController().verticalScrollPosition) : Number(0);
      }
      
      public function set verticalScrollPosition(val:Number) : void
      {
         if(val == 0 && this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            return;
         }
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         this.getController().verticalScrollPosition = val;
      }
      
      public function getScrollDelta(numLines:int) : Number
      {
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         return this.getController().getScrollDelta(numLines);
      }
      
      public function scrollToRange(activePosition:int, anchorPosition:int) : void
      {
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         this.getController().scrollToRange(activePosition,anchorPosition);
      }
      
      public function get swfContext() : ISWFContext
      {
         return this._swfContext;
      }
      
      public function set swfContext(context:ISWFContext) : void
      {
         this._swfContext = context;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this._textFlow.flowComposer.swfContext = this._swfContext;
         }
         else
         {
            this._damaged = true;
         }
      }
      
      public function getBaseSWFContext() : ISWFContext
      {
         return this._swfContext;
      }
      
      public function callInContext(fn:Function, thisArg:Object, argsArray:Array, returns:Boolean = true) : *
      {
         var textBlock:TextBlock = thisArg as TextBlock;
         if(textBlock && _expectedFactoryCompose == TextLineFactoryBase._factoryComposer)
         {
            if(fn == textBlock.createTextLine)
            {
               return this.createTextLine(textBlock,argsArray);
            }
            if(Configuration.playerEnablesArgoFeatures && fn == thisArg["recreateTextLine"])
            {
               return this.recreateTextLine(textBlock,argsArray);
            }
         }
         var swfContext:ISWFContext = !!this._swfContext ? this._swfContext : BaseCompose.globalSWFContext;
         if(returns)
         {
            return swfContext.callInContext(fn,thisArg,argsArray,returns);
         }
         swfContext.callInContext(fn,thisArg,argsArray,returns);
      }
      
      public function resetLine(textLine:TextLine) : void
      {
         if(textLine == this._composedLines[this._composeRecycledInPlaceLines - 1])
         {
            --this._composeRecycledInPlaceLines;
         }
      }
      
      private function createTextLine(textBlock:TextBlock, argsArray:Array) : TextLine
      {
         var textLine:TextLine = null;
         var swfContext:ISWFContext = !!this._swfContext ? this._swfContext : BaseCompose.globalSWFContext;
         if(this._composeRecycledInPlaceLines < this._composedLines.length && _expectedFactoryCompose == TextLineFactoryBase._factoryComposer)
         {
            textLine = this._composedLines[this._composeRecycledInPlaceLines++];
            argsArray.splice(0,0,textLine);
            return swfContext.callInContext(textBlock["recreateTextLine"],textBlock,argsArray);
         }
         return swfContext.callInContext(textBlock.createTextLine,textBlock,argsArray);
      }
      
      private function recreateTextLine(textBlock:TextBlock, argsArray:Array) : TextLine
      {
         var swfContext:ISWFContext = !!this._swfContext ? this._swfContext : BaseCompose.globalSWFContext;
         if(this._composeRecycledInPlaceLines < this._composedLines.length)
         {
            TextLineRecycler.addLineForReuse(argsArray[0]);
            argsArray[0] = this._composedLines[this._composeRecycledInPlaceLines++];
         }
         return swfContext.callInContext(textBlock["recreateTextLine"],textBlock,argsArray);
      }
      
      public function beginInteraction() : ISelectionManager
      {
         ++this._interactionCount;
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         return this._textFlow.interactionManager;
      }
      
      public function endInteraction() : void
      {
         --this._interactionCount;
      }
      
      public function invalidateUndoManager() : void
      {
         if(this._editingMode == EditingMode.READ_WRITE)
         {
            this.invalidateInteractionManager(true);
         }
      }
      
      public function invalidateSelectionFormats() : void
      {
         this.invalidateInteractionManager();
      }
      
      private function invalidateInteractionManager(alwaysRecreateManager:Boolean = false) : void
      {
         var interactionManager:ISelectionManager = null;
         var activePos:int = 0;
         var anchorPos:int = 0;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            interactionManager = this._textFlow.interactionManager;
            activePos = !!interactionManager ? int(interactionManager.activePosition) : -1;
            anchorPos = !!interactionManager ? int(interactionManager.anchorPosition) : -1;
            if(this._editingMode == EditingMode.READ_ONLY)
            {
               if(interactionManager)
               {
                  this._textFlow.interactionManager = null;
               }
            }
            else if(this._editingMode == EditingMode.READ_WRITE)
            {
               if(alwaysRecreateManager || interactionManager == null || interactionManager.editingMode == EditingMode.READ_SELECT)
               {
                  this._textFlow.interactionManager = this.createEditManager(this.getUndoManager());
                  if(this._textFlow.interactionManager is SelectionManager)
                  {
                     SelectionManager(this._textFlow.interactionManager).cloneSelectionFormatState(interactionManager);
                  }
               }
            }
            else if(this._editingMode == EditingMode.READ_SELECT)
            {
               if(alwaysRecreateManager || interactionManager == null || interactionManager.editingMode == EditingMode.READ_WRITE)
               {
                  this._textFlow.interactionManager = this.createSelectionManager();
                  if(this._textFlow.interactionManager is SelectionManager)
                  {
                     SelectionManager(this._textFlow.interactionManager).cloneSelectionFormatState(interactionManager);
                  }
               }
            }
            interactionManager = this._textFlow.interactionManager;
            if(interactionManager)
            {
               interactionManager.unfocusedSelectionFormat = this.getUnfocusedSelectionFormat();
               interactionManager.focusedSelectionFormat = this.getFocusedSelectionFormat();
               interactionManager.inactiveSelectionFormat = this.getInactiveSelectionFormat();
               interactionManager.selectRange(anchorPos,activePos);
            }
         }
      }
      
      protected function createSelectionManager() : ISelectionManager
      {
         return new SelectionManager();
      }
      
      protected function createEditManager(undoManager:IUndoManager) : IEditManager
      {
         return new EditManager(undoManager);
      }
      
      private function getController() : TMContainerController
      {
         return this._textFlow.flowComposer.getControllerAt(0) as TMContainerController;
      }
      
      public function getLineAt(index:int) : TextLine
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            if(this._sourceState == tlf_internal::SOURCE_STRING && this._text.length == 0 && !this._damaged && this._composedLines.length == 0)
            {
               if(this._needsRedraw)
               {
                  this.compose();
               }
               else
               {
                  this.updateContainer();
               }
            }
            return this._composedLines[index];
         }
         var tfl:TextFlowLine = this._textFlow.flowComposer.getLineAt(index);
         return !!tfl ? tfl.getTextLine(true) : null;
      }
      
      public function get numLines() : int
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            return this._textFlow.flowComposer.numLines;
         }
         if(this._sourceState == tlf_internal::SOURCE_STRING && this._text.length == 0)
         {
            return 1;
         }
         return this._composedLines.length;
      }
      
      tlf_internal function getActualNumLines() : int
      {
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.convertToTextFlowWithComposer();
         }
         this._textFlow.flowComposer.composeToPosition();
         return this._textFlow.flowComposer.numLines;
      }
      
      tlf_internal function clearComposedLines() : void
      {
         if(this._composedLines)
         {
            this._composedLines.length = 0;
         }
      }
      
      private function populateComposedLines(displayObject:DisplayObject) : void
      {
         this._composedLines.push(displayObject);
      }
      
      private function populateAndRecycleComposedLines(object:DisplayObject) : void
      {
         var textLine:TextLine = object as TextLine;
         if(textLine)
         {
            if(this._composePushedLines >= this._composedLines.length)
            {
               this._composedLines.push(textLine);
            }
         }
         else
         {
            this._composedLines.splice(0,0,object);
         }
         ++this._composePushedLines;
      }
      
      public function compose() : void
      {
         var callback:Function = null;
         var inputManagerFactory:TextLineFactoryBase = null;
         var bounds:Rectangle = null;
         var firstObj:Object = null;
         var stringFactory:StringTextLineFactory = null;
         var format:TextLayoutFormat = null;
         var holderStyles:Object = null;
         var key:* = null;
         var val:* = undefined;
         var factory:TCMTextFlowTextLineFactory = null;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this._textFlow.flowComposer.compose();
         }
         else if(this._damaged)
         {
            if(this._sourceState == tlf_internal::SOURCE_TEXTFLOW && this._textFlow.mustUseComposer())
            {
               this.convertToTextFlowWithComposer(false);
               this._textFlow.flowComposer.compose();
               return;
            }
            if(Configuration.playerEnablesArgoFeatures)
            {
               while(true)
               {
                  firstObj = this._composedLines[0];
                  if(firstObj == null || firstObj is TextLine)
                  {
                     break;
                  }
                  this._composedLines.splice(0,1);
               }
               this._composeRecycledInPlaceLines = 0;
               this._composePushedLines = 0;
               callback = this.populateAndRecycleComposedLines;
            }
            else
            {
               this.clearComposedLines();
               callback = this.populateComposedLines;
            }
            inputManagerFactory = this._sourceState == tlf_internal::SOURCE_STRING ? inputManagerStringFactory(this._config) : inputManagerTextFlowFactory();
            inputManagerFactory.verticalScrollPolicy = this._verticalScrollPolicy;
            inputManagerFactory.horizontalScrollPolicy = this._horizontalScrollPolicy;
            inputManagerFactory.compositionBounds = new Rectangle(0,0,this._compositionWidth,this._compositionHeight);
            inputManagerFactory.swfContext = !!Configuration.playerEnablesArgoFeatures ? this : this._swfContext;
            _expectedFactoryCompose = TextLineFactoryBase.peekFactoryCompose();
            if(this._sourceState == tlf_internal::SOURCE_STRING)
            {
               stringFactory = inputManagerFactory as StringTextLineFactory;
               if(!this._stringFactoryTextFlowFormat)
               {
                  if(this._hostFormat == null)
                  {
                     this._stringFactoryTextFlowFormat = this._config.textFlowInitialFormat;
                  }
                  else
                  {
                     format = new TextLayoutFormat(this._hostFormat);
                     TextLayoutFormat.resetModifiedNoninheritedStyles(format);
                     holderStyles = (this._config.textFlowInitialFormat as TextLayoutFormat).getStyles();
                     for(key in holderStyles)
                     {
                        val = holderStyles[key];
                        format[key] = val !== FormatValue.INHERIT ? val : this._hostFormat[key];
                     }
                     this._stringFactoryTextFlowFormat = format;
                  }
               }
               if(!TextLayoutFormat.isEqual(stringFactory.textFlowFormat,this._stringFactoryTextFlowFormat))
               {
                  stringFactory.textFlowFormat = this._stringFactoryTextFlowFormat;
               }
               stringFactory.text = this._text;
               stringFactory.createTextLines(callback);
            }
            else
            {
               factory = inputManagerFactory as TCMTextFlowTextLineFactory;
               factory.tcm = this;
               factory.createTextLines(callback,this._textFlow);
               factory.tcm = null;
            }
            inputManagerFactory.swfContext = null;
            _expectedFactoryCompose = null;
            if(Configuration.playerEnablesArgoFeatures)
            {
               this._composedLines.length = this._composePushedLines;
            }
            bounds = inputManagerFactory.getContentBounds();
            this._contentLeft = bounds.x;
            this._contentTop = bounds.y;
            this._contentWidth = bounds.width;
            this._contentHeight = bounds.height;
            this._damaged = false;
            if(hasEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE))
            {
               this.dispatchEvent(new CompositionCompleteEvent(CompositionCompleteEvent.COMPOSITION_COMPLETE,false,false,this._textFlow,0,-1));
            }
            this._needsRedraw = true;
         }
      }
      
      public function updateContainer() : Boolean
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            return this._textFlow.flowComposer.updateAllControllers();
         }
         this.compose();
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this._textFlow.flowComposer.updateAllControllers();
            return true;
         }
         if(!this._needsRedraw)
         {
            return false;
         }
         this.factoryUpdateContainerChildren();
         this.drawBackgroundAndSetScrollRect(0,0);
         if(this._handlersState == tlf_internal::HANDLERS_NOTADDED)
         {
            this.addActivationEventListeners();
         }
         if(hasEventListener(UpdateCompleteEvent.UPDATE_COMPLETE))
         {
            this.dispatchEvent(new UpdateCompleteEvent(UpdateCompleteEvent.UPDATE_COMPLETE,false,false,null));
         }
         this._needsRedraw = false;
         return true;
      }
      
      tlf_internal function factoryUpdateContainerChildren() : void
      {
         var textObject:DisplayObject = null;
         var idx:int = 0;
         var textLine:TextLine = null;
         if(Configuration.playerEnablesArgoFeatures)
         {
            while(this._container.numChildren != 0)
            {
               textObject = this._container.getChildAt(0);
               if(textObject is TextLine)
               {
                  break;
               }
               this._container.removeChildAt(0);
            }
            for(idx = 0; idx < this._composedLines.length; idx++)
            {
               textObject = this._composedLines[idx];
               if(textObject is TextLine)
               {
                  break;
               }
               this._container.addChildAt(textObject,idx);
            }
            while(this._container.numChildren < this._composedLines.length)
            {
               this._container.addChild(this._composedLines[this._container.numChildren]);
            }
            while(this._container.numChildren > this._composedLines.length)
            {
               textLine = this._container.getChildAt(this._composedLines.length) as TextLine;
               this._container.removeChildAt(this._composedLines.length);
               if(textLine)
               {
                  if(textLine.validity == TextLineValidity.VALID)
                  {
                     textLine.textBlock.releaseLines(textLine,textLine.textBlock.lastLine);
                  }
                  textLine.userData = null;
                  TextLineRecycler.addLineForReuse(textLine);
               }
            }
         }
         else
         {
            this.clearContainerChildren(false);
            for each(textObject in this._composedLines)
            {
               this._container.addChild(textObject);
            }
            this.clearComposedLines();
         }
      }
      
      private function addActivationEventListeners() : void
      {
         var newState:int = tlf_internal::HANDLERS_NONE;
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            if(this._editingMode == EditingMode.READ_ONLY)
            {
               newState = tlf_internal::HANDLERS_MOUSEWHEEL;
            }
            else
            {
               newState = this._handlersState == tlf_internal::HANDLERS_NOTADDED ? int(tlf_internal::HANDLERS_CREATION) : int(tlf_internal::HANDLERS_ACTIVE);
            }
         }
         if(newState == this._handlersState)
         {
            return;
         }
         this.removeActivationEventListeners();
         if(newState == tlf_internal::HANDLERS_CREATION)
         {
            this._container.addEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.addEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
         }
         else if(newState == tlf_internal::HANDLERS_ACTIVE)
         {
            this._container.addEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.addEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
            this._container.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
            this._container.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
            this._container.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
            this._container.addEventListener("imeStartComposition",this.imeStartCompositionHandler);
            if(this.getContextMenu() != null)
            {
               this._container.contextMenu = this._contextMenu;
            }
            if(this._container.contextMenu)
            {
               this._container.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,this.menuSelectHandler);
            }
            this._container.addEventListener(Event.SELECT_ALL,this.editHandler);
         }
         else if(newState == tlf_internal::HANDLERS_MOUSEWHEEL)
         {
            this._container.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
         }
         this._handlersState = newState;
      }
      
      tlf_internal function getContextMenu() : ContextMenu
      {
         if(this._contextMenu === undefined)
         {
            this._contextMenu = this.createContextMenu();
         }
         return this._contextMenu;
      }
      
      private function removeActivationEventListeners() : void
      {
         if(this._handlersState == tlf_internal::HANDLERS_CREATION)
         {
            this._container.removeEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
         }
         else if(this._handlersState == tlf_internal::HANDLERS_ACTIVE)
         {
            this._container.removeEventListener(FocusEvent.FOCUS_IN,this.requiredFocusInHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_OVER,this.requiredMouseOverHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
            this._container.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
            this._container.removeEventListener("imeStartComposition",this.imeStartCompositionHandler);
            if(this._container.contextMenu)
            {
               this._container.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,this.menuSelectHandler);
            }
            if(this._contextMenu)
            {
               this._container.contextMenu = null;
            }
            this._container.removeEventListener(Event.SELECT_ALL,this.editHandler);
         }
         else if(this._handlersState == tlf_internal::HANDLERS_MOUSEWHEEL)
         {
            this._container.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
         }
         this._handlersState = tlf_internal::HANDLERS_NOTADDED;
      }
      
      private function addTextFlowListeners() : void
      {
         var event:String = null;
         for each(event in eventList)
         {
            this._textFlow.addEventListener(event,this.dispatchEvent);
         }
      }
      
      private function removeTextFlowListeners() : void
      {
         var event:String = null;
         for each(event in eventList)
         {
            this._textFlow.removeEventListener(event,this.dispatchEvent);
         }
         this._handlersState = tlf_internal::HANDLERS_NONE;
      }
      
      override public function dispatchEvent(event:Event) : Boolean
      {
         if(event.type == DamageEvent.DAMAGE)
         {
            this._textDamaged = true;
            if(this._composeState == tlf_internal::COMPOSE_FACTORY)
            {
               this._damaged = true;
            }
         }
         else if(event.type == FlowOperationEvent.FLOW_OPERATION_BEGIN)
         {
            if(this._container.mouseChildren == false)
            {
               this._container.mouseChildren = true;
            }
         }
         var result:Boolean = super.dispatchEvent(event);
         if(!result)
         {
            event.preventDefault();
         }
         return result;
      }
      
      tlf_internal function clearContainerChildren(recycle:Boolean) : void
      {
         var textLine:TextLine = null;
         var textBlock:TextBlock = null;
         while(this._container.numChildren)
         {
            textLine = this._container.getChildAt(0) as TextLine;
            this._container.removeChildAt(0);
            if(textLine)
            {
               if(textLine.validity != TextLineValidity.INVALID && textLine.validity != TextLineValidity.STATIC)
               {
                  textBlock = textLine.textBlock;
                  textBlock.releaseLines(textBlock.firstLine,textBlock.lastLine);
               }
               if(recycle)
               {
                  textLine.userData = null;
                  TextLineRecycler.addLineForReuse(textLine);
               }
            }
         }
      }
      
      private function convertToTextFlow() : void
      {
         this._textFlow = new TextFlow(this._config);
         this._textFlow.hostFormat = this._hostFormat;
         if(this._swfContext)
         {
            this._textFlow.flowComposer.swfContext = this._swfContext;
         }
         var p:ParagraphElement = new ParagraphElement();
         this._textFlow.addChild(p);
         var s:SpanElement = new SpanElement();
         s.text = this._text;
         p.addChild(s);
         this._sourceState = tlf_internal::SOURCE_TEXTFLOW;
         this.addTextFlowListeners();
      }
      
      tlf_internal function convertToTextFlowWithComposer(callUpdateContainer:Boolean = true) : void
      {
         var controller:TMContainerController = null;
         this.removeActivationEventListeners();
         if(this._sourceState != tlf_internal::SOURCE_TEXTFLOW)
         {
            this.convertToTextFlow();
         }
         if(this._composeState != tlf_internal::COMPOSE_COMPOSER)
         {
            this.clearContainerChildren(true);
            this.clearComposedLines();
            controller = new TMContainerController(this._container,this._compositionWidth,this._compositionHeight,this);
            this._textFlow.flowComposer = new StandardFlowComposer();
            this._textFlow.flowComposer.addController(controller);
            this._textFlow.flowComposer.swfContext = this._swfContext;
            this._composeState = tlf_internal::COMPOSE_COMPOSER;
            this.invalidateInteractionManager();
            if(callUpdateContainer)
            {
               this.updateContainer();
            }
         }
      }
      
      private function get effectiveBlockProgression() : String
      {
         if(this._textFlow)
         {
            return this._textFlow.computedFormat.blockProgression;
         }
         return this._hostFormat && this._hostFormat.blockProgression && this._hostFormat.blockProgression != FormatValue.INHERIT ? this._hostFormat.blockProgression : BlockProgression.TB;
      }
      
      private function removeIBeamCursor() : void
      {
         if(this._ibeamCursorSet)
         {
            Mouse.cursor = Configuration.getCursorString(this.configuration,MouseCursor.AUTO);
            this._ibeamCursorSet = false;
         }
      }
      
      private function get hasScrollRect() : Boolean
      {
         return this._hasScrollRect;
      }
      
      private function set hasScrollRect(value:Boolean) : void
      {
         this._hasScrollRect = value;
      }
      
      public function drawBackgroundAndSetScrollRect(scrollX:Number, scrollY:Number) : Boolean
      {
         var contentWidth:Number = NaN;
         var contentHeight:Number = NaN;
         var width:Number = NaN;
         var height:Number = NaN;
         var controller:ContainerController = null;
         var contentLeft:Number = NaN;
         var contentTop:Number = NaN;
         var cont:Sprite = this.container;
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            contentWidth = this._contentWidth;
            contentHeight = this._contentHeight;
         }
         else
         {
            controller = this.getController();
            contentWidth = controller.contentWidth;
            contentHeight = controller.contentHeight;
         }
         if(isNaN(this.compositionWidth))
         {
            contentLeft = this._composeState == tlf_internal::COMPOSE_FACTORY ? Number(this._contentLeft) : Number(controller.contentLeft);
            width = contentLeft + contentWidth - scrollX;
         }
         else
         {
            width = this.compositionWidth;
         }
         if(isNaN(this.compositionHeight))
         {
            contentTop = this._composeState == tlf_internal::COMPOSE_FACTORY ? Number(this._contentTop) : Number(controller.contentTop);
            height = contentTop + contentHeight - scrollY;
         }
         else
         {
            height = this.compositionHeight;
         }
         if(scrollX == 0 && scrollY == 0 && contentWidth <= width && contentHeight <= height)
         {
            if(this._hasScrollRect)
            {
               cont.scrollRect = null;
               this._hasScrollRect = false;
            }
         }
         else
         {
            cont.scrollRect = new Rectangle(scrollX,scrollY,width,height);
            this._hasScrollRect = true;
            scrollX = cont.scrollRect.x;
            scrollY = cont.scrollRect.y;
            width = cont.scrollRect.width;
            height = cont.scrollRect.height;
         }
         var s:Sprite = cont as Sprite;
         if(s)
         {
            s.graphics.clear();
            s.graphics.beginFill(0,0);
            s.graphics.drawRect(scrollX,scrollY,width,height);
            s.graphics.endFill();
         }
         return this._hasScrollRect;
      }
      
      protected function getFocusedSelectionFormat() : SelectionFormat
      {
         return this._config.focusedSelectionFormat;
      }
      
      protected function getInactiveSelectionFormat() : SelectionFormat
      {
         return this._config.inactiveSelectionFormat;
      }
      
      protected function getUnfocusedSelectionFormat() : SelectionFormat
      {
         return this._config.unfocusedSelectionFormat;
      }
      
      protected function getUndoManager() : IUndoManager
      {
         return new UndoManager();
      }
      
      protected function createContextMenu() : ContextMenu
      {
         return ContainerController.createDefaultContextMenu();
      }
      
      public function editHandler(event:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.convertToTextFlowWithComposer();
            this.getController().editHandler(event);
            this._textFlow.interactionManager.setFocus();
         }
         else
         {
            this.getController().editHandler(event);
         }
      }
      
      public function keyDownHandler(event:KeyboardEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().keyDownHandler(event);
         }
      }
      
      public function keyUpHandler(event:KeyboardEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().keyUpHandler(event);
         }
      }
      
      public function keyFocusChangeHandler(event:FocusEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().keyFocusChangeHandler(event);
         }
      }
      
      public function textInputHandler(event:TextEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().textInputHandler(event);
         }
      }
      
      public function imeStartCompositionHandler(event:IMEEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().imeStartCompositionHandler(event);
         }
      }
      
      public function softKeyboardActivatingHandler(event:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().softKeyboardActivatingHandler(event);
         }
      }
      
      public function mouseDownHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.convertToTextFlowWithComposer();
            this.getController().requiredFocusInHandler(null);
            this.getController().requiredMouseOverHandler(event.target != this.container ? new RemappedMouseEvent(event) : event);
            if(this._hasFocus)
            {
               this.getController().requiredFocusInHandler(null);
            }
            this.getController().requiredMouseDownHandler(event);
         }
         else
         {
            this.getController().mouseDownHandler(event);
         }
      }
      
      public function mouseMoveHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseMoveHandler(event);
         }
      }
      
      public function mouseUpHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseUpHandler(event);
         }
      }
      
      public function mouseDoubleClickHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseDoubleClickHandler(event);
         }
      }
      
      tlf_internal final function requiredMouseOverHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.mouseOverHandler(event);
         }
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().requiredMouseOverHandler(event);
         }
      }
      
      public function mouseOverHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseOverHandler(event);
         }
         else
         {
            if(this.effectiveBlockProgression != BlockProgression.RL)
            {
               Mouse.cursor = MouseCursor.IBEAM;
               this._ibeamCursorSet = true;
            }
            this.addActivationEventListeners();
         }
      }
      
      public function mouseOutHandler(event:MouseEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.removeIBeamCursor();
         }
         else
         {
            this.getController().mouseOutHandler(event);
         }
      }
      
      public function focusInHandler(event:FocusEvent) : void
      {
         this._hasFocus = true;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().focusInHandler(event);
         }
      }
      
      tlf_internal function requiredFocusOutHandler(event:FocusEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().requiredFocusOutHandler(event);
         }
      }
      
      public function focusOutHandler(event:FocusEvent) : void
      {
         this._hasFocus = false;
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().focusOutHandler(event);
         }
      }
      
      public function activateHandler(event:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().activateHandler(event);
         }
      }
      
      public function deactivateHandler(event:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().deactivateHandler(event);
         }
      }
      
      public function focusChangeHandler(event:FocusEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().focusChangeHandler(event);
         }
      }
      
      public function menuSelectHandler(event:ContextMenuEvent) : void
      {
         var contextMenu:ContextMenu = null;
         var cbItems:ContextMenuClipboardItems = null;
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            contextMenu = this._container.contextMenu as ContextMenu;
            if(contextMenu)
            {
               cbItems = contextMenu.clipboardItems;
               cbItems.selectAll = this._editingMode != EditingMode.READ_ONLY;
               cbItems.clear = false;
               cbItems.copy = false;
               cbItems.cut = false;
               cbItems.paste = false;
            }
         }
         else
         {
            this.getController().menuSelectHandler(event);
         }
      }
      
      public function mouseWheelHandler(event:MouseEvent) : void
      {
         if(event.isDefaultPrevented())
         {
            return;
         }
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.convertToTextFlowWithComposer();
            this.getController().requiredMouseOverHandler(event);
         }
         this.getController().mouseWheelHandler(event);
      }
      
      tlf_internal final function requiredFocusInHandler(event:FocusEvent) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_FACTORY)
         {
            this.addActivationEventListeners();
            this.focusInHandler(event);
         }
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().requiredFocusInHandler(event);
         }
      }
      
      public function beginMouseCapture() : void
      {
      }
      
      public function endMouseCapture() : void
      {
      }
      
      public function mouseUpSomewhere(e:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseUpSomewhere(e);
         }
      }
      
      public function mouseMoveSomewhere(e:Event) : void
      {
         if(this._composeState == tlf_internal::COMPOSE_COMPOSER)
         {
            this.getController().mouseUpSomewhere(e);
         }
      }
      
      tlf_internal function getFirstTextLineChildIndex() : int
      {
         var firstTextLine:int = 0;
         for(firstTextLine = 0; firstTextLine < this._container.numChildren; firstTextLine++)
         {
            if(this._container.getChildAt(firstTextLine) is TextLine)
            {
               break;
            }
         }
         return firstTextLine;
      }
      
      tlf_internal function addTextLine(textLine:TextLine, index:int) : void
      {
         this._container.addChildAt(textLine,index);
      }
      
      tlf_internal function removeTextLine(textLine:TextLine) : void
      {
         if(this._container.contains(textLine))
         {
            this._container.removeChild(textLine);
         }
      }
      
      tlf_internal function addBackgroundShape(shape:Shape) : void
      {
         this._container.addChildAt(shape,this.getFirstTextLineChildIndex());
      }
      
      tlf_internal function removeBackgroundShape(shape:Shape) : void
      {
         if(shape.parent)
         {
            shape.parent.removeChild(shape);
         }
      }
      
      tlf_internal function addSelectionContainer(selectionContainer:DisplayObjectContainer) : void
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
      
      tlf_internal function removeSelectionContainer(selectionContainer:DisplayObjectContainer) : void
      {
         selectionContainer.parent.removeChild(selectionContainer);
      }
      
      tlf_internal function addInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject, index:int) : void
      {
         if(parent)
         {
            parent.addChildAt(inlineGraphicElement,index);
         }
      }
      
      tlf_internal function removeInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject) : void
      {
         if(parent && inlineGraphicElement.parent == parent)
         {
            parent.removeChild(inlineGraphicElement);
         }
      }
      
      public function get preserveSelectionOnSetText() : Boolean
      {
         return this._preserveSelectionOnSetText;
      }
      
      public function set preserveSelectionOnSetText(value:Boolean) : void
      {
         this._preserveSelectionOnSetText = value;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.engine.TextLine;
import flash.ui.ContextMenu;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.container.ScrollPolicy;
import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.edit.IInteractionEventHandler;
import flashx.textLayout.formats.BlockProgression;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class TMContainerController extends ContainerController
{
    
   
   private var _inputManager:TextContainerManager;
   
   function TMContainerController(container:Sprite, compositionWidth:Number, compositionHeight:Number, tm:TextContainerManager)
   {
      super(container,compositionWidth,compositionHeight);
      this._inputManager = tm;
      verticalScrollPolicy = tm.verticalScrollPolicy;
      horizontalScrollPolicy = tm.horizontalScrollPolicy;
   }
   
   public function get textContainerManager() : TextContainerManager
   {
      return this._inputManager;
   }
   
   override protected function createContextMenu() : ContextMenu
   {
      return this._inputManager.getContextMenu();
   }
   
   override protected function get attachTransparentBackground() : Boolean
   {
      return false;
   }
   
   tlf_internal function doUpdateVisibleRectangle() : void
   {
      this.updateVisibleRectangle();
   }
   
   override protected function updateVisibleRectangle() : void
   {
      var xpos:Number = NaN;
      var ypos:Number = NaN;
      xpos = horizontalScrollPosition;
      if(tlf_internal::effectiveBlockProgression == BlockProgression.RL && (verticalScrollPolicy != ScrollPolicy.OFF || horizontalScrollPolicy != ScrollPolicy.OFF))
      {
         xpos -= !isNaN(compositionWidth) ? compositionWidth : tlf_internal::contentWidth;
      }
      ypos = verticalScrollPosition;
      _hasScrollRect = this._inputManager.drawBackgroundAndSetScrollRect(xpos,ypos);
   }
   
   override tlf_internal function getInteractionHandler() : IInteractionEventHandler
   {
      return this._inputManager;
   }
   
   override tlf_internal function attachContextMenu() : void
   {
      if(this._inputManager.getContextMenu() != null)
      {
         super.attachContextMenu();
      }
   }
   
   override tlf_internal function removeContextMenu() : void
   {
      if(this._inputManager.getContextMenu())
      {
         super.removeContextMenu();
      }
   }
   
   override protected function getFirstTextLineChildIndex() : int
   {
      return this._inputManager.getFirstTextLineChildIndex();
   }
   
   override protected function addTextLine(textLine:TextLine, index:int) : void
   {
      this._inputManager.addTextLine(textLine,index);
   }
   
   override protected function removeTextLine(textLine:TextLine) : void
   {
      this._inputManager.removeTextLine(textLine);
   }
   
   override protected function addBackgroundShape(shape:Shape) : void
   {
      this._inputManager.addBackgroundShape(shape);
   }
   
   override protected function removeBackgroundShape(shape:Shape) : void
   {
      this._inputManager.removeBackgroundShape(shape);
   }
   
   override protected function addSelectionContainer(selectionContainer:DisplayObjectContainer) : void
   {
      this._inputManager.addSelectionContainer(selectionContainer);
   }
   
   override protected function removeSelectionContainer(selectionContainer:DisplayObjectContainer) : void
   {
      this._inputManager.removeSelectionContainer(selectionContainer);
   }
   
   override protected function addInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject, index:int) : void
   {
      this._inputManager.addInlineGraphicElement(parent,inlineGraphicElement,index);
   }
   
   override protected function removeInlineGraphicElement(parent:DisplayObjectContainer, inlineGraphicElement:DisplayObject) : void
   {
      this._inputManager.removeInlineGraphicElement(parent,inlineGraphicElement);
   }
}

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

class RemappedMouseEvent extends MouseEvent
{
    
   
   private var _event:MouseEvent;
   
   function RemappedMouseEvent(event:MouseEvent, cloning:Boolean = false)
   {
      var containerPoint:Point = null;
      if(!cloning)
      {
         containerPoint = DisplayObject(event.target).localToGlobal(new Point(event.localX,event.localY));
         containerPoint = DisplayObject(event.currentTarget).globalToLocal(containerPoint);
      }
      else
      {
         containerPoint = new Point();
      }
      super(event.type,event.bubbles,event.cancelable,containerPoint.x,containerPoint.y,event.relatedObject,event.ctrlKey,event.altKey,event.shiftKey,event.buttonDown,event.delta);
      this._event = event;
   }
   
   override public function get target() : Object
   {
      return this._event.currentTarget;
   }
   
   override public function get currentTarget() : Object
   {
      return this._event.currentTarget;
   }
   
   override public function get eventPhase() : uint
   {
      return this._event.eventPhase;
   }
   
   override public function get isRelatedObjectInaccessible() : Boolean
   {
      return this._event.isRelatedObjectInaccessible;
   }
   
   override public function get stageX() : Number
   {
      return this._event.stageX;
   }
   
   override public function get stageY() : Number
   {
      return this._event.stageY;
   }
   
   override public function clone() : Event
   {
      var rslt:RemappedMouseEvent = new RemappedMouseEvent(this._event,true);
      rslt.localX = localX;
      rslt.localY = localY;
      return rslt;
   }
   
   override public function updateAfterEvent() : void
   {
      this._event.updateAfterEvent();
   }
   
   override public function isDefaultPrevented() : Boolean
   {
      return this._event.isDefaultPrevented();
   }
   
   override public function preventDefault() : void
   {
      this._event.preventDefault();
   }
   
   override public function stopImmediatePropagation() : void
   {
      this._event.stopImmediatePropagation();
   }
   
   override public function stopPropagation() : void
   {
      this._event.stopPropagation();
   }
}

import flashx.textLayout.compose.IFlowComposer;
import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.factory.TextFlowTextLineFactory;
import flashx.textLayout.tlf_internal;

class TCMTextFlowTextLineFactory extends TextFlowTextLineFactory
{
    
   
   private var _tcm:TextContainerManager;
   
   function TCMTextFlowTextLineFactory()
   {
      super();
   }
   
   override tlf_internal function createFlowComposer() : IFlowComposer
   {
      return new TCMFactoryDisplayComposer(this._tcm);
   }
   
   public function get tcm() : TextContainerManager
   {
      return this._tcm;
   }
   
   public function set tcm(val:TextContainerManager) : void
   {
      this._tcm = val;
   }
}

import flashx.textLayout.compose.SimpleCompose;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.factory.FactoryDisplayComposer;
import flashx.textLayout.factory.TextLineFactoryBase;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class TCMFactoryDisplayComposer extends FactoryDisplayComposer
{
    
   
   tlf_internal var _tcm:TextContainerManager;
   
   function TCMFactoryDisplayComposer(tcm:TextContainerManager)
   {
      super();
      this._tcm = tcm;
   }
   
   override tlf_internal function callTheComposer(absoluteEndPosition:int, controllerEndIndex:int) : ContainerController
   {
      clearCompositionResults();
      var state:SimpleCompose = TextLineFactoryBase._factoryComposer;
      state.resetLineHandler = this._tcm.resetLine;
      state.composeTextFlow(textFlow,-1,-1);
      state.releaseAnyReferences();
      return getControllerAt(0);
   }
}
