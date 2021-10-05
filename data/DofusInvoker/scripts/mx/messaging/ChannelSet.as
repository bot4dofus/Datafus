package mx.messaging
{
   import flash.errors.IllegalOperationError;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.messaging.channels.NetConnectionChannel;
   import mx.messaging.channels.PollingChannel;
   import mx.messaging.config.ServerConfig;
   import mx.messaging.errors.NoChannelAvailableError;
   import mx.messaging.events.ChannelEvent;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.events.MessageEvent;
   import mx.messaging.events.MessageFaultEvent;
   import mx.messaging.messages.AcknowledgeMessage;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.ErrorMessage;
   import mx.messaging.messages.IMessage;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.AsyncDispatcher;
   import mx.rpc.AsyncToken;
   import mx.rpc.events.AbstractEvent;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.utils.Base64Encoder;
   
   use namespace mx_internal;
   
   [Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
   [Event(name="fault",type="mx.rpc.events.FaultEvent")]
   [Event(name="result",type="mx.rpc.events.ResultEvent")]
   [Event(name="channelFault",type="mx.messaging.events.ChannelFaultEvent")]
   [Event(name="channelDisconnect",type="mx.messaging.events.ChannelEvent")]
   [Event(name="channelConnect",type="mx.messaging.events.ChannelEvent")]
   public class ChannelSet extends EventDispatcher
   {
       
      
      private var _authAgent:AuthenticationAgent;
      
      private var _connecting:Boolean;
      
      private var _credentials:String;
      
      private var _credentialsCharset:String;
      
      private var _currentChannelIndex:int;
      
      private var _hasRequestedClusterEndpoints:Boolean;
      
      private var _heartbeatTimer:Timer;
      
      private var _hunting:Boolean;
      
      private var _pendingMessages:Dictionary;
      
      private var _pendingSends:Array;
      
      private var _reconnectTimer:Timer = null;
      
      private var _shouldBeConnected:Boolean;
      
      private var _shouldHunt:Boolean;
      
      private var resourceManager:IResourceManager;
      
      private var _authenticated:Boolean;
      
      private var _channels:Array;
      
      private var _channelIds:Array;
      
      private var _currentChannel:Channel;
      
      private var _channelFailoverURIs:Object;
      
      private var _configured:Boolean;
      
      private var _connected:Boolean;
      
      private var _clustered:Boolean;
      
      private var _heartbeatInterval:int = 0;
      
      private var _initialDestinationId:String;
      
      private var _messageAgents:Array;
      
      public function ChannelSet(channelIds:Array = null, clusteredWithURLLoadBalancing:Boolean = false)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._clustered = clusteredWithURLLoadBalancing;
         this._connected = false;
         this._connecting = false;
         this._currentChannelIndex = -1;
         if(channelIds != null)
         {
            this._channelIds = channelIds;
            this._channels = new Array(this._channelIds.length);
            this._configured = true;
         }
         else
         {
            this._channels = [];
            this._configured = false;
         }
         this._hasRequestedClusterEndpoints = false;
         this._hunting = false;
         this._messageAgents = [];
         this._pendingMessages = new Dictionary();
         this._pendingSends = [];
         this._shouldBeConnected = false;
         this._shouldHunt = true;
      }
      
      [Bindable(event="propertyChange")]
      public function get authenticated() : Boolean
      {
         return this._authenticated;
      }
      
      mx_internal function setAuthenticated(value:Boolean, creds:String, notifyAgents:Boolean = true) : void
      {
         var event:PropertyChangeEvent = null;
         var ma:MessageAgent = null;
         var i:int = 0;
         if(this._authenticated != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"authenticated",this._authenticated,value);
            this._authenticated = value;
            if(notifyAgents)
            {
               for(i = 0; i < this._messageAgents.length; i++)
               {
                  ma = MessageAgent(this._messageAgents[i]);
                  ma.setAuthenticated(value,creds);
               }
            }
            if(!value && this._authAgent != null)
            {
               this._authAgent.state = AuthenticationAgent.LOGGED_OUT_STATE;
            }
            dispatchEvent(event);
         }
      }
      
      public function get channels() : Array
      {
         return this._channels;
      }
      
      public function set channels(values:Array) : void
      {
         var message:String = null;
         var m:int = 0;
         var j:int = 0;
         if(this.configured)
         {
            message = this.resourceManager.getString("messaging","cannotAddWhenConfigured");
            throw new IllegalOperationError(message);
         }
         var channelsToRemove:Array = this._channels.slice();
         var n:int = channelsToRemove.length;
         for(var i:int = 0; i < n; i++)
         {
            this.removeChannel(channelsToRemove[i]);
         }
         if(values != null && values.length > 0)
         {
            m = values.length;
            for(j = 0; j < m; j++)
            {
               this.addChannel(values[j]);
            }
         }
      }
      
      public function get channelIds() : Array
      {
         var ids:Array = null;
         var n:int = 0;
         var i:int = 0;
         if(this._channelIds != null)
         {
            return this._channelIds;
         }
         ids = [];
         n = this._channels.length;
         for(i = 0; i < n; i++)
         {
            if(this._channels[i] != null)
            {
               ids.push(this._channels[i].id);
            }
            else
            {
               ids.push(null);
            }
         }
         return ids;
      }
      
      public function get currentChannel() : Channel
      {
         return this._currentChannel;
      }
      
      mx_internal function get channelFailoverURIs() : Object
      {
         return this._channelFailoverURIs;
      }
      
      mx_internal function set channelFailoverURIs(value:Object) : void
      {
         var channel:Channel = null;
         this._channelFailoverURIs = value;
         var n:int = this._channels.length;
         for(var i:int = 0; i < n; i++)
         {
            channel = this._channels[i];
            if(channel == null)
            {
               break;
            }
            if(this._channelFailoverURIs[channel.id] != null)
            {
               channel.failoverURIs = this._channelFailoverURIs[channel.id];
            }
         }
      }
      
      mx_internal function get configured() : Boolean
      {
         return this._configured;
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
            this.setAuthenticated(value && this.currentChannel && this.currentChannel.authenticated,this._credentials,false);
            if(!this.connected)
            {
               this.unscheduleHeartbeat();
            }
            else if(this.heartbeatInterval > 0)
            {
               this.scheduleHeartbeat();
            }
         }
      }
      
      public function get clustered() : Boolean
      {
         return this._clustered;
      }
      
      public function set clustered(value:Boolean) : void
      {
         var ids:Array = null;
         var n:int = 0;
         var i:int = 0;
         var message:String = null;
         if(this._clustered != value)
         {
            if(value)
            {
               ids = this.channelIds;
               n = ids.length;
               for(i = 0; i < n; i++)
               {
                  if(ids[i] == null)
                  {
                     message = this.resourceManager.getString("messaging","cannotSetClusteredWithdNullChannelIds");
                     throw new IllegalOperationError(message);
                  }
               }
            }
            this._clustered = value;
         }
      }
      
      public function get heartbeatInterval() : int
      {
         return this._heartbeatInterval;
      }
      
      public function set heartbeatInterval(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._heartbeatInterval != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"heartbeatInterval",this._heartbeatInterval,value);
            this._heartbeatInterval = value;
            dispatchEvent(event);
            if(this._heartbeatInterval > 0 && this.connected)
            {
               this.scheduleHeartbeat();
            }
         }
      }
      
      public function get initialDestinationId() : String
      {
         return this._initialDestinationId;
      }
      
      public function set initialDestinationId(value:String) : void
      {
         this._initialDestinationId = value;
      }
      
      public function get messageAgents() : Array
      {
         return this._messageAgents;
      }
      
      override public function toString() : String
      {
         var s:String = "[ChannelSet ";
         for(var i:uint = 0; i < this._channels.length; i++)
         {
            if(this._channels[i] != null)
            {
               s += this._channels[i].id + " ";
            }
         }
         return s + "]";
      }
      
      public function addChannel(channel:Channel) : void
      {
         var message:String = null;
         if(channel == null)
         {
            return;
         }
         if(this.configured)
         {
            message = this.resourceManager.getString("messaging","cannotAddWhenConfigured");
            throw new IllegalOperationError(message);
         }
         if(this.clustered && channel.id == null)
         {
            message = this.resourceManager.getString("messaging","cannotAddNullIdChannelWhenClustered");
            throw new IllegalOperationError(message);
         }
         if(this._channels.indexOf(channel) != -1)
         {
            return;
         }
         this._channels.push(channel);
         if(this._credentials)
         {
            channel.setCredentials(this._credentials,null,this._credentialsCharset);
         }
      }
      
      public function removeChannel(channel:Channel) : void
      {
         var message:String = null;
         if(this.configured)
         {
            message = this.resourceManager.getString("messaging","cannotRemoveWhenConfigured");
            throw new IllegalOperationError(message);
         }
         var channelIndex:int = this._channels.indexOf(channel);
         if(channelIndex > -1)
         {
            this._channels.splice(channelIndex,1);
            if(this._currentChannel != null && this._currentChannel == channel)
            {
               if(this.connected)
               {
                  this._shouldHunt = false;
                  this.disconnectChannel();
               }
               this._currentChannel = null;
               this._currentChannelIndex = -1;
            }
         }
      }
      
      public function connect(agent:MessageAgent) : void
      {
         if(agent != null && this._messageAgents.indexOf(agent) == -1)
         {
            this._shouldBeConnected = true;
            this._messageAgents.push(agent);
            agent.internalSetChannelSet(this);
            addEventListener(ChannelEvent.CONNECT,agent.channelConnectHandler);
            addEventListener(ChannelEvent.DISCONNECT,agent.channelDisconnectHandler);
            addEventListener(ChannelFaultEvent.FAULT,agent.channelFaultHandler);
            if(this.connected && !agent.needsConfig)
            {
               agent.channelConnectHandler(ChannelEvent.createEvent(ChannelEvent.CONNECT,this._currentChannel,false,false,this.connected));
            }
         }
      }
      
      public function disconnect(agent:MessageAgent) : void
      {
         var allMessageAgents:Array = null;
         var n:int = 0;
         var i:int = 0;
         var agentIndex:int = 0;
         var n2:int = 0;
         var j:int = 0;
         var ps:PendingSend = null;
         if(agent == null)
         {
            allMessageAgents = this._messageAgents.slice();
            n = allMessageAgents.length;
            for(i = 0; i < n; i++)
            {
               allMessageAgents[i].disconnect();
            }
            if(this._authAgent != null)
            {
               this._authAgent.state = AuthenticationAgent.SHUTDOWN_STATE;
               this._authAgent = null;
            }
         }
         else
         {
            agentIndex = agent != null ? int(this._messageAgents.indexOf(agent)) : -1;
            if(agentIndex != -1)
            {
               this._messageAgents.splice(agentIndex,1);
               removeEventListener(ChannelEvent.CONNECT,agent.channelConnectHandler);
               removeEventListener(ChannelEvent.DISCONNECT,agent.channelDisconnectHandler);
               removeEventListener(ChannelFaultEvent.FAULT,agent.channelFaultHandler);
               if(this.connected || this._connecting)
               {
                  agent.channelDisconnectHandler(ChannelEvent.createEvent(ChannelEvent.DISCONNECT,this._currentChannel,false));
               }
               else
               {
                  n2 = this._pendingSends.length;
                  for(j = 0; j < n2; j++)
                  {
                     ps = PendingSend(this._pendingSends[j]);
                     if(ps.agent == agent)
                     {
                        this._pendingSends.splice(j,1);
                        j--;
                        n2--;
                        delete this._pendingMessages[ps.message];
                     }
                  }
               }
               if(this._messageAgents.length == 0)
               {
                  this._shouldBeConnected = false;
                  this._currentChannelIndex = -1;
                  if(this.connected)
                  {
                     this.disconnectChannel();
                  }
               }
               if(agent.channelSetMode == MessageAgent.AUTO_CONFIGURED_CHANNELSET)
               {
                  agent.internalSetChannelSet(null);
               }
            }
         }
      }
      
      public function disconnectAll() : void
      {
         this.disconnect(null);
      }
      
      public function channelConnectHandler(event:ChannelEvent) : void
      {
         var ps:PendingSend = null;
         var command:CommandMessage = null;
         var ack:AcknowledgeMessage = null;
         this._connecting = false;
         this._connected = true;
         this._currentChannelIndex = -1;
         while(this._pendingSends.length > 0)
         {
            ps = PendingSend(this._pendingSends.shift());
            delete this._pendingMessages[ps.message];
            command = ps.message as CommandMessage;
            if(command != null)
            {
               if(command.operation == CommandMessage.TRIGGER_CONNECT_OPERATION)
               {
                  ack = new AcknowledgeMessage();
                  ack.clientId = ps.agent.clientId;
                  ack.correlationId = command.messageId;
                  ps.agent.acknowledge(ack,command);
                  continue;
               }
               if(!ps.agent.configRequested && ps.agent.needsConfig && command.operation == CommandMessage.CLIENT_PING_OPERATION)
               {
                  command.headers[CommandMessage.NEEDS_CONFIG_HEADER] = true;
                  ps.agent.configRequested = true;
               }
            }
            this.send(ps.agent,ps.message);
         }
         if(this._hunting)
         {
            event.reconnecting = true;
            this._hunting = false;
         }
         dispatchEvent(event);
         var connectedChangeEvent:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this,"connected",false,true);
         dispatchEvent(connectedChangeEvent);
      }
      
      public function channelDisconnectHandler(event:ChannelEvent) : void
      {
         this._connecting = false;
         this.setConnected(false);
         if(this._shouldBeConnected && !event.reconnecting && !event.rejected)
         {
            if(this._shouldHunt && this.hunt())
            {
               event.reconnecting = true;
               dispatchEvent(event);
               if(this._currentChannel is NetConnectionChannel)
               {
                  if(this._reconnectTimer == null)
                  {
                     this._reconnectTimer = new Timer(1,1);
                     this._reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnectChannel);
                     this._reconnectTimer.start();
                  }
               }
               else
               {
                  this.connectChannel();
               }
            }
            else
            {
               dispatchEvent(event);
               this.faultPendingSends(event);
            }
         }
         else
         {
            dispatchEvent(event);
            if(event.rejected)
            {
               this.faultPendingSends(event);
            }
         }
         this._shouldHunt = true;
      }
      
      public function channelFaultHandler(event:ChannelFaultEvent) : void
      {
         if(event.channel.connected)
         {
            dispatchEvent(event);
         }
         else
         {
            this._connecting = false;
            this.setConnected(false);
            if(this._shouldBeConnected && !event.reconnecting && !event.rejected)
            {
               if(this.hunt())
               {
                  event.reconnecting = true;
                  dispatchEvent(event);
                  if(this._currentChannel is NetConnectionChannel)
                  {
                     if(this._reconnectTimer == null)
                     {
                        this._reconnectTimer = new Timer(1,1);
                        this._reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnectChannel);
                        this._reconnectTimer.start();
                     }
                  }
                  else
                  {
                     this.connectChannel();
                  }
               }
               else
               {
                  dispatchEvent(event);
                  this.faultPendingSends(event);
               }
            }
            else
            {
               dispatchEvent(event);
               if(event.rejected)
               {
                  this.faultPendingSends(event);
               }
            }
         }
      }
      
      public function login(username:String, password:String, charset:String = null) : AsyncToken
      {
         var rawCredentials:String = null;
         var encoder:Base64Encoder = null;
         if(this.authenticated)
         {
            throw new IllegalOperationError("ChannelSet is already authenticated.");
         }
         if(this._authAgent != null && this._authAgent.state != AuthenticationAgent.LOGGED_OUT_STATE)
         {
            throw new IllegalOperationError("ChannelSet is in the process of logging in or logging out.");
         }
         if(charset != Base64Encoder.CHARSET_UTF_8)
         {
            charset = null;
         }
         var credentials:String = null;
         if(username != null && password != null)
         {
            rawCredentials = username + ":" + password;
            encoder = new Base64Encoder();
            if(charset == Base64Encoder.CHARSET_UTF_8)
            {
               encoder.encodeUTFBytes(rawCredentials);
            }
            else
            {
               encoder.encode(rawCredentials);
            }
            credentials = encoder.drain();
         }
         var msg:CommandMessage = new CommandMessage();
         msg.operation = CommandMessage.LOGIN_OPERATION;
         msg.body = credentials;
         if(charset != null)
         {
            msg.headers[CommandMessage.CREDENTIALS_CHARSET_HEADER] = charset;
         }
         msg.destination = "auth";
         var token:AsyncToken = new AsyncToken(msg);
         if(this._authAgent == null)
         {
            this._authAgent = new AuthenticationAgent(this);
         }
         this._authAgent.registerToken(token);
         this._authAgent.state = AuthenticationAgent.LOGGING_IN_STATE;
         this.send(this._authAgent,msg);
         return token;
      }
      
      public function logout(agent:MessageAgent = null) : AsyncToken
      {
         var n:int = 0;
         var i:int = 0;
         var msg:CommandMessage = null;
         var token:AsyncToken = null;
         var n2:int = 0;
         var i2:int = 0;
         this._credentials = null;
         if(agent == null)
         {
            if(this._authAgent != null && (this._authAgent.state == AuthenticationAgent.LOGGING_OUT_STATE || this._authAgent.state == AuthenticationAgent.LOGGING_IN_STATE))
            {
               throw new IllegalOperationError("ChannelSet is in the process of logging in or logging out.");
            }
            n = this._messageAgents.length;
            for(i = 0; i < n; )
            {
               this._messageAgents[i].internalSetCredentials(null);
               i++;
            }
            n = this._channels.length;
            for(i = 0; i < n; i++)
            {
               if(this._channels[i] != null)
               {
                  this._channels[i].internalSetCredentials(null);
                  if(this._channels[i] is PollingChannel)
                  {
                     PollingChannel(this._channels[i]).disablePolling();
                  }
               }
            }
            msg = new CommandMessage();
            msg.operation = CommandMessage.LOGOUT_OPERATION;
            msg.destination = "auth";
            token = new AsyncToken(msg);
            if(this._authAgent == null)
            {
               this._authAgent = new AuthenticationAgent(this);
            }
            this._authAgent.registerToken(token);
            this._authAgent.state = AuthenticationAgent.LOGGING_OUT_STATE;
            this.send(this._authAgent,msg);
            return token;
         }
         n2 = this._channels.length;
         for(i2 = 0; i2 < n2; i2++)
         {
            if(this._channels[i2] != null)
            {
               this._channels[i2].logout(agent);
            }
         }
         return null;
      }
      
      public function send(agent:MessageAgent, message:IMessage) : void
      {
         var ack:AcknowledgeMessage = null;
         var msg:CommandMessage = null;
         if(this._currentChannel != null && this._currentChannel.connected)
         {
            if(message is CommandMessage && CommandMessage(message).operation == CommandMessage.TRIGGER_CONNECT_OPERATION && !agent.needsConfig)
            {
               ack = new AcknowledgeMessage();
               ack.clientId = agent.clientId;
               ack.correlationId = message.messageId;
               new AsyncDispatcher(agent.acknowledge,[ack,message],1);
               return;
            }
            if(!this._hasRequestedClusterEndpoints && this.clustered)
            {
               msg = new CommandMessage();
               if(agent is AuthenticationAgent)
               {
                  msg.destination = this.initialDestinationId;
               }
               else
               {
                  msg.destination = agent.destination;
               }
               msg.operation = CommandMessage.CLUSTER_REQUEST_OPERATION;
               this._currentChannel.sendInternalMessage(new ClusterMessageResponder(msg,this));
               this._hasRequestedClusterEndpoints = true;
            }
            this.unscheduleHeartbeat();
            this._currentChannel.send(agent,message);
            this.scheduleHeartbeat();
         }
         else
         {
            if(this._pendingMessages[message] == null)
            {
               this._pendingMessages[message] = true;
               this._pendingSends.push(new PendingSend(agent,message));
            }
            if(!this._connecting)
            {
               if(this._currentChannel == null || this._currentChannelIndex == -1)
               {
                  this.hunt();
               }
               if(this._currentChannel is NetConnectionChannel)
               {
                  if(this._reconnectTimer == null)
                  {
                     this._reconnectTimer = new Timer(1,1);
                     this._reconnectTimer.addEventListener(TimerEvent.TIMER,this.reconnectChannel);
                     this._reconnectTimer.start();
                  }
               }
               else
               {
                  this.connectChannel();
               }
            }
         }
      }
      
      public function setCredentials(credentials:String, agent:MessageAgent, charset:String = null) : void
      {
         this._credentials = credentials;
         var n:int = this._channels.length;
         for(var i:int = 0; i < n; i++)
         {
            if(this._channels[i] != null)
            {
               this._channels[i].setCredentials(this._credentials,agent,charset);
            }
         }
      }
      
      mx_internal function authenticationSuccess(agent:AuthenticationAgent, token:AsyncToken, ackMessage:AcknowledgeMessage) : void
      {
         var n:int = 0;
         var i:int = 0;
         var command:CommandMessage = CommandMessage(token.message);
         var handlingLogin:* = command.operation == CommandMessage.LOGIN_OPERATION;
         var creds:String = !!handlingLogin ? String(command.body) : null;
         var delay:Number = 0;
         if(handlingLogin)
         {
            this._credentials = creds;
            n = this._messageAgents.length;
            for(i = 0; i < n; )
            {
               this._messageAgents[i].internalSetCredentials(creds);
               i++;
            }
            n = this._channels.length;
            for(i = 0; i < n; i++)
            {
               if(this._channels[i] != null)
               {
                  this._channels[i].internalSetCredentials(creds);
               }
            }
            agent.state = AuthenticationAgent.LOGGED_IN_STATE;
            this.currentChannel.setAuthenticated(true);
         }
         else
         {
            agent.state = AuthenticationAgent.SHUTDOWN_STATE;
            this._authAgent = null;
            delay = 250;
            this.disconnect(agent);
            this.currentChannel.setAuthenticated(false);
         }
         var resultEvent:ResultEvent = ResultEvent.createEvent(ackMessage.body,token,ackMessage);
         if(delay > 0)
         {
            new AsyncDispatcher(this.dispatchRPCEvent,[resultEvent],delay);
         }
         else
         {
            this.dispatchRPCEvent(resultEvent);
         }
      }
      
      mx_internal function authenticationFailure(agent:AuthenticationAgent, token:AsyncToken, faultMessage:ErrorMessage) : void
      {
         var messageFaultEvent:MessageFaultEvent = MessageFaultEvent.createEvent(faultMessage);
         var faultEvent:FaultEvent = FaultEvent.createEventFromMessageFault(messageFaultEvent,token);
         agent.state = AuthenticationAgent.SHUTDOWN_STATE;
         this._authAgent = null;
         this.disconnect(agent);
         this.dispatchRPCEvent(faultEvent);
      }
      
      protected function faultPendingSends(event:ChannelEvent) : void
      {
         var ps:PendingSend = null;
         var pendingMsg:IMessage = null;
         var errorMsg:ErrorMessage = null;
         var faultEvent:ChannelFaultEvent = null;
         while(this._pendingSends.length > 0)
         {
            ps = this._pendingSends.shift() as PendingSend;
            pendingMsg = ps.message;
            delete this._pendingMessages[pendingMsg];
            errorMsg = new ErrorMessage();
            errorMsg.correlationId = pendingMsg.messageId;
            errorMsg.headers[ErrorMessage.RETRYABLE_HINT_HEADER] = true;
            errorMsg.faultCode = "Client.Error.MessageSend";
            errorMsg.faultString = this.resourceManager.getString("messaging","sendFailed");
            if(event is ChannelFaultEvent)
            {
               faultEvent = event as ChannelFaultEvent;
               errorMsg.faultDetail = faultEvent.faultCode + " " + faultEvent.faultString + " " + faultEvent.faultDetail;
               if(faultEvent.faultCode == "Channel.Authentication.Error")
               {
                  errorMsg.faultCode = faultEvent.faultCode;
               }
            }
            else
            {
               errorMsg.faultDetail = this.resourceManager.getString("messaging","cannotConnectToDestination");
            }
            errorMsg.rootCause = event;
            ps.agent.fault(errorMsg,pendingMsg);
         }
      }
      
      protected function messageHandler(event:MessageEvent) : void
      {
         dispatchEvent(event);
      }
      
      protected function scheduleHeartbeat() : void
      {
         if(this._heartbeatTimer == null && this.heartbeatInterval > 0)
         {
            this._heartbeatTimer = new Timer(this.heartbeatInterval,1);
            this._heartbeatTimer.addEventListener(TimerEvent.TIMER,this.sendHeartbeatHandler);
            this._heartbeatTimer.start();
         }
      }
      
      protected function sendHeartbeatHandler(event:TimerEvent) : void
      {
         this.unscheduleHeartbeat();
         if(this.currentChannel != null)
         {
            this.sendHeartbeat();
            this.scheduleHeartbeat();
         }
      }
      
      protected function sendHeartbeat() : void
      {
         var pollingChannel:PollingChannel = this.currentChannel as PollingChannel;
         if(pollingChannel != null && pollingChannel._shouldPoll)
         {
            return;
         }
         var heartbeat:CommandMessage = new CommandMessage();
         heartbeat.operation = CommandMessage.CLIENT_PING_OPERATION;
         heartbeat.headers[CommandMessage.HEARTBEAT_HEADER] = true;
         this.currentChannel.sendInternalMessage(new MessageResponder(null,heartbeat));
      }
      
      protected function unscheduleHeartbeat() : void
      {
         if(this._heartbeatTimer != null)
         {
            this._heartbeatTimer.stop();
            this._heartbeatTimer.removeEventListener(TimerEvent.TIMER,this.sendHeartbeatHandler);
            this._heartbeatTimer = null;
         }
      }
      
      private function connectChannel() : void
      {
         this._connecting = true;
         this._currentChannel.connect(this);
         this._currentChannel.addEventListener(MessageEvent.MESSAGE,this.messageHandler);
      }
      
      private function disconnectChannel() : void
      {
         this._connecting = false;
         this._currentChannel.removeEventListener(MessageEvent.MESSAGE,this.messageHandler);
         this._currentChannel.disconnect(this);
      }
      
      private function dispatchRPCEvent(event:AbstractEvent) : void
      {
         event.callTokenResponders();
         dispatchEvent(event);
      }
      
      private function hunt() : Boolean
      {
         var message:String = null;
         if(this._channels.length == 0)
         {
            message = this.resourceManager.getString("messaging","noAvailableChannels");
            throw new NoChannelAvailableError(message);
         }
         if(this._currentChannel != null)
         {
            this.disconnectChannel();
         }
         if(++this._currentChannelIndex >= this._channels.length)
         {
            this._currentChannelIndex = -1;
            return false;
         }
         if(this._currentChannelIndex > 0)
         {
            this._hunting = true;
         }
         if(this.configured)
         {
            if(this._channels[this._currentChannelIndex] != null)
            {
               this._currentChannel = this._channels[this._currentChannelIndex];
            }
            else
            {
               this._currentChannel = ServerConfig.getChannel(this._channelIds[this._currentChannelIndex],this._clustered);
               this._currentChannel.setCredentials(this._credentials);
               this._channels[this._currentChannelIndex] = this._currentChannel;
            }
         }
         else
         {
            this._currentChannel = this._channels[this._currentChannelIndex];
         }
         if(this._channelFailoverURIs != null && this._channelFailoverURIs[this._currentChannel.id] != null)
         {
            this._currentChannel.failoverURIs = this._channelFailoverURIs[this._currentChannel.id];
         }
         return true;
      }
      
      private function reconnectChannel(event:TimerEvent) : void
      {
         this._reconnectTimer.stop();
         this._reconnectTimer.removeEventListener(TimerEvent.TIMER,this.reconnectChannel);
         this._reconnectTimer = null;
         this.connectChannel();
      }
   }
}

