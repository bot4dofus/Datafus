package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.edit.TextScrap;
   
   public class CutOperation extends FlowTextOperation
   {
       
      
      private var _tScrap:TextScrap;
      
      private var _deleteTextOperation:DeleteTextOperation;
      
      public function CutOperation(operationState:SelectionState, scrapToCut:TextScrap)
      {
         super(operationState);
         if(absoluteStart < absoluteEnd)
         {
            this._tScrap = scrapToCut;
         }
      }
      
      override public function doOperation() : Boolean
      {
         this._deleteTextOperation = new DeleteTextOperation(originalSelectionState);
         return this._deleteTextOperation.doOperation();
      }
      
      override public function undo() : SelectionState
      {
         return this._deleteTextOperation.undo();
      }
      
      override public function redo() : SelectionState
      {
         return this._deleteTextOperation.redo();
      }
      
      public function get scrapToCut() : TextScrap
      {
         return this._tScrap;
      }
      
      public function set scrapToCut(val:TextScrap) : void
      {
         this._tScrap = val;
      }
   }
}
