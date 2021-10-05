package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementMark;
   import flashx.textLayout.edit.MementoList;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class CreateListOperation extends FlowTextOperation
   {
       
      
      private var _listParentMarker:ElementMark;
      
      private var _mementoList:MementoList;
      
      private var _listFormat:ITextLayoutFormat;
      
      private var _listElement:ListElement;
      
      private var _postOpSelectionState:SelectionState;
      
      public function CreateListOperation(operationState:SelectionState, parent:FlowGroupElement = null, listFormat:ITextLayoutFormat = null)
      {
         super(operationState);
         this.parent = parent;
         this._listFormat = listFormat;
         this._mementoList = new MementoList(operationState.textFlow);
      }
      
      public function get parent() : FlowGroupElement
      {
         return !!this._listParentMarker ? this._listParentMarker.findElement(originalSelectionState.textFlow) as FlowGroupElement : null;
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
         this._listParentMarker = new ElementMark(value,0);
      }
      
      public function get listFormat() : ITextLayoutFormat
      {
         return this._listFormat;
      }
      
      public function set listFormat(value:ITextLayoutFormat) : void
      {
         this._listFormat = value;
      }
      
      public function get newListElement() : ListElement
      {
         return this._listElement;
      }
      
      override public function doOperation() : Boolean
      {
         var endChildIndex:int = 0;
         var child:FlowGroupElement = null;
         var listItem:ListItemElement = null;
         var testListItem:ListItemElement = null;
         var target:FlowGroupElement = this.parent;
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
         this._listElement = new ListElement();
         this._listElement.format = this.listFormat;
         if(begChildIndex == target.numChildren)
         {
            child = target.getChildAt(target.numChildren - 1) as FlowGroupElement;
            this._mementoList.push(ModelEdit.splitElement(textFlow,child,child.textLength));
            this._mementoList.push(ModelEdit.addElement(textFlow,this._listElement,target,target.numChildren));
            if(!(child is ListItemElement))
            {
               listItem = new ListItemElement();
               this._mementoList.push(ModelEdit.addElement(textFlow,listItem,this._listElement,this._listElement.numChildren));
               this._mementoList.push(ModelEdit.moveElement(textFlow,child,listItem,listItem.numChildren));
               if(listItem.normalizeNeedsInitialParagraph())
               {
                  this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),listItem,0));
               }
            }
            else
            {
               this._mementoList.push(ModelEdit.moveElement(textFlow,child,this._listElement,this._listElement.numChildren));
            }
         }
         else
         {
            this._mementoList.push(ModelEdit.addElement(textFlow,this._listElement,target,endChildIndex));
            if(target is ListItemElement && (target as ListItemElement).normalizeNeedsInitialParagraph())
            {
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),target,0));
               begChildIndex++;
               endChildIndex++;
            }
            if(begChildIndex == endChildIndex)
            {
               listItem = new ListItemElement();
               this._mementoList.push(ModelEdit.addElement(textFlow,listItem,this._listElement,0));
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),listItem,0));
            }
            else
            {
               while(begChildIndex < endChildIndex)
               {
                  child = target.getChildAt(begChildIndex) as FlowGroupElement;
                  if(child is ListItemElement)
                  {
                     listItem = child as ListItemElement;
                     this._mementoList.push(ModelEdit.moveElement(textFlow,listItem,this._listElement,this._listElement.numChildren));
                     if(!(listItem.getChildAt(0) is ParagraphElement))
                     {
                        this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),listItem,0));
                     }
                  }
                  else
                  {
                     listItem = new ListItemElement();
                     this._mementoList.push(ModelEdit.addElement(textFlow,listItem,this._listElement,this._listElement.numChildren));
                     this._mementoList.push(ModelEdit.moveElement(textFlow,child,listItem,listItem.numChildren));
                     if(listItem.normalizeNeedsInitialParagraph())
                     {
                        this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),listItem,0));
                     }
                     child = listItem;
                  }
                  child.normalizeRange(0,child.textLength);
                  endChildIndex--;
               }
            }
            testListItem = target as ListItemElement;
            if(testListItem && testListItem.normalizeNeedsInitialParagraph())
            {
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),testListItem,0));
            }
            testListItem = target.parent as ListItemElement;
            if(testListItem && testListItem.normalizeNeedsInitialParagraph())
            {
               this._mementoList.push(ModelEdit.addElement(textFlow,new ParagraphElement(),testListItem,0));
            }
         }
         if(originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
         {
            textFlow.normalize();
            this._postOpSelectionState = new SelectionState(textFlow,this._listElement.getAbsoluteStart(),this._listElement.getAbsoluteStart() + this._listElement.textLength - 1);
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
