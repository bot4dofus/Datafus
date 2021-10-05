package mx.messaging
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.logging.Log;
   import mx.messaging.channels.PollingChannel;
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
   
   use namespace mx_internal;
   
   [Event(name="message",type="mx.messaging.events.MessageEvent")]
   public class AbstractConsumer extends MessageAgent
   {
       
      
      private var _currentAttempt:int;
      
      private var _resubscribeTimer:Timer;
      
      protected var _shouldBeSubscribed:Boolean;
      
      private var _subscribeMsg:CommandMessage;
      
      private var resourceManager:IResourceManager;
      
      private var _maxFrequency:uint = 0;
      
      private var _resubscribeAttempts:int = 5;
      
      private var _resubscribeInterval:int = 5000;
      
      private var _subscribed:Boolean;
      
      private var _timestamp:Number = -1;
      
      public function AbstractConsumer()
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         _log = Log.getLogger("mx.messaging.Consumer");
         _agentType = "consumer";
      }
      
      override mx_internal function setClientId(value:String) : void
      {
         var resetSubscription:Boolean = false;
         if(super.clientId != value)
         {
            resetSubscription = false;
            if(this.subscribed)
            {
               this.unsubscribe();
               resetSubscription = true;
            }
            super.setClientId(value);
            if(resetSubscription)
            {
               this.subscribe(value);
            }
         }
      }
      
      override public function set destination(value:String) : void
      {
         var resetSubscription:Boolean = false;
         if(destination != value)
         {
            resetSubscription = false;
            if(this.subscribed)
            {
               this.unsubscribe();
               resetSubscription = true;
            }
            super.destination = value;
            if(resetSubscription)
            {
               this.subscribe();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maxFrequency() : uint
      {
         return this._maxFrequency;
      }
      
      public function set maxFrequency(value:uint) : void
      {
         var event:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this,"maxFrequency",this._maxFrequency,value);
         this._maxFrequency = value;
         dispatchEvent(event);
      }
      
      [Bindable(event="propertyChange")]
      public function get resubscribeAttempts() : int
      {
         return this._resubscribeAttempts;
      }
      
      public function set resubscribeAttempts(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._resubscribeAttempts != value)
         {
            if(value == 0)
            {
               this.stopResubscribeTimer();
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"resubscribeAttempts",this._resubscribeAttempts,value);
            this._resubscribeAttempts = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get resubscribeInterval() : int
      {
         return this._resubscribeInterval;
      }
      
      public function set resubscribeInterval(value:int) : void
      {
         var event:PropertyChangeEvent = null;
         var message:String = null;
         if(this._resubscribeInterval != value)
         {
            if(value < 0)
            {
               message = this.resourceManager.getString("messaging","resubscribeIntervalNegative");
               throw new ArgumentError(message);
            }
            if(value == 0)
            {
               this.stopResubscribeTimer();
            }
            else if(this._resubscribeTimer != null)
            {
               this._resubscribeTimer.delay = value;
            }
            event = PropertyChangeEvent.createUpdateEvent(this,"resubscribeInterval",this._resubscribeInterval,value);
            this._resubscribeInterval = value;
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get subscribed() : Boolean
      {
         return this._subscribed;
      }
      
      protected function setSubscribed(value:Boolean) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._subscribed != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"subscribed",this._subscribed,value);
            this._subscribed = value;
            if(this._subscribed)
            {
               ConsumerMessageDispatcher.getInstance().registerSubscription(this);
               if(channelSet != null && channelSet.currentChannel != null && channelSet.currentChannel is PollingChannel)
               {
                  PollingChannel(channelSet.currentChannel).enablePolling();
               }
            }
            else
            {
               ConsumerMessageDispatcher.getInstance().unregisterSubscription(this);
               if(channelSet != null && channelSet.currentChannel != null && channelSet.currentChannel is PollingChannel)
               {
                  PollingChannel(channelSet.currentChannel).disablePolling();
               }
            }
            dispatchEvent(event);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timestamp() : Number
      {
         return this._timestamp;
      }
      
      public function set timestamp(value:Number) : void
      {
         var event:PropertyChangeEvent = null;
         if(this._timestamp != value)
         {
            event = PropertyChangeEvent.createUpdateEvent(this,"timestamp",this._timestamp,value);
            this._timestamp = value;
            dispatchEvent(event);
         }
      }
      
      override public function acknowledge(ackMsg:AcknowledgeMessage, msg:IMessage) : void
      {
         var command:CommandMessage = null;
         var op:int = 0;
         var messageList:Array = null;
         var message:IMessage = null;
         if(_disconnectBarrier)
         {
            return;
         }
         if(!ackMsg.headers[AcknowledgeMessage.ERROR_HINT_HEADER] && msg is CommandMessage)
         {
            command = msg as CommandMessage;
            op = command.operation;
            if(op == CommandMessage.MULTI_SUBSCRIBE_OPERATION)
            {
               if(msg.headers.DSlastUnsub != null)
               {
                  op = CommandMessage.UNSUBSCRIBE_OPERATION;
               }
               else
               {
                  op = CommandMessage.SUBSCRIBE_OPERATION;
               }
            }
            switch(op)
            {
               case CommandMessage.UNSUBSCRIBE_OPERATION:
                  if(Log.isInfo())
                  {
                     _log.info("\'{0}\' {1} acknowledge for unsubscribe.",id,_agentType);
                  }
                  super.setClientId(null);
                  this.setSubscribed(false);
                  ackMsg.clientId = null;
                  super.acknowledge(ackMsg,msg);
                  break;
               case CommandMessage.SUBSCRIBE_OPERATION:
                  this.stopResubscribeTimer();
                  if(ackMsg.timestamp > this._timestamp)
                  {
                     this._timestamp = ackMsg.timestamp - 1;
                  }
                  if(Log.isInfo())
                  {
                     _log.info("\'{0}\' {1} acknowledge for subscribe. Client id \'{2}\' new timestamp {3}",id,_agentType,ackMsg.clientId,this._timestamp);
                  }
                  super.setClientId(ackMsg.clientId);
                  this.setSubscribed(true);
                  super.acknowledge(ackMsg,msg);
                  break;
               case CommandMessage.POLL_OPERATION:
                  if(ackMsg.body != null && ackMsg.body is Array)
                  {
                     messageList = ackMsg.body as Array;
                     for each(message in messageList)
                     {
                        this.messageHandler(MessageEvent.createEvent(MessageEvent.MESSAGE,message));
                     }
                  }
                  super.acknowledge(ackMsg,msg);
            }
         }
         else
         {
            super.acknowledge(ackMsg,msg);
         }
      }
      
      override public function disconnect() : void
      {
         this._shouldBeSubscribed = false;
         this.stopResubscribeTimer();
         this.setSubscribed(false);
         super.disconnect();
      }
      
      override public function fault(errMsg:ErrorMessage, msg:IMessage) : void
      {
         if(_disconnectBarrier)
         {
            return;
         }
         if(errMsg.headers[ErrorMessage.RETRYABLE_HINT_HEADER])
         {
            if(this._resubscribeTimer == null)
            {
               if(this._subscribeMsg != null && errMsg.correlationId == this._subscribeMsg.messageId)
               {
                  this._shouldBeSubscribed = false;
               }
               super.fault(errMsg,msg);
            }
         }
         else
         {
            super.fault(errMsg,msg);
         }
      }
      
      override public function channelConnectHandler(event:ChannelEvent) : void
      {
         super.channelConnectHandler(event);
         if(connected && channelSet != null && channelSet.currentChannel != null && !channelSet.currentChannel.realtime && Log.isWarn())
         {
            _log.warn("\'{0}\' {1} connected over a non-realtime channel \'{2}\'" + " which means channel is not automatically receiving updates via polling or server push.",id,_agentType,channelSet.currentChannel.id);
         }
      }
      
      override public function channelDisconnectHandler(event:ChannelEvent) : void
      {
         this.setSubscribed(false);
         super.channelDisconnectHandler(event);
         if(this._shouldBeSubscribed && !event.rejected)
         {
            this.startResubscribeTimer();
         }
      }
      
      override public function channelFaultHandler(event:ChannelFaultEvent) : void
      {
         if(!event.channel.connected)
         {
            this.setSubscribed(false);
         }
         super.channelFaultHandler(event);
         if(this._shouldBeSubscribed && !event.rejected && !event.channel.connected)
         {
            this.startResubscribeTimer();
         }
      }
      
      public function receive(timestamp:Number = 0) : void
      {
         var msg:CommandMessage = null;
         if(clientId != null)
         {
            msg = new CommandMessage();
            msg.operation = CommandMessage.POLL_OPERATION;
            msg.destination = destination;
            internalSend(msg);
         }
      }
      
      public function subscribe(clientId:String = null) : void
      {
         var resetClientId:Boolean = clientId != null && super.clientId != clientId ? true : false;
         if(this.subscribed && resetClientId)
         {
            this.unsubscribe();
         }
         this.stopResubscribeTimer();
         this._shouldBeSubscribed = true;
         if(resetClientId)
         {
            super.setClientId(clientId);
         }
         if(Log.isInfo())
         {
            _log.info("\'{0}\' {1} subscribe.",id,_agentType);
         }
         this._subscribeMsg = this.buildSubscribeMessage();
         internalSend(this._subscribeMsg);
      }
      
      public function unsubscribe(preserveDurable:Boolean = false) : void
      {
         this._shouldBeSubscribed = false;
         if(this.subscribed)
         {
            if(channelSet != null)
            {
               channelSet.removeEventListener(destination,this.messageHandler);
            }
            if(Log.isInfo())
            {
               _log.info("\'{0}\' {1} unsubscribe.",id,_agentType);
            }
            internalSend(this.buildUnsubscribeMessage(preserveDurable));
         }
         else
         {
            this.stopResubscribeTimer();
         }
      }
      
      mx_internal function messageHandler(event:MessageEvent) : void
      {
         var command:CommandMessage = null;
         var message:IMessage = event.message;
         if(message is CommandMessage)
         {
            command = message as CommandMessage;
            switch(command.operation)
            {
               case CommandMessage.SUBSCRIPTION_INVALIDATE_OPERATION:
                  this.setSubscribed(false);
                  break;
               default:
                  if(Log.isWarn())
                  {
                     _log.warn("\'{0}\' received a CommandMessage \'{1}\' that could not be handled.",id,CommandMessage.getOperationAsString(command.operation));
                  }
            }
            return;
         }
         if(message.timestamp > this._timestamp)
         {
            this._timestamp = message.timestamp;
         }
         if(message is ErrorMessage)
         {
            dispatchEvent(MessageFaultEvent.createEvent(ErrorMessage(message)));
         }
         else
         {
            dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE,message));
         }
      }
      
      protected function buildSubscribeMessage() : CommandMessage
      {
         var msg:CommandMessage = new CommandMessage();
         msg.operation = CommandMessage.SUBSCRIBE_OPERATION;
         msg.clientId = clientId;
         msg.destination = destination;
         if(this.maxFrequency > 0)
         {
            msg.headers[CommandMessage.MAX_FREQUENCY_HEADER] = this.maxFrequency;
         }
         return msg;
      }
      
      protected function buildUnsubscribeMessage(preserveDurable:Boolean) : CommandMessage
      {
         var msg:CommandMessage = new CommandMessage();
         msg.operation = CommandMessage.UNSUBSCRIBE_OPERATION;
         msg.clientId = clientId;
         msg.destination = destination;
         if(preserveDurable)
         {
            msg.headers[CommandMessage.PRESERVE_DURABLE_HEADER] = preserveDurable;
         }
         return msg;
      }
      
      protected function resubscribe(event:TimerEvent) : void
      {
         var errMsg:ErrorMessage = null;
         if(this._resubscribeAttempts != -1 && this._currentAttempt >= this._resubscribeAttempts)
         {
            this.stopResubscribeTimer();
            this._shouldBeSubscribed = false;
            errMsg = new ErrorMessage();
            errMsg.faultCode = "Client.Error.Subscribe";
            errMsg.faultString = this.resourceManager.getString("messaging","consumerSubscribeError");
            errMsg.faultDetail = this.resourceManager.getString("messaging","failedToSubscribe");
            errMsg.correlationId = this._subscribeMsg.messageId;
            this.fault(errMsg,this._subscribeMsg);
            return;
         }
         if(Log.isDebug())
         {
            _log.debug("\'{0}\' {1} trying to resubscribe.",id,_agentType);
         }
         this._resubscribeTimer.delay = this._resubscribeInterval;
         ++this._currentAttempt;
         internalSend(this._subscribeMsg,false);
      }
      
      protected function startResubscribeTimer() : void
      {
         if(this._shouldBeSubscribed && this._resubscribeTimer == null)
         {
            if(this._resubscribeAttempts != 0 && this._resubscribeInterval > 0)
            {
               if(Log.isDebug())
               {
                  _log.debug("\'{0}\' {1} starting resubscribe timer.",id,_agentType);
               }
               this._resubscribeTimer = new Timer(1);
               this._resubscribeTimer.addEventListener(TimerEvent.TIMER,this.resubscribe);
               this._resubscribeTimer.start();
               this._currentAttempt = 0;
            }
         }
      }
      
      protected function stopResubscribeTimer() : void
      {
         if(this._resubscribeTimer != null)
         {
            if(Log.isDebug())
            {
               _log.debug("\'{0}\' {1} stopping resubscribe timer.",id,_agentType);
            }
            this._resubscribeTimer.removeEventListener(TimerEvent.TIMER,this.resubscribe);
            this._resubscribeTimer.reset();
            this._resubscribeTimer = null;
         }
      }
   }
}
