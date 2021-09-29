package mx.messaging.channels
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import mx.core.mx_internal;
   import mx.messaging.Channel;
   import mx.messaging.MessageAgent;
   import mx.messaging.MessageResponder;
   import mx.messaging.config.LoaderConfig;
   import mx.messaging.errors.ChannelError;
   import mx.messaging.errors.InvalidChannelError;
   import mx.messaging.errors.MessageSerializationError;
   import mx.messaging.messages.HTTPRequestMessage;
   import mx.messaging.messages.IMessage;
   import mx.netmon.NetworkMonitor;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class DirectHTTPChannel extends Channel
   {
      
      private static var clientCounter:uint;
       
      
      mx_internal var clientId:String;
      
      private var resourceManager:IResourceManager;
      
      public function DirectHTTPChannel(id:String, uri:String = "")
      {
         var message:String = null;
         this.resourceManager = ResourceManager.getInstance();
         super(id,uri);
         if(uri.length > 0)
         {
            message = this.resourceManager.getString("messaging","noURIAllowed");
            throw new InvalidChannelError(message);
         }
         this.clientId = "DirectHTTPChannel" + clientCounter++;
      }
      
      override public function get connected() : Boolean
      {
         return true;
      }
      
      override public function get protocol() : String
      {
         return "http";
      }
      
      override mx_internal function get realtime() : Boolean
      {
         return false;
      }
      
      override protected function connectTimeoutHandler(event:TimerEvent) : void
      {
      }
      
      override protected function getMessageResponder(agent:MessageAgent, message:IMessage) : MessageResponder
      {
         return new DirectHTTPMessageResponder(agent,message,this,new URLLoader());
      }
      
      override protected function internalConnect() : void
      {
         connectSuccess();
      }
      
      override protected function internalSend(msgResp:MessageResponder) : void
      {
         var httpMsgResp:DirectHTTPMessageResponder = null;
         var urlRequest:URLRequest = null;
         httpMsgResp = DirectHTTPMessageResponder(msgResp);
         try
         {
            urlRequest = this.createURLRequest(httpMsgResp.message);
         }
         catch(e:MessageSerializationError)
         {
            httpMsgResp.agent.fault(e.fault,httpMsgResp.message);
            return;
         }
         var urlLoader:URLLoader = httpMsgResp.urlLoader;
         urlLoader.addEventListener(ErrorEvent.ERROR,httpMsgResp.errorHandler);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,httpMsgResp.errorHandler);
         urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,httpMsgResp.securityErrorHandler);
         urlLoader.addEventListener(Event.COMPLETE,httpMsgResp.completeHandler);
         urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpMsgResp.httpStatusHandler);
         urlLoader.load(urlRequest);
      }
      
      mx_internal function createURLRequest(message:IMessage) : URLRequest
      {
         var requestHeaders:Array = null;
         var header:URLRequestHeader = null;
         var h:* = null;
         var urlVariables:URLVariables = null;
         var body:Object = null;
         var p:* = null;
         var httpMsg:HTTPRequestMessage = HTTPRequestMessage(message);
         var result:URLRequest = new URLRequest();
         var url:String = httpMsg.url;
         var params:String = null;
         if("idleTimeout" in result && requestTimeout > 0)
         {
            result["idleTimeout"] = requestTimeout * 1000;
         }
         result.contentType = httpMsg.contentType;
         var contentTypeIsXML:Boolean = result.contentType == HTTPRequestMessage.CONTENT_TYPE_XML || result.contentType == HTTPRequestMessage.CONTENT_TYPE_SOAP_XML;
         var headers:Object = httpMsg.httpHeaders;
         if(headers)
         {
            requestHeaders = [];
            for(h in headers)
            {
               header = new URLRequestHeader(h,headers[h]);
               requestHeaders.push(header);
            }
            result.requestHeaders = requestHeaders;
         }
         if(!contentTypeIsXML)
         {
            urlVariables = new URLVariables();
            body = httpMsg.body;
            for(p in body)
            {
               urlVariables[p] = httpMsg.body[p];
            }
            params = urlVariables.toString();
         }
         if(httpMsg.method == HTTPRequestMessage.POST_METHOD || contentTypeIsXML)
         {
            result.method = "POST";
            if(result.contentType == HTTPRequestMessage.CONTENT_TYPE_FORM)
            {
               result.data = params;
            }
            else if(httpMsg.body != null && httpMsg.body is XML)
            {
               result.data = XML(httpMsg.body).toXMLString();
            }
            else
            {
               result.data = httpMsg.body;
            }
         }
         else if(params && params != "")
         {
            url += url.indexOf("?") > -1 ? "&" : "?";
            url += params;
         }
         result.url = url;
         if(NetworkMonitor.isMonitoring())
         {
            NetworkMonitor.adjustURLRequest(result,LoaderConfig.url,message.messageId);
         }
         return result;
      }
      
      override public function setCredentials(credentials:String, agent:MessageAgent = null, charset:String = null) : void
      {
         var message:String = this.resourceManager.getString("messaging","authenticationNotSupported");
         throw new ChannelError(message);
      }
   }
}

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import mx.core.mx_internal;
import mx.messaging.MessageAgent;
import mx.messaging.MessageResponder;
import mx.messaging.channels.DirectHTTPChannel;
import mx.messaging.messages.AbstractMessage;
import mx.messaging.messages.AcknowledgeMessage;
import mx.messaging.messages.ErrorMessage;
import mx.messaging.messages.HTTPRequestMessage;
import mx.messaging.messages.IMessage;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

