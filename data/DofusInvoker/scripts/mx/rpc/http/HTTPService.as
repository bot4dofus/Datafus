package mx.rpc.http
{
   import mx.core.mx_internal;
   import mx.messaging.ChannelSet;
   import mx.messaging.config.LoaderConfig;
   import mx.rpc.AbstractInvoker;
   import mx.rpc.AsyncRequest;
   import mx.rpc.AsyncToken;
   import mx.utils.URLUtil;
   
   use namespace mx_internal;
   
   [Event(name="invoke",type="mx.rpc.events.InvokeEvent")]
   [Event(name="fault",type="mx.rpc.events.FaultEvent")]
   [Event(name="result",type="mx.rpc.events.ResultEvent")]
   public class HTTPService extends AbstractInvoker
   {
      
      public static const RESULT_FORMAT_E4X:String = "e4x";
      
      public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
      
      public static const RESULT_FORMAT_OBJECT:String = "object";
      
      public static const RESULT_FORMAT_ARRAY:String = "array";
      
      public static const RESULT_FORMAT_TEXT:String = "text";
      
      public static const RESULT_FORMAT_XML:String = "xml";
      
      public static const CONTENT_TYPE_XML:String = "application/xml";
      
      public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
      
      public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
      
      public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
      
      public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
      
      public static const ERROR_DECODING:String = "Client.CouldNotDecode";
      
      public static const ERROR_ENCODING:String = "Client.CouldNotEncode";
       
      
      mx_internal var operation:AbstractOperation;
      
      public function HTTPService(rootURL:String = null, destination:String = null)
      {
         super();
         this.operation = new HTTPOperation(this);
         this.operation.makeObjectsBindable = true;
         this.operation._rootURL = rootURL;
         if(destination == null)
         {
            if(URLUtil.isHttpsURL(LoaderConfig.url))
            {
               this.asyncRequest.destination = DEFAULT_DESTINATION_HTTPS;
            }
            else
            {
               this.asyncRequest.destination = DEFAULT_DESTINATION_HTTP;
            }
         }
         else
         {
            this.asyncRequest.destination = destination;
            this.useProxy = true;
         }
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.operation.addEventListener(type,listener,useCapture,priority,useWeakReference);
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.operation.removeEventListener(type,listener,useCapture);
         super.removeEventListener(type,listener,useCapture);
      }
      
      override mx_internal function set asyncRequest(ar:AsyncRequest) : void
      {
         this.operation.asyncRequest = ar;
      }
      
      override mx_internal function get asyncRequest() : AsyncRequest
      {
         return this.operation.asyncRequest;
      }
      
      public function get channelSet() : ChannelSet
      {
         return this.asyncRequest.channelSet;
      }
      
      public function set channelSet(value:ChannelSet) : void
      {
         this.useProxy = true;
         this.asyncRequest.channelSet = value;
      }
      
      [Inspectable(defaultValue="application/x-www-form-urlencoded",enumeration="application/x-www-form-urlencoded,application/xml",category="General")]
      public function get contentType() : String
      {
         return this.operation.contentType;
      }
      
      public function set contentType(c:String) : void
      {
         this.operation.contentType = c;
      }
      
      [Inspectable(defaultValue="multiple",enumeration="multiple,single,last",category="General")]
      public function get concurrency() : String
      {
         return this.operation.concurrency;
      }
      
      public function set concurrency(c:String) : void
      {
         this.operation.concurrency = c;
      }
      
      [Inspectable(defaultValue="DefaultHTTP",category="General")]
      public function get destination() : String
      {
         return this.asyncRequest.destination;
      }
      
      public function set destination(value:String) : void
      {
         this.useProxy = true;
         this.asyncRequest.destination = value;
      }
      
      [Inspectable(defaultValue="true",category="General")]
      override public function get makeObjectsBindable() : Boolean
      {
         return this.operation.makeObjectsBindable;
      }
      
      override public function set makeObjectsBindable(b:Boolean) : void
      {
         this.operation.makeObjectsBindable = b;
      }
      
      [Inspectable(defaultValue="undefined",category="General")]
      public function get headers() : Object
      {
         return this.operation.headers;
      }
      
      public function set headers(r:Object) : void
      {
         this.operation.headers = r;
      }
      
      [Inspectable(defaultValue="GET",enumeration="GET,get,POST,post,HEAD,head,OPTIONS,options,PUT,put,TRACE,trace,DELETE,delete",category="General")]
      public function get method() : String
      {
         return this.operation.method;
      }
      
      public function set method(m:String) : void
      {
         this.operation.method = m;
      }
      
      [Inspectable(defaultValue="undefined",category="General")]
      public function get request() : Object
      {
         return this.operation.request;
      }
      
      public function set request(r:Object) : void
      {
         this.operation.request = r;
      }
      
      [Inspectable(defaultValue="object",enumeration="object,array,xml,flashvars,text,e4x",category="General")]
      public function get resultFormat() : String
      {
         return this.operation.resultFormat;
      }
      
      public function set resultFormat(rf:String) : void
      {
         this.operation.resultFormat = rf;
      }
      
      public function get rootURL() : String
      {
         return this.operation.rootURL;
      }
      
      public function set rootURL(ru:String) : void
      {
         this.operation.rootURL = ru;
      }
      
      [Inspectable(defaultValue="false",category="General")]
      public function get showBusyCursor() : Boolean
      {
         return this.operation.showBusyCursor;
      }
      
      public function set showBusyCursor(sbc:Boolean) : void
      {
         this.operation.showBusyCursor = sbc;
      }
      
      public function get serializationFilter() : SerializationFilter
      {
         return this.operation.serializationFilter;
      }
      
      public function set serializationFilter(s:SerializationFilter) : void
      {
         this.operation.serializationFilter = s;
      }
      
      [Inspectable(defaultValue="undefined",category="General")]
      public function get url() : String
      {
         return this.operation.url;
      }
      
      public function set url(u:String) : void
      {
         this.operation.url = u;
      }
      
      [Inspectable(defaultValue="false",category="General")]
      public function get useProxy() : Boolean
      {
         return this.operation.useProxy;
      }
      
      public function set useProxy(u:Boolean) : void
      {
         this.operation.useProxy = u;
      }
      
      [Inspectable(defaultValue="undefined",category="General")]
      public function get xmlDecode() : Function
      {
         return this.operation.xmlDecode;
      }
      
      public function set xmlDecode(u:Function) : void
      {
         this.operation.xmlDecode = u;
      }
      
      [Inspectable(defaultValue="undefined",category="General")]
      public function get xmlEncode() : Function
      {
         return this.operation.xmlEncode;
      }
      
      public function set xmlEncode(u:Function) : void
      {
         this.operation.xmlEncode = u;
      }
      
      [Bindable("resultForBinding")]
      override public function get lastResult() : Object
      {
         return this.operation.lastResult;
      }
      
      override public function clearResult(fireBindingEvent:Boolean = true) : void
      {
         this.operation.clearResult(fireBindingEvent);
      }
      
      [Inspectable(category="General")]
      public function get requestTimeout() : int
      {
         return this.asyncRequest.requestTimeout;
      }
      
      public function set requestTimeout(value:int) : void
      {
         if(this.asyncRequest.requestTimeout != value)
         {
            this.asyncRequest.requestTimeout = value;
            if(this.operation)
            {
               this.operation.requestTimeout = value;
            }
         }
      }
      
      public function logout() : void
      {
         this.asyncRequest.logout();
      }
      
      public function send(parameters:Object = null) : AsyncToken
      {
         if(parameters == null)
         {
            parameters = this.request;
         }
         return this.operation.sendBody(parameters);
      }
      
      public function disconnect() : void
      {
         this.asyncRequest.disconnect();
      }
      
      public function setCredentials(username:String, password:String, charset:String = null) : void
      {
         this.asyncRequest.setCredentials(username,password,charset);
      }
      
      public function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null) : void
      {
         this.asyncRequest.setRemoteCredentials(remoteUsername,remotePassword,charset);
      }
      
      override public function cancel(id:String = null) : AsyncToken
      {
         return this.operation.cancel(id);
      }
   }
}

import mx.core.mx_internal;
import mx.rpc.events.AbstractEvent;
import mx.rpc.http.AbstractOperation;
import mx.rpc.http.HTTPService;

class HTTPOperation extends AbstractOperation
{
    
   
   private var httpService:HTTPService;
   
   function HTTPOperation(httpService:HTTPService, name:String = null)
   {
      super(null,name);
      this.httpService = httpService;
   }
   
   override mx_internal function dispatchRpcEvent(event:AbstractEvent) : void
   {
      if(hasEventListener(event.type))
      {
         event.callTokenResponders();
         if(!event.isDefaultPrevented())
         {
            dispatchEvent(event);
         }
      }
      else if(this.httpService != null)
      {
         this.httpService.dispatchRpcEvent(event);
      }
      else
      {
         event.callTokenResponders();
      }
   }
}
