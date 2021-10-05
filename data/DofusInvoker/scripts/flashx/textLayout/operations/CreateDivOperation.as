package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementMark;
   import flashx.textLayout.edit.MementoList;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class CreateDivOperation extends FlowTextOperation
   {
       
      
      private var _divParentMarker:ElementMark;
      
      private var _mementoList:MementoList;
      
      private var _format:ITextLayoutFormat;
      
      private var _divElement:DivElement;
      
      private var _postOpSelectionState:SelectionState;
      
      public function CreateDivOperation(operationState:SelectionState, parent:FlowGroupElement = null, format:ITextLayoutFormat = null)
      {
         super(operationState);
         this.parent = parent;
         this._format = format;
         this._mementoList = new MementoList(operationState.textFlow);
      }
      
      public function get parent() : FlowGroupElement
      {
         return !!this._divParentMarker ? this._divParentMarker.findElement(originalSelectionState.textFlow) as FlowGroupElement : null;
      }
      
      public function set parent(value:FlowGroupElement) : void
      {
         var begPos:int = 0;
         var endPos:int = 0;
         var begChildIdx:int = 0;
         var elem:FlowGroupElement = null;
         if(!value)
         {
            value = textFlow;
            begPos = this.absoluteStart;
            endPos = this.absoluteEnd;
            while(true)
            {
               begChildIdx = value.findChildIndexAtPosition(begPos);
               elem = value.getChildAt(begChildIdx) as FlowGroupElement;
               if(elem is ParagraphElement)
               {
                  break;
               }
               begPos -= elem.parentRelativeStart;
               endPos -= elem.parentRelativeStart;
               if(endPos >= elem.textLength)
               {
                  break;
               }
               value = elem;
            }
         }
         else if(value is SubParagraphGroupElementBase)
         {
            value = value.getParagraph().parent;
         }
         this._divParentMarker = new ElementMark(value,0);
      }
      
      public function get format() : ITextLayoutFormat
      {
         return this._format;
      }
      
      public function set format(value:ITextLayoutFormat) : void
      {
         this._format = value;
      }
      
      public function get newDivElement() : DivElement
      {
         return this._divElement;
      }
      
      override public function doOperation() : Boolean
      {
         var endChildIndex:int = 0;
         var child:FlowGroupElement = null;
         var target:FlowGroupElement = this.parent;
         if(!target || target is ParagraphElement || target is SubParagraphGroupElementBase)
         {
            return false;
         }
         var begChildIndex:int = 0;
         var begStart:int = absoluteStart - target.getAbsoluteStart();
         var endStart:int = absoluteEnd - target.getAbsoluteStart();
         if(begStart > 0)
         {
            begChildIndex = target.findChildIndexAtPosition(begStart);
            child = target.getChildAt(begChildIndex) as FlowGroupElement;
            if(child.parentRelativeStart != begStart)
            {
               this._mementoList.push(ModelEdit.splitElement(textFlow,child,begStart - child.parentRelativeStart));
               if(child is ParagraphElement)
               {
                  endStart++;
               }
               begChildIndex++;
            }
         }
         if(endStart >= 0)
         {
            if(endStart >= target.textLength - 1)
            {
               endChildIndex = target.numChildren;
            }
            else
            {
               endChildIndex = target.findChildIndexAtPosition(endStart);
               child = target.getChildAt(endChildIndex) as FlowGroupElement;
               if(child.parentRelativeStart != endStart)
               {
                  this._mementoList.push(ModelEdit.splitElement(textFlow,child,endStart - child.parentRelativeStart));
                  endChildIndex++;
               }
            }
         }
         else
         {
            endChildIndex = begChildIndex + 1;
         }
         this._divElement = new DivElement();
         this._divElement.format = this.format;
         if(begChildIndex == target.numChildren)
         {
            child = target.getChildAt(target.numChildren - 1) as FlowGroupElement;
            this._mementoList.push(ModelEdit.splitElement(textFlow,child,child.textLength));
            this._mementoList.push(ModelEdit.addElement(textFlow,this._divElement,target,target.numChildren));
            this._mementoList.push(ModelEdit.moveElement(textFlow,child,this._divElement,this._divElement.numChildren));
         }
         else
         {
            this._mementoList.push(ModelEdit.addElement(textFlow,this._divElement,target,endChildIndex));
            if(begChildIndex == endChildIndex)
            {
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),this._divElement,0));
            }
            else
            {
               while(begChildIndex < endChildIndex)
               {
                  child = target.getChildAt(begChildIndex) as FlowGroupElement;
                  if(child is ListItemElement)
                  {
                     while(child.numChildren)
                     {
                        this._mementoList.push(ModelEdit.moveElement(textFlow,child.getChildAt(0),this._divElement,this._divElement.numChildren));
                     }
                     this._mementoList.push(ModelEdit.removeElements(textFlow,target,begChildIndex,1));
                  }
                  else
                  {
                     this._mementoList.push(ModelEdit.moveElement(textFlow,child,this._divElement,this._divElement.numChildren));
                     child.normalizeRange(0,child.textLength);
                  }
                  endChildIndex--;
               }
            }
            if(target is ListItemElement && (target as ListItemElement).normalizeNeedsInitialParagraph())
            {
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),target,0));
            }
         }
         if(originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
         {
            textFlow.normalize();
            this._postOpSelectionState = new SelectionState(textFlow,this._divElement.getAbsoluteStart(),this._divElement.getAbsoluteStart() + this._divElement.textLength - 1);
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
