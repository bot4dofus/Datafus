package mx.messaging
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.logging.Log;
   import mx.messaging.events.ChannelEvent;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.ErrorMessage;
   import mx.messaging.messages.IMessage;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class AbstractProducer extends MessageAgent
   {
       
      
      private var _connectMsg:CommandMessage;
      
      private var _currentAttempt:int;
      
      private var _reconnectTimer:Timer;
      
      protected var _shouldBeConnected:Boolean;
      
      private var resourceManager:IResourceManager;
      
      private var _autoConnect:Boolean = true;
      
      private var _defaultHeaders:Object;
      
      private var _priority:int = -1;
      
      private var _reconnectAttempts:int;
      
      private var _reconnectInterval:int;
      
      public function AbstractProducer()
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
      }
      
      [Bindable(event="propertyChange")]
      public function get autoConnect() : Boolean
      {
         return this._autoConnect;
      }
      
      public function set autoConnect(value:Boolean) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._autoConnect != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"autoConnect",this._autoConnect,value);
            this._autoConnect = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get defaultHeaders() : Object
      {
         return this._defaultHeaders;
      }
      
      public function set defaultHeaders(value:Object) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._defaultHeaders != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"defaultHeaders",this._defaultHeaders,value);
            this._defaultHeaders = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._priority != value)
         {
            value = value < 0 ? 0 : (value > 9 ? 9 : int(value));
            event = PropertyChangeEvent.createUpdateEvent(this,"priority",this._priority,value);
            this._priority = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reconnectAttempts() : int
      {
         return this._reconnectAttempts;
      }
      
      public function set reconnectAttempts(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._reconnectAttempts != value)
         {
            if(value == 0)
            {
               this.stopReconnectTimer();
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"reconnectAttempts",this._reconnectAttempts,value);
            this._reconnectAttempts = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reconnectInterval() : int
      {
         return this._reconnectInterval;
      }
      
      public function set reconnectInterval(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         var message:String = null;
         if(this._reconnectInterval != value)
         {
            if(value < 0)
            {
               message = this.resourceManager.getString("messaging","reconnectIntervalNegative");
               throw new ArgumentError(message);
            }
            if(value == 0)
            {
               this.stopReconnectTimer();
            }
            else if(this._reconnectTimer != null)
            {
               this._reconnectTimer.delay = value;
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"reconnectInterval",this._reconnectInterval,value);
            this._reconnectInterval = value;
            dispatchEvent(event);
         }
      }
      
      override public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage) : void
      {
         if(_disconnectBarrier)
         {
            return;
         }
         super.acknowledge(ackMsg,msg);
         if(msg is CommandMessage && CommandMessage(msg).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)
         {
            this.stopReconnectTimer();
         }
      }
      
      override public function fault(errMsg:ErrorMessage, msg:IMessage) : void
      {
         this.internalFault(errMsg,msg);
      }
      
      override public function channelDisconnectHandler(event:ChannelEvent) : void
      {
         super.channelDisconnectHandler(event);
         if(this._shouldBeConnected && !event.rejected)
         {
            this.startReconnectTimer();
         }
      }
      
      override public function channelFaultHandler(event:ChannelFaultEvent) : void
      {
         super.channelFaultHandler(event);
         if(this._shouldBeConnected && !event.rejected && !event.channel.connected)
         {
            this.startReconnectTimer();
         }
      }
      
      override public function disconnect() : void
      {
         this._shouldBeConnected = false;
         this.stopReconnectTimer();
         super.disconnect();
      }
      
      public function connect() : void
      {
         if(!connected)
         {
            this._shouldBeConnected = true;
            if(this._connectMsg == null)
            {
               this._connectMsg = this.buildConnectMessage();
            }
            internalSend(this._connectMsg,false);
         }
      }
      
      public function send(message:IMessage) : void
      {
         var header:* = null;
         var errMsg2:ErrorMessage = null;
         if(!connected && this.autoConnect)
         {
            this._shouldBeConnected = true;
         }
         if(this.defaultHeaders != null)
         {
            for(header in this.defaultHeaders)
            {
               if(!message.headers.hasOwnProperty(header))
               {
                  message.headers[header] = this.defaultHeaders[header];
               }
            }
         }
         if(!connected && !this.autoConnect)
         {
            this._shouldBeConnected = false;
            errMsg2 = new ErrorMessage();
            errMsg2.faultCode = "Client.Error.MessageSend";
            errMsg2.faultString = this.resourceManager.getString("messaging","producerSendError");
            errMsg2.faultDetail = this.resourceManager.getString("messaging","producerSendErrorDetails");
            errMsg2.correlationId = message.messageId;
            this.internalFault(errMsg2,message,false,true);
         }
         else
         {
            if(Log.isInfo())
            {
               _log.info("\'{0}\' {1} sending message \'{2}\'",id,_agentType,message.messageId);
            }
            internalSend(message);
         }
      }
      
      mx_internal function internalFault(errMsg:ErrorMessage, msg:IMessage, routeToStore:Boolean = true, ignoreDisconnectBarrier:Boolean = false) : void
      {
         var errMsg2:ErrorMessage = null;
         if(_disconnectBarrier && !ignoreDisconnectBarrier)
         {
            return;
         }
         if(msg is CommandMessage && CommandMessage(msg).operation == CommandMessage.TRIGGER_CONNECT_OPERATION)
         {
            if(this._reconnectTimer == null)
            {
               if(this._connectMsg != null && errMsg.correlationId == this._connectMsg.messageId)
               {
                  this._shouldBeConnected = false;
                  errMsg2 = this.buildConnectErrorMessage();
                  errMsg2.rootCause = errMsg.rootCause;
                  super.fault(errMsg2,msg);
               }
               else
               {
                  super.fault(errMsg,msg);
               }
            }
         }
         else
         {
            super.fault(errMsg,msg);
         }
      }
      
      protected function reconnect(event:TimerEvent) : void
      {
         if(this._reconnectAttempts != -1 && this._currentAttempt >= this._reconnectAttempts)
         {
            this.stopReconnectTimer();
            this._shouldBeConnected = false;
            this.fault(this.buildConnectErrorMessage(),this._connectMsg);
            return;
         }
         if(Log.isDebug())
         {
            _log.debug("\'{0}\' {1} trying to reconnect.",id,_agentType);
         }
         this._reconnectTimer.delay = this._reconnectInterval;
         ++this._currentAttempt;
         if(this._connectMsg == null)
         {
            this._connectMsg = this.buildConnectMessage();
         }
         internalSend(this._connectMsg,false);
      }
      
      protected function startReconnectTimer() : void
      {
         if(this._shouldBeConnected && this._reconnectTimer == null)
         {
            if(this._reconnectAttempts != 0 && this._reconnectInterval > 0)
            {
               if(Log.isDebug())
               {
                  _log.debug("\'{0}\' {1} starting reconnect timer.",id,_agentType);
               }
               this._reconnectTimer = new Timer(1);
               this._reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnect);
               this._reconnectTimer.start();
               this._currentAttempt = 0;
            }
         }
      }
      
      protected function stopReconnectTimer() : void
      {
         if(this._reconnectTimer != null)
         {
            if(Log.isDebug())
            {
               _log.debug("\'{0}\' {1} stopping reconnect timer.",id,_agentType);
            }
            this._reconnectTimer.removeEventListener(TimerEvent.TIMER,this.reconnect);
            this._reconnectTimer.reset();
            this._reconnectTimer = null;
         }
      }
      
      private function buildConnectErrorMessage() : ErrorMessage
      {
         var errMsg:ErrorMessage = new ErrorMessage();
         errMsg.faultCode = "Client.Error.Connect";
         errMsg.faultString = this.resourceManager.getString("messaging","producerConnectError");
         errMsg.faultDetail = this.resourceManager.getString("messaging","failedToConnect");
         errMsg.correlationId = this._connectMsg.messageId;
         return errMsg;
      }
      
      private function buildConnectMessage() : CommandMessage
      {
         var msg:CommandMessage = new CommandMessage();
         msg.operation = CommandMessage.TRIGGER_CONNECT_OPERATION;
         msg.clientId = clientId;
         msg.destination = destination;
         return msg;
      }
   }
}
