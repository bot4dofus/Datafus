package chat.protocol.common
{
   import chat.protocol.transport.Frame;
   
   public class CorrelatedRequest
   {
       
      
      public var requestedFrame:Frame;
      
      public var callbackOnFailure:Function;
      
      public function CorrelatedRequest(_frame:Frame, callbackOnFailure:Function)
      {
         super();
         this.requestedFrame = _frame;
         this.callbackOnFailure = callbackOnFailure;
      }
   }
}
