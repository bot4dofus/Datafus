package mx.messaging.channels
{
   import flash.events.AsyncErrorEvent;
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.NetConnection;
   import flash.net.ObjectEncoding;
   import mx.core.mx_internal;
   import mx.logging.Log;
   import mx.messaging.MessageAgent;
   import mx.messaging.MessageResponder;
   import mx.messaging.config.LoaderConfig;
   import mx.messaging.events.ChannelFaultEvent;
   import mx.messaging.events.MessageEvent;
   import mx.messaging.messages.IMessage;
   import mx.messaging.messages.ISmallMessage;
   import mx.messaging.messages.MessagePerformanceInfo;
   import mx.messaging.messages.MessagePerformanceUtils;
   import mx.netmon.NetworkMonitor;
   
   use namespace mx_internal;
   
   public class NetConnectionChannel extends PollingChannel
   {
       
      
      mx_internal var _appendToURL:String;
      
      protected var _nc:NetConnection;
      
      public function NetConnectionChannel(id:String = null, uri:String = null)
      {
         super(id,uri);
         this._nc = new NetConnection();
         this._nc.objectEncoding = ObjectEncoding.AMF3;
         this._nc.client = this;
      }
      
      public function get netConnection() : NetConnection
      {
         return this._nc;
      }
      
      override public function get useSmallMessages() : Boolean
      {
         return super.useSmallMessages && this._nc != null && this._nc.objectEncoding >= ObjectEncoding.AMF3;
      }
      
      override protected function connectTimeoutHandler(event:TimerEvent) : void
      {
         this.shutdownNetConnection();
         super.connectTimeoutHandler(event);
      }
      
      override protected function getDefaultMessageResponder(agent:MessageAgent, msg:IMessage) : MessageResponder
      {
         return new NetConnectionMessageResponder(agent,msg,this);
      }
      
      override protected function internalDisconnect(rejected:Boolean = false) : void
      {
         super.internalDisconnect(rejected);
         this.shutdownNetConnection();
         disconnectSuccess(rejected);
      }
      
      override protected function internalConnect() : void
      {
         var url:String = null;
         var i:int = 0;
         var temp:String = null;
         var j:int = 0;
         var redirectedUrl:String = null;
         super.internalConnect();
         url = endpoint;
         if(this._appendToURL != null)
         {
            i = url.indexOf("wsrp-url=");
            if(i != -1)
            {
               temp = url.substr(i + 9,url.length);
               j = temp.indexOf("&");
               if(j != -1)
               {
                  temp = temp.substr(0,j);
               }
               url = url.replace(temp,temp + this._appendToURL);
            }
            else
            {
               url += this._appendToURL;
            }
         }
         if(this._nc.uri != null && this._nc.uri.length > 0 && this._nc.connected)
         {
            this._nc.removeEventListener(NetStatusEvent.NET_STATUS,this.statusHandler);
            this._nc.close();
         }
         if("httpIdleTimeout" in this._nc && requestTimeout > 0)
         {
            this._nc["httpIdleTimeout"] = requestTimeout * 1000;
         }
         this._nc.addEventListener(NetStatusEvent.NET_STATUS,this.statusHandler);
         this._nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this._nc.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.asyncErrorHandler);
         try
         {
            if(NetworkMonitor.isMonitoring())
            {
               redirectedUrl = NetworkMonitor.adjustNetConnectionURL(LoaderConfig.url,url);
               if(redirectedUrl != null)
               {
                  url = redirectedUrl;
               }
            }
            this._nc.connect(url);
         }
         catch(e:Error)
         {
            e.message += "  url: \'" + url + "\'";
            throw e;
         }
      }
      
      override protected function internalSend(msgResp:MessageResponder) : void
      {
         var mpii:MessagePerformanceInfo = null;
         var smallMessage:IMessage = null;
         setFlexClientIdOnMessage(msgResp.message);
         if(mpiEnabled)
         {
            mpii = new MessagePerformanceInfo();
            if(recordMessageTimes)
            {
               mpii.sendTime = new Date().getTime();
            }
            msgResp.message.headers[MessagePerformanceUtils.MPI_HEADER_IN] = mpii;
         }
         var message:IMessage = msgResp.message;
         if(this.useSmallMessages && message is ISmallMessage)
         {
            smallMessage = ISmallMessage(message).getSmallMessage();
            if(smallMessage != null)
            {
               message = smallMessage;
            }
         }
         this._nc.call(null,msgResp,message);
      }
      
      public function AppendToGatewayUrl(value:String) : void
      {
         if(value != null && value != "" && value != this._appendToURL)
         {
            if(Log.isDebug())
            {
               _log.debug("\'{0}\' channel will disconnect and reconnect with with its session identifier \'{1}\' appended to its endpoint url \n",id,value);
            }
            this._appendToURL = value;
         }
      }
      
      public function receive(msg:IMessage, ... rest) : void
      {
         var mpiutil:MessagePerformanceUtils = null;
         if(Log.isDebug())
         {
            _log.debug("\'{0}\' channel got message\n{1}\n",id,msg.toString());
            if(this.mpiEnabled)
            {
               try
               {
                  mpiutil = new MessagePerformanceUtils(msg);
                  _log.debug(mpiutil.prettyPrint());
               }
               catch(e:Error)
               {
                  _log.debug("Could not get message performance information for: " + msg.toString());
               }
            }
         }
         dispatchEvent(MessageEvent.createEvent(MessageEvent.MESSAGE,msg));
      }
      
      protected function shutdownNetConnection() : void
      {
         this._nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this._nc.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._nc.removeEventListener(NetStatusEvent.NET_STATUS,this.statusHandler);
         this._nc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.asyncErrorHandler);
         this._nc.close();
      }
      
      protected function statusHandler(event:NetStatusEvent) : void
      {
      }
      
      protected function securityErrorHandler(event:SecurityErrorEvent) : void
      {
         this.defaultErrorHandler("Channel.Security.Error",event);
      }
      
      protected function ioErrorHandler(event:IOErrorEvent) : void
      {
         this.defaultErrorHandler("Channel.IO.Error",event);
      }
      
      protected function asyncErrorHandler(event:AsyncErrorEvent) : void
      {
         this.defaultErrorHandler("Channel.Async.Error",event);
      }
      
      private function defaultErrorHandler(code:String, event:ErrorEvent) : void
      {
         var faultEvent:ChannelFaultEvent = ChannelFaultEvent.createEvent(this,false,code,"error",event.text + " url: \'" + endpoint + "\'");
         faultEvent.rootCause = event;
         if(_connecting)
         {
            connectFailed(faultEvent);
         }
         else
         {
            dispatchEvent(faultEvent);
         }
      }
   }
}

