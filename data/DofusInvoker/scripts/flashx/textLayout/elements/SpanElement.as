package flashx.textLayout.elements
{
   import flash.text.engine.GroupElement;
   import flash.text.engine.TextElement;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.formats.WhiteSpaceCollapse;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.CharacterUtil;
   
   use namespace tlf_internal;
   
   public class SpanElement extends FlowLeafElement
   {
      
      tlf_internal static const kParagraphTerminator:String = " ";
      
      private static const _dblSpacePattern:RegExp = /[ ]{2,}/g;
      
      private static const _newLineTabPattern:RegExp = /[\t\n\r]/g;
      
      private static const _tabPlaceholderPattern:RegExp = //g;
      
      private static const anyPrintChar:RegExp = /[^\t\n\r ]/g;
       
      
      public function SpanElement()
      {
         super();
      }
      
      override tlf_internal function createContentElement() : void
      {
         if(_blockElement && _blockElement.textBlock)
         {
            return;
         }
         computedFormat;
         _blockElement = new TextElement(_text,null);
         super.createContentElement();
      }
      
      override public function shallowCopy(startPos:int = 0, endPos:int = -1) : FlowElement
      {
         if(endPos == -1)
         {
            endPos = textLength;
         }
         var retFlow:SpanElement = super.shallowCopy(startPos,endPos) as SpanElement;
         var startSpan:int = 0;
         var endSpan:int = startSpan + textLength;
         var leafElStartPos:int = startSpan >= startPos ? int(startSpan) : int(startPos);
         var leafElEndPos:int = endSpan < endPos ? int(endSpan) : int(endPos);
         if(leafElEndPos == textLength && this.hasParagraphTerminator)
         {
            leafElEndPos--;
         }
         if(leafElStartPos > leafElEndPos)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badShallowCopyRange"));
         }
         if(leafElStartPos != endSpan && CharacterUtil.isLowSurrogate(_text.charCodeAt(leafElStartPos)) || leafElEndPos != 0 && CharacterUtil.isHighSurrogate(_text.charCodeAt(leafElEndPos - 1)))
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badSurrogatePairCopy"));
         }
         if(leafElStartPos != leafElEndPos)
         {
            retFlow.replaceText(0,retFlow.textLength,_text.substring(leafElStartPos,leafElEndPos));
         }
         return retFlow;
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "span";
      }
      
      override public function get text() : String
      {
         if(textLength == 0)
         {
            return "";
         }
         return !!this.hasParagraphTerminator ? _text.substr(0,textLength - 1) : _text;
      }
      
      public function set text(textValue:String) : void
      {
         this.replaceText(0,textLength,textValue);
      }
      
      override public function getText(relativeStart:int = 0, relativeEnd:int = -1, paragraphSeparator:String = "\n") : String
      {
         if(relativeEnd == -1)
         {
            relativeEnd = textLength;
         }
         if(textLength && relativeEnd == textLength && this.hasParagraphTerminator)
         {
            relativeEnd--;
         }
         return !!_text ? _text.substring(relativeStart,relativeEnd) : "";
      }
      
      public function get mxmlChildren() : Array
      {
         return [this.text];
      }
      
      public function set mxmlChildren(array:Array) : void
      {
         var elem:Object = null;
         var str:String = new String();
         for each(elem in array)
         {
            if(elem is String)
            {
               str += elem as String;
            }
            else if(elem is Number)
            {
               str += elem.toString();
            }
            else if(elem is BreakElement)
            {
               str += String.fromCharCode(8232);
            }
            else if(elem is TabElement)
            {
               str += String.fromCharCode(57344);
            }
            else if(elem != null)
            {
               throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument",[getQualifiedClassName(elem)]));
            }
         }
         this.replaceText(0,textLength,str);
      }
      
      tlf_internal function get hasParagraphTerminator() : Boolean
      {
         var p:ParagraphElement = getParagraph();
         return p && p.getLastLeaf() == this;
      }
      
      override tlf_internal function applyWhiteSpaceCollapse(collapse:String) : void
      {
         var ffc:ITextLayoutFormat = this.formatForCascade;
         var wsc:* = !!ffc ? ffc.whiteSpaceCollapse : undefined;
         if(wsc !== undefined && wsc != FormatValue.INHERIT)
         {
            collapse = wsc;
         }
         var origTxt:String = this.text;
         var tempTxt:String = origTxt;
         if(!collapse || collapse == WhiteSpaceCollapse.COLLAPSE)
         {
            if(tlf_internal::impliedElement && parent != null)
            {
               if(tempTxt.search(anyPrintChar) == -1)
               {
                  parent.removeChild(this);
                  return;
               }
            }
            tempTxt = tempTxt.replace(_newLineTabPattern," ");
            tempTxt = tempTxt.replace(_dblSpacePattern," ");
         }
         tempTxt = tempTxt.replace(_tabPlaceholderPattern,"\t");
         if(tempTxt != origTxt)
         {
            this.replaceText(0,textLength,tempTxt);
         }
         super.applyWhiteSpaceCollapse(collapse);
      }
      
      public function replaceText(relativeStartPosition:int, relativeEndPosition:int, textValue:String) : void
      {
         if(relativeStartPosition < 0 || relativeEndPosition > textLength || relativeEndPosition < relativeStartPosition)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidReplaceTextPositions"));
         }
         if(relativeStartPosition != 0 && relativeStartPosition != textLength && CharacterUtil.isLowSurrogate(_text.charCodeAt(relativeStartPosition)) || relativeEndPosition != 0 && relativeEndPosition != textLength && CharacterUtil.isHighSurrogate(_text.charCodeAt(relativeEndPosition - 1)))
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSurrogatePairSplit"));
         }
         if(this.hasParagraphTerminator)
         {
            if(relativeStartPosition == textLength)
            {
               relativeStartPosition--;
            }
            if(relativeEndPosition == textLength)
            {
               relativeEndPosition--;
            }
         }
         if(relativeEndPosition != relativeStartPosition)
         {
            modelChanged(ModelChange.TEXT_DELETED,this,relativeStartPosition,relativeEndPosition - relativeStartPosition);
         }
         this.replaceTextInternal(relativeStartPosition,relativeEndPosition,textValue);
         if(textValue && textValue.length)
         {
            modelChanged(ModelChange.TEXT_INSERTED,this,relativeStartPosition,textValue.length);
         }
      }
      
      private function replaceTextInternal(startPos:int, endPos:int, textValue:String) : void
      {
         var enclosingContainer:ContainerController = null;
         var textValueLength:int = textValue == null ? 0 : int(textValue.length);
         var deleteTotal:int = endPos - startPos;
         var deltaChars:int = textValueLength - deleteTotal;
         if(_blockElement)
         {
            (_blockElement as TextElement).replaceText(startPos,endPos,textValue);
            _text = _blockElement.rawText;
         }
         else if(_text)
         {
            if(textValue)
            {
               _text = _text.slice(0,startPos) + textValue + _text.slice(endPos,_text.length);
            }
            else
            {
               _text = _text.slice(0,startPos) + _text.slice(endPos,_text.length);
            }
         }
         else
         {
            _text = textValue;
         }
         if(deltaChars != 0)
         {
            updateLengths(getAbsoluteStart() + startPos,deltaChars,true);
            deleteContainerText(endPos,deleteTotal);
            if(textValueLength != 0)
            {
               enclosingContainer = getEnclosingController(startPos);
               if(enclosingContainer)
               {
                  ContainerController(enclosingContainer).setTextLength(enclosingContainer.textLength + textValueLength);
               }
            }
         }
      }
      
      tlf_internal function addParaTerminator() : void
      {
         if(_text && _text.substr(-1) == SpanElement.kParagraphTerminator)
         {
            return;
         }
         this.replaceTextInternal(textLength,textLength,SpanElement.kParagraphTerminator);
         modelChanged(ModelChange.TEXT_INSERTED,this,textLength - 1,1);
      }
      
      tlf_internal function removeParaTerminator() : void
      {
         if(!_text || _text.substr(-1) != SpanElement.kParagraphTerminator)
         {
            return;
         }
         this.replaceTextInternal(textLength - 1,textLength,"");
         modelChanged(ModelChange.TEXT_DELETED,this,textLength > 0 ? int(textLength - 1) : 0,1);
      }
      
      override public function splitAtPosition(relativePosition:int) : FlowElement
      {
         var newBlockElement:TextElement = null;
         var newSpanLength:int = 0;
         var p:ParagraphElement = null;
         var group:GroupElement = null;
         var elementIndex:int = 0;
         if(relativePosition < 0 || relativePosition > textLength)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
         }
         if(relativePosition < textLength && CharacterUtil.isLowSurrogate(String(this.text).charCodeAt(relativePosition)))
         {
            throw RangeError(GlobalSettings.resourceStringFunction("invalidSurrogatePairSplit"));
         }
         var newSpan:SpanElement = new SpanElement();
         newSpan.id = this.id;
         newSpan.typeName = this.typeName;
         if(parent)
         {
            newSpanLength = textLength - relativePosition;
            if(_blockElement)
            {
               group = parent.createContentAsGroup(getElementRelativeStart(parent));
               elementIndex = group.getElementIndex(_blockElement);
               group.splitTextElement(elementIndex,relativePosition);
               _blockElement = group.getElementAt(elementIndex);
               _text = _blockElement.rawText;
               newBlockElement = group.getElementAt(elementIndex + 1) as TextElement;
            }
            else if(relativePosition < textLength)
            {
               newSpan.text = _text.substr(relativePosition);
               _text = _text.substring(0,relativePosition);
            }
            modelChanged(ModelChange.TEXT_DELETED,this,relativePosition,newSpanLength);
            newSpan.quickInitializeForSplit(this,newSpanLength,newBlockElement);
            setTextLength(relativePosition);
            parent.addChildAfterInternal(this,newSpan);
            p = this.getParagraph();
            p.updateTerminatorSpan(this,newSpan);
            parent.modelChanged(ModelChange.ELEMENT_ADDED,newSpan,newSpan.parentRelativeStart,newSpan.textLength);
         }
         else
         {
            newSpan.format = format;
            if(relativePosition < textLength)
            {
               newSpan.text = String(this.text).substr(relativePosition);
               this.replaceText(relativePosition,textLength,null);
            }
         }
         return newSpan;
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
         var p:ParagraphElement = null;
         var prevLeaf:FlowLeafElement = null;
         if(this.textLength == 1 && !tlf_internal::bindableElement)
         {
            p = getParagraph();
            if(p && p.getLastLeaf() == this)
            {
               prevLeaf = getPreviousLeaf(p);
               if(prevLeaf)
               {
                  if(!TextLayoutFormat.isEqual(this.format,prevLeaf.format))
                  {
                     this.format = prevLeaf.format;
                  }
               }
            }
         }
         super.normalizeRange(normalizeStart,normalizeEnd);
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean
      {
         var myidx:int = 0;
         var sib:SpanElement = null;
         var thisIsSimpleTerminator:Boolean = false;
         var p:ParagraphElement = null;
         var prevLeaf:FlowLeafElement = null;
         var siblingInsertPosition:int = 0;
         if(parent && !tlf_internal::bindableElement)
         {
            myidx = parent.getChildIndex(this);
            if(myidx != 0)
            {
               sib = parent.getChildAt(myidx - 1) as SpanElement;
               if(!sib && this.textLength == 1 && this.hasParagraphTerminator)
               {
                  p = getParagraph();
                  if(p)
                  {
                     prevLeaf = getPreviousLeaf(p) as SpanElement;
                     if(prevLeaf)
                     {
                        parent.removeChildAt(myidx);
                        return true;
                     }
                  }
               }
               if(sib == null)
               {
                  return false;
               }
               if(this.hasActiveEventMirror())
               {
                  return false;
               }
               thisIsSimpleTerminator = textLength == 1 && this.hasParagraphTerminator;
               if(sib.hasActiveEventMirror() && !thisIsSimpleTerminator)
               {
                  return false;
               }
               if(thisIsSimpleTerminator || equalStylesForMerge(sib))
               {
                  siblingInsertPosition = sib.textLength;
                  sib.replaceText(siblingInsertPosition,siblingInsertPosition,this.text);
                  parent.removeChildAt(myidx);
                  return true;
               }
            }
         }
         return false;
      }
   }
}
