package mx.rpc
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.messaging.messages.IMessage;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   
   [Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
   public dynamic class AsyncToken extends EventDispatcher
   {
       
      
      private var _message:IMessage;
      
      private var _responders:Array;
      
      private var _result:Object;
      
      public function AsyncToken(message:IMessage = null)
      {
         super();
         this._message = message;
      }
      
      public function get message() : IMessage
      {
         return this._message;
      }
      
      mx_internal function setMessage(message:IMessage) : void
      {
         this._message = message;
      }
      
      public function get responders() : Array
      {
         return this._responders;
      }
      
      [Bindable(event="propertyChange")]
      public function get result() : Object
      {
         return this._result;
      }
      
      public function addResponder(responder:IResponder) : void
      {
         if(this._responders == null)
         {
            this._responders = [];
         }
         this._responders.push(responder);
      }
      
      public function hasResponder() : Boolean
      {
         return this._responders != null && this._responders.length > 0;
      }
      
      mx_internal function applyFault(event:FaultEvent) : void
      {
         var i:uint = 0;
         var responder:IResponder = null;
         if(this._responders != null)
         {
            for(i = 0; i < this._responders.length; i++)
            {
               responder = this._responders[i];
               if(responder != null)
               {
                  responder.fault(event);
               }
            }
         }
      }
      
      mx_internal function applyResult(event:ResultEvent) : void
      {
         var i:uint = 0;
         var responder:IResponder = null;
         this.setResult(event.result);
         if(this._responders != null)
         {
            for(i = 0; i < this._responders.length; i++)
            {
               responder = this._responders[i];
               if(responder != null)
               {
                  responder.result(event);
               }
            }
         }
      }
      
      mx_internal function setResult(newResult:Object) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._result !== newResult)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"result",this._result,newResult);
            this._result = newResult;
            dispatchEvent(event);
         }
      }
   }
}
