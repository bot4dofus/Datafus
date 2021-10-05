package flashx.textLayout.operations
{
   import flashx.textLayout.edit.IMemento;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.edit.TextFlowEdit;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.TCYElement;
   
   public class ApplyTCYOperation extends FlowTextOperation
   {
       
      
      private var makeBegIdx:int;
      
      private var makeEndIdx:int;
      
      private var removeBegIdx:int;
      
      private var removeEndIdx:int;
      
      private var removeRedoBegIdx:int;
      
      private var removeRedoEndIdx:int;
      
      private var _memento:IMemento;
      
      private var _tcyOn:Boolean;
      
      private var _tcyElement:TCYElement;
      
      public function ApplyTCYOperation(operationState:SelectionState, tcyOn:Boolean)
      {
         super(operationState);
         if(tcyOn)
         {
            this.makeBegIdx = operationState.absoluteStart;
            this.makeEndIdx = operationState.absoluteEnd;
         }
         else
         {
            this.removeBegIdx = operationState.absoluteStart;
            this.removeEndIdx = operationState.absoluteEnd;
         }
         this._tcyOn = tcyOn;
      }
      
      public function get tcyOn() : Boolean
      {
         return this._tcyOn;
      }
      
      public function set tcyOn(val:Boolean) : void
      {
         this._tcyOn = val;
      }
      
      public function get newTCYElement() : TCYElement
      {
         return this._tcyElement;
      }
      
      override public function doOperation() : Boolean
      {
         var leaf:FlowLeafElement = null;
         var tcyElem:TCYElement = null;
         if(this._tcyOn && this.makeEndIdx <= this.makeBegIdx)
         {
            return false;
         }
         if(!this._tcyOn && this.removeEndIdx <= this.removeBegIdx)
         {
            return false;
         }
         if(this._tcyOn)
         {
            this._memento = ModelEdit.saveCurrentState(textFlow,this.makeBegIdx,this.makeEndIdx);
            if(TextFlowEdit.makeTCY(textFlow,this.makeBegIdx,this.makeEndIdx))
            {
               leaf = textFlow.findLeaf(this.makeBegIdx);
               this._tcyElement = leaf.getParentByType(TCYElement) as TCYElement;
            }
         }
         else
         {
            leaf = textFlow.findLeaf(this.removeBegIdx);
            tcyElem = leaf.getParentByType(TCYElement) as TCYElement;
            this.removeRedoBegIdx = this.removeBegIdx;
            this.removeRedoEndIdx = this.removeEndIdx;
            this.removeBegIdx = tcyElem.getAbsoluteStart();
            this.removeEndIdx = this.removeBegIdx + tcyElem.textLength;
            this._memento = ModelEdit.saveCurrentState(textFlow,this.removeBegIdx,this.removeEndIdx);
            TextFlowEdit.removeTCY(textFlow,this.removeRedoBegIdx,this.removeRedoEndIdx);
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         this._memento.undo();
         return originalSelectionState;
      }
      
      override public function redo() : SelectionState
      {
         if(this._tcyOn)
         {
            TextFlowEdit.makeTCY(textFlow,this.makeBegIdx,this.makeEndIdx);
         }
         else
         {
            TextFlowEdit.removeTCY(textFlow,this.removeRedoBegIdx,this.removeRedoEndIdx);
         }
         return originalSelectionState;
      }
   }
}
