package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementMark;
   import flashx.textLayout.edit.MementoList;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class CreateSubParagraphGroupOperation extends FlowTextOperation
   {
       
      
      private var _spgeParentMarker:ElementMark;
      
      private var _format:ITextLayoutFormat;
      
      private var _mementoList:MementoList;
      
      private var _spgeElement:SubParagraphGroupElement;
      
      private var _postOpSelectionState:SelectionState;
      
      public function CreateSubParagraphGroupOperation(operationState:SelectionState, parent:FlowGroupElement = null, format:ITextLayoutFormat = null)
      {
         super(operationState);
         this._format = format;
         this.parent = parent;
         this._mementoList = new MementoList(operationState.textFlow);
      }
      
      public function get parent() : FlowGroupElement
      {
         return !!this._spgeParentMarker ? this._spgeParentMarker.findElement(originalSelectionState.textFlow) as FlowGroupElement : null;
      }
      
      public function set parent(value:FlowGroupElement) : void
      {
         var begPos:int = 0;
         var endPos:int = 0;
         var para:ParagraphElement = null;
         var paraStart:int = 0;
         var begChildIdx:int = 0;
         var elem:FlowGroupElement = null;
         if(!value)
         {
            begPos = this.absoluteStart;
            endPos = this.absoluteEnd;
            para = textFlow.findLeaf(begPos).getParagraph();
            paraStart = para.getAbsoluteStart();
            if(begPos < paraStart + para.textLength - 1)
            {
               if(endPos >= paraStart + para.textLength - 1)
               {
                  endPos = paraStart + para.textLength;
               }
               value = para;
               while(true)
               {
                  begChildIdx = value.findChildIndexAtPosition(begPos);
                  elem = value.getChildAt(begChildIdx) as FlowGroupElement;
                  if(elem == null)
                  {
                     break;
                  }
                  begPos -= elem.parentRelativeStart;
                  endPos -= elem.parentRelativeStart;
                  if(endPos > elem.textLength)
                  {
                     break;
                  }
                  value = elem;
               }
            }
         }
         else if(!(value is SubParagraphGroupElementBase) || !(value is ParagraphElement))
         {
            value = null;
         }
         this._spgeParentMarker = !!value ? new ElementMark(value,0) : null;
      }
      
      public function get format() : ITextLayoutFormat
      {
         return this._format;
      }
      
      public function set format(value:ITextLayoutFormat) : void
      {
         this._format = value;
      }
      
      public function get newSubParagraphGroupElement() : SubParagraphGroupElement
      {
         return this._spgeElement;
      }
      
      override public function doOperation() : Boolean
      {
         var endChildIndex:int = 0;
         var child:FlowElement = null;
         var lastChild:FlowElement = null;
         if(absoluteStart == absoluteEnd)
         {
            return false;
         }
         var target:FlowGroupElement = this.parent;
         if(!target)
         {
            return false;
         }
         var begChildIndex:int = 0;
         var begStart:int = absoluteStart - target.getAbsoluteStart();
         var endStart:int = absoluteEnd - target.getAbsoluteStart();
         if(endStart >= target.getAbsoluteStart() + target.textLength - 1)
         {
            endStart = target.getAbsoluteStart() + target.textLength;
         }
         if(begStart > 0)
         {
            begChildIndex = target.findChildIndexAtPosition(begStart);
            child = target.getChildAt(begChildIndex);
            if(child.parentRelativeStart != begStart)
            {
               if(child is FlowGroupElement)
               {
                  this._mementoList.push(ModelEdit.splitElement(textFlow,child as FlowGroupElement,begStart - child.parentRelativeStart));
               }
               else
               {
                  child.splitAtPosition(begStart - child.parentRelativeStart);
               }
               begChildIndex++;
            }
         }
         if(endStart >= 0)
         {
            if(endStart >= target.textLength - 1)
            {
               endChildIndex = target.numChildren;
               if(endChildIndex != 0)
               {
                  lastChild = target.getChildAt(endChildIndex - 1);
                  if(lastChild is SpanElement && lastChild.textLength == 1 && (lastChild as SpanElement).hasParagraphTerminator)
                  {
                     endChildIndex--;
                  }
               }
            }
            else
            {
               endChildIndex = target.findChildIndexAtPosition(endStart);
               child = target.getChildAt(endChildIndex);
               if(child.parentRelativeStart != endStart)
               {
                  if(child is FlowGroupElement)
                  {
                     this._mementoList.push(ModelEdit.splitElement(textFlow,child as FlowGroupElement,endStart - child.parentRelativeStart));
                  }
                  else
                  {
                     child.splitAtPosition(endStart - child.parentRelativeStart);
                  }
                  endChildIndex++;
               }
            }
         }
         else
         {
            endChildIndex = begChildIndex + 1;
         }
         this._spgeElement = new SubParagraphGroupElement();
         this._spgeElement.format = this.format;
         this._mementoList.push(ModelEdit.addElement(textFlow,this._spgeElement,target,endChildIndex));
         while(begChildIndex < endChildIndex)
         {
            child = target.getChildAt(begChildIndex);
            if(child.textLength == 0)
            {
               begChildIndex++;
            }
            else
            {
               this._mementoList.push(ModelEdit.moveElement(textFlow,child,this._spgeElement,this._spgeElement.numChildren));
               endChildIndex--;
            }
         }
         if(originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
         {
            textFlow.normalize();
            this._postOpSelectionState = new SelectionState(textFlow,this._spgeElement.getAbsoluteStart(),this._spgeElement.getAbsoluteStart() + this._spgeElement.textLength);
            textFlow.interactionManager.setSelectionState(this._postOpSelectionState);
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         this._mementoList.undo();
         return originalSelectionState;
      }
      
      override public function redo() : SelectionState
      {
         this._mementoList.redo();
         return this._postOpSelectionState;
      }
   }
}
