package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   
   public class ApplyElementIDOperation extends FlowElementOperation
   {
       
      
      private var _origID:String;
      
      private var _newID:String;
      
      public function ApplyElementIDOperation(operationState:SelectionState, targetElement:FlowElement, newID:String, relativeStart:int = 0, relativeEnd:int = -1)
      {
         this._newID = newID;
         super(operationState,targetElement,relativeStart,relativeEnd);
      }
      
      public function get newID() : String
      {
         return this._newID;
      }
      
      public function set newID(val:String) : void
      {
         this._newID = val;
      }
      
      override public function doOperation() : Boolean
      {
         var targetElement:FlowElement = getTargetElement();
         this._origID = targetElement.id;
         adjustForDoOperation(targetElement);
         targetElement.id = this._newID;
         return true;
      }
      
      override public function undo() : SelectionState
      {
         var targetElement:FlowElement = getTargetElement();
         targetElement.id = this._origID;
         adjustForUndoOperation(targetElement);
         return originalSelectionState;
      }
   }
}
