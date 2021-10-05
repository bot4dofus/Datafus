package flashx.textLayout.compose
{
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineCreationResult;
   import flash.utils.Dictionary;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.OverflowPolicy;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableColElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.BaselineOffset;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.BreakStyle;
   import flashx.textLayout.formats.ClearFloats;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.formats.ListStylePosition;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.LocaleUtil;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class BaseCompose
   {
      
      private static var _savedAlignData:AlignData;
      
      protected static var _savedLineSlug:Slug;
      
      protected static var _floatSlug:Slug;
       
      
      protected var _parcelList:ParcelList;
      
      private var _correctTextLength:Boolean = false;
      
      protected var _curElement:FlowLeafElement;
      
      protected var _curElementStart:int;
      
      protected var _curElementOffset:int;
      
      protected var _curParaElement:ParagraphElement;
      
      protected var _curParaFormat:ITextLayoutFormat;
      
      protected var _curParaStart:int;
      
      protected var _curLineStart:int;
      
      private var _curLineLeadingModel:String = "";
      
      private var _curLineLeading:Number;
      
      protected var _lastLineLeadingModel:String = "";
      
      protected var _lastLineLeading:Number;
      
      protected var _lastLineDescent:Number;
      
      protected var _paragraphSpaceCarried:Number;
      
      protected var _verticalSpaceCarried:Number;
      
      protected var _blockProgression:String;
      
      protected var _atColumnStart:Boolean;
      
      protected var _textIndent:Number;
      
      private var _controllerLeft:Number;
      
      private var _controllerTop:Number;
      
      private var _controllerRight:Number;
      
      private var _controllerBottom:Number;
      
      protected var _contentLogicalExtent:Number;
      
      protected var _contentCommittedExtent:Number;
      
      protected var _contentCommittedHeight:Number;
      
      protected var _workingContentLogicalExtent:Number;
      
      protected var _workingContentExtent:Number;
      
      protected var _workingContentHeight:Number;
      
      protected var _workingTotalDepth:Number;
      
      protected var _workingParcelIndex:int;
      
      protected var _workingParcelLogicalTop:Number;
      
      protected var _accumulatedMinimumStart:Number;
      
      protected var _parcelLogicalTop:Number;
      
      protected var _parcelLeft:Number;
      
      protected var _parcelTop:Number;
      
      protected var _parcelRight:Number;
      
      protected var _parcelBottom:Number;
      
      protected var _textFlow:TextFlow;
      
      private var _releaseLineCreationData:Boolean;
      
      protected var _flowComposer:IFlowComposer;
      
      protected var _rootElement:ContainerFormattedElement;
      
      protected var _stopComposePos:int;
      
      protected var _startController:ContainerController;
      
      protected var _startComposePosition:int;
      
      protected var _controllerVisibleBoundsXTW:int;
      
      protected var _controllerVisibleBoundsYTW:int;
      
      protected var _controllerVisibleBoundsWidthTW:int;
      
      protected var _controllerVisibleBoundsHeightTW:int;
      
      protected var _forceILGs:Boolean;
      
      protected var _lastGoodStart:int;
      
      protected var _linePass:int;
      
      protected var _paragraphContainsVisibleLines:Boolean;
      
      protected var _lineSlug:Slug;
      
      protected var _pushInFloats:Array;
      
      private var _alignLines:Array;
      
      protected var _curParcel:Parcel;
      
      protected var _curParcelStart:int;
      
      protected var _curInteractiveObjects:Dictionary = null;
      
      protected var _measuring:Boolean;
      
      protected var _curLine:TextFlowLine;
      
      protected var _previousLine:TextLine;
      
      protected var _listItemElement:ListItemElement;
      
      private var _firstLineDescentAndLeading:Number;
      
      public function BaseCompose()
      {
         this._lineSlug = new Slug();
         super();
      }
      
      public static function get globalSWFContext() : ISWFContext
      {
         return GlobalSWFContext.globalSWFContext;
      }
      
      private static function createAlignData(tfl:TextFlowLine) : AlignData
      {
         var rslt:AlignData = null;
         if(_savedAlignData)
         {
            rslt = _savedAlignData;
            rslt.textFlowLine = tfl;
            _savedAlignData = null;
            return rslt;
         }
         return new AlignData(tfl);
      }
      
      private static function releaseAlignData(ad:AlignData) : void
      {
         ad.textLine = null;
         ad.textFlowLine = null;
         _savedAlignData = ad;
      }
      
      tlf_internal static function computeNumberLineAlignment(alignData:AlignData, textLineWidth:Number, textLineOffset:Number, numberLine:TextLine, coord:Number, delta:Number, extraSpace:Number) : Number
      {
         var rslt:Number = NaN;
         if(alignData.textAlign == TextAlign.CENTER)
         {
            if(TextFlowLine.getNumberLineParagraphDirection(numberLine) == Direction.LTR)
            {
               rslt = -(numberLine.textWidth + TextFlowLine.getListEndIndent(numberLine) + delta) - alignData.textIndent;
            }
            else
            {
               rslt = textLineWidth + TextFlowLine.getListEndIndent(numberLine) + (TextFlowLine.getNumberLineInsideLineWidth(numberLine) - numberLine.textWidth) + (coord - delta + extraSpace - textLineOffset) + alignData.textIndent;
            }
         }
         else if(alignData.textAlign == TextAlign.RIGHT)
         {
            if(TextFlowLine.getNumberLineParagraphDirection(numberLine) == Direction.LTR)
            {
               rslt = -(numberLine.textWidth + TextFlowLine.getListEndIndent(numberLine) + delta) - alignData.textIndent;
            }
            else
            {
               rslt = textLineWidth + TextFlowLine.getListEndIndent(numberLine) + (TextFlowLine.getNumberLineInsideLineWidth(numberLine) - numberLine.textWidth) + alignData.textIndent;
            }
         }
         else if(TextFlowLine.getNumberLineParagraphDirection(numberLine) == Direction.LTR)
         {
            rslt = -(numberLine.textWidth + TextFlowLine.getListEndIndent(numberLine)) - alignData.textIndent;
         }
         else
         {
            rslt = textLineWidth + TextFlowLine.getListEndIndent(numberLine) + (TextFlowLine.getNumberLineInsideLineWidth(numberLine) - numberLine.textWidth) + (coord - textLineOffset) + alignData.textIndent;
         }
         return rslt;
      }
      
      public function get parcelList() : ParcelList
      {
         return this._parcelList;
      }
      
      protected function createParcelList() : ParcelList
      {
         return null;
      }
      
      protected function releaseParcelList(list:ParcelList) : void
      {
      }
      
      public function get startController() : ContainerController
      {
         return this._startController;
      }
      
      tlf_internal function releaseAnyReferences() : void
      {
         this._curElement = null;
         this._curParaElement = null;
         this._curParaFormat = null;
         this._flowComposer = null;
         this._parcelList = null;
         this._rootElement = null;
         this._startController = null;
         this._textFlow = null;
         this._previousLine = null;
         this._curLine = null;
      }
      
      protected function initializeForComposer(composer:IFlowComposer, composeToPosition:int, controllerStartIndex:int, controllerEndIndex:int) : void
      {
         if(!_savedLineSlug)
         {
            this._lineSlug = new Slug();
         }
         else
         {
            this._lineSlug = _savedLineSlug;
            _savedLineSlug = null;
         }
         this._parcelList = this.createParcelList();
         this._paragraphSpaceCarried = 0;
         this._blockProgression = composer.rootElement.computedFormat.blockProgression;
         this._stopComposePos = composeToPosition >= 0 ? int(Math.min(this._textFlow.textLength,composeToPosition)) : int(this._textFlow.textLength);
         if(controllerStartIndex < 0)
         {
            controllerStartIndex = 0;
         }
         this._parcelList.beginCompose(composer,controllerStartIndex,controllerEndIndex,composeToPosition > 0);
         this._contentLogicalExtent = 0;
         this._contentCommittedExtent = 0;
         this._contentCommittedHeight = 0;
         this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
         this._parcelLogicalTop = NaN;
         this._linePass = 0;
         this._lastGoodStart = -1;
         if(this._pushInFloats)
         {
            this._pushInFloats.length = 0;
         }
         this._listItemElement = null;
      }
      
      private function composeBlockElement(elem:FlowGroupElement, absStart:int, isInTable:Boolean = false, startChildIdx:int = -1) : Boolean
      {
         var child:FlowElement = null;
         var rslt:Boolean = false;
         var tableCell:TableCellElement = null;
         var table:TableElement = null;
         var previousElement:FlowLeafElement = null;
         var previousParagraph:ParagraphElement = null;
         var boxLeftIndent:Number = NaN;
         var boxRightIndent:Number = NaN;
         var boxTopIndent:Number = NaN;
         var boxBottomIndent:Number = NaN;
         var para:ParagraphElement = null;
         var adjustedDepth:Number = NaN;
         var savedListItemElement:ListItemElement = null;
         var isInTableCell:Boolean = elem is TextFlow && TextFlow(elem).parentElement is TableCellElement ? true : false;
         var cellSpacing:Number = 0;
         if(isInTableCell)
         {
            tableCell = TextFlow(elem).parentElement as TableCellElement;
            table = tableCell.table;
            cellSpacing = table.cellSpacing != undefined ? Number(table.cellSpacing) : Number(0);
         }
         var idx:int = 0;
         if(startChildIdx != -1)
         {
            idx = startChildIdx;
         }
         if(absStart != this._curElementStart + this._curElementOffset)
         {
            idx = elem.findChildIndexAtPosition(this._curElementStart + this._curElementOffset - absStart);
            child = elem.getChildAt(idx);
            absStart += child.parentRelativeStart;
            previousElement = this._textFlow.findLeaf(this._startComposePosition - 1);
            if(previousElement)
            {
               previousParagraph = previousElement.getParagraph();
               if(previousParagraph && previousParagraph != this._curElement.getParagraph())
               {
                  if(previousParagraph.paddingBottom != undefined)
                  {
                     this._parcelList.addTotalDepth(previousParagraph.paddingBottom);
                  }
               }
            }
         }
         var composeEntireElement:* = absStart == this._curElementStart + this._curElementOffset;
         while(idx < elem.numChildren && (absStart <= this._stopComposePos || !this.parcelList.atLast()))
         {
            child = elem.getChildAt(idx);
            if(child.computedFormat.clearFloats != ClearFloats.NONE)
            {
               adjustedDepth = this._curParcel.applyClear(child.computedFormat.clearFloats,this._parcelList.totalDepth,child.computedFormat.direction);
               this._parcelList.addTotalDepth(adjustedDepth);
               this._verticalSpaceCarried = 0;
            }
            if(this._blockProgression == BlockProgression.RL)
            {
               boxLeftIndent = child.getEffectivePaddingTop() + child.getEffectiveBorderTopWidth() + child.getEffectiveMarginTop();
               boxRightIndent = child.getEffectivePaddingBottom() + child.getEffectiveBorderBottomWidth() + child.getEffectiveMarginBottom();
               boxTopIndent = child.getEffectivePaddingRight() + child.getEffectiveBorderRightWidth() + child.getEffectiveMarginRight();
               boxBottomIndent = child.getEffectivePaddingLeft() + child.getEffectiveBorderLeftWidth() + child.getEffectiveMarginLeft();
            }
            else
            {
               boxLeftIndent = child.getEffectivePaddingLeft() + child.getEffectiveBorderLeftWidth() + child.getEffectiveMarginLeft();
               boxRightIndent = child.getEffectivePaddingRight() + child.getEffectiveBorderRightWidth() + child.getEffectiveMarginRight();
               boxTopIndent = child.getEffectivePaddingTop() + child.getEffectiveBorderTopWidth() + child.getEffectiveMarginTop();
               boxBottomIndent = child.getEffectivePaddingBottom() + child.getEffectiveBorderBottomWidth() + child.getEffectiveMarginBottom();
               if(isInTableCell)
               {
                  boxLeftIndent += cellSpacing;
                  boxRightIndent += cellSpacing;
                  boxTopIndent += cellSpacing;
                  boxBottomIndent += cellSpacing;
               }
            }
            this._parcelList.pushLeftMargin(boxLeftIndent);
            this._parcelList.pushRightMargin(boxRightIndent);
            if(composeEntireElement && boxTopIndent > this._verticalSpaceCarried)
            {
               this._parcelList.addTotalDepth(boxTopIndent - this._verticalSpaceCarried);
            }
            this._verticalSpaceCarried = Math.max(boxTopIndent,0);
            para = child as ParagraphElement;
            if(para)
            {
               if(!this._atColumnStart && para.computedFormat.columnBreakBefore == BreakStyle.ALWAYS)
               {
                  this.advanceToNextParcel();
               }
               if(!(this._atColumnStart && this._parcelList.currentParcel != null && this._parcelList.currentParcel.columnIndex == 0) && para.computedFormat.containerBreakBefore == BreakStyle.ALWAYS)
               {
                  this.advanceToNextContainer();
               }
               if(!this.composeParagraphElement(para,absStart))
               {
                  BackgroundManager.collectBlock(this._textFlow,elem);
                  return false;
               }
               if(!(this._atColumnStart && this._parcelList.currentParcel != null && this._parcelList.currentParcel.columnIndex == 0) && para.computedFormat.containerBreakAfter == BreakStyle.ALWAYS)
               {
                  this.advanceToNextContainer();
               }
               if(!this._atColumnStart && para.computedFormat.columnBreakAfter == BreakStyle.ALWAYS)
               {
                  this.advanceToNextParcel();
               }
            }
            else if(child is ListElement)
            {
               rslt = this.composeBlockElement(FlowGroupElement(child),absStart);
               if(!rslt)
               {
                  BackgroundManager.collectBlock(this._textFlow,elem);
                  return false;
               }
            }
            else if(child is ListItemElement)
            {
               savedListItemElement = this._listItemElement;
               this._listItemElement = child as ListItemElement;
               rslt = this.composeBlockElement(FlowGroupElement(child),absStart);
               this._listItemElement = savedListItemElement;
               if(!rslt)
               {
                  BackgroundManager.collectBlock(this._textFlow,elem);
                  return false;
               }
            }
            else if(!this.composeBlockElement(FlowGroupElement(child),absStart))
            {
               BackgroundManager.collectBlock(this._textFlow,elem);
               return false;
            }
            if(boxBottomIndent > this._verticalSpaceCarried)
            {
               this._parcelList.addTotalDepth(boxBottomIndent - this._verticalSpaceCarried);
            }
            this._verticalSpaceCarried = Math.max(boxBottomIndent,0);
            this._parcelList.popLeftMargin(boxLeftIndent);
            this._parcelList.popRightMargin(boxRightIndent);
            composeEntireElement = true;
            absStart += child.textLength;
            idx++;
         }
         if(!(elem is TableElement || elem is TableRowElement || elem is TableCellElement))
         {
            BackgroundManager.collectBlock(this._textFlow,elem);
         }
         return true;
      }
      
      private function composeTableElement(tableElement:TableElement, absStart:int) : Boolean
      {
         var spaceBefore:Number = NaN;
         var rIdx:int = 0;
         var curRowElem:TableRowElement = null;
         var rowHeight:Number = NaN;
         var minRowHeight:Number = NaN;
         var cell:TableCellElement = null;
         var col:TableColElement = null;
         if(this._curLine && this._curLine.paragraph == this._curParaElement)
         {
            spaceBefore = 0;
         }
         else
         {
            spaceBefore = !!isNaN(this._curParaElement.computedFormat.paragraphSpaceBefore) ? Number(0) : Number(this._curParaElement.computedFormat.paragraphSpaceBefore);
         }
         spaceBefore = !!this._atColumnStart ? Number(0) : Number(spaceBefore);
         var spaceCarried:Number = !!this._atColumnStart ? Number(0) : Number(this._paragraphSpaceCarried);
         if(spaceBefore != 0 || spaceCarried != 0)
         {
            this._parcelList.addTotalDepth(Math.max(spaceBefore,spaceCarried));
         }
         this._paragraphSpaceCarried = 0;
         if(this._verticalSpaceCarried != 0)
         {
            this._verticalSpaceCarried = 0;
         }
         this._parcelList.getLineSlug(this._lineSlug,0,1,this._textIndent,this._curParaFormat.direction == Direction.LTR);
         tableElement.normalizeColumnWidths(this._lineSlug.width);
         tableElement.composeCells();
         var headerHeight:Number = tableElement.getHeaderHeight();
         var footerHeight:Number = tableElement.getFooterHeight();
         var totalRowHeight:Number = 0;
         var haveRealRows:Boolean = false;
         var headerRows:Vector.<Vector.<TableCellElement>> = tableElement.getHeaderRows();
         var footerRows:Vector.<Vector.<TableCellElement>> = tableElement.getFooterRows();
         var curRow:Vector.<TableCellElement> = tableElement.getNextRow();
         var curTableBlock:TextFlowTableBlock = tableElement.getFirstBlock();
         curTableBlock.clear();
         curTableBlock.y = this._parcelList.totalDepth;
         var adjustTop:Number = !!isNaN(this._lastLineDescent) ? Number(0) : Number(this._lastLineDescent);
         curTableBlock.y += adjustTop;
         curTableBlock.x = this._lineSlug.leftMargin;
         var lineOffset:Number = this._curParaFormat.direction == Direction.LTR ? Number(this._lineSlug.leftMargin) : Number(this._lineSlug.rightMargin);
         curTableBlock.initialize(this._curParaElement,this._lineSlug.width,lineOffset - this._parcelList.insideListItemMargin,tableElement.getAbsoluteStart(),1);
         var blockToAdd:Boolean = true;
         while(curRow)
         {
            rIdx = curRow[0].rowIndex;
            curRowElem = tableElement.getRowAt(rIdx);
            rowHeight = curRowElem.composedHeight;
            minRowHeight = curRowElem.totalHeight;
            while(false)
            {
               curTableBlock.height = totalRowHeight;
               if(!haveRealRows)
               {
                  curTableBlock.clear();
               }
               this.endTableBlock(curTableBlock);
               blockToAdd = false;
               if(!this._parcelList.next())
               {
                  break;
               }
               this._parcelList.getLineSlug(this._lineSlug,0,1,this._textIndent,this._curParaFormat.direction == Direction.LTR);
               curTableBlock = tableElement.getNextBlock();
               blockToAdd = true;
               curTableBlock.clear();
               curTableBlock.y = this._parcelList.totalDepth;
               curTableBlock.x = this._lineSlug.leftMargin;
               curTableBlock.initialize(this._curParaElement,this._lineSlug.width,lineOffset - this._parcelList.insideListItemMargin,tableElement.getAbsoluteStart(),1);
               totalRowHeight = 0;
               if(this._parcelList.currentParcel == null)
               {
                  blockToAdd = false;
                  break;
               }
            }
            if(this._parcelList.currentParcel == null)
            {
               blockToAdd = false;
               break;
            }
            for each(cell in curRow)
            {
               cell.y = totalRowHeight;
               col = tableElement.getColumnAt(cell.colIndex);
               if(col)
               {
                  cell.x = col.x;
               }
               tableElement.addCellToBlock(cell,curTableBlock);
            }
            this._parcelList.addTotalDepth(rowHeight);
            curRow = tableElement.getNextRow();
            totalRowHeight += rowHeight;
         }
         if(this._parcelList.currentParcel && blockToAdd)
         {
            curTableBlock.height = totalRowHeight;
            this.endTableBlock(curTableBlock);
         }
         return true;
      }
      
      protected function endTableBlock(block:TextFlowTableBlock) : void
      {
         this._curLine = block;
         block.setController(this._curParcel.controller,this._curParcel.columnIndex);
         BackgroundManager.collectTableBlock(this._textFlow,block,this._parcelList.currentParcel.controller);
         this._contentCommittedExtent = Math.max(this._contentCommittedExtent,this._workingContentExtent);
         this._contentCommittedHeight = Math.max(this._contentCommittedHeight,this._workingContentHeight);
         this._contentLogicalExtent = Math.max(this._contentLogicalExtent,this._workingContentLogicalExtent);
         if(!this._measuring)
         {
            this._contentLogicalExtent = this._contentCommittedExtent;
         }
         if(this._pushInFloats)
         {
            this._pushInFloats.length = 0;
         }
         this._atColumnStart = false;
         this._linePass = 0;
         if(!isNaN(this._workingParcelLogicalTop))
         {
            this._parcelLogicalTop = this._workingParcelLogicalTop;
         }
      }
      
      public function composeTextFlow(textFlow:TextFlow, composeToPosition:int, controllerEndIndex:int) : int
      {
         var curElem:Object = null;
         var cidx:int = 0;
         var startLineIndex:int = 0;
         var line:TextFlowLine = null;
         var nextParcel:Parcel = null;
         this._textFlow = textFlow;
         if(this._textFlow && this._textFlow.backgroundManager)
         {
            this._textFlow.backgroundManager.clearBlockRecord();
         }
         this._releaseLineCreationData = textFlow.configuration.releaseLineCreationData && Configuration.playerEnablesArgoFeatures;
         this._flowComposer = this._textFlow.flowComposer;
         this._rootElement = textFlow;
         this._curElementOffset = 0;
         this._curElement = this._rootElement.getFirstLeaf();
         this._curElementStart = 0;
         this._curParcel = null;
         this.initializeForComposer(this._flowComposer,composeToPosition,-1,controllerEndIndex);
         this.resetControllerBounds();
         this._curElement = this._textFlow.findLeaf(this._startComposePosition);
         this._curElementStart = this._curElement.getAbsoluteStart();
         this._curElementOffset = this._startComposePosition - this._curElementStart;
         var curInteractiveObjects:Dictionary = this._startController.interactiveObjects;
         var interactiveObjects_lastTime:Array = this._startController.oldInteractiveObjects;
         interactiveObjects_lastTime.splice(0);
         for each(curElem in curInteractiveObjects)
         {
            if(curElem && (curElem as FlowElement).getAbsoluteStart() >= this._startComposePosition)
            {
               interactiveObjects_lastTime.push(curInteractiveObjects[curElem]);
               delete curInteractiveObjects[curElem];
            }
         }
         for(cidx = this._flowComposer.getControllerIndex(this._startController) + 1; cidx <= controllerEndIndex; cidx++)
         {
            curInteractiveObjects = this._flowComposer.getControllerAt(cidx).interactiveObjects;
            for each(curElem in curInteractiveObjects)
            {
               if(curElem)
               {
                  delete curInteractiveObjects[curElem];
               }
            }
            this._flowComposer.getControllerAt(cidx).clearCompositionResults();
         }
         if(this._startComposePosition <= this._startController.absoluteStart || !this.advanceToComposeStartPosition())
         {
            if(this._startComposePosition > this._startController.absoluteStart)
            {
               this._startComposePosition = this._startController.absoluteStart;
               this._curElement = this._textFlow.findLeaf(this._startComposePosition);
               this._curElementStart = this._curElement.getAbsoluteStart();
               this._curElementOffset = this._startComposePosition - this._curElementStart;
            }
            if(this._startComposePosition == this._curElement.getParagraph().getAbsoluteStart())
            {
               this._previousLine = null;
            }
            else
            {
               startLineIndex = this._flowComposer.findLineIndexAtPosition(this._startComposePosition - 1);
               line = this._flowComposer.getLineAt(startLineIndex);
               this._previousLine = line.getTextLine(true);
            }
            this.advanceToNextParcel();
            if(this._curParcel)
            {
               this._curParcel.controller.clearFloatsAt(0);
            }
         }
         this._startController.clearComposedLines(this._curElementStart + this._curElementOffset);
         this._curParcelStart = this._startController.absoluteStart;
         this.composeInternal(this._rootElement,0);
         while(!this.parcelList.atEnd())
         {
            nextParcel = this.parcelList.getParcelAt(this.parcelList.currentParcelIndex + 1);
            this.advanceToNextParcel();
            this._correctTextLength = false;
         }
         this.parcelHasChanged(null);
         this.releaseParcelList(this._parcelList);
         this._parcelList = null;
         _savedLineSlug = this._lineSlug;
         return this._curElementStart + this._curElementOffset;
      }
      
      private function advanceToComposeStartPosition() : Boolean
      {
         var numFloats:int = 0;
         var floatInfo:FloatCompositionData = null;
         var ilg:InlineGraphicElement = null;
         var logicalHeight:Number = NaN;
         var startLineIndex:int = this._flowComposer.findLineIndexAtPosition(this._startComposePosition - 1);
         var curLine:TextFlowLine = this._flowComposer.getLineAt(startLineIndex);
         if(curLine.controller && curLine.controller.numFloats)
         {
            if(this._measuring)
            {
               return false;
            }
         }
         this._curLine = curLine;
         var previousElement:FlowLeafElement = this._curElementOffset == 0 ? this._curElement.getPreviousLeaf() : this._curElement;
         this._curLineLeadingModel = previousElement.getParagraph().getEffectiveLeadingModel();
         var curElem:FlowLeafElement = this._textFlow.findLeaf(this._curLine.absoluteStart);
         var curElemStart:int = curElem.getAbsoluteStart();
         this.calculateLeadingParameters(curElem,curElemStart,TextFlowLine.findNumberLine(this._curLine.getTextLine()));
         if(this._startComposePosition == this._curElement.getParagraph().getAbsoluteStart())
         {
            this._previousLine = null;
         }
         else
         {
            this._previousLine = this._curLine.getTextLine(true);
         }
         this._paragraphSpaceCarried = this._curLine.spaceAfter;
         this.commitLastLineState(this._curLine);
         var startParcel:int = this._curLine.columnIndex == -1 ? 0 : int(this._curLine.columnIndex);
         this._curParcel = this._parcelList.currentParcel;
         var floatIndex:int = 0;
         for(var parcelIndex:int = -1; parcelIndex < startParcel; parcelIndex++)
         {
            this.advanceToNextParcel();
            this._curParcelStart = this._curParcel.controller.absoluteStart;
            numFloats = this._curParcel.controller.numFloats;
            if(numFloats)
            {
               while(floatIndex < numFloats)
               {
                  floatInfo = this._curParcel.controller.getFloatAt(floatIndex);
                  if(floatInfo.columnIndex > this._curParcel.columnIndex)
                  {
                     break;
                  }
                  if(floatInfo.floatType != Float.NONE && floatInfo.absolutePosition < this._startComposePosition)
                  {
                     ilg = this._textFlow.findLeaf(floatInfo.absolutePosition) as InlineGraphicElement;
                     logicalHeight = this._blockProgression == BlockProgression.RL ? Number(ilg.elementWidthWithMarginsAndPadding()) : Number(ilg.elementHeightWithMarginsAndPadding());
                     this._curParcel.knockOut(floatInfo.knockOutWidth,floatInfo.depth - this._lastLineDescent,floatInfo.depth + logicalHeight,floatInfo.floatType == Float.LEFT);
                  }
                  floatIndex++;
               }
            }
            this._curParcel.controller.clearFloatsAt(this._startComposePosition);
         }
         this._curParcelStart = this._curElementStart + this._curElementOffset;
         if(this._blockProgression == BlockProgression.TB)
         {
            this._parcelList.addTotalDepth(this._curLine.y + this._curLine.ascent - this._curParcel.y);
         }
         else
         {
            this._parcelList.addTotalDepth(this._curParcel.right - this._curLine.x);
         }
         this._atColumnStart = false;
         var lineIndex:int = this._flowComposer.findLineIndexAtPosition(this._startController.absoluteStart);
         this.initializeContentBounds(lineIndex,startLineIndex);
         return true;
      }
      
      private function initializeContentBounds(lineIndex:int, lastLineToCheck:int) : void
      {
         var line:TextFlowLine = null;
         var lineExtent:Number = NaN;
         var textLine:TextLine = null;
         var alignData:AlignData = null;
         var paraFormat:ITextLayoutFormat = null;
         var columnIndex:int = -1;
         this._parcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._flowComposer.getLineAt(lineIndex),null);
         if(this._measuring)
         {
            while(lineIndex <= lastLineToCheck)
            {
               line = this._flowComposer.getLineAt(lineIndex);
               if(line.columnIndex != columnIndex)
               {
                  columnIndex = line.columnIndex;
                  this._contentLogicalExtent = 0;
                  this._contentCommittedExtent = 0;
                  this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
               }
               lineExtent = line.lineExtent;
               this._contentLogicalExtent = Math.max(this._contentLogicalExtent,lineExtent);
               if(line.alignment == TextAlign.LEFT && !line.hasNumberLine)
               {
                  this._contentCommittedExtent = Math.max(this._contentCommittedExtent,lineExtent);
               }
               else
               {
                  alignData = createAlignData(line);
                  alignData.textLine = line.getTextLine(true);
                  alignData.textAlign = line.alignment;
                  paraFormat = line.paragraph.computedFormat;
                  alignData.rightSideGap = this.getRightSideGap(line,line.alignment != TextAlign.LEFT);
                  alignData.leftSideGap = this.getLeftSideGap(line);
                  alignData.textIndent = paraFormat.textIndent;
                  alignData.lineWidth = lineExtent - (alignData.rightSideGap + alignData.leftSideGap);
                  if(!this._alignLines)
                  {
                     this._alignLines = [];
                  }
                  this._alignLines.push(alignData);
               }
               lineIndex++;
            }
         }
         else
         {
            line = this._flowComposer.getLineAt(lastLineToCheck);
            this._contentLogicalExtent = this._contentCommittedExtent = line.accumulatedLineExtent;
            this._accumulatedMinimumStart = line.accumulatedMinimumStart;
            if(this._parcelList.currentParcelIndex > 0 && this._parcelList.currentParcel.columnIndex > 0)
            {
               if(this._blockProgression == BlockProgression.TB)
               {
                  this._controllerBottom = this._curParcel.controller.compositionHeight;
               }
               else
               {
                  this._controllerLeft = 0 - this._curParcel.controller.compositionWidth;
               }
               if(this._textFlow.computedFormat.direction == Direction.RTL)
               {
                  this._controllerRight = this._curParcel.controller.compositionWidth;
               }
            }
         }
      }
      
      tlf_internal function computeTextFlowLineMinimumLogicalTop(line:TextFlowLine, textLine:TextLine) : Number
      {
         var pos:int = 0;
         var leafElement:FlowLeafElement = null;
         var adjustedAscent:Number = NaN;
         var parcelTop:Number = NaN;
         var controller:ContainerController = null;
         var lineEnd:int = 0;
         var floatInfo:FloatCompositionData = null;
         if(line.hasGraphicElement)
         {
            pos = line.absoluteStart;
            leafElement = this._textFlow.findLeaf(pos);
            adjustedAscent = line.getLineTypographicAscent(leafElement,leafElement.getAbsoluteStart(),textLine);
            parcelTop = this._blockProgression == BlockProgression.RL ? Number(line.x + adjustedAscent) : Number(line.y + line.ascent - adjustedAscent);
            controller = line.controller;
            lineEnd = pos + line.textLength;
            if(controller.numFloats > 0)
            {
               while(pos < lineEnd)
               {
                  floatInfo = controller.getFloatAtPosition(pos);
                  if(!floatInfo)
                  {
                     break;
                  }
                  parcelTop = Math.min(parcelTop,floatInfo.depth);
                  pos = floatInfo.absolutePosition + 1;
               }
            }
            return parcelTop;
         }
         return NaN;
      }
      
      private function resetControllerBounds() : void
      {
         this._controllerLeft = TextLine.MAX_LINE_WIDTH;
         this._controllerTop = TextLine.MAX_LINE_WIDTH;
         this._controllerRight = -TextLine.MAX_LINE_WIDTH;
         this._controllerBottom = -TextLine.MAX_LINE_WIDTH;
      }
      
      protected function get releaseLineCreationData() : Boolean
      {
         return this._releaseLineCreationData;
      }
      
      protected function composeInternal(composeRoot:FlowGroupElement, absStart:int) : void
      {
         this.composeBlockElement(composeRoot,absStart);
      }
      
      protected function composeParagraphElement(elem:ParagraphElement, absStart:int) : Boolean
      {
         var textBlocks:Vector.<TextBlock> = null;
         var textLine:TextLine = null;
         var textBlock:TextBlock = null;
         this._curParaElement = elem;
         this._curParaStart = absStart;
         this._curLineStart = absStart;
         this._curParaFormat = elem.computedFormat;
         this._paragraphContainsVisibleLines = this._curElementStart + this._curElementOffset != this._curParaStart;
         if(this._paragraphContainsVisibleLines)
         {
            this._curLineStart = this._curElementStart + this._curElementOffset;
         }
         var success:Boolean = this.composeParagraphElementIntoLines();
         var okToRelease:Boolean = true;
         if(!this._paragraphContainsVisibleLines)
         {
            textBlocks = elem.getTextBlocks();
            for each(textBlock in textBlocks)
            {
               textLine = textBlock.lastLine;
               while(textLine && okToRelease)
               {
                  if(textLine.parent)
                  {
                     okToRelease = false;
                  }
                  textLine = textLine.previousLine;
               }
               if(okToRelease)
               {
                  textLine = textBlock.lastLine;
                  while(textLine)
                  {
                     textBlock.releaseLines(textLine,textLine);
                     textLine.userData = null;
                     TextLineRecycler.addLineForReuse(textLine);
                     if(this._textFlow.backgroundManager)
                     {
                        this._textFlow.backgroundManager.removeLineFromCache(textLine);
                     }
                     textLine = textBlock.lastLine;
                  }
                  elem.releaseTextBlock(textBlock);
               }
            }
         }
         if(this.releaseLineCreationData && !okToRelease)
         {
            elem.releaseLineCreationData();
         }
         BackgroundManager.collectBlock(this._textFlow,elem);
         return success;
      }
      
      protected function getFirstIndentCharPos(paragraph:ParagraphElement) : int
      {
         var pos:int = 0;
         var leaf:FlowLeafElement = paragraph.getFirstLeaf();
         while(leaf && leaf is InlineGraphicElement && InlineGraphicElement(leaf).effectiveFloat != Float.NONE)
         {
            pos += leaf.textLength;
            leaf = leaf.getNextLeaf();
         }
         return pos;
      }
      
      protected function composeParagraphElementIntoLines() : Boolean
      {
         var textLine:TextLine = null;
         var leftMargin:Number = NaN;
         var rightMargin:Number = NaN;
         var curChild:FlowElement = null;
         var textAlignment:String = null;
         var numberLine:TextLine = null;
         var needAlignData:Boolean = false;
         var alignData:AlignData = null;
         var spaceBefore:Number = NaN;
         var spaceCarried:Number = NaN;
         var location:int = 0;
         var curElement:FlowElement = null;
         if(this._curParaElement.getTextBlock().content == null)
         {
            this._curParaElement.createContentElement();
         }
         var result:Boolean = true;
         var firstLineIndent:Number = 0;
         if(this._curParaFormat.direction == Direction.LTR)
         {
            leftMargin = this._curParaFormat.paragraphStartIndent;
            rightMargin = this._curParaFormat.paragraphEndIndent;
         }
         else
         {
            leftMargin = this._curParaFormat.paragraphEndIndent;
            rightMargin = this._curParaFormat.paragraphStartIndent;
         }
         this._parcelList.pushLeftMargin(leftMargin);
         this._parcelList.pushRightMargin(rightMargin);
         var firstIndentCharPos:int = this._curParaStart;
         if(this.preProcessILGs(this._curElementStart - this._curParaStart))
         {
            firstIndentCharPos = this.getFirstIndentCharPos(this._curParaElement) + this._curParaStart;
         }
         while(result)
         {
            if(this._parcelList.atEnd())
            {
               result = false;
               break;
            }
            this.startLine();
            if(!this._forceILGs)
            {
               this.processFloatsAtLineStart();
            }
            this._textIndent = this._curElementStart + this._curElementOffset <= firstIndentCharPos ? Number(this._curParaFormat.textIndent) : Number(0);
            if(this._parcelList.atEnd())
            {
               result = false;
               break;
            }
            curChild = this._curParaElement.getChildAt(this._curParaElement.findChildIndexAtPosition(this._curElementStart - this._curParaStart));
            if(curChild is TableElement)
            {
               if(!this.composeTableElement(curChild as TableElement,this._curElementStart))
               {
                  return false;
               }
               this._curElementOffset = 0;
               this._curElementStart += this._curElement.textLength;
               this._curElement = this._curElement.getNextLeaf();
               ++this._curLineStart;
               this._previousLine = null;
               if(this._curElement is SpanElement && SpanElement(this._curElement).hasParagraphTerminator && this._curElement.textLength == 1)
               {
                  this._curElementOffset = 0;
                  this._curElementStart += this._curElement.textLength;
                  this._curElement = this._curElement.getNextLeaf();
                  return true;
               }
            }
            textLine = this.composeNextLine();
            if(textLine == null)
            {
               result = false;
               break;
            }
            textAlignment = this._curParaFormat.textAlign;
            if(textAlignment == TextAlign.JUSTIFY)
            {
               location = this._curLine.location;
               if(location == TextFlowLineLocation.LAST || location == TextFlowLineLocation.ONLY)
               {
                  textAlignment = this._curParaFormat.textAlignLast;
               }
            }
            switch(textAlignment)
            {
               case TextAlign.START:
                  textAlignment = this._curParaFormat.direction == Direction.LTR ? TextAlign.LEFT : TextAlign.RIGHT;
                  break;
               case TextAlign.END:
                  textAlignment = this._curParaFormat.direction == Direction.LTR ? TextAlign.RIGHT : TextAlign.LEFT;
            }
            numberLine = TextFlowLine.findNumberLine(textLine);
            needAlignData = numberLine && TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE || textAlignment == TextAlign.CENTER || textAlignment == TextAlign.RIGHT;
            if(Configuration.playerEnablesArgoFeatures)
            {
               if(textLine["hasTabs"])
               {
                  if(this._curParaFormat.direction == Direction.LTR)
                  {
                     if(!numberLine || TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.INSIDE)
                     {
                        needAlignData = false;
                     }
                     textAlignment = TextAlign.LEFT;
                  }
                  else
                  {
                     needAlignData = true;
                     textAlignment = TextAlign.RIGHT;
                  }
               }
            }
            if(needAlignData)
            {
               alignData = createAlignData(this._curLine);
               alignData.textLine = textLine;
               alignData.textAlign = textAlignment;
            }
            spaceBefore = this._atColumnStart && this._curParaFormat.leadingModel != LeadingModel.BOX ? Number(0) : Number(this._curLine.spaceBefore);
            spaceCarried = !!this._atColumnStart ? Number(0) : Number(this._paragraphSpaceCarried);
            if(spaceBefore != 0 || spaceCarried != 0)
            {
               this._parcelList.addTotalDepth(Math.max(spaceBefore,spaceCarried));
            }
            this._paragraphSpaceCarried = 0;
            if(this._verticalSpaceCarried != 0)
            {
               this._verticalSpaceCarried = 0;
            }
            this._parcelList.addTotalDepth(this._curLine.height);
            alignData = this.calculateLineAlignmentAndBounds(textLine,numberLine,alignData);
            if(alignData)
            {
               if(!this._alignLines)
               {
                  this._alignLines = [];
               }
               this._alignLines.push(alignData);
               this._curLine.alignment = textAlignment;
            }
            if(firstLineIndent != 0)
            {
               if(this._curParaFormat.direction == Direction.LTR)
               {
                  this._parcelList.popLeftMargin(firstLineIndent);
               }
               else
               {
                  this._parcelList.popRightMargin(firstLineIndent);
               }
               firstLineIndent = 0;
            }
            if(!this.processFloatsAtLineEnd(textLine) || !this._curLine)
            {
               this.resetLine(textLine);
            }
            else
            {
               this.endLine(textLine);
               this._lastGoodStart = -1;
               if(this.isLineVisible(textLine))
               {
                  this._curParcel.controller.addComposedLine(textLine);
                  this._paragraphContainsVisibleLines = true;
               }
               if(this._parcelList.atEnd())
               {
                  result = false;
                  break;
               }
               this._previousLine = textLine;
               this._curElementOffset = this._curLine.absoluteStart + this._curLine.textLength - this._curElementStart;
               if(this._curElementOffset >= this._curElement.textLength)
               {
                  do
                  {
                     if(this._curParaElement.hasInteractiveChildren())
                     {
                        curElement = this._curElement;
                        while(curElement && curElement != this._curParaElement)
                        {
                           if(curElement is LinkElement)
                           {
                              this._curInteractiveObjects[curElement] = curElement;
                           }
                           else if(curElement.hasActiveEventMirror())
                           {
                              this._curInteractiveObjects[curElement] = curElement;
                           }
                           curElement = curElement.parent;
                        }
                     }
                     this._curElementOffset -= this._curElement.textLength;
                     this._curElementStart += this._curElement.textLength;
                     this._curElement = this._curElement.getNextLeaf();
                     if(this._curElementStart == this._curParaStart + this._curParaElement.textLength)
                     {
                        break;
                     }
                  }
                  while(this._curElementOffset >= this._curElement.textLength || this._curElement.textLength == 0);
                  
               }
               this._paragraphSpaceCarried = this._curLine.spaceAfter;
               if(this._curElementStart == this._curParaStart + this._curParaElement.textLength)
               {
                  break;
               }
            }
         }
         this._parcelList.popLeftMargin(leftMargin);
         this._parcelList.popRightMargin(rightMargin);
         if(firstLineIndent != 0)
         {
            if(this._curParaFormat.direction == Direction.LTR)
            {
               this._parcelList.popLeftMargin(firstLineIndent);
            }
            else
            {
               this._parcelList.popRightMargin(firstLineIndent);
            }
            firstLineIndent = 0;
         }
         this._previousLine = null;
         return result;
      }
      
      protected function createTextLine(targetWidth:Number, allowEmergencyBreaks:Boolean) : TextLine
      {
         var lineOffset:Number = this._curParaFormat.direction == Direction.LTR ? Number(this._lineSlug.leftMargin) : Number(this._lineSlug.rightMargin);
         var textLine:TextLine = null;
         textLine = TextLineRecycler.getLineForReuse();
         var textBlock:TextBlock = this._curParaElement.getTextBlockAtPosition(this._curElement.getElementRelativeStart(this._curParaElement));
         if(textLine)
         {
            textLine = this.swfContext.callInContext(textBlock["recreateTextLine"],textBlock,[textLine,this._previousLine,targetWidth,lineOffset,true]);
         }
         else
         {
            textLine = this.swfContext.callInContext(textBlock.createTextLine,textBlock,[this._previousLine,targetWidth,lineOffset,true]);
         }
         if(!allowEmergencyBreaks && textBlock.textLineCreationResult == TextLineCreationResult.EMERGENCY)
         {
            textLine = null;
         }
         if(textLine == null)
         {
            return null;
         }
         this._curLine.initialize(this._curParaElement,targetWidth,lineOffset - this._parcelList.insideListItemMargin,this._curLineStart,textLine.rawTextLength,textLine);
         return textLine;
      }
      
      protected function startLine() : void
      {
         this._workingContentExtent = 0;
         this._workingContentHeight = 0;
         this._workingContentLogicalExtent = 0;
         this._workingParcelIndex = this._parcelList.currentParcelIndex;
         this._workingTotalDepth = this.parcelList.totalDepth;
         this._workingParcelLogicalTop = NaN;
      }
      
      protected function isLineVisible(textLine:TextLine) : Boolean
      {
         return this._curParcel.controller.testLineVisible(this._blockProgression,this._controllerVisibleBoundsXTW,this._controllerVisibleBoundsYTW,this._controllerVisibleBoundsWidthTW,this._controllerVisibleBoundsHeightTW,this._curLine,textLine) is TextLine;
      }
      
      protected function endLine(textLine:TextLine) : void
      {
         this._curLineStart += this._curLine.textLength;
         this._contentCommittedExtent = Math.max(this._contentCommittedExtent,this._workingContentExtent);
         this._contentCommittedHeight = Math.max(this._contentCommittedHeight,this._workingContentHeight);
         this._contentLogicalExtent = Math.max(this._contentLogicalExtent,this._workingContentLogicalExtent);
         if(!this._measuring)
         {
            this._contentLogicalExtent = this._contentCommittedExtent;
         }
         if(this._pushInFloats)
         {
            this._pushInFloats.length = 0;
         }
         this._atColumnStart = false;
         this._linePass = 0;
         if(!isNaN(this._workingParcelLogicalTop))
         {
            this._parcelLogicalTop = this._workingParcelLogicalTop;
         }
      }
      
      protected function resetLine(textLine:TextLine) : void
      {
         if(this._textFlow.backgroundManager)
         {
            this._textFlow.backgroundManager.removeLineFromCache(textLine);
         }
         if(this._workingParcelIndex != this.parcelList.currentParcelIndex)
         {
            this._linePass = 0;
            if(this._pushInFloats)
            {
               this._pushInFloats.length = 0;
            }
         }
         else
         {
            ++this._linePass;
         }
         this.parcelList.addTotalDepth(this._workingTotalDepth - this._parcelList.totalDepth);
         this._workingTotalDepth = this.parcelList.totalDepth;
      }
      
      protected function preProcessILGs(startPos:int) : Boolean
      {
         var inlineGraphic:InlineGraphicElement = null;
         if(!this._curParcel)
         {
            return false;
         }
         var foundFloat:Boolean = false;
         var verticalText:* = this._blockProgression == BlockProgression.RL;
         this._forceILGs = this._parcelList.explicitLineBreaks || verticalText && this._curParcel.controller.measureHeight || !verticalText && this._curParcel.controller.measureWidth;
         var leaf:FlowLeafElement = this._curParaElement.findLeaf(startPos);
         while(leaf)
         {
            if(leaf is InlineGraphicElement)
            {
               inlineGraphic = leaf as InlineGraphicElement;
               inlineGraphic.setEffectiveFloat(!!this._forceILGs ? Float.NONE : inlineGraphic.computedFloat);
               foundFloat = true;
            }
            leaf = leaf.getNextLeaf(this._curParaElement);
         }
         return foundFloat;
      }
      
      protected function processFloatsAtLineStart() : void
      {
         var i:int = 0;
         var pos:int = 0;
         var leaf:FlowLeafElement = null;
         if(this._forceILGs)
         {
            return;
         }
         if(this._pushInFloats && this._pushInFloats.length > 0)
         {
            for(i = 0; i < this._pushInFloats.length; i++)
            {
               pos = this._pushInFloats[i];
               leaf = this._textFlow.findLeaf(pos);
               if(!this.composeFloat(leaf as InlineGraphicElement,false))
               {
                  this._pushInFloats.length = i;
               }
            }
         }
      }
      
      protected function processFloatsAtLineEnd(textLine:TextLine) : Boolean
      {
         var floatPosition:int = 0;
         var floatIndex:int = 0;
         var elem:InlineGraphicElement = null;
         var logicalFloatHeight:Number = NaN;
         var floatInfo:FloatCompositionData = null;
         var adjustTop:Number = NaN;
         var inlineGraphic:InlineGraphicElement = null;
         if(!textLine.hasGraphicElement && this._linePass <= 0)
         {
            return true;
         }
         if(this._pushInFloats && this._pushInFloats.length > 0)
         {
            floatPosition = this._pushInFloats[this._pushInFloats.length - 1];
            if(this._curLine.absoluteStart + this._curLine.textLength <= floatPosition)
            {
               for(floatIndex = this._pushInFloats.length - 1; floatIndex >= 0; floatIndex--)
               {
                  floatPosition = this._pushInFloats[floatIndex];
                  elem = this._textFlow.findLeaf(floatPosition) as InlineGraphicElement;
                  logicalFloatHeight = this._blockProgression == BlockProgression.RL ? Number(elem.elementWidth + elem.getEffectivePaddingLeft() + elem.getEffectivePaddingRight()) : Number(elem.elementHeightWithMarginsAndPadding());
                  floatInfo = this._curLine.controller.getFloatAtPosition(floatPosition);
                  if(floatInfo && floatInfo.absolutePosition == floatPosition)
                  {
                     adjustTop = !!isNaN(this._lastLineDescent) ? Number(0) : Number(this._lastLineDescent);
                     this._curParcel.removeKnockOut(floatInfo.knockOutWidth,floatInfo.depth - adjustTop,floatInfo.depth + logicalFloatHeight,floatInfo.floatType == Float.LEFT);
                  }
               }
               this._curLine.controller.clearFloatsAt(this._pushInFloats[0]);
               --this._pushInFloats.length;
               return false;
            }
         }
         var elementStart:int = this._curElementStart;
         var element:FlowLeafElement = this._curElement;
         var endPos:int = this._curLine.absoluteStart + this._curLine.textLength;
         var skipCount:int = 0;
         var hasInlines:Boolean = false;
         while(elementStart < endPos)
         {
            if(element is InlineGraphicElement)
            {
               inlineGraphic = InlineGraphicElement(element);
               if(inlineGraphic.computedFloat == Float.NONE || this._forceILGs)
               {
                  hasInlines = true;
               }
               else if(this._linePass == 0)
               {
                  if(!this._pushInFloats)
                  {
                     this._pushInFloats = [];
                  }
                  this._pushInFloats.push(elementStart);
               }
               else if(this._pushInFloats.indexOf(elementStart) >= 0)
               {
                  skipCount++;
               }
               else if(!this.composeFloat(inlineGraphic,true))
               {
                  this.advanceToNextParcel();
                  return false;
               }
            }
            elementStart += element.textLength;
            element = element.getNextLeaf();
         }
         var completed:* = skipCount >= (!!this._pushInFloats ? this._pushInFloats.length : 0);
         if(completed && hasInlines)
         {
            this.processInlinesAtLineEnd(textLine);
         }
         return completed;
      }
      
      protected function processInlinesAtLineEnd(textLine:TextLine) : void
      {
         var inlineGraphic:InlineGraphicElement = null;
         var elementStart:int = this._curElementStart;
         var element:FlowLeafElement = this._curElement;
         var endPos:int = this._curLine.absoluteStart + this._curLine.textLength;
         while(elementStart < endPos)
         {
            if(element is InlineGraphicElement)
            {
               inlineGraphic = element as InlineGraphicElement;
               if(inlineGraphic.computedFloat == Float.NONE || this._forceILGs)
               {
                  this.composeInlineGraphicElement(inlineGraphic,textLine);
               }
            }
            elementStart += element.textLength;
            element = element.getNextLeaf();
         }
      }
      
      protected function composeInlineGraphicElement(inlineGraphic:InlineGraphicElement, textLine:TextLine) : Boolean
      {
         var curElement:FlowElement = null;
         var marginAndPaddingX:Number = this._blockProgression == BlockProgression.RL ? Number(-inlineGraphic.getEffectivePaddingRight()) : Number(inlineGraphic.getEffectivePaddingLeft());
         var marginAndPaddingY:Number = inlineGraphic.getEffectivePaddingTop();
         var fteInline:DisplayObject = inlineGraphic.placeholderGraphic.parent;
         this._curParcel.controller.addFloatAt(this._curParaStart + inlineGraphic.getElementRelativeStart(this._curParaElement),inlineGraphic.graphic,Float.NONE,marginAndPaddingX,marginAndPaddingY,!!fteInline ? Number(fteInline.alpha) : Number(1),!!fteInline ? fteInline.transform.matrix : null,this._parcelList.totalDepth,0,this._curParcel.columnIndex,textLine);
         if(this._curParaElement.hasInteractiveChildren())
         {
            curElement = inlineGraphic;
            while(curElement && curElement != this._curParaElement)
            {
               if(curElement is LinkElement)
               {
                  this._curInteractiveObjects[curElement] = curElement;
               }
               else if(curElement.hasActiveEventMirror())
               {
                  this._curInteractiveObjects[curElement] = curElement;
               }
               curElement = curElement.parent;
            }
         }
         return true;
      }
      
      protected function composeFloat(elem:InlineGraphicElement, afterLine:Boolean) : Boolean
      {
         var logicalFloatWidth:Number = NaN;
         var logicalFloatHeight:Number = NaN;
         var floatType:String = null;
         var floatRect:Rectangle = null;
         var knockOutWidth:Number = NaN;
         var adjustTop:Number = NaN;
         if(elem.elementHeight == 0 || elem.elementWidth == 0)
         {
            return true;
         }
         if(this._lastGoodStart == -1)
         {
            this._lastGoodStart = this._curElementStart + this._curElementOffset;
         }
         var verticalText:* = this._blockProgression == BlockProgression.RL;
         var effectiveLastLineDescent:Number = 0;
         if((afterLine || !this._atColumnStart) && !isNaN(this._lastLineDescent))
         {
            effectiveLastLineDescent = this._lastLineDescent;
         }
         var spaceBefore:Number = 0;
         if(this._curLine && this._curParaElement != this._curLine.paragraph && !this._atColumnStart)
         {
            spaceBefore = Math.max(this._curParaElement.computedFormat.paragraphSpaceBefore,this._paragraphSpaceCarried);
         }
         var totalDepth:Number = this._parcelList.totalDepth + spaceBefore + effectiveLastLineDescent;
         if(!_floatSlug)
         {
            _floatSlug = new Slug();
         }
         if(verticalText)
         {
            logicalFloatWidth = elem.elementHeight + elem.getEffectivePaddingTop() + elem.getEffectivePaddingBottom();
            logicalFloatHeight = elem.elementWidth + elem.getEffectivePaddingLeft() + elem.getEffectivePaddingRight();
         }
         else
         {
            logicalFloatWidth = elem.elementWidthWithMarginsAndPadding();
            logicalFloatHeight = elem.elementHeightWithMarginsAndPadding();
         }
         var floatPosition:int = elem.getAbsoluteStart();
         var floatFits:Boolean = this._parcelList.fitFloat(_floatSlug,totalDepth,logicalFloatWidth,logicalFloatHeight);
         if(!floatFits && (this._curParcel.fitAny || this._curParcel.fitsInHeight(totalDepth,int(logicalFloatHeight))) && (!this._curLine || this._curLine.absoluteStart == floatPosition || afterLine))
         {
            floatFits = true;
         }
         if(floatFits)
         {
            floatType = elem.computedFloat;
            if(floatType == Float.START)
            {
               floatType = this._curParaFormat.direction == Direction.LTR ? Float.LEFT : Float.RIGHT;
            }
            else if(floatType == Float.END)
            {
               floatType = this._curParaFormat.direction == Direction.LTR ? Float.RIGHT : Float.LEFT;
            }
            floatRect = this.calculateFloatBounds(elem,verticalText,floatType);
            if(verticalText)
            {
               this._workingContentExtent = Math.max(this._workingContentExtent,floatRect.bottom + elem.getEffectivePaddingLeft() + elem.getEffectivePaddingRight());
               this._workingContentHeight = Math.max(this._workingContentHeight,_floatSlug.depth + floatRect.width + elem.getEffectivePaddingTop() + elem.getEffectivePaddingBottom());
               this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,floatRect.bottom);
               this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,floatRect.y);
            }
            else
            {
               this._workingContentExtent = Math.max(this._workingContentExtent,floatRect.right + elem.getEffectivePaddingLeft() + elem.getEffectivePaddingRight());
               this._workingContentHeight = Math.max(this._workingContentHeight,_floatSlug.depth + floatRect.height + elem.getEffectivePaddingTop() + elem.getEffectivePaddingBottom());
               this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,floatRect.right);
               this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,floatRect.x);
            }
            if(floatPosition == this._curParcelStart)
            {
               this._workingParcelLogicalTop = _floatSlug.depth;
            }
            knockOutWidth = (floatType == Float.LEFT ? _floatSlug.leftMargin : _floatSlug.rightMargin) + logicalFloatWidth;
            adjustTop = !!isNaN(this._lastLineDescent) ? Number(0) : Number(this._lastLineDescent);
            this._curParcel.knockOut(knockOutWidth,_floatSlug.depth - adjustTop,_floatSlug.depth + logicalFloatHeight,floatType == Float.LEFT);
            this._curParcel.controller.addFloatAt(floatPosition,elem.graphic,floatType,floatRect.x,floatRect.y,elem.computedFormat.textAlpha,null,_floatSlug.depth,knockOutWidth,this._curParcel.columnIndex,this._curParcel.controller.container);
         }
         return floatFits;
      }
      
      private function calculateFloatBounds(elem:InlineGraphicElement, verticalText:Boolean, floatType:String) : Rectangle
      {
         var floatRect:Rectangle = new Rectangle();
         if(verticalText)
         {
            floatRect.x = this._curParcel.right - _floatSlug.depth - elem.elementWidth - elem.getEffectivePaddingRight();
            floatRect.y = floatType == Float.LEFT ? Number(this._curParcel.y + _floatSlug.leftMargin + elem.getEffectivePaddingTop()) : Number(this._curParcel.bottom - _floatSlug.rightMargin - elem.getEffectivePaddingBottom() - elem.elementHeight);
            floatRect.width = elem.elementWidth;
            floatRect.height = elem.elementHeight;
         }
         else
         {
            floatRect.x = floatType == Float.LEFT ? Number(this._curParcel.x + _floatSlug.leftMargin + elem.getEffectivePaddingLeft()) : Number(this._curParcel.right - _floatSlug.rightMargin - elem.getEffectivePaddingRight() - elem.elementWidth);
            floatRect.y = this._curParcel.y + _floatSlug.depth + elem.getEffectivePaddingTop();
            floatRect.width = elem.elementWidth;
            floatRect.height = elem.elementHeight;
         }
         return floatRect;
      }
      
      private function calculateLineWidthExplicit(textLine:TextLine) : Number
      {
         var isRTL:* = this._curParaElement.computedFormat.direction == Direction.RTL;
         var lastAtom:int = textLine.atomCount - 1;
         var endOfParagraph:* = this._curLine.absoluteStart + this._curLine.textLength == this._curParaStart + this._curParaElement.textLength;
         if(endOfParagraph && !isRTL)
         {
            lastAtom--;
         }
         var bounds:Rectangle = textLine.getAtomBounds(lastAtom >= 0 ? int(lastAtom) : 0);
         var lineWidth:Number = this._blockProgression == BlockProgression.TB ? (lastAtom >= 0 ? Number(bounds.right) : Number(bounds.left)) : (lastAtom >= 0 ? Number(bounds.bottom) : Number(bounds.top));
         if(isRTL)
         {
            bounds = textLine.getAtomBounds(lastAtom != 0 && endOfParagraph ? 1 : 0);
            lineWidth -= this._blockProgression == BlockProgression.TB ? bounds.left : bounds.top;
         }
         return lineWidth;
      }
      
      private function getRightSideGap(curLine:TextFlowLine, aligned:Boolean) : Number
      {
         var textLine:TextLine = null;
         var numberLine:TextLine = null;
         var elem:FlowGroupElement = curLine.paragraph;
         var paraFormat:ITextLayoutFormat = elem.computedFormat;
         var rightSideGap:Number = paraFormat.direction == Direction.RTL ? Number(paraFormat.paragraphStartIndent) : Number(paraFormat.paragraphEndIndent);
         if(paraFormat.direction == Direction.RTL && curLine.location & TextFlowLineLocation.FIRST)
         {
            rightSideGap += paraFormat.textIndent;
            if(curLine.hasNumberLine && elem.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
            {
               textLine = curLine.getTextLine(true);
               numberLine = TextFlowLine.findNumberLine(textLine);
               rightSideGap += TextFlowLine.getNumberLineInsideLineWidth(numberLine);
            }
         }
         do
         {
            rightSideGap += this._blockProgression == BlockProgression.TB ? elem.getEffectivePaddingRight() + elem.getEffectiveBorderRightWidth() + elem.getEffectiveMarginRight() : elem.getEffectivePaddingBottom() + elem.getEffectiveBorderBottomWidth() + elem.getEffectiveMarginBottom();
            elem = elem.parent;
         }
         while(!(elem is TextFlow));
         
         return rightSideGap;
      }
      
      private function getLeftSideGap(curLine:TextFlowLine) : Number
      {
         var textLine:TextLine = null;
         var numberLine:TextLine = null;
         var elem:FlowGroupElement = curLine.paragraph;
         var paraFormat:ITextLayoutFormat = elem.computedFormat;
         var leftSideGap:Number = paraFormat.direction == Direction.LTR ? Number(paraFormat.paragraphStartIndent) : Number(paraFormat.paragraphEndIndent);
         if(paraFormat.direction == Direction.LTR && curLine.location & TextFlowLineLocation.FIRST)
         {
            leftSideGap += paraFormat.textIndent;
            if(curLine.hasNumberLine && elem.getParentByType(ListItemElement).computedFormat.listStylePosition == ListStylePosition.INSIDE)
            {
               textLine = curLine.getTextLine(true);
               numberLine = TextFlowLine.findNumberLine(textLine);
               leftSideGap += TextFlowLine.getNumberLineInsideLineWidth(numberLine);
            }
         }
         do
         {
            leftSideGap += this._blockProgression == BlockProgression.TB ? elem.getEffectivePaddingLeft() + elem.getEffectiveBorderLeftWidth() + elem.getEffectiveMarginLeft() : elem.getEffectivePaddingTop() + elem.getEffectiveBorderTopWidth() + elem.getEffectiveMarginTop();
            elem = elem.parent;
         }
         while(!(elem is TextFlow));
         
         return leftSideGap;
      }
      
      private function calculateLineAlignmentAndBounds(textLine:TextLine, numberLine:TextLine, alignData:AlignData) : AlignData
      {
         var extraSpace:Number = NaN;
         var coord:Number = NaN;
         var adjustedLogicalRight:Number = NaN;
         var textLineWidth:Number = NaN;
         var edgeAdjust:Number = NaN;
         var numberLineStart:Number = NaN;
         var numberLineMaxExtent:Number = NaN;
         var lineWidth:Number = textLine.textWidth;
         if(GlobalSettings.alwaysCalculateWhitespaceBounds || this._parcelList.explicitLineBreaks)
         {
            lineWidth = this.calculateLineWidthExplicit(textLine);
         }
         var rightSideGap:Number = this._lineSlug.rightMargin;
         var leftSideGap:Number = this._lineSlug.leftMargin;
         var delta:Number = 0;
         if(alignData)
         {
            alignData.rightSideGap = rightSideGap;
            alignData.leftSideGap = leftSideGap;
            alignData.lineWidth = lineWidth;
            alignData.textIndent = this._curParaFormat.textIndent;
            if(this._blockProgression == BlockProgression.TB)
            {
               if(!this._measuring)
               {
                  textLineWidth = textLine.textWidth;
                  extraSpace = this._curParcel.width - leftSideGap - rightSideGap - textLineWidth;
                  if(alignData.textAlign != TextAlign.LEFT)
                  {
                     delta = alignData.textAlign == TextAlign.CENTER ? Number(extraSpace / 2) : Number(extraSpace);
                     coord = this._curParcel.x + leftSideGap + delta;
                  }
                  else
                  {
                     coord = this._curParcel.x + leftSideGap + extraSpace;
                  }
                  if(alignData.textAlign != TextAlign.LEFT)
                  {
                     this._curLine.x = coord;
                     textLine.x = coord;
                  }
                  else
                  {
                     textLine.x = this._curLine.x;
                  }
                  if(numberLine && TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
                  {
                     numberLine.x = computeNumberLineAlignment(alignData,textLine.textWidth,textLine.x,numberLine,coord,delta,extraSpace);
                     this._curLine.numberLinePosition = numberLine.x;
                  }
                  releaseAlignData(alignData);
                  alignData = null;
               }
            }
            else if(!this._measuring)
            {
               extraSpace = this._curParcel.height - leftSideGap - rightSideGap - textLine.textWidth;
               if(alignData.textAlign != TextAlign.LEFT)
               {
                  delta = alignData.textAlign == TextAlign.CENTER ? Number(extraSpace / 2) : Number(extraSpace);
                  coord = this._curParcel.y + leftSideGap + delta;
               }
               else
               {
                  coord = this._curParcel.y + leftSideGap + extraSpace;
               }
               if(alignData.textAlign != TextAlign.LEFT)
               {
                  this._curLine.y = coord;
                  textLine.y = coord;
               }
               else
               {
                  textLine.y = this._curLine.y;
               }
               if(numberLine && TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
               {
                  numberLine.y = computeNumberLineAlignment(alignData,textLine.textWidth,textLine.y,numberLine,coord,delta,extraSpace);
                  this._curLine.numberLinePosition = numberLine.y;
               }
               releaseAlignData(alignData);
               alignData = null;
            }
         }
         var lineExtent:Number = lineWidth + leftSideGap + rightSideGap + delta;
         this._curLine.lineExtent = lineExtent;
         this._workingContentLogicalExtent = Math.max(this._workingContentLogicalExtent,lineExtent);
         this._curLine.accumulatedLineExtent = Math.max(this._contentLogicalExtent,this._workingContentLogicalExtent);
         if(!alignData)
         {
            edgeAdjust = this._curParaFormat.direction == Direction.LTR ? Number(Math.max(this._curLine.lineOffset,0)) : Number(this._curParaFormat.paragraphEndIndent);
            edgeAdjust = this._blockProgression == BlockProgression.RL ? Number(this._curLine.y - edgeAdjust) : Number(this._curLine.x - edgeAdjust);
            if(numberLine)
            {
               numberLineStart = this._blockProgression == BlockProgression.TB ? Number(numberLine.x + this._curLine.x) : Number(numberLine.y + this._curLine.y);
               edgeAdjust = Math.min(edgeAdjust,numberLineStart);
               if(TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
               {
                  numberLineMaxExtent = numberLineStart + TextFlowLine.getNumberLineInsideLineWidth(numberLine);
                  numberLineMaxExtent -= lineExtent;
                  if(numberLineMaxExtent > 0)
                  {
                     delta += numberLineMaxExtent;
                  }
               }
            }
            this._workingContentExtent = Math.max(this._workingContentExtent,lineWidth + leftSideGap + Math.max(0,rightSideGap) + delta);
            this._curLine.accumulatedMinimumStart = this._accumulatedMinimumStart = Math.min(this._accumulatedMinimumStart,edgeAdjust);
         }
         if(this._curLine.absoluteStart == this._curParcelStart && isNaN(this._workingParcelLogicalTop))
         {
            this._workingParcelLogicalTop = this.computeTextFlowLineMinimumLogicalTop(this._curLine,textLine);
         }
         return alignData;
      }
      
      protected function composeNextLine() : TextLine
      {
         return null;
      }
      
      protected function fitLineToParcel(textLine:TextLine, isNewLine:Boolean, numberLine:TextLine) : Boolean
      {
         var composeYCoord:Number = this._lineSlug.depth;
         this._curLine.setController(this._curParcel.controller,this._curParcel.columnIndex);
         var spaceBefore:Number = Math.max(this._curLine.spaceBefore,this._paragraphSpaceCarried);
         loop0:
         while(true)
         {
            this.finishComposeLine(textLine,numberLine);
            if(this._parcelList.getLineSlug(this._lineSlug,spaceBefore + (this._parcelList.atLast() && this._textFlow.configuration.overflowPolicy != OverflowPolicy.FIT_DESCENDERS ? this._curLine.height - this._curLine.ascent : this._curLine.height + this._curLine.descent),1,this._textIndent,this._curParaFormat.direction == Direction.LTR))
            {
               if(Twips.to(this._lineSlug.width) == this._curLine.outerTargetWidthTW && this._lineSlug.depth != composeYCoord)
               {
                  this.finishComposeLine(textLine,numberLine);
               }
               break;
            }
            spaceBefore = this._curLine.spaceBefore;
            if(this._pushInFloats && this._parcelList.currentParcel.fitAny && this._pushInFloats.length > 0)
            {
               break;
            }
            while(true)
            {
               this.advanceToNextParcel();
               if(!this._curLine || this._parcelList.atEnd())
               {
                  break;
               }
               if(this._parcelList.getLineSlug(this._lineSlug,0,1,this._textIndent,this._curParaFormat.direction == Direction.LTR))
               {
                  continue loop0;
               }
            }
            return false;
         }
         if(Twips.to(this._lineSlug.width) != this._curLine.outerTargetWidthTW)
         {
            return false;
         }
         if(isNewLine)
         {
            if(numberLine)
            {
               TextFlowLine.initializeNumberLinePosition(numberLine,this._listItemElement,this._curParaElement,textLine.textWidth);
            }
            this._curLine.createAdornments(this._blockProgression,this._curElement,this._curElementStart,textLine,numberLine);
         }
         return true;
      }
      
      protected function calculateLeadingParameters(curElement:FlowLeafElement, curElementStart:int, numberLine:TextLine = null) : Number
      {
         var effectiveListMarkerFormat:ITextLayoutFormat = null;
         var lineBox:Rectangle = null;
         if(numberLine)
         {
            effectiveListMarkerFormat = TextFlowLine.getNumberLineSpanFormat(numberLine);
         }
         if(this._curLineLeadingModel == LeadingModel.BOX)
         {
            lineBox = this._curLine.getCSSLineBox(this._blockProgression,curElement,curElementStart,this._textFlow.flowComposer.swfContext,effectiveListMarkerFormat,numberLine);
            this._curLineLeading = !!lineBox ? Number(lineBox.bottom) : Number(0);
            return !!lineBox ? Number(-lineBox.top) : Number(0);
         }
         this._curLineLeading = this._curLine.getLineLeading(this._blockProgression,curElement,curElementStart);
         if(effectiveListMarkerFormat)
         {
            this._curLineLeading = Math.max(this._curLineLeading,TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(effectiveListMarkerFormat.lineHeight,effectiveListMarkerFormat.fontSize));
         }
         return 0;
      }
      
      protected function finishComposeLine(curTextLine:TextLine, numberLine:TextLine) : void
      {
         var rise:Number = NaN;
         var run:Number = NaN;
         var containerAttrs:ITextLayoutFormat = null;
         var baselineType:Object = null;
         var firstBaselineOffsetBasis:String = null;
         var firstLineAdjustment:LeadingAdjustment = null;
         var curLineAscent:Number = NaN;
         var curLeadingDirectionUp:Boolean = false;
         var prevLeadingDirectionUp:Boolean = false;
         var prevLineFirstElement:FlowLeafElement = null;
         var adjustment:LeadingAdjustment = null;
         var spaceAdjust:Number = NaN;
         var lineHeight:Number = 0;
         if(this._blockProgression == BlockProgression.RL)
         {
            rise = this._curParcel.x + this._curParcel.width - this._lineSlug.depth;
            run = this._curParcel.y;
         }
         else
         {
            rise = this._curParcel.y + this._lineSlug.depth;
            run = this._curParcel.x;
         }
         run += this._lineSlug.leftMargin;
         this._curLineLeadingModel = this._curParaElement.getEffectiveLeadingModel();
         var secondaryLeadingParameter:Number = this.calculateLeadingParameters(this._curElement,this._curElementStart,numberLine);
         if(this._curLineLeadingModel == LeadingModel.BOX)
         {
            lineHeight += !!this._atColumnStart ? 0 : this._lastLineDescent;
            lineHeight += secondaryLeadingParameter;
         }
         else
         {
            containerAttrs = this._curParcel.controller.computedFormat;
            baselineType = BaselineOffset.LINE_HEIGHT;
            if(this._atColumnStart)
            {
               if(containerAttrs.firstBaselineOffset != BaselineOffset.AUTO && containerAttrs.verticalAlign != VerticalAlign.BOTTOM && containerAttrs.verticalAlign != VerticalAlign.MIDDLE)
               {
                  baselineType = containerAttrs.firstBaselineOffset;
                  firstBaselineOffsetBasis = LocaleUtil.leadingModel(containerAttrs.locale) == LeadingModel.IDEOGRAPHIC_TOP_DOWN ? TextBaseline.IDEOGRAPHIC_BOTTOM : TextBaseline.ROMAN;
                  lineHeight -= curTextLine.getBaselinePosition(firstBaselineOffsetBasis);
               }
               else if(this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
               {
                  lineHeight += Math.round(curTextLine.descent) + Math.round(curTextLine.ascent);
                  if(this._blockProgression == BlockProgression.TB)
                  {
                     lineHeight = Math.round(rise + lineHeight) - rise;
                  }
                  else
                  {
                     lineHeight = rise - Math.round(rise - lineHeight);
                  }
                  baselineType = 0;
               }
               else
               {
                  baselineType = BaselineOffset.ASCENT;
                  if(curTextLine.hasGraphicElement)
                  {
                     firstLineAdjustment = this.getLineAdjustmentForInline(curTextLine,this._curLineLeadingModel,true);
                     if(firstLineAdjustment != null)
                     {
                        if(this._blockProgression == BlockProgression.RL)
                        {
                           firstLineAdjustment.rise = -firstLineAdjustment.rise;
                        }
                        this._curLineLeading += firstLineAdjustment.leading;
                        rise += firstLineAdjustment.rise;
                     }
                  }
                  lineHeight -= curTextLine.getBaselinePosition(TextBaseline.ROMAN);
               }
            }
            if(baselineType == BaselineOffset.ASCENT)
            {
               curLineAscent = this._curLine.getLineTypographicAscent(this._curElement,this._curElementStart,curTextLine);
               if(numberLine)
               {
                  lineHeight += Math.max(curLineAscent,TextFlowLine.getTextLineTypographicAscent(numberLine,null,0,0));
               }
               else
               {
                  lineHeight += curLineAscent;
               }
            }
            else if(baselineType == BaselineOffset.LINE_HEIGHT)
            {
               if(this._curLineLeadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
               {
                  lineHeight += Math.round(this._lastLineDescent) + Math.round(curTextLine.ascent) + Math.round(curTextLine.descent) + Math.round(this._curLineLeading);
               }
               else if(this._curLineLeadingModel == LeadingModel.ASCENT_DESCENT_UP)
               {
                  lineHeight += this._lastLineDescent + curTextLine.ascent + this._curLineLeading;
               }
               else
               {
                  curLeadingDirectionUp = !!this._atColumnStart ? true : Boolean(ParagraphElement.useUpLeadingDirection(this._curLineLeadingModel));
                  prevLeadingDirectionUp = this._atColumnStart || this._lastLineLeadingModel == "" ? true : Boolean(ParagraphElement.useUpLeadingDirection(this._lastLineLeadingModel));
                  if(curLeadingDirectionUp)
                  {
                     lineHeight += this._curLineLeading;
                  }
                  else if(!prevLeadingDirectionUp)
                  {
                     lineHeight += this._lastLineLeading;
                  }
                  else
                  {
                     lineHeight += this._lastLineDescent + curTextLine.ascent;
                  }
               }
            }
            else
            {
               lineHeight += Number(baselineType);
            }
            if(curTextLine.hasGraphicElement && baselineType != BaselineOffset.ASCENT)
            {
               adjustment = this.getLineAdjustmentForInline(curTextLine,this._curLineLeadingModel,false);
               if(adjustment != null)
               {
                  if(this._blockProgression == BlockProgression.RL)
                  {
                     adjustment.rise = -adjustment.rise;
                  }
                  this._curLineLeading += adjustment.leading;
                  rise += adjustment.rise;
               }
            }
         }
         this._firstLineDescentAndLeading = this._blockProgression == BlockProgression.RL ? Number(-lineHeight) : Number(lineHeight - curTextLine.ascent);
         rise += this._firstLineDescentAndLeading;
         var spaceBefore:Number = this._atColumnStart && this._curLineLeadingModel != LeadingModel.BOX ? Number(0) : Number(this._curLine.spaceBefore);
         var spaceCarried:Number = !!this._atColumnStart ? Number(0) : Number(this._paragraphSpaceCarried);
         if(spaceBefore != 0 || spaceCarried != 0)
         {
            spaceAdjust = Math.max(spaceBefore,spaceCarried);
            rise += this._blockProgression == BlockProgression.RL ? -spaceAdjust : spaceAdjust;
         }
         if(this._blockProgression == BlockProgression.TB)
         {
            this._curLine.setXYAndHeight(run,rise,lineHeight);
         }
         else
         {
            this._curLine.setXYAndHeight(rise,run,lineHeight);
         }
      }
      
      private function applyTextAlign(effectiveParcelWidth:Number) : void
      {
         var textLine:TextLine = null;
         var numberLine:TextLine = null;
         var line:TextFlowLine = null;
         var alignData:AlignData = null;
         var coord:Number = NaN;
         var delta:Number = NaN;
         var adjustedLogicalRight:Number = NaN;
         var extraSpace:Number = NaN;
         var leftSideGap:Number = NaN;
         var rightSideGap:Number = NaN;
         var numberLineMetric:Number = NaN;
         if(this._blockProgression == BlockProgression.TB)
         {
            for each(alignData in this._alignLines)
            {
               textLine = alignData.textLine;
               rightSideGap = alignData.rightSideGap;
               leftSideGap = alignData.leftSideGap;
               extraSpace = effectiveParcelWidth - leftSideGap - rightSideGap - textLine.textWidth;
               delta = alignData.textAlign == TextAlign.CENTER ? Number(extraSpace / 2) : Number(extraSpace);
               coord = this._curParcel.x + leftSideGap + delta;
               if(alignData.textAlign != TextAlign.LEFT)
               {
                  line = textLine.userData as TextFlowLine;
                  if(line)
                  {
                     line.x = coord;
                  }
                  textLine.x = coord;
               }
               adjustedLogicalRight = alignData.lineWidth + coord + Math.max(rightSideGap,0);
               this._parcelRight = Math.max(adjustedLogicalRight,this._parcelRight);
               numberLine = TextFlowLine.findNumberLine(textLine);
               if(numberLine && TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
               {
                  numberLine.x = computeNumberLineAlignment(alignData,textLine.textWidth,textLine.x,numberLine,coord,delta,extraSpace);
                  alignData.textFlowLine.numberLinePosition = numberLine.x;
                  numberLineMetric = numberLine.x + textLine.x;
                  if(numberLineMetric < this._parcelLeft)
                  {
                     this._parcelLeft = numberLineMetric;
                  }
                  numberLineMetric += TextFlowLine.getNumberLineInsideLineWidth(numberLine);
                  if(numberLineMetric > this._parcelRight)
                  {
                     this._parcelRight = numberLineMetric;
                  }
               }
            }
         }
         else
         {
            for each(alignData in this._alignLines)
            {
               textLine = alignData.textLine;
               rightSideGap = alignData.rightSideGap;
               leftSideGap = alignData.leftSideGap;
               extraSpace = effectiveParcelWidth - leftSideGap - rightSideGap - textLine.textWidth;
               delta = alignData.textAlign == TextAlign.CENTER ? Number(extraSpace / 2) : Number(extraSpace);
               coord = this._curParcel.y + leftSideGap + delta;
               if(alignData.textAlign != TextAlign.LEFT)
               {
                  line = textLine.userData as TextFlowLine;
                  if(line)
                  {
                     line.y = coord;
                  }
                  textLine.y = coord;
               }
               adjustedLogicalRight = alignData.lineWidth + coord + Math.max(rightSideGap,0);
               this._parcelBottom = Math.max(adjustedLogicalRight,this._parcelBottom);
               numberLine = TextFlowLine.findNumberLine(textLine);
               if(numberLine && TextFlowLine.getNumberLineListStylePosition(numberLine) == ListStylePosition.OUTSIDE)
               {
                  numberLine.y = computeNumberLineAlignment(alignData,textLine.textWidth,textLine.y,numberLine,coord,delta,extraSpace);
                  alignData.textFlowLine.numberLinePosition = numberLine.y;
                  numberLineMetric = numberLine.y + textLine.y;
                  if(numberLineMetric < this._parcelTop)
                  {
                     this._parcelTop = numberLineMetric;
                  }
                  numberLineMetric += TextFlowLine.getNumberLineInsideLineWidth(numberLine);
                  if(numberLineMetric > this._parcelBottom)
                  {
                     this._parcelBottom = numberLineMetric;
                  }
               }
            }
         }
      }
      
      protected function commitLastLineState(curLine:TextFlowLine) : void
      {
         this._lastLineDescent = this._curLineLeadingModel == LeadingModel.BOX ? Number(this._curLineLeading) : Number(curLine.descent);
         this._lastLineLeading = this._curLineLeading;
         this._lastLineLeadingModel = this._curLineLeadingModel;
      }
      
      protected function doVerticalAlignment(canVerticalAlign:Boolean, nextParcel:Parcel) : void
      {
      }
      
      protected function finalParcelAdjustment(controller:ContainerController) : void
      {
      }
      
      protected function finishParcel(controller:ContainerController, nextParcel:Parcel) : Boolean
      {
         if(this._curParcelStart == this._curElementStart + this._curElementOffset)
         {
            return false;
         }
         var totalDepth:Number = this._parcelList.totalDepth;
         if(this._textFlow.configuration.overflowPolicy == OverflowPolicy.FIT_DESCENDERS && !isNaN(this._lastLineDescent))
         {
            totalDepth += this._lastLineDescent;
         }
         totalDepth = Math.max(totalDepth,this._contentCommittedHeight);
         if(this._blockProgression == BlockProgression.TB)
         {
            this._parcelLeft = this._curParcel.x;
            this._parcelTop = this._curParcel.y;
            this._parcelRight = this._contentCommittedExtent + this._curParcel.x;
            this._parcelBottom = totalDepth + this._curParcel.y;
         }
         else
         {
            this._parcelLeft = this._curParcel.right - totalDepth;
            this._parcelTop = this._curParcel.y;
            this._parcelRight = this._curParcel.right;
            this._parcelBottom = this._contentCommittedExtent + this._curParcel.y;
         }
         if(this._alignLines && this._alignLines.length > 0)
         {
            this.applyTextAlign(this._contentLogicalExtent);
            releaseAlignData(this._alignLines[0]);
            this._alignLines.length = 0;
         }
         var canVerticalAlign:Boolean = false;
         if(this._blockProgression == BlockProgression.TB)
         {
            if(!controller.measureHeight && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
            {
               canVerticalAlign = true;
            }
         }
         else if(!controller.measureWidth && (!this._curParcel.fitAny || this._curElementStart + this._curElementOffset >= this._textFlow.textLength))
         {
            canVerticalAlign = true;
         }
         this.doVerticalAlignment(canVerticalAlign,nextParcel);
         this.finalParcelAdjustment(controller);
         this._contentLogicalExtent = 0;
         this._contentCommittedExtent = 0;
         this._contentCommittedHeight = 0;
         this._accumulatedMinimumStart = TextLine.MAX_LINE_WIDTH;
         return true;
      }
      
      protected function applyVerticalAlignmentToColumn(controller:ContainerController, vjType:String, lines:Array, beginIndex:int, numLines:int, beginFloatIndex:int, endFloatIndex:int) : void
      {
         var firstLineCoord:Number = NaN;
         var lastLineCoord:Number = NaN;
         var firstLine:IVerticalJustificationLine = lines[beginIndex];
         var lastLine:IVerticalJustificationLine = lines[beginIndex + numLines - 1];
         if(this._blockProgression == BlockProgression.TB)
         {
            firstLineCoord = firstLine.y;
            lastLineCoord = lastLine.y;
         }
         else
         {
            firstLineCoord = firstLine.x;
            lastLineCoord = lastLine.x;
         }
         var firstLineAdjustment:Number = VerticalJustifier.applyVerticalAlignmentToColumn(controller,vjType,lines,beginIndex,numLines,beginFloatIndex,endFloatIndex);
         if(!isNaN(this._parcelLogicalTop))
         {
            this._parcelLogicalTop += firstLineAdjustment;
         }
         if(this._blockProgression == BlockProgression.TB)
         {
            this._parcelTop += firstLine.y - firstLineCoord;
            this._parcelBottom += lastLine.y - lastLineCoord;
         }
         else
         {
            this._parcelRight += firstLine.x - firstLineCoord;
            this._parcelLeft += lastLine.x - lastLineCoord;
         }
      }
      
      protected function finishController(controller:ContainerController) : void
      {
         var paddingLeft:Number = NaN;
         var paddingTop:Number = NaN;
         var paddingRight:Number = NaN;
         var paddingBottom:Number = NaN;
         var controllerTextLength:int = this._curElementStart + this._curElementOffset - controller.absoluteStart;
         var nextCC:ContainerController = this._flowComposer.getControllerAt(this._flowComposer.getControllerIndex(controller) + 1);
         if(nextCC && nextCC.absoluteStart != 0 && this._correctTextLength)
         {
            controllerTextLength = nextCC.absoluteStart - controller.absoluteStart;
         }
         if(controllerTextLength != 0)
         {
            paddingLeft = controller.getTotalPaddingLeft();
            paddingTop = controller.getTotalPaddingTop();
            paddingRight = controller.getTotalPaddingRight();
            paddingBottom = controller.getTotalPaddingBottom();
            if(this._blockProgression == BlockProgression.TB)
            {
               if(this._controllerLeft > 0)
               {
                  if(this._controllerLeft < paddingLeft)
                  {
                     this._controllerLeft = 0;
                  }
                  else
                  {
                     this._controllerLeft -= paddingLeft;
                  }
               }
               if(this._controllerTop > 0)
               {
                  if(this._controllerTop < paddingTop)
                  {
                     this._controllerTop = 0;
                  }
                  else
                  {
                     this._controllerTop -= paddingTop;
                  }
               }
               if(isNaN(controller.compositionWidth))
               {
                  this._controllerRight += paddingRight;
               }
               else if(this._controllerRight < controller.compositionWidth)
               {
                  if(this._controllerRight > controller.compositionWidth - paddingRight)
                  {
                     this._controllerRight = controller.compositionWidth;
                  }
                  else
                  {
                     this._controllerRight += paddingRight;
                  }
               }
               this._controllerBottom += paddingBottom;
            }
            else
            {
               this._controllerLeft -= paddingLeft;
               if(this._controllerTop > 0)
               {
                  if(this._controllerTop < paddingTop)
                  {
                     this._controllerTop = 0;
                  }
                  else
                  {
                     this._controllerTop -= paddingTop;
                  }
               }
               if(this._controllerRight < 0)
               {
                  if(this._controllerRight > -paddingRight)
                  {
                     this._controllerRight = 0;
                  }
                  else
                  {
                     this._controllerRight += paddingRight;
                  }
               }
               if(isNaN(controller.compositionHeight))
               {
                  this._controllerBottom += paddingBottom;
               }
               else if(this._controllerBottom < controller.compositionHeight)
               {
                  if(this._controllerBottom > controller.compositionHeight - paddingBottom)
                  {
                     this._controllerBottom = controller.compositionHeight;
                  }
                  else
                  {
                     this._controllerBottom += paddingBottom;
                  }
               }
            }
            controller.setContentBounds(this._controllerLeft,this._controllerTop,this._controllerRight - this._controllerLeft,this._controllerBottom - this._controllerTop);
         }
         else
         {
            controller.setContentBounds(0,0,0,0);
         }
         controller.setTextLength(controllerTextLength);
         controller.finalParcelStart = this._curParcelStart;
      }
      
      private function clearControllers(oldController:ContainerController, newController:ContainerController) : void
      {
         var controllerToClear:ContainerController = null;
         var firstToClear:int = !!oldController ? int(this._flowComposer.getControllerIndex(oldController) + 1) : 0;
         var lastToClear:int = !!newController ? int(this._flowComposer.getControllerIndex(newController)) : int(this._flowComposer.numControllers - 1);
         while(firstToClear <= lastToClear)
         {
            controllerToClear = ContainerController(this._flowComposer.getControllerAt(firstToClear));
            controllerToClear.setContentBounds(0,0,0,0);
            controllerToClear.setTextLength(0);
            controllerToClear.clearComposedLines(controllerToClear.absoluteStart);
            controllerToClear.clearFloatsAt(controllerToClear.absoluteStart);
            firstToClear++;
         }
      }
      
      protected function advanceToNextParcel() : void
      {
         this.parcelHasChanged(!!this._parcelList.atLast() ? null : this._parcelList.getParcelAt(this._parcelList.currentParcelIndex + 1));
         this._parcelList.next();
      }
      
      protected function advanceToNextContainer() : void
      {
         var newController:ContainerController = null;
         var newParcel:Parcel = !!this._parcelList.atLast() ? null : this._parcelList.getParcelAt(this._parcelList.currentParcelIndex + 1);
         for(var oldController:ContainerController = !!this._curParcel ? ContainerController(this._curParcel.controller) : null; !this._parcelList.atLast(); )
         {
            newParcel = !!this._parcelList.atLast() ? null : this._parcelList.getParcelAt(this._parcelList.currentParcelIndex + 1);
            newController = !!newParcel ? ContainerController(newParcel.controller) : null;
            if(oldController != newController)
            {
               break;
            }
            this._parcelList.next();
         }
         this.parcelHasChanged(!!this._parcelList.atLast() ? null : this._parcelList.getParcelAt(this._parcelList.currentParcelIndex + 1));
         this._parcelList.next();
      }
      
      protected function parcelHasChanged(newParcel:Parcel) : void
      {
         var oldController:ContainerController = !!this._curParcel ? ContainerController(this._curParcel.controller) : null;
         var newController:ContainerController = !!newParcel ? ContainerController(newParcel.controller) : null;
         if(oldController != null && this._lastGoodStart != -1)
         {
            oldController.clearFloatsAt(this._lastGoodStart);
            this._curLine = null;
            this._linePass = 0;
            this._pushInFloats.length = 0;
         }
         if(this._curParcel != null)
         {
            if(this.finishParcel(oldController,newParcel))
            {
               if(this._parcelLeft < this._controllerLeft)
               {
                  this._controllerLeft = this._parcelLeft;
               }
               if(this._parcelRight > this._controllerRight)
               {
                  this._controllerRight = this._parcelRight;
               }
               if(this._parcelTop < this._controllerTop)
               {
                  this._controllerTop = this._parcelTop;
               }
               if(this._parcelBottom > this._controllerBottom)
               {
                  this._controllerBottom = this._parcelBottom;
               }
            }
         }
         if(oldController != newController)
         {
            if(oldController)
            {
               this.finishController(oldController);
            }
            this.resetControllerBounds();
            if(this._flowComposer.numControllers > 1)
            {
               if(oldController == null && this._startController)
               {
                  this.clearControllers(this._startController,newController);
               }
               else
               {
                  this.clearControllers(oldController,newController);
               }
            }
            if(newController)
            {
               if(oldController)
               {
                  this._startComposePosition = newController.absoluteStart;
               }
               this._curInteractiveObjects = newController.interactiveObjects;
               this.calculateControllerVisibleBounds(newController);
            }
         }
         this._curParcel = newParcel;
         this._curParcelStart = this._curElementStart + this._curElementOffset;
         this._atColumnStart = true;
         this._workingTotalDepth = 0;
         if(newController)
         {
            this._verticalSpaceCarried = this._blockProgression == BlockProgression.RL ? Number(newController.getTotalPaddingRight()) : Number(newController.getTotalPaddingTop());
            this._measuring = this._blockProgression == BlockProgression.TB && newController.measureWidth || this._blockProgression == BlockProgression.RL && newController.measureHeight;
         }
      }
      
      private function calculateControllerVisibleBounds(controller:ContainerController) : void
      {
         var width:Number = !!controller.measureWidth ? Number(Number.MAX_VALUE) : Number(controller.compositionWidth);
         var xScroll:Number = controller.horizontalScrollPosition;
         this._controllerVisibleBoundsXTW = Twips.roundTo(this._blockProgression == BlockProgression.RL ? Number(xScroll - width) : Number(xScroll));
         this._controllerVisibleBoundsYTW = Twips.roundTo(controller.verticalScrollPosition);
         this._controllerVisibleBoundsWidthTW = !!controller.measureWidth ? int(int.MAX_VALUE) : int(Twips.to(controller.compositionWidth));
         this._controllerVisibleBoundsHeightTW = !!controller.measureHeight ? int(int.MAX_VALUE) : int(Twips.to(controller.compositionHeight));
      }
      
      private function getLineAdjustmentForInline(curTextLine:TextLine, curLeadingDir:String, isFirstLine:Boolean) : LeadingAdjustment
      {
         var inlineImg:InlineGraphicElement = null;
         var domBaseline:String = null;
         var curAdjustment:LeadingAdjustment = null;
         var tempSize:Number = NaN;
         var adjustment:LeadingAdjustment = null;
         var para:ParagraphElement = this._curLine.paragraph;
         var flowElem:FlowLeafElement = this._curElement;
         var curPos:int = flowElem.getAbsoluteStart();
         var largestPointSize:Number = flowElem.getEffectiveFontSize();
         var largestImg:Number = 0;
         while(flowElem && curPos < this._curLine.absoluteStart + this._curLine.textLength)
         {
            if(curPos >= this._curLine.absoluteStart || curPos + flowElem.textLength >= this._curLine.absoluteStart)
            {
               if(flowElem is InlineGraphicElement)
               {
                  inlineImg = flowElem as InlineGraphicElement;
                  if(inlineImg.effectiveFloat == Float.NONE && !(this._blockProgression == BlockProgression.RL && flowElem.parent is TCYElement))
                  {
                     if(largestImg < inlineImg.getEffectiveFontSize())
                     {
                        largestImg = inlineImg.getEffectiveFontSize();
                        if(largestImg >= largestPointSize)
                        {
                           largestImg = largestImg;
                           domBaseline = flowElem.computedFormat.dominantBaseline;
                           if(domBaseline == FormatValue.AUTO)
                           {
                              domBaseline = LocaleUtil.dominantBaseline(para.computedFormat.locale);
                           }
                           if(domBaseline == TextBaseline.IDEOGRAPHIC_CENTER)
                           {
                              curAdjustment = this.calculateLinePlacementAdjustment(curTextLine,domBaseline,curLeadingDir,inlineImg,isFirstLine);
                              if(!adjustment || Math.abs(curAdjustment.rise) > Math.abs(adjustment.rise) || Math.abs(curAdjustment.leading) > Math.abs(adjustment.leading))
                              {
                                 if(adjustment)
                                 {
                                    adjustment.rise = curAdjustment.rise;
                                    adjustment.leading = curAdjustment.leading;
                                 }
                                 else
                                 {
                                    adjustment = curAdjustment;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               else
               {
                  tempSize = flowElem.getEffectiveFontSize();
                  if(largestPointSize <= tempSize)
                  {
                     largestPointSize = tempSize;
                  }
                  if(adjustment && largestImg < largestPointSize)
                  {
                     adjustment.leading = 0;
                     adjustment.rise = 0;
                  }
               }
            }
            curPos += flowElem.textLength;
            flowElem = flowElem.getNextLeaf(para);
         }
         return adjustment;
      }
      
      public function get swfContext() : ISWFContext
      {
         var composerContext:ISWFContext = this._flowComposer.swfContext;
         return !!composerContext ? composerContext : GlobalSWFContext.globalSWFContext;
      }
      
      private function calculateLinePlacementAdjustment(curTextLine:TextLine, domBaseline:String, curLeadingDir:String, inlineImg:InlineGraphicElement, isFirstLine:Boolean) : LeadingAdjustment
      {
         var curAdjustment:LeadingAdjustment = new LeadingAdjustment();
         var imgHeight:Number = inlineImg.getEffectiveLineHeight(this._blockProgression);
         var lineLeading:Number = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(inlineImg.computedFormat.lineHeight,curTextLine.textHeight);
         if(domBaseline == TextBaseline.IDEOGRAPHIC_CENTER)
         {
            if(!isFirstLine)
            {
               curAdjustment.rise += (imgHeight - lineLeading) / 2;
            }
            else
            {
               curAdjustment.leading -= (imgHeight - lineLeading) / 2;
            }
         }
         return curAdjustment;
      }
      
      protected function pushInsideListItemMargins(numberLine:TextLine) : void
      {
         var numberLineWidth:Number = NaN;
         if(numberLine && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
         {
            numberLineWidth = TextFlowLine.getNumberLineInsideLineWidth(numberLine);
            this._parcelList.pushInsideListItemMargin(numberLineWidth);
         }
      }
      
      protected function popInsideListItemMargins(numberLine:TextLine) : void
      {
         var numberLineWidth:Number = NaN;
         if(numberLine && this._listItemElement.computedFormat.listStylePosition == ListStylePosition.INSIDE)
         {
            numberLineWidth = TextFlowLine.getNumberLineInsideLineWidth(numberLine);
            this._parcelList.popInsideListItemMargin(numberLineWidth);
         }
      }
      
      private function gotoParcel(index:int, depth:Number = 0) : Boolean
      {
         this.parcelHasChanged(this._parcelList.getParcelAt(index));
         return this._parcelList.gotoParcel(index,depth);
      }
   }
}

import flash.text.engine.TextLine;
import flashx.textLayout.compose.TextFlowLine;

class AlignData
{
    
   
   public var textFlowLine:TextFlowLine;
   
   public var textLine:TextLine;
   
   public var lineWidth:Number;
   
   public var textAlign:String;
   
   public var leftSideGap:Number;
   
   public var rightSideGap:Number;
   
   public var textIndent:Number;
   
   function AlignData(tfl:TextFlowLine)
   {
      super();
      this.textFlowLine = tfl;
   }
}

import flashx.textLayout.compose.ISWFContext;

class GlobalSWFContext implements ISWFContext
{
   
   public static const globalSWFContext:GlobalSWFContext = new GlobalSWFContext();
    
   
   function GlobalSWFContext()
   {
      super();
   }
   
   public function callInContext(fn:Function, thisArg:Object, argsArray:Array, returns:Boolean = true) : *
   {
      if(returns)
      {
         return fn.apply(thisArg,argsArray);
      }
      fn.apply(thisArg,argsArray);
   }
}

class LeadingAdjustment
{
    
   
   public var rise:Number = 0;
   
   public var leading:Number = 0;
   
   public var lineHeight:Number = 0;
   
   function LeadingAdjustment()
   {
      super();
   }
}
