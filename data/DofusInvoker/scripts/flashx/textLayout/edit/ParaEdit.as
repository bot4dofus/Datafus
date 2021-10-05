package flashx.textLayout.edit
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableLeafElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class ParaEdit
   {
       
      
      public function ParaEdit()
      {
         super();
      }
      
      public static function insertText(textFlow:TextFlow, absoluteStart:int, insertText:String, createNewSpan:Boolean) : SpanElement
      {
         var siblingIndex:int = 0;
         var subParInsertionPoint:int = 0;
         var newSpan:SpanElement = null;
         var insertIdx:int = 0;
         var nextLeaf:FlowLeafElement = null;
         var formatElem:FlowLeafElement = null;
         var relativeStart:int = 0;
         if(insertText.length == 0)
         {
            return null;
         }
         var sibling:FlowElement = textFlow.findLeaf(absoluteStart);
         var paragraph:ParagraphElement = sibling.getParagraph();
         var paraStart:int = paragraph.getAbsoluteStart();
         var paraSelBegIdx:int = absoluteStart - paraStart;
         if(paraStart == absoluteStart)
         {
            siblingIndex = 0;
         }
         else
         {
            if(paraSelBegIdx == sibling.getElementRelativeStart(paragraph))
            {
               sibling = FlowLeafElement(sibling).getPreviousLeaf(paragraph);
            }
            if(sibling is TableLeafElement)
            {
               siblingIndex = sibling.parent.parent.getChildIndex(sibling.parent) + 1;
            }
            else
            {
               siblingIndex = sibling.parent.getChildIndex(sibling) + 1;
            }
         }
         var insertParent:FlowGroupElement = sibling.parent;
         if(insertParent is TableElement)
         {
            insertParent = insertParent.parent;
         }
         var curSPGElement:SubParagraphGroupElementBase = sibling.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
         while(curSPGElement != null)
         {
            subParInsertionPoint = paraSelBegIdx - curSPGElement.getElementRelativeStart(paragraph);
            if(!(subParInsertionPoint == 0 && !curSPGElement.acceptTextBefore() || !curSPGElement.acceptTextAfter() && (subParInsertionPoint == curSPGElement.textLength || subParInsertionPoint == curSPGElement.textLength - 1 && sibling == paragraph.getLastLeaf())))
            {
               break;
            }
            createNewSpan = true;
            sibling = insertParent;
            insertParent = insertParent.parent;
            curSPGElement = curSPGElement.getParentByType(SubParagraphGroupElementBase) as SubParagraphGroupElementBase;
            siblingIndex = insertParent.getChildIndex(sibling) + 1;
         }
         var insertSpan:SpanElement = sibling as SpanElement;
         if(paragraph.terminatorSpan.textLength == 1 && paragraph.terminatorSpan == insertSpan)
         {
            createNewSpan = false;
         }
         if(!insertSpan || createNewSpan)
         {
            newSpan = new SpanElement();
            if(siblingIndex > 0)
            {
               relativeStart = paraSelBegIdx - sibling.getElementRelativeStart(paragraph);
               if(createNewSpan)
               {
                  if(relativeStart == 0)
                  {
                     siblingIndex--;
                  }
                  else if(relativeStart != sibling.textLength)
                  {
                     sibling.splitAtPosition(relativeStart);
                  }
               }
            }
            nextLeaf = paragraph.findLeaf(paraSelBegIdx);
            if(nextLeaf && nextLeaf.textLength == 1 && nextLeaf.parent == insertParent && nextLeaf == paragraph.terminatorSpan)
            {
               newSpan = SpanElement(nextLeaf);
            }
            else
            {
               insertParent.replaceChildren(siblingIndex,siblingIndex,newSpan);
            }
            formatElem = newSpan.getPreviousLeaf(paragraph);
            if(formatElem == null)
            {
               newSpan.format = newSpan.getNextLeaf(paragraph).format;
            }
            else
            {
               newSpan.format = formatElem.format;
            }
            insertSpan = newSpan;
         }
         var runInsertionPoint:int = paraSelBegIdx - insertSpan.getElementRelativeStart(paragraph);
         insertSpan.replaceText(runInsertionPoint,runInsertionPoint,insertText);
         return insertSpan;
      }
      
      private static function deleteTextInternal(para:ParagraphElement, paraSelBegIdx:int, totalToDelete:int) : void
      {
         var composeNode:FlowElement = null;
         var curSpan:SpanElement = null;
         var curNumToDelete:int = 0;
         var curSpanRelativeStart:int = 0;
         var delIdx:int = 0;
         var curSpanDeletePos:int = 0;
         while(totalToDelete > 0)
         {
            composeNode = para.findLeaf(paraSelBegIdx);
            curSpan = composeNode as SpanElement;
            curSpanRelativeStart = curSpan.getElementRelativeStart(para);
            curSpanDeletePos = paraSelBegIdx - curSpanRelativeStart;
            if(paraSelBegIdx > curSpanRelativeStart + curSpan.textLength)
            {
               curNumToDelete = curSpan.textLength;
            }
            else
            {
               curNumToDelete = curSpanRelativeStart + curSpan.textLength - paraSelBegIdx;
            }
            if(totalToDelete < curNumToDelete)
            {
               curNumToDelete = totalToDelete;
            }
            curSpan.replaceText(curSpanDeletePos,curSpanDeletePos + curNumToDelete,"");
            if(curSpan.textLength == 0)
            {
               delIdx = curSpan.parent.getChildIndex(curSpan);
               curSpan.parent.replaceChildren(delIdx,delIdx + 1,null);
            }
            totalToDelete -= curNumToDelete;
         }
      }
      
      public static function deleteText(para:ParagraphElement, paraSelBegIdx:int, totalToDelete:int) : void
      {
         var lastParPos:int = para.textLength - 1;
         if(paraSelBegIdx < 0 || paraSelBegIdx > lastParPos)
         {
            return;
         }
         if(totalToDelete <= 0)
         {
            return;
         }
         var endPos:int = paraSelBegIdx + totalToDelete - 1;
         if(endPos > lastParPos)
         {
            endPos = lastParPos;
            totalToDelete = endPos - paraSelBegIdx + 1;
         }
         deleteTextInternal(para,paraSelBegIdx,totalToDelete);
      }
      
      public static function createImage(flowBlock:FlowGroupElement, flowSelBegIdx:int, source:Object, width:Object, height:Object, options:Object, pointFormat:ITextLayoutFormat) : InlineGraphicElement
      {
         var searchStr:String = null;
         var index:int = 0;
         var imageElemFormat:TextLayoutFormat = null;
         var curComposeNode:FlowElement = flowBlock.findLeaf(flowSelBegIdx);
         var posInCurComposeNode:int = 0;
         if(curComposeNode != null)
         {
            posInCurComposeNode = flowSelBegIdx - curComposeNode.getElementRelativeStart(flowBlock);
         }
         if(curComposeNode != null && posInCurComposeNode > 0 && posInCurComposeNode < curComposeNode.textLength)
         {
            (curComposeNode as SpanElement).splitAtPosition(posInCurComposeNode);
         }
         var imgElem:InlineGraphicElement = new InlineGraphicElement();
         imgElem.height = height;
         imgElem.width = width;
         imgElem.float = !!options ? options.toString() : undefined;
         var src:Object = source;
         var embedStr:String = "@Embed";
         if(src is String && src.length > embedStr.length && src.substr(0,embedStr.length) == embedStr)
         {
            searchStr = "source=";
            index = src.indexOf(searchStr,embedStr.length);
            if(index > 0)
            {
               index += searchStr.length;
               index = src.indexOf("\'",index);
               src = src.substring(index + 1,src.indexOf("\'",index + 1));
            }
         }
         imgElem.source = src;
         while(curComposeNode && curComposeNode.parent != flowBlock)
         {
            curComposeNode = curComposeNode.parent;
         }
         var elementIdx:int = curComposeNode != null ? int(flowBlock.getChildIndex(curComposeNode)) : int(flowBlock.numChildren);
         if(curComposeNode && posInCurComposeNode > 0)
         {
            elementIdx++;
         }
         flowBlock.replaceChildren(elementIdx,elementIdx,imgElem);
         var p:ParagraphElement = imgElem.getParagraph();
         var attrElem:FlowLeafElement = imgElem.getPreviousLeaf(p);
         if(!attrElem)
         {
            attrElem = imgElem.getNextLeaf(p);
         }
         if(attrElem.format || pointFormat)
         {
            imageElemFormat = new TextLayoutFormat(attrElem.format);
            if(pointFormat)
            {
               imageElemFormat.apply(pointFormat);
            }
            imgElem.format = imageElemFormat;
         }
         return imgElem;
      }
      
      private static function splitForChange(span:SpanElement, begIdx:int, rangeLength:int) : SpanElement
      {
         var elemToUpdate:SpanElement = null;
         var startOffset:int = span.getAbsoluteStart();
         if(begIdx == startOffset && rangeLength == span.textLength)
         {
            return span;
         }
         var origLength:int = span.textLength;
         var begRelativeIdx:int = begIdx - startOffset;
         if(begRelativeIdx > 0)
         {
            elemToUpdate = span.splitAtPosition(begRelativeIdx) as SpanElement;
            if(begRelativeIdx + rangeLength < origLength)
            {
               elemToUpdate.splitAtPosition(rangeLength);
            }
         }
         else
         {
            span.splitAtPosition(rangeLength);
            elemToUpdate = span;
         }
         return elemToUpdate;
      }
      
      private static function undefineDefinedFormats(target:TextLayoutFormat, undefineFormat:ITextLayoutFormat) : void
      {
         var tlfUndefineFormat:TextLayoutFormat = null;
         var prop:* = null;
         if(undefineFormat)
         {
            if(undefineFormat is TextLayoutFormat)
            {
               tlfUndefineFormat = undefineFormat as TextLayoutFormat;
            }
            else
            {
               tlfUndefineFormat = new TextLayoutFormat(undefineFormat);
            }
            for(prop in tlfUndefineFormat.styles)
            {
               target.setStyle(prop,undefined);
            }
         }
      }
      
      private static function applyCharacterFormat(leaf:FlowLeafElement, begIdx:int, rangeLength:int, applyFormat:ITextLayoutFormat, undefineFormat:ITextLayoutFormat) : int
      {
         var newFormat:TextLayoutFormat = new TextLayoutFormat(leaf.format);
         if(applyFormat)
         {
            newFormat.apply(applyFormat);
         }
         undefineDefinedFormats(newFormat,undefineFormat);
         return setCharacterFormat(leaf,newFormat,begIdx,rangeLength);
      }
      
      private static function setCharacterFormat(leaf:FlowLeafElement, format:ITextLayoutFormat, begIdx:int, rangeLength:int) : int
      {
         var para:ParagraphElement = null;
         var paraStartOffset:int = 0;
         var begRelativeIdx:int = 0;
         var elemToUpdate:FlowLeafElement = null;
         var startOffset:int = leaf.getAbsoluteStart();
         if(!(format is ITextLayoutFormat) || !TextLayoutFormat.isEqual(ITextLayoutFormat(format),leaf.format))
         {
            para = leaf.getParagraph();
            paraStartOffset = para.getAbsoluteStart();
            begRelativeIdx = begIdx - startOffset;
            if(begRelativeIdx + rangeLength > leaf.textLength)
            {
               rangeLength = leaf.textLength - begRelativeIdx;
            }
            if(begRelativeIdx + rangeLength == leaf.textLength - 1 && leaf is SpanElement && SpanElement(leaf).hasParagraphTerminator)
            {
               rangeLength++;
            }
            if(leaf is SpanElement)
            {
               elemToUpdate = splitForChange(SpanElement(leaf),begIdx,rangeLength);
            }
            else
            {
               elemToUpdate = leaf;
            }
            if(format is ITextLayoutFormat)
            {
               elemToUpdate.format = ITextLayoutFormat(format);
            }
            else
            {
               elemToUpdate.setStylesInternal(format);
            }
            return begIdx + rangeLength;
         }
         rangeLength = leaf.textLength;
         return startOffset + rangeLength;
      }
      
      public static function applyTextStyleChange(flowRoot:TextFlow, begChange:int, endChange:int, applyFormat:ITextLayoutFormat, undefineFormat:ITextLayoutFormat) : void
      {
         var elem:FlowLeafElement = null;
         var workIdx:int = begChange;
         while(workIdx < endChange)
         {
            elem = flowRoot.findLeaf(workIdx);
            workIdx = applyCharacterFormat(elem,workIdx,endChange - workIdx,applyFormat,undefineFormat);
         }
      }
      
      public static function setTextStyleChange(flowRoot:TextFlow, begChange:int, endChange:int, coreStyle:ITextLayoutFormat) : void
      {
         var elem:FlowElement = null;
         var workIdx:int = begChange;
         while(workIdx < endChange)
         {
            elem = flowRoot.findLeaf(workIdx);
            workIdx = setCharacterFormat(FlowLeafElement(elem),coreStyle,workIdx,endChange - workIdx);
         }
      }
      
      public static function splitElement(elem:FlowGroupElement, splitPos:int) : FlowGroupElement
      {
         var rsltParagraph:FlowGroupElement = null;
         var elemParagraph:FlowGroupElement = null;
         var p:ParagraphElement = null;
         var rslt:FlowGroupElement = elem.splitAtPosition(splitPos) as FlowGroupElement;
         if(!(rslt is SubParagraphGroupElementBase))
         {
            rsltParagraph = rslt;
            while(!(rsltParagraph is ParagraphElement) && rsltParagraph.numChildren)
            {
               rsltParagraph = rsltParagraph.getChildAt(0) as FlowGroupElement;
            }
            elemParagraph = elem;
            while(!(elemParagraph is ParagraphElement) && elemParagraph.numChildren)
            {
               elemParagraph = elemParagraph.getChildAt(elemParagraph.numChildren - 1) as FlowGroupElement;
            }
            if(!(elemParagraph is ParagraphElement))
            {
               p = rsltParagraph.shallowCopy() as ParagraphElement;
               elemParagraph.addChild(p);
               elemParagraph = p;
            }
            else if(!(rsltParagraph is ParagraphElement))
            {
               p = elemParagraph.shallowCopy() as ParagraphElement;
               rsltParagraph.addChild(p);
               rsltParagraph = p;
            }
            if(elemParagraph.textLength <= 1)
            {
               elemParagraph.normalizeRange(0,elemParagraph.textLength);
               elemParagraph.getLastLeaf().quickCloneTextLayoutFormat(rsltParagraph.getFirstLeaf());
            }
            else if(rsltParagraph.textLength <= 1)
            {
               rsltParagraph.normalizeRange(0,rsltParagraph.textLength);
               rsltParagraph.getFirstLeaf().quickCloneTextLayoutFormat(elemParagraph.getLastLeaf());
            }
         }
         return rslt;
      }
      
      public static function mergeParagraphWithNext(para:ParagraphElement) : Boolean
      {
         var elem:FlowElement = null;
         var indexOfPara:int = para.parent.getChildIndex(para);
         if(indexOfPara == para.parent.numChildren - 1)
         {
            return false;
         }
         var nextPar:ParagraphElement = para.parent.getChildAt(indexOfPara + 1) as ParagraphElement;
         if(nextPar == null)
         {
            return false;
         }
         para.parent.replaceChildren(indexOfPara + 1,indexOfPara + 2,null);
         if(nextPar.textLength <= 1)
         {
            return true;
         }
         while(nextPar.numChildren)
         {
            elem = nextPar.getChildAt(0);
            nextPar.replaceChildren(0,1,null);
            para.replaceChildren(para.numChildren,para.numChildren,elem);
            if(para.numChildren > 1 && para.getChildAt(para.numChildren - 2).textLength == 0)
            {
               para.replaceChildren(para.numChildren - 2,para.numChildren - 1,null);
            }
         }
         return true;
      }
      
      public static function cacheParagraphStyleInformation(flowRoot:TextFlow, begSel:int, endSel:int, undoArray:Array) : void
      {
         var para:ParagraphElement = null;
         var obj:Object = null;
         while(begSel <= endSel && begSel >= 0)
         {
            para = flowRoot.findLeaf(begSel).getParagraph();
            obj = new Object();
            obj.begIdx = para.getAbsoluteStart();
            obj.endIdx = obj.begIdx + para.textLength - 1;
            obj.attributes = new TextLayoutFormat(para.format);
            undoArray.push(obj);
            begSel = obj.begIdx + para.textLength;
         }
      }
      
      public static function setParagraphStyleChange(flowRoot:TextFlow, begChange:int, endChange:int, format:ITextLayoutFormat) : void
      {
         var para:ParagraphElement = null;
         var beginPara:int = begChange;
         while(beginPara <= endChange)
         {
            para = flowRoot.findLeaf(beginPara).getParagraph();
            para.format = !!format ? new TextLayoutFormat(format) : null;
            beginPara = para.getAbsoluteStart() + para.textLength;
         }
      }
      
      public static function applyParagraphStyleChange(flowRoot:TextFlow, begChange:int, endChange:int, applyFormat:ITextLayoutFormat, undefineFormat:ITextLayoutFormat) : void
      {
         var leaf:FlowLeafElement = null;
         var para:ParagraphElement = null;
         var newFormat:TextLayoutFormat = null;
         var curIndex:int = begChange;
         while(curIndex <= endChange)
         {
            leaf = flowRoot.findLeaf(curIndex);
            if(!leaf)
            {
               break;
            }
            para = leaf.getParagraph();
            newFormat = new TextLayoutFormat(para.format);
            if(applyFormat)
            {
               newFormat.apply(applyFormat);
            }
            undefineDefinedFormats(newFormat,undefineFormat);
            para.format = newFormat;
            curIndex = para.getAbsoluteStart() + para.textLength;
         }
      }
      
      public static function cacheStyleInformation(flowRoot:TextFlow, begSel:int, endSel:int, undoArray:Array) : void
      {
         var obj:Object = null;
         var objLength:int = 0;
         var elem:FlowElement = flowRoot.findLeaf(begSel);
         var elemLength:int = elem.getAbsoluteStart() + elem.textLength - begSel;
         var countRemaining:int = endSel - begSel;
         while(true)
         {
            obj = new Object();
            obj.begIdx = begSel;
            objLength = Math.min(countRemaining,elemLength);
            obj.endIdx = begSel + objLength;
            obj.style = new TextLayoutFormat(elem.format);
            undoArray.push(obj);
            countRemaining -= Math.min(countRemaining,elemLength);
            if(countRemaining == 0)
            {
               break;
            }
            begSel = obj.endIdx;
            elem = flowRoot.findLeaf(begSel);
            elemLength = elem.textLength;
         }
      }
      
      public static function cacheContainerStyleInformation(flowRoot:TextFlow, begIdx:int, endIdx:int, undoArray:Array) : void
      {
         var ctrlrBegIdx:int = 0;
         var ctrlrEndIdx:int = 0;
         var controller:ContainerController = null;
         var obj:Object = null;
         if(flowRoot.flowComposer)
         {
            ctrlrBegIdx = flowRoot.flowComposer.findControllerIndexAtPosition(begIdx,false);
            if(ctrlrBegIdx == -1)
            {
               return;
            }
            ctrlrEndIdx = flowRoot.flowComposer.findControllerIndexAtPosition(endIdx,true);
            if(ctrlrEndIdx == -1)
            {
               ctrlrEndIdx = flowRoot.flowComposer.numControllers - 1;
            }
            while(ctrlrBegIdx <= ctrlrEndIdx)
            {
               controller = flowRoot.flowComposer.getControllerAt(ctrlrBegIdx);
               obj = new Object();
               obj.container = controller;
               obj.attributes = new TextLayoutFormat(controller.format);
               undoArray.push(obj);
               ctrlrBegIdx++;
            }
         }
      }
      
      public static function applyContainerStyleChange(flowRoot:TextFlow, begIdx:int, endIdx:int, applyFormat:ITextLayoutFormat, undefineFormat:ITextLayoutFormat) : void
      {
         var ctrlrBegIdx:int = 0;
         var ctrlrEndIdx:int = 0;
         var controllerIndex:int = 0;
         var controller:ContainerController = null;
         var newFormat:TextLayoutFormat = null;
         if(flowRoot.flowComposer)
         {
            ctrlrBegIdx = flowRoot.flowComposer.findControllerIndexAtPosition(begIdx,false);
            if(ctrlrBegIdx == -1)
            {
               return;
            }
            ctrlrEndIdx = flowRoot.flowComposer.findControllerIndexAtPosition(endIdx,true);
            if(ctrlrEndIdx == -1)
            {
               ctrlrEndIdx = flowRoot.flowComposer.numControllers - 1;
            }
            controllerIndex = flowRoot.flowComposer.findControllerIndexAtPosition(begIdx,false);
            while(ctrlrBegIdx <= ctrlrEndIdx)
            {
               controller = flowRoot.flowComposer.getControllerAt(ctrlrBegIdx);
               newFormat = new TextLayoutFormat(controller.format);
               if(applyFormat)
               {
                  newFormat.apply(applyFormat);
               }
               undefineDefinedFormats(newFormat,undefineFormat);
               controller.format = newFormat;
               ctrlrBegIdx++;
            }
         }
      }
      
      public static function setContainerStyleChange(obj:Object) : void
      {
         obj.container.format = obj.attributes as ITextLayoutFormat;
      }
   }
}