import mx.collections.ArrayCollection;
import mx.core.mx_internal;
import mx.messaging.ChannelSet;
import mx.messaging.MessageResponder;
import mx.messaging.messages.IMessage;

use namespace mx_internal;

class ClusterMessageResponder extends MessageResponder
{
    
   
   private var _channelSet:ChannelSet;
   
   function ClusterMessageResponder(message:IMessage, channelSet:ChannelSet)
   {
      super(null,message);
      this._channelSet = channelSet;
   }
   
   override protected function resultHandler(message:IMessage) : void
   {
      var channelFailoverURIs:Object = null;
      var mappings:Array = null;
      var n:int = 0;
      var i:int = 0;
      var channelToEndpointMap:Object = null;
      var channelId:* = null;
      if(message.body != null && (message.body is Array || message.body is ArrayCollection))
      {
         channelFailoverURIs = {};
         mappings = message.body is Array ? message.body as Array : (message.body as ArrayCollection).toArray();
         n = mappings.length;
         for(i = 0; i < n; i++)
         {
            channelToEndpointMap = mappings[i];
            for(channelId in channelToEndpointMap)
            {
               if(channelFailoverURIs[channelId] == null)
               {
                  channelFailoverURIs[channelId] = [];
               }
               channelFailoverURIs[channelId].push(channelToEndpointMap[channelId]);
            }
         }
         this._channelSet.channelFailoverURIs = channelFailoverURIs;
      }
   }
}

