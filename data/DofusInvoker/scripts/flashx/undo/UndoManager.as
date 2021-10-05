package flashx.undo
{
   public class UndoManager implements IUndoManager
   {
       
      
      private var undoStack:Array;
      
      private var redoStack:Array;
      
      private var _undoAndRedoItemLimit:int = 25;
      
      public function UndoManager()
      {
         super();
         this.undoStack = new Array();
         this.redoStack = new Array();
      }
      
      public function clearAll() : void
      {
         this.undoStack.length = 0;
         this.redoStack.length = 0;
      }
      
      public function canUndo() : Boolean
      {
         return this.undoStack.length > 0;
      }
      
      public function peekUndo() : IOperation
      {
         return this.undoStack.length > 0 ? this.undoStack[this.undoStack.length - 1] : null;
      }
      
      public function popUndo() : IOperation
      {
         return IOperation(this.undoStack.pop());
      }
      
      public function pushUndo(operation:IOperation) : void
      {
         this.undoStack.push(operation);
         this.trimUndoRedoStacks();
      }
      
      public function canRedo() : Boolean
      {
         return this.redoStack.length > 0;
      }
      
      public function clearRedo() : void
      {
         this.redoStack.length = 0;
      }
      
      public function peekRedo() : IOperation
      {
         return this.redoStack.length > 0 ? this.redoStack[this.redoStack.length - 1] : null;
      }
      
      public function popRedo() : IOperation
      {
         return IOperation(this.redoStack.pop());
      }
      
      public function pushRedo(operation:IOperation) : void
      {
         this.redoStack.push(operation);
         this.trimUndoRedoStacks();
      }
      
      public function get undoAndRedoItemLimit() : int
      {
         return this._undoAndRedoItemLimit;
      }
      
      public function set undoAndRedoItemLimit(value:int) : void
      {
         this._undoAndRedoItemLimit = value;
         this.trimUndoRedoStacks();
      }
      
      public function undo() : void
      {
         var undoOp:IOperation = null;
         if(this.canUndo())
         {
            undoOp = this.popUndo();
            undoOp.performUndo();
         }
      }
      
      public function redo() : void
      {
         var redoOp:IOperation = null;
         if(this.canRedo())
         {
            redoOp = this.popRedo();
            redoOp.performRedo();
         }
      }
      
      private function trimUndoRedoStacks() : void
      {
         var numToSplice:int = 0;
         var numItems:int = this.undoStack.length + this.redoStack.length;
         if(numItems > this._undoAndRedoItemLimit)
         {
            numToSplice = Math.min(numItems - this._undoAndRedoItemLimit,this.redoStack.length);
            if(numToSplice)
            {
               this.redoStack.splice(0,numToSplice);
               numItems = this.undoStack.length + this.redoStack.length;
            }
            if(numItems > this._undoAndRedoItemLimit)
            {
               numToSplice = Math.min(numItems - this._undoAndRedoItemLimit,this.undoStack.length);
               this.undoStack.splice(0,numToSplice);
            }
         }
      }
   }
}
