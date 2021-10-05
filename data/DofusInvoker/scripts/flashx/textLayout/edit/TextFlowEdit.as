package flashx.textLayout.edit
{
   import flashx.textLayout.conversion.ConverterBase;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class TextFlowEdit
   {
       
      
      public function TextFlowEdit()
      {
         super();
      }
      
      tlf_internal static function deleteRange(textFlow:TextFlow, startPos:int, endPos:int) : ParagraphElement
      {
         var mergePara:ParagraphElement = null;
         var firstLeafInRange:FlowLeafElement = null;
         var lastLeafInRange:FlowLeafElement = null;
         var firstParagraphInRange:ParagraphElement = null;
         var lastParagraphInRange:ParagraphElement = null;
         var firstParaStart:int = 0;
         var lastParaEnd:int = 0;
         var doMerge:* = false;
         var followingLeaf:FlowLeafElement = null;
         var previousLeaf:FlowLeafElement = null;
         if(endPos > startPos)
         {
            firstLeafInRange = textFlow.findLeaf(startPos);
            lastLeafInRange = textFlow.findLeaf(endPos - 1);
            firstParagraphInRange = firstLeafInRange.getParagraph();
            lastParagraphInRange = lastLeafInRange.getParagraph();
            firstParaStart = firstParagraphInRange.getAbsoluteStart();
            lastParaEnd = lastParagraphInRange.getAbsoluteStart() + lastParagraphInRange.textLength;
            doMerge = false;
            if(firstParagraphInRange == lastParagraphInRange)
            {
               doMerge = Boolean(endPos == lastParaEnd && startPos != firstParaStart);
            }
            else
            {
               doMerge = startPos != firstParaStart;
            }
            if(doMerge)
            {
               followingLeaf = textFlow.findLeaf(endPos);
               if(followingLeaf)
               {
                  mergePara = followingLeaf.getParagraph();
                  if(mergePara.textLength == 1 && mergePara.parent is ListItemElement && mergePara.parent.numChildren > 1)
                  {
                     mergePara = null;
                  }
               }
            }
         }
         deleteRangeInternal(textFlow,startPos,endPos - startPos);
         if(mergePara)
         {
            previousLeaf = mergePara.getFirstLeaf().getPreviousLeaf();
            mergePara = !!previousLeaf ? previousLeaf.getParagraph() : null;
         }
         return mergePara;
      }
      
      private static function deleteRangeInternal(element:FlowGroupElement, relativeStart:int, numToDelete:int) : void
      {
         var child:FlowElement = null;
         var childStart:int = 0;
         var childRelativeStart:int = 0;
         var childNumToDelete:int = 0;
         var span:SpanElement = null;
         var pendingDeleteStart:int = -1;
         var pendingDeleteCount:int = 0;
         var childIndex:int = element.findChildIndexAtPosition(relativeStart);
         while(numToDelete > 0 && childIndex < element.numChildren)
         {
            child = element.getChildAt(childIndex);
            if(relativeStart <= child.parentRelativeStart && numToDelete >= child.textLength)
            {
               if(pendingDeleteStart < 0)
               {
                  pendingDeleteStart = childIndex;
               }
               pendingDeleteCount++;
               numToDelete -= child.textLength;
            }
            else
            {
               if(pendingDeleteStart >= 0)
               {
                  element.replaceChildren(pendingDeleteStart,pendingDeleteStart + pendingDeleteCount);
                  childIndex -= pendingDeleteCount;
                  pendingDeleteStart = -1;
                  pendingDeleteCount = 0;
               }
               childStart = child.parentRelativeStart;
               childRelativeStart = Math.max(relativeStart - childStart,0);
               childNumToDelete = Math.min(child.textLength - childRelativeStart,numToDelete);
               if(child is SpanElement)
               {
                  span = child as SpanElement;
                  span.replaceText(childRelativeStart,childRelativeStart + childNumToDelete,"");
                  numToDelete -= childNumToDelete;
               }
               else
               {
                  deleteRangeInternal(child as FlowGroupElement,childRelativeStart,childNumToDelete);
                  numToDelete -= childNumToDelete;
               }
            }
            childIndex++;
         }
         if(pendingDeleteStart >= 0)
         {
            element.replaceChildren(pendingDeleteStart,pendingDeleteStart + pendingDeleteCount);
         }
      }
      
      private static function findLowestPossibleParent(element:FlowGroupElement, prospectiveChild:FlowElement) : FlowGroupElement
      {
         while(element && !element.canOwnFlowElement(prospectiveChild))
         {
            element = element.parent;
         }
         return element;
      }
      
      private static function removePasteAttributes(element:FlowElement) : void
      {
         var flowGroupElement:FlowGroupElement = null;
         if(!element)
         {
            return;
         }
         if(element is FlowGroupElement && element.format)
         {
            flowGroupElement = FlowGroupElement(element);
            if(element.format.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE) !== undefined)
            {
               removePasteAttributes(flowGroupElement.getChildAt(flowGroupElement.numChildren - 1));
            }
         }
         element.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,undefined);
      }
      
      private static function applyFormatToElement(destinationElement:FlowGroupElement, childIndex:int, insertThis:Object) : void
      {
         var formatSourceSibling:FlowElement = null;
         var spanFormat:ITextLayoutFormat = null;
         var element:FlowElement = null;
         var concatFormat:TextLayoutFormat = null;
         var scrapElement:FlowElement = null;
         if(childIndex > 0)
         {
            formatSourceSibling = destinationElement.getChildAt(childIndex - 1);
         }
         else
         {
            formatSourceSibling = destinationElement.getChildAt(0);
         }
         if(formatSourceSibling)
         {
            if(formatSourceSibling is FlowGroupElement)
            {
               element = FlowGroupElement(formatSourceSibling).getLastLeaf();
               while(element != formatSourceSibling.parent)
               {
                  if(element.format)
                  {
                     if(!concatFormat)
                     {
                        concatFormat = new TextLayoutFormat(element.format);
                     }
                     else
                     {
                        concatFormat.concatInheritOnly(element.format);
                     }
                  }
                  element = element.parent;
               }
               spanFormat = concatFormat;
            }
            else
            {
               spanFormat = formatSourceSibling.format;
            }
            if(insertThis is Array)
            {
               for each(scrapElement in insertThis)
               {
                  if(scrapElement is FlowLeafElement)
                  {
                     scrapElement.format = spanFormat;
                  }
                  else
                  {
                     scrapElement.format = formatSourceSibling.format;
                  }
               }
            }
            else if(insertThis is FlowLeafElement)
            {
               insertThis.format = spanFormat;
            }
            else
            {
               insertThis.format = formatSourceSibling.format;
            }
         }
      }
      
      public static function insertTextScrap(destinationFlow:TextFlow, absoluteStart:int, textScrap:TextScrap, applyFormat:Boolean) : int
      {
         var scrapElement:FlowElement = null;
         var scrapParagraph:ParagraphElement = null;
         var destinationParagraph:ParagraphElement = null;
         var destinationElement:FlowGroupElement = null;
         var destinationStart:int = 0;
         var currentIndex:int = 0;
         var scrapParent:FlowGroupElement = null;
         var scrapChildren:Array = null;
         var childIndex:int = 0;
         var child:FlowElement = null;
         var childStart:int = 0;
         if(!textScrap)
         {
            return absoluteStart;
         }
         var scrapFlow:TextFlow = textScrap.textFlow.deepCopy() as TextFlow;
         var scrapLeaf:FlowLeafElement = scrapFlow.getFirstLeaf();
         var destinationLeaf:FlowLeafElement = destinationFlow.findLeaf(absoluteStart);
         var insertPosition:int = absoluteStart;
         var firstParagraph:Boolean = true;
         var doSplit:Boolean = false;
         while(scrapLeaf)
         {
            removePasteAttributes(scrapLeaf);
            scrapElement = scrapLeaf;
            scrapParagraph = scrapLeaf.getParagraph();
            destinationParagraph = !!destinationLeaf ? destinationLeaf.getParagraph() : destinationParagraph;
            if(firstParagraph && (destinationParagraph.textLength > 1 || applyFormat))
            {
               if(!scrapParagraph.format || scrapParagraph.format.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE) === undefined)
               {
                  doSplit = true;
               }
               scrapElement = scrapParagraph.getChildAt(0);
            }
            else
            {
               if(applyFormat)
               {
                  destinationElement = !!destinationLeaf ? findLowestPossibleParent(destinationLeaf.parent,scrapElement) : findLowestPossibleParent(destinationElement,scrapElement);
                  currentIndex = destinationElement.findChildIndexAtPosition(insertPosition - destinationElement.getAbsoluteStart());
                  applyFormatToElement(destinationElement,currentIndex,scrapElement);
               }
               while(scrapElement && scrapElement.parent && (!scrapElement.parent.format || scrapElement.parent.format.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE) === undefined) && !(scrapElement.parent is TextFlow))
               {
                  scrapElement = scrapElement.parent;
               }
            }
            destinationElement = !!destinationLeaf ? findLowestPossibleParent(destinationLeaf.parent,scrapElement) : findLowestPossibleParent(destinationElement,scrapElement);
            while(!destinationElement)
            {
               scrapElement = scrapElement.parent;
               destinationElement = findLowestPossibleParent(destinationLeaf.parent,scrapElement);
            }
            removePasteAttributes(scrapElement);
            destinationStart = destinationElement.getAbsoluteStart();
            if(firstParagraph && doSplit)
            {
               ModelEdit.splitElement(destinationFlow,destinationElement,insertPosition - destinationStart);
               scrapParent = scrapElement.parent;
               scrapChildren = scrapParent.mxmlChildren;
               scrapParent.replaceChildren(0,scrapParent.numChildren);
               if(scrapParent.parent)
               {
                  scrapParent.parent.removeChild(scrapParent);
               }
               if(applyFormat)
               {
                  applyFormatToElement(destinationElement,destinationElement.numChildren,scrapChildren);
               }
               destinationElement.replaceChildren(destinationElement.numChildren,destinationElement.numChildren,scrapChildren);
               scrapElement = destinationElement.getChildAt(destinationElement.numChildren - 1);
               firstParagraph = false;
            }
            else
            {
               childIndex = destinationElement.findChildIndexAtPosition(insertPosition - destinationElement.getAbsoluteStart());
               child = destinationElement.getChildAt(childIndex);
               childStart = child.getAbsoluteStart();
               if(insertPosition == childStart + child.textLength)
               {
                  childIndex++;
               }
               else if(insertPosition > childStart)
               {
                  if(child is FlowLeafElement)
                  {
                     child.splitAtPosition(insertPosition - childStart);
                  }
                  else
                  {
                     ModelEdit.splitElement(destinationFlow,child as FlowGroupElement,insertPosition - childStart);
                  }
                  childIndex++;
               }
               if(applyFormat)
               {
                  applyFormatToElement(destinationElement,childIndex,scrapElement);
               }
               destinationElement.replaceChildren(childIndex,childIndex,scrapElement);
            }
            destinationLeaf = scrapElement is FlowLeafElement ? FlowLeafElement(scrapElement).getNextLeaf() : FlowGroupElement(scrapElement).getLastLeaf().getNextLeaf();
            insertPosition = !!destinationLeaf ? int(destinationLeaf.getAbsoluteStart()) : int(destinationFlow.textLength - 1);
            scrapLeaf = scrapFlow.getFirstLeaf();
            if(destinationLeaf && scrapLeaf && scrapLeaf.getParagraph() == scrapParagraph)
            {
               if(destinationLeaf.getParagraph() != destinationParagraph)
               {
                  insertPosition--;
                  destinationLeaf = null;
               }
            }
         }
         if(scrapParagraph.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE) == "true" && insertPosition == destinationParagraph.getAbsoluteStart() + destinationParagraph.textLength)
         {
            insertPosition--;
         }
         return insertPosition;
      }
      
      public static function makeTCY(theFlow:TextFlow, startPos:int, endPos:int) : Boolean
      {
         var paraEnd:int = 0;
         var curEndPos:int = 0;
         var new_tcyElem:TCYElement = null;
         var madeTCY:Boolean = true;
         var curPara:ParagraphElement = theFlow.findAbsoluteParagraph(startPos);
         if(!curPara)
         {
            return false;
         }
         while(curPara)
         {
            paraEnd = curPara.getAbsoluteStart() + curPara.textLength;
            curEndPos = Math.min(paraEnd,endPos);
            if(canInsertSPBlock(theFlow,startPos,curEndPos,TCYElement) && curPara.textLength > 1)
            {
               new_tcyElem = new TCYElement();
               madeTCY = madeTCY && insertNewSPBlock(theFlow,startPos,curEndPos,new_tcyElem,TCYElement);
            }
            else
            {
               madeTCY = false;
            }
            if(paraEnd < endPos)
            {
               curPara = theFlow.findAbsoluteParagraph(curEndPos);
               startPos = curEndPos;
            }
            else
            {
               curPara = null;
            }
         }
         return madeTCY;
      }
      
      public static function makeLink(theFlow:TextFlow, startPos:int, endPos:int, urlString:String, target:String) : Boolean
      {
         var paraEnd:int = 0;
         var curEndPos:int = 0;
         var linkEndPos:int = 0;
         var newLinkElement:LinkElement = null;
         var madeLink:Boolean = true;
         var curPara:ParagraphElement = theFlow.findAbsoluteParagraph(startPos);
         if(!curPara)
         {
            return false;
         }
         while(curPara)
         {
            paraEnd = curPara.getAbsoluteStart() + curPara.textLength;
            curEndPos = Math.min(paraEnd,endPos);
            linkEndPos = curEndPos == paraEnd ? int(curEndPos - 1) : int(curEndPos);
            if(linkEndPos > startPos)
            {
               if(!canInsertSPBlock(theFlow,startPos,linkEndPos,LinkElement))
               {
                  return false;
               }
               newLinkElement = new LinkElement();
               newLinkElement.href = urlString;
               newLinkElement.target = target;
               madeLink = madeLink && insertNewSPBlock(theFlow,startPos,linkEndPos,newLinkElement,LinkElement);
            }
            if(paraEnd < endPos)
            {
               curPara = theFlow.findAbsoluteParagraph(curEndPos);
               startPos = curEndPos;
            }
            else
            {
               curPara = null;
            }
         }
         return madeLink;
      }
      
      public static function removeTCY(theFlow:TextFlow, startPos:int, endPos:int) : Boolean
      {
         if(endPos <= startPos)
         {
            return false;
         }
         return findAndRemoveFlowGroupElement(theFlow,startPos,endPos,TCYElement);
      }
      
      public static function removeLink(theFlow:TextFlow, startPos:int, endPos:int) : Boolean
      {
         if(endPos <= startPos)
         {
            return false;
         }
         return findAndRemoveFlowGroupElement(theFlow,startPos,endPos,LinkElement);
      }
      
      tlf_internal static function insertNewSPBlock(theFlow:TextFlow, startPos:int, endPos:int, newSPB:SubParagraphGroupElementBase, spgClass:Class) : Boolean
      {
         var curPos:int = startPos;
         var curFBE:FlowGroupElement = theFlow.findAbsoluteFlowGroupElement(curPos);
         var elementIdx:int = 0;
         var paraEl:ParagraphElement = curFBE.getParagraph();
         if(endPos == paraEl.getAbsoluteStart() + paraEl.textLength - 1)
         {
            endPos++;
         }
         var parentStart:int = curFBE.parent.getAbsoluteStart();
         var curFBEStart:int = curFBE.getAbsoluteStart();
         if(curFBE.parent && curFBE.parent is spgClass && !(parentStart == curFBEStart && parentStart + curFBE.parent.textLength == curFBEStart + curFBE.textLength))
         {
            return false;
         }
         if(!(curFBE is ParagraphElement) && curPos == curFBEStart && curPos + curFBE.textLength <= endPos)
         {
            elementIdx = curFBE.parent.getChildIndex(curFBE);
            curFBE = curFBE.parent;
         }
         if(curPos >= curFBEStart)
         {
            if(!(curFBE is spgClass))
            {
               elementIdx = findAndSplitElement(curFBE,elementIdx,curPos,true);
            }
            else
            {
               elementIdx = findAndSplitElement(curFBE.parent,curFBE.parent.getChildIndex(curFBE),curPos,false);
               curFBE = curFBE.parent;
            }
         }
         if(curFBE is spgClass)
         {
            curFBEStart = curFBE.getAbsoluteStart();
            elementIdx = curFBE.parent.getChildIndex(curFBE);
            if(curPos > curFBEStart)
            {
               elementIdx += 1;
            }
            while(endPos >= curFBEStart + curFBE.textLength)
            {
               curFBE = curFBE.parent;
            }
            curFBE.replaceChildren(elementIdx,elementIdx,newSPB);
         }
         else
         {
            curFBE.replaceChildren(elementIdx,elementIdx,newSPB);
         }
         subsumeElementsToSPBlock(curFBE,elementIdx + 1,curPos,endPos,newSPB,spgClass);
         return true;
      }
      
      tlf_internal static function splitElement(elem:FlowElement, splitPos:int, splitSubBlockContents:Boolean) : void
      {
         var subBlock:SubParagraphGroupElementBase = null;
         var tempElem:SpanElement = null;
         if(elem is SpanElement)
         {
            SpanElement(elem).splitAtPosition(splitPos);
         }
         else if(elem is SubParagraphGroupElementBase && splitSubBlockContents)
         {
            subBlock = SubParagraphGroupElementBase(elem);
            tempElem = subBlock.findLeaf(splitPos) as SpanElement;
            if(tempElem)
            {
               tempElem.splitAtPosition(splitPos - tempElem.getElementRelativeStart(subBlock));
            }
         }
         else if(elem is FlowGroupElement)
         {
            FlowGroupElement(elem).splitAtPosition(splitPos);
         }
      }
      
      tlf_internal static function findAndSplitElement(fbe:FlowGroupElement, elementIdx:int, startIdx:int, splitSubBlockContents:Boolean) : int
      {
         var curFlowEl:FlowElement = null;
         var curIndexInPar:int = startIdx - fbe.getAbsoluteStart();
         while(elementIdx < fbe.numChildren)
         {
            curFlowEl = fbe.getChildAt(elementIdx);
            if(curIndexInPar == curFlowEl.parentRelativeStart)
            {
               return elementIdx;
            }
            if(curIndexInPar > curFlowEl.parentRelativeStart && curIndexInPar < curFlowEl.parentRelativeEnd)
            {
               splitElement(curFlowEl,curIndexInPar - curFlowEl.parentRelativeStart,splitSubBlockContents);
            }
            elementIdx++;
         }
         return elementIdx;
      }
      
      tlf_internal static function subsumeElementsToSPBlock(parentFBE:FlowGroupElement, elementIdx:int, curPos:int, endPos:int, newSPB:SubParagraphGroupElementBase, spgClass:Class) : int
      {
         var subBlock:SubParagraphGroupElementBase = null;
         var fe:FlowElement = null;
         var childSPGE:SubParagraphGroupElementBase = null;
         var myIdx:int = 0;
         var tempFE:FlowElement = null;
         var curFlowEl:FlowElement = null;
         if(elementIdx >= parentFBE.numChildren)
         {
            return curPos;
         }
         while(curPos < endPos)
         {
            curFlowEl = parentFBE.getChildAt(elementIdx);
            if(curPos + curFlowEl.textLength > endPos)
            {
               splitElement(curFlowEl,endPos - curFlowEl.getAbsoluteStart(),!(curFlowEl is spgClass));
            }
            curPos += curFlowEl.textLength;
            parentFBE.replaceChildren(elementIdx,elementIdx + 1);
            if(curFlowEl is spgClass)
            {
               subBlock = curFlowEl as SubParagraphGroupElementBase;
               while(subBlock.numChildren > 0)
               {
                  fe = subBlock.getChildAt(0);
                  subBlock.replaceChildren(0,1);
                  newSPB.replaceChildren(newSPB.numChildren,newSPB.numChildren,fe);
               }
            }
            else
            {
               if(curFlowEl is SubParagraphGroupElementBase)
               {
                  flushSPBlock(curFlowEl as SubParagraphGroupElementBase,spgClass);
               }
               newSPB.replaceChildren(newSPB.numChildren,newSPB.numChildren,curFlowEl);
               if(newSPB.numChildren == 1 && curFlowEl is SubParagraphGroupElementBase)
               {
                  childSPGE = curFlowEl as SubParagraphGroupElementBase;
                  if(childSPGE.textLength == newSPB.textLength && curPos >= endPos)
                  {
                     if(childSPGE.precedence > newSPB.precedence)
                     {
                        newSPB.replaceChildren(0,1);
                        while(childSPGE.numChildren > 0)
                        {
                           tempFE = childSPGE.getChildAt(0);
                           childSPGE.replaceChildren(0,1);
                           newSPB.replaceChildren(newSPB.numChildren,newSPB.numChildren,tempFE);
                        }
                        myIdx = newSPB.parent.getChildIndex(newSPB);
                        newSPB.parent.replaceChildren(myIdx,myIdx + 1,childSPGE);
                        childSPGE.replaceChildren(0,0,newSPB);
                     }
                  }
               }
            }
         }
         return curPos;
      }
      
      tlf_internal static function findAndRemoveFlowGroupElement(theFlow:TextFlow, startPos:int, endPos:int, fbeClass:Class) : Boolean
      {
         var curEl:FlowElement = null;
         var containerFBE:FlowGroupElement = null;
         var ancestorOfFBE:FlowGroupElement = null;
         var containerFBEStart:int = 0;
         var childIdx:int = 0;
         var curFBE:FlowGroupElement = null;
         var parentBlock:FlowGroupElement = null;
         var idxInParent:int = 0;
         var childFE:FlowElement = null;
         var curSPB:SubParagraphGroupElementBase = null;
         var curPos:int = startPos;
         while(curPos < endPos)
         {
            containerFBE = theFlow.findAbsoluteFlowGroupElement(curPos);
            while(containerFBE.parent && containerFBE.parent.getAbsoluteStart() == containerFBE.getAbsoluteStart() && !(containerFBE.parent is ParagraphElement) && !(containerFBE is ParagraphElement))
            {
               containerFBE = containerFBE.parent;
            }
            if(containerFBE is fbeClass)
            {
               containerFBE = containerFBE.parent;
            }
            ancestorOfFBE = containerFBE.parent;
            while(ancestorOfFBE != null && !(ancestorOfFBE is fbeClass))
            {
               if(ancestorOfFBE.parent is fbeClass)
               {
                  return false;
               }
               ancestorOfFBE = ancestorOfFBE.parent;
            }
            containerFBEStart = containerFBE.getAbsoluteStart();
            if(ancestorOfFBE is fbeClass && (containerFBEStart >= curPos && containerFBEStart + containerFBE.textLength <= endPos))
            {
               containerFBE = ancestorOfFBE.parent;
            }
            childIdx = containerFBE.findChildIndexAtPosition(curPos - containerFBEStart);
            curEl = containerFBE.getChildAt(childIdx);
            if(curEl is fbeClass)
            {
               curFBE = curEl as FlowGroupElement;
               parentBlock = curFBE.parent;
               idxInParent = parentBlock.getChildIndex(curFBE);
               if(curPos > curFBE.getAbsoluteStart())
               {
                  splitElement(curFBE,curPos - curFBE.getAbsoluteStart(),false);
                  curPos = curFBE.getAbsoluteStart() + curFBE.textLength;
               }
               else
               {
                  if(curFBE.getAbsoluteStart() + curFBE.textLength > endPos)
                  {
                     splitElement(curFBE,endPos - curFBE.getAbsoluteStart(),false);
                  }
                  curPos = curFBE.getAbsoluteStart() + curFBE.textLength;
                  while(curFBE.numChildren > 0)
                  {
                     childFE = curFBE.getChildAt(0);
                     curFBE.replaceChildren(0,1);
                     parentBlock.replaceChildren(idxInParent,idxInParent,childFE);
                     idxInParent++;
                  }
                  parentBlock.replaceChildren(idxInParent,idxInParent + 1);
               }
            }
            else if(curEl is SubParagraphGroupElementBase)
            {
               curSPB = SubParagraphGroupElementBase(curEl);
               if(curSPB.numChildren == 1)
               {
                  curPos = curSPB.getAbsoluteStart() + curSPB.textLength;
               }
               else
               {
                  curEl = curSPB.getChildAt(curSPB.findChildIndexAtPosition(curPos - curSPB.getAbsoluteStart()));
                  curPos = curEl.getAbsoluteStart() + curEl.textLength;
               }
            }
            else
            {
               curPos = curEl.getAbsoluteStart() + curEl.textLength;
            }
         }
         return true;
      }
      
      tlf_internal static function canInsertSPBlock(theFlow:TextFlow, startPos:int, endPos:int, blockClass:Class) : Boolean
      {
         var anchorStart:int = 0;
         var tailStart:int = 0;
         if(endPos <= startPos)
         {
            return false;
         }
         var anchorFBE:FlowGroupElement = theFlow.findAbsoluteFlowGroupElement(startPos);
         if(anchorFBE.getParentByType(blockClass))
         {
            anchorFBE = anchorFBE.getParentByType(blockClass) as FlowGroupElement;
         }
         var tailFBE:FlowGroupElement = theFlow.findAbsoluteFlowGroupElement(endPos - 1);
         if(tailFBE.getParentByType(blockClass))
         {
            tailFBE = tailFBE.getParentByType(blockClass) as FlowGroupElement;
         }
         if(anchorFBE == tailFBE)
         {
            return true;
         }
         if(anchorFBE.getParagraph() != tailFBE.getParagraph())
         {
            return false;
         }
         if(anchorFBE is blockClass && tailFBE is blockClass)
         {
            return true;
         }
         if(anchorFBE is SubParagraphGroupElementBase && !(anchorFBE is blockClass))
         {
            anchorStart = anchorFBE.getAbsoluteStart();
            if(startPos > anchorStart && endPos > anchorStart + anchorFBE.textLength)
            {
               return false;
            }
         }
         else if((anchorFBE.parent is SubParagraphGroupElementBase || tailFBE.parent is SubParagraphGroupElementBase) && anchorFBE.parent != tailFBE.parent)
         {
            return false;
         }
         if(tailFBE is SubParagraphGroupElementBase && !(tailFBE is blockClass) && endPos > tailFBE.getAbsoluteStart())
         {
            tailStart = tailFBE.getAbsoluteStart();
            if(startPos < tailStart && endPos < tailStart + tailFBE.textLength)
            {
               return false;
            }
         }
         return true;
      }
      
      tlf_internal static function flushSPBlock(subPB:SubParagraphGroupElementBase, spgClass:Class) : void
      {
         var subFE:FlowElement = null;
         var subChildFBE:FlowGroupElement = null;
         var subFEChild:FlowElement = null;
         var subParaIter:int = 0;
         while(subParaIter < subPB.numChildren)
         {
            subFE = subPB.getChildAt(subParaIter);
            if(subFE is spgClass)
            {
               subChildFBE = subFE as FlowGroupElement;
               while(subChildFBE.numChildren > 0)
               {
                  subFEChild = subChildFBE.getChildAt(0);
                  subChildFBE.replaceChildren(0,1);
                  subPB.replaceChildren(subParaIter,subParaIter,subFEChild);
               }
               subParaIter++;
               subPB.replaceChildren(subParaIter,subParaIter + 1);
            }
            else if(subFE is SubParagraphGroupElementBase)
            {
               flushSPBlock(subFE as SubParagraphGroupElementBase,spgClass);
               subParaIter++;
            }
            else
            {
               subParaIter++;
            }
         }
      }
      
      tlf_internal static function findNextParagraph(para:ParagraphElement) : ParagraphElement
      {
         var leaf:FlowLeafElement = null;
         if(para)
         {
            leaf = para.getLastLeaf();
            leaf = leaf.getNextLeaf();
            if(leaf)
            {
               return leaf.getParagraph();
            }
         }
         return null;
      }
      
      tlf_internal static function removeEmptyParentChain(parent:FlowGroupElement) : IMemento
      {
         var grandParent:FlowGroupElement = null;
         var parentIdx:int = 0;
         if(parent is ParagraphElement)
         {
            ParagraphElement(parent).removeEmptyTerminator();
         }
         var mementoList:MementoList = new MementoList(parent.getTextFlow());
         while(parent && parent.numChildren == 0)
         {
            grandParent = parent.parent;
            if(grandParent is ParagraphElement)
            {
               ParagraphElement(grandParent).removeEmptyTerminator();
            }
            if(grandParent)
            {
               parentIdx = grandParent.getChildIndex(parent);
               mementoList.push(ModelEdit.removeElements(grandParent.getTextFlow(),grandParent,parentIdx,1));
            }
            parent = grandParent;
         }
         return mementoList;
      }
      
      public static function joinNextParagraph(para:ParagraphElement, inSameParent:Boolean) : IMemento
      {
         var nextPara:ParagraphElement = findNextParagraph(para);
         if(nextPara && (!inSameParent || para.parent == nextPara.parent))
         {
            return joinToElement(para,nextPara);
         }
         return null;
      }
      
      public static function joinToNextParagraph(para:ParagraphElement, inSameParent:Boolean) : MementoList
      {
         var sibParagraph:ParagraphElement = findNextParagraph(para);
         if(sibParagraph && (!inSameParent || para.parent == sibParagraph.parent))
         {
            return joinToNextElement(para,sibParagraph);
         }
         return null;
      }
      
      public static function joinToElement(element1:FlowGroupElement, element2:FlowGroupElement) : IMemento
      {
         var list:MementoList = null;
         if(element1 && element2)
         {
            return ModelEdit.joinElement(element2.getTextFlow(),element1,element2);
         }
         return list;
      }
      
      public static function joinToNextElement(element1:FlowGroupElement, element2:FlowGroupElement) : MementoList
      {
         var list:MementoList = null;
         var elementList:Array = null;
         var i:int = 0;
         if(element1 && element2)
         {
            list = new MementoList(element1.getTextFlow());
            elementList = element1.mxmlChildren;
            list.push(ModelEdit.removeElements(element1.getTextFlow(),element1,0,element1.numChildren));
            for(i = elementList.length - 1; i >= 0; i--)
            {
               list.push(ModelEdit.addElement(element2.getTextFlow(),elementList[i],element2,0));
            }
            list.push(removeEmptyParentChain(element1));
            return list;
         }
         return list;
      }
   }
}
