package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.tlf_internal;
   
   public class SplitParagraphOperation extends SplitElementOperation
   {
       
      
      public function SplitParagraphOperation(operationState:SelectionState)
      {
         var para:ParagraphElement = operationState.textFlow.findLeaf(operationState.absoluteStart).getParagraph();
         super(operationState,para);
      }
      
      override tlf_internal function merge(operation:FlowOperation) : FlowOperation
      {
         if(this.endGeneration != operation.beginGeneration)
         {
            return null;
         }
         if(operation is SplitParagraphOperation || operation is InsertTextOperation)
         {
            return new CompositeOperation([this,operation]);
         }
         return null;
      }
   }
}
