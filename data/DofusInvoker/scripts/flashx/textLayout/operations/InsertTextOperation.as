package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.ParaEdit;
   import flashx.textLayout.edit.PointFormat;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.edit.TextFlowEdit;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class InsertTextOperation extends FlowTextOperation
   {
       
      
      private var _deleteSelectionState:SelectionState;
      
      private var delSelOp:DeleteTextOperation = null;
      
      public var _text:String;
      
      private var _pointFormat:ITextLayoutFormat;
      
      public function InsertTextOperation(operationState:SelectionState, text:String, deleteSelectionState:SelectionState = null)
      {
         super(operationState);
         this._pointFormat = operationState.pointFormat;
         this._text = text;
         this.initialize(deleteSelectionState);
      }
      
      private function initialize(deleteSelectionState:SelectionState) : void
      {
         if(deleteSelectionState == null)
         {
            deleteSelectionState = originalSelectionState;
         }
         if(deleteSelectionState.anchorPosition != deleteSelectionState.activePosition)
         {
            this._deleteSelectionState = deleteSelectionState;
            this.delSelOp = new DeleteTextOperation(this._deleteSelectionState);
         }
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(value:String) : void
      {
         this._text = value;
      }
      
      public function get deleteSelectionState() : SelectionState
      {
         return this._deleteSelectionState;
      }
      
      public function set deleteSelectionState(value:SelectionState) : void
      {
         this._deleteSelectionState = value;
      }
      
      public function get characterFormat() : ITextLayoutFormat
      {
         return this._pointFormat;
      }
      
      public function set characterFormat(value:ITextLayoutFormat) : void
      {
         this._pointFormat = new PointFormat(value);
      }
      
      private function doDelete(leaf:FlowLeafElement) : ITextLayoutFormat
      {
         var deleteFormat:PointFormat = PointFormat.createFromFlowElement(textFlow.findLeaf(absoluteStart));
         var beforeDeleteFormat:PointFormat = absoluteStart == leaf.getParagraph().getAbsoluteStart() ? null : PointFormat.createFromFlowElement(textFlow.findLeaf(absoluteStart - 1));
         if(this.delSelOp.doOperation())
         {
            if(!this._pointFormat && absoluteStart < absoluteEnd && PointFormat.isEqual(deleteFormat,beforeDeleteFormat))
            {
               deleteFormat = null;
            }
            else if(leaf.textLength == 0)
            {
               leaf.parent.removeChild(leaf);
            }
         }
         return deleteFormat;
      }
      
      private function applyPointFormat(span:SpanElement, pointFormat:ITextLayoutFormat) : void
      {
         var spanFormat:TextLayoutFormat = null;
         var pf:PointFormat = null;
         var linkLeaf:FlowLeafElement = null;
         var linkElement:FlowElement = null;
         var tcyLeaf:FlowLeafElement = null;
         var tcyElement:FlowElement = null;
         if(!TextLayoutFormat.isEqual(pointFormat,span.format))
         {
            spanFormat = new TextLayoutFormat(span.format);
            spanFormat.apply(pointFormat);
            span.format = spanFormat;
         }
         if(pointFormat is PointFormat)
         {
            pf = pointFormat as PointFormat;
            if(pf.linkElement)
            {
               if(pf.linkElement.href)
               {
                  TextFlowEdit.makeLink(textFlow,absoluteStart,absoluteStart + this._text.length,pf.linkElement.href,pf.linkElement.target);
                  linkLeaf = textFlow.findLeaf(absoluteStart);
                  linkElement = linkLeaf.getParentByType(LinkElement);
                  linkElement.format = pf.linkElement.format;
               }
            }
            if(pf.tcyElement)
            {
               TextFlowEdit.makeTCY(textFlow,absoluteStart,absoluteStart + this._text.length);
               tcyLeaf = textFlow.findLeaf(absoluteStart);
               tcyElement = tcyLeaf.getParentByType(TCYElement);
               tcyElement.format = pf.tcyElement.format;
            }
            else if(span.getParentByType(TCYElement))
            {
               TextFlowEdit.removeTCY(textFlow,absoluteStart,absoluteStart + this._text.length);
            }
         }
      }
      
      private function doInternal() : void
      {
         var deleteFormat:ITextLayoutFormat = null;
         var state:SelectionState = null;
         if(this.delSelOp != null)
         {
            deleteFormat = this.doDelete(textFlow.findLeaf(absoluteStart));
         }
         var span:SpanElement = ParaEdit.insertText(textFlow,absoluteStart,this._text,this._pointFormat != null || deleteFormat != null);
         if(textFlow.interactionManager)
         {
            textFlow.interactionManager.notifyInsertOrDelete(absoluteStart,this._text.length);
         }
         if(span != null)
         {
            if(deleteFormat)
            {
               span.format = deleteFormat;
               this.applyPointFormat(span,deleteFormat);
               if(deleteFormat is PointFormat && PointFormat(deleteFormat).linkElement && PointFormat(deleteFormat).linkElement.href && originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
               {
                  state = textFlow.interactionManager.getSelectionState();
                  state.pointFormat = PointFormat.clone(deleteFormat as PointFormat);
                  textFlow.interactionManager.setSelectionState(state);
               }
            }
            if(this._pointFormat)
            {
               this.applyPointFormat(span,this._pointFormat);
            }
         }
      }
      
      override public function doOperation() : Boolean
      {
         this.doInternal();
         return true;
      }
      
      override public function undo() : SelectionState
      {
         ModelEdit.deleteText(textFlow,absoluteStart,absoluteStart + this._text.length,false);
         var newSelectionState:SelectionState = originalSelectionState;
         if(this.delSelOp != null)
         {
            newSelectionState = this.delSelOp.undo();
         }
         return originalSelectionState;
      }
      
      override public function redo() : SelectionState
      {
         this.doInternal();
         return new SelectionState(textFlow,absoluteStart + this._text.length,absoluteStart + this._text.length,null);
      }
      
      override tlf_internal function merge(op2:FlowOperation) : FlowOperation
      {
         if(absoluteStart < absoluteEnd)
         {
            return null;
         }
         if(this.endGeneration != op2.beginGeneration)
         {
            return null;
         }
         var insertOp:InsertTextOperation = null;
         if(op2 is InsertTextOperation)
         {
            insertOp = op2 as InsertTextOperation;
         }
         if(insertOp)
         {
            if(insertOp.deleteSelectionState != null || this.deleteSelectionState != null)
            {
               return null;
            }
            if(insertOp.originalSelectionState.pointFormat == null && originalSelectionState.pointFormat != null)
            {
               return null;
            }
            if(originalSelectionState.pointFormat == null && insertOp.originalSelectionState.pointFormat != null)
            {
               return null;
            }
            if(originalSelectionState.absoluteStart + this._text.length != insertOp.originalSelectionState.absoluteStart)
            {
               return null;
            }
            if(originalSelectionState.pointFormat == null && insertOp.originalSelectionState.pointFormat == null || PointFormat.isEqual(originalSelectionState.pointFormat,insertOp.originalSelectionState.pointFormat))
            {
               this._text += insertOp.text;
               setGenerations(beginGeneration,insertOp.endGeneration);
               setGenerations(beginGeneration,insertOp.endGeneration);
               return this;
            }
            return null;
         }
         if(op2 is SplitParagraphOperation)
         {
            return new CompositeOperation([this,op2]);
         }
         return null;
      }
   }
}
