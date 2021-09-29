package mx.messaging
{
   import flash.events.EventDispatcher;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.messaging.channels.PollingChannel;
   import mx.messaging.config.ConfigMap;
   import mx.messaging.config.ServerConfig;
   import mx.messaging.errors.InvalidDestinationError;
   import mx.messaging.events.ChannelEvent;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.events.MessageAckEvent;
   import mx.messaging.events.MessageEvent;
   import mx.messaging.events.MessageFaultEvent;
   import mx.messaging.messages.AbstractMessage;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.ErrorMessage;
   import mx.messaging.messages.IMessage;
   import mx.messaging.messages.MessagePerformanceUtils;
   import mx.netmon.NetworkMonitor;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.Base64Encoder;
   import mx.utils.UIDUtil;
   
   use namespace mx_internal;
   
   [Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
   [Event(name="channelFault",type="mx.messaging.events.ChannelFaultEvent")]
   [Event(name="channelDisconnect",type="mx.messaging.events.ChannelEvent")]
   [Event(name="channelConnect",type="mx.messaging.events.ChannelEvent")]
   [Event(name="fault",type="mx.messaging.events.MessageFaultEvent")]
   [Event(name="acknowledge",type="mx.messaging.events.MessageAckEvent")]
   public class MessageAgent extends EventDispatcher implements IMXMLObject
   {
      
      mx_internal static const AUTO_CONFIGURED_CHANNELSET:int = 0;
      
      mx_internal static const MANUALLY_ASSIGNED_CHANNELSET:int = 1;
       
      
      protected var _agentType:String = "mx.messaging.MessageAgent";
      
      protected var _credentials:String;
      
      protected var _credentialsCharset:String;
      
      protected var _disconnectBarrier:Boolean;
      
      private var _pendingConnectEvent:ChannelEvent;
      
      private var _remoteCredentials:String = "";
      
      private var _remoteCredentialsCharset:String;
      
      private var _sendRemoteCredentials:Boolean;
      
      protected var _log:ILogger;
      
      private var _clientIdWaitQueue:Array;
      
      protected var _ignoreFault:Boolean = false;
      
      private var resourceManager:IResourceManager;
      
      private var _authenticated:Boolean;
      
      private var _channelSet:ChannelSet;
      
      private var _clientId:String;
      
      private var _connected:Boolean = false;
      
      private var _destination:String = "";
      
      private var _id:String;
      
      private var _requestTimeout:int = -1;
      
      private var _channelSetMode:int = 0;
      
      mx_internal var configRequested:Boolean = false;
      
      private var _needsConfig:Boolean;
      
      public function MessageAgent()
      {
         this.resourceManager = ResourceManager.getInstance();
         this._id = UIDUtil.createUID();
         super();
      }
      
      [Bindable(event="propertyChange")]
      public function get authenticated() : Boolean
      {
         return this._authenticated;
      }
      
      mx_internal function setAuthenticated(value:Boolean, creds:String) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._authenticated != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"authenticated",this._authenticated,value);
            this._authenticated = value;
            dispatchEvent(event);
            if(value)
            {
               this.assertCredentials(creds);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get channelSet() : ChannelSet
      {
         return this._channelSet;
      }
      
      public function set channelSet(value:ChannelSet) : void
      {
         this.internalSetChannelSet(value);
         this._channelSetMode = mx_internal::MANUALLY_ASSIGNED_CHANNELSET;
      }
      
      mx_internal function internalSetChannelSet(value:ChannelSet) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._channelSet != value)
         {
            if(this._channelSet != null)
            {
               this._channelSet.disconnect(this);
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"channelSet",this._channelSet,value);
            this._channelSet = value;
            if(this._channelSet != null)
            {
               if(this._credentials)
               {
                  this._channelSet.setCredentials(this._credentials,this,this._credentialsCharset);
               }
               this._channelSet.connect(this);
            }
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get clientId() : String
      {
         return this._clientId;
      }
      
      mx_internal function setClientId(value:String) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._clientId != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"clientId",this._clientId,value);
            this._clientId = value;
            this.flushClientIdWaitQueue();
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get connected() : Boolean
      {
         return this._connected;
      }
      
      protected function setConnected(value:Boolean) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._connected != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"connected",this._connected,value);
            this._connected = value;
            dispatchEvent(event);
            this.setAuthenticated(value && this.channelSet && this.channelSet.authenticated,this._credentials);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get destination() : String
      {
         return this._destination;
      }
      
      public function set destination(value:String) : void
      {
         var event:PropertyChangeEvent = null;
         if(value == null || value.length == 0)
         {
            return;
         }
         if(this._destination != value)
         {
            if(this._channelSetMode == mx_internal::AUTO_CONFIGURED_CHANNELSET && this.channelSet != null)
            {
               this.channelSet.disconnect(this);
               this.channelSet = null;
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"destination",this._destination,value);
            this._destination = value;
            dispatchEvent(event);
            if(Log.isInfo())
            {
               this._log.info("\'{0}\' {2} set destination to \'{1}\'.",this.id,this._destination,this._agentType);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(value:String) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._id != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"id",this._id,value);
            this._id = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get requestTimeout() : int
      {
         return this._requestTimeout;
      }
      
      public function set requestTimeout(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._requestTimeout != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"requestTimeout",this._requestTimeout,value);
            this._requestTimeout = value;
            dispatchEvent(event);
         }
      }
      
      mx_internal function get channelSetMode() : int
      {
         return this._channelSetMode;
      }
      
      mx_internal function get needsConfig() : Boolean
      {
         return this._needsConfig;
      }
      
      mx_internal function set needsConfig(value:Boolean) : void
      {
         var cs:ChannelSet = null;
         if(this._needsConfig == value)
         {
            return;
         }
         this._needsConfig = value;
         if(!this._needsConfig)
         {
         }
      }
      
      public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage) : void
      {
         var mpiutil:MessagePerformanceUtils = null;
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' {2} acknowledge of \'{1}\'.",this.id,msg.messageId,this._agentType);
         }
         if(Log.isDebug() && this.isCurrentChannelNotNull() && this.getCurrentChannel().mpiEnabled)
         {
            try
            {
               mpiutil = new MessagePerformanceUtils(ackMsg);
               this._log.debug(mpiutil.prettyPrint());
            }
            catch(e:Error)
            {
               _log.debug("Could not get message performance information for: " + msg.toString());
            }
         }
         if(this.configRequested)
         {
            this.configRequested = false;
            ServerConfig.updateServerConfigData(ackMsg.body as ConfigMap);
            this.needsConfig = false;
            if(this._pendingConnectEvent)
            {
               this.channelConnectHandler(this._pendingConnectEvent);
            }
            this._pendingConnectEvent = null;
         }
         if(this.clientId == null)
         {
            if(ackMsg.clientId != null)
            {
               this.setClientId(ackMsg.clientId);
            }
            else
            {
               this.flushClientIdWaitQueue();
            }
         }
         dispatchEvent(MessageAckEvent.createEvent(ackMsg,msg));
         this.monitorRpcMessage(ackMsg,msg);
      }
      
      public function disconnect() : void
      {
         if(!this._disconnectBarrier)
         {
            this._clientIdWaitQueue = null;
            if(this.connected)
            {
               this._disconnectBarrier = true;
            }
            if(this._channelSetMode == mx_internal::AUTO_CONFIGURED_CHANNELSET)
            {
               this.internalSetChannelSet(null);
            }
            else if(this._channelSet != null)
            {
               this._channelSet.disconnect(this);
            }
         }
      }
      
      public function fault(errMsg:ErrorMessage, msg:IMessage) : void
      {
         if(Log.isError())
         {
            this._log.error("\'{0}\' {2} fault for \'{1}\'.",this.id,msg.messageId,this._agentType);
         }
         this._ignoreFault = false;
         this.configRequested = false;
         if(errMsg.headers[ErrorMessage.RETRYABLE_HINT_HEADER])
         {
            delete errMsg.headers[ErrorMessage.RETRYABLE_HINT_HEADER];
         }
         if(this.clientId == null)
         {
            if(errMsg.clientId != null)
            {
               this.setClientId(errMsg.clientId);
            }
            else
            {
               this.flushClientIdWaitQueue();
            }
         }
         dispatchEvent(MessageFaultEvent.createEvent(errMsg));
         this.monitorRpcMessage(errMsg,msg);
         this.handleAuthenticationFault(errMsg,msg);
      }
      
      public function channelConnectHandler(event:ChannelEvent) : void
      {
         this._disconnectBarrier = false;
         if(this.needsConfig)
         {
            if(Log.isInfo())
            {
               this._log.info("\'{0}\' {1} waiting for configuration information.",this.id,this._agentType);
            }
            this._pendingConnectEvent = event;
         }
         else
         {
            if(Log.isInfo())
            {
               this._log.info("\'{0}\' {1} connected.",this.id,this._agentType);
            }
            this.setConnected(true);
            dispatchEvent(event);
         }
      }
      
      public function channelDisconnectHandler(event:ChannelEvent) : void
      {
         if(Log.isWarn())
         {
            this._log.warn("\'{0}\' {1} channel disconnected.",this.id,this._agentType);
         }
         this.setConnected(false);
         if(this._remoteCredentials != null)
         {
            this._sendRemoteCredentials = true;
         }
         dispatchEvent(event);
      }
      
      public function channelFaultHandler(event:ChannelFaultEvent) : void
      {
         if(Log.isWarn())
         {
            this._log.warn("\'{0}\' {1} channel faulted with {2} {3}",this.id,this._agentType,event.faultCode,event.faultDetail);
         }
         if(!event.channel.connected)
         {
            this.setConnected(false);
            if(this._remoteCredentials != null)
            {
               this._sendRemoteCredentials = true;
            }
         }
         dispatchEvent(event);
      }
      
      public function initialized(document:Object, id:String) : void
      {
         this.id = id;
      }
      
      public function logout() : void
      {
         this._credentials = null;
         if(this.channelSet)
         {
            this.channelSet.logout(this);
         }
      }
      
      public function setCredentials(username:String, password:String, charset:String = null) : void
      {
         var cred:String = null;
         var encoder:Base64Encoder = null;
         if(username == null && password == null)
         {
            this._credentials = null;
            this._credentialsCharset = null;
         }
         else
         {
            cred = username + ":" + password;
            encoder = new Base64Encoder();
            if(charset == Base64Encoder.CHARSET_UTF_8)
            {
               encoder.encodeUTFBytes(cred);
            }
            else
            {
               encoder.encode(cred);
            }
            this._credentials = encoder.drain();
            this._credentialsCharset = charset;
         }
         if(this.channelSet != null)
         {
            this.channelSet.setCredentials(this._credentials,this,this._credentialsCharset);
         }
      }
      
      public function setRemoteCredentials(username:String, password:String, charset:String = null) : void
      {
         var cred:String = null;
         var encoder:Base64Encoder = null;
         if(username == null && password == null)
         {
            this._remoteCredentials = "";
            this._remoteCredentialsCharset = null;
         }
         else
         {
            cred = username + ":" + password;
            encoder = new Base64Encoder();
            if(charset == Base64Encoder.CHARSET_UTF_8)
            {
               encoder.encodeUTFBytes(cred);
            }
            else
            {
               encoder.encode(cred);
            }
            this._remoteCredentials = encoder.drain();
            this._remoteCredentialsCharset = charset;
         }
         this._sendRemoteCredentials = true;
      }
      
      public function hasPendingRequestForMessage(msg:IMessage) : Boolean
      {
         return false;
      }
      
      mx_internal function internalSetCredentials(credentials:String) : void
      {
         this._credentials = credentials;
      }
      
      protected final function assertCredentials(value:String) : void
      {
         var errMsg:ErrorMessage = null;
         if(this._credentials != null && this._credentials != value)
         {
            errMsg = new ErrorMessage();
            errMsg.faultCode = "Client.Authentication.Error";
            errMsg.faultString = "Credentials specified do not match those used on underlying connection.";
            errMsg.faultDetail = "Channel was authenticated with a different set of credentials than those used for this agent.";
            dispatchEvent(MessageFaultEvent.createEvent(errMsg));
         }
      }
      
      protected final function flushClientIdWaitQueue() : void
      {
         var saveQueue:Array = null;
         if(this._clientIdWaitQueue != null)
         {
            if(this.clientId != null)
            {
               while(this._clientIdWaitQueue.length > 0)
               {
                  this.internalSend(this._clientIdWaitQueue.shift() as IMessage);
               }
            }
            if(this.clientId == null)
            {
               if(this._clientIdWaitQueue.length > 0)
               {
                  saveQueue = this._clientIdWaitQueue;
                  this._clientIdWaitQueue = null;
                  this.internalSend(saveQueue.shift() as IMessage);
                  this._clientIdWaitQueue = saveQueue;
               }
               else
               {
                  this._clientIdWaitQueue = null;
               }
            }
         }
      }
      
      protected function handleAuthenticationFault(errMsg:ErrorMessage, msg:IMessage) : void
      {
         var currentChannel:Channel = null;
         if(errMsg.faultCode == "Client.Authentication" && this.authenticated && this.isCurrentChannelNotNull())
         {
            currentChannel = this.getCurrentChannel();
            currentChannel.setAuthenticated(false);
            if(currentChannel is PollingChannel && (currentChannel as PollingChannel).loginAfterDisconnect)
            {
               this.reAuthorize(msg);
               this._ignoreFault = true;
            }
         }
      }
      
      protected function initChannelSet(message:IMessage) : void
      {
         if(this._channelSet == null)
         {
            this._channelSetMode = mx_internal::AUTO_CONFIGURED_CHANNELSET;
            this.internalSetChannelSet(ServerConfig.getChannelSet(this.destination));
         }
         if(this._channelSet.connected && this.needsConfig && !this.configRequested)
         {
            message.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
            this.configRequested = true;
         }
         this._channelSet.connect(this);
         if(this._credentials != null)
         {
            this.channelSet.setCredentials(this._credentials,this,this._credentialsCharset);
         }
      }
      
      protected function internalSend(message:IMessage, waitForClientId:Boolean = true) : void
      {
         var msg:String = null;
         if(message.clientId == null && waitForClientId && this.clientId == null)
         {
            if(this._clientIdWaitQueue != null)
            {
               this._clientIdWaitQueue.push(message);
               return;
            }
            this._clientIdWaitQueue = [];
         }
         if(message.clientId == null)
         {
            message.clientId = this.clientId;
         }
         if(this.requestTimeout > 0)
         {
            message.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER] = this.requestTimeout;
         }
         if(this._sendRemoteCredentials)
         {
            if(!(message is CommandMessage && CommandMessage(message).operation == CommandMessage.TRIGGER_CONNECT_OPERATION))
            {
               message.headers[AbstractMessage.REMOTE_CREDENTIALS_HEADER] = this._remoteCredentials;
               message.headers[AbstractMessage.REMOTE_CREDENTIALS_CHARSET_HEADER] = this._remoteCredentialsCharset;
               this._sendRemoteCredentials = false;
            }
         }
         if(this.channelSet != null)
         {
            if(!this.connected && this._channelSetMode == mx_internal::MANUALLY_ASSIGNED_CHANNELSET)
            {
               this._channelSet.connect(this);
            }
            if(this.channelSet.connected && this.needsConfig && !this.configRequested)
            {
               message.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
               this.configRequested = true;
            }
            this.channelSet.send(this,message);
            this.monitorRpcMessage(message,message);
         }
         else
         {
            if(!(this.destination != null && this.destination.length > 0))
            {
               msg = this.resourceManager.getString("messaging","destinationNotSet");
               throw new InvalidDestinationError(msg);
            }
            this.initChannelSet(message);
            if(this.channelSet != null)
            {
               this.channelSet.send(this,message);
               this.monitorRpcMessage(message,message);
            }
         }
      }
      
      protected function reAuthorize(msg:IMessage) : void
      {
         if(this.channelSet != null)
         {
            this.channelSet.disconnectAll();
         }
         this.internalSend(msg);
      }
      
      private function getCurrentChannel() : Channel
      {
         return this.channelSet != null ? this.channelSet.currentChannel : null;
      }
      
      private function isCurrentChannelNotNull() : Boolean
      {
         return this.getCurrentChannel() != null;
      }
      
      private function monitorRpcMessage(message:IMessage, actualMessage:IMessage) : void
      {
         if(NetworkMonitor.isMonitoring())
         {
            if(message is ErrorMessage)
            {
               NetworkMonitor.monitorFault(actualMessage,MessageFaultEvent.createEvent(ErrorMessage(message)));
            }
            else if(message is AcknowledgeMessage)
            {
               NetworkMonitor.monitorResult(message,MessageEvent.createEvent(MessageEvent.RESULT,actualMessage));
            }
            else
            {
               NetworkMonitor.monitorInvocation(this.getNetmonId(),message,this);
            }
         }
      }
      
      mx_internal function getNetmonId() : String
      {
         return null;
      }
   }
}