import mx.messaging.MessageAgent;
import mx.messaging.messages.IMessage;

class PendingSend
{
    
   
   public var agent:MessageAgent;
   
   public var message:IMessage;
   
   function PendingSend(agent:MessageAgent, message:IMessage)
   {
      super();
      this.agent = agent;
      this.message = message;
   }
}

import mx.core.mx_internal;
import mx.logging.Log;
import mx.messaging.ChannelSet;
import mx.messaging.MessageAgent;
import mx.messaging.events.ChannelEvent;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.IMessage;
import mx.rpc.AsyncToken;

use namespace mx_internal;

class AuthenticationAgent extends MessageAgent
{
   
   public static const LOGGED_OUT_STATE:int = 0;
   
   public static const LOGGING_IN_STATE:int = 1;
   
   public static const LOGGED_IN_STATE:int = 2;
   
   public static const LOGGING_OUT_STATE:int = 3;
   
   public static const SHUTDOWN_STATE:int = 4;
    
   
   private var tokens:Object;
   
   private var _state:int = 0;
   
   function AuthenticationAgent(channelSet:ChannelSet)
   {
      this.tokens = {};
      super();
      _log = Log.getLogger("ChannelSet.AuthenticationAgent");
      _agentType = "authentication agent";
      this.channelSet = channelSet;
   }
   
