package mx.rpc
{
   import mx.core.mx_internal;
   import mx.messaging.Producer;
   import mx.messaging.events.MessageEvent;
   import mx.messaging.events.MessageFaultEvent;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.ErrorMessage;
   import mx.messaging.messages.IMessage;
   
   use namespace mx_internal;
   
   public class AsyncRequest extends Producer
   {
       
      
      private var _pendingRequests:Object;
      
      public function AsyncRequest()
      {
         this._pendingRequests = {};
         super();
      }
      
      override public function acknowledge(ack:AcknowledgeMessage, msg:IMessage) : void
      {
         var act:String = null;
         var resp:IResponder = null;
         var error:Boolean = ack.headers[AcknowledgeMessage.ERROR_HINT_HEADER];
         super.acknowledge(ack,msg);
         if(!error)
         {
            act = ack.correlationId;
            resp = IResponder(this._pendingRequests[act]);
            if(resp)
            {
               delete this._pendingRequests[act];
               resp.result(MessageEvent.createEvent(MessageEvent.RESULT,ack));
            }
         }
      }
      
      override public function fault(errMsg:ErrorMessage, msg:IMessage) : void
      {
         super.fault(errMsg,msg);
         if(_ignoreFault)
         {
            return;
         }
         var act:String = msg.messageId;
         var resp:IResponder = IResponder(this._pendingRequests[act]);
         if(resp)
         {
            delete this._pendingRequests[act];
            resp.fault(MessageFaultEvent.createEvent(errMsg));
         }
      }
      
      override public function hasPendingRequestForMessage(msg:IMessage) : Boolean
      {
         var act:String = msg.messageId;
         return this._pendingRequests[act];
      }
      
      public function invoke(msg:IMessage, responder:IResponder) : void
      {
         this._pendingRequests[msg.messageId] = responder;
         send(msg);
      }
   }
}
