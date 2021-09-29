package mx.messaging
{
   import flash.errors.IllegalOperationError;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.collections.ArrayCollection;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.messaging.config.LoaderConfig;
   import mx.messaging.config.ServerConfig;
   import mx.messaging.errors.InvalidChannelError;
   import mx.messaging.errors.InvalidDestinationError;
   import mx.messaging.events.ChannelEvent;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.messages.AbstractMessage;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.IMessage;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.AsyncDispatcher;
   import mx.utils.URLUtil;
   
   use namespace mx_internal;
   
   [Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
   [Event(name="message",type="mx.messaging.events.MessageEvent")]
   [Event(name="channelFault",type="mx.messaging.events.ChannelFaultEvent")]
   [Event(name="channelDisconnect",type="mx.messaging.events.ChannelEvent")]
   [Event(name="channelConnect",type="mx.messaging.events.ChannelEvent")]
   public class Channel extends EventDispatcher implements IMXMLObject
   {
      
      protected static const CLIENT_LOAD_BALANCING:String = "client-load-balancing";
      
      protected static const CONNECT_TIMEOUT_SECONDS:String = "connect-timeout-seconds";
      
      protected static const ENABLE_SMALL_MESSAGES:String = "enable-small-messages";
      
      protected static const FALSE:String = "false";
      
      protected static const RECORD_MESSAGE_TIMES:String = "record-message-times";
      
      protected static const RECORD_MESSAGE_SIZES:String = "record-message-sizes";
      
      protected static const REQUEST_TIMEOUT_SECONDS:String = "request-timeout-seconds";
      
      protected static const SERIALIZATION:String = "serialization";
      
      protected static const TRUE:String = "true";
      
      public static const SMALL_MESSAGES_FEATURE:String = "small_messages";
      
      private static const dep:ArrayCollection = null;
       
      
      mx_internal var authenticating:Boolean;
      
      protected var credentials:String;
      
      public var enableSmallMessages:Boolean = true;
      
      protected var _log:ILogger;
      
      protected var _connecting:Boolean;
      
      private var _connectTimer:Timer;
      
      private var _failoverIndex:int;
      
      private var _isEndpointCalculated:Boolean;
      
      protected var messagingVersion:Number = 1.0;
      
      private var _ownsWaitGuard:Boolean;
      
      private var _previouslyConnected:Boolean;
      
      private var _primaryURI:String;
      
      mx_internal var reliableReconnectDuration:int = -1;
      
      private var _reliableReconnectBeginTimestamp:Number;
      
      private var _reliableReconnectLastTimestamp:Number;
      
      private var _reliableReconnectAttempts:int;
      
      private var resourceManager:IResourceManager;
      
      private var _channelSets:Array;
      
      private var _connected:Boolean = false;
      
      private var _connectTimeout:int = -1;
      
      private var _endpoint:String;
      
      protected var _recordMessageTimes:Boolean = false;
      
      protected var _recordMessageSizes:Boolean = false;
      
      private var _reconnecting:Boolean = false;
      
      private var _failoverURIs:Array;
      
      private var _id:String;
      
      private var _authenticated:Boolean = false;
      
      private var _requestTimeout:int = -1;
      
      private var _shouldBeConnected:Boolean;
      
      private var _uri:String;
      
      private var _smallMessagesSupported:Boolean;
      
      public function Channel(id:String = null, uri:String = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         this._channelSets = [];
         super();
         this._log = Log.getLogger("mx.messaging.Channel");
         this._failoverIndex = -1;
         this.id = id;
         this._primaryURI = uri;
         this.uri = uri;
      }
      
      public function initialized(document:Object, id:String) : void
      {
         this.id = id;
      }
      
      public function get channelSets() : Array
      {
         return this._channelSets;
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
            if(this._connected)
            {
               this._previouslyConnected = true;
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"connected",this._connected,value);
            this._connected = value;
            dispatchEvent(event);
            if(!value)
            {
               this.setAuthenticated(false);
            }
         }
      }
      
      public function get connectTimeout() : int
      {
         return this._connectTimeout;
      }
      
      public function set connectTimeout(value:int) : void
      {
         this._connectTimeout = value;
      }
      
      public function get endpoint() : String
      {
         if(!this._isEndpointCalculated)
         {
            this.calculateEndpoint();
         }
         return this._endpoint;
      }
      
      public function get recordMessageTimes() : Boolean
      {
         return this._recordMessageTimes;
      }
      
      public function get recordMessageSizes() : Boolean
      {
         return this._recordMessageSizes;
      }
      
      [Bindable(event="propertyChange")]
      public function get reconnecting() : Boolean
      {
         return this._reconnecting;
      }
      
      private function setReconnecting(value:Boolean) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._reconnecting != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"reconnecting",this._reconnecting,value);
            this._reconnecting = value;
            dispatchEvent(event);
         }
      }
      
      public function get failoverURIs() : Array
      {
         return this._failoverURIs != null ? this._failoverURIs : [];
      }
      
      public function set failoverURIs(value:Array) : void
      {
         if(value != null)
         {
            this._failoverURIs = value;
            this._failoverIndex = -1;
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(value:String) : void
      {
         if(this._id != value)
         {
            this._id = value;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get authenticated() : Boolean
      {
         return this._authenticated;
      }
      
      mx_internal function setAuthenticated(value:Boolean) : void
      {
         var event:PropertyChangeEvent = null;
         var cs:ChannelSet = null;
         var i:int = 0;
         if(value != this._authenticated)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"authenticated",this._authenticated,value);
            this._authenticated = value;
            for(i = 0; i < this._channelSets.length; i++)
            {
               cs = ChannelSet(this._channelSets[i]);
               cs.setAuthenticated(this.authenticated,this.credentials);
            }
            dispatchEvent(event);
         }
      }
      
      public function get protocol() : String
      {
         throw new IllegalOperationError("Channel subclasses must override " + "the get function for \'protocol\' to return the proper protocol " + "string.");
      }
      
      mx_internal function get realtime() : Boolean
      {
         return false;
      }
      
      public function get requestTimeout() : int
      {
         return this._requestTimeout;
      }
      
      public function set requestTimeout(value:int) : void
      {
         this._requestTimeout = value;
      }
      
      protected function get shouldBeConnected() : Boolean
      {
         return this._shouldBeConnected;
      }
      
      public function get uri() : String
      {
         return this._uri;
      }
      
      public function set uri(value:String) : void
      {
         if(value != null)
         {
            this._uri = value;
            this.calculateEndpoint();
         }
      }
      
      public function get url() : String
      {
         return this.uri;
      }
      
      public function set url(value:String) : void
      {
         this.uri = value;
      }
      
      public function get useSmallMessages() : Boolean
      {
         return this._smallMessagesSupported && this.enableSmallMessages;
      }
      
      public function set useSmallMessages(value:Boolean) : void
      {
         this._smallMessagesSupported = value;
      }
      
      public function applySettings(settings:XML) : void
      {
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' channel settings are:\n{1}",this.id,settings);
         }
         if(settings.properties.length() == 0)
         {
            return;
         }
         var props:XML = settings.properties[0];
         this.applyClientLoadBalancingSettings(props);
         if(props[CONNECT_TIMEOUT_SECONDS].length() != 0)
         {
            this.connectTimeout = props[CONNECT_TIMEOUT_SECONDS].toString();
         }
         if(props[RECORD_MESSAGE_TIMES].length() != 0)
         {
            this._recordMessageTimes = props[RECORD_MESSAGE_TIMES].toString() == TRUE;
         }
         if(props[RECORD_MESSAGE_SIZES].length() != 0)
         {
            this._recordMessageSizes = props[RECORD_MESSAGE_SIZES].toString() == TRUE;
         }
         if(props[REQUEST_TIMEOUT_SECONDS].length() != 0)
         {
            this.requestTimeout = props[REQUEST_TIMEOUT_SECONDS].toString();
         }
         var serializationProps:XMLList = props[SERIALIZATION];
         if(serializationProps.length() != 0 && serializationProps[ENABLE_SMALL_MESSAGES].toString() == FALSE)
         {
            this.enableSmallMessages = false;
         }
      }
      
      protected function applyClientLoadBalancingSettings(props:XML) : void
      {
         var url:XML = null;
         var clientLoadBalancingProps:XMLList = props[CLIENT_LOAD_BALANCING];
         if(clientLoadBalancingProps.length() == 0)
         {
            return;
         }
         var urlCount:int = clientLoadBalancingProps.url.length();
         if(urlCount == 0)
         {
            return;
         }
         var urls:Array = [];
         for each(url in clientLoadBalancingProps.url)
         {
            urls.push(url.toString());
         }
         this.shuffle(urls);
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' channel picked {1} as its main url.",this.id,urls[0]);
         }
         this.url = urls[0];
         var failoverURIs:Array = urls.slice(1);
         if(failoverURIs.length > 0)
         {
            this.failoverURIs = failoverURIs;
         }
      }
      
      public final function connect(channelSet:ChannelSet) : void
      {
         var flexClient:FlexClient = null;
         var exists:Boolean = false;
         var n:int = this._channelSets.length;
         for(var i:int = 0; i < this._channelSets.length; i++)
         {
            if(this._channelSets[i] == channelSet)
            {
               exists = true;
               break;
            }
         }
         this._shouldBeConnected = true;
         if(!exists)
         {
            this._channelSets.push(channelSet);
            addEventListener(ChannelEvent.CONNECT,channelSet.channelConnectHandler);
            addEventListener(ChannelEvent.DISCONNECT,channelSet.channelDisconnectHandler);
            addEventListener(ChannelFaultEvent.FAULT,channelSet.channelFaultHandler);
         }
         if(this.connected)
         {
            channelSet.channelConnectHandler(ChannelEvent.createEvent(ChannelEvent.CONNECT,this,false,false,this.connected));
         }
         else if(!this._connecting)
         {
            this._connecting = true;
            if(this.connectTimeout > 0)
            {
               this._connectTimer = new Timer(this.connectTimeout * 1000,1);
               this._connectTimer.addEventListener(TimerEvent.TIMER,this.connectTimeoutHandler);
               this._connectTimer.start();
            }
            if(FlexClient.getInstance().id == null)
            {
               flexClient = FlexClient.getInstance();
               if(!flexClient.waitForFlexClientId)
               {
                  flexClient.waitForFlexClientId = true;
                  this._ownsWaitGuard = true;
                  this.internalConnect();
               }
               else
               {
                  flexClient.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.flexClientWaitHandler);
               }
            }
            else
            {
               this.internalConnect();
            }
         }
      }
      
      public final function disconnect(channelSet:ChannelSet) : void
      {
         if(this._ownsWaitGuard)
         {
            this._ownsWaitGuard = false;
            FlexClient.getInstance().waitForFlexClientId = false;
         }
         var i:int = channelSet != null ? int(this._channelSets.indexOf(channelSet)) : -1;
         if(i != -1)
         {
            this._channelSets.splice(i,1);
            removeEventListener(ChannelEvent.CONNECT,channelSet.channelConnectHandler,false);
            removeEventListener(ChannelEvent.DISCONNECT,channelSet.channelDisconnectHandler,false);
            removeEventListener(ChannelFaultEvent.FAULT,channelSet.channelFaultHandler,false);
            if(this.connected)
            {
               channelSet.channelDisconnectHandler(ChannelEvent.createEvent(ChannelEvent.DISCONNECT,this,false));
            }
            if(this._channelSets.length == 0)
            {
               this._shouldBeConnected = false;
               if(this.connected)
               {
                  this.internalDisconnect();
               }
            }
         }
      }
      
      public function logout(agent:MessageAgent) : void
      {
         var msg:CommandMessage = null;
         if(this.connected && this.authenticated && this.credentials || this.authenticating && this.credentials)
         {
            msg = new CommandMessage();
            msg.operation = CommandMessage.LOGOUT_OPERATION;
            this.internalSend(new AuthenticationMessageResponder(agent,msg,this,this._log));
            this.authenticating = true;
         }
         this.credentials = null;
      }
      
      public function send(agent:MessageAgent, message:IMessage) : void
      {
         var msg:String = null;
         if(message.destination.length == 0)
         {
            if(agent.destination.length == 0)
            {
               msg = this.resourceManager.getString("messaging","noDestinationSpecified");
               throw new InvalidDestinationError(msg);
            }
            message.destination = agent.destination;
         }
         if(Log.isDebug())
         {
            this._log.debug("\'{0}\' channel sending message:\n{1}",this.id,message.toString());
         }
         message.headers[AbstractMessage.ENDPOINT_HEADER] = this.id;
         var responder:MessageResponder = this.getMessageResponder(agent,message);
         this.initializeRequestTimeout(responder);
         this.internalSend(responder);
      }
      
      public function setCredentials(credentials:String, agent:MessageAgent = null, charset:String = null) : void
      {
         var msg:CommandMessage = null;
         var changedCreds:* = this.credentials !== credentials;
         if(this.authenticating && changedCreds)
         {
            throw new IllegalOperationError("Credentials cannot be set while authenticating or logging out.");
         }
         if(this.authenticated && changedCreds)
         {
            throw new IllegalOperationError("Credentials cannot be set when already authenticated. Logout must be performed before changing credentials.");
         }
         this.credentials = credentials;
         if(this.connected && changedCreds && credentials != null)
         {
            this.authenticating = true;
            msg = new CommandMessage();
            msg.operation = CommandMessage.LOGIN_OPERATION;
            msg.body = credentials;
            if(charset != null)
            {
               msg.headers[CommandMessage.CREDENTIALS_CHARSET_HEADER] = charset;
            }
            this.internalSend(new AuthenticationMessageResponder(agent,msg,this,this._log));
         }
      }
      
      public function get mpiEnabled() : Boolean
      {
         return this._recordMessageSizes || this._recordMessageTimes;
      }
      
      mx_internal function internalSetCredentials(credentials:String) : void
      {
         this.credentials = credentials;
      }
      
      mx_internal function sendInternalMessage(msgResp:MessageResponder) : void
      {
         this.internalSend(msgResp);
      }
      
      protected function connectFailed(event:ChannelFaultEvent) : void
      {
         this.shutdownConnectTimer();
         this.setConnected(false);
         if(Log.isError())
         {
            this._log.error("\'{0}\' channel connect failed.",this.id);
         }
         if(!event.rejected && this.shouldAttemptFailover())
         {
            this._connecting = true;
            this.failover();
         }
         else
         {
            this.connectCleanup();
         }
         if(this.reconnecting)
         {
            event.reconnecting = true;
         }
         dispatchEvent(event);
      }
      
      protected function connectSuccess() : void
      {
         var i:int = 0;
         var messageAgents:Array = null;
         var j:int = 0;
         this.shutdownConnectTimer();
         if(ServerConfig.fetchedConfig(this.endpoint))
         {
            for(i = 0; i < this.channelSets.length; i++)
            {
               messageAgents = ChannelSet(this.channelSets[i]).messageAgents;
               for(j = 0; j < messageAgents.length; j++)
               {
                  messageAgents[j].needsConfig = false;
               }
            }
         }
         this.setConnected(true);
         this._failoverIndex = -1;
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' channel is connected.",this.id);
         }
         dispatchEvent(ChannelEvent.createEvent(ChannelEvent.CONNECT,this,this.reconnecting));
         this.connectCleanup();
      }
      
      protected function connectTimeoutHandler(event:TimerEvent) : void
      {
         var errorText:String = null;
         var faultEvent:ChannelFaultEvent = null;
         this.shutdownConnectTimer();
         if(!this.connected)
         {
            this._shouldBeConnected = false;
            errorText = this.resourceManager.getString("messaging","connectTimedOut");
            faultEvent = ChannelFaultEvent.createEvent(this,false,"Channel.Connect.Failed","error",errorText);
            this.connectFailed(faultEvent);
         }
      }
      
      protected function disconnectSuccess(rejected:Boolean = false) : void
      {
         this.setConnected(false);
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' channel disconnected.",this.id);
         }
         if(!rejected && this.shouldAttemptFailover())
         {
            this._connecting = true;
            this.failover();
         }
         else
         {
            this.connectCleanup();
         }
         dispatchEvent(ChannelEvent.createEvent(ChannelEvent.DISCONNECT,this,this.reconnecting,rejected));
      }
      
      protected function disconnectFailed(event:ChannelFaultEvent) : void
      {
         this._connecting = false;
         this.setConnected(false);
         if(Log.isError())
         {
            this._log.error("\'{0}\' channel disconnect failed.",this.id);
         }
         if(this.reconnecting)
         {
            this.resetToPrimaryURI();
            event.reconnecting = false;
         }
         dispatchEvent(event);
      }
      
      protected function flexClientWaitHandler(event:PropertyChangeEvent) : void
      {
         var flexClient:FlexClient = null;
         if(event.property == "waitForFlexClientId")
         {
            flexClient = event.source as FlexClient;
            if(flexClient.waitForFlexClientId == false)
            {
               flexClient.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.flexClientWaitHandler);
               flexClient.waitForFlexClientId = true;
               this._ownsWaitGuard = true;
               this.internalConnect();
            }
         }
      }
      
      protected function getMessageResponder(agent:MessageAgent, message:IMessage) : MessageResponder
      {
         throw new IllegalOperationError("Channel subclasses must override " + " getMessageResponder().");
      }
      
      protected function internalConnect() : void
      {
      }
      
      protected function internalDisconnect(rejected:Boolean = false) : void
      {
      }
      
      protected function internalSend(messageResponder:MessageResponder) : void
      {
      }
      
      protected function handleServerMessagingVersion(version:Number) : void
      {
         this.useSmallMessages = version >= this.messagingVersion;
      }
      
      protected function setFlexClientIdOnMessage(message:IMessage) : void
      {
         var id:String = FlexClient.getInstance().id;
         message.headers[AbstractMessage.FLEX_CLIENT_ID_HEADER] = id != null ? id : FlexClient.NULL_FLEXCLIENT_ID;
      }
      
      private function calculateEndpoint() : void
      {
         var message:String = null;
         if(this.uri == null)
         {
            message = this.resourceManager.getString("messaging","noURLSpecified");
            throw new InvalidChannelError(message);
         }
         var uriCopy:String = this.uri;
         var proto:String = URLUtil.getProtocol(uriCopy);
         if(proto.length == 0)
         {
            uriCopy = URLUtil.getFullURL(LoaderConfig.url,uriCopy);
         }
         if(URLUtil.hasTokens(uriCopy) && !URLUtil.hasUnresolvableTokens())
         {
            this._isEndpointCalculated = false;
            return;
         }
         uriCopy = URLUtil.replaceTokens(uriCopy);
         proto = URLUtil.getProtocol(uriCopy);
         if(proto.length > 0)
         {
            this._endpoint = URLUtil.replaceProtocol(uriCopy,this.protocol);
         }
         else
         {
            this._endpoint = this.protocol + ":" + uriCopy;
         }
         this._isEndpointCalculated = true;
         if(Log.isInfo())
         {
            this._log.info("\'{0}\' channel endpoint set to {1}",this.id,this._endpoint);
         }
      }
      
      private function initializeRequestTimeout(messageResponder:MessageResponder) : void
      {
         var message:IMessage = messageResponder.message;
         if(message.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER] != null)
         {
            messageResponder.startRequestTimeout(message.headers[AbstractMessage.REQUEST_TIMEOUT_HEADER]);
         }
         else if(this.requestTimeout > 0)
         {
            messageResponder.startRequestTimeout(this.requestTimeout);
         }
      }
      
      private function shouldAttemptFailover() : Boolean
      {
         return this._shouldBeConnected && (this._previouslyConnected || this.reliableReconnectDuration != -1 || this._failoverURIs != null && this._failoverURIs.length > 0);
      }
      
      private function failover() : void
      {
         var acs:Class = null;
         var duration:int = 0;
         var channelSet:ChannelSet = null;
         var d:int = 0;
         var remaining:Number = NaN;
         var delay:int = 0;
         if(this._previouslyConnected)
         {
            this._previouslyConnected = false;
            acs = null;
            try
            {
               acs = getDefinitionByName("mx.messaging.AdvancedChannelSet") as Class;
            }
            catch(ignore:Error)
            {
            }
            duration = -1;
            if(acs != null)
            {
               for each(channelSet in this.channelSets)
               {
                  if(channelSet is acs)
                  {
                     d = (channelSet as acs)["reliableReconnectDuration"];
                     if(d > duration)
                     {
                        duration = d;
                     }
                  }
               }
            }
            if(duration != -1)
            {
               this.setReconnecting(true);
               this.reliableReconnectDuration = duration;
               this._reliableReconnectBeginTimestamp = new Date().valueOf();
               new AsyncDispatcher(this.reconnect,null,1);
               return;
            }
         }
         if(this.reliableReconnectDuration != -1)
         {
            this._reliableReconnectLastTimestamp = new Date().valueOf();
            remaining = this.reliableReconnectDuration - (this._reliableReconnectLastTimestamp - this._reliableReconnectBeginTimestamp);
            if(remaining > 0)
            {
               delay = 1000;
               delay << ++this._reliableReconnectAttempts;
               if(delay < remaining)
               {
                  new AsyncDispatcher(this.reconnect,null,delay);
                  return;
               }
            }
            this.reliableReconnectCleanup();
         }
         ++this._failoverIndex;
         if(this._failoverIndex + 1 <= this.failoverURIs.length)
         {
            this.setReconnecting(true);
            this.uri = this.failoverURIs[this._failoverIndex];
            if(Log.isInfo())
            {
               this._log.info("\'{0}\' channel attempting to connect to {1}.",this.id,this.endpoint);
            }
            new AsyncDispatcher(this.reconnect,null,1);
         }
         else
         {
            if(Log.isInfo())
            {
               this._log.info("\'{0}\' channel has exhausted failover options and has reset to its primary endpoint.",this.id);
            }
            this.resetToPrimaryURI();
         }
      }
      
      private function connectCleanup() : void
      {
         if(this._ownsWaitGuard)
         {
            this._ownsWaitGuard = false;
            FlexClient.getInstance().waitForFlexClientId = false;
         }
         this._connecting = false;
         this.setReconnecting(false);
         this.reliableReconnectCleanup();
      }
      
      private function reconnect(event:TimerEvent = null) : void
      {
         this.internalConnect();
      }
      
      private function reliableReconnectCleanup() : void
      {
         this.reliableReconnectDuration = -1;
         this._reliableReconnectBeginTimestamp = 0;
         this._reliableReconnectLastTimestamp = 0;
         this._reliableReconnectAttempts = 0;
      }
      
      private function resetToPrimaryURI() : void
      {
         this._connecting = false;
         this.setReconnecting(false);
         this.uri = this._primaryURI;
         this._failoverIndex = -1;
      }
      
      private function shuffle(elements:Array) : void
      {
         var index:int = 0;
         var temp:Object = null;
         var length:int = elements.length;
         for(var i:int = 0; i < length; i++)
         {
            index = Math.floor(Math.random() * length);
            if(index != i)
            {
               temp = elements[i];
               elements[i] = elements[index];
               elements[index] = temp;
            }
         }
      }
      
      private function shutdownConnectTimer() : void
      {
         if(this._connectTimer != null)
         {
            this._connectTimer.stop();
            this._connectTimer.removeEventListener(TimerEvent.TIMER,this.connectTimeoutHandler);
            this._connectTimer = null;
         }
      }
   }
}

