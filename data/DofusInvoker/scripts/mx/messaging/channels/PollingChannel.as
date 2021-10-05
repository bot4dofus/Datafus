package mx.messaging.channels
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.core.mx_internal;
   import mx.logging.Log;
   import mx.messaging.Channel;
   import mx.messaging.ChannelSet;
   import mx.messaging.Consumer;
   import mx.messaging.ConsumerMessageDispatcher;
   import mx.messaging.MessageAgent;
   import mx.messaging.MessageResponder;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.messages.CommandMessage;
   import mx.messaging.messages.IMessage;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class PollingChannel extends Channel
   {
      
      protected static const POLLING_ENABLED:String = "polling-enabled";
      
      protected static const POLLING_INTERVAL_MILLIS:String = "polling-interval-millis";
      
      protected static const POLLING_INTERVAL_LEGACY:String = "polling-interval-seconds";
      
      protected static const PIGGYBACKING_ENABLED:String = "piggybacking-enabled";
      
      protected static const LOGIN_AFTER_DISCONNECT:String = "login-after-disconnect";
      
      private static const DEFAULT_POLLING_INTERVAL:int = 3000;
       
      
      mx_internal var _pollingInterval:int;
      
      mx_internal var _shouldPoll:Boolean;
      
      private var _pollingRef:int = -1;
      
      mx_internal var pollOutstanding:Boolean;
      
      mx_internal var _timer:Timer;
      
      private var resourceManager:IResourceManager;
      
      protected var _loginAfterDisconnect:Boolean;
      
      private var _piggybackingEnabled:Boolean;
      
      private var _pollingEnabled:Boolean;
      
      public function PollingChannel(id:String = null, uri:String = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super(id,uri);
         this._pollingEnabled = true;
         this._shouldPoll = false;
         if(this.timerRequired())
         {
            this._pollingInterval = DEFAULT_POLLING_INTERVAL;
            this._timer = new Timer(this._pollingInterval,1);
            this._timer.addEventListener(TimerEvent.TIMER,this.internalPoll);
         }
      }
      
      override protected function setConnected(value:Boolean) : void
      {
         var channelSet:ChannelSet = null;
         var agent:MessageAgent = null;
         if(connected != value)
         {
            if(value)
            {
               for each(channelSet in channelSets)
               {
                  for each(agent in channelSet.messageAgents)
                  {
                     if(agent is Consumer && (agent as Consumer).subscribed)
                     {
                        this.enablePolling();
                     }
                  }
               }
            }
            super.setConnected(value);
         }
      }
      
      mx_internal function get loginAfterDisconnect() : Boolean
      {
         return this._loginAfterDisconnect;
      }
      
      protected function get internalPiggybackingEnabled() : Boolean
      {
         return this._piggybackingEnabled;
      }
      
      protected function set internalPiggybackingEnabled(value:Boolean) : void
      {
         this._piggybackingEnabled = value;
      }
      
      protected function get internalPollingEnabled() : Boolean
      {
         return this._pollingEnabled;
      }
      
      protected function set internalPollingEnabled(value:Boolean) : void
      {
         this._pollingEnabled = value;
         if(!value && (this.timerRunning || !this.timerRunning && this._pollingInterval == 0))
         {
            this.stopPolling();
         }
         else if(value && this._shouldPoll && !this.timerRunning)
         {
            this.startPolling();
         }
      }
      
      mx_internal function get internalPollingInterval() : Number
      {
         return this._timer == null ? Number(0) : Number(this._pollingInterval);
      }
      
      mx_internal function set internalPollingInterval(value:Number) : void
      {
         var message:String = null;
         if(value == 0)
         {
            this._pollingInterval = value;
            if(this._timer != null)
            {
               this._timer.stop();
            }
            if(this._shouldPoll)
            {
               this.startPolling();
            }
         }
         else
         {
            if(value <= 0)
            {
               message = this.resourceManager.getString("messaging","pollingIntervalNonPositive");
               throw new ArgumentError(message);
            }
            if(this._timer != null)
            {
               this._timer.delay = this._pollingInterval = value;
               if(!this.timerRunning && this._shouldPoll)
               {
                  this.startPolling();
               }
            }
         }
      }
      
      override mx_internal function get realtime() : Boolean
      {
         return this._pollingEnabled;
      }
      
      mx_internal function get timerRunning() : Boolean
      {
         return this._timer != null && this._timer.running;
      }
      
      override public function send(agent:MessageAgent, message:IMessage) : void
      {
         var consumerDispatcher:ConsumerMessageDispatcher = null;
         var msg:CommandMessage = null;
         var piggyback:Boolean = false;
         if(!this.pollOutstanding && this._piggybackingEnabled && !(message is CommandMessage))
         {
            if(this._shouldPoll)
            {
               piggyback = true;
            }
            else
            {
               consumerDispatcher = ConsumerMessageDispatcher.getInstance();
               if(consumerDispatcher.isChannelUsedForSubscriptions(this))
               {
                  piggyback = true;
               }
            }
         }
         if(piggyback)
         {
            this.internalPoll();
         }
         super.send(agent,message);
         if(piggyback)
         {
            msg = new CommandMessage();
            msg.operation = CommandMessage.POLL_OPERATION;
            if(Log.isDebug())
            {
               _log.debug("\'{0}\' channel sending poll message\n{1}\n",id,msg.toString());
            }
            try
            {
               internalSend(new PollCommandMessageResponder(null,msg,this,_log));
            }
            catch(e:Error)
            {
               stopPolling();
               throw e;
            }
         }
      }
      
      override protected function connectFailed(event:ChannelFaultEvent) : void
      {
         this.stopPolling();
         super.connectFailed(event);
      }
      
      override protected final function getMessageResponder(agent:MessageAgent, msg:IMessage) : MessageResponder
      {
         if(msg is CommandMessage && (msg as CommandMessage).operation == CommandMessage.POLL_OPERATION)
         {
            return new PollCommandMessageResponder(agent,msg,this,_log);
         }
         return this.getDefaultMessageResponder(agent,msg);
      }
      
      override protected function internalDisconnect(rejected:Boolean = false) : void
      {
         this.stopPolling();
         super.internalDisconnect(rejected);
      }
      
      public function enablePolling() : void
      {
         ++this._pollingRef;
         if(this._pollingRef == 0)
         {
            this.startPolling();
         }
      }
      
      public function disablePolling() : void
      {
         --this._pollingRef;
         if(this._pollingRef < 0)
         {
            this.stopPolling();
         }
      }
      
      public function poll() : void
      {
         this.internalPoll();
      }
      
      mx_internal function pollFailed(rejected:Boolean = false) : void
      {
         this.internalDisconnect(rejected);
      }
      
      mx_internal function stopPolling() : void
      {
         if(Log.isInfo())
         {
            _log.info("\'{0}\' channel polling stopped.",id);
         }
         if(this._timer != null)
         {
            this._timer.stop();
         }
         this._pollingRef = -1;
         this._shouldPoll = false;
         this.pollOutstanding = false;
      }
      
      protected function applyPollingSettings(settings:XML) : void
      {
         if(settings.properties.length() == 0)
         {
            return;
         }
         var props:XML = settings.properties[0];
         if(props[POLLING_ENABLED].length() != 0)
         {
            this.internalPollingEnabled = props[POLLING_ENABLED].toString() == TRUE;
         }
         if(props[POLLING_INTERVAL_MILLIS].length() != 0)
         {
            this.internalPollingInterval = parseInt(props[POLLING_INTERVAL_MILLIS].toString());
         }
         else if(props[POLLING_INTERVAL_LEGACY].length() != 0)
         {
            this.internalPollingInterval = parseInt(props[POLLING_INTERVAL_LEGACY].toString()) * 1000;
         }
         if(props[PIGGYBACKING_ENABLED].length() != 0)
         {
            this.internalPiggybackingEnabled = props[PIGGYBACKING_ENABLED].toString() == TRUE;
         }
         if(props[LOGIN_AFTER_DISCONNECT].length() != 0)
         {
            this._loginAfterDisconnect = props[LOGIN_AFTER_DISCONNECT].toString() == TRUE;
         }
      }
      
      protected function getDefaultMessageResponder(agent:MessageAgent, msg:IMessage) : MessageResponder
      {
         return super.getMessageResponder(agent,msg);
      }
      
      protected function internalPoll(event:Event = null) : void
      {
         var poll:CommandMessage = null;
         if(!this.pollOutstanding)
         {
            if(Log.isInfo())
            {
               _log.info("\'{0}\' channel requesting queued messages.",id);
            }
            if(this.timerRunning)
            {
               this._timer.stop();
            }
            poll = new CommandMessage();
            poll.operation = CommandMessage.POLL_OPERATION;
            if(Log.isDebug())
            {
               _log.debug("\'{0}\' channel sending poll message\n{1}\n",id,poll.toString());
            }
            try
            {
               internalSend(new PollCommandMessageResponder(null,poll,this,_log));
               this.pollOutstanding = true;
            }
            catch(e:Error)
            {
               stopPolling();
               throw e;
            }
         }
         else if(Log.isInfo())
         {
            _log.info("\'{0}\' channel waiting for poll response.",id);
         }
      }
      
      protected function startPolling() : void
      {
         if(this._pollingEnabled)
         {
            if(Log.isInfo())
            {
               _log.info("\'{0}\' channel polling started.",id);
            }
            this._shouldPoll = true;
            this.poll();
         }
      }
      
      protected function timerRequired() : Boolean
      {
         return true;
      }
   }
}

