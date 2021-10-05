package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   
   public class ApplyElementTypeNameOperation extends FlowElementOperation
   {
       
      
      private var _undoTypeName:String;
      
      private var _typeName:String;
      
      public function ApplyElementTypeNameOperation(operationState:SelectionState, targetElement:FlowElement, typeName:String, relativeStart:int = 0, relativeEnd:int = -1)
      {
         this._typeName = typeName;
         super(operationState,targetElement,relativeStart,relativeEnd);
      }
      
      public function get typeName() : String
      {
         return this._typeName;
      }
      
      public function set typeName(val:String) : void
      {
         this._typeName = val;
      }
      
      override public function doOperation() : Boolean
      {
         var targetElement:FlowElement = getTargetElement();
         this._undoTypeName = targetElement.typeName;
         adjustForDoOperation(targetElement);
         targetElement.typeName = this._typeName;
         return true;
      }
      
      override public function undo() : SelectionState
      {
         var targetElement:FlowElement = getTargetElement();
         targetElement.typeName = this._undoTypeName;
         adjustForUndoOperation(targetElement);
         return originalSelectionState;
      }
   }
}
