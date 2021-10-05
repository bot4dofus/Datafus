package mx.rpc
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import mx.core.mx_internal;
   import mx.messaging.ChannelSet;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.events.AbstractEvent;
   
   use namespace mx_internal;
   use namespace flash_proxy;
   
   [Bindable(event="operationsChange")]
   [Event(name="fault",type="mx.rpc.events.FaultEvent")]
   [Event(name="result",type="mx.rpc.events.ResultEvent")]
   [Event(name="invoke",type="mx.rpc.events.InvokeEvent")]
   public dynamic class AbstractService extends Proxy implements IEventDispatcher
   {
       
      
      private var resourceManager:IResourceManager;
      
      private var _managers:Array;
      
      mx_internal var _operations:Object;
      
      protected var _keepLastResult:Boolean = true;
      
      private var nextNameArray:Array;
      
      mx_internal var _availableChannelIds:Array;
      
      mx_internal var asyncRequest:AsyncRequest;
      
      private var eventDispatcher:EventDispatcher;
      
      private var _initialized:Boolean = false;
      
      public function AbstractService(destination:String = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this.eventDispatcher = new EventDispatcher(this);
         this.asyncRequest = new AsyncRequest();
         if(destination)
         {
            this.destination = destination;
            this.asyncRequest.destination = destination;
         }
         this._operations = {};
      }
      
      public function get channelSet() : ChannelSet
      {
         return this.asyncRequest.channelSet;
      }
      
      public function set channelSet(value:ChannelSet) : void
      {
         if(this.channelSet != value)
         {
            this.asyncRequest.channelSet = value;
         }
      }
      
      [Inspectable(category="General")]
      public function get destination() : String
      {
         return this.asyncRequest.destination;
      }
      
      public function set destination(name:String) : void
      {
         this.asyncRequest.destination = name;
      }
      
      public function get managers() : Array
      {
         return this._managers;
      }
      
      public function set managers(mgrs:Array) : void
      {
         var i:int = 0;
         var mgr:Object = null;
         if(this._managers != null)
         {
            for(i = 0; i < this._managers.length; i++)
            {
               mgr = this._managers[i];
               if(mgr.hasOwnProperty("service"))
               {
                  mgr.service = null;
               }
            }
         }
         this._managers = mgrs;
         for(i = 0; i < mgrs.length; i++)
         {
            mgr = this._managers[i];
            if(mgr.hasOwnProperty("service"))
            {
               mgr.service = this;
            }
            if(this._initialized && mgr.hasOwnProperty("initialize"))
            {
               mgr.initialize();
            }
         }
      }
      
      public function get operations() : Object
      {
         return this._operations;
      }
      
      public function set operations(ops:Object) : void
      {
         var op:AbstractOperation = null;
         var i:* = null;
         for(i in ops)
         {
            op = AbstractOperation(ops[i]);
            op.setService(this);
            if(!op.name)
            {
               op.name = i;
            }
            op.asyncRequest = this.asyncRequest;
            op.setKeepLastResultIfNotSet(this._keepLastResult);
         }
         this._operations = ops;
         this.dispatchEvent(new Event("operationsChange"));
      }
      
      [Inspectable(category="General")]
      public function get requestTimeout() : int
      {
         return this.asyncRequest.requestTimeout;
      }
      
      public function set requestTimeout(value:int) : void
      {
         if(this.requestTimeout != value)
         {
            this.asyncRequest.requestTimeout = value;
         }
      }
      
      [Inspectable(defaultValue="true",category="General")]
      public function get keepLastResult() : Boolean
      {
         return this._keepLastResult;
      }
      
      public function set keepLastResult(value:Boolean) : void
      {
         this._keepLastResult = value;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this.eventDispatcher.dispatchEvent(event);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.eventDispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this.eventDispatcher.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return this.eventDispatcher.willTrigger(type);
      }
      
      public function initialize() : void
      {
         var i:int = 0;
         var mgr:Object = null;
         if(!this._initialized && this._managers != null)
         {
            for(i = 0; i < this._managers.length; i++)
            {
               mgr = this._managers[i];
               if(mgr.hasOwnProperty("initialize"))
               {
                  mgr.initialize();
               }
            }
            this._initialized = true;
         }
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         return this.getOperation(this.getLocalName(name));
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void
      {
         var message:String = this.resourceManager.getString("rpc","operationsNotAllowedInService",[this.getLocalName(name)]);
         throw new Error(message);
      }
      
      override flash_proxy function callProperty(name:*, ... args) : *
      {
         return this.getOperation(this.getLocalName(name)).send.apply(null,args);
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         var op:* = null;
         if(index == 0)
         {
            this.nextNameArray = [];
            for(op in this._operations)
            {
               this.nextNameArray.push(op);
            }
         }
         return index < this.nextNameArray.length ? int(index + 1) : 0;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return this.nextNameArray[index - 1];
      }
      
      override flash_proxy function nextValue(index:int) : *
      {
         return this._operations[this.nextNameArray[index - 1]];
      }
      
      mx_internal function getLocalName(name:Object) : String
      {
         if(name is QName)
         {
            return QName(name).localName;
         }
         return String(name);
      }
      
      public function getOperation(name:String) : AbstractOperation
      {
         var o:Object = this._operations[name];
         return o is AbstractOperation ? AbstractOperation(o) : null;
      }
      
      public function disconnect() : void
      {
         this.asyncRequest.disconnect();
      }
      
      public function setCredentials(username:String, password:String, charset:String = null) : void
      {
         this.asyncRequest.setCredentials(username,password,charset);
      }
      
      public function logout() : void
      {
         this.asyncRequest.logout();
      }
      
      public function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null) : void
      {
         this.asyncRequest.setRemoteCredentials(remoteUsername,remotePassword,charset);
      }
      
      public function valueOf() : Object
      {
         return this;
      }
      
      mx_internal function hasTokenResponders(event:Event) : Boolean
      {
         var rpcEvent:AbstractEvent = null;
         if(event is AbstractEvent)
         {
            rpcEvent = event as AbstractEvent;
            if(rpcEvent.token != null && rpcEvent.token.hasResponder())
            {
               return true;
            }
         }
         return false;
      }
   }
}
