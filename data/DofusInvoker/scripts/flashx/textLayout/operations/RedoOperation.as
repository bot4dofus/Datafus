package flashx.textLayout.operations
{
   public class RedoOperation extends FlowOperation
   {
       
      
      private var _operation:FlowOperation;
      
      public function RedoOperation(operation:FlowOperation)
      {
         super(operation.textFlow);
         this._operation = operation;
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
