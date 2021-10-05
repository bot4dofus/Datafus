package flashx.textLayout.elements
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.text.engine.ContentElement;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.FontMetrics;
   import flash.text.engine.GraphicElement;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextRotation;
   import flashx.textLayout.compose.ISWFContext;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.events.StatusChangeEvent;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.JustificationRule;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class InlineGraphicElement extends FlowLeafElement
   {
      
      private static const graphicElementText:String = String.fromCharCode(ContentElement.GRAPHIC_ELEMENT);
      
      private static const LOAD_INITIATED:String = "loadInitiated";
      
      private static const OPEN_RECEIVED:String = "openReceived";
      
      private static const LOAD_COMPLETE:String = "loadComplete";
      
      private static const EMBED_LOADED:String = "embedLoaded";
      
      private static const DISPLAY_OBJECT:String = "displayObject";
      
      private static const NULL_GRAPHIC:String = "nullGraphic";
      
      private static var isMac:Boolean = Capabilities.os.search("Mac OS") > -1;
      
      tlf_internal static const heightPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("height",FormatValue.AUTO,false,null,0,32000,"0%","1000000%",FormatValue.AUTO);
      
      tlf_internal static const widthPropertyDefinition:Property = Property.NewNumberOrPercentOrEnumProperty("width",FormatValue.AUTO,false,null,0,32000,"0%","1000000%",FormatValue.AUTO);
      
      tlf_internal static const rotationPropertyDefinition:Property = Property.NewEnumStringProperty("rotation",TextRotation.ROTATE_0,false,null,TextRotation.ROTATE_0,TextRotation.ROTATE_90,TextRotation.ROTATE_180,TextRotation.ROTATE_270);
      
      tlf_internal static const floatPropertyDefinition:Property = Property.NewEnumStringProperty("float",Float.NONE,false,null,Float.NONE,Float.LEFT,Float.RIGHT,Float.START,Float.END);
       
      
      private var _source:Object;
      
      private var _graphic:DisplayObject;
      
      private var _placeholderGraphic:Sprite;
      
      private var _elementWidth:Number;
      
      private var _elementHeight:Number;
      
      private var _graphicStatus:Object;
      
      private var okToUpdateHeightAndWidth:Boolean;
      
      private var _width;
      
      private var _height;
      
      private var _measuredWidth:Number;
      
      private var _measuredHeight:Number;
      
      private var _float;
      
      private var _effectiveFloat:String;
      
      public function InlineGraphicElement()
      {
         super();
         this.okToUpdateHeightAndWidth = false;
         this._measuredWidth = 0;
         this._measuredHeight = 0;
         this.internalSetWidth(undefined);
         this.internalSetHeight(undefined);
         this._graphicStatus = InlineGraphicElementStatus.LOAD_PENDING;
         setTextLength(1);
         _text = graphicElementText;
      }
      
      private static function recursiveShutDownGraphic(graphic:DisplayObject) : void
      {
         var container:DisplayObjectContainer = null;
         var idx:int = 0;
         if(graphic is Loader)
         {
            Loader(graphic).unloadAndStop();
         }
         else if(graphic)
         {
            container = graphic as DisplayObjectContainer;
            if(container)
            {
               for(idx = 0; idx < container.numChildren; idx++)
               {
                  recursiveShutDownGraphic(container.getChildAt(idx));
               }
            }
            if(graphic is MovieClip)
            {
               MovieClip(graphic).stop();
            }
         }
      }
      
      override tlf_internal function createContentElement() : void
      {
         if(_blockElement)
         {
            return;
         }
         this.computedFormat;
         var graphicElement:GraphicElement = new GraphicElement();
         _blockElement = graphicElement;
         this.updateContentElement();
         super.createContentElement();
      }
      
      private function updateContentElement() : void
      {
         var height:Number = NaN;
         var width:Number = NaN;
         var graphicElement:GraphicElement = _blockElement as GraphicElement;
         if(!this._placeholderGraphic)
         {
            this._placeholderGraphic = new Sprite();
         }
         graphicElement.graphic = this._placeholderGraphic;
         if(this.effectiveFloat != Float.NONE)
         {
            if(graphicElement.elementHeight != 0)
            {
               graphicElement.elementHeight = 0;
            }
            if(graphicElement.elementWidth != 0)
            {
               graphicElement.elementWidth = 0;
            }
         }
         else
         {
            height = this.elementHeightWithMarginsAndPadding();
            if(graphicElement.elementHeight != height)
            {
               graphicElement.elementHeight = height;
            }
            width = this.elementWidthWithMarginsAndPadding();
            if(graphicElement.elementWidth != width)
            {
               graphicElement.elementWidth = width;
            }
         }
      }
      
      override public function get computedFormat() : ITextLayoutFormat
      {
         var updateGraphicElement:* = _computedFormat == null;
         super.computedFormat;
         if(updateGraphicElement && _blockElement)
         {
            this.updateContentElement();
         }
         return _computedFormat;
      }
      
      tlf_internal function elementWidthWithMarginsAndPadding() : Number
      {
         var textFlow:TextFlow = getTextFlow();
         if(!textFlow)
         {
            return this.elementWidth;
         }
         var paddingAmount:Number = textFlow.computedFormat.blockProgression == BlockProgression.RL ? Number(getEffectivePaddingTop() + getEffectivePaddingBottom()) : Number(getEffectivePaddingLeft() + getEffectivePaddingRight());
         return this.elementWidth + paddingAmount;
      }
      
      tlf_internal function elementHeightWithMarginsAndPadding() : Number
      {
         var textFlow:TextFlow = getTextFlow();
         if(!textFlow)
         {
            return this.elementHeight;
         }
         var paddingAmount:Number = textFlow.computedFormat.blockProgression == BlockProgression.RL ? Number(getEffectivePaddingLeft() + getEffectivePaddingRight()) : Number(getEffectivePaddingTop() + getEffectivePaddingBottom());
         return this.elementHeight + paddingAmount;
      }
      
      public function get graphic() : DisplayObject
      {
         return this._graphic;
      }
      
      private function setGraphic(value:DisplayObject) : void
      {
         this._graphic = value;
      }
      
      tlf_internal function get placeholderGraphic() : Sprite
      {
         return this._placeholderGraphic;
      }
      
      tlf_internal function get elementWidth() : Number
      {
         return this._elementWidth;
      }
      
      tlf_internal function set elementWidth(value:Number) : void
      {
         this._elementWidth = value;
         if(_blockElement)
         {
            (_blockElement as GraphicElement).elementWidth = this.effectiveFloat != Float.NONE ? Number(0) : Number(this.elementWidthWithMarginsAndPadding());
         }
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength,true,false);
      }
      
      tlf_internal function get elementHeight() : Number
      {
         return this._elementHeight;
      }
      
      tlf_internal function set elementHeight(value:Number) : void
      {
         this._elementHeight = value;
         if(_blockElement)
         {
            (_blockElement as GraphicElement).elementHeight = this.effectiveFloat != Float.NONE ? Number(0) : Number(this.elementHeightWithMarginsAndPadding());
         }
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength,true,false);
      }
      
      public function get status() : String
      {
         switch(this._graphicStatus)
         {
            case LOAD_INITIATED:
            case OPEN_RECEIVED:
               return InlineGraphicElementStatus.LOADING;
            case LOAD_COMPLETE:
            case EMBED_LOADED:
            case DISPLAY_OBJECT:
            case NULL_GRAPHIC:
               return InlineGraphicElementStatus.READY;
            case InlineGraphicElementStatus.LOAD_PENDING:
            case InlineGraphicElementStatus.SIZE_PENDING:
               return String(this._graphicStatus);
            default:
               return InlineGraphicElementStatus.ERROR;
         }
      }
      
      override public function getText(relativeStart:int = 0, relativeEnd:int = -1, paragraphSeparator:String = "\n") : String
      {
         if(relativeEnd == -1)
         {
            relativeEnd = textLength;
         }
         return !!_text ? _text.substring(relativeStart,relativeEnd) : "";
      }
      
      private function changeGraphicStatus(stat:Object) : void
      {
         var tf:TextFlow = null;
         var oldStatus:String = this.status;
         this._graphicStatus = stat;
         var newStatus:String = this.status;
         if(oldStatus != newStatus || stat is ErrorEvent)
         {
            tf = getTextFlow();
            if(tf)
            {
               if(newStatus == InlineGraphicElementStatus.SIZE_PENDING)
               {
                  tf.processAutoSizeImageLoaded(this);
               }
               tf.dispatchEvent(new StatusChangeEvent(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,false,false,this,newStatus,stat as ErrorEvent));
            }
         }
      }
      
      public function get width() : *
      {
         return this._width;
      }
      
      public function set width(w:*) : void
      {
         this.internalSetWidth(w);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get measuredWidth() : Number
      {
         return this._measuredWidth;
      }
      
      public function get actualWidth() : Number
      {
         return this.elementWidth;
      }
      
      private function widthIsComputed() : Boolean
      {
         return this.internalWidth is String;
      }
      
      private function get internalWidth() : Object
      {
         return this._width === undefined ? tlf_internal::widthPropertyDefinition.defaultValue : this._width;
      }
      
      private function computeWidth() : Number
      {
         var effHeight:Number = NaN;
         if(this.internalWidth == FormatValue.AUTO)
         {
            if(this.internalHeight == FormatValue.AUTO)
            {
               return this._measuredWidth;
            }
            if(this._measuredHeight == 0 || this._measuredWidth == 0)
            {
               return 0;
            }
            effHeight = !!this.heightIsComputed() ? Number(this.computeHeight()) : Number(Number(this.internalHeight));
            return effHeight / this._measuredHeight * this._measuredWidth;
         }
         return tlf_internal::widthPropertyDefinition.computeActualPropertyValue(this.internalWidth,this._measuredWidth);
      }
      
      private function internalSetWidth(w:*) : void
      {
         this._width = tlf_internal::widthPropertyDefinition.setHelper(this.width,w);
         this.elementWidth = !!this.widthIsComputed() ? Number(0) : Number(Number(this.internalWidth));
         if(this.okToUpdateHeightAndWidth && this.graphic)
         {
            if(this.widthIsComputed())
            {
               this.elementWidth = this.computeWidth();
            }
            this.graphic.width = this.elementWidth;
            if(this.internalHeight == FormatValue.AUTO)
            {
               this.elementHeight = this.computeHeight();
               this.graphic.height = this.elementHeight;
            }
         }
      }
      
      public function get height() : *
      {
         return this._height;
      }
      
      public function set height(h:*) : void
      {
         this.internalSetHeight(h);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      private function get internalHeight() : Object
      {
         return this._height === undefined ? tlf_internal::heightPropertyDefinition.defaultValue : this._height;
      }
      
      tlf_internal function get computedFloat() : *
      {
         if(this._float === undefined)
         {
            return tlf_internal::floatPropertyDefinition.defaultValue;
         }
         return this._float;
      }
      
      tlf_internal function get effectiveFloat() : *
      {
         return !!this._effectiveFloat ? this._effectiveFloat : this.computedFloat;
      }
      
      tlf_internal function setEffectiveFloat(floatValue:String) : void
      {
         if(this._effectiveFloat != floatValue)
         {
            this._effectiveFloat = floatValue;
            if(_blockElement)
            {
               this.updateContentElement();
            }
         }
      }
      
      [Inspectable(enumeration="none,left,right,start,end")]
      public function get float() : *
      {
         return this._float;
      }
      
      public function set float(value:*) : *
      {
         value = tlf_internal::floatPropertyDefinition.setHelper(this.float,value) as String;
         if(this._float != value)
         {
            this._float = value;
            if(_blockElement)
            {
               this.updateContentElement();
            }
            modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
         }
      }
      
      public function get measuredHeight() : Number
      {
         return this._measuredHeight;
      }
      
      public function get actualHeight() : Number
      {
         return this.elementHeight;
      }
      
      private function heightIsComputed() : Boolean
      {
         return this.internalHeight is String;
      }
      
      private function computeHeight() : Number
      {
         var effWidth:Number = NaN;
         if(this.internalHeight == FormatValue.AUTO)
         {
            if(this.internalWidth == FormatValue.AUTO)
            {
               return this._measuredHeight;
            }
            if(this._measuredHeight == 0 || this._measuredWidth == 0)
            {
               return 0;
            }
            effWidth = !!this.widthIsComputed() ? Number(this.computeWidth()) : Number(Number(this.internalWidth));
            return effWidth / this._measuredWidth * this._measuredHeight;
         }
         return tlf_internal::heightPropertyDefinition.computeActualPropertyValue(this.internalHeight,this._measuredHeight);
      }
      
      private function internalSetHeight(h:*) : void
      {
         this._height = tlf_internal::heightPropertyDefinition.setHelper(this.height,h);
         this.elementHeight = !!this.heightIsComputed() ? Number(0) : Number(Number(this.internalHeight));
         if(this.okToUpdateHeightAndWidth && this.graphic != null)
         {
            if(this.heightIsComputed())
            {
               this.elementHeight = this.computeHeight();
            }
            this.graphic.height = this.elementHeight;
            if(this.internalWidth == FormatValue.AUTO)
            {
               this.elementWidth = this.computeWidth();
               this.graphic.width = this.elementWidth;
            }
         }
      }
      
      private function loadCompleteHandler(e:Event) : void
      {
         this.removeDefaultLoadHandlers(this.graphic as Loader);
         this.okToUpdateHeightAndWidth = true;
         var g:DisplayObject = this.graphic;
         this._measuredWidth = g.width;
         this._measuredHeight = g.height;
         if(this.graphic is Loader && Loader(this.graphic).contentLoaderInfo.contentType == "application/x-shockwave-flash" && Loader(this.graphic).content != null && Loader(this.graphic).content.hasOwnProperty("setActualSize") && (!this.widthIsComputed() || !this.heightIsComputed()))
         {
            Object(Loader(this.graphic).content).setActualSize(this.elementWidth,this.elementHeight);
         }
         else
         {
            if(!this.widthIsComputed())
            {
               g.width = this.elementWidth;
            }
            if(!this.heightIsComputed())
            {
               g.height = this.elementHeight;
            }
         }
         if(e is IOErrorEvent)
         {
            this.changeGraphicStatus(e);
         }
         else if(this.widthIsComputed() || this.heightIsComputed())
         {
            g.visible = false;
            this.changeGraphicStatus(InlineGraphicElementStatus.SIZE_PENDING);
         }
         else
         {
            this.changeGraphicStatus(LOAD_COMPLETE);
         }
      }
      
      private function openHandler(e:Event) : void
      {
         this.changeGraphicStatus(OPEN_RECEIVED);
      }
      
      private function addDefaultLoadHandlers(loader:Loader) : void
      {
         var loaderInfo:LoaderInfo = loader.contentLoaderInfo;
         loaderInfo.addEventListener(Event.OPEN,this.openHandler,false,0,true);
         loaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler,false,0,true);
         loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadCompleteHandler,false,0,true);
      }
      
      private function removeDefaultLoadHandlers(loader:Loader) : void
      {
         loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.openHandler);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadCompleteHandler);
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(value:Object) : void
      {
         this.stop(true);
         this._source = value;
         this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      override tlf_internal function applyDelayedElementUpdate(textFlow:TextFlow, okToUnloadGraphics:Boolean, hasController:Boolean) : void
      {
         var source:Object = null;
         var elem:DisplayObject = null;
         var cILGStatus:String = null;
         var inlineGraphicResolver:Function = null;
         var loader:Loader = null;
         var myPattern:RegExp = null;
         var src:String = null;
         var pictURLReq:URLRequest = null;
         var cls:Class = null;
         if(textFlow != this.getTextFlow())
         {
            var hasController:Boolean = false;
         }
         if(this._graphicStatus == InlineGraphicElementStatus.LOAD_PENDING)
         {
            if(hasController)
            {
               source = this._source;
               if(source is String)
               {
                  inlineGraphicResolver = textFlow.configuration.inlineGraphicResolverFunction;
                  if(inlineGraphicResolver != null)
                  {
                     source = inlineGraphicResolver(this);
                  }
               }
               cILGStatus = null;
               if(source is String || source is URLRequest)
               {
                  this.okToUpdateHeightAndWidth = false;
                  loader = new Loader();
                  try
                  {
                     this.addDefaultLoadHandlers(loader);
                     if(source is String)
                     {
                        myPattern = /\\/g;
                        src = source as String;
                        src = src.replace(myPattern,"/");
                        if(isMac)
                        {
                           pictURLReq = new URLRequest(encodeURI(src));
                        }
                        else
                        {
                           pictURLReq = new URLRequest(src);
                        }
                        loader.load(pictURLReq);
                     }
                     else
                     {
                        loader.load(URLRequest(source));
                     }
                     this.setGraphic(loader);
                     this.changeGraphicStatus(LOAD_INITIATED);
                     cILGStatus = LOAD_INITIATED;
                  }
                  catch(e:Error)
                  {
                     removeDefaultLoadHandlers(loader);
                     elem = new Shape();
                     changeGraphicStatus(NULL_GRAPHIC);
                     cILGStatus = NULL_GRAPHIC;
                  }
               }
               else if(source is Class)
               {
                  cls = source as Class;
                  elem = DisplayObject(new cls());
                  cILGStatus = EMBED_LOADED;
               }
               else if(source is DisplayObject)
               {
                  elem = DisplayObject(source);
                  cILGStatus = DISPLAY_OBJECT;
               }
               else
               {
                  elem = new Shape();
                  cILGStatus = NULL_GRAPHIC;
               }
               if(cILGStatus != LOAD_INITIATED)
               {
                  this.okToUpdateHeightAndWidth = true;
                  this._measuredWidth = !!elem ? Number(elem.width) : Number(0);
                  this._measuredHeight = !!elem ? Number(elem.height) : Number(0);
                  if(this.widthIsComputed())
                  {
                     if(elem)
                     {
                        elem.width = this.elementWidth = this.computeWidth();
                     }
                     else
                     {
                        this.elementWidth = 0;
                     }
                  }
                  else
                  {
                     elem.width = Number(this.width);
                  }
                  if(this.heightIsComputed())
                  {
                     if(elem)
                     {
                        elem.height = this.elementHeight = this.computeHeight();
                     }
                     else
                     {
                        this.elementHeight = 0;
                     }
                  }
                  else
                  {
                     elem.height = Number(this.height);
                  }
                  this.setGraphic(elem);
                  if(cILGStatus != null)
                  {
                     this.changeGraphicStatus(cILGStatus);
                  }
               }
            }
         }
         else
         {
            if(this._graphicStatus == InlineGraphicElementStatus.SIZE_PENDING)
            {
               this.updateAutoSizes();
               this.graphic.visible = true;
               this.changeGraphicStatus(LOAD_COMPLETE);
            }
            if(!hasController)
            {
               this.stop(okToUnloadGraphics);
            }
         }
      }
      
      override tlf_internal function updateForMustUseComposer(textFlow:TextFlow) : Boolean
      {
         this.applyDelayedElementUpdate(textFlow,false,true);
         return this.status != InlineGraphicElementStatus.READY;
      }
      
      private function updateAutoSizes() : void
      {
         if(this.widthIsComputed())
         {
            this.elementWidth = this.computeWidth();
            this.graphic.width = this.elementWidth;
         }
         if(this.heightIsComputed())
         {
            this.elementHeight = this.computeHeight();
            this.graphic.height = this.elementHeight;
         }
      }
      
      tlf_internal function stop(okToUnloadGraphics:Boolean) : Boolean
      {
         var loader:Loader = null;
         if(this._graphicStatus == OPEN_RECEIVED || this._graphicStatus == LOAD_INITIATED)
         {
            loader = this.graphic as Loader;
            try
            {
               loader.close();
            }
            catch(e:Error)
            {
            }
            this.removeDefaultLoadHandlers(loader);
         }
         if(this._graphicStatus != DISPLAY_OBJECT)
         {
            if(okToUnloadGraphics)
            {
               recursiveShutDownGraphic(this.graphic);
               this.setGraphic(null);
            }
            if(this.widthIsComputed())
            {
               this.elementWidth = 0;
            }
            if(this.heightIsComputed())
            {
               this.elementHeight = 0;
            }
            this.changeGraphicStatus(InlineGraphicElementStatus.LOAD_PENDING);
         }
         return true;
      }
      
      override tlf_internal function getEffectiveFontSize() : Number
      {
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         var defaultLeading:Number = super.getEffectiveFontSize();
         return Math.max(defaultLeading,this.elementHeightWithMarginsAndPadding());
      }
      
      override tlf_internal function getEffectiveLineHeight(blockProgression:String) : Number
      {
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         return super.getEffectiveLineHeight(blockProgression);
      }
      
      tlf_internal function getTypographicAscent(textLine:TextLine) : Number
      {
         var dominantBaselineString:String = null;
         if(this.effectiveFloat != Float.NONE)
         {
            return 0;
         }
         var effectiveHeight:Number = this.elementHeightWithMarginsAndPadding();
         if(this._computedFormat.dominantBaseline != FormatValue.AUTO)
         {
            dominantBaselineString = this._computedFormat.dominantBaseline;
         }
         else
         {
            dominantBaselineString = this.getParagraph().getEffectiveDominantBaseline();
         }
         var elementFormat:ElementFormat = !!_blockElement ? _blockElement.elementFormat : computeElementFormat();
         var alignmentBaseline:String = elementFormat.alignmentBaseline == TextBaseline.USE_DOMINANT_BASELINE ? dominantBaselineString : elementFormat.alignmentBaseline;
         var top:Number = 0;
         if(dominantBaselineString == TextBaseline.IDEOGRAPHIC_CENTER)
         {
            top += effectiveHeight / 2;
         }
         else if(dominantBaselineString == TextBaseline.IDEOGRAPHIC_BOTTOM || dominantBaselineString == TextBaseline.DESCENT || dominantBaselineString == TextBaseline.ROMAN)
         {
            top += effectiveHeight;
         }
         top += textLine.getBaselinePosition(TextBaseline.ROMAN) - textLine.getBaselinePosition(alignmentBaseline);
         return Number(top + elementFormat.baselineShift);
      }
      
      override tlf_internal function getCSSInlineBox(blockProgression:String, textLine:TextLine, para:ParagraphElement = null, swfContext:ISWFContext = null) : Rectangle
      {
         if(this.effectiveFloat != Float.NONE)
         {
            return null;
         }
         var inlineBox:Rectangle = new Rectangle();
         inlineBox.top = -this.getTypographicAscent(textLine);
         inlineBox.height = this.elementHeightWithMarginsAndPadding();
         inlineBox.width = this.elementWidth;
         return inlineBox;
      }
      
      override tlf_internal function updateIMEAdornments(tLine:TextLine, blockProgression:String, imeStatus:String) : void
      {
         if(this.effectiveFloat == Float.NONE)
         {
            super.updateIMEAdornments(tLine,blockProgression,imeStatus);
         }
      }
      
      override tlf_internal function updateAdornments(tLine:TextLine, blockProgression:String) : int
      {
         if(this.effectiveFloat == Float.NONE)
         {
            return super.updateAdornments(tLine,blockProgression);
         }
         return 0;
      }
      
      override public function shallowCopy(startPos:int = 0, endPos:int = -1) : FlowElement
      {
         if(endPos == -1)
         {
            endPos = textLength;
         }
         var retFlow:InlineGraphicElement = super.shallowCopy(startPos,endPos) as InlineGraphicElement;
         retFlow.source = this.source;
         retFlow.width = this.width;
         retFlow.height = this.height;
         retFlow.float = this.float;
         return retFlow;
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "img";
      }
      
      override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void
      {
         if(changeType == ModelChange.ELEMENT_ADDED)
         {
            tf.incGraphicObjectCount();
         }
         else if(changeType == ModelChange.ELEMENT_REMOVAL)
         {
            tf.decGraphicObjectCount();
         }
         if(this.status != InlineGraphicElementStatus.READY || changeType == ModelChange.ELEMENT_REMOVAL)
         {
            tf.appendOneElementForUpdate(this);
         }
      }
      
      override tlf_internal function calculateStrikeThrough(tLine:TextLine, blockProgression:String, metrics:FontMetrics) : Number
      {
         var paddingRight:Number = NaN;
         var line:TextFlowLine = null;
         var elemIdx:int = 0;
         if(!this.graphic || this.status != InlineGraphicElementStatus.READY)
         {
            return super.calculateStrikeThrough(tLine,blockProgression,metrics);
         }
         var stOffset:Number = 0;
         var inlineHolder:DisplayObjectContainer = this._placeholderGraphic.parent;
         if(inlineHolder)
         {
            if(blockProgression != BlockProgression.RL)
            {
               stOffset = this.placeholderGraphic.parent.y + (this.elementHeight / 2 + Number(getEffectivePaddingTop()));
            }
            else
            {
               paddingRight = getEffectivePaddingRight();
               line = tLine.userData as TextFlowLine;
               elemIdx = this.getAbsoluteStart() - line.absoluteStart;
               if(tLine.getAtomTextRotation(elemIdx) != TextRotation.ROTATE_0)
               {
                  stOffset = this._placeholderGraphic.parent.x - (this.elementHeight / 2 + paddingRight);
               }
               else
               {
                  stOffset = this._placeholderGraphic.parent.x - (this.elementWidth / 2 + paddingRight);
               }
            }
         }
         return blockProgression == BlockProgression.TB ? Number(stOffset) : Number(-stOffset);
      }
      
      override tlf_internal function calculateUnderlineOffset(stOffset:Number, blockProgression:String, metrics:FontMetrics, tLine:TextLine) : Number
      {
         if(!this.graphic || this.status != InlineGraphicElementStatus.READY)
         {
            return super.calculateUnderlineOffset(stOffset,blockProgression,metrics,tLine);
         }
         var para:ParagraphElement = this.getParagraph();
         var ulOffset:Number = 0;
         var inlineHolder:DisplayObjectContainer = this._placeholderGraphic.parent;
         if(inlineHolder)
         {
            if(blockProgression == BlockProgression.TB)
            {
               ulOffset = inlineHolder.y + this.elementHeightWithMarginsAndPadding();
            }
            else
            {
               if(para.computedFormat.locale.toLowerCase().indexOf("zh") == 0)
               {
                  ulOffset = inlineHolder.x - this.elementHeightWithMarginsAndPadding();
                  return Number(ulOffset - (metrics.underlineOffset + metrics.underlineThickness / 2));
               }
               ulOffset = inlineHolder.x - getEffectivePaddingLeft();
            }
         }
         ulOffset += metrics.underlineOffset + metrics.underlineThickness / 2;
         var justRule:String = para.getEffectiveJustificationRule();
         if(justRule == JustificationRule.EAST_ASIAN)
         {
            ulOffset += 1;
         }
         return ulOffset;
      }
   }
}
