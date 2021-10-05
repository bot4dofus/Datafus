package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.operations.FlowOperation;
   
   public class FlowOperationEvent extends Event
   {
      
      public static const FLOW_OPERATION_BEGIN:String = "flowOperationBegin";
      
      public static const FLOW_OPERATION_END:String = "flowOperationEnd";
      
      public static const FLOW_OPERATION_COMPLETE:String = "flowOperationComplete";
       
      
      private var _op:FlowOperation;
      
      private var _e:Error;
      
      private var _level:int;
      
      public function FlowOperationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, operation:FlowOperation = null, level:int = 0, error:Error = null)
      {
         this._op = operation;
         this._e = error;
         this._level = level;
         super(type,bubbles,cancelable);
      }
      
      public function get operation() : FlowOperation
      {
         return this._op;
      }
      
      public function set operation(value:FlowOperation) : void
      {
         this._op = value;
      }
      
      public function get error() : Error
      {
         return this._e;
      }
      
      public function set error(value:Error) : void
      {
         this._e = value;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(value:int) : void
      {
         this._level = value;
      }
      
      override public function clone() : Event
      {
         return new FlowOperationEvent(type,bubbles,cancelable,this._op,this._level,this._e);
      }
   }
}
