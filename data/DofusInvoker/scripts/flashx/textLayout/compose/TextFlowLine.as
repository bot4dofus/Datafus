package flashx.textLayout.compose
{
   import flash.display.DisplayObject;
   import flash.display.GraphicsPathCommand;
   import flash.display.GraphicsPathWinding;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.FontMetrics;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flash.text.engine.TextRotation;
   import flash.utils.Dictionary;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.edit.SelectionFormat;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.LinkState;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TableLeafElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.IListMarkerFormat;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.JustificationRule;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.formats.LineBreak;
   import flashx.textLayout.formats.ListStylePosition;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.CharacterUtil;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class TextFlowLine implements IVerticalJustificationLine
   {
      
      private static var _selectionBlockCache:Dictionary = new Dictionary(true);
      
      private static const VALIDITY_MASK:uint = 7;
      
      private static const ALIGNMENT_SHIFT:uint = 3;
      
      private static const ALIGNMENT_MASK:uint = 24;
      
      private static const NUMBERLINE_MASK:uint = 32;
      
      private static const GRAPHICELEMENT_MASK:uint = 64;
      
      private static const _validities:Array = [TextLineValidity.INVALID,TextLineValidity.POSSIBLY_INVALID,TextLineValidity.STATIC,TextLineValidity.VALID,FlowDamageType.GEOMETRY];
      
      private static const _alignments:Array = [TextAlign.LEFT,TextAlign.CENTER,TextAlign.RIGHT];
      
      private static var numberLineFactory:NumberLineFactory;
      
      private static const localZeroPoint:Point = new Point(0,0);
      
      private static const localOnePoint:Point = new Point(1,0);
      
      private static const rlLocalOnePoint:Point = new Point(0,1);
       
      
      private var _absoluteStart:int;
      
      private var _textLength:int;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _height:Number = 0;
      
      private var _outerTargetWidth:Number = 0;
      
      private var _boundsLeftTW:int = 2;
      
      private var _boundsRightTW:int = 1;
      
      private var _para:ParagraphElement;
      
      private var _controller:ContainerController;
      
      private var _columnIndex:int;
      
      private var _adornCount:int = 0;
      
      private var _flags:uint;
      
      protected var _ascent:Number;
      
      protected var _descent:Number;
      
      private var _targetWidth:Number;
      
      protected var _lineOffset:Number;
      
      private var _lineExtent:Number;
      
      private var _accumulatedLineExtent:Number;
      
      private var _accumulatedMinimumStart:Number;
      
      private var _numberLinePosition:int;
      
      public function TextFlowLine(textLine:TextLine, paragraph:ParagraphElement, outerTargetWidth:Number = 0, lineOffset:Number = 0, absoluteStart:int = 0, numChars:int = 0)
      {
         super();
         this.initialize(paragraph,outerTargetWidth,lineOffset,absoluteStart,numChars,textLine);
      }
      
      tlf_internal static function initializeNumberLinePosition(numberLine:TextLine, listItemElement:ListItemElement, curParaElement:ParagraphElement, totalWidth:Number) : void
      {
         var listMarkerFormat:IListMarkerFormat = listItemElement.computedListMarkerFormat();
         var paragraphFormat:ITextLayoutFormat = curParaElement.computedFormat;
         var listEndIndent:Number = listMarkerFormat.paragraphEndIndent === undefined || listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE ? Number(0) : (listMarkerFormat.paragraphEndIndent == FormatValue.INHERIT ? Number(paragraphFormat.paragraphEndIndent) : Number(listMarkerFormat.paragraphEndIndent));
         TextFlowLine.setListEndIndent(numberLine,listEndIndent);
         if(listItemElement.computedFormat.listStylePosition == ListStylePosition.OUTSIDE)
         {
            numberLine.x = numberLine.y = 0;
            return;
         }
         var bp:String = curParaElement.getTextFlow().computedFormat.blockProgression;
         var numberLineWidth:Number = TextFlowLine.getNumberLineInsideLineWidth(numberLine);
         if(bp == BlockProgression.TB)
         {
            if(paragraphFormat.direction == Direction.LTR)
            {
               numberLine.x = -numberLineWidth;
            }
            else
            {
               numberLine.x = totalWidth + numberLineWidth - numberLine.textWidth;
            }
            numberLine.y = 0;
         }
         else
         {
            if(paragraphFormat.direction == Direction.LTR)
            {
               numberLine.y = -numberLineWidth;
            }
            else
            {
               numberLine.y = totalWidth + numberLineWidth - numberLine.textWidth;
            }
            numberLine.x = 0;
         }
      }
      
      tlf_internal static function createNumberLine(listItemElement:ListItemElement, curParaElement:ParagraphElement, swfContext:ISWFContext, totalStartIndent:Number) : TextLine
      {
         var highestParentLinkLinkElement:LinkElement = null;
         var key:String = null;
         var rslt:Array = null;
         var numberLine:TextLine = null;
         var leaf:FlowLeafElement = null;
         var val:* = undefined;
         if(numberLineFactory == null)
         {
            numberLineFactory = new NumberLineFactory();
            numberLineFactory.compositionBounds = new Rectangle(0,0,NaN,NaN);
         }
         numberLineFactory.swfContext = swfContext;
         var listMarkerFormat:IListMarkerFormat = listItemElement.computedListMarkerFormat();
         numberLineFactory.listStylePosition = listItemElement.computedFormat.listStylePosition;
         var listElement:ListElement = listItemElement.parent as ListElement;
         var paragraphFormat:TextLayoutFormat = new TextLayoutFormat(curParaElement.computedFormat);
         var boxStartIndent:Number = paragraphFormat.direction == Direction.LTR ? Number(listElement.getEffectivePaddingLeft() + listElement.getEffectiveBorderLeftWidth() + listElement.getEffectiveMarginLeft()) : Number(listElement.getEffectivePaddingRight() + listElement.getEffectiveBorderRightWidth() + listElement.getEffectiveMarginRight());
         paragraphFormat.apply(listMarkerFormat);
         paragraphFormat.textIndent += totalStartIndent;
         if(numberLineFactory.listStylePosition == ListStylePosition.OUTSIDE)
         {
            paragraphFormat.textIndent -= boxStartIndent;
         }
         numberLineFactory.paragraphFormat = paragraphFormat;
         numberLineFactory.textFlowFormat = curParaElement.getTextFlow().computedFormat;
         var firstLeaf:FlowLeafElement = curParaElement.getFirstLeaf();
         var parentLink:LinkElement = firstLeaf.getParentByType(LinkElement) as LinkElement;
         var linkStateArray:Array = [];
         while(parentLink)
         {
            highestParentLinkLinkElement = parentLink;
            linkStateArray.push(parentLink.linkState);
            parentLink.chgLinkState(LinkState.SUPPRESSED);
            parentLink = parentLink.getParentByType(LinkElement) as LinkElement;
         }
         var spanFormat:TextLayoutFormat = new TextLayoutFormat(firstLeaf.computedFormat);
         parentLink = firstLeaf.getParentByType(LinkElement) as LinkElement;
         while(parentLink)
         {
            linkStateArray.push(parentLink.linkState);
            parentLink.chgLinkState(linkStateArray.shift());
            parentLink = parentLink.getParentByType(LinkElement) as LinkElement;
         }
         if(highestParentLinkLinkElement)
         {
            leaf = highestParentLinkLinkElement.getFirstLeaf();
            while(leaf)
            {
               leaf.computedFormat;
               leaf = leaf.getNextLeaf(highestParentLinkLinkElement);
            }
         }
         var markerFormat:TextLayoutFormat = new TextLayoutFormat(spanFormat);
         TextLayoutFormat.resetModifiedNoninheritedStyles(markerFormat);
         var holderStyles:Object = (listMarkerFormat as TextLayoutFormat).getStyles();
         for(key in holderStyles)
         {
            if(val !== FormatValue.INHERIT)
            {
               val = holderStyles[key];
               markerFormat[key] = val !== FormatValue.INHERIT ? val : spanFormat[key];
            }
         }
         numberLineFactory.markerFormat = markerFormat;
         numberLineFactory.text = listElement.computeListItemText(listItemElement,listMarkerFormat);
         rslt = [];
         numberLineFactory.createTextLines(function(o:DisplayObject):void
         {
            rslt.push(o);
         });
         numberLine = rslt[0] as TextLine;
         if(numberLine)
         {
            numberLine.mouseEnabled = false;
            numberLine.mouseChildren = false;
            setNumberLineBackground(numberLine,numberLineFactory.backgroundManager);
         }
         numberLineFactory.clearBackgroundManager();
         return numberLine;
      }
      
      tlf_internal static function getTextLineTypographicAscent(textLine:TextLine, elem:FlowLeafElement, elemStart:int, textLineEnd:int) : Number
      {
         var rslt:Number = textLine.getBaselinePosition(TextBaseline.ROMAN) - textLine.getBaselinePosition(TextBaseline.ASCENT);
         if(textLine.hasGraphicElement)
         {
            while(true)
            {
               if(elem is InlineGraphicElement)
               {
                  rslt = Math.max(rslt,InlineGraphicElement(elem).getTypographicAscent(textLine));
               }
               elemStart += elem.textLength;
               if(elemStart >= textLineEnd)
               {
                  break;
               }
               elem = elem.getNextLeaf();
            }
         }
         return rslt;
      }
      
      private static function createSelectionRect(selObj:Shape, color:uint, x:Number, y:Number, width:Number, height:Number) : DisplayObject
      {
         selObj.graphics.beginFill(color);
         var cmds:Vector.<int> = new Vector.<int>();
         var pathPoints:Vector.<Number> = new Vector.<Number>();
         cmds.push(GraphicsPathCommand.MOVE_TO);
         pathPoints.push(x);
         pathPoints.push(y);
         cmds.push(GraphicsPathCommand.LINE_TO);
         pathPoints.push(x + width);
         pathPoints.push(y);
         cmds.push(GraphicsPathCommand.LINE_TO);
         pathPoints.push(x + width);
         pathPoints.push(y + height);
         cmds.push(GraphicsPathCommand.LINE_TO);
         pathPoints.push(x);
         pathPoints.push(y + height);
         cmds.push(GraphicsPathCommand.LINE_TO);
         pathPoints.push(x);
         pathPoints.push(y);
         selObj.graphics.drawPath(cmds,pathPoints,GraphicsPathWinding.NON_ZERO);
         return selObj;
      }
      
      tlf_internal static function constrainRectToColumn(tf:TextFlow, rect:Rectangle, columnRect:Rectangle, hScrollPos:Number, vScrollPos:Number, compositionWidth:Number, compositionHeight:Number) : void
      {
         if(columnRect == null)
         {
            return;
         }
         if(tf.computedFormat.lineBreak == LineBreak.EXPLICIT)
         {
            return;
         }
         var bp:String = tf.computedFormat.blockProgression;
         var direction:String = tf.computedFormat.direction;
         if(bp == BlockProgression.TB && !isNaN(compositionWidth))
         {
            if(direction == Direction.LTR)
            {
               if(rect.left > columnRect.x + columnRect.width + hScrollPos)
               {
                  rect.left = columnRect.x + columnRect.width + hScrollPos;
               }
               if(rect.right > columnRect.x + columnRect.width + hScrollPos)
               {
                  rect.right = columnRect.x + columnRect.width + hScrollPos;
               }
            }
            else
            {
               if(rect.right < columnRect.x + hScrollPos)
               {
                  rect.right = columnRect.x + hScrollPos;
               }
               if(rect.left < columnRect.x + hScrollPos)
               {
                  rect.left = columnRect.x + hScrollPos;
               }
            }
         }
         else if(bp == BlockProgression.RL && !isNaN(compositionHeight))
         {
            if(direction == Direction.LTR)
            {
               if(rect.top > columnRect.y + columnRect.height + vScrollPos)
               {
                  rect.top = columnRect.y + columnRect.height + vScrollPos;
               }
               if(rect.bottom > columnRect.y + columnRect.height + vScrollPos)
               {
                  rect.bottom = columnRect.y + columnRect.height + vScrollPos;
               }
            }
            else
            {
               if(rect.bottom < columnRect.y + vScrollPos)
               {
                  rect.bottom = columnRect.y + vScrollPos;
               }
               if(rect.top < columnRect.y + vScrollPos)
               {
                  rect.top = columnRect.y + vScrollPos;
               }
            }
         }
      }
      
      private static function setRectangleValues(rect:Rectangle, x:Number, y:Number, width:Number, height:Number) : void
      {
         rect.x = x;
         rect.y = y;
         rect.width = width;
         rect.height = height;
      }
      
      tlf_internal static function findNumberLine(textLine:TextLine) : TextLine
      {
         var numberLine:TextLine = null;
         if(textLine == null)
         {
            return null;
         }
         for(var idx:int = 0; idx < textLine.numChildren; idx++)
         {
            numberLine = textLine.getChildAt(idx) as TextLine;
            if(numberLine && numberLine.userData is NumberLineUserData)
            {
               break;
            }
         }
         return numberLine;
      }
      
      tlf_internal static function getNumberLineListStylePosition(numberLine:TextLine) : String
      {
         return (numberLine.userData as NumberLineUserData).listStylePosition;
      }
      
      tlf_internal static function getNumberLineInsideLineWidth(numberLine:TextLine) : Number
      {
         return (numberLine.userData as NumberLineUserData).insideLineWidth;
      }
      
      tlf_internal static function getNumberLineSpanFormat(numberLine:TextLine) : ITextLayoutFormat
      {
         return (numberLine.userData as NumberLineUserData).spanFormat;
      }
      
      tlf_internal static function getNumberLineParagraphDirection(numberLine:TextLine) : String
      {
         return (numberLine.userData as NumberLineUserData).paragraphDirection;
      }
      
      tlf_internal static function setListEndIndent(numberLine:TextLine, listEndIndent:Number) : void
      {
         (numberLine.userData as NumberLineUserData).listEndIndent = listEndIndent;
      }
      
      tlf_internal static function getListEndIndent(numberLine:TextLine) : Number
      {
         return (numberLine.userData as NumberLineUserData).listEndIndent;
      }
      
      tlf_internal static function setNumberLineBackground(numberLine:TextLine, background:BackgroundManager) : void
      {
         (numberLine.userData as NumberLineUserData).backgroundManager = background;
      }
      
      tlf_internal static function getNumberLineBackground(numberLine:TextLine) : BackgroundManager
      {
         return (numberLine.userData as NumberLineUserData).backgroundManager;
      }
      
      tlf_internal function initialize(paragraph:ParagraphElement, outerTargetWidth:Number = 0, lineOffset:Number = 0, absoluteStart:int = 0, numChars:int = 0, textLine:TextLine = null) : void
      {
         this._para = paragraph;
         this._outerTargetWidth = outerTargetWidth;
         this._absoluteStart = absoluteStart;
         this._textLength = numChars;
         this._adornCount = 0;
         this._lineExtent = 0;
         this._accumulatedLineExtent = 0;
         this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
         this._flags = 0;
         this._controller = null;
         if(textLine)
         {
            textLine.userData = this;
            this._targetWidth = textLine.specifiedWidth;
            this._ascent = textLine.ascent;
            this._descent = textLine.descent;
            this._lineOffset = lineOffset;
            this.setValidity(textLine.validity);
            this.setFlag(!!textLine.hasGraphicElement ? uint(GRAPHICELEMENT_MASK) : uint(0),GRAPHICELEMENT_MASK);
         }
         else
         {
            this.setValidity(TextLineValidity.INVALID);
         }
      }
      
      private function setFlag(value:uint, mask:uint) : void
      {
         this._flags = this._flags & ~mask | value;
      }
      
      private function getFlag(mask:uint) : uint
      {
         return this._flags & mask;
      }
      
      tlf_internal function get heightTW() : int
      {
         return Twips.to(this._height);
      }
      
      tlf_internal function get outerTargetWidthTW() : int
      {
         return Twips.to(this._outerTargetWidth);
      }
      
      tlf_internal function get ascentTW() : int
      {
         return Twips.to(this._ascent);
      }
      
      tlf_internal function get targetWidthTW() : int
      {
         return Twips.to(this._targetWidth);
      }
      
      tlf_internal function get textHeightTW() : int
      {
         return Twips.to(this.textHeight);
      }
      
      tlf_internal function get lineOffsetTW() : int
      {
         return Twips.to(this._lineOffset);
      }
      
      tlf_internal function get lineExtentTW() : int
      {
         return Twips.to(this._lineExtent);
      }
      
      tlf_internal function get hasGraphicElement() : Boolean
      {
         return this.getFlag(GRAPHICELEMENT_MASK) != 0;
      }
      
      tlf_internal function get hasNumberLine() : Boolean
      {
         return this.getFlag(NUMBERLINE_MASK) != 0;
      }
      
      tlf_internal function get numberLinePosition() : Number
      {
         return Twips.from(this._numberLinePosition);
      }
      
      tlf_internal function set numberLinePosition(position:Number) : void
      {
         this._numberLinePosition = Twips.to(position);
      }
      
      public function get textHeight() : Number
      {
         return this._ascent + this._descent;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(lineX:Number) : void
      {
         this._x = lineX;
         this._boundsLeftTW = 2;
         this._boundsRightTW = 1;
      }
      
      tlf_internal function get xTW() : int
      {
         return Twips.to(this._x);
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      tlf_internal function get yTW() : int
      {
         return Twips.to(this._y);
      }
      
      public function set y(lineY:Number) : void
      {
         this._y = lineY;
         this._boundsLeftTW = 2;
         this._boundsRightTW = 1;
      }
      
      tlf_internal function setXYAndHeight(lineX:Number, lineY:Number, lineHeight:Number) : void
      {
         this._x = lineX;
         this._y = lineY;
         this._height = lineHeight;
         this._boundsLeftTW = 2;
         this._boundsRightTW = 1;
      }
      
      public function get location() : int
      {
         var lineStart:int = 0;
         var textLine:TextLine = null;
         if(this._para)
         {
            textLine = this.peekTextLine();
            if(textLine)
            {
               lineStart = this._absoluteStart - this._para.getTextBlockAbsoluteStart(textLine.textBlock);
            }
            else
            {
               lineStart = this._absoluteStart - this._para.getAbsoluteStart();
            }
            if(lineStart == 0)
            {
               return this._textLength == this._para.textLength ? int(TextFlowLineLocation.ONLY) : int(TextFlowLineLocation.FIRST);
            }
            if(lineStart + this.textLength == this._para.textLength)
            {
               return TextFlowLineLocation.LAST;
            }
         }
         return TextFlowLineLocation.MIDDLE;
      }
      
      public function get controller() : ContainerController
      {
         return this._controller;
      }
      
      public function get columnIndex() : int
      {
         return this._columnIndex;
      }
      
      tlf_internal function setController(cont:ContainerController, colNumber:int) : void
      {
         this._controller = cont as ContainerController;
         this._columnIndex = colNumber;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function get ascent() : Number
      {
         return this._ascent;
      }
      
      public function get descent() : Number
      {
         return this._descent;
      }
      
      public function get lineOffset() : Number
      {
         return this._lineOffset;
      }
      
      public function get paragraph() : ParagraphElement
      {
         return this._para;
      }
      
      public function get absoluteStart() : int
      {
         return this._absoluteStart;
      }
      
      tlf_internal function setAbsoluteStart(val:int) : void
      {
         this._absoluteStart = val;
      }
      
      public function get textLength() : int
      {
         return this._textLength;
      }
      
      tlf_internal function setTextLength(val:int) : void
      {
         this._textLength = val;
         this.damage(TextLineValidity.INVALID);
      }
      
      public function get spaceBefore() : Number
      {
         return !!(this.location & TextFlowLineLocation.FIRST) ? Number(this._para.computedFormat.paragraphSpaceBefore) : Number(0);
      }
      
      public function get spaceAfter() : Number
      {
         return !!(this.location & TextFlowLineLocation.LAST) ? Number(this._para.computedFormat.paragraphSpaceAfter) : Number(0);
      }
      
      tlf_internal function get outerTargetWidth() : Number
      {
         return this._outerTargetWidth;
      }
      
      tlf_internal function set outerTargetWidth(val:Number) : void
      {
         this._outerTargetWidth = val;
      }
      
      tlf_internal function get targetWidth() : Number
      {
         return this._targetWidth;
      }
      
      public function getBounds() : Rectangle
      {
         var textLine:TextLine = this.getTextLine(true);
         if(!textLine)
         {
            return new Rectangle();
         }
         var bp:String = this.paragraph.getAncestorWithContainer().computedFormat.blockProgression;
         var shapeX:Number = this.x;
         var shapeY:Number = this.createShapeY(bp);
         if(bp == BlockProgression.TB)
         {
            shapeY += this.descent - textLine.height;
         }
         return new Rectangle(shapeX,shapeY,textLine.width,textLine.height);
      }
      
      private function setValidity(value:String) : void
      {
         this.setFlag(_validities.indexOf(value),VALIDITY_MASK);
      }
      
      public function get validity() : String
      {
         return _validities[this.getFlag(VALIDITY_MASK)];
      }
      
      public function get unjustifiedTextWidth() : Number
      {
         var textLine:TextLine = this.getTextLine(true);
         return textLine.unjustifiedTextWidth + (this._outerTargetWidth - this.targetWidth);
      }
      
      tlf_internal function get lineExtent() : Number
      {
         return this._lineExtent;
      }
      
      tlf_internal function set lineExtent(value:Number) : void
      {
         this._lineExtent = value;
      }
      
      tlf_internal function get accumulatedLineExtent() : Number
      {
         return this._accumulatedLineExtent;
      }
      
      tlf_internal function set accumulatedLineExtent(value:Number) : void
      {
         this._accumulatedLineExtent = value;
      }
      
      tlf_internal function get accumulatedMinimumStart() : Number
      {
         return this._accumulatedMinimumStart;
      }
      
      tlf_internal function set accumulatedMinimumStart(value:Number) : void
      {
         this._accumulatedMinimumStart = value;
      }
      
      tlf_internal function get alignment() : String
      {
         return _alignments[this.getFlag(ALIGNMENT_MASK) >> ALIGNMENT_SHIFT];
      }
      
      tlf_internal function set alignment(value:String) : void
      {
         this.setFlag(_alignments.indexOf(value) << ALIGNMENT_SHIFT,ALIGNMENT_MASK);
      }
      
      tlf_internal function isDamaged() : Boolean
      {
         return this.validity != TextLineValidity.VALID;
      }
      
      tlf_internal function clearDamage() : void
      {
         this.setValidity(TextLineValidity.VALID);
      }
      
      tlf_internal function damage(damageType:String) : void
      {
         var current:String = this.validity;
         if(current == damageType || current == TextLineValidity.INVALID)
         {
            return;
         }
         this.setValidity(damageType);
      }
      
      tlf_internal function testLineVisible(wmode:String, x:int, y:int, w:int, h:int) : int
      {
         if(wmode == BlockProgression.RL)
         {
            if(this._boundsRightTW >= x && this._boundsLeftTW < x + w)
            {
               return 0;
            }
            return x < this._boundsRightTW ? 1 : -1;
         }
         if(this._boundsRightTW >= y && this._boundsLeftTW < y + h)
         {
            return 0;
         }
         return y < this._boundsRightTW ? -1 : 1;
      }
      
      tlf_internal function oldTestLineVisible(wmode:String, x:int, y:int, w:int, h:int) : Boolean
      {
         if(wmode == BlockProgression.RL)
         {
            return this._boundsRightTW >= x && this._boundsLeftTW < x + w;
         }
         return this._boundsRightTW >= y && this._boundsLeftTW < y + h;
      }
      
      tlf_internal function cacheLineBounds(wmode:String, bndsx:Number, bndsy:Number, bndsw:Number, bndsh:Number) : void
      {
         if(wmode == BlockProgression.RL)
         {
            this._boundsLeftTW = Twips.to(bndsx);
            this._boundsRightTW = Twips.to(bndsx + bndsw);
         }
         else
         {
            this._boundsLeftTW = Twips.to(bndsy);
            this._boundsRightTW = Twips.to(bndsy + bndsh);
         }
      }
      
      tlf_internal function hasLineBounds() : Boolean
      {
         return this._boundsLeftTW <= this._boundsRightTW;
      }
      
      public function get textLineExists() : Boolean
      {
         return this.peekTextLine() != null;
      }
      
      tlf_internal function peekTextLine() : TextLine
      {
         var textLine:TextLine = null;
         var textBlock:TextBlock = null;
         if(!this.paragraph)
         {
            return null;
         }
         var textBlocks:Vector.<TextBlock> = this.paragraph.getTextBlocks();
         for each(textBlock in textBlocks)
         {
            textLine = textBlock.firstLine;
            while(textLine)
            {
               if(textLine.userData == this)
               {
                  return textLine;
               }
               textLine = textLine.nextLine;
            }
         }
         return null;
      }
      
      public function getTextLine(forceValid:Boolean = false) : TextLine
      {
         var textLine:TextLine = this.peekTextLine();
         if(textLine && textLine.validity == FlowDamageType.GEOMETRY)
         {
            this.createShape(this.paragraph.getTextFlow().computedFormat.blockProgression,textLine);
         }
         else if(!textLine || textLine.validity == TextLineValidity.INVALID && forceValid)
         {
            if(this.isDamaged() && this.validity != FlowDamageType.GEOMETRY)
            {
               return null;
            }
            textLine = this.getTextLineInternal();
         }
         return textLine;
      }
      
      private function getTextLineInternal() : TextLine
      {
         var textLine:TextLine = null;
         var line:TextFlowLine = null;
         var paraAbsStart:int = this.paragraph.getAbsoluteStart();
         var textBlock:TextBlock = this.paragraph.getTextBlockAtPosition(this.absoluteStart - paraAbsStart);
         var currentLine:TextLine = textBlock.firstLine;
         var flowComposer:IFlowComposer = this.paragraph.getTextFlow().flowComposer;
         var lineIndex:int = flowComposer.findLineIndexAtPosition(paraAbsStart);
         var previousLine:TextLine = null;
         do
         {
            line = flowComposer.getLineAt(lineIndex);
            if(currentLine != null && currentLine.validity == TextLineValidity.VALID && (line != this || currentLine.userData == line))
            {
               textLine = currentLine;
               currentLine = currentLine.nextLine;
            }
            else if(line is TextFlowTableBlock)
            {
               textLine = null;
               currentLine = null;
            }
            else
            {
               textLine = line.recreateTextLine(textBlock,previousLine);
               currentLine = null;
            }
            previousLine = textLine;
            lineIndex++;
         }
         while(line != this);
         
         return textLine;
      }
      
      tlf_internal function recreateTextLine(textBlock:TextBlock, previousLine:TextLine) : TextLine
      {
         var textLine:TextLine = null;
         var numberLine:TextLine = null;
         var boxStartTotalIndent:Number = NaN;
         var paraStart:int = 0;
         var elem:FlowLeafElement = null;
         var elemStart:int = 0;
         var listItemElement:ListItemElement = null;
         var textFlow:TextFlow = this._para.getTextFlow();
         var bp:String = textFlow.computedFormat.blockProgression;
         var flowComposer:IFlowComposer = textFlow.flowComposer;
         var swfContext:ISWFContext = !!flowComposer.swfContext ? flowComposer.swfContext : BaseCompose.globalSWFContext;
         var effLineOffset:Number = this._lineOffset;
         if(this.hasNumberLine)
         {
            boxStartTotalIndent = this._lineOffset - this._para.computedFormat.textIndent;
            numberLine = TextFlowLine.createNumberLine(this._para.getParentByType(ListItemElement) as ListItemElement,this._para,flowComposer.swfContext,boxStartTotalIndent);
            if(numberLine)
            {
               if(getNumberLineListStylePosition(numberLine) == ListStylePosition.INSIDE)
               {
                  effLineOffset += getNumberLineInsideLineWidth(numberLine);
               }
            }
         }
         textLine = TextLineRecycler.getLineForReuse();
         if(textLine)
         {
            textLine = swfContext.callInContext(textBlock["recreateTextLine"],textBlock,[textLine,previousLine,this._targetWidth,effLineOffset,true]);
         }
         else
         {
            textLine = swfContext.callInContext(textBlock.createTextLine,textBlock,[previousLine,this._targetWidth,effLineOffset,true]);
         }
         if(textLine == null)
         {
            return null;
         }
         textLine.x = this.x;
         textLine.y = this.createShapeY(bp);
         textLine.doubleClickEnabled = true;
         textLine.userData = this;
         if(this._adornCount > 0)
         {
            paraStart = this._para.getAbsoluteStart();
            elem = this._para.findLeaf(this.absoluteStart - paraStart);
            elemStart = elem.getAbsoluteStart();
            if(numberLine)
            {
               listItemElement = this._para.getParentByType(ListItemElement) as ListItemElement;
               TextFlowLine.initializeNumberLinePosition(numberLine,listItemElement,this._para,textLine.textWidth);
            }
            this.createAdornments(this._para.getAncestorWithContainer().computedFormat.blockProgression,elem,elemStart,textLine,numberLine);
            if(numberLine && getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
            {
               if(bp == BlockProgression.TB)
               {
                  numberLine.x = this.numberLinePosition;
               }
               else
               {
                  numberLine.y = this.numberLinePosition;
               }
            }
         }
         return textLine;
      }
      
      tlf_internal function createShape(bp:String, textLine:TextLine) : void
      {
         var newX:Number = this.x;
         textLine.x = newX;
         var newY:Number = this.createShapeY(bp);
         textLine.y = newY;
      }
      
      private function createShapeY(bp:String) : Number
      {
         return bp == BlockProgression.RL ? Number(this.y) : Number(this.y + this._ascent);
      }
      
      tlf_internal function createAdornments(blockProgression:String, elem:FlowLeafElement, elemStart:int, textLine:TextLine, numberLine:TextLine) : void
      {
         var bgm:BackgroundManager = null;
         var elemFormat:ITextLayoutFormat = null;
         var imeStatus:* = undefined;
         var endPos:int = this._absoluteStart + this._textLength;
         this._adornCount = 0;
         if(numberLine)
         {
            ++this._adornCount;
            this.setFlag(NUMBERLINE_MASK,NUMBERLINE_MASK);
            textLine.addChild(numberLine);
            if(getNumberLineBackground(numberLine) != null)
            {
               bgm = elem.getTextFlow().getBackgroundManager();
               if(bgm)
               {
                  bgm.addNumberLine(textLine,numberLine);
               }
            }
         }
         else
         {
            this.setFlag(0,NUMBERLINE_MASK);
         }
         while(true)
         {
            this._adornCount += elem.updateAdornments(textLine,blockProgression);
            elemFormat = elem.format;
            imeStatus = !!elemFormat ? elemFormat.getStyle("imeStatus") : undefined;
            if(imeStatus)
            {
               elem.updateIMEAdornments(textLine,blockProgression,imeStatus as String);
            }
            elemStart += elem.textLength;
            if(elemStart >= endPos)
            {
               break;
            }
            elem = elem.getNextLeaf(this._para);
         }
      }
      
      tlf_internal function getLineLeading(bp:String, elem:FlowLeafElement, elemStart:int) : Number
      {
         var elemLeading:Number = NaN;
         var endPos:int = this._absoluteStart + this._textLength;
         var totalLeading:Number = 0;
         do
         {
            elemLeading = elem.getEffectiveLineHeight(bp);
            if(!elemLeading && elem.textLength == this.textLength)
            {
               elemLeading = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(elem.computedFormat.lineHeight,elem.computedFormat.fontSize);
            }
            totalLeading = Math.max(totalLeading,elemLeading);
            elemStart += elem.textLength;
            if(elemStart >= endPos)
            {
               break;
            }
            elem = elem.getNextLeaf(this._para);
         }
         while(elem != null);
         
         return totalLeading;
      }
      
      tlf_internal function getLineTypographicAscent(elem:FlowLeafElement, elemStart:int, textLine:TextLine) : Number
      {
         return getTextLineTypographicAscent(!!textLine ? textLine : this.getTextLine(),elem,elemStart,this.absoluteStart + this.textLength);
      }
      
      tlf_internal function getCSSLineBox(bp:String, elem:FlowLeafElement, elemStart:int, swfContext:ISWFContext, effectiveListMarkerFormat:ITextLayoutFormat = null, numberLine:TextLine = null) : Rectangle
      {
         var lineBox:Rectangle = null;
         var para:ParagraphElement = null;
         var ef:ElementFormat = null;
         var metrics:FontMetrics = null;
         var addToLineBox:Function = function(inlineBox:Rectangle):void
         {
            if(inlineBox)
            {
               lineBox = !!lineBox ? lineBox.union(inlineBox) : inlineBox;
            }
         };
         var endPos:int = this._absoluteStart + this._textLength;
         var textLine:TextLine = this.getTextLine();
         while(true)
         {
            addToLineBox(elem.getCSSInlineBox(bp,textLine,this._para,swfContext));
            var elemStart:int = elemStart + elem.textLength;
            if(elemStart >= endPos)
            {
               break;
            }
            var elem:FlowLeafElement = elem.getNextLeaf(this._para);
         }
         if(effectiveListMarkerFormat && numberLine)
         {
            para = null;
            ef = FlowLeafElement.computeElementFormatHelper(effectiveListMarkerFormat,para,swfContext);
            metrics = !!swfContext ? swfContext.callInContext(ef.getFontMetrics,ef,null,true) : ef.getFontMetrics();
            addToLineBox(FlowLeafElement.getCSSInlineBoxHelper(effectiveListMarkerFormat,metrics,numberLine,para));
         }
         return lineBox;
      }
      
      private function isTextlineSubsetOfSpan(element:FlowLeafElement) : Boolean
      {
         var spanStart:int = element.getAbsoluteStart();
         var spanEnd:int = spanStart + element.textLength;
         var lineStart:int = this.absoluteStart;
         var lineEnd:int = this.absoluteStart + this._textLength;
         return spanStart <= lineStart && spanEnd >= lineEnd;
      }
      
      private function getSelectionShapesCacheEntry(begIdx:int, endIdx:int, prevLine:TextFlowLine, nextLine:TextFlowLine, blockProgression:String) : SelectionCache
      {
         var drawRect:Rectangle = null;
         if(this.isDamaged())
         {
            return null;
         }
         var textLine:TextLine = this.getTextLine();
         var paraAbsStart:int = this._para.getTextBlockAbsoluteStart(textLine.textBlock);
         if(begIdx == endIdx && paraAbsStart + begIdx == this.absoluteStart)
         {
            if(this.absoluteStart != this._para.getTextFlow().textLength - 1)
            {
               return null;
            }
            endIdx++;
         }
         var selectionCache:SelectionCache = _selectionBlockCache[this];
         if(selectionCache && selectionCache.begIdx == begIdx && selectionCache.endIdx == endIdx)
         {
            return selectionCache;
         }
         var drawRects:Array = new Array();
         var tcyDrawRects:Array = new Array();
         if(selectionCache == null)
         {
            selectionCache = new SelectionCache();
            _selectionBlockCache[this] = selectionCache;
         }
         else
         {
            selectionCache.clear();
         }
         selectionCache.begIdx = begIdx;
         selectionCache.endIdx = endIdx;
         var heightAndAdj:Array = this.getRomanSelectionHeightAndVerticalAdjustment(prevLine,nextLine);
         this.calculateSelectionBounds(textLine,drawRects,begIdx,endIdx,blockProgression,heightAndAdj);
         for each(drawRect in drawRects)
         {
            selectionCache.pushSelectionBlock(drawRect);
         }
         return selectionCache;
      }
      
      tlf_internal function calculateSelectionBounds(textLine:TextLine, rectArray:Array, begIdx:int, endIdx:int, blockProgression:String, heightAndAdj:Array) : void
      {
         var numCharsSelecting:int = 0;
         var endPos:int = 0;
         var ilg:InlineGraphicElement = null;
         var floatInfo:FloatCompositionData = null;
         var blockRect:Rectangle = null;
         var leafBlockArray:Array = null;
         var leafBlockIter:int = 0;
         var tcyBlock:FlowElement = null;
         var tcyParentRelativeEnd:int = 0;
         var subParBlock:SubParagraphGroupElementBase = null;
         var largestTCYRise:Number = NaN;
         var lastTCYIdx:int = 0;
         var tcyRects:Array = null;
         var tcyRectArray:Array = null;
         var tcyBlockIter:int = 0;
         var tcyRect:Rectangle = null;
         var charCode:int = 0;
         var lastElemBlockArray:Array = null;
         var lastRect:Rectangle = null;
         var modifyRect:Rectangle = null;
         var tcyIter:int = 0;
         var floatIter:int = 0;
         var direction:String = this._para.computedFormat.direction;
         var paraAbsStart:int = this._para.getTextBlockAbsoluteStart(textLine.textBlock);
         var curIdx:int = begIdx;
         var curElem:FlowLeafElement = null;
         var largestRise:Number = 0;
         var blockRectArray:Array = [];
         var floatRectArray:Array = null;
         var tcyDrawRects:Array = null;
         while(curIdx < endIdx)
         {
            curElem = this._para.findLeaf(curIdx);
            if(curElem.textLength == 0)
            {
               curIdx++;
            }
            else if(curElem is InlineGraphicElement && (curElem as InlineGraphicElement).computedFloat != Float.NONE)
            {
               if(floatRectArray == null)
               {
                  floatRectArray = [];
               }
               ilg = curElem as InlineGraphicElement;
               floatInfo = this.controller.getFloatAtPosition(paraAbsStart + curIdx);
               if(floatInfo)
               {
                  blockRect = new Rectangle(floatInfo.x - textLine.x,floatInfo.y - textLine.y,ilg.elementWidth,ilg.elementHeight);
                  floatRectArray.push(blockRect);
               }
               curIdx++;
            }
            else
            {
               numCharsSelecting = curElem.textLength + curElem.getElementRelativeStart(this._para) - curIdx;
               if(curElem is TableLeafElement)
               {
                  curIdx++;
               }
               else
               {
                  endPos = numCharsSelecting + curIdx > endIdx ? int(endIdx) : int(numCharsSelecting + curIdx);
                  if(blockProgression != BlockProgression.RL || textLine.getAtomTextRotation(textLine.getAtomIndexAtCharIndex(curIdx)) != TextRotation.ROTATE_0)
                  {
                     leafBlockArray = this.makeSelectionBlocks(textLine,curIdx,endPos,paraAbsStart,blockProgression,direction,heightAndAdj);
                     for(leafBlockIter = 0; leafBlockIter < leafBlockArray.length; leafBlockIter++)
                     {
                        blockRectArray.push(leafBlockArray[leafBlockIter]);
                     }
                     curIdx = endPos;
                  }
                  else
                  {
                     tcyBlock = curElem.getParentByType(TCYElement);
                     tcyParentRelativeEnd = tcyBlock.parentRelativeEnd;
                     subParBlock = tcyBlock.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
                     while(subParBlock)
                     {
                        tcyParentRelativeEnd += subParBlock.parentRelativeStart;
                        subParBlock = subParBlock.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
                     }
                     largestTCYRise = 0;
                     lastTCYIdx = endIdx < tcyParentRelativeEnd ? int(endIdx) : int(tcyParentRelativeEnd);
                     tcyRects = new Array();
                     while(curIdx < lastTCYIdx)
                     {
                        curElem = this._para.findLeaf(curIdx);
                        numCharsSelecting = curElem.textLength + curElem.getElementRelativeStart(this._para) - curIdx;
                        endPos = numCharsSelecting + curIdx > endIdx ? int(endIdx) : int(numCharsSelecting + curIdx);
                        tcyRectArray = this.makeSelectionBlocks(textLine,curIdx,endPos,paraAbsStart,blockProgression,direction,heightAndAdj);
                        for(tcyBlockIter = 0; tcyBlockIter < tcyRectArray.length; tcyBlockIter++)
                        {
                           tcyRect = tcyRectArray[tcyBlockIter];
                           if(tcyRect.height > largestTCYRise)
                           {
                              largestTCYRise = tcyRect.height;
                           }
                           tcyRects.push(tcyRect);
                        }
                        curIdx = endPos;
                     }
                     if(!tcyDrawRects)
                     {
                        tcyDrawRects = new Array();
                     }
                     this.normalizeRects(tcyRects,tcyDrawRects,largestTCYRise,BlockProgression.TB,direction);
                  }
               }
            }
         }
         if(blockRectArray.length > 0 && paraAbsStart + begIdx == this.absoluteStart && paraAbsStart + endIdx == this.absoluteStart + this.textLength)
         {
            curElem = this._para.findLeaf(begIdx);
            if(curElem.getAbsoluteStart() + curElem.textLength < this.absoluteStart + this.textLength && endPos >= 2)
            {
               charCode = this._para.getCharCodeAtPosition(endPos - 1);
               if(charCode != SpanElement.kParagraphTerminator.charCodeAt(0) && CharacterUtil.isWhitespace(charCode))
               {
                  lastElemBlockArray = this.makeSelectionBlocks(textLine,endPos - 1,endPos - 1,paraAbsStart,blockProgression,direction,heightAndAdj);
                  lastRect = lastElemBlockArray[lastElemBlockArray.length - 1];
                  modifyRect = blockRectArray[blockRectArray.length - 1] as Rectangle;
                  if(blockProgression != BlockProgression.RL)
                  {
                     if(modifyRect.width == lastRect.width)
                     {
                        blockRectArray.pop();
                     }
                     else
                     {
                        modifyRect.width -= lastRect.width;
                        if(direction == Direction.RTL)
                        {
                           modifyRect.left -= lastRect.width;
                        }
                     }
                  }
                  else if(modifyRect.height == lastRect.height)
                  {
                     blockRectArray.pop();
                  }
                  else
                  {
                     modifyRect.height -= lastRect.height;
                     if(direction == Direction.RTL)
                     {
                        modifyRect.top += lastRect.height;
                     }
                  }
               }
            }
         }
         this.normalizeRects(blockRectArray,rectArray,largestRise,blockProgression,direction);
         if(tcyDrawRects && tcyDrawRects.length > 0)
         {
            for(tcyIter = 0; tcyIter < tcyDrawRects.length; tcyIter++)
            {
               rectArray.push(tcyDrawRects[tcyIter]);
            }
         }
         if(floatRectArray)
         {
            for(floatIter = 0; floatIter < floatRectArray.length; floatIter++)
            {
               rectArray.push(floatRectArray[floatIter]);
            }
         }
      }
      
      private function createSelectionShapes(selObj:Shape, selFormat:SelectionFormat, container:DisplayObject, begIdx:int, endIdx:int, prevLine:TextFlowLine, nextLine:TextFlowLine) : void
      {
         var drawRect:Rectangle = null;
         var selMgr:ISelectionManager = null;
         var contElement:ContainerFormattedElement = this._para.getAncestorWithContainer();
         var blockProgression:String = contElement.computedFormat.blockProgression;
         var selCache:SelectionCache = this.getSelectionShapesCacheEntry(begIdx,endIdx,prevLine,nextLine,blockProgression);
         if(!selCache)
         {
            return;
         }
         var color:uint = selFormat.rangeColor;
         if(this._para && this._para.getTextFlow())
         {
            selMgr = this._para.getTextFlow().interactionManager;
            if(selMgr && selMgr.anchorPosition == selMgr.activePosition)
            {
               color = selFormat.pointColor;
            }
         }
         for each(drawRect in selCache.selectionBlocks)
         {
            drawRect = drawRect.clone();
            this.convertLineRectToContainer(drawRect,true);
            createSelectionRect(selObj,color,drawRect.x,drawRect.y,drawRect.width,drawRect.height);
         }
      }
      
      tlf_internal function getRomanSelectionHeightAndVerticalAdjustment(prevLine:TextFlowLine, nextLine:TextFlowLine) : Array
      {
         var isFirstLine:Boolean = false;
         var isLastLine:Boolean = false;
         var top:Number = NaN;
         var bottom:Number = NaN;
         var rectHeight:Number = 0;
         var verticalAdj:Number = 0;
         if(ParagraphElement.useUpLeadingDirection(this._para.getEffectiveLeadingModel()))
         {
            rectHeight = Math.max(this.height,this.textHeight);
         }
         else
         {
            isFirstLine = !prevLine || prevLine.controller != this.controller || prevLine.columnIndex != this.columnIndex;
            isLastLine = !nextLine || nextLine.controller != this.controller || nextLine.columnIndex != this.columnIndex || nextLine.paragraph.getEffectiveLeadingModel() == LeadingModel.ROMAN_UP;
            if(isLastLine)
            {
               if(!isFirstLine)
               {
                  rectHeight = this.textHeight;
               }
               else
               {
                  rectHeight = Math.max(this.height,this.textHeight);
               }
            }
            else if(!isFirstLine)
            {
               rectHeight = Math.max(nextLine.height,this.textHeight);
               verticalAdj = rectHeight - this.textHeight;
            }
            else
            {
               top = this._descent - Math.max(this.height,this.textHeight);
               bottom = Math.max(nextLine.height,this.textHeight) - this._ascent;
               rectHeight = bottom - top;
               verticalAdj = bottom - this._descent;
            }
         }
         if(!prevLine || prevLine.columnIndex != this.columnIndex || prevLine.controller != this.controller)
         {
            rectHeight += this.descent;
            verticalAdj = Math.floor(this.descent / 2);
         }
         return [rectHeight,verticalAdj];
      }
      
      private function makeSelectionBlocks(textLine:TextLine, begIdx:int, endIdx:int, paraAbsStart:int, blockProgression:String, direction:String, heightAndAdj:Array) : Array
      {
         var bidiBlock:Array = null;
         var bidiBlockIter:int = 0;
         var curIdx:int = 0;
         var incrementor:int = 0;
         var activeStartIndex:int = 0;
         var activeEndIndex:int = 0;
         var curElementIndex:int = 0;
         var activeEndIsBidi:Boolean = false;
         var curIsBidi:Boolean = false;
         var testILG:InlineGraphicElement = null;
         var verticalText:* = false;
         var ilgFormat:ITextLayoutFormat = null;
         var paddingTop:Number = NaN;
         var paddingBottom:Number = NaN;
         var paddingLeft:Number = NaN;
         var paddingRight:Number = NaN;
         var blockArray:Array = [];
         var blockRect:Rectangle = new Rectangle();
         var startElem:FlowLeafElement = this._para.findLeaf(begIdx);
         var startMetrics:Rectangle = startElem.getComputedFontMetrics().emBox;
         if(!textLine)
         {
            textLine = this.getTextLine(true);
         }
         var begAtomIndex:int = textLine.getAtomIndexAtCharIndex(begIdx);
         var endAtomIndex:int = this.adjustEndElementForBidi(textLine,begIdx,endIdx,begAtomIndex,direction);
         if(direction == Direction.RTL && textLine.getAtomBidiLevel(endAtomIndex) % 2 != 0)
         {
            if(endAtomIndex == 0 && begIdx < endIdx - 1)
            {
               blockArray = this.makeSelectionBlocks(textLine,begIdx,endIdx - 1,paraAbsStart,blockProgression,direction,heightAndAdj);
               bidiBlock = this.makeSelectionBlocks(textLine,endIdx - 1,endIdx - 1,paraAbsStart,blockProgression,direction,heightAndAdj);
               bidiBlockIter = 0;
               while(bidiBlockIter < bidiBlock.length)
               {
                  blockArray.push(bidiBlock[bidiBlockIter]);
                  bidiBlockIter++;
               }
               return blockArray;
            }
         }
         var begIsBidi:Boolean = begAtomIndex != -1 ? Boolean(this.isAtomBidi(textLine,begAtomIndex,direction)) : false;
         var endIsBidi:Boolean = endAtomIndex != -1 ? Boolean(this.isAtomBidi(textLine,endAtomIndex,direction)) : false;
         if(begIsBidi || endIsBidi)
         {
            curIdx = begIdx;
            incrementor = begIdx != endIdx ? 1 : 0;
            activeStartIndex = begAtomIndex;
            activeEndIndex = begAtomIndex;
            curElementIndex = begAtomIndex;
            activeEndIsBidi = begIsBidi;
            do
            {
               curIdx += incrementor;
               curElementIndex = textLine.getAtomIndexAtCharIndex(curIdx);
               curIsBidi = curElementIndex != -1 ? Boolean(this.isAtomBidi(textLine,curElementIndex,direction)) : false;
               if(curElementIndex != -1 && curIsBidi != activeEndIsBidi)
               {
                  blockRect = this.makeBlock(textLine,curIdx,activeStartIndex,activeEndIndex,startMetrics,blockProgression,direction,heightAndAdj);
                  blockArray.push(blockRect);
                  activeStartIndex = curElementIndex;
                  activeEndIndex = curElementIndex;
                  activeEndIsBidi = curIsBidi;
               }
               else
               {
                  if(curIdx == endIdx)
                  {
                     blockRect = this.makeBlock(textLine,curIdx,activeStartIndex,activeEndIndex,startMetrics,blockProgression,direction,heightAndAdj);
                     blockArray.push(blockRect);
                  }
                  activeEndIndex = curElementIndex;
               }
            }
            while(curIdx < endIdx);
            
         }
         else
         {
            testILG = startElem as InlineGraphicElement;
            if(!testILG || testILG.effectiveFloat == Float.NONE || begIdx == endIdx)
            {
               blockRect = this.makeBlock(textLine,begIdx,begAtomIndex,endAtomIndex,startMetrics,blockProgression,direction,heightAndAdj);
               if(testILG && testILG.elementWidthWithMarginsAndPadding() != testILG.elementWidth)
               {
                  verticalText = testILG.getTextFlow().computedFormat.blockProgression == BlockProgression.RL;
                  ilgFormat = testILG.computedFormat;
                  if(verticalText)
                  {
                     paddingTop = testILG.getEffectivePaddingTop();
                     blockRect.top += paddingTop;
                     paddingBottom = testILG.getEffectivePaddingBottom();
                     blockRect.bottom -= paddingBottom;
                  }
                  else
                  {
                     paddingLeft = testILG.getEffectivePaddingLeft();
                     blockRect.left += paddingLeft;
                     paddingRight = testILG.getEffectivePaddingRight();
                     blockRect.right -= paddingRight;
                  }
               }
            }
            else
            {
               blockRect = testILG.graphic.getBounds(textLine);
            }
            blockArray.push(blockRect);
         }
         return blockArray;
      }
      
      private function makeBlock(textLine:TextLine, begTextIndex:int, begAtomIndex:int, endAtomIndex:int, startMetrics:Rectangle, blockProgression:String, direction:String, heightAndAdj:Array) : Rectangle
      {
         var rotation:String = null;
         var tempEndIdx:int = 0;
         var blockRect:Rectangle = new Rectangle();
         var globalStart:Point = new Point(0,0);
         if(begAtomIndex > endAtomIndex)
         {
            tempEndIdx = endAtomIndex;
            endAtomIndex = begAtomIndex;
            begAtomIndex = tempEndIdx;
         }
         if(!textLine)
         {
            textLine = this.getTextLine(true);
         }
         var begCharRect:Rectangle = textLine.getAtomBounds(begAtomIndex);
         var endCharRect:Rectangle = textLine.getAtomBounds(endAtomIndex);
         var justRule:String = this._para.getEffectiveJustificationRule();
         if(blockProgression == BlockProgression.RL && textLine.getAtomTextRotation(begAtomIndex) != TextRotation.ROTATE_0)
         {
            globalStart.y = begCharRect.y;
            blockRect.height = begAtomIndex != endAtomIndex ? Number(endCharRect.bottom - begCharRect.top) : Number(begCharRect.height);
            if(justRule == JustificationRule.EAST_ASIAN)
            {
               blockRect.width = begCharRect.width;
            }
            else
            {
               blockRect.width = heightAndAdj[0];
               globalStart.x -= heightAndAdj[1];
            }
         }
         else
         {
            globalStart.x = Math.min(begCharRect.x,endCharRect.x);
            if(blockProgression == BlockProgression.RL)
            {
               globalStart.y = begCharRect.y + startMetrics.width / 2;
            }
            if(justRule != JustificationRule.EAST_ASIAN)
            {
               blockRect.height = heightAndAdj[0];
               if(blockProgression == BlockProgression.RL)
               {
                  globalStart.x -= heightAndAdj[1];
               }
               else
               {
                  globalStart.y += heightAndAdj[1];
               }
               blockRect.width = begAtomIndex != endAtomIndex ? Number(Math.abs(endCharRect.right - begCharRect.left)) : Number(begCharRect.width);
            }
            else
            {
               blockRect.height = begCharRect.height;
               blockRect.width = begAtomIndex != endAtomIndex ? Number(Math.abs(endCharRect.right - begCharRect.left)) : Number(begCharRect.width);
            }
         }
         blockRect.x = globalStart.x;
         blockRect.y = globalStart.y;
         if(blockProgression == BlockProgression.RL)
         {
            if(textLine.getAtomTextRotation(begAtomIndex) != TextRotation.ROTATE_0)
            {
               blockRect.x -= textLine.descent;
            }
            else
            {
               blockRect.y -= blockRect.height / 2;
            }
         }
         else
         {
            blockRect.y += textLine.descent - blockRect.height;
         }
         var tfl:TextFlowLine = textLine.userData as TextFlowLine;
         var curElem:FlowLeafElement = this._para.findLeaf(begTextIndex);
         if(!curElem)
         {
            if(begTextIndex < 0)
            {
               curElem = this._para.getFirstLeaf();
            }
            else if(begTextIndex >= this._para.textLength)
            {
               curElem = this._para.getLastLeaf();
            }
            rotation = !!curElem ? curElem.computedFormat.textRotation : TextRotation.ROTATE_0;
         }
         else
         {
            rotation = curElem.computedFormat.textRotation;
         }
         if(rotation == TextRotation.ROTATE_180 || rotation == TextRotation.ROTATE_90)
         {
            if(blockProgression != BlockProgression.RL)
            {
               blockRect.y += blockRect.height / 2;
            }
            else if(curElem.getParentByType(TCYElement) == null)
            {
               if(rotation == TextRotation.ROTATE_90)
               {
                  blockRect.x -= blockRect.width;
               }
               else
               {
                  blockRect.x -= blockRect.width * 0.75;
               }
            }
            else if(rotation == TextRotation.ROTATE_90)
            {
               blockRect.y += blockRect.height;
            }
            else
            {
               blockRect.y += blockRect.height * 0.75;
            }
         }
         return blockRect;
      }
      
      tlf_internal function convertLineRectToContainer(rect:Rectangle, constrainShape:Boolean) : void
      {
         var tf:TextFlow = null;
         var columnRect:Rectangle = null;
         var textLine:TextLine = this.getTextLine();
         rect.x += textLine.x;
         rect.y += textLine.y;
         if(constrainShape)
         {
            tf = this._para.getTextFlow();
            columnRect = this.controller.columnState.getColumnAt(this.columnIndex);
            constrainRectToColumn(tf,rect,columnRect,this.controller.horizontalScrollPosition,this.controller.verticalScrollPosition,this.controller.compositionWidth,this.controller.compositionHeight);
         }
      }
      
      tlf_internal function hiliteBlockSelection(selObj:Shape, selFormat:SelectionFormat, container:DisplayObject, begIdx:int, endIdx:int, prevLine:TextFlowLine, nextLine:TextFlowLine) : void
      {
         if(this.isDamaged() || !this._controller)
         {
            return;
         }
         var textLine:TextLine = this.peekTextLine();
         if(!textLine || !textLine.parent)
         {
            return;
         }
         var paraStart:int = this._para.getTextBlockAbsoluteStart(textLine.textBlock);
         begIdx -= paraStart;
         endIdx -= paraStart;
         this.createSelectionShapes(selObj,selFormat,container,begIdx,endIdx,prevLine,nextLine);
      }
      
      tlf_internal function hilitePointSelection(selFormat:SelectionFormat, idx:int, container:DisplayObject, prevLine:TextFlowLine, nextLine:TextFlowLine) : void
      {
         var rect:Rectangle = this.computePointSelectionRectangle(idx,container,prevLine,nextLine,true);
         if(rect)
         {
            this._controller.drawPointSelection(selFormat,rect.x,rect.y,rect.width,rect.height);
         }
      }
      
      tlf_internal function computePointSelectionRectangle(idx:int, container:DisplayObject, prevLine:TextFlowLine, nextLine:TextFlowLine, constrainSelRect:Boolean) : Rectangle
      {
         var cursorWidth:Number = NaN;
         var prevElementIndex:int = 0;
         var rlOnePoint:Point = null;
         var onePoint:Point = null;
         if(this.isDamaged() || !this._controller)
         {
            return null;
         }
         var textLine:TextLine = this.peekTextLine();
         if(!textLine || !textLine.parent)
         {
            return null;
         }
         idx -= this._para.getTextBlockAbsoluteStart(textLine.textBlock);
         textLine = this.getTextLine(true);
         var endIdx:int = idx;
         var elementIndex:int = textLine.getAtomIndexAtCharIndex(idx);
         var isTCYBounds:Boolean = false;
         var paraLeadingTCY:Boolean = false;
         var contElement:ContainerFormattedElement = this._para.getAncestorWithContainer();
         var blockProgression:String = contElement.computedFormat.blockProgression;
         var direction:String = this._para.computedFormat.direction;
         if(blockProgression == BlockProgression.RL)
         {
            if(idx == 0)
            {
               if(textLine.getAtomTextRotation(0) == TextRotation.ROTATE_0)
               {
                  paraLeadingTCY = true;
               }
            }
            else
            {
               prevElementIndex = textLine.getAtomIndexAtCharIndex(idx - 1);
               if(prevElementIndex != -1)
               {
                  if(textLine.getAtomTextRotation(elementIndex) == TextRotation.ROTATE_0 && textLine.getAtomTextRotation(prevElementIndex) != TextRotation.ROTATE_0)
                  {
                     elementIndex = prevElementIndex;
                     idx--;
                     isTCYBounds = true;
                  }
                  else if(textLine.getAtomTextRotation(prevElementIndex) == TextRotation.ROTATE_0)
                  {
                     elementIndex = prevElementIndex;
                     idx--;
                     isTCYBounds = true;
                  }
               }
            }
         }
         var heightAndAdj:Array = this.getRomanSelectionHeightAndVerticalAdjustment(prevLine,nextLine);
         var blockRectArray:Array = this.makeSelectionBlocks(textLine,idx,endIdx,this._para.getTextBlockAbsoluteStart(textLine.textBlock),blockProgression,direction,heightAndAdj);
         var rect:Rectangle = blockRectArray[0];
         this.convertLineRectToContainer(rect,constrainSelRect);
         var drawOnRight:* = direction == Direction.RTL;
         if(drawOnRight && textLine.getAtomBidiLevel(elementIndex) % 2 == 0 || !drawOnRight && textLine.getAtomBidiLevel(elementIndex) % 2 != 0)
         {
            drawOnRight = !drawOnRight;
         }
         var zeroPoint:Point = container.localToGlobal(localZeroPoint);
         if(blockProgression == BlockProgression.RL && textLine.getAtomTextRotation(elementIndex) != TextRotation.ROTATE_0)
         {
            rlOnePoint = container.localToGlobal(rlLocalOnePoint);
            cursorWidth = zeroPoint.y - rlOnePoint.y;
            cursorWidth = cursorWidth == 0 ? Number(1) : Number(Math.abs(1 / cursorWidth));
            if(!drawOnRight)
            {
               setRectangleValues(rect,rect.x,!isTCYBounds ? Number(rect.y) : Number(rect.y + rect.height),rect.width,cursorWidth);
            }
            else
            {
               setRectangleValues(rect,rect.x,!isTCYBounds ? Number(rect.y + rect.height) : Number(rect.y),rect.width,cursorWidth);
            }
         }
         else
         {
            onePoint = container.localToGlobal(localOnePoint);
            cursorWidth = zeroPoint.x - onePoint.x;
            cursorWidth = cursorWidth == 0 ? Number(1) : Number(Math.abs(1 / cursorWidth));
            if(!drawOnRight)
            {
               setRectangleValues(rect,!isTCYBounds ? Number(rect.x) : Number(rect.x + rect.width),rect.y,cursorWidth,rect.height);
            }
            else
            {
               setRectangleValues(rect,!isTCYBounds ? Number(rect.x + rect.width) : Number(rect.x),rect.y,cursorWidth,rect.height);
            }
         }
         return rect;
      }
      
      tlf_internal function selectionWillIntersectScrollRect(scrollRect:Rectangle, begIdx:int, endIdx:int, prevLine:TextFlowLine, nextLine:TextFlowLine) : int
      {
         var pointSelRect:Rectangle = null;
         var paraStart:int = 0;
         var selCache:SelectionCache = null;
         var drawRect:Rectangle = null;
         var contElement:ContainerFormattedElement = this._para.getAncestorWithContainer();
         var blockProgression:String = contElement.computedFormat.blockProgression;
         var textLine:TextLine = this.getTextLine(true);
         if(begIdx == endIdx)
         {
            pointSelRect = this.computePointSelectionRectangle(begIdx,DisplayObject(this.controller.container),prevLine,nextLine,false);
            if(pointSelRect)
            {
               if(scrollRect.containsRect(pointSelRect))
               {
                  return 2;
               }
               if(scrollRect.intersects(pointSelRect))
               {
                  return 1;
               }
            }
         }
         else
         {
            if(textLine)
            {
               paraStart = this._para.getTextBlockAbsoluteStart(textLine.textBlock);
            }
            else
            {
               paraStart = this._para.getAbsoluteStart();
            }
            selCache = this.getSelectionShapesCacheEntry(begIdx - paraStart,endIdx - paraStart,prevLine,nextLine,blockProgression);
            if(selCache)
            {
               for each(drawRect in selCache.selectionBlocks)
               {
                  drawRect = drawRect.clone();
                  drawRect.x += textLine.x;
                  drawRect.y += textLine.y;
                  if(scrollRect.intersects(drawRect))
                  {
                     if(blockProgression == BlockProgression.RL)
                     {
                        if(drawRect.left >= scrollRect.left && drawRect.right <= scrollRect.right)
                        {
                           return 2;
                        }
                     }
                     else if(drawRect.top >= scrollRect.top && drawRect.bottom <= scrollRect.bottom)
                     {
                        return 2;
                     }
                     return 1;
                  }
               }
            }
         }
         return 0;
      }
      
      private function normalizeRects(srcRects:Array, dstRects:Array, largestRise:Number, blockProgression:String, direction:String) : void
      {
         var rect:Rectangle = null;
         var lastRect:Rectangle = null;
         var rectIter:int = 0;
         while(rectIter < srcRects.length)
         {
            rect = srcRects[rectIter++];
            if(blockProgression == BlockProgression.RL)
            {
               if(rect.width < largestRise)
               {
                  rect.width = largestRise;
               }
            }
            else if(rect.height < largestRise)
            {
               rect.height = largestRise;
            }
            if(lastRect == null)
            {
               lastRect = rect;
            }
            else if(blockProgression == BlockProgression.RL)
            {
               if(lastRect.y < rect.y && lastRect.y + lastRect.height >= rect.top && lastRect.x == rect.x)
               {
                  lastRect.height += rect.height;
               }
               else if(rect.y < lastRect.y && lastRect.y <= rect.bottom && lastRect.x == rect.x)
               {
                  lastRect.height += rect.height;
                  lastRect.y = rect.y;
               }
               else
               {
                  dstRects.push(lastRect);
                  lastRect = rect;
               }
            }
            else if(lastRect.x < rect.x && lastRect.x + lastRect.width >= rect.left && lastRect.y == rect.y)
            {
               lastRect.width += rect.width;
            }
            else if(rect.x < lastRect.x && lastRect.x <= rect.right && lastRect.y == rect.y)
            {
               lastRect.width += rect.width;
               lastRect.x = rect.x;
            }
            else
            {
               dstRects.push(lastRect);
               lastRect = rect;
            }
            if(rectIter == srcRects.length)
            {
               dstRects.push(lastRect);
            }
         }
      }
      
      private function adjustEndElementForBidi(textLine:TextLine, begIdx:int, endIdx:int, begAtomIndex:int, direction:String) : int
      {
         var endAtomIndex:int = begAtomIndex;
         if(endIdx != begIdx)
         {
            if((direction == Direction.LTR && textLine.getAtomBidiLevel(begAtomIndex) % 2 != 0 || direction == Direction.RTL && textLine.getAtomBidiLevel(begAtomIndex) % 2 == 0) && textLine.getAtomTextRotation(begAtomIndex) != TextRotation.ROTATE_0)
            {
               endAtomIndex = textLine.getAtomIndexAtCharIndex(endIdx);
            }
            else
            {
               endAtomIndex = textLine.getAtomIndexAtCharIndex(endIdx - 1);
            }
         }
         if(endAtomIndex == -1 && endIdx > 0)
         {
            return this.adjustEndElementForBidi(textLine,begIdx,endIdx - 1,begAtomIndex,direction);
         }
         return endAtomIndex;
      }
      
      private function isAtomBidi(textLine:TextLine, elementIdx:int, direction:String) : Boolean
      {
         if(!textLine)
         {
            textLine = this.getTextLine(true);
         }
         return textLine.getAtomBidiLevel(elementIdx) % 2 != 0 && direction == Direction.LTR || textLine.getAtomBidiLevel(elementIdx) % 2 == 0 && direction == Direction.RTL;
      }
      
      tlf_internal function get adornCount() : int
      {
         return this._adornCount;
      }
   }
}

import flash.geom.Rectangle;

final class SelectionCache
{
    
   
   private var _begIdx:int = -1;
   
   private var _endIdx:int = -1;
   
   private var _selectionBlocks:Array = null;
   
   function SelectionCache()
   {
      super();
   }
   
   public function get begIdx() : int
   {
      return this._begIdx;
   }
   
   public function set begIdx(val:int) : void
   {
      this._begIdx = val;
   }
   
   public function get endIdx() : int
   {
      return this._endIdx;
   }
   
   public function set endIdx(val:int) : void
   {
      this._endIdx = val;
   }
   
   public function pushSelectionBlock(drawRect:Rectangle) : void
   {
      if(!this._selectionBlocks)
      {
         this._selectionBlocks = new Array();
      }
      this._selectionBlocks.push(drawRect.clone());
   }
   
   public function get selectionBlocks() : Array
   {
      return this._selectionBlocks;
   }
   
   public function clear() : void
   {
      this._selectionBlocks = null;
      this._begIdx = -1;
      this._endIdx = -1;
   }
}

import flashx.textLayout.elements.BackgroundManager;
import flashx.textLayout.formats.ITextLayoutFormat;

class NumberLineUserData
{
    
   
   public var listStylePosition:String;
   
   public var insideLineWidth:Number;
   
   public var spanFormat:ITextLayoutFormat;
   
   public var paragraphDirection:String;
   
   public var listEndIndent:Number;
   
   public var backgroundManager:BackgroundManager;
   
   function NumberLineUserData(listStylePosition:String, insideLineWidth:Number, spanFormat:ITextLayoutFormat, paraDirection:String)
   {
      super();
      this.listStylePosition = listStylePosition;
      this.insideLineWidth = insideLineWidth;
      this.spanFormat = spanFormat;
      this.paragraphDirection = paraDirection;
   }
}

import flash.geom.Rectangle;
import flash.text.engine.TextBlock;
import flash.text.engine.TextLine;
import flash.text.engine.TextLineValidity;
import flashx.textLayout.elements.BackgroundManager;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.factory.StringTextLineFactory;
import flashx.textLayout.formats.BlockProgression;
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class NumberLineFactory extends StringTextLineFactory
{
    
   
   private var _listStylePosition:String;
   
   private var _markerFormat:ITextLayoutFormat;
   
   private var _backgroundManager:BackgroundManager;
   
   function NumberLineFactory()
   {
      super();
   }
   
   tlf_internal static function calculateInsideNumberLineWidth(numberLine:TextLine, bp:String) : Number
   {
      var rect:Rectangle = null;
      var minVal:Number = Number.MAX_VALUE;
      var maxVal:Number = Number.MIN_VALUE;
      var idx:int = 0;
      if(bp == BlockProgression.TB)
      {
         while(idx < numberLine.atomCount)
         {
            if(numberLine.getAtomTextBlockBeginIndex(idx) != numberLine.rawTextLength - 1)
            {
               rect = numberLine.getAtomBounds(idx);
               minVal = Math.min(minVal,rect.x);
               maxVal = Math.max(maxVal,rect.right);
            }
            idx++;
         }
      }
      else
      {
         while(idx < numberLine.atomCount)
         {
            if(numberLine.getAtomTextBlockBeginIndex(idx) != numberLine.rawTextLength - 1)
            {
               rect = numberLine.getAtomBounds(idx);
               minVal = Math.min(minVal,rect.top);
               maxVal = Math.max(maxVal,rect.bottom);
            }
            idx++;
         }
      }
      return maxVal > minVal ? Number(maxVal - minVal) : Number(0);
   }
   
   public function get listStylePosition() : String
   {
      return this._listStylePosition;
   }
   
   public function set listStylePosition(val:String) : void
   {
      this._listStylePosition = val;
   }
   
   public function get markerFormat() : ITextLayoutFormat
   {
      return this._markerFormat;
   }
   
   public function set markerFormat(val:ITextLayoutFormat) : void
   {
      this._markerFormat = val;
      spanFormat = val;
   }
   
   public function get backgroundManager() : BackgroundManager
   {
      return this._backgroundManager;
   }
   
   public function clearBackgroundManager() : void
   {
      this._backgroundManager = null;
   }
   
   override protected function callbackWithTextLines(callback:Function, delx:Number, dely:Number) : void
   {
      var textLine:TextLine = null;
      var textBlock:TextBlock = null;
      for each(textLine in tlf_internal::_factoryComposer._lines)
      {
         textLine.userData = new NumberLineUserData(this.listStylePosition,calculateInsideNumberLineWidth(textLine,textFlowFormat.blockProgression),this._markerFormat,paragraphFormat.direction);
         textBlock = textLine.textBlock;
         if(textBlock)
         {
            textBlock.releaseLines(textBlock.firstLine,textBlock.lastLine);
         }
         textLine.x += delx;
         textLine.y += dely;
         textLine.validity = TextLineValidity.STATIC;
         callback(textLine);
      }
   }
   
   override tlf_internal function processBackgroundColors(textFlow:TextFlow, callback:Function, x:Number, y:Number, constrainWidth:Number, constrainHeight:Number) : *
   {
      this._backgroundManager = textFlow.backgroundManager;
      textFlow.clearBackgroundManager();
   }
}