   public function get state() : int
   {
      return this._state;
   }
   
   public function set state(value:int) : void
   {
      this._state = value;
      if(value == SHUTDOWN_STATE)
      {
         this.tokens = null;
      }
   }
   
   public function registerToken(token:AsyncToken) : void
   {
      this.tokens[token.message.messageId] = token;
   }
   
   override public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage) : void
   {
      var token:AsyncToken = null;
      if(this.state == SHUTDOWN_STATE)
      {
         return;
      }
      var error:Boolean = ackMsg.headers[AcknowledgeMessage.ERROR_HINT_HEADER];
      super.acknowledge(ackMsg,msg);
      if(!error)
      {
         token = this.tokens[msg.messageId];
         delete this.tokens[msg.messageId];
         channelSet.authenticationSuccess(this,token,ackMsg as AcknowledgeMessage);
      }
   }
   
   override public function fault(errMsg:ErrorMessage, msg:IMessage) : void
   {
      var ackMsg:AcknowledgeMessage = null;
      if(this.state == SHUTDOWN_STATE)
      {
         return;
      }
      if(errMsg.rootCause is ChannelEvent && (errMsg.rootCause as ChannelEvent).type == ChannelEvent.DISCONNECT)
      {
         ackMsg = new AcknowledgeMessage();
         ackMsg.clientId = clientId;
         ackMsg.correlationId = msg.messageId;
         this.acknowledge(ackMsg,msg);
         return;
      }
      super.fault(errMsg,msg);
      var token:AsyncToken = this.tokens[msg.messageId];
      delete this.tokens[msg.messageId];
      channelSet.authenticationFailure(this,token,errMsg as ErrorMessage);
   }
}
