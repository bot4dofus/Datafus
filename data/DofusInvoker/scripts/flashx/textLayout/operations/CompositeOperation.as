package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class CompositeOperation extends FlowOperation
   {
       
      
      private var _operations:Array;
      
      public function CompositeOperation(operations:Array = null)
      {
         super(null);
         this.operations = operations;
         if(this._operations.length)
         {
            setGenerations(this._operations[0].beginGeneration,this._operations[this._operations.length - 1].endGeneration);
         }
      }
      
      override public function get textFlow() : TextFlow
      {
         return this._operations.length > 0 ? this._operations[0].textFlow : null;
      }
      
      public function get operations() : Array
      {
         return this._operations;
      }
      
      public function set operations(value:Array) : void
      {
         this._operations = !!value ? value.slice() : [];
      }
      
      public function addOperation(operation:FlowOperation) : void
      {
         if(this._operations.length > 0 && operation.textFlow != this.textFlow)
         {
            return;
         }
         this._operations.push(operation);
      }
      
      override public function doOperation() : Boolean
      {
         var success:Boolean = true;
         for(var i:int = 0; i < this._operations.length; i++)
         {
            success = success && FlowOperation(this._operations[i]).doOperation();
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         var selState:SelectionState = null;
         for(var i:int = this._operations.length - 1; i >= 0; i--)
         {
            selState = FlowOperation(this._operations[i]).undo();
         }
         return selState;
      }
      
      override public function redo() : SelectionState
      {
         var selState:SelectionState = null;
         for(var i:int = 0; i < this._operations.length; i++)
         {
            selState = FlowOperation(this._operations[i]).redo();
         }
         return selState;
      }
      
      override public function canUndo() : Boolean
      {
         var op:FlowOperation = null;
         var undoable:Boolean = true;
         var generation:int = beginGeneration;
         var opCount:int = this._operations.length;
         var i:int = 0;
         while(i < opCount && undoable)
         {
            op = this._operations[i];
            if(op.beginGeneration != generation || !op.canUndo())
            {
               undoable = false;
            }
            generation = op.endGeneration;
            i++;
         }
         if(opCount > 0 && this._operations[opCount - 1].endGeneration != endGeneration)
         {
            undoable = false;
         }
         return undoable;
      }
      
      override tlf_internal function merge(operation:FlowOperation) : FlowOperation
      {
         var mergedOp:FlowOperation = null;
         var lastOp:FlowOperation = null;
         if(operation is InsertTextOperation || operation is SplitParagraphOperation || operation is DeleteTextOperation)
         {
            if(this.endGeneration != operation.beginGeneration)
            {
               return null;
            }
            lastOp = this._operations && this._operations.length ? FlowOperation(this._operations[this._operations.length - 1]) : null;
            if(lastOp)
            {
               mergedOp = lastOp.merge(operation);
            }
            if(mergedOp && !(mergedOp is CompositeOperation))
            {
               this._operations[this._operations.length - 1] = mergedOp;
            }
            else
            {
               this._operations.push(operation);
            }
            setGenerations(beginGeneration,operation.endGeneration);
            return this;
         }
         return null;
      }
   }
}
