package flashx.textLayout.elements
{
   import flash.text.engine.ContentElement;
   import flash.text.engine.EastAsianJustifier;
   import flash.text.engine.GroupElement;
   import flash.text.engine.LineJustification;
   import flash.text.engine.SpaceJustifier;
   import flash.text.engine.TabAlignment;
   import flash.text.engine.TabStop;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flash.text.engine.TextRotation;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.JustificationRule;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.formats.LineBreak;
   import flashx.textLayout.formats.TabStopFormat;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.TextJustify;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.CharacterUtil;
   import flashx.textLayout.utils.LocaleUtil;
   
   use namespace tlf_internal;
   
   public final class ParagraphElement extends ParagraphFormattedElement
   {
      
      private static var _defaultTabStops:Vector.<TabStop>;
      
      private static const defaultTabWidth:int = 48;
      
      private static const defaultTabCount:int = 20;
       
      
      private var _terminatorSpan:SpanElement;
      
      private var _interactiveChildrenCount:int;
      
      private var _textBlocks:Vector.<TextBlock>;
      
      public function ParagraphElement()
      {
         super();
         this._terminatorSpan = null;
         this._interactiveChildrenCount = 0;
      }
      
      private static function initializeDefaultTabStops() : void
      {
         _defaultTabStops = new Vector.<TabStop>(defaultTabCount,true);
         for(var i:int = 0; i < defaultTabCount; i++)
         {
            _defaultTabStops[i] = new TabStop(TextAlign.START,defaultTabWidth * i);
         }
      }
      
      tlf_internal static function getLeadingBasis(leadingModel:String) : String
      {
         switch(leadingModel)
         {
            case LeadingModel.ASCENT_DESCENT_UP:
            case LeadingModel.APPROXIMATE_TEXT_FIELD:
            case LeadingModel.BOX:
            case LeadingModel.ROMAN_UP:
            default:
               return TextBaseline.ROMAN;
            case LeadingModel.IDEOGRAPHIC_TOP_UP:
            case LeadingModel.IDEOGRAPHIC_TOP_DOWN:
               return TextBaseline.IDEOGRAPHIC_TOP;
            case LeadingModel.IDEOGRAPHIC_CENTER_UP:
            case LeadingModel.IDEOGRAPHIC_CENTER_DOWN:
               return TextBaseline.IDEOGRAPHIC_CENTER;
         }
      }
      
      tlf_internal static function useUpLeadingDirection(leadingModel:String) : Boolean
      {
         switch(leadingModel)
         {
            case LeadingModel.ASCENT_DESCENT_UP:
            case LeadingModel.APPROXIMATE_TEXT_FIELD:
            case LeadingModel.BOX:
            case LeadingModel.ROMAN_UP:
            case LeadingModel.IDEOGRAPHIC_TOP_UP:
            case LeadingModel.IDEOGRAPHIC_CENTER_UP:
            default:
               return true;
            case LeadingModel.IDEOGRAPHIC_TOP_DOWN:
            case LeadingModel.IDEOGRAPHIC_CENTER_DOWN:
               return false;
         }
      }
      
      tlf_internal function get interactiveChildrenCount() : int
      {
         return this._interactiveChildrenCount;
      }
      
      tlf_internal function createTextBlock() : void
      {
         var tb:TextBlock = null;
         var child:FlowElement = null;
         this.computedFormat;
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         var tableCount:int = 0;
         if(tbs.length == 0 && !(getChildAt(0) is TableElement))
         {
            tbs.push(new TextBlock());
         }
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            if(child is TableElement)
            {
               tableCount++;
            }
         }
         while(tableCount >= tbs.length)
         {
            tbs.push(new TextBlock());
         }
         for(i = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            child.createContentElement();
         }
         tbs.length = tableCount + 1;
         for each(tb in tbs)
         {
            this.updateTextBlock(tb);
         }
      }
      
      private function updateTextBlockRefs() : void
      {
         var child:FlowElement = null;
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         if(tbs.length == 0)
         {
            return;
         }
         var tbIdx:int = 0;
         var tb:TextBlock = tbs[tbIdx];
         var items:Array = [];
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            if(child is TableElement)
            {
               tb.userData = items;
               if(++tbIdx == tbs.length)
               {
                  return;
               }
               tb = tbs[tbIdx];
               tb.userData = null;
               if(++tbIdx == tbs.length)
               {
                  return;
               }
               tb = tbs[tbIdx];
               items = [];
            }
            else
            {
               items.push(child);
            }
         }
         tb.userData = items;
      }
      
      private function removeTextBlock(tb:TextBlock) : void
      {
         var idx:int = 0;
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         if(tbs)
         {
            idx = this.getTextBlocks().indexOf(tb);
            if(idx > -1)
            {
               tbs.splice(idx,1);
            }
         }
      }
      
      private function releaseTextBlockInternal(tb:TextBlock) : void
      {
         var textLineTest:TextLine = null;
         var tfl:TextFlowLine = null;
         var len:int = 0;
         var i:int = 0;
         var child:FlowElement = null;
         if(!tb)
         {
            return;
         }
         if(tb.firstLine)
         {
            for(textLineTest = tb.firstLine; textLineTest != null; textLineTest = textLineTest.nextLine)
            {
               if(textLineTest.numChildren != 0)
               {
                  tfl = textLineTest.userData as TextFlowLine;
                  if(tfl.adornCount != textLineTest.numChildren)
                  {
                     return;
                  }
               }
            }
            tb.releaseLines(tb.firstLine,tb.lastLine);
         }
         var items:Array = tb.userData;
         if(items)
         {
            len = items.length;
            for(i = 0; i < len; i++)
            {
               child = items[i];
               child.releaseContentElement();
            }
            items.length = 0;
         }
         tb.content = null;
         this.removeTextBlock(tb);
      }
      
      tlf_internal function releaseTextBlock(tb:TextBlock = null) : void
      {
         var textBlock:TextBlock = null;
         this.updateTextBlockRefs();
         if(tb)
         {
            this.releaseTextBlockInternal(tb);
            return;
         }
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         for each(textBlock in tbs)
         {
            this.releaseTextBlockInternal(textBlock);
         }
         if(_computedFormat)
         {
            _computedFormat = null;
         }
      }
      
      tlf_internal function getTextBlocks() : Vector.<TextBlock>
      {
         if(this._textBlocks == null)
         {
            this._textBlocks = new Vector.<TextBlock>();
         }
         return this._textBlocks;
      }
      
      tlf_internal function getTextBlock() : TextBlock
      {
         if(!this.getTextBlocks().length)
         {
            this.createTextBlock();
         }
         return this.getTextBlocks()[0];
      }
      
      tlf_internal function getLastTextBlock() : TextBlock
      {
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         if(!tbs.length)
         {
            this.createTextBlock();
         }
         return tbs[tbs.length - 1];
      }
      
      tlf_internal function getTextBlockAtPosition(pos:int) : TextBlock
      {
         var table:TableElement = null;
         var tbs:Vector.<TextBlock> = null;
         var tb:TextBlock = null;
         var curPos:int = 0;
         var posShift:int = 0;
         var tables:Vector.<TableElement> = this.getTables();
         if(!tables.length)
         {
            return this.getTextBlock();
         }
         for each(table in tables)
         {
            if(table.getElementRelativeStart(this) < pos)
            {
               posShift++;
            }
         }
         tbs = this.getTextBlocks();
         for each(tb in tbs)
         {
            if(tb.content == null)
            {
               return tb;
            }
            curPos += tb.content.rawText.length;
            if(curPos + posShift > pos)
            {
               if(this.getTextBlockStart(tb) > pos)
               {
                  return null;
               }
               return tb;
            }
         }
         return null;
      }
      
      tlf_internal function getTextBlockAbsoluteStart(tb:TextBlock) : int
      {
         var start:int = this.getTextBlockStart(tb);
         if(start < 0)
         {
            start = 0;
         }
         return getAbsoluteStart() + start;
      }
      
      tlf_internal function getTextBlockStart(tb:TextBlock) : int
      {
         var i:int = 0;
         var curTB:TextBlock = null;
         var table:TableElement = null;
         var curPos:int = 0;
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         if(tbs.length == 0)
         {
            return -1;
         }
         var tables:Vector.<TableElement> = this.getTables();
         for each(curTB in tbs)
         {
            for each(table in tables)
            {
               if(table.getElementRelativeStart(this) <= curPos)
               {
                  curPos++;
                  tables.splice(tables.indexOf(table),1);
               }
            }
            if(tb == curTB)
            {
               return curPos;
            }
            if(tb.content)
            {
               curPos += curTB.content.rawText.length;
            }
         }
         return -1;
      }
      
      private function getTables() : Vector.<TableElement>
      {
         var child:FlowElement = null;
         var tables:Vector.<TableElement> = new Vector.<TableElement>();
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            if(child is TableElement)
            {
               tables.push(child as TableElement);
            }
         }
         return tables;
      }
      
      tlf_internal function peekTextBlock() : TextBlock
      {
         return this.getTextBlocks().length == 0 ? null : this.getTextBlocks()[0];
      }
      
      tlf_internal function releaseLineCreationData() : void
      {
         var tb:TextBlock = null;
         var tbs:Vector.<TextBlock> = this.getTextBlocks();
         for each(tb in tbs)
         {
            tb["releaseLineCreationData"]();
         }
      }
      
      override tlf_internal function createContentAsGroup(pos:int = 0) : GroupElement
      {
         var originalContent:ContentElement = null;
         var gc:Vector.<ContentElement> = null;
         var textFlow:TextFlow = null;
         var tb:TextBlock = this.getTextBlockAtPosition(pos);
         if(!tb)
         {
            tb = this.getTextBlockAtPosition(pos - 1);
         }
         var group:GroupElement = tb.content as GroupElement;
         if(!group)
         {
            originalContent = tb.content;
            group = new GroupElement();
            tb.content = group;
            if(originalContent)
            {
               gc = new Vector.<ContentElement>();
               gc.push(originalContent);
               group.replaceElements(0,0,gc);
            }
            if(tb.firstLine && textLength)
            {
               textFlow = getTextFlow();
               if(textFlow)
               {
                  textFlow.damage(getAbsoluteStart(),textLength,TextLineValidity.INVALID,false);
               }
            }
         }
         return group;
      }
      
      override tlf_internal function removeBlockElement(child:FlowElement, block:ContentElement) : void
      {
         var idx:int = 0;
         var group:GroupElement = null;
         var elem:ContentElement = null;
         var tb:TextBlock = this.getTextBlockAtPosition(child.getElementRelativeStart(this));
         if(!tb)
         {
            tb = this.getTextBlock();
         }
         if(tb.content == null)
         {
            return;
         }
         var relativeStart:int = child.getElementRelativeStart(this);
         if(this.getChildrenInTextBlock(relativeStart).length < 2)
         {
            if(block is GroupElement)
            {
               GroupElement(tb.content).replaceElements(0,1,null);
            }
            tb.content = null;
         }
         else if(block.groupElement)
         {
            idx = this.getChildIndexInBlock(child);
            group = GroupElement(tb.content);
            group.replaceElements(idx,idx + 1,null);
            if(group.elementCount == 0)
            {
               return;
            }
            if(numChildren == 2)
            {
               elem = group.getElementAt(0);
               if(!(elem is GroupElement))
               {
                  group.replaceElements(0,1,null);
                  tb.content = elem;
               }
            }
         }
      }
      
      override tlf_internal function hasBlockElement() : Boolean
      {
         return this.getTextBlocks().length > 0;
      }
      
      override tlf_internal function createContentElement() : void
      {
         this.createTextBlock();
      }
      
      private function getChildrenInTextBlock(pos:int) : Array
      {
         var retVal:Array = [];
         if(numChildren == 0)
         {
            return retVal;
         }
         if(numChildren == 1)
         {
            retVal.push(getChildAt(0));
            return retVal;
         }
         var chldrn:Array = mxmlChildren.slice();
         for(var i:int = 0; i < chldrn.length; i++)
         {
            if(chldrn[i] is TableElement)
            {
               if(chldrn[i].parentRelativeStart < pos)
               {
                  retVal.length = 0;
                  continue;
               }
               if(chldrn[i].parentRelativeStart >= pos)
               {
                  break;
               }
            }
            retVal.push(chldrn[i]);
         }
         return retVal;
      }
      
      override tlf_internal function insertBlockElement(child:FlowElement, block:ContentElement) : void
      {
         var gc:Vector.<ContentElement> = null;
         var group:GroupElement = null;
         var idx:int = 0;
         var relativeStart:int = child.getElementRelativeStart(this);
         var tb:TextBlock = this.getTextBlockAtPosition(relativeStart);
         if(!tb)
         {
            tb = this.getTextBlockAtPosition(relativeStart - 1);
         }
         if(!tb)
         {
            child.releaseContentElement();
            return;
         }
         if(this.getTextBlocks().length == 0)
         {
            child.releaseContentElement();
            this.createTextBlock();
            return;
         }
         if(this.getChildrenInTextBlock(relativeStart).length < 2)
         {
            if(block is GroupElement)
            {
               gc = new Vector.<ContentElement>();
               gc.push(block);
               group = new GroupElement(gc);
               tb.content = group;
            }
            else
            {
               if(block.groupElement)
               {
                  block.groupElement.elementCount;
               }
               tb.content = block;
            }
         }
         else
         {
            group = this.createContentAsGroup(relativeStart);
            idx = this.getChildIndexInBlock(child);
            gc = new Vector.<ContentElement>();
            gc.push(block);
            if(idx > group.elementCount)
            {
               idx = group.elementCount;
            }
            group.replaceElements(idx,idx,gc);
         }
      }
      
      private function getChildIndexInBlock(elem:FlowElement) : int
      {
         var child:FlowElement = null;
         var relIdx:int = 0;
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            if(child == elem)
            {
               return relIdx;
            }
            relIdx++;
            if(child is TableElement)
            {
               relIdx = 0;
            }
         }
         return -1;
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "p";
      }
      
      tlf_internal function removeEmptyTerminator() : void
      {
         if(numChildren == 1 && this._terminatorSpan && this._terminatorSpan.textLength == 1)
         {
            this._terminatorSpan.removeParaTerminator();
            super.replaceChildren(0,1);
            this._terminatorSpan = null;
         }
      }
      
      override public function replaceChildren(beginChildIndex:int, endChildIndex:int, ... rest) : void
      {
         var applyParams:Array = null;
         var termIdx:int = 0;
         do
         {
            if(this._terminatorSpan)
            {
               termIdx = getChildIndex(this._terminatorSpan);
               if(termIdx > 0 && termIdx < beginChildIndex && this._terminatorSpan.textLength == 1)
               {
                  super.replaceChildren(termIdx,termIdx + 1);
                  this._terminatorSpan = null;
                  if(beginChildIndex >= termIdx)
                  {
                     beginChildIndex--;
                     if(rest.length == 0)
                     {
                        break;
                     }
                  }
                  if(endChildIndex >= termIdx && beginChildIndex != endChildIndex)
                  {
                     endChildIndex--;
                  }
               }
            }
            if(rest.length == 1)
            {
               applyParams = [beginChildIndex,endChildIndex,rest[0]];
            }
            else
            {
               applyParams = [beginChildIndex,endChildIndex];
               if(rest.length != 0)
               {
                  applyParams = applyParams.concat.apply(applyParams,rest);
               }
            }
            super.replaceChildren.apply(this,applyParams);
         }
         while(false);
         
         this.ensureTerminatorAfterReplace();
         this.createTextBlock();
      }
      
      override public function splitAtPosition(relativePosition:int) : FlowElement
      {
         return super.splitAtPosition(relativePosition);
      }
      
      tlf_internal function ensureTerminatorAfterReplace() : void
      {
         var termIdx:int = 0;
         var s:SpanElement = null;
         var prev:FlowLeafElement = null;
         if(this._terminatorSpan && this._terminatorSpan.parent != this)
         {
            this._terminatorSpan.removeParaTerminator();
            this._terminatorSpan = null;
         }
         var newLastLeaf:FlowLeafElement = getLastLeaf();
         if(this._terminatorSpan != newLastLeaf)
         {
            if(this._terminatorSpan)
            {
               this._terminatorSpan.removeParaTerminator();
            }
            if(newLastLeaf && this._terminatorSpan)
            {
               if(this._terminatorSpan.textLength == 0 && !this._terminatorSpan.id)
               {
                  termIdx = getChildIndex(this._terminatorSpan);
                  super.replaceChildren(termIdx,termIdx + 1);
               }
               this._terminatorSpan = null;
            }
            if(newLastLeaf)
            {
               if(newLastLeaf is SpanElement)
               {
                  (newLastLeaf as SpanElement).addParaTerminator();
                  this._terminatorSpan = newLastLeaf as SpanElement;
               }
               else
               {
                  s = new SpanElement();
                  super.replaceChildren(numChildren,numChildren,s);
                  s.format = !!newLastLeaf ? newLastLeaf.format : this._terminatorSpan.format;
                  s.addParaTerminator();
                  this._terminatorSpan = s;
               }
            }
            else
            {
               this._terminatorSpan = null;
            }
         }
         if(this._terminatorSpan && this._terminatorSpan.textLength == 1)
         {
            prev = this._terminatorSpan.getPreviousLeaf(this);
            if(prev && prev.parent == this && prev is SpanElement)
            {
               this._terminatorSpan.mergeToPreviousIfPossible();
            }
         }
      }
      
      tlf_internal function updateTerminatorSpan(splitSpan:SpanElement, followingSpan:SpanElement) : void
      {
         if(this._terminatorSpan == splitSpan)
         {
            this._terminatorSpan = followingSpan;
         }
      }
      
      override public function set mxmlChildren(array:Array) : void
      {
         var child:Object = null;
         var s:SpanElement = null;
         this.replaceChildren(0,numChildren);
         for each(child in array)
         {
            if(child is FlowElement)
            {
               if(child is SpanElement || child is SubParagraphGroupElementBase)
               {
                  child.bindableElement = true;
               }
               super.replaceChildren(numChildren,numChildren,child as FlowElement);
            }
            else if(child is String)
            {
               s = new SpanElement();
               s.text = String(child);
               s.bindableElement = true;
               super.replaceChildren(numChildren,numChildren,s);
            }
            else if(child != null)
            {
               throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument",[getQualifiedClassName(child)]));
            }
         }
         this.ensureTerminatorAfterReplace();
         this.createTextBlock();
      }
      
      override public function getText(relativeStart:int = 0, relativeEnd:int = -1, paragraphSeparator:String = "\n") : String
      {
         var tb:TextBlock = null;
         var tbs:Vector.<TextBlock> = null;
         var text:String = null;
         if(relativeStart == 0 && (relativeEnd == -1 || relativeEnd >= textLength - 1) && this.getTextBlocks().length)
         {
            tbs = this.getTextBlocks();
            text = "";
            for each(tb in tbs)
            {
               text += this.getTextInBlock(tb);
            }
            if(tb.content && tb.content.rawText)
            {
               return text.substring(0,text.length - 1);
            }
            return text;
         }
         return super.getText(relativeStart,relativeEnd,paragraphSeparator);
      }
      
      private function getTextInBlock(tb:TextBlock) : String
      {
         if(!tb.content || !tb.content.rawText)
         {
            return "";
         }
         return tb.content.rawText;
      }
      
      public function getNextParagraph() : ParagraphElement
      {
         var nextLeaf:FlowLeafElement = getLastLeaf().getNextLeaf();
         return !!nextLeaf ? nextLeaf.getParagraph() : null;
      }
      
      public function getPreviousParagraph() : ParagraphElement
      {
         var previousLeaf:FlowLeafElement = getFirstLeaf().getPreviousLeaf();
         return !!previousLeaf ? previousLeaf.getParagraph() : null;
      }
      
      public function findPreviousAtomBoundary(relativePosition:int) : int
      {
         var currentAtomIndex:int = 0;
         var isRTL:* = false;
         var foo:int = 0;
         var tb:TextBlock = this.getTextBlockAtPosition(relativePosition);
         if(!tb || !tb.content)
         {
            return relativePosition - 1;
         }
         var tbStart:int = this.getTextBlockStart(tb);
         var textBlockPos:int = relativePosition - tbStart;
         var tl:TextLine = tb.getTextLineAtCharIndex(textBlockPos);
         if(ContainerController.usesDiscretionaryHyphens && tl != null)
         {
            currentAtomIndex = tl.getAtomIndexAtCharIndex(textBlockPos);
            isRTL = tl.getAtomBidiLevel(currentAtomIndex) == 1;
            if(isRTL)
            {
               foo = tb.findPreviousAtomBoundary(textBlockPos);
               if(currentAtomIndex == 0)
               {
                  if(tl.atomCount > 0)
                  {
                     while(--textBlockPos)
                     {
                        relativePosition--;
                        if(tl.getAtomIndexAtCharIndex(textBlockPos) != currentAtomIndex)
                        {
                           break;
                        }
                     }
                  }
               }
               else
               {
                  while(--relativePosition && --textBlockPos)
                  {
                     if(tl.getAtomIndexAtCharIndex(textBlockPos) != currentAtomIndex)
                     {
                        break;
                     }
                  }
               }
               if(CharacterUtil.isLowSurrogate(this.getText(relativePosition,relativePosition + 1).charCodeAt(0)))
               {
                  relativePosition--;
                  textBlockPos--;
               }
            }
            else
            {
               if(currentAtomIndex == 0)
               {
                  tl = tl.previousLine;
                  if(!tl)
                  {
                     if(tb != this._textBlocks[0])
                     {
                        return relativePosition - 1;
                     }
                     return -1;
                  }
                  if(tl.textBlockBeginIndex + tl.rawTextLength == textBlockPos)
                  {
                     return tl.textBlockBeginIndex + tl.rawTextLength - 1 + tbStart;
                  }
                  return tl.textBlockBeginIndex + tl.rawTextLength + tbStart;
               }
               while(--relativePosition && --textBlockPos)
               {
                  if(tl.getAtomIndexAtCharIndex(textBlockPos) < currentAtomIndex)
                  {
                     break;
                  }
               }
               if(CharacterUtil.isLowSurrogate(this.getText(relativePosition,relativePosition + 1).charCodeAt(0)))
               {
                  relativePosition--;
                  textBlockPos--;
               }
            }
            return relativePosition;
         }
         var pos:int = tb.findPreviousAtomBoundary(textBlockPos);
         if(pos >= 0)
         {
            pos += tbStart;
         }
         return pos;
      }
      
      public function findNextAtomBoundary(relativePosition:int) : int
      {
         var currentAtomIndex:int = 0;
         var isRTL:* = false;
         var foo:int = 0;
         var tb:TextBlock = this.getTextBlockAtPosition(relativePosition);
         if(!tb || !tb.content)
         {
            return relativePosition + 1;
         }
         var tbStart:int = this.getTextBlockStart(tb);
         var textBlockPos:int = relativePosition - tbStart;
         var tl:TextLine = tb.getTextLineAtCharIndex(textBlockPos);
         if(ContainerController.usesDiscretionaryHyphens && tl != null)
         {
            currentAtomIndex = tl.getAtomIndexAtCharIndex(textBlockPos);
            isRTL = tl.getAtomBidiLevel(currentAtomIndex) == 1;
            if(isRTL)
            {
               foo = tb.findNextAtomBoundary(textBlockPos);
               if(currentAtomIndex == 0)
               {
                  while(++textBlockPos)
                  {
                     relativePosition++;
                     if(tl.getAtomIndexAtCharIndex(textBlockPos) != currentAtomIndex)
                     {
                        break;
                     }
                  }
               }
               else
               {
                  while(++textBlockPos)
                  {
                     relativePosition++;
                     if(tl.getAtomIndexAtCharIndex(textBlockPos) != currentAtomIndex)
                     {
                        break;
                     }
                  }
               }
               if(CharacterUtil.isHighSurrogate(this.getText(relativePosition,relativePosition + 1).charCodeAt(0)))
               {
                  relativePosition++;
                  textBlockPos++;
               }
            }
            else
            {
               if(currentAtomIndex == tl.atomCount - 1)
               {
                  tl = tl.nextLine;
                  if(!tl)
                  {
                     if(tb != this._textBlocks[this._textBlocks.length - 1])
                     {
                        return relativePosition + 1;
                     }
                     return -1;
                  }
                  return tl.textBlockBeginIndex + tbStart;
               }
               while(++textBlockPos)
               {
                  relativePosition++;
                  if(tl.getAtomIndexAtCharIndex(textBlockPos) > currentAtomIndex)
                  {
                     break;
                  }
               }
               if(CharacterUtil.isHighSurrogate(this.getText(relativePosition,relativePosition + 1).charCodeAt(0)))
               {
                  relativePosition++;
                  textBlockPos++;
               }
            }
            return relativePosition;
         }
         var pos:int = tb.findNextAtomBoundary(textBlockPos);
         if(pos >= 0)
         {
            pos += tbStart;
         }
         return pos;
      }
      
      override public function getCharAtPosition(relativePosition:int) : String
      {
         var table:TableElement = null;
         var tbs:Vector.<TextBlock> = null;
         var tb:TextBlock = null;
         var foundTB:TextBlock = this.getTextBlockAtPosition(relativePosition);
         if(!foundTB)
         {
            return "\x16";
         }
         var tables:Vector.<TableElement> = this.getTables();
         var pos:int = relativePosition;
         for each(table in tables)
         {
            if(table.getElementRelativeStart(this) < pos)
            {
               relativePosition--;
            }
         }
         tbs = this.getTextBlocks();
         for each(tb in tbs)
         {
            if(foundTB == tb)
            {
               break;
            }
            if(tb)
            {
               relativePosition -= tb.content.rawText.length;
            }
            else
            {
               relativePosition--;
            }
            this.getText();
         }
         return foundTB.content.rawText.charAt(relativePosition);
      }
      
      public function findPreviousWordBoundary(relativePosition:int) : int
      {
         if(relativePosition == 0)
         {
            return 0;
         }
         var prevCharCode:int = getCharCodeAtPosition(relativePosition - 1);
         if(CharacterUtil.isWhitespace(prevCharCode))
         {
            while(CharacterUtil.isWhitespace(prevCharCode) && relativePosition - 1 > 0)
            {
               relativePosition--;
               prevCharCode = getCharCodeAtPosition(relativePosition - 1);
            }
            return relativePosition;
         }
         var block:TextBlock = this.getTextBlockAtPosition(relativePosition);
         if(block == null)
         {
            block = this.getTextBlockAtPosition(--relativePosition);
         }
         var pos:int = this.getTextBlockStart(block);
         if(pos < 0)
         {
            pos = 0;
         }
         return relativePosition == pos ? int(pos) : int(pos + block.findPreviousWordBoundary(relativePosition - pos));
      }
      
      public function findNextWordBoundary(relativePosition:int) : int
      {
         if(relativePosition == textLength)
         {
            return textLength;
         }
         var curCharCode:int = getCharCodeAtPosition(relativePosition);
         if(CharacterUtil.isWhitespace(curCharCode))
         {
            while(CharacterUtil.isWhitespace(curCharCode) && relativePosition < textLength - 1)
            {
               relativePosition++;
               curCharCode = getCharCodeAtPosition(relativePosition);
            }
            return relativePosition;
         }
         var block:TextBlock = this.getTextBlockAtPosition(relativePosition);
         if(block == null)
         {
            block = this.getTextBlockAtPosition(--relativePosition);
         }
         var pos:int = this.getTextBlockStart(block);
         if(pos < 0)
         {
            pos = 0;
         }
         return pos + block.findNextWordBoundary(relativePosition - pos);
      }
      
      private function updateTextBlock(textBlock:TextBlock = null) : void
      {
         var lineJust:String = null;
         var spaceJustifier:SpaceJustifier = null;
         var newMinimumSpacing:Number = NaN;
         var newMaximumSpacing:Number = NaN;
         var newOptimumSpacing:Number = NaN;
         var eastAsianJustifier:Object = null;
         var tabStops:Vector.<TabStop> = null;
         var tsa:TabStopFormat = null;
         var token:String = null;
         var alignment:String = null;
         var tabStop:TabStop = null;
         var garbage:String = null;
         if(!textBlock)
         {
            textBlock = this.getTextBlock();
         }
         var containerElement:ContainerFormattedElement = getAncestorWithContainer();
         if(!containerElement)
         {
            return;
         }
         var containerElementFormat:ITextLayoutFormat = !!containerElement ? containerElement.computedFormat : TextLayoutFormat.defaultFormat;
         if(this.computedFormat.textAlign == TextAlign.JUSTIFY)
         {
            lineJust = _computedFormat.textAlignLast == TextAlign.JUSTIFY ? LineJustification.ALL_INCLUDING_LAST : LineJustification.ALL_BUT_LAST;
            if(containerElementFormat.lineBreak == LineBreak.EXPLICIT)
            {
               lineJust = LineJustification.UNJUSTIFIED;
            }
         }
         else
         {
            lineJust = LineJustification.UNJUSTIFIED;
         }
         var makeJustRuleStyle:String = this.getEffectiveJustificationStyle();
         var justRule:String = this.getEffectiveJustificationRule();
         if(justRule == JustificationRule.SPACE)
         {
            spaceJustifier = new SpaceJustifier(_computedFormat.locale,lineJust,false);
            spaceJustifier.letterSpacing = _computedFormat.textJustify == TextJustify.DISTRIBUTE ? true : false;
            if(Configuration.playerEnablesArgoFeatures)
            {
               newMinimumSpacing = Property.toNumberIfPercent(_computedFormat.wordSpacing.minimumSpacing) / 100;
               newMaximumSpacing = Property.toNumberIfPercent(_computedFormat.wordSpacing.maximumSpacing) / 100;
               newOptimumSpacing = Property.toNumberIfPercent(_computedFormat.wordSpacing.optimumSpacing) / 100;
               spaceJustifier["minimumSpacing"] = Math.min(newMinimumSpacing,spaceJustifier["minimumSpacing"]);
               spaceJustifier["maximumSpacing"] = Math.max(newMaximumSpacing,spaceJustifier["maximumSpacing"]);
               spaceJustifier["optimumSpacing"] = newOptimumSpacing;
               spaceJustifier["minimumSpacing"] = newMinimumSpacing;
               spaceJustifier["maximumSpacing"] = newMaximumSpacing;
            }
            textBlock.textJustifier = spaceJustifier;
            textBlock.baselineZero = getLeadingBasis(this.getEffectiveLeadingModel());
         }
         else
         {
            eastAsianJustifier = new EastAsianJustifier(_computedFormat.locale,lineJust,makeJustRuleStyle);
            if(Configuration.versionIsAtLeast(10,3) && eastAsianJustifier.hasOwnProperty("composeTrailingIdeographicSpaces"))
            {
               eastAsianJustifier.composeTrailingIdeographicSpaces = true;
            }
            textBlock.textJustifier = eastAsianJustifier as EastAsianJustifier;
            textBlock.baselineZero = getLeadingBasis(this.getEffectiveLeadingModel());
         }
         textBlock.bidiLevel = _computedFormat.direction == Direction.LTR ? 0 : 1;
         textBlock.lineRotation = containerElementFormat.blockProgression == BlockProgression.RL ? TextRotation.ROTATE_90 : TextRotation.ROTATE_0;
         if(_computedFormat.tabStops && _computedFormat.tabStops.length != 0)
         {
            tabStops = new Vector.<TabStop>();
            for each(tsa in _computedFormat.tabStops)
            {
               token = tsa.decimalAlignmentToken == null ? "" : tsa.decimalAlignmentToken;
               alignment = tsa.alignment == null ? TabAlignment.START : tsa.alignment;
               tabStop = new TabStop(alignment,Number(tsa.position),token);
               if(tsa.decimalAlignmentToken != null)
               {
                  garbage = "x" + tabStop.decimalAlignmentToken;
               }
               tabStops.push(tabStop);
            }
            textBlock.tabStops = tabStops;
         }
         else if(GlobalSettings.enableDefaultTabStops && !Configuration.playerEnablesArgoFeatures)
         {
            if(_defaultTabStops == null)
            {
               initializeDefaultTabStops();
            }
            textBlock.tabStops = _defaultTabStops;
         }
         else
         {
            textBlock.tabStops = null;
         }
      }
      
      override public function get computedFormat() : ITextLayoutFormat
      {
         var tbs:Vector.<TextBlock> = null;
         var tb:TextBlock = null;
         if(!_computedFormat)
         {
            super.computedFormat;
            tbs = this.getTextBlocks();
            for each(tb in tbs)
            {
               this.updateTextBlock(tb);
            }
         }
         return _computedFormat;
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return elem is FlowLeafElement || elem is SubParagraphGroupElementBase || elem is TableElement;
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
         var child:FlowElement = null;
         var origChildEnd:int = 0;
         var newChildEnd:int = 0;
         var prevElement:FlowElement = null;
         var lastChild:FlowElement = null;
         var s:SpanElement = null;
         var idx:int = findChildIndexAtPosition(normalizeStart);
         if(idx != -1 && idx < numChildren)
         {
            child = getChildAt(idx);
            normalizeStart -= child.parentRelativeStart;
            while(true)
            {
               origChildEnd = child.parentRelativeStart + child.textLength;
               child.normalizeRange(normalizeStart,normalizeEnd - child.parentRelativeStart);
               newChildEnd = child.parentRelativeStart + child.textLength;
               normalizeEnd += newChildEnd - origChildEnd;
               if(child.textLength == 0 && !child.bindableElement)
               {
                  this.replaceChildren(idx,idx + 1);
               }
               else if(child.mergeToPreviousIfPossible())
               {
                  prevElement = this.getChildAt(idx - 1);
                  prevElement.normalizeRange(0,prevElement.textLength);
               }
               else
               {
                  idx++;
               }
               if(idx == numChildren)
               {
                  if(idx != 0)
                  {
                     lastChild = this.getChildAt(idx - 1);
                     if(lastChild is SubParagraphGroupElementBase && lastChild.textLength == 1 && !lastChild.bindableElement)
                     {
                        this.replaceChildren(idx - 1,idx);
                     }
                  }
                  break;
               }
               child = getChildAt(idx);
               if(child.parentRelativeStart > normalizeEnd)
               {
                  break;
               }
               normalizeStart = 0;
            }
         }
         if(numChildren == 0 || textLength == 0)
         {
            s = new SpanElement();
            this.replaceChildren(0,0,s);
            s.normalizeRange(0,s.textLength);
         }
      }
      
      tlf_internal function getEffectiveLeadingModel() : String
      {
         return this.computedFormat.leadingModel == LeadingModel.AUTO ? LocaleUtil.leadingModel(this.computedFormat.locale) : this.computedFormat.leadingModel;
      }
      
      tlf_internal function getEffectiveDominantBaseline() : String
      {
         return this.computedFormat.dominantBaseline == FormatValue.AUTO ? LocaleUtil.dominantBaseline(this.computedFormat.locale) : this.computedFormat.dominantBaseline;
      }
      
      tlf_internal function getEffectiveJustificationRule() : String
      {
         return this.computedFormat.justificationRule == FormatValue.AUTO ? LocaleUtil.justificationRule(this.computedFormat.locale) : this.computedFormat.justificationRule;
      }
      
      tlf_internal function getEffectiveJustificationStyle() : String
      {
         return this.computedFormat.justificationStyle == FormatValue.AUTO ? LocaleUtil.justificationStyle(this.computedFormat.locale) : this.computedFormat.justificationStyle;
      }
      
      tlf_internal function incInteractiveChildrenCount() : void
      {
         ++this._interactiveChildrenCount;
      }
      
      tlf_internal function decInteractiveChildrenCount() : void
      {
         --this._interactiveChildrenCount;
      }
      
      tlf_internal function hasInteractiveChildren() : Boolean
      {
         return this._interactiveChildrenCount != 0;
      }
      
      tlf_internal function get terminatorSpan() : SpanElement
      {
         return this._terminatorSpan;
      }
   }
}
