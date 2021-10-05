package flashx.textLayout.operations
{
   public class UndoOperation extends FlowOperation
   {
       
      
      private var _operation:FlowOperation;
      
      public function UndoOperation(op:FlowOperation)
      {
         super(null);
         this._operation = op;
      }
      
      public function get operation() : FlowOperation
      {
         return this._operation;
      }
      
      public function set operation(value:FlowOperation) : void
      {
         this._operation = value;
      }
   }
}
