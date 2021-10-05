package flashx.textLayout.operations
{
   import flashx.textLayout.edit.MementoList;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.TextFlow;
   
   public class MoveChildrenOperation extends FlowTextOperation
   {
       
      
      private var _source:FlowGroupElement;
      
      private var _sourceIndex:int;
      
      private var _numChildren:int;
      
      private var _destination:FlowGroupElement;
      
      private var _destinationIndex:int;
      
      private var _mementoList:MementoList;
      
      public function MoveChildrenOperation(operationState:SelectionState, source:FlowGroupElement, sourceIndex:int, numChildren:int, destination:FlowGroupElement, destinationIndex:int)
      {
         super(operationState);
         this._source = source;
         this._sourceIndex = sourceIndex;
         this._numChildren = numChildren;
         this._destination = destination;
         this._destinationIndex = destinationIndex;
         this._mementoList = new MementoList(operationState.textFlow);
      }
      
      public function get source() : FlowGroupElement
      {
         return this._source;
      }
      
      public function set source(val:FlowGroupElement) : void
      {
         this._source = val;
      }
      
      public function get sourceIndex() : int
      {
         return this._sourceIndex;
      }
      
      public function set sourceIndex(val:int) : void
      {
         this._sourceIndex = val;
      }
      
      public function get numChildren() : int
      {
         return this._numChildren;
      }
      
      public function set numChildren(val:int) : void
      {
         this._numChildren = val;
      }
      
      public function get destination() : FlowGroupElement
      {
         return this._destination;
      }
      
      public function set destination(val:FlowGroupElement) : void
      {
         this._destination = val;
      }
      
      public function get destinationIndex() : int
      {
         return this._destinationIndex;
      }
      
      public function set destinationIndex(val:int) : void
      {
         this._destinationIndex = val;
      }
      
      override public function doOperation() : Boolean
      {
         var insertContext:FlowGroupElement = null;
         var idx:int = 0;
         var count2:int = 0;
         for(var count:int = 0; count < this._numChildren; count++)
         {
            if(this._source.getChildAt(this._sourceIndex) is ListItemElement && !(this._destination is ListElement))
            {
               count2 = 0;
               while(count2 = (this._source.getChildAt(this._sourceIndex) as FlowGroupElement).numChildren)
               {
                  this._mementoList.push(ModelEdit.moveElement(textFlow,(this._source.getChildAt(this._sourceIndex) as FlowGroupElement).getChildAt(0),this._destination,this._destinationIndex++));
                  count2++;
               }
               this._mementoList.push(ModelEdit.removeElements(textFlow,this._source,this._sourceIndex,1));
            }
            else
            {
               this._mementoList.push(ModelEdit.moveElement(textFlow,this._source.getChildAt(this._sourceIndex),this._destination,this._destinationIndex++));
            }
         }
         var parent:FlowGroupElement = this._source;
         while(parent.numChildren == 0 && !(parent is TextFlow))
         {
            idx = parent.parent.getChildIndex(parent);
            parent = parent.parent;
            this._mementoList.push(ModelEdit.removeElements(textFlow,parent,idx,1));
            insertContext = parent;
         }
         if(parent is ListElement)
         {
            insertContext = parent.parent;
            idx = parent.parent.getChildIndex(parent);
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
         return originalSelectionState;
      }
   }
}