use namespace mx_internal;

class DirectHTTPMessageResponder extends MessageResponder
{
    
   
   private var clientId:String;
   
   private var lastStatus:int;
   
   private var resourceManager:IResourceManager;
   
   public var urlLoader:URLLoader;
   
   function DirectHTTPMessageResponder(agent:MessageAgent, msg:IMessage, channel:DirectHTTPChannel, urlLoader:URLLoader)
   {
      this.resourceManager = ResourceManager.getInstance();
      super(agent,msg,channel);
      this.urlLoader = urlLoader;
      this.clientId = channel.clientId;
   }
   
   public function errorHandler(event:Event) : void
   {
      status(null);
      var ack:AcknowledgeMessage = new AcknowledgeMessage();
      ack.clientId = this.clientId;
      ack.correlationId = message.messageId;
      ack.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
      agent.acknowledge(ack,message);
      var msg:ErrorMessage = new ErrorMessage();
      msg.clientId = this.clientId;
      msg.correlationId = message.messageId;
      msg.faultCode = "Server.Error.Request";
      msg.faultString = this.resourceManager.getString("messaging","httpRequestError");
      var details:* = event.toString();
      if(message is HTTPRequestMessage)
      {
         details += ". URL: ";
         details += HTTPRequestMessage(message).url;
      }
      msg.faultDetail = this.resourceManager.getString("messaging","httpRequestError.details",[details]);
      msg.rootCause = event;
      msg.body = URLLoader(event.target).data;
      msg.headers[AbstractMessage.STATUS_CODE_HEADER] = this.lastStatus;
      agent.fault(msg,message);
   }
   
   public function securityErrorHandler(event:Event) : void
   {
      status(null);
      var ack:AcknowledgeMessage = new AcknowledgeMessage();
      ack.clientId = this.clientId;
      ack.correlationId = message.messageId;
      ack.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
      agent.acknowledge(ack,message);
      var msg:ErrorMessage = new ErrorMessage();
      msg.clientId = this.clientId;
      msg.correlationId = message.messageId;
      msg.faultCode = "Channel.Security.Error";
      msg.faultString = this.resourceManager.getString("messaging","securityError");
      msg.faultDetail = this.resourceManager.getString("messaging","securityError.details",[message.destination]);
      msg.rootCause = event;
      msg.body = URLLoader(event.target).data;
      msg.headers[AbstractMessage.STATUS_CODE_HEADER] = this.lastStatus;
      agent.fault(msg,message);
   }
   
   public function completeHandler(event:Event) : void
   {
      result(null);
      var ack:AcknowledgeMessage = new AcknowledgeMessage();
      ack.clientId = this.clientId;
      ack.correlationId = message.messageId;
      ack.body = URLLoader(event.target).data;
      ack.headers[AbstractMessage.STATUS_CODE_HEADER] = this.lastStatus;
      agent.acknowledge(ack,message);
   }
   
   public function httpStatusHandler(event:HTTPStatusEvent) : void
   {
      this.lastStatus = event.status;
   }
   
   override protected function requestTimedOut() : void
   {
      this.urlLoader.removeEventListener(ErrorEvent.ERROR,this.errorHandler);
      this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
      this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
      this.urlLoader.removeEventListener(Event.COMPLETE,this.completeHandler);
      this.urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
      this.urlLoader.close();
      status(null);
      var ack:AcknowledgeMessage = new AcknowledgeMessage();
      ack.clientId = this.clientId;
      ack.correlationId = message.messageId;
      ack.headers[AcknowledgeMessage.ERROR_HINT_HEADER] = true;
      agent.acknowledge(ack,message);
      agent.fault(createRequestTimeoutErrorMessage(),message);
   }
}