import mx.core.mx_internal;
import mx.logging.ILogger;
import mx.logging.Log;
import mx.messaging.Channel;
import mx.messaging.MessageAgent;
import mx.messaging.MessageResponder;
import mx.messaging.events.ChannelFaultEvent;
import mx.messaging.messages.CommandMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.IMessage;

use namespace mx_internal;

class AuthenticationMessageResponder extends MessageResponder
{
    
   
   private var _log:ILogger;
   
   function AuthenticationMessageResponder(agent:MessageAgent, message:IMessage, channel:Channel, log:ILogger)
   {
      super(agent,message,channel);
      this._log = log;
   }
   
   override protected function resultHandler(msg:IMessage) : void
   {
      var cmd:CommandMessage = message as CommandMessage;
      channel.authenticating = false;
      if(cmd.operation == CommandMessage.LOGIN_OPERATION)
      {
         if(Log.isDebug())
         {
            this._log.debug("Login successful");
         }
         channel.setAuthenticated(true);
      }
      else
      {
         if(Log.isDebug())
         {
            this._log.debug("Logout successful");
         }
         channel.setAuthenticated(false);
      }
   }
   
   override protected function statusHandler(msg:IMessage) : void
   {
      var errMsg:ErrorMessage = null;
      var channelFault:ChannelFaultEvent = null;
      var cmd:CommandMessage = CommandMessage(message);
      if(Log.isDebug())
      {
         this._log.debug("{1} failure: {0}",msg.toString(),cmd.operation == CommandMessage.LOGIN_OPERATION ? "Login" : "Logout");
      }
      channel.authenticating = false;
      channel.setAuthenticated(false);
      if(agent != null && agent.hasPendingRequestForMessage(message))
      {
         agent.fault(ErrorMessage(msg),message);
      }
      else
      {
         errMsg = ErrorMessage(msg);
         channelFault = ChannelFaultEvent.createEvent(channel,false,"Channel.Authentication.Error","warn",errMsg.faultString);
         channelFault.rootCause = errMsg;
         channel.dispatchEvent(channelFault);
      }
   }
}