import mx.core.mx_internal;
import mx.messaging.MessageAgent;
import mx.messaging.MessageResponder;
import mx.messaging.channels.NetConnectionChannel;
import mx.messaging.events.ChannelEvent;
import mx.messaging.events.ChannelFaultEvent;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.AsyncMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.IMessage;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

use namespace mx_internal;

class NetConnectionMessageResponder extends MessageResponder
{
    
   
   private var handled:Boolean;
   
   private var resourceManager:IResourceManager;
   
   function NetConnectionMessageResponder(agent:MessageAgent, msg:IMessage, channel:NetConnectionChannel)
   {
      this.resourceManager = ResourceManager.getInstance();
      super(agent,msg,channel);
      channel.addEventListener(ChannelEvent.DISCONNECT,this.channelDisconnectHandler);
      channel.addEventListener(ChannelFaultEvent.FAULT,this.channelFaultHandler);
   }
   
   override protected function resultHandler(msg:IMessage) : void
   {
      var errorMsg:ErrorMessage = null;
      if(this.handled)
      {
         return;
      }
      this.disconnect();
      if(msg is AsyncMessage)
      {
         if(AsyncMessage(msg).correlationId == message.messageId)
         {
            agent.acknowledge(msg as AcknowledgeMessage,message);
         }
         else
         {
            errorMsg = new ErrorMessage();
            errorMsg.faultCode = "Server.Acknowledge.Failed";
            errorMsg.faultString = this.resourceManager.getString("messaging","ackFailed");
            errorMsg.faultDetail = this.resourceManager.getString("messaging","ackFailed.details",[message.messageId,AsyncMessage(msg).correlationId]);
            errorMsg.correlationId = message.messageId;
            agent.fault(errorMsg,message);
         }
      }
      else
      {
         errorMsg = new ErrorMessage();
         errorMsg.faultCode = "Server.Acknowledge.Failed";
         errorMsg.faultString = this.resourceManager.getString("messaging","noAckMessage");
         errorMsg.faultDetail = this.resourceManager.getString("messaging","noAckMessage.details",[!!msg ? msg.toString() : "null"]);
         errorMsg.correlationId = message.messageId;
         agent.fault(errorMsg,message);
      }
   }
   
