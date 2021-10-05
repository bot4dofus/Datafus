package flashx.textLayout.utils
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextRotation;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.compose.TextFlowTableBlock;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.container.ScrollPolicy;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class NavigationUtil
   {
       
      
      public function NavigationUtil()
      {
         super();
      }
      
      private static function validateTextRange(range:TextRange) : Boolean
      {
         return range.textFlow != null && range.anchorPosition != -1 && range.activePosition != -1;
      }
      
      private static function doIncrement(flowRoot:TextFlow, pos:int, incrementer:Function) : int
      {
         var para:ParagraphElement = flowRoot.findAbsoluteParagraph(pos);
         return incrementer(flowRoot,para,pos,para.getAbsoluteStart());
      }
      
      private static function previousAtomHelper(flowRoot:TextFlow, para:ParagraphElement, pos:int, paraStart:int) : int
      {
         if(pos - paraStart == 0)
         {
            return pos > 0 ? int(pos - 1) : 0;
         }
         var paraEnd:Number = para.getAbsoluteStart() + para.textLength;
         para.getTextFlow().flowComposer.composeToPosition(paraEnd);
         return para.findPreviousAtomBoundary(pos - paraStart) + paraStart;
      }
      
      public static function previousAtomPosition(flowRoot:TextFlow, absolutePos:int) : int
      {
         return doIncrement(flowRoot,absolutePos,previousAtomHelper);
      }
      
      private static function nextAtomHelper(flowRoot:TextFlow, para:ParagraphElement, pos:int, paraStart:int) : int
      {
         if(pos - paraStart == para.textLength - 1)
         {
            return Math.min(flowRoot.textLength,pos + 1);
         }
         var paraEnd:Number = para.getAbsoluteStart() + para.textLength;
         para.getTextFlow().flowComposer.composeToPosition(paraEnd);
         return para.findNextAtomBoundary(pos - paraStart) + paraStart;
      }
      
      public static function nextAtomPosition(flowRoot:TextFlow, absolutePos:int) : int
      {
         return doIncrement(flowRoot,absolutePos,nextAtomHelper);
      }
      
      public static function previousWordPosition(flowRoot:TextFlow, absolutePos:int) : int
      {
         if(isOverset(flowRoot,absolutePos))
         {
            return endOfLastController(flowRoot);
         }
         var para:ParagraphElement = flowRoot.findAbsoluteParagraph(absolutePos);
         var paraStart:int = para.getAbsoluteStart();
         var paraEnd:Number = para.getAbsoluteStart() + para.textLength;
         para.getTextFlow().flowComposer.composeToPosition(paraEnd);
         var prevWordPos:int = absolutePos - paraStart;
         var nextWordPos:int = 0;
         if(absolutePos - paraStart == 0)
         {
            return absolutePos > 0 ? int(absolutePos - 1) : 0;
         }
         do
         {
            nextWordPos = para.findPreviousWordBoundary(prevWordPos);
            if(prevWordPos == nextWordPos)
            {
               prevWordPos = para.findPreviousWordBoundary(prevWordPos - 1);
            }
            else
            {
               prevWordPos = nextWordPos;
            }
         }
         while(prevWordPos > 0 && CharacterUtil.isWhitespace(para.getCharCodeAtPosition(prevWordPos)));
         
         return prevWordPos + paraStart;
      }
      
      public static function nextWordPosition(flowRoot:TextFlow, absolutePos:int) : int
      {
         var para:ParagraphElement = flowRoot.findAbsoluteParagraph(absolutePos);
         var paraStart:int = para.getAbsoluteStart();
         var paraEnd:Number = para.getAbsoluteStart() + para.textLength;
         para.getTextFlow().flowComposer.composeToPosition(paraEnd);
         var nextWordPos:int = absolutePos - paraStart;
         if(absolutePos - paraStart == para.textLength - 1)
         {
            return Math.min(flowRoot.textLength,absolutePos + 1);
         }
         do
         {
            nextWordPos = para.findNextWordBoundary(nextWordPos);
         }
         while(nextWordPos < para.textLength - 1 && CharacterUtil.isWhitespace(para.getCharCodeAtPosition(nextWordPos)));
         
         return nextWordPos + paraStart;
      }
      
      tlf_internal static function updateStartIfInReadOnlyElement(textFlow:TextFlow, idx:int) : int
      {
         return idx;
      }
      
      tlf_internal static function updateEndIfInReadOnlyElement(textFlow:TextFlow, idx:int) : int
      {
         return idx;
      }
      
      private static function moveForwardHelper(range:TextRange, extendSelection:Boolean, incrementor:Function) : Boolean
      {
         var textFlow:TextFlow = range.textFlow;
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         if(extendSelection)
         {
            endIdx = incrementor(textFlow,endIdx);
         }
         else if(begIdx == endIdx)
         {
            begIdx = incrementor(textFlow,begIdx);
            endIdx = begIdx;
         }
         else if(endIdx > begIdx)
         {
            begIdx = endIdx;
         }
         else
         {
            endIdx = begIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateStartIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         if(!extendSelection && range.anchorPosition == begIdx && range.activePosition == endIdx)
         {
            if(begIdx < endIdx)
            {
               begIdx = Math.min(endIdx + 1,textFlow.textLength - 1);
               endIdx = begIdx;
            }
            else
            {
               endIdx = Math.min(begIdx + 1,textFlow.textLength - 1);
               begIdx = endIdx;
            }
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      private static function moveBackwardHelper(range:TextRange, extendSelection:Boolean, incrementor:Function) : Boolean
      {
         var textFlow:TextFlow = range.textFlow;
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         if(extendSelection)
         {
            endIdx = incrementor(textFlow,endIdx);
         }
         else if(begIdx == endIdx)
         {
            begIdx = incrementor(textFlow,begIdx);
            endIdx = begIdx;
         }
         else if(endIdx > begIdx)
         {
            endIdx = begIdx;
         }
         else
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         if(!extendSelection && range.anchorPosition == begIdx && range.activePosition == endIdx)
         {
            if(begIdx < endIdx)
            {
               endIdx = Math.max(begIdx - 1,0);
               begIdx = endIdx;
            }
            else
            {
               begIdx = Math.max(endIdx - 1,0);
               endIdx = begIdx;
            }
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function nextCharacter(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(validateTextRange(range))
         {
            if(!adjustForOversetForward(range))
            {
               moveForwardHelper(range,extendSelection,nextAtomPosition);
            }
            return true;
         }
         return false;
      }
      
      public static function previousCharacter(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(validateTextRange(range))
         {
            if(!adjustForOversetBack(range))
            {
               moveBackwardHelper(range,extendSelection,previousAtomPosition);
            }
            return true;
         }
         return false;
      }
      
      public static function nextWord(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(validateTextRange(range))
         {
            if(!adjustForOversetForward(range))
            {
               moveForwardHelper(range,extendSelection,nextWordPosition);
            }
            return true;
         }
         return false;
      }
      
      public static function previousWord(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(validateTextRange(range))
         {
            if(!adjustForOversetBack(range))
            {
               moveBackwardHelper(range,extendSelection,previousWordPosition);
            }
            return true;
         }
         return false;
      }
      
      tlf_internal static function computeEndIdx(targetFlowLine:TextFlowLine, curTextFlowLine:TextFlowLine, blockProgression:String, isRTLDirection:Boolean, globalPoint:Point) : int
      {
         var endIdx:int = 0;
         var atomIndex:int = 0;
         var firstAtomRect:Rectangle = null;
         var firstAtomPoint:Point = null;
         var glyphRect:Rectangle = null;
         var leanRight:* = false;
         var paraSelectionIdx:int = 0;
         var glyphGlobalPoint:Point = null;
         var targetTextLine:TextLine = targetFlowLine.getTextLine(true);
         var blockOffset:int = targetFlowLine.paragraph.getTextBlockAbsoluteStart(targetTextLine.textBlock);
         var currentTextLine:TextLine = curTextFlowLine.getTextLine(true);
         var bidiRightToLeft:* = currentTextLine.getAtomBidiLevel(atomIndex) % 2 != 0;
         if(targetFlowLine.controller == curTextFlowLine.controller)
         {
            if(blockProgression != BlockProgression.RL)
            {
               globalPoint.y -= currentTextLine.y - targetTextLine.y;
            }
            else
            {
               globalPoint.x += targetTextLine.x - currentTextLine.x;
            }
         }
         else
         {
            firstAtomRect = targetTextLine.getAtomBounds(0);
            firstAtomPoint = new Point();
            firstAtomPoint.x = firstAtomRect.left;
            firstAtomPoint.y = 0;
            firstAtomPoint = targetTextLine.localToGlobal(firstAtomPoint);
            if(blockProgression != BlockProgression.RL)
            {
               globalPoint.x -= curTextFlowLine.controller.container.x;
               globalPoint.y = firstAtomPoint.y;
            }
            else
            {
               globalPoint.x = firstAtomPoint.x;
               globalPoint.y -= curTextFlowLine.controller.container.y;
            }
         }
         atomIndex = targetTextLine.getAtomIndexAtPoint(globalPoint.x,globalPoint.y);
         if(atomIndex == -1)
         {
            if(blockProgression != BlockProgression.RL)
            {
               if(!bidiRightToLeft)
               {
                  endIdx = globalPoint.x <= targetTextLine.x ? int(targetFlowLine.absoluteStart) : int(targetFlowLine.absoluteStart + targetFlowLine.textLength - 1);
               }
               else
               {
                  endIdx = globalPoint.x <= targetTextLine.x ? int(targetFlowLine.absoluteStart + targetFlowLine.textLength - 1) : int(targetFlowLine.absoluteStart);
               }
            }
            else if(!bidiRightToLeft)
            {
               endIdx = globalPoint.y <= targetTextLine.y ? int(targetFlowLine.absoluteStart) : int(targetFlowLine.absoluteStart + targetFlowLine.textLength - 1);
            }
            else
            {
               endIdx = globalPoint.y <= targetTextLine.y ? int(targetFlowLine.absoluteStart + targetFlowLine.textLength - 1) : int(targetFlowLine.absoluteStart);
            }
         }
         else
         {
            glyphRect = targetTextLine.getAtomBounds(atomIndex);
            leanRight = false;
            if(glyphRect)
            {
               glyphGlobalPoint = new Point();
               glyphGlobalPoint.x = glyphRect.x;
               glyphGlobalPoint.y = glyphRect.y;
               glyphGlobalPoint = targetTextLine.localToGlobal(glyphGlobalPoint);
               if(blockProgression == BlockProgression.RL && targetTextLine.getAtomTextRotation(atomIndex) != TextRotation.ROTATE_0)
               {
                  leanRight = globalPoint.y > glyphGlobalPoint.y + glyphRect.height / 2;
               }
               else
               {
                  leanRight = globalPoint.x > glyphGlobalPoint.x + glyphRect.width / 2;
               }
            }
            if(targetTextLine.getAtomBidiLevel(atomIndex) % 2 != 0)
            {
               paraSelectionIdx = !!leanRight ? int(targetTextLine.getAtomTextBlockBeginIndex(atomIndex)) : int(targetTextLine.getAtomTextBlockEndIndex(atomIndex));
            }
            else if(isRTLDirection)
            {
               if(leanRight == false && atomIndex > 0)
               {
                  paraSelectionIdx = targetTextLine.getAtomTextBlockBeginIndex(atomIndex - 1);
               }
               else
               {
                  paraSelectionIdx = targetTextLine.getAtomTextBlockBeginIndex(atomIndex);
               }
            }
            else
            {
               paraSelectionIdx = !!leanRight ? int(targetTextLine.getAtomTextBlockEndIndex(atomIndex)) : int(targetTextLine.getAtomTextBlockBeginIndex(atomIndex));
            }
            endIdx = blockOffset + paraSelectionIdx;
         }
         return endIdx;
      }
      
      public static function nextLine(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var curTextFlowLine:TextFlowLine = null;
         var lineStart:int = 0;
         var lineDelta:int = 0;
         var currentTextLine:TextLine = null;
         var blockOffset:int = 0;
         var atomIndex:int = 0;
         var bidiRightToLeft:* = false;
         var curPosRect:Rectangle = null;
         var currentTextLineX:Number = NaN;
         var curPosRectLeft:Number = NaN;
         var curPosRectRight:Number = NaN;
         var globalPoint:Point = null;
         var lineInc:int = 0;
         var nextFlowLine:TextFlowLine = null;
         var controller:ContainerController = null;
         var firstPosInContainer:int = 0;
         var lastPosInContainer:int = 0;
         var curLogicalHorizontalScrollPos:Number = NaN;
         if(!validateTextRange(range))
         {
            return false;
         }
         if(adjustForOversetForward(range))
         {
            return true;
         }
         var textFlow:TextFlow = range.textFlow;
         var blockProgression:String = textFlow.computedFormat.blockProgression;
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var limitIdx:int = endOfLastController(textFlow);
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var isRTLDirection:* = textFlow.computedFormat.direction == Direction.RTL;
         if(curLine < textFlow.flowComposer.numLines - 1)
         {
            curTextFlowLine = textFlow.flowComposer.getLineAt(curLine);
            lineStart = curTextFlowLine.absoluteStart;
            lineDelta = endIdx - lineStart;
            currentTextLine = curTextFlowLine.getTextLine(true);
            blockOffset = curTextFlowLine.paragraph.getTextBlockAbsoluteStart(currentTextLine.textBlock);
            atomIndex = currentTextLine.getAtomIndexAtCharIndex(endIdx - blockOffset);
            bidiRightToLeft = currentTextLine.getAtomBidiLevel(atomIndex) % 2 != 0;
            curPosRect = currentTextLine.getAtomBounds(atomIndex);
            currentTextLineX = currentTextLine.x;
            curPosRectLeft = curPosRect.left;
            curPosRectRight = curPosRect.right;
            if(blockProgression == BlockProgression.RL)
            {
               currentTextLineX = currentTextLine.y;
               curPosRectLeft = curPosRect.top;
               curPosRectRight = curPosRect.bottom;
            }
            globalPoint = new Point();
            if(blockProgression != BlockProgression.RL)
            {
               if(!isRTLDirection)
               {
                  globalPoint.x = curPosRect.left;
               }
               else
               {
                  globalPoint.x = curPosRect.right;
               }
               globalPoint.y = 0;
            }
            else
            {
               globalPoint.x = 0;
               if(!isRTLDirection)
               {
                  globalPoint.y = curPosRect.top;
               }
               else
               {
                  globalPoint.y = curPosRect.bottom;
               }
            }
            globalPoint = currentTextLine.localToGlobal(globalPoint);
            lineInc = 1;
            nextFlowLine = textFlow.flowComposer.getLineAt(curLine + lineInc);
            while(nextFlowLine is TextFlowTableBlock)
            {
               nextFlowLine = textFlow.flowComposer.getLineAt(++lineInc + curLine);
            }
            if(!nextFlowLine || nextFlowLine.absoluteStart >= limitIdx)
            {
               if(!extendSelection)
               {
                  range.activePosition = range.anchorPosition = textFlow.textLength - 1;
               }
               else
               {
                  range.activePosition = textFlow.textLength;
               }
               return true;
            }
            controller = textFlow.flowComposer.getControllerAt(textFlow.flowComposer.numControllers - 1);
            firstPosInContainer = controller.absoluteStart;
            lastPosInContainer = firstPosInContainer + controller.textLength;
            if(nextFlowLine.absoluteStart >= firstPosInContainer && nextFlowLine.absoluteStart < lastPosInContainer)
            {
               if(nextFlowLine.isDamaged())
               {
                  textFlow.flowComposer.composeToPosition(nextFlowLine.absoluteStart + 1);
                  nextFlowLine = textFlow.flowComposer.getLineAt(curLine + 1);
                  if(nextFlowLine.isDamaged())
                  {
                     return false;
                  }
               }
               curLogicalHorizontalScrollPos = blockProgression == BlockProgression.TB ? Number(controller.horizontalScrollPosition) : Number(controller.verticalScrollPosition);
               controller.scrollToRange(nextFlowLine.absoluteStart,nextFlowLine.absoluteStart + nextFlowLine.textLength - 1);
               if(blockProgression == BlockProgression.TB)
               {
                  controller.horizontalScrollPosition = curLogicalHorizontalScrollPos;
               }
               else
               {
                  controller.verticalScrollPosition = curLogicalHorizontalScrollPos;
               }
            }
            endIdx = computeEndIdx(nextFlowLine,curTextFlowLine,blockProgression,isRTLDirection,globalPoint);
            if(endIdx >= textFlow.textLength)
            {
               endIdx = textFlow.textLength;
            }
         }
         else
         {
            endIdx = textFlow.textLength;
         }
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateStartIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function previousLine(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var curTextFlowLine:TextFlowLine = null;
         var lineStart:int = 0;
         var lineDelta:int = 0;
         var currentTextLine:TextLine = null;
         var blockOffset:int = 0;
         var atomIndex:int = 0;
         var curPosRect:Rectangle = null;
         var currentTextLineX:Number = NaN;
         var curPosRectLeft:Number = NaN;
         var curPosRectRight:Number = NaN;
         var globalPoint:Point = null;
         var lineInc:int = 0;
         var prevFlowLine:TextFlowLine = null;
         var controller:ContainerController = null;
         var firstPosInContainer:int = 0;
         var lastPosInContainer:int = 0;
         var curLogicalHorizontalScrollPos:Number = NaN;
         if(!validateTextRange(range))
         {
            return false;
         }
         if(adjustForOversetBack(range))
         {
            return true;
         }
         var textFlow:TextFlow = range.textFlow;
         var blockProgression:String = textFlow.computedFormat.blockProgression;
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var isRTLDirection:* = textFlow.computedFormat.direction == Direction.RTL;
         if(curLine > 0)
         {
            curTextFlowLine = textFlow.flowComposer.getLineAt(curLine);
            lineStart = curTextFlowLine.absoluteStart;
            lineDelta = endIdx - lineStart;
            currentTextLine = curTextFlowLine.getTextLine(true);
            blockOffset = curTextFlowLine.paragraph.getTextBlockAbsoluteStart(currentTextLine.textBlock);
            atomIndex = currentTextLine.getAtomIndexAtCharIndex(endIdx - blockOffset);
            curPosRect = currentTextLine.getAtomBounds(atomIndex);
            currentTextLineX = currentTextLine.x;
            curPosRectLeft = curPosRect.left;
            curPosRectRight = curPosRect.right;
            if(blockProgression == BlockProgression.RL)
            {
               currentTextLineX = currentTextLine.y;
               curPosRectLeft = curPosRect.top;
               curPosRectRight = curPosRect.bottom;
            }
            globalPoint = new Point();
            if(blockProgression != BlockProgression.RL)
            {
               if(!isRTLDirection)
               {
                  globalPoint.x = curPosRect.left;
               }
               else
               {
                  globalPoint.x = curPosRect.right;
               }
               globalPoint.y = 0;
            }
            else
            {
               globalPoint.x = 0;
               if(!isRTLDirection)
               {
                  globalPoint.y = curPosRect.top;
               }
               else
               {
                  globalPoint.y = curPosRect.bottom;
               }
            }
            globalPoint = currentTextLine.localToGlobal(globalPoint);
            lineInc = 1;
            prevFlowLine = textFlow.flowComposer.getLineAt(curLine - lineInc);
            while(prevFlowLine is TextFlowTableBlock)
            {
               prevFlowLine = textFlow.flowComposer.getLineAt(curLine - ++lineInc);
            }
            if(!prevFlowLine)
            {
               if(!extendSelection)
               {
                  range.activePosition = range.anchorPosition = 0;
               }
               else
               {
                  range.activePosition = 0;
               }
               return true;
            }
            controller = textFlow.flowComposer.getControllerAt(textFlow.flowComposer.numControllers - 1);
            firstPosInContainer = controller.absoluteStart;
            lastPosInContainer = firstPosInContainer + controller.textLength;
            if(prevFlowLine.absoluteStart >= firstPosInContainer && prevFlowLine.absoluteStart < lastPosInContainer)
            {
               curLogicalHorizontalScrollPos = blockProgression == BlockProgression.TB ? Number(controller.horizontalScrollPosition) : Number(controller.verticalScrollPosition);
               controller.scrollToRange(prevFlowLine.absoluteStart,prevFlowLine.absoluteStart + prevFlowLine.textLength - 1);
               if(blockProgression == BlockProgression.TB)
               {
                  controller.horizontalScrollPosition = curLogicalHorizontalScrollPos;
               }
               else
               {
                  controller.verticalScrollPosition = curLogicalHorizontalScrollPos;
               }
            }
            endIdx = computeEndIdx(prevFlowLine,curTextFlowLine,blockProgression,isRTLDirection,globalPoint);
         }
         else
         {
            endIdx = 0;
         }
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateStartIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateEndIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function nextPage(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var controller:ContainerController = null;
         var nextLine:int = 0;
         var amount:Number = NaN;
         var contentWidth:Number = NaN;
         var oldHorzScrollPos:Number = NaN;
         var newHorzScrollPos:Number = NaN;
         var contentHeight:Number = NaN;
         var oldVertScrollPos:Number = NaN;
         var newVertScrollPos:Number = NaN;
         if(!validateTextRange(range))
         {
            return false;
         }
         var textFlow:TextFlow = range.textFlow;
         var controllerIndex:int = textFlow.flowComposer.findControllerIndexAtPosition(range.activePosition);
         if(controllerIndex != textFlow.flowComposer.numControllers - 1)
         {
            range.activePosition = textFlow.flowComposer.getControllerAt(controllerIndex + 1).absoluteStart;
            if(!extendSelection)
            {
               range.anchorPosition = range.activePosition;
            }
            return true;
         }
         if(!isScrollable(textFlow,range.activePosition))
         {
            return false;
         }
         if(adjustForOversetForward(range))
         {
            return true;
         }
         var begIdx:int = range.absoluteStart;
         var endIdx:int = range.absoluteEnd;
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var curTextFlowLine:TextFlowLine = textFlow.flowComposer.getLineAt(curLine);
         var lineStart:int = textFlow.flowComposer.getLineAt(curLine).absoluteStart;
         var linePos:int = endIdx - lineStart;
         var nextTextFlowLine:TextFlowLine = curTextFlowLine;
         var isTTB:* = textFlow.computedFormat.blockProgression == BlockProgression.RL;
         controller = textFlow.flowComposer.getControllerAt(textFlow.flowComposer.numControllers - 1);
         if(isTTB)
         {
            amount = controller.compositionWidth * textFlow.configuration.scrollPagePercentage;
         }
         else
         {
            amount = controller.compositionHeight * textFlow.configuration.scrollPagePercentage;
         }
         if(isTTB)
         {
            contentWidth = controller.contentWidth;
            if(controller.horizontalScrollPosition - amount < -contentWidth)
            {
               controller.horizontalScrollPosition = -contentWidth;
               nextLine = textFlow.flowComposer.numLines - 1;
               nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
            }
            else
            {
               oldHorzScrollPos = controller.horizontalScrollPosition;
               controller.horizontalScrollPosition -= amount;
               newHorzScrollPos = controller.horizontalScrollPosition;
               if(oldHorzScrollPos == newHorzScrollPos)
               {
                  nextLine = textFlow.flowComposer.numLines - 1;
                  nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
               }
               else
               {
                  nextLine = curLine;
                  while(nextLine < textFlow.flowComposer.numLines - 1)
                  {
                     nextLine++;
                     nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
                     if(curTextFlowLine.x - nextTextFlowLine.x >= oldHorzScrollPos - newHorzScrollPos)
                     {
                        break;
                     }
                  }
               }
            }
         }
         else
         {
            contentHeight = controller.contentHeight;
            if(controller.verticalScrollPosition + amount > contentHeight)
            {
               controller.verticalScrollPosition = contentHeight;
               nextLine = textFlow.flowComposer.numLines - 1;
               nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
            }
            else
            {
               oldVertScrollPos = controller.verticalScrollPosition;
               controller.verticalScrollPosition += amount;
               newVertScrollPos = controller.verticalScrollPosition;
               if(newVertScrollPos == oldVertScrollPos)
               {
                  nextLine = textFlow.flowComposer.numLines - 1;
                  nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
               }
               else
               {
                  nextLine = curLine;
                  while(nextLine < textFlow.flowComposer.numLines - 1)
                  {
                     nextLine++;
                     nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
                     if(nextTextFlowLine.y - curTextFlowLine.y >= newVertScrollPos - oldVertScrollPos)
                     {
                        break;
                     }
                  }
               }
            }
         }
         endIdx = nextTextFlowLine.absoluteStart + linePos;
         var nextLineEnd:int = nextTextFlowLine.absoluteStart + nextTextFlowLine.textLength - 1;
         if(endIdx > nextLineEnd)
         {
            endIdx = nextLineEnd;
         }
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function previousPage(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var nextLine:int = 0;
         var amount:Number = NaN;
         var oldHorzPos:Number = NaN;
         var newHorzPos:Number = NaN;
         var oldVertPos:Number = NaN;
         var newVertPos:Number = NaN;
         if(!validateTextRange(range))
         {
            return false;
         }
         var textFlow:TextFlow = range.textFlow;
         var controllerIndex:int = textFlow.flowComposer.findControllerIndexAtPosition(range.activePosition);
         var controller:ContainerController = textFlow.flowComposer.getControllerAt(controllerIndex);
         var controllerFirstLine:TextFlowLine = textFlow.flowComposer.findLineAtPosition(controller.absoluteStart);
         if(range.activePosition <= controller.absoluteStart + controllerFirstLine.textLength)
         {
            if(controllerIndex == 0)
            {
               return false;
            }
            range.activePosition = textFlow.flowComposer.getControllerAt(controllerIndex - 1).absoluteStart;
            if(!extendSelection)
            {
               range.anchorPosition = range.activePosition;
            }
            return true;
         }
         if(controllerIndex != textFlow.flowComposer.numControllers - 1)
         {
            range.activePosition = controller.absoluteStart;
            if(!extendSelection)
            {
               range.anchorPosition = range.activePosition;
            }
            return true;
         }
         if(!isScrollable(textFlow,range.activePosition))
         {
            return false;
         }
         if(adjustForOversetBack(range))
         {
            return true;
         }
         var begIdx:int = range.absoluteStart;
         var endIdx:int = range.absoluteEnd;
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var curTextFlowLine:TextFlowLine = textFlow.flowComposer.getLineAt(curLine);
         var lineStart:int = textFlow.flowComposer.getLineAt(curLine).absoluteStart;
         var linePos:int = endIdx - lineStart;
         var nextTextFlowLine:TextFlowLine = curTextFlowLine;
         var isTTB:* = textFlow.computedFormat.blockProgression == BlockProgression.RL;
         controller = textFlow.flowComposer.getControllerAt(textFlow.flowComposer.numControllers - 1);
         if(isTTB)
         {
            amount = controller.compositionWidth * textFlow.configuration.scrollPagePercentage;
         }
         else
         {
            amount = controller.compositionHeight * textFlow.configuration.scrollPagePercentage;
         }
         if(isTTB)
         {
            if(controller.horizontalScrollPosition + amount + controller.compositionWidth > 0)
            {
               controller.horizontalScrollPosition = 0;
               nextLine = textFlow.flowComposer.findLineIndexAtPosition(controller.absoluteStart);
               nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
            }
            else
            {
               oldHorzPos = controller.horizontalScrollPosition;
               controller.horizontalScrollPosition += amount;
               newHorzPos = controller.horizontalScrollPosition;
               if(oldHorzPos == newHorzPos)
               {
                  nextLine = textFlow.flowComposer.findLineIndexAtPosition(controller.absoluteStart);
                  nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
               }
               else
               {
                  nextLine = curLine;
                  while(nextLine > 0)
                  {
                     nextLine--;
                     nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
                     if(nextTextFlowLine.x - curTextFlowLine.x >= newHorzPos - oldHorzPos || nextTextFlowLine.absoluteStart < controller.absoluteStart)
                     {
                        break;
                     }
                  }
               }
            }
         }
         else if(controller.verticalScrollPosition - amount + controller.compositionHeight < 0)
         {
            controller.verticalScrollPosition = 0;
            nextLine = textFlow.flowComposer.findLineIndexAtPosition(controller.absoluteStart);
            nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
         }
         else
         {
            oldVertPos = controller.verticalScrollPosition;
            controller.verticalScrollPosition -= amount;
            newVertPos = controller.verticalScrollPosition;
            if(oldVertPos == newVertPos)
            {
               nextLine = textFlow.flowComposer.findLineIndexAtPosition(controller.absoluteStart);
               nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
            }
            else
            {
               nextLine = curLine;
               while(nextLine > 0)
               {
                  nextLine--;
                  nextTextFlowLine = textFlow.flowComposer.getLineAt(nextLine);
                  if(curTextFlowLine.y - nextTextFlowLine.y >= oldVertPos - newVertPos || nextTextFlowLine.absoluteStart < controller.absoluteStart)
                  {
                     break;
                  }
               }
            }
         }
         endIdx = nextTextFlowLine.absoluteStart + linePos;
         var nextLineEnd:int = nextTextFlowLine.absoluteStart + nextTextFlowLine.textLength - 1;
         if(endIdx > nextLineEnd)
         {
            endIdx = nextLineEnd;
         }
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function endOfLine(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(!validateTextRange(range))
         {
            return false;
         }
         var textFlow:TextFlow = range.textFlow;
         checkCompose(textFlow.flowComposer,range.absoluteEnd);
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var lineStart:int = textFlow.flowComposer.getLineAt(curLine).absoluteStart;
         var lineEnd:int = lineStart + textFlow.flowComposer.getLineAt(curLine).textLength - 1;
         var leaf:FlowLeafElement = textFlow.findLeaf(endIdx);
         var para:ParagraphElement = leaf.getParagraph();
         if(CharacterUtil.isWhitespace(para.getCharCodeAtPosition(lineEnd - para.getAbsoluteStart())))
         {
            endIdx = lineEnd;
         }
         else
         {
            endIdx = lineEnd + 1;
         }
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function startOfLine(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(!validateTextRange(range))
         {
            return false;
         }
         var textFlow:TextFlow = range.textFlow;
         checkCompose(textFlow.flowComposer,range.absoluteEnd);
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var curLine:int = textFlow.flowComposer.findLineIndexAtPosition(endIdx);
         var lineStart:int = textFlow.flowComposer.getLineAt(curLine).absoluteStart;
         endIdx = lineStart;
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function endOfDocument(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(!validateTextRange(range))
         {
            return false;
         }
         var textFlow:TextFlow = range.textFlow;
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         endIdx = textFlow.textLength;
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function startOfDocument(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var begIdx:int = range.anchorPosition;
         var endIdx:int = 0;
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateEndIfInReadOnlyElement(range.textFlow,begIdx);
            endIdx = updateStartIfInReadOnlyElement(range.textFlow,endIdx);
         }
         else
         {
            endIdx = updateStartIfInReadOnlyElement(range.textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function startOfParagraph(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var leaf:FlowLeafElement = range.textFlow.findLeaf(endIdx);
         var para:ParagraphElement = leaf.getParagraph();
         endIdx = para.getAbsoluteStart();
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateStartIfInReadOnlyElement(range.textFlow,begIdx);
            endIdx = updateEndIfInReadOnlyElement(range.textFlow,endIdx);
         }
         else
         {
            endIdx = updateEndIfInReadOnlyElement(range.textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      public static function endOfParagraph(range:TextRange, extendSelection:Boolean = false) : Boolean
      {
         if(!validateTextRange(range))
         {
            return false;
         }
         var begIdx:int = range.anchorPosition;
         var endIdx:int = range.activePosition;
         var leaf:FlowLeafElement = range.textFlow.findLeaf(endIdx);
         var para:ParagraphElement = leaf.getParagraph();
         endIdx = para.getAbsoluteStart() + para.textLength - 1;
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = updateStartIfInReadOnlyElement(range.textFlow,begIdx);
            endIdx = updateEndIfInReadOnlyElement(range.textFlow,endIdx);
         }
         else
         {
            endIdx = updateEndIfInReadOnlyElement(range.textFlow,endIdx);
         }
         return range.updateRange(begIdx,endIdx);
      }
      
      private static function adjustForOversetForward(range:TextRange) : Boolean
      {
         var controllerIndex:int = 0;
         var flowComposer:IFlowComposer = range.textFlow.flowComposer;
         var controller:ContainerController = null;
         checkCompose(flowComposer,range.absoluteEnd);
         if(range.absoluteEnd >= flowComposer.damageAbsoluteStart - 1)
         {
            clampToFit(range,flowComposer.damageAbsoluteStart - 1);
            return false;
         }
         if(flowComposer && flowComposer.numControllers)
         {
            controllerIndex = flowComposer.findControllerIndexAtPosition(range.absoluteEnd);
            if(controllerIndex >= 0)
            {
               controller = flowComposer.getControllerAt(controllerIndex);
            }
            if(controllerIndex == flowComposer.numControllers - 1)
            {
               if(controller.absoluteStart + controller.textLength <= range.absoluteEnd && controller.absoluteStart + controller.textLength != range.textFlow.textLength)
               {
                  controller = null;
               }
            }
         }
         if(!controller)
         {
            range.anchorPosition = range.textFlow.textLength;
            range.activePosition = range.anchorPosition;
            return true;
         }
         return false;
      }
      
      private static function clampToFit(range:TextRange, endPos:int) : void
      {
         if(endPos < 0)
         {
            endPos = 0;
         }
         range.anchorPosition = Math.min(range.anchorPosition,endPos);
         range.activePosition = Math.min(range.activePosition,endPos);
      }
      
      private static function adjustForOversetBack(range:TextRange) : Boolean
      {
         var flowComposer:IFlowComposer = range.textFlow.flowComposer;
         if(flowComposer)
         {
            checkCompose(flowComposer,range.absoluteEnd);
            if(range.absoluteEnd > flowComposer.damageAbsoluteStart - 1)
            {
               clampToFit(range,flowComposer.damageAbsoluteStart - 1);
               return true;
            }
            if(flowComposer.findControllerIndexAtPosition(range.absoluteEnd) == -1)
            {
               range.anchorPosition = endOfLastController(range.textFlow);
               range.activePosition = range.anchorPosition;
               return true;
            }
         }
         return false;
      }
      
      private static function checkCompose(flowComposer:IFlowComposer, pos:int) : void
      {
         if(flowComposer.damageAbsoluteStart <= pos)
         {
            flowComposer.composeToPosition(pos);
         }
      }
      
      private static function endOfLastController(flowRoot:TextFlow) : int
      {
         var flowComposer:IFlowComposer = flowRoot.flowComposer;
         if(!flowComposer || flowComposer.numControllers <= 0)
         {
            return 0;
         }
         var controller:ContainerController = flowComposer.getControllerAt(flowComposer.numControllers - 1);
         return controller.absoluteStart + Math.max(controller.textLength - 1,0);
      }
      
      private static function isOverset(flowRoot:TextFlow, absolutePos:int) : Boolean
      {
         var flowComposer:IFlowComposer = flowRoot.flowComposer;
         return !flowComposer || flowComposer.findControllerIndexAtPosition(absolutePos) == -1;
      }
      
      private static function isScrollable(flowRoot:TextFlow, absolutePos:int) : Boolean
      {
         var controller:ContainerController = null;
         var blockProgression:String = null;
         var flowComposer:IFlowComposer = flowRoot.flowComposer;
         if(!flowComposer)
         {
            return false;
         }
         var controllerIndex:int = flowComposer.findControllerIndexAtPosition(absolutePos);
         if(controllerIndex >= 0)
         {
            controller = flowComposer.getControllerAt(controllerIndex);
            blockProgression = controller.rootElement.computedFormat.blockProgression;
            return blockProgression == BlockProgression.TB && controller.verticalScrollPolicy != ScrollPolicy.OFF || blockProgression == BlockProgression.RL && controller.horizontalScrollPolicy != ScrollPolicy.OFF;
         }
         return false;
      }
   }
}
