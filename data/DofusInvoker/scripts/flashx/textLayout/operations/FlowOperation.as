package flashx.textLayout.operations
{
   import flashx.textLayout.edit.IEditManager;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   import flashx.undo.IOperation;
   
   public class FlowOperation implements IOperation
   {
       
      
      public var userData;
      
      private var _beginGeneration:uint;
      
      private var _endGeneration:uint;
      
      private var _textFlow:TextFlow;
      
      public function FlowOperation(textFlow:TextFlow)
      {
         super();
         this._textFlow = textFlow;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         this._textFlow = value;
      }
      
      public function doOperation() : Boolean
      {
         return false;
      }
      
      public function undo() : SelectionState
      {
         return null;
      }
      
      public function canUndo() : Boolean
      {
         return true;
      }
      
      public function redo() : SelectionState
      {
         return null;
      }
      
      public function get beginGeneration() : uint
      {
         return this._beginGeneration;
      }
      
      public function get endGeneration() : uint
      {
         return this._endGeneration;
      }
      
      public function performUndo() : void
      {
         var editManager:IEditManager = !!this.textFlow ? this.textFlow.interactionManager as IEditManager : null;
         if(editManager != null)
         {
            editManager.performUndo(this);
         }
      }
      
      public function performRedo() : void
      {
         var editManager:IEditManager = !!this.textFlow ? this.textFlow.interactionManager as IEditManager : null;
         if(editManager != null)
         {
            editManager.performRedo(this);
         }
      }
      
      tlf_internal function setGenerations(beginGeneration:uint, endGeneration:uint) : void
      {
         this._beginGeneration = beginGeneration;
         this._endGeneration = endGeneration;
      }
      
      tlf_internal function merge(operation:FlowOperation) : FlowOperation
      {
         return null;
      }
   }
}
