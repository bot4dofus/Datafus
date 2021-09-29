package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TextFieldScrollBar extends GraphicContainer implements UIComponent
   {
      
      public static const WIDTH:int = 10;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TextFieldScrollBar));
       
      
      private const MAGIC_STRING:String = "<span class=\'p1\'> </span>";
      
      public var _label:Label;
      
      private var _lines:Vector.<String>;
      
      private var _numLines:int = 20;
      
      private var _power:int = 4;
      
      private var _scroll:int;
      
      private var _interScroll:int;
      
      private var _maxScroll:int;
      
      private var _maxInterScroll:int;
      
      private var _scrollAtEnd:Boolean = true;
      
      private var _leftSide:Boolean;
      
      private var _testLabel:Label;
      
      private var _testLabelWordWrap:Label;
      
      private var _isFinalized:Boolean;
      
      private var _backgroundColor:uint;
      
      private var _color:uint;
      
      private var _background:Shape;
      
      private var _scrollBar:Sprite;
      
      private var textFieldNumLines:uint;
      
      private var linesLenghts:Dictionary;
      
      private var _nbLines:Dictionary;
      
      private var offsetY:int;
      
      public function TextFieldScrollBar()
      {
         this.linesLenghts = new Dictionary();
         this._nbLines = new Dictionary();
         super();
         this._testLabel = new Label();
         this._testLabelWordWrap = new Label();
      }
      
      public function initProperties(label:Label, lines:Vector.<String>, power:int, backgroundColor:uint, color:uint, leftSide:Boolean = false) : void
      {
         this._isFinalized = false;
         this._label = label;
         this._lines = lines;
         this._power = power;
         this._backgroundColor = backgroundColor;
         this._color = color;
         this._leftSide = leftSide;
         this._label.mouseEnabled = true;
         this._label.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this._testLabel.hyperlinkEnabled = this._label.hyperlinkEnabled;
         this._testLabel.useEmbedFonts = this._label.useEmbedFonts;
         this._testLabel.setStyleSheet(this._label.textfield.styleSheet);
         this._testLabel.multiline = false;
         this._testLabel.wordWrap = false;
         this._testLabel.fixedWidth = false;
         this._testLabelWordWrap.hyperlinkEnabled = this._label.hyperlinkEnabled;
         this._testLabelWordWrap.useEmbedFonts = this._label.useEmbedFonts;
         this._testLabelWordWrap.setStyleSheet(this._label.textfield.styleSheet);
         this._testLabelWordWrap.multiline = true;
         this._testLabelWordWrap.wordWrap = true;
         this._testLabelWordWrap.width = this._label.width;
         this._testLabelWordWrap.visible = false;
         addChild(this._testLabelWordWrap);
         this.createUI();
      }
      
      public function set lines(newLines:Vector.<String>) : void
      {
         this._lines = newLines;
         this.reCalculateTextsWidth(true);
      }
      
      override public function set width(nW:Number) : void
      {
         if(this._label.width != nW - WIDTH)
         {
            this._label.width = nW - WIDTH;
            this._testLabelWordWrap.width = this._label.width;
            this.reCalculateTextsWidth();
         }
      }
      
      override public function set height(nH:Number) : void
      {
         this._label.height = nH;
         this._label.textfield.height = this._label.height;
      }
      
      public function reset(lines:Vector.<String>) : void
      {
         this._label.text = "";
         this._lines = lines;
      }
      
      public function isAtEnd() : Boolean
      {
         return this._scrollAtEnd;
      }
      
      public function resize(nW:Number = 0, nH:Number = 0) : void
      {
         if(nW)
         {
            this.width = nW;
         }
         if(nH)
         {
            this.height = nH;
         }
         if(nW || nH)
         {
            this._numLines = Math.floor((this._label.height - 4) / (this._label.textHeight / this._label.textfield.numLines));
         }
         this._background.graphics.clear();
         this._background.graphics.beginFill(this._backgroundColor);
         this._background.graphics.drawRoundRect(0,0,WIDTH,this._label.height,5);
         this._background.graphics.endFill();
         x = !!this._leftSide ? Number(this._label.x - WIDTH - 5) : Number(this._label.x + this._label.width);
         y = this._label.y;
         this.drawScrollBar();
      }
      
      public function updateScrolling() : void
      {
         if(this._scrollAtEnd)
         {
            this.scrollAtEnd();
         }
         else
         {
            this.scrollText(0);
            this.drawScrollBar();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function scrollText(scrollDiff:int = 0) : void
      {
         var newText:String = null;
         this.updateMaxScroll();
         this._scrollAtEnd = false;
         this._interScroll += scrollDiff;
         while(this._interScroll >= this._nbLines[this._lines[this._scroll]] || this._scroll == this._maxScroll && this._interScroll > this._maxInterScroll)
         {
            this._interScroll -= this._nbLines[this._lines[this._scroll]];
            this._scroll += 1;
            if(this._scroll > this._maxScroll || this._scroll == this._maxScroll && this._interScroll >= this._maxInterScroll)
            {
               this._scroll = this._maxScroll;
               this._interScroll = this._maxInterScroll;
               this._scrollAtEnd = true;
               break;
            }
         }
         while(this._interScroll < 0)
         {
            this._scroll = this._scroll - 1;
            if(this._scroll < 0)
            {
               this._scroll = 0;
               this._interScroll = 0;
               break;
            }
            this._interScroll += this._nbLines[this._lines[this._scroll]];
         }
         var nbLines:uint = this.linesFromScroll();
         newText = this._lines.slice(this._scroll,this._scroll + nbLines).join("\n");
         this._label.htmlText = (!!this._label.wordWrap ? this.checkSpan(newText,this._scroll) : newText) + this.MAGIC_STRING;
         this._label.textfield.scrollV = this._interScroll + 1;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function scrollAtEnd() : void
      {
         var oldMaxScroll:int = 0;
         var oldMaxInterScroll:int = 0;
         var nbCharDiffSelectionBegin:int = 0;
         var newSelectionBegin:int = 0;
         var newSelectionEnd:int = 0;
         var addedLines:int = 0;
         var i:int = 0;
         var selectionBegin:int = this._label.textfield.selectionBeginIndex;
         var selectionEnd:int = this._label.textfield.selectionEndIndex;
         if(selectionBegin != selectionEnd)
         {
            oldMaxScroll = this._maxScroll;
            oldMaxInterScroll = this._maxInterScroll;
         }
         this.updateMaxScroll();
         if(selectionBegin != selectionEnd)
         {
            nbCharDiffSelectionBegin = 0;
            addedLines = 0;
            for(i = oldMaxScroll; i < this._maxScroll; i++)
            {
               addedLines += this._nbLines[this._lines[i]];
            }
            for(i = 0; i < Math.max(addedLines + this._maxInterScroll - oldMaxInterScroll + this._interScroll,this._label.textfield.numLines); i++)
            {
               nbCharDiffSelectionBegin += this._label.textfield.getLineLength(i);
            }
            newSelectionBegin = selectionBegin - nbCharDiffSelectionBegin;
            newSelectionEnd = selectionEnd - nbCharDiffSelectionBegin;
         }
         var newText:String = this._lines.slice(this._maxScroll).join("\n");
         this._label.htmlText = (!!this._label.wordWrap ? this.checkSpan(newText,this._maxScroll) : newText) + this.MAGIC_STRING;
         this._scroll = this._maxScroll;
         this._interScroll = this._maxInterScroll;
         this._scrollAtEnd = true;
         this._label.textfield.scrollV = this._maxInterScroll + 1;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
         if(selectionBegin != selectionEnd)
         {
            this._label.textfield.setSelection(this._label.textfield.getLineOffset(this._interScroll) + Math.max(0,newSelectionBegin),this._label.textfield.getLineOffset(this._interScroll) + Math.max(0,newSelectionEnd));
         }
      }
      
      public function removeLastText() : void
      {
         var newSelectionBegin:int = 0;
         var newSelectionEnd:int = 0;
         var nbCharDiffSelectionBegin:int = 0;
         var i:int = 0;
         var removedText:String = this._lines.shift();
         this.textFieldNumLines -= this._nbLines[removedText];
         var selectionBegin:int = this._label.textfield.selectionBeginIndex;
         var selectionEnd:int = this._label.textfield.selectionEndIndex;
         if(this._scroll == 0 && selectionBegin != selectionEnd)
         {
            nbCharDiffSelectionBegin = 0;
            for(i = 0; i < this._nbLines[removedText]; i++)
            {
               nbCharDiffSelectionBegin += this._label.textfield.getLineLength(i);
            }
            newSelectionBegin = selectionBegin - nbCharDiffSelectionBegin;
            newSelectionEnd = selectionEnd - nbCharDiffSelectionBegin;
         }
         if(!this._scrollAtEnd)
         {
            this.scrollText(-1 * this._nbLines[removedText]);
         }
         if(this._scroll == 0 && selectionBegin != selectionEnd)
         {
            this._label.textfield.setSelection(Math.max(0,newSelectionBegin),Math.max(0,newSelectionEnd));
         }
         if(this._lines.indexOf(removedText) == -1)
         {
            delete this.linesLenghts[removedText];
            delete this._nbLines[removedText];
         }
      }
      
      public function addTextLength(text:String) : void
      {
         if(!this.linesLenghts[text])
         {
            this._testLabel.htmlText = text;
            this.linesLenghts[text] = this._testLabel.textfield.textWidth;
            this._nbLines[text] = this.textNbLines(text);
         }
         this.textFieldNumLines += this._nbLines[text];
      }
      
      public function clear() : void
      {
         this._lines.length = 0;
         this.textFieldNumLines = 0;
         this.linesLenghts = new Dictionary();
         this._nbLines = new Dictionary();
      }
      
      public function setFontSize(size:uint) : void
      {
         var style:Object = null;
         var styleName:String = null;
         for each(styleName in this._label.textfield.styleSheet.styleNames)
         {
            style = this._label.textfield.styleSheet.getStyle(styleName);
            style.fontSize = size.toString();
            this._label.textfield.styleSheet.setStyle(styleName,style);
            this._testLabel.textfield.styleSheet.setStyle(styleName,style);
            this._testLabelWordWrap.textfield.styleSheet.setStyle(styleName,style);
         }
         this.reCalculateTextsWidth();
      }
      
      override public function remove() : void
      {
         if(this._label)
         {
            this._label.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         }
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN,this.onScrollBarMouseDown);
         }
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         super.remove();
      }
      
      private function updateMaxScroll() : void
      {
         var i:int = this._lines.length;
         var LinesShown:int = 0;
         while(i > 0 && LinesShown <= this._numLines)
         {
            i--;
            LinesShown += this._nbLines[this._lines[i]];
         }
         if(LinesShown <= this._numLines)
         {
            this._maxScroll = 0;
            this._maxInterScroll = 0;
         }
         else
         {
            this._maxScroll = i;
            this._maxInterScroll = LinesShown - this._numLines;
         }
         if(this._scroll > this._maxScroll || this._scroll == this._maxScroll && this._interScroll > this._maxInterScroll)
         {
            this._scroll = this._maxScroll;
            this._interScroll = this._maxInterScroll;
         }
      }
      
      private function linesFromScroll() : uint
      {
         var i:int = this._scroll - 1;
         var LinesShown:int = 0;
         while(LinesShown < this._numLines + this._interScroll && i < this._lines.length - 1)
         {
            i++;
            LinesShown += this._nbLines[this._lines[i]];
         }
         return i - this._scroll + 1;
      }
      
      private function checkSpan(pText:String, pLineIndex:int) : String
      {
         var i:int = 0;
         var spanIndex:int = 0;
         var lastSpan:String = null;
         var text:String = pText;
         var openSpanIndex:int = pText.indexOf("<span");
         var closeSpanIndex:int = pText.indexOf("</span>");
         if(closeSpanIndex < openSpanIndex)
         {
            for(i = 0; i <= pLineIndex; i++)
            {
               spanIndex = this._lines[i].indexOf("<span");
               if(spanIndex != -1)
               {
                  lastSpan = this._lines[i].substring(spanIndex,this._lines[i].indexOf(">") + 1);
               }
            }
            text = lastSpan + text;
         }
         return text;
      }
      
      private function updateTextPosition() : void
      {
         var p:Number = this._scrollBar.y / (this._label.height - this._scrollBar.height);
         this.scrollText((this.remainingScrollableLines + this.alreadyScrolledLines) * p - this.alreadyScrolledLines);
      }
      
      private function drawScrollBar() : void
      {
         if(this.textFieldNumLines <= this._numLines)
         {
            visible = false;
            this._scrollAtEnd = true;
            return;
         }
         visible = true;
         var pHeight:Number = this._numLines / this.textFieldNumLines;
         var vHeight:int = int(this._label.height * pHeight);
         if(vHeight < 40)
         {
            vHeight = 40;
         }
         this._scrollBar.graphics.clear();
         this._scrollBar.graphics.beginFill(this._color);
         this._scrollBar.graphics.drawRoundRect(0,0,WIDTH,vHeight,5);
         this._scrollBar.graphics.endFill();
         var ytemp:int = this._interScroll;
         for(var i:int = 0; i < this._scroll; i++)
         {
            ytemp += this._nbLines[this._lines[i]];
         }
         this._scrollBar.y = ytemp * (this._label.height - this._scrollBar.height) / (this.textFieldNumLines - this._numLines);
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
         this._scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollBarMouseDown);
         addChild(this._background);
         addChild(this._scrollBar);
         this.resize();
      }
      
      public function reCalculateTextsWidth(force:Boolean = false) : void
      {
         var text:String = null;
         this.textFieldNumLines = 0;
         for each(text in this._lines)
         {
            if(!this.linesLenghts[text] || force)
            {
               this._testLabel.htmlText = text;
               this.linesLenghts[text] = this._testLabel.textWidth;
            }
            this._nbLines[text] = this.textNbLines(text);
            this.textFieldNumLines += this._nbLines[text];
         }
      }
      
      private function textNbLines(text:String) : uint
      {
         if(this.linesLenghts[text] < this._label.width - 50)
         {
            return 1;
         }
         this._testLabelWordWrap.htmlText = text;
         return this._testLabelWordWrap.textfield.numLines;
      }
      
      private function onScrollBarMouseDown(mouseEvent:MouseEvent) : void
      {
         this.offsetY = this._scrollBar.mouseY;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseWheel(mouseEvent:MouseEvent) : void
      {
         var nbCharDiffSelectionBegin:int = 0;
         var newSelectionBegin:int = 0;
         var newSelectionEnd:int = 0;
         var i:int = 0;
         var alreadyScrolled:int = 0;
         var initialInterScroll:int = 0;
         var endIndex:int = 0;
         if(!visible)
         {
            return;
         }
         var selectionBegin:int = this._label.textfield.selectionBeginIndex;
         var selectionEnd:int = this._label.textfield.selectionEndIndex;
         if(selectionBegin != selectionEnd)
         {
            nbCharDiffSelectionBegin = 0;
            if(mouseEvent.delta < 0)
            {
               for(i = 0; i < Math.min(this._power,this.remainingScrollableLines) + this._interScroll; i++)
               {
                  nbCharDiffSelectionBegin += this._label.textfield.getLineLength(i);
               }
               newSelectionBegin = selectionBegin - nbCharDiffSelectionBegin;
               newSelectionEnd = selectionEnd - nbCharDiffSelectionBegin;
            }
            else
            {
               alreadyScrolled = this.alreadyScrolledLines;
               initialInterScroll = this._interScroll;
            }
         }
         this.scrollText(int((mouseEvent.delta < 0 ? 1 : -1) * this._power));
         this.resize();
         if(selectionBegin != selectionEnd)
         {
            if(mouseEvent.delta > 0)
            {
               for(i = 0; i < Math.min(this._power,alreadyScrolled) - initialInterScroll + this._interScroll; i++)
               {
                  nbCharDiffSelectionBegin += this._label.textfield.getLineLength(i);
               }
               newSelectionBegin = selectionBegin + nbCharDiffSelectionBegin;
               newSelectionEnd = selectionEnd + nbCharDiffSelectionBegin;
               endIndex = this._numLines + this._interScroll < this._label.textfield.numLines ? int(this._label.textfield.getLineOffset(this._numLines + this._interScroll) - 1) : int(this._label.textfield.text.length - 1);
               this._label.textfield.setSelection(Math.min(newSelectionBegin,endIndex),Math.min(newSelectionEnd,endIndex));
            }
            else
            {
               this._label.textfield.setSelection(this._label.textfield.getLineOffset(this._interScroll) + Math.max(0,newSelectionBegin),this._label.textfield.getLineOffset(this._interScroll) + Math.max(0,newSelectionEnd));
            }
         }
      }
      
      private function onMouseUp(mouseEvent:MouseEvent) : void
      {
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }
      
      private function onMouseMove(mouseEvent:MouseEvent) : void
      {
         var value:int = mouseY - this.offsetY;
         var maxValue:int = this._label.height - this._scrollBar.height;
         if(value < 0)
         {
            value = 0;
         }
         else if(value > maxValue)
         {
            value = maxValue;
         }
         this._scrollBar.y = value;
         this.updateTextPosition();
         mouseEvent.updateAfterEvent();
      }
      
      private function get remainingScrollableLines() : int
      {
         var total:int = 0;
         for(var i:int = this._scroll; i < this._maxScroll; i++)
         {
            total += this._nbLines[this._lines[i]];
         }
         return total - this._interScroll + this._maxInterScroll;
      }
      
      private function get alreadyScrolledLines() : int
      {
         var total:int = 0;
         for(var i:int = this._scroll - 1; i >= 0; i--)
         {
            total += this._nbLines[this._lines[i]];
         }
         return total + this._interScroll;
      }
   }
}