   override protected function statusHandler(msg:IMessage) : void
   {
      var ack:AcknowledgeMessage = null;
      var errorMsg:ErrorMessage = null;
      if(this.handled)
      {
         return;
      }
      this.disconnect();
      if(msg is AsyncMessage)
      {
         if(AsyncMessage(msg).correlationId == message.messageId)
         {
            ack = new AcknowledgeMessage();
            ack.correlationId = AsyncMessage(msg).correlationId;
            ack.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
            agent.acknowledge(ack,message);
            agent.fault(msg as ErrorMessage,message);
         }
         else if(msg is ErrorMessage)
         {
            agent.fault(msg as ErrorMessage,message);
         }
         else
         {
            errorMsg = new ErrorMessage();
            errorMsg.faultCode = "Server.Acknowledge.Failed";
            errorMsg.faultString = this.resourceManager.getString("messaging","noErrorForMessage");
            errorMsg.faultDetail = this.resourceManager.getString("messaging","noErrorForMessage.details",[message.messageId,AsyncMessage(msg).correlationId]);
            errorMsg.correlationId = message.messageId;
            agent.fault(errorMsg,message);
         }
      }
      else
      {
         errorMsg = new ErrorMessage();
         errorMsg.faultCode = "Server.Acknowledge.Failed";
         errorMsg.faultString = this.resourceManager.getString("messaging","noAckMessage");
         errorMsg.faultDetail = this.resourceManager.getString("messaging","noAckMessage.details",[!!msg ? msg.toString() : "null"]);
         errorMsg.correlationId = message.messageId;
         agent.fault(errorMsg,message);
      }
   }
   
   override protected function requestTimedOut() : void
   {
      this.statusHandler(createRequestTimeoutErrorMessage());
   }
   
   protected function channelDisconnectHandler(event:ChannelEvent) : void
   {
      if(this.handled)
      {
         return;
      }
      this.disconnect();
      var errorMsg:ErrorMessage = new ErrorMessage();
      errorMsg.correlationId = message.messageId;
      errorMsg.faultString = this.resourceManager.getString("messaging","deliveryInDoubt");
      errorMsg.faultDetail = this.resourceManager.getString("messaging","deliveryInDoubt.details");
      errorMsg.faultCode = ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT;
      errorMsg.rootCause = event;
      agent.fault(errorMsg,message);
   }
   
   protected function channelFaultHandler(event:ChannelFaultEvent) : void
   {
      if(this.handled)
      {
         return;
      }
      this.disconnect();
      var errorMsg:ErrorMessage = event.createErrorMessage();
      errorMsg.correlationId = message.messageId;
      if(!event.channel.connected)
      {
         errorMsg.faultCode = ErrorMessage.MESSAGE_DELIVERY_IN_DOUBT;
      }
      errorMsg.rootCause = event;
      agent.fault(errorMsg,message);
   }
   
   private function disconnect() : void
   {
      this.handled = true;
      channel.removeEventListener(ChannelEvent.DISCONNECT,this.channelDisconnectHandler);
      channel.removeEventListener(ChannelFaultEvent.FAULT,this.channelFaultHandler);
   }
}
