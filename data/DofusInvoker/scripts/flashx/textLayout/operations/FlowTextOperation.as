package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   
   public class FlowTextOperation extends FlowOperation
   {
       
      
      private var _originalSelectionState:SelectionState;
      
      private var _absoluteStart:int;
      
      private var _absoluteEnd:int;
      
      public function FlowTextOperation(operationState:SelectionState)
      {
         super(operationState.textFlow);
         this._absoluteStart = operationState.absoluteStart;
         this._absoluteEnd = operationState.absoluteEnd;
         this._originalSelectionState = operationState;
      }
      
      public function get absoluteStart() : int
      {
         return this._absoluteStart;
      }
      
      public function set absoluteStart(value:int) : void
      {
         this._absoluteStart = value;
      }
      
      public function get absoluteEnd() : int
      {
         return this._absoluteEnd;
      }
      
      public function set absoluteEnd(value:int) : void
      {
         this._absoluteEnd = value;
      }
      
      public function get originalSelectionState() : SelectionState
      {
         return this._originalSelectionState;
      }
      
      public function set originalSelectionState(value:SelectionState) : void
      {
         this._originalSelectionState = value;
      }
      
      override public function redo() : SelectionState
      {
         doOperation();
         return this._originalSelectionState;
      }
   }
}