import mx.core.mx_internal;
import mx.events.PropertyChangeEvent;
import mx.logging.ILogger;
import mx.logging.Log;
import mx.messaging.MessageAgent;
import mx.messaging.MessageResponder;
import mx.messaging.channels.PollingChannel;
import mx.messaging.events.ChannelFaultEvent;
import mx.messaging.events.MessageEvent;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.CommandMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.IMessage;
import mx.messaging.messages.MessagePerformanceUtils;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

use namespace mx_internal;

class PollCommandMessageResponder extends MessageResponder
{
    
   
   private var _log:ILogger;
   
   private var resourceManager:IResourceManager;
   
   private var suppressHandlers:Boolean;
   
   function PollCommandMessageResponder(agent:MessageAgent, msg:IMessage, channel:PollingChannel, log:ILogger)
   {
      this.resourceManager = ResourceManager.getInstance();
      super(agent,msg,channel);
      this._log = log;
      channel.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.channelPropertyChangeHandler);
   }
   
   override protected function resultHandler(msg:IMessage) : void
   {
      var messageList:Array = null;
      var message:IMessage = null;
      var mpiutil:MessagePerformanceUtils = null;
      var errMsg:ErrorMessage = null;
      var pollingChannel:PollingChannel = channel as PollingChannel;
      channel.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.channelPropertyChangeHandler);
      if(this.suppressHandlers)
      {
         if(Log.isDebug())
         {
            this._log.debug("\'{0}\' channel ignoring response for poll request preceeding most recent disconnect.\n",channel.id);
         }
         this.doPoll();
         return;
      }
      if(msg is CommandMessage)
      {
         pollingChannel.pollOutstanding = false;
         if(msg.headers[CommandMessage.NO_OP_POLL_HEADER] == true)
         {
            return;
         }
         if(msg.body != null)
         {
            messageList = msg.body as Array;
            for each(message in messageList)
            {
               if(Log.isDebug())
               {
                  this._log.debug("\'{0}\' channel got message\n{1}\n",channel.id,message.toString());
                  if(channel.mpiEnabled)
                  {
                     try
                     {
                        mpiutil = new MessagePerformanceUtils(message);
                        this._log.debug(mpiutil.prettyPrint());
                     }
                     catch(e:Error)
                     {
                        _log.debug("Could not get message performance information for: " + msg.toString());
                     }
                  }
               }
               channel.dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE,message));
            }
         }
      }
      else
      {
         if(!(msg is AcknowledgeMessage))
         {
            errMsg = new ErrorMessage();
            errMsg.faultDetail = this.resourceManager.getString("messaging","receivedNull");
            status(errMsg);
            return;
         }
         pollingChannel.pollOutstanding = false;
      }
      if(msg.headers[CommandMessage.POLL_WAIT_HEADER] != null)
      {
         this.doPoll(msg.headers[CommandMessage.POLL_WAIT_HEADER]);
      }
      else
      {
         this.doPoll();
      }
   }
   
   override protected function statusHandler(msg:IMessage) : void
   {
      channel.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.channelPropertyChangeHandler);
      if(this.suppressHandlers)
      {
         if(Log.isDebug())
         {
            this._log.debug("\'{0}\' channel ignoring response for poll request preceeding most recent disconnect.\n",channel.id);
         }
         return;
      }
      var pollingChannel:PollingChannel = PollingChannel(channel);
      pollingChannel.stopPolling();
      var errMsg:ErrorMessage = msg as ErrorMessage;
      var details:String = errMsg != null ? errMsg.faultDetail : "";
      var faultEvent:ChannelFaultEvent = ChannelFaultEvent.createEvent(pollingChannel,false,"Channel.Polling.Error","error",details);
      faultEvent.rootCause = msg;
      pollingChannel.dispatchEvent(faultEvent);
      if(errMsg != null && errMsg.faultCode == "Server.PollNotSupported")
      {
         pollingChannel.pollFailed(true);
      }
      else
      {
         pollingChannel.pollFailed(false);
      }
   }
   
   private function channelPropertyChangeHandler(event:PropertyChangeEvent) : void
   {
      if(event.property == "connected" && !event.newValue)
      {
         this.suppressHandlers = true;
      }
   }
   
   private function doPoll(adaptivePollWait:int = 0) : void
   {
      var pollingChannel:PollingChannel = PollingChannel(channel);
      if(pollingChannel.connected && pollingChannel._shouldPoll)
      {
         if(adaptivePollWait == 0)
         {
            if(pollingChannel.internalPollingInterval == 0)
            {
               pollingChannel.poll();
            }
            else if(!pollingChannel.timerRunning)
            {
               pollingChannel._timer.delay = pollingChannel._pollingInterval;
               pollingChannel._timer.start();
            }
         }
         else
         {
            pollingChannel._timer.delay = adaptivePollWait;
            pollingChannel._timer.start();
         }
      }
   }
}
