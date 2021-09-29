package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.messages.TextClickMessage;
   import com.ankamagames.berilia.events.LinkInteractionEvent;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.UserFont;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.utils.UIDUtil;
   
   public class Label extends GraphicContainer implements UIComponent, IRectangle, FinalizableUIComponent
   {
      
      public static var HEIGHT_OFFSET:int = 0;
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Label));
      
      private static const VALIGN_NONE:String = "NONE";
      
      private static const VALIGN_TOP:String = "TOP";
      
      private static const VALIGN_CENTER:String = "CENTER";
      
      private static const VALIGN_BOTTOM:String = "BOTTOM";
      
      private static const VALIGN_FIXEDHEIGHT:String = "FIXEDHEIGHT";
      
      private static const _filterIndex:Dictionary = new Dictionary();
       
      
      protected var _tText:TextField;
      
      private var _cssApplied:Boolean = false;
      
      protected var _sText:String = "";
      
      protected var _sType:String = "default";
      
      protected var _parseText:Boolean = true;
      
      private var _binded:Boolean = false;
      
      private var _needToFinalize:Boolean = false;
      
      private var _lastWidth:Number = -1;
      
      private var _uid:String = null;
      
      protected var _sCssUrl:Uri;
      
      protected var _nWidth:uint = 100;
      
      protected var _nHeight:uint = 20;
      
      protected var _bHtmlAllowed:Boolean = true;
      
      protected var _sAntialiasType:String = "normal";
      
      protected var _bFixedWidth:Boolean = true;
      
      protected var _hyperlinkEnabled:Boolean = false;
      
      protected var _bFixedHeight:Boolean = true;
      
      protected var _bFixedHeightForMultiline:Boolean = false;
      
      protected var _aStyleObj:Array;
      
      protected var _ssSheet:ExtendedStyleSheet;
      
      protected var _tfFormatter:TextFormat;
      
      protected var _useEmbedFonts:Boolean = true;
      
      protected var _useDefaultFont:Boolean = false;
      
      protected var _useFontResize:Boolean = true;
      
      protected var _nPaddingLeft:int = 0;
      
      protected var _nPaddingRight:int = 0;
      
      protected var _nTextIndent:int = 0;
      
      protected var _verticalOffset:Number = 0.0;
      
      protected var _bDisabled:Boolean;
      
      protected var _nTextHeight:int;
      
      protected var _sVerticalAlign:String = "none";
      
      protected var _useExtendWidth:Boolean = false;
      
      protected var _autoResize:Boolean = true;
      
      protected var _useStyleSheet:Boolean = false;
      
      protected var _currentStyleSheet:StyleSheet;
      
      protected var _useCustomFormat:Boolean = false;
      
      protected var _neverIndent:Boolean = false;
      
      protected var _hasHandCursor:Boolean = false;
      
      protected var _shiftClickActivated:Boolean = true;
      
      protected var _forceUppercase:Boolean = false;
      
      private var _useTooltipExtension:Boolean = true;
      
      private var _textFieldTooltipExtension:TextField;
      
      private var _textTooltipExtensionColor:uint;
      
      private var _mouseOverHyperLink:Boolean;
      
      private var _lastHyperLinkId:int;
      
      private var _hyperLinks:Array;
      
      protected var _sCssClass:String;
      
      public function Label()
      {
         super();
         this.aStyleObj = new Array();
         this.createTextField();
         this._tText.type = TextFieldType.DYNAMIC;
         this._tText.selectable = false;
         this._tText.mouseEnabled = false;
         this.useFontResize = this._useFontResize;
         MEMORY_LOG[this] = 1;
      }
      
      public function get text() : String
      {
         return this._tText.text;
      }
      
      public function set text(sValue:String) : void
      {
         if(sValue == null)
         {
            sValue = "";
         }
         if(this._forceUppercase)
         {
            sValue = sValue.toLocaleUpperCase();
         }
         this._sText = sValue;
         if(this._bHtmlAllowed)
         {
            if(this._useStyleSheet)
            {
               this._tText.styleSheet = null;
            }
            this._tText.htmlText = sValue;
            if(!this._useCustomFormat)
            {
               if(this._sCssUrl != null && !this._cssApplied)
               {
                  this.applyCSS(this._sCssUrl);
                  this._cssApplied = true;
               }
               else
               {
                  this.updateCss();
                  if(_bgColor != -1)
                  {
                     this.bgColor = _bgColor;
                  }
               }
            }
         }
         else
         {
            this._tText.text = sValue;
         }
         if(!this._useCustomFormat && !this._sCssClass)
         {
            this.cssClass = "p";
         }
         if(this._hyperlinkEnabled)
         {
            HyperlinkFactory.createTextClickHandler(this._tText,this._useStyleSheet);
            HyperlinkFactory.createRollOverHandler(this._tText);
            this.parseLinks();
         }
         if(this._currentStyleSheet)
         {
            if(this._hyperlinkEnabled)
            {
               sValue = HyperlinkFactory.decode(sValue);
               this.parseLinks();
            }
            this._tText.styleSheet = this._currentStyleSheet;
            this._tText.htmlText = sValue;
         }
         if(_finalized && this._autoResize)
         {
            this.resizeText();
         }
      }
      
      public function get htmlText() : String
      {
         return this._tText.htmlText;
      }
      
      public function set htmlText(val:String) : void
      {
         if(this._forceUppercase)
         {
            val = val.toLocaleUpperCase();
         }
         this._tText.htmlText = val;
         if(this._hyperlinkEnabled)
         {
            HyperlinkFactory.createTextClickHandler(this._tText);
            HyperlinkFactory.createRollOverHandler(this._tText);
            this.parseLinks();
         }
      }
      
      public function get parseText() : Boolean
      {
         return this._parseText;
      }
      
      public function set parseText(value:Boolean) : void
      {
         this._parseText = value;
      }
      
      public function get hyperlinkEnabled() : Boolean
      {
         return this._hyperlinkEnabled;
      }
      
      public function get mouseOverHyperLink() : Boolean
      {
         return this._mouseOverHyperLink;
      }
      
      public function set hyperlinkEnabled(bValue:Boolean) : void
      {
         this._hyperlinkEnabled = bValue;
         mouseEnabled = bValue;
         mouseChildren = bValue;
         this._tText.mouseEnabled = bValue;
         if(bValue)
         {
            this._hyperLinks = [];
            this._tText.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            this._tText.addEventListener(MouseEvent.ROLL_OUT,this.hyperlinkRollOut);
         }
         else
         {
            this._tText.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            this._tText.removeEventListener(MouseEvent.ROLL_OUT,this.hyperlinkRollOut);
         }
      }
      
      public function get useStyleSheet() : Boolean
      {
         return this._useStyleSheet;
      }
      
      public function set useStyleSheet(bValue:Boolean) : void
      {
         this._useStyleSheet = bValue;
      }
      
      public function get useCustomFormat() : Boolean
      {
         return this._useCustomFormat;
      }
      
      public function set useCustomFormat(bValue:Boolean) : void
      {
         this._useCustomFormat = bValue;
      }
      
      public function get shiftClickActivated() : Boolean
      {
         return this._shiftClickActivated;
      }
      
      public function set shiftClickActivated(bValue:Boolean) : void
      {
         this._shiftClickActivated = bValue;
      }
      
      public function get neverIndent() : Boolean
      {
         return this._neverIndent;
      }
      
      public function set neverIndent(bValue:Boolean) : void
      {
         this._neverIndent = bValue;
      }
      
      public function get autoResize() : Boolean
      {
         return this._autoResize;
      }
      
      public function set autoResize(bValue:Boolean) : void
      {
         this._autoResize = bValue;
      }
      
      public function get caretIndex() : int
      {
         return this._tText.caretIndex;
      }
      
      public function set caretIndex(pos:int) : void
      {
         var lastPos:int = 0;
         if(pos == -1)
         {
            lastPos = this._tText.text.length;
            this._tText.setSelection(lastPos,lastPos);
         }
         else
         {
            this._tText.setSelection(pos,pos);
         }
      }
      
      public function selectAll() : void
      {
         this._tText.setSelection(0,this._tText.length);
      }
      
      public function getCharBoundaries(charPos:Number) : Rectangle
      {
         return this._tText.getCharBoundaries(charPos);
      }
      
      public function get type() : String
      {
         return this._sType;
      }
      
      public function set type(sValue:String) : void
      {
         this._sType = sValue;
      }
      
      [Uri]
      public function get css() : Uri
      {
         return this._sCssUrl;
      }
      
      [Uri]
      public function set css(sFile:Uri) : void
      {
         this._cssApplied = false;
         this.applyCSS(sFile);
      }
      
      public function set cssClass(c:String) : void
      {
         this._sCssClass = c == "" ? "p" : c;
         this.bindCss();
      }
      
      public function get cssClass() : String
      {
         return this._sCssClass;
      }
      
      public function get antialias() : String
      {
         return this._sAntialiasType;
      }
      
      public function set antialias(s:String) : void
      {
         this._sAntialiasType = s;
         this._tText.antiAliasType = this._sAntialiasType;
      }
      
      public function get thickness() : int
      {
         return this._tText.thickness;
      }
      
      public function set thickness(value:int) : void
      {
         this._tText.thickness = value;
      }
      
      public function get forceUppercase() : Boolean
      {
         return this._forceUppercase;
      }
      
      public function set forceUppercase(value:Boolean) : void
      {
         this._forceUppercase = value;
         var currentText:String = this.text;
         this.text = currentText;
      }
      
      public function set aStyleObj(value:Object) : void
      {
         this._aStyleObj = value as Array;
      }
      
      public function get aStyleObj() : Object
      {
         return this._aStyleObj;
      }
      
      override public function get width() : Number
      {
         return this._useExtendWidth && this._tText.numLines < 2 ? Number(this._tText.textWidth + 7) : Number(this._nWidth);
      }
      
      override public function set width(nValue:Number) : void
      {
         if(nValue == 0)
         {
            return;
         }
         this._nWidth = nValue;
         this._tText.width = this._nWidth;
         super.width = nValue;
         if(!this._bFixedHeight)
         {
            this.bindCss();
         }
         if(_finalized && this._autoResize)
         {
            this.resizeText();
         }
      }
      
      override public function get height() : Number
      {
         return this._nHeight;
      }
      
      override public function set height(nValue:Number) : void
      {
         var valMin:Number = NaN;
         if(!this._tText.multiline)
         {
            valMin = this._tText.textHeight;
            if(nValue < valMin)
            {
               nValue = valMin;
            }
         }
         this._nHeight = nValue;
         this._tText.height = this._nHeight;
         __height = this._nHeight;
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
      }
      
      public function get textWidth() : Number
      {
         return this._tText.textWidth;
      }
      
      public function get textHeight() : Number
      {
         return this._tText.textHeight;
      }
      
      public function get html() : Boolean
      {
         return this._bHtmlAllowed;
      }
      
      public function set html(bValue:Boolean) : void
      {
         this._bHtmlAllowed = bValue;
      }
      
      public function set wordWrap(bWordWrap:Boolean) : void
      {
         this._tText.wordWrap = bWordWrap;
      }
      
      public function get wordWrap() : Boolean
      {
         return this._tText.wordWrap;
      }
      
      public function set multiline(bMultiline:Boolean) : void
      {
         this._tText.multiline = bMultiline;
      }
      
      public function get multiline() : Boolean
      {
         return this._tText.multiline;
      }
      
      public function get border() : Boolean
      {
         return this._tText.border;
      }
      
      public function set border(bValue:Boolean) : void
      {
         this._tText.border = bValue;
      }
      
      public function get fixedWidth() : Boolean
      {
         return this._bFixedWidth;
      }
      
      public function set fixedWidth(bValue:Boolean) : void
      {
         this._bFixedWidth = bValue;
         if(this._bFixedWidth)
         {
            this._tText.autoSize = TextFieldAutoSize.NONE;
         }
         else
         {
            this._tText.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      public function get useExtendWidth() : Boolean
      {
         return this._useExtendWidth;
      }
      
      public function set useExtendWidth(v:Boolean) : void
      {
         this._useExtendWidth = v;
      }
      
      public function get hasTooltipExtension() : Boolean
      {
         return this._textFieldTooltipExtension && this._textFieldTooltipExtension.text != "";
      }
      
      public function get fixedHeight() : Boolean
      {
         return this._bFixedHeight;
      }
      
      public function set fixedHeight(bValue:Boolean) : void
      {
         this._bFixedHeight = bValue;
         if(this._tText.wordWrap && bValue)
         {
            _log.warn("Setting wordWrap to false as fixedHeight has been set to true!");
         }
         this._tText.wordWrap = !this._bFixedHeight;
      }
      
      public function get fixedHeightForMultiline() : Boolean
      {
         return this._bFixedHeightForMultiline;
      }
      
      public function set fixedHeightForMultiline(bValue:Boolean) : void
      {
         this._bFixedHeightForMultiline = bValue;
      }
      
      override public function set bgColor(nColor:*) : void
      {
         setColorVar(nColor);
         graphics.clear();
         if(bgColor == -1 || !this.width || !this.height)
         {
            return;
         }
         if(_borderColor != -1)
         {
            graphics.lineStyle(1,_borderColor);
         }
         graphics.beginFill(_bgColor,_bgAlpha);
         if(!_bgCornerRadius)
         {
            graphics.drawRect(x - _bgMargin,y,this.width + _bgMargin * 2,this.height + 2);
         }
         else
         {
            graphics.drawRoundRect(this._tText.x - _bgMargin,this._tText.y,this._tText.width + _bgMargin * 2,this._tText.height + 2,_bgCornerRadius,_bgCornerRadius);
         }
         graphics.endFill();
      }
      
      override public function set borderColor(nColor:int) : void
      {
         if(nColor == -1)
         {
            this._tText.border = false;
         }
         else
         {
            this._tText.border = true;
            this._tText.borderColor = nColor;
         }
      }
      
      public function set selectable(bValue:Boolean) : void
      {
         this._tText.selectable = bValue;
      }
      
      public function get length() : uint
      {
         return this._tText.length;
      }
      
      public function set scrollV(nVal:int) : void
      {
         this._tText.scrollV = nVal;
      }
      
      public function get scrollV() : int
      {
         this._tText.getCharBoundaries(0);
         return this._tText.scrollV;
      }
      
      public function get maxScrollV() : int
      {
         this._tText.getCharBoundaries(0);
         return this._tText.maxScrollV;
      }
      
      public function get textfield() : TextField
      {
         return this._tText;
      }
      
      public function get useEmbedFonts() : Boolean
      {
         return this._useEmbedFonts;
      }
      
      public function set useEmbedFonts(b:Boolean) : void
      {
         this._useEmbedFonts = b;
         this._tText.embedFonts = b;
      }
      
      override public function set disabled(bool:Boolean) : void
      {
         if(bool)
         {
            this._hasHandCursor = handCursor;
            handCursor = false;
            mouseEnabled = false;
            this._tText.mouseEnabled = false;
         }
         else
         {
            if(!handCursor)
            {
               handCursor = this._hasHandCursor;
            }
            mouseEnabled = true;
            this._tText.mouseEnabled = true;
         }
         this._bDisabled = bool;
      }
      
      public function get verticalAlign() : String
      {
         return this._sVerticalAlign;
      }
      
      public function set verticalAlign(s:String) : void
      {
         this._sVerticalAlign = s;
         this.updateAlign();
      }
      
      public function get textFormat() : TextFormat
      {
         return this._tfFormatter;
      }
      
      public function set textFormat(tf:TextFormat) : void
      {
         this._tfFormatter = tf;
         this._tText.setTextFormat(this._tfFormatter);
      }
      
      public function set restrict(restrictTo:String) : void
      {
         this._tText.restrict = restrictTo;
      }
      
      public function get restrict() : String
      {
         return this._tText.restrict;
      }
      
      public function set colorText(color:uint) : void
      {
         if(!this._tfFormatter)
         {
            _log.error("Error. Try to change the size before formatter was initialized.");
            return;
         }
         this._tfFormatter.color = color;
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
      }
      
      public function get useDefaultFont() : Boolean
      {
         return this._useDefaultFont;
      }
      
      public function set useDefaultFont(value:Boolean) : void
      {
         this._useDefaultFont = value;
      }
      
      public function get useFontResize() : Boolean
      {
         return this._useFontResize;
      }
      
      public function set useFontResize(value:Boolean) : void
      {
         this._useFontResize = value;
         if(this._useFontResize)
         {
            FontManager.getInstance().addEventListener(Event.CHANGE,this.onFontConfigChange,false,0,true);
         }
         else
         {
            FontManager.getInstance().removeEventListener(Event.CHANGE,this.onFontConfigChange,false);
         }
      }
      
      public function setCssColor(color:String, style:String = null) : void
      {
         this.changeCssClassColor(color,style);
      }
      
      public function setCssSize(size:uint, style:String = null) : void
      {
         this.changeCssClassSize(size,style);
      }
      
      public function setCssFont(font:String, style:String = null) : void
      {
         this.changeCssClassFont(font,style);
      }
      
      public function setStyleSheet(styles:StyleSheet) : void
      {
         this._useStyleSheet = true;
         this._currentStyleSheet = styles;
         this._tText.styleSheet = this._currentStyleSheet;
      }
      
      protected function onFontConfigChange(event:Event) : void
      {
         this.bindCss();
      }
      
      public function applyCSS(sFile:Uri) : void
      {
         if(sFile == null)
         {
            return;
         }
         if(sFile == this._sCssUrl && this._tfFormatter)
         {
            this.updateCss();
         }
         else
         {
            this._sCssUrl = sFile;
            CssManager.getInstance().askCss(sFile.uri,new Callback(this.bindCss));
         }
      }
      
      public function setBorderColor(nColor:int) : void
      {
         this._tText.borderColor = nColor;
      }
      
      public function allowTextMouse(bValue:Boolean) : void
      {
         this.mouseChildren = bValue;
         this._tText.mouseEnabled = bValue;
      }
      
      override public function remove() : void
      {
         super.remove();
         if(this._tText && this._tText.parent)
         {
            removeChild(this._tText);
         }
         if(this._uid)
         {
            TooltipManager.hide("TextExtension" + this._uid);
         }
         if(this._tText)
         {
            this._tText.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            this._tText.removeEventListener(MouseEvent.ROLL_OUT,this.hyperlinkRollOut);
            this._tText.removeEventListener(TextEvent.LINK,this.onTextClick);
            HyperlinkFactory.deactiveSmallHyperlink(this._tText);
            HyperlinkFactory.removeTextClickHandler(this._tText);
            HyperlinkFactory.removeRollOverHandler(this._tText);
         }
         if(this._textFieldTooltipExtension)
         {
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipExtensionOver);
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipExtensionOut);
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onTooltipExtensionOut);
         }
         FontManager.getInstance().removeEventListener(Event.CHANGE,this.onFontConfigChange,false);
      }
      
      override public function free() : void
      {
         super.free();
         this._sType = "default";
         this._nWidth = 100;
         this._nHeight = 20;
         this._bHtmlAllowed = true;
         this._sAntialiasType = AntiAliasType.NORMAL;
         this._bFixedWidth = true;
         this._bFixedHeight = true;
         this._bFixedHeightForMultiline = false;
         this._ssSheet = null;
         this._useEmbedFonts = true;
         this._nPaddingLeft = 0;
         this._nPaddingRight = 0;
         this._nTextIndent = 0;
         this._bDisabled = false;
         this._nTextHeight = 0;
         this._sVerticalAlign = "none";
         this._useExtendWidth = false;
         this._sCssClass = null;
         this._tText.type = TextFieldType.DYNAMIC;
         this._tText.selectable = false;
      }
      
      private function createTextField() : void
      {
         this._tText = new TextField();
         this._tText.addEventListener(TextEvent.LINK,this.onTextClick);
         addChild(this._tText);
      }
      
      private function changeCssClassColor(color:String, style:String = null) : void
      {
         var i:* = undefined;
         if(style)
         {
            if(this.aStyleObj[style] == null)
            {
               this.aStyleObj[style] = new Object();
            }
            this.aStyleObj[style].color = color;
            if(this._ssSheet)
            {
               this._tfFormatter = this._ssSheet.transform(this.aStyleObj[style]);
               this._tText.setTextFormat(this._tfFormatter);
               this._tText.defaultTextFormat = this._tfFormatter;
            }
         }
         else
         {
            for each(i in this.aStyleObj)
            {
               i.color = color;
            }
         }
      }
      
      private function changeCssClassSize(size:uint, style:String = null) : void
      {
         var currentStyleSheet:StyleSheet = null;
         var i:* = undefined;
         if(style)
         {
            if(this.aStyleObj[style] == null)
            {
               this.aStyleObj[style] = new Object();
            }
            this.aStyleObj[style].fontSize = size;
            if(this._ssSheet)
            {
               currentStyleSheet = this._tText.styleSheet;
               this._tText.styleSheet = null;
               this._tfFormatter = this._ssSheet.transform(this.aStyleObj[style]);
               this._tText.setTextFormat(this._tfFormatter);
               this._tText.defaultTextFormat = this._tfFormatter;
               this._tText.styleSheet = currentStyleSheet;
            }
         }
         else
         {
            for each(i in this.aStyleObj)
            {
               i.fontSize = size;
            }
         }
      }
      
      private function changeCssClassFont(font:String, style:String = null) : void
      {
         var i:* = undefined;
         if(style)
         {
            if(this.aStyleObj[style] == null)
            {
               this.aStyleObj[style] = new Object();
            }
            this.aStyleObj[style].fontFamily = font;
         }
         else
         {
            for each(i in this.aStyleObj)
            {
               i.fontFamily = font;
            }
         }
      }
      
      public function appendText(sTxt:String, style:String = null) : void
      {
         var textFormat:TextFormat = null;
         if(this._forceUppercase)
         {
            sTxt = sTxt.toLocaleUpperCase();
         }
         if(style && this.aStyleObj[style] && this._ssSheet)
         {
            if(this._tText.filters.length)
            {
               this._tText.filters = new Array();
            }
            textFormat = this._ssSheet.transform(this.aStyleObj[style]);
            if(!textFormat.bold)
            {
               textFormat.bold = false;
            }
            this._tText.defaultTextFormat = textFormat;
         }
         if(this._hyperlinkEnabled)
         {
            sTxt = HyperlinkFactory.decode(sTxt);
         }
         this._tText.htmlText += sTxt;
         if(this._hyperlinkEnabled)
         {
            this.parseLinks();
         }
      }
      
      public function activeSmallHyperlink() : void
      {
         HyperlinkFactory.activeSmallHyperlink(this._tText);
      }
      
      private function bindCss() : void
      {
         var styleToDisplay:String = null;
         var s:String = null;
         var effectName:String = null;
         var filtersTmp:Array = null;
         var filterRef:Dictionary = null;
         var cssKey:String = null;
         var oldCssUrl:Uri = null;
         var filter:BitmapFilter = null;
         var valueString:String = null;
         var value:* = undefined;
         var oldSize:Number = NaN;
         var font:String = null;
         if(!this._sCssUrl)
         {
            if(this._needToFinalize)
            {
               this.finalize();
            }
            return;
         }
         var oldCss:ExtendedStyleSheet = this._ssSheet;
         this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
         if(!this._ssSheet)
         {
            if(oldCss == null)
            {
               if(this._needToFinalize)
               {
                  this.finalize();
               }
               return;
            }
            this._ssSheet = oldCss;
            oldCssUrl = this._sCssUrl;
            this._sCssUrl = null;
            this.applyCSS(oldCssUrl);
         }
         var currentStyleSheet:StyleSheet = this._tText.styleSheet;
         this._tText.styleSheet = null;
         this.aStyleObj = new Array();
         for each(s in this._ssSheet.styleNames)
         {
            if(!styleToDisplay || s == this._sCssClass || this._sCssClass != styleToDisplay && s == "p")
            {
               styleToDisplay = s;
            }
            if(this._ssSheet != oldCss || !this.aStyleObj[s])
            {
               this.aStyleObj[s] = this._ssSheet.getStyle(s);
            }
         }
         filtersTmp = [];
         filterRef = new Dictionary();
         for(cssKey in this.aStyleObj[styleToDisplay])
         {
            effectName = cssKey.indexOf("shadow") != -1 ? "shadow" : null;
            effectName = !effectName && cssKey.indexOf("glow") != -1 ? "glow" : effectName;
            if(effectName)
            {
               if(!filterRef[effectName])
               {
                  if(effectName == "shadow")
                  {
                     filter = new DropShadowFilter();
                  }
                  else if(effectName == "glow")
                  {
                     filter = new GlowFilter();
                  }
                  this.buildFilterIndex(filter);
                  filtersTmp.push(filter);
                  filterRef[effectName] = filter;
               }
               else
               {
                  filter = filterRef[effectName];
               }
               try
               {
                  valueString = this.aStyleObj[styleToDisplay][cssKey];
                  if(valueString.charAt(0) == "#")
                  {
                     value = parseInt(valueString.substr(1),16);
                  }
                  else
                  {
                     value = parseFloat(valueString);
                  }
                  filter[_filterIndex[getQualifiedClassName(filter)][cssKey.substr(effectName.length).toLowerCase()]] = value;
               }
               catch(e:Error)
               {
                  _log.error(e);
               }
            }
         }
         filters = filtersTmp;
         if(this.aStyleObj[styleToDisplay]["useEmbedFonts"])
         {
            this._useEmbedFonts = this.aStyleObj[styleToDisplay]["useEmbedFonts"] == "true";
         }
         if(this.aStyleObj[styleToDisplay]["paddingLeft"])
         {
            this._nPaddingLeft = parseInt(this.aStyleObj[styleToDisplay]["paddingLeft"]);
         }
         if(this.aStyleObj[styleToDisplay]["paddingRight"])
         {
            this._nPaddingRight = parseInt(this.aStyleObj[styleToDisplay]["paddingRight"]);
         }
         if(this.aStyleObj[styleToDisplay]["verticalHeight"])
         {
            this._nTextHeight = parseInt(this.aStyleObj[styleToDisplay]["verticalHeight"]);
         }
         if(this.aStyleObj[styleToDisplay]["verticalAlign"])
         {
            this.verticalAlign = this.aStyleObj[styleToDisplay]["verticalAlign"];
         }
         if(this.aStyleObj[styleToDisplay]["thickness"])
         {
            this._tText.thickness = this.aStyleObj[styleToDisplay]["thickness"];
         }
         this._tText.gridFitType = GridFitType.PIXEL;
         this._tText.htmlText = !!this._sText ? this._sText : this.htmlText;
         this._tfFormatter = this._ssSheet.transform(this.aStyleObj[styleToDisplay]);
         if(this.aStyleObj[styleToDisplay]["leading"])
         {
            this._tfFormatter.leading = this.aStyleObj[styleToDisplay]["leading"];
         }
         if(this.aStyleObj[styleToDisplay]["letterSpacing"])
         {
            this._tfFormatter.letterSpacing = parseFloat(this.aStyleObj[styleToDisplay]["letterSpacing"]);
         }
         if(this.aStyleObj[styleToDisplay]["kerning"])
         {
            this._tfFormatter.kerning = this.aStyleObj[styleToDisplay]["kerning"] == "true";
         }
         if(!this._neverIndent)
         {
            this._tfFormatter.indent = this._nTextIndent;
         }
         this._tfFormatter.leftMargin = this._nPaddingLeft;
         this._tfFormatter.rightMargin = this._nPaddingRight;
         var fontInfo:UserFont = FontManager.getInstance().getFontInfo(this._tfFormatter.font,this._useDefaultFont);
         if(this._useEmbedFonts)
         {
            if(fontInfo)
            {
               oldSize = this._tfFormatter.size != null ? Number(Number(this._tfFormatter.size)) : Number(12);
               if(fontInfo.maxSize != UserFont.FONT_SIZE_NO_MAX && this._tfFormatter.size < fontInfo.maxSize)
               {
                  this._tfFormatter.size = Math.min(Math.round(int(this._tfFormatter.size) * fontInfo.sizeMultiplicator),fontInfo.maxSize != UserFont.FONT_SIZE_NO_MAX ? Number(fontInfo.maxSize) : Number(1000));
                  this._verticalOffset = ((this._tfFormatter.size != null ? Number(this._tfFormatter.size) : 12) - oldSize) * fontInfo.verticalOffset;
               }
               this._tfFormatter.font = fontInfo.className;
               this._tText.defaultTextFormat.font = fontInfo.className;
               this._tText.embedFonts = true;
               this._tText.antiAliasType = AntiAliasType.ADVANCED;
               this._tText.sharpness = fontInfo.sharpness;
               if(this._tfFormatter.letterSpacing < fontInfo.letterSpacing)
               {
                  this._tfFormatter.letterSpacing = fontInfo.letterSpacing;
               }
               if(this._tfFormatter.letterSpacing == null)
               {
                  this._tfFormatter.letterSpacing = 0.0001;
               }
            }
            else if(this._tfFormatter)
            {
               _log.warn("System font [" + this._tfFormatter.font + "] used (in " + (!!getUi() ? getUi().name : "unknow") + ", from " + this._sCssUrl.uri + ")");
            }
            else
            {
               _log.fatal("Erreur de formattage.");
            }
         }
         else
         {
            font = !!fontInfo ? fontInfo.realName : "";
            this._tfFormatter.font = font != "" ? font : this._tfFormatter.font;
            this._tText.embedFonts = false;
         }
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
         if(this._hyperlinkEnabled)
         {
            HyperlinkFactory.createTextClickHandler(this._tText,true);
            HyperlinkFactory.createRollOverHandler(this._tText);
            this.parseLinks();
         }
         this._tText.styleSheet = currentStyleSheet;
         if(this._nTextHeight)
         {
            this._tText.height = this._nTextHeight;
            this._tText.y += this._nHeight / 2 - this._tText.height / 2;
         }
         else if(!this._bFixedHeight)
         {
            this._tText.height = this._tText.textHeight + 5;
            this._nHeight = this._tText.height;
         }
         else
         {
            this._tText.height = this._nHeight;
         }
         if(this._useExtendWidth)
         {
            this._tText.width = this._tText.textWidth + 7;
            this._nWidth = this._tText.width;
         }
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
         if(this._useExtendWidth && getUi())
         {
            getUi().render();
         }
         this._binded = true;
         this.updateTooltipExtensionStyle();
         if(this._needToFinalize)
         {
            this.finalize();
         }
      }
      
      public function updateCss() : void
      {
         if(!this._tfFormatter)
         {
            return;
         }
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
         this.updateTooltipExtensionStyle();
         if(!this._bFixedHeight)
         {
            this._tText.height = this._tText.textHeight + 5;
            this._nHeight = this._tText.height;
         }
         else
         {
            this._tText.height = this._nHeight;
         }
         if(this._useExtendWidth)
         {
            this._tText.width = this._tText.textWidth + 7;
            this._nWidth = this._tText.width;
         }
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
         if(this._useExtendWidth && getUi())
         {
            getUi().render();
         }
      }
      
      public function updateTextFormatProperty(pPropertyName:String, pPropertyValue:*) : void
      {
         this._tfFormatter[pPropertyName] = pPropertyValue;
         this.updateCss();
      }
      
      public function fullSize(width:int) : void
      {
         this.removeTooltipExtension();
         this._nWidth = width;
         this._tText.width = width;
         var tHeight:uint = this._tText.textHeight + 8;
         this._tText.height = tHeight;
         this._nHeight = tHeight;
      }
      
      public function fullWidthAndHeight(maxWidth:uint = 0, offsetWidth:uint = 5) : void
      {
         this._nWidth = int(this._tText.textWidth + offsetWidth);
         this._tText.width = this._nWidth;
         if(maxWidth > 0)
         {
            this._nWidth = maxWidth;
            this._tText.width = maxWidth;
            if(this._tText.textWidth < maxWidth)
            {
               this._tText.width = this._tText.textWidth + 10;
            }
         }
         this._nHeight = this._tText.textHeight + 8;
         this._tText.height = this._nHeight;
      }
      
      public function fullWidth(maxWidth:uint = 0, offsetWidth:uint = 5) : void
      {
         this._nWidth = int(this._tText.textWidth + offsetWidth);
         this._tText.width = this._nWidth;
         if(maxWidth > 0)
         {
            this._nWidth = maxWidth;
            this._tText.width = maxWidth;
            if(this._tText.textWidth < maxWidth)
            {
               this._tText.width = this._tText.textWidth + 10;
            }
         }
      }
      
      public function resizeText() : void
      {
         var needTooltipExtension:Boolean = false;
         var currentTextFieldWidth:int = 0;
         this.removeTooltipExtension();
         if((this._bFixedHeight && !this._tText.multiline || this._bFixedHeightForMultiline) && this._tText.autoSize == "none" && this._tfFormatter)
         {
            needTooltipExtension = false;
            currentTextFieldWidth = this._tText.width;
            if(this._tText.textWidth > currentTextFieldWidth + 1 || this._tText.textHeight > this._tText.height || this._bFixedHeightForMultiline && this._tText.textHeight > this.height)
            {
               if(this._useTooltipExtension)
               {
                  needTooltipExtension = true;
               }
               else
               {
                  _log.warn("Attention : Ce texte est beaucoup trop long pour entrer dans ce TextField (Texte : " + this._tText.text + ")");
               }
            }
            if(needTooltipExtension && (!this.multiline && this._bFixedHeight || this._bFixedHeightForMultiline))
            {
               this.addTooltipExtension();
            }
            else if(this._lastWidth != this._tText.width)
            {
               this._lastWidth = this._tText.width;
            }
         }
      }
      
      public function truncateText(pMaxHeight:Number, pCleanTruncature:Boolean = true) : void
      {
         var numLines:int = 0;
         var nbVisibleLines:int = 0;
         var nbVisibleChars:int = 0;
         var i:int = 0;
         var h:Number = NaN;
         var lineHeight:Number = NaN;
         var lineBreakIndex:int = 0;
         var periodIndex:int = 0;
         this._nHeight = __height = this._tText.height = pMaxHeight;
         if(this._tText.wordWrap && this._tText.numLines > 0)
         {
            numLines = this._tText.numLines;
            h = 4;
            lineHeight = this._tText.getLineMetrics(0).height;
            for(i = 0; i < numLines; i++)
            {
               h += lineHeight;
               if(h >= this._tText.height)
               {
                  break;
               }
               nbVisibleLines++;
               nbVisibleChars += this._tText.getLineLength(i);
            }
            this._tText.text = this._tText.text.substr(0,nbVisibleChars);
            if(pCleanTruncature)
            {
               lineBreakIndex = this._tText.text.lastIndexOf(String.fromCharCode(10));
               periodIndex = this._tText.text.lastIndexOf(".");
               if(lineBreakIndex != -1 || periodIndex != -1)
               {
                  this._tText.text = this._tText.text.substring(0,Math.max(lineBreakIndex,periodIndex));
                  this._tText.appendText(" (" + String.fromCharCode(8230) + ")");
                  this._nHeight = __height = this._tText.height = this._tText.height - (nbVisibleLines - this._tText.numLines) * lineHeight;
               }
               else
               {
                  this.addEllipsis();
               }
            }
            else
            {
               this.addEllipsis();
            }
         }
      }
      
      public function removeTooltipExtension() : void
      {
         if(this._textFieldTooltipExtension)
         {
            removeChild(this._textFieldTooltipExtension);
            this._tText.width = __width + int(this._textFieldTooltipExtension.width + 2);
            __width = this._tText.width;
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipExtensionOver);
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipExtensionOut);
            this._textFieldTooltipExtension = null;
         }
      }
      
      private function buildFilterIndex(target:BitmapFilter) : void
      {
         var field:String = null;
         var className:String = getQualifiedClassName(target);
         if(_filterIndex[className])
         {
            return;
         }
         var index:Dictionary = new Dictionary();
         for each(field in DescribeTypeCache.getVariables(target))
         {
            index[field.toLowerCase()] = field;
         }
         _filterIndex[className] = index;
      }
      
      private function addEllipsis() : void
      {
         var i:int = 0;
         var nbSpaces:int = 0;
         if(this._tText.text.length - 3 > 0)
         {
            this._tText.text = this._tText.text.substr(0,this._tText.text.length - 3);
            i = this._tText.text.length - 1;
            while(i >= 0 && this._tText.text.charAt(i) == " ")
            {
               nbSpaces++;
               i--;
            }
            if(nbSpaces > 0)
            {
               this._tText.text = this._tText.text.substr(0,this._tText.text.length - nbSpaces);
            }
            this._tText.appendText(String.fromCharCode(8230));
         }
      }
      
      public function addTooltipExtension() : void
      {
         this._textFieldTooltipExtension = new TextField();
         this._textFieldTooltipExtension.selectable = false;
         this._textFieldTooltipExtension.height = 1;
         this._textFieldTooltipExtension.width = 1;
         this._textFieldTooltipExtension.autoSize = TextFieldAutoSize.LEFT;
         this.updateTooltipExtensionStyle();
         this._textFieldTooltipExtension.text = "...";
         this._textFieldTooltipExtension.name = "extension_" + name;
         addChild(this._textFieldTooltipExtension);
         var w:int = this._textFieldTooltipExtension.width + 2;
         this._tText.width -= w;
         __width = this._tText.width;
         this._textFieldTooltipExtension.x = this._tText.width;
         this._textFieldTooltipExtension.y = this._tText.y + this._tText.height - this._textFieldTooltipExtension.textHeight - 10;
         if(!this._tText.wordWrap)
         {
            this._textFieldTooltipExtension.y = this._tText.y;
            this._tText.height = this._tText.textHeight + 3;
            __height = this._tText.height;
         }
         else if(this._bFixedHeightForMultiline)
         {
            this._tText.height = this.height + 3;
            __height = this._tText.height;
            switch(this._sVerticalAlign.toUpperCase())
            {
               case VALIGN_CENTER:
                  this._tText.y = (this.height - this._tText.height) / 2;
                  break;
               case VALIGN_BOTTOM:
                  this._tText.y = this.height - this._tText.height;
                  break;
               default:
                  this._tText.y = 0;
            }
            this._textFieldTooltipExtension.y = this._tText.y + this.height - this._textFieldTooltipExtension.textHeight;
         }
         var target:DisplayObjectContainer = this;
         for(var i:int = 0; i < 4; i++)
         {
            if(target is ButtonContainer)
            {
               (target as ButtonContainer).mouseChildren = true;
               break;
            }
            target = target.parent;
            if(!target)
            {
               break;
            }
         }
         this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OVER,this.onTooltipExtensionOver,false,0,true);
         this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OUT,this.onTooltipExtensionOut,false,0,true);
         this._textFieldTooltipExtension.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTooltipExtensionOut,false,0,true);
      }
      
      private function updateTooltipExtensionStyle() : void
      {
         if(!this._textFieldTooltipExtension)
         {
            return;
         }
         this._textFieldTooltipExtension.embedFonts = this._tText.embedFonts;
         this._textFieldTooltipExtension.defaultTextFormat = this._tfFormatter;
         this._textFieldTooltipExtension.setTextFormat(this._tfFormatter);
         this._textTooltipExtensionColor = uint(this._tfFormatter.color);
         this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
      }
      
      private function onTextClick(e:TextEvent) : void
      {
         e.stopPropagation();
         Berilia.getInstance().handler.process(new TextClickMessage(this,e.text));
      }
      
      protected function updateAlign() : void
      {
         if(!this._tText.textHeight)
         {
            return;
         }
         var h:int = 0;
         for(var i:int = 0; i < this._tText.numLines; i++)
         {
            h += TextLineMetrics(this._tText.getLineMetrics(i)).height + TextLineMetrics(this._tText.getLineMetrics(i)).leading + TextLineMetrics(this._tText.getLineMetrics(i)).descent;
         }
         this._tText.y = 0;
         switch(this._sVerticalAlign.toUpperCase())
         {
            case VALIGN_CENTER:
               this._tText.height = h;
               this._tText.y = (this.height - this._tText.height) / 2;
               break;
            case VALIGN_BOTTOM:
               this._tText.height = this.height;
               this._tText.y = this.height - h;
               break;
            case VALIGN_TOP:
               this._tText.height = h;
               this._tText.y = 0;
               break;
            case VALIGN_FIXEDHEIGHT:
               if(!this._tText.wordWrap || this._tText.multiline)
               {
                  this._tText.height = this._tText.textHeight + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
               break;
            case VALIGN_NONE:
               if(!this._tText.wordWrap || this._tText.multiline)
               {
                  this._tText.height = this._tText.textHeight + 4 + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
         }
         if(this._tfFormatter && FontManager.getInstance().getFontInfo(this._tfFormatter.font))
         {
            this._tText.y += this._verticalOffset;
         }
      }
      
      private function onTooltipExtensionOver(e:MouseEvent) : void
      {
         var docMain:Sprite = Berilia.getInstance().docMain;
         if(this._uid == null)
         {
            this._uid = UIDUtil.createUID();
         }
         TooltipManager.show(new TextTooltipInfo(this._tText.text),this,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"TextExtension" + this._uid,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,20,true,null,TooltipManager.defaultTooltipUiScript,null,"TextInfo" + this._uid);
         this._textFieldTooltipExtension.textColor = XmlConfig.getInstance().getEntry("colors.hyperlink.link");
      }
      
      private function onTooltipExtensionOut(e:MouseEvent = null) : void
      {
         TooltipManager.hide("TextExtension" + this._uid);
         this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
      }
      
      override public function finalize() : void
      {
         var ui:UiRootContainer = null;
         if(this._binded)
         {
            if(this._autoResize)
            {
               this.resizeText();
            }
            if(this._hyperlinkEnabled)
            {
               HyperlinkFactory.createTextClickHandler(this._tText);
               HyperlinkFactory.createRollOverHandler(this._tText);
               this.parseLinks();
            }
            _finalized = true;
            super.finalize();
            ui = getUi();
            if(ui)
            {
               ui.iAmFinalized(this);
            }
         }
         else
         {
            this._needToFinalize = true;
         }
      }
      
      public function get bmpText() : BitmapData
      {
         var m:Matrix = new Matrix();
         var bmpdt:BitmapData = new BitmapData(this.width,this.height,true,16711680);
         bmpdt.draw(this._tText,m,null,null,null,true);
         return bmpdt;
      }
      
      private function parseLinks() : void
      {
         var textrun:Object = null;
         var textrunText:String = null;
         var openSquareBrackets:Array = null;
         var closeSquareBrackets:Array = null;
         var nbBrackets:int = 0;
         var i:int = 0;
         var j:int = 0;
         var textruns:Array = this._tText.getTextRuns();
         var nbRuns:int = textruns.length;
         this._lastHyperLinkId = -1;
         this._hyperLinks.length = 0;
         for(i = 0; i < nbRuns; i++)
         {
            textrun = textruns[i];
            if(textrun.textFormat && textrun.textFormat.url.length > 0)
            {
               textrunText = this._tText.text.substring(textrun.beginIndex,textrun.endIndex);
               openSquareBrackets = StringUtils.getAllIndexOf("[",textrunText);
               closeSquareBrackets = StringUtils.getAllIndexOf("]",textrunText);
               if(openSquareBrackets.length > 1 && openSquareBrackets.length == closeSquareBrackets.length)
               {
                  nbBrackets = openSquareBrackets.length;
                  for(j = 0; j < nbBrackets; j++)
                  {
                     this._hyperLinks.push({
                        "beginIndex":textrun.beginIndex + openSquareBrackets[j],
                        "endIndex":textrun.beginIndex + closeSquareBrackets[j],
                        "textFormat":textrun.textFormat
                     });
                  }
               }
               else
               {
                  this._hyperLinks.push(textrun);
               }
            }
         }
      }
      
      private function getHyperLinkId(pCharIndex:int) : int
      {
         var i:int = 0;
         var nbLinks:int = this._hyperLinks.length;
         for(i = 0; i < nbLinks; i++)
         {
            if(pCharIndex >= this._hyperLinks[i].beginIndex && pCharIndex <= this._hyperLinks[i].endIndex)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function onMouseMove(pEvent:MouseEvent) : void
      {
         var charIndex:int = 0;
         var textHeight:Number = NaN;
         var nbVisibleLines:int = 0;
         var lineHeight:Number = NaN;
         var i:int = 0;
         var numLines:int = 0;
         var bottomMargin:Number = NaN;
         var labelGlobalPos:Point = null;
         var mouseOverText:Boolean = false;
         var hyperLinkId:int = 0;
         var url:String = null;
         var params:Array = null;
         var type:String = null;
         var posY:int = 0;
         var data:String = null;
         if(this._tText.length > 0)
         {
            charIndex = this._tText.getCharIndexAtPoint(pEvent.localX,pEvent.localY);
            textHeight = 4;
            lineHeight = this._tText.getLineMetrics(0).height;
            numLines = this._tText.numLines;
            for(i = 0; i < numLines; i++)
            {
               textHeight += lineHeight;
               if(textHeight > this._tText.height)
               {
                  break;
               }
               nbVisibleLines++;
            }
            bottomMargin = this._tText.height - nbVisibleLines * lineHeight;
            labelGlobalPos = localToGlobal(new Point(x,y));
            mouseOverText = pEvent.stageY > labelGlobalPos.y + this._tText.height - bottomMargin ? false : true;
            if(mouseOverText && charIndex != -1)
            {
               hyperLinkId = this.getHyperLinkId(charIndex);
               url = hyperLinkId >= 0 ? this._hyperLinks[hyperLinkId].textFormat.url : null;
               if(url)
               {
                  if(this._mouseOverHyperLink && (this._lastHyperLinkId >= 0 && hyperLinkId != this._lastHyperLinkId))
                  {
                     this._mouseOverHyperLink = true;
                     this.hyperlinkRollOut();
                  }
                  if(!this._mouseOverHyperLink)
                  {
                     params = url.replace("event:","").split(",");
                     type = params.shift();
                     posY = labelGlobalPos.y + this._tText.getCharBoundaries(charIndex).y;
                     data = type + "," + Math.round(pEvent.stageX) + "," + Math.round(posY) + "," + params.join(",");
                     this._tText.dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OVER,data));
                     this._mouseOverHyperLink = true;
                     this._lastHyperLinkId = hyperLinkId;
                  }
               }
               else
               {
                  this.hyperlinkRollOut();
               }
            }
            else
            {
               this.hyperlinkRollOut();
            }
         }
      }
      
      private function hyperlinkRollOut(pEvent:MouseEvent = null) : void
      {
         if(pEvent || this._mouseOverHyperLink)
         {
            TooltipManager.hideAll();
            this._tText.dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OUT));
         }
         this._mouseOverHyperLink = false;
      }
   }
}
