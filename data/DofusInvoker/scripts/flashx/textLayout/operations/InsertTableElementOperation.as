package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementMark;
   import flashx.textLayout.edit.MementoList;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.PointFormat;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class InsertTableElementOperation extends FlowTextOperation
   {
       
      
      private var delSelOp:DeleteTextOperation;
      
      private var _table:TableElement;
      
      private var selPos:int = 0;
      
      private var _mementoList:MementoList;
      
      private var _postOpSelectionState:SelectionState;
      
      private var _listParentMarker:ElementMark;
      
      public function InsertTableElementOperation(operationState:SelectionState, table:TableElement)
      {
         super(operationState);
         this._mementoList = new MementoList(operationState.textFlow);
         this._table = table;
      }
      
      override public function doOperation() : Boolean
      {
         var pointFormat:ITextLayoutFormat = null;
         var endChildIndex:int = 0;
         var child:FlowGroupElement = null;
         var leafEl:FlowLeafElement = null;
         var deleteFormat:PointFormat = null;
         this.selPos = absoluteStart;
         if(absoluteStart != absoluteEnd)
         {
            leafEl = textFlow.findLeaf(absoluteStart);
            deleteFormat = new PointFormat(textFlow.findLeaf(absoluteStart).format);
            this._mementoList.push(ModelEdit.deleteText(textFlow,absoluteStart,absoluteEnd,true));
            pointFormat = deleteFormat;
         }
         else
         {
            pointFormat = originalSelectionState.pointFormat;
         }
         var target:FlowGroupElement = textFlow;
         var begStart:int = absoluteStart;
         var begChildIndex:int = 0;
         if(begStart >= 0)
         {
            begChildIndex = target.findChildIndexAtPosition(begStart);
            child = target.getChildAt(begChildIndex) as FlowGroupElement;
            this._mementoList.push(ModelEdit.splitElement(textFlow,child,begStart - child.parentRelativeStart));
         }
         if(begStart >= target.textLength - 1)
         {
            endChildIndex = target.numChildren;
         }
         else
         {
            endChildIndex = begChildIndex + 1;
         }
         if(begChildIndex == target.numChildren)
         {
            child = target.getChildAt(target.numChildren - 1) as FlowGroupElement;
            this._mementoList.push(ModelEdit.addElement(textFlow,this._table,target,target.numChildren));
         }
         else
         {
            this._mementoList.push(ModelEdit.addElement(textFlow,this._table,target,endChildIndex));
         }
         if(originalSelectionState.selectionManagerOperationState && textFlow.interactionManager)
         {
            textFlow.normalize();
            this._postOpSelectionState = new SelectionState(textFlow,this._table.getAbsoluteStart(),this._table.getAbsoluteStart() + this._table.textLength - 1);
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
