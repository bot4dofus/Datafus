package mx.rpc
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   import mx.core.mx_internal;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.messaging.errors.MessagingError;
   import mx.messaging.events.MessageEvent;
   import mx.messaging.events.MessageFaultEvent;
   import mx.messaging.messages.AsyncMessage;
   import mx.messaging.messages.IMessage;
   import mx.netmon.NetworkMonitor;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.events.AbstractEvent;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.InvokeEvent;
   import mx.rpc.events.ResultEvent;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class AbstractInvoker extends EventDispatcher
   {
      
      mx_internal static const BINDING_RESULT:String = "resultForBinding";
       
      
      private var resourceManager:IResourceManager;
      
      private var _keepLastResult:Boolean = true;
      
      private var _keepLastResultSet:Boolean = false;
      
      public var operationManager:Function;
      
      public var resultType:Class;
      
      public var resultElementType:Class;
      
      mx_internal var activeCalls:ActiveCalls;
      
      mx_internal var _responseHeaders:Array;
      
      mx_internal var _result:Object;
      
      mx_internal var _makeObjectsBindable:Boolean;
      
      private var _asyncRequest:AsyncRequest;
      
      private var _log:ILogger;
      
      public function AbstractInvoker()
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._log = Log.getLogger("mx.rpc.AbstractInvoker");
         this.activeCalls = new ActiveCalls();
      }
      
      public function get keepLastResult() : Boolean
      {
         return this._keepLastResult;
      }
      
      public function set keepLastResult(value:Boolean) : void
      {
         this._keepLastResult = value;
         this._keepLastResultSet = true;
      }
      
      mx_internal function setKeepLastResultIfNotSet(value:Boolean) : void
      {
         if(!this._keepLastResultSet)
         {
            this._keepLastResult = value;
         }
      }
      
      [Bindable("resultForBinding")]
      public function get lastResult() : Object
      {
         return this._result;
      }
      
      [Inspectable(defaultValue="true",category="General")]
      public function get makeObjectsBindable() : Boolean
      {
         return this._makeObjectsBindable;
      }
      
      public function set makeObjectsBindable(b:Boolean) : void
      {
         this._makeObjectsBindable = b;
      }
      
      public function cancel(id:String = null) : AsyncToken
      {
         if(id != null)
         {
            return this.activeCalls.removeCall(id);
         }
         return this.activeCalls.cancelLast();
      }
      
      public function clearResult(fireBindingEvent:Boolean = true) : void
      {
         if(fireBindingEvent)
         {
            this.setResult(null);
         }
         else
         {
            this._result = null;
         }
      }
      
      public function setResult(result:Object) : void
      {
         this._result = result;
         dispatchEvent(new Event(mx_internal::BINDING_RESULT));
      }
      
      mx_internal function dispatchRpcEvent(event:AbstractEvent) : void
      {
         event.callTokenResponders();
         if(!event.isDefaultPrevented())
         {
            dispatchEvent(event);
         }
      }
      
      mx_internal function monitorRpcEvent(event:AbstractEvent) : void
      {
         if(NetworkMonitor.isMonitoring())
         {
            if(event is ResultEvent)
            {
               NetworkMonitor.monitorResult(event.message,ResultEvent(event).result);
            }
            else if(event is FaultEvent)
            {
               NetworkMonitor.monitorFault(event.message,FaultEvent(event).fault);
            }
         }
      }
      
      mx_internal function resultHandler(event:MessageEvent) : void
      {
         var resultEvent:ResultEvent = null;
         var token:AsyncToken = this.preHandle(event);
         if(token == null)
         {
            return;
         }
         if(this.processResult(event.message,token))
         {
            dispatchEvent(new Event(mx_internal::BINDING_RESULT));
            resultEvent = ResultEvent.createEvent(this._result,token,event.message);
            resultEvent.headers = this._responseHeaders;
            this.dispatchRpcEvent(resultEvent);
            if(!this._keepLastResult)
            {
               this._result = null;
            }
         }
      }
      
      mx_internal function faultHandler(event:MessageFaultEvent) : void
      {
         var fault:Fault = null;
         var faultEvent:FaultEvent = null;
         var msgEvent:MessageEvent = MessageEvent.createEvent(MessageEvent.MESSAGE,event.message);
         var token:AsyncToken = this.preHandle(msgEvent);
         if(token == null && AsyncMessage(event.message).correlationId != null && AsyncMessage(event.message).correlationId != "" && event.faultCode != "Client.Authentication")
         {
            return;
         }
         if(this.processFault(event.message,token))
         {
            fault = new Fault(event.faultCode,event.faultString,event.faultDetail);
            fault.content = event.message.body;
            fault.rootCause = event.rootCause;
            faultEvent = FaultEvent.createEvent(fault,token,event.message);
            faultEvent.headers = this._responseHeaders;
            this.dispatchRpcEvent(faultEvent);
         }
      }
      
      mx_internal function getNetmonId() : String
      {
         return null;
      }
      
      mx_internal function invoke(message:IMessage, token:AsyncToken = null) : AsyncToken
      {
         var fault:Fault = null;
         var errorText:String = null;
         if(token == null)
         {
            var token:AsyncToken = new AsyncToken(message);
         }
         else
         {
            token.setMessage(message);
         }
         this.activeCalls.addCall(message.messageId,token);
         try
         {
            this.asyncRequest.invoke(message,new Responder(this.resultHandler,this.faultHandler));
            this.dispatchRpcEvent(InvokeEvent.createEvent(token,message));
         }
         catch(e:MessagingError)
         {
            _log.warn(e.toString());
            errorText = resourceManager.getString("rpc","cannotConnectToDestination",[mx_internal::asyncRequest.destination]);
            fault = new Fault("InvokeFailed",e.toString(),errorText);
            new AsyncDispatcher(mx_internal::dispatchRpcEvent,[FaultEvent.createEvent(fault,token,message)],10);
         }
         catch(e2:Error)
         {
            _log.warn(e2.toString());
            fault = new Fault("InvokeFailed",e2.message);
            new AsyncDispatcher(mx_internal::dispatchRpcEvent,[FaultEvent.createEvent(fault,token,message)],10);
         }
         return token;
      }
      
      mx_internal function preHandle(event:MessageEvent) : AsyncToken
      {
         return this.activeCalls.removeCall(AsyncMessage(event.message).correlationId);
      }
      
      mx_internal function processFault(message:IMessage, token:AsyncToken) : Boolean
      {
         return true;
      }
      
      mx_internal function processResult(message:IMessage, token:AsyncToken) : Boolean
      {
         var body:Object = message.body;
         if(this.makeObjectsBindable && body != null && getQualifiedClassName(body) == "Object")
         {
            this._result = new ObjectProxy(body);
         }
         else
         {
            this._result = body;
         }
         return true;
      }
      
      mx_internal function get asyncRequest() : AsyncRequest
      {
         if(this._asyncRequest == null)
         {
            this._asyncRequest = new AsyncRequest();
         }
         return this._asyncRequest;
      }
      
      mx_internal function set asyncRequest(req:AsyncRequest) : void
      {
         this._asyncRequest = req;
      }
   }
}
