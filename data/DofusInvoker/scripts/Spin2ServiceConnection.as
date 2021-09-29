package
{
   import chat.auth.AuthErrorCode;
   import chat.auth.AuthRequest;
   import chat.auth.AuthResponse;
   import chat.protocol.common.CorrelatedRequest;
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.common.MessageType;
   import chat.protocol.common.PayloadType;
   import chat.protocol.transport.Frame;
   import chat.protocol.transport.Request;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.SecureSocket;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import pools.PoolableChatFrame;
   import pools.PoolsManager;
   
   public class Spin2ServiceConnection
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Spin2ServiceConnection));
      
      protected static const SPIN_HEADER_BYTES_SIZE:uint = 4;
      
      protected static const SPIN_MSG_TYPE_BYTES_SIZE:uint = 1;
      
      protected static const MAX_MSG_SIZE:uint = 128 * 1024;
      
      private static const RECONNECT_TRY_DELAY:Vector.<Number> = new <Number>[2000,10000,30000,60000,120000];
      
      private static const HEARTBEAT_DELAY:Number = 25000;
       
      
      protected var currentCorrelationId:int = 0;
      
      protected var statusRequestMap:Dictionary;
      
      protected var accountId:String;
      
      protected var _currentHaapiToken:String = "";
      
      private var _host:String;
      
      private var _port:int;
      
      private var _socket:Socket;
      
      private var _buffer:ByteArray;
      
      private var _toSendBuffer:ByteArray;
      
      private var _currentData:ByteArray;
      
      private var _reconnectionTryCount:uint = 0;
      
      private var _reconnectTimer:BenchmarkTimer;
      
      private var _heartbeatTimer:BenchmarkTimer;
      
      private var _authenticated:Boolean = false;
      
      public function Spin2ServiceConnection(host:String, port:int)
      {
         this.statusRequestMap = new Dictionary();
         super();
         this._host = host;
         this._port = port;
         this._buffer = new ByteArray();
         this._currentData = new ByteArray();
         this._toSendBuffer = new ByteArray();
         if(host == "localhost")
         {
            this._socket = new Socket();
         }
         else
         {
            this._socket = new SecureSocket();
         }
         this._socket.addEventListener(Event.CONNECT,this.onConnectedToSocket);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onDataReceived);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._socket.addEventListener(Event.CLOSE,this.onSocketClosed);
         this._reconnectTimer = new BenchmarkTimer(this.getExponentialBackoffDelay(),1,"Spin2ServiceConnection._reconnectTimer");
         this._reconnectTimer.addEventListener(TimerEvent.TIMER_COMPLETE,function(event:TimerEvent):void
         {
            connect();
         });
         this._heartbeatTimer = new BenchmarkTimer(HEARTBEAT_DELAY,0,"Spin2ServiceConnection._heartbeatTimer");
         this._heartbeatTimer.addEventListener(TimerEvent.TIMER,function(event:TimerEvent):void
         {
            sendHeartbeat();
         });
      }
      
      public function get connected() : Boolean
      {
         return this._socket != null && this._socket.connected;
      }
      
      public function set authenticated(c:Boolean) : void
      {
         this._authenticated = c;
      }
      
      public function get authenticated() : Boolean
      {
         return this._authenticated;
      }
      
      protected function log(level:uint, msg:String) : void
      {
         _log.log(level,msg);
      }
      
      public function connect() : void
      {
         throw new Error("connect() is an abstract method, it must be implemented");
      }
      
      protected function requestAuthDetails() : void
      {
         throw new Error("requestAuthDetails() is an abstract method, it must be implemented and must call onAuthDetailsReady() when auth properties are available");
      }
      
      protected function onAuthenticated() : void
      {
         this.authenticated = true;
         this._heartbeatTimer.start();
         this.log(LogLevel.INFO,"User authenticated. Starting to send Heartbeats");
         this.resetReconnectionTimer();
      }
      
      protected function onDisconnected() : void
      {
      }
      
      protected function onMessage(msg:Frame) : void
      {
      }
      
      protected function connectSocket() : void
      {
         if(this._socket.connected)
         {
            this.log(LogLevel.WARN,"Already connected, aborting");
            if(!this.authenticated)
            {
               this.send(MessageType.PING,"");
            }
            return;
         }
         this._reconnectTimer.reset();
         this.log(LogLevel.INFO,"Spin2 Chat Service : Connecting to " + this._host + ":" + this._port + "...");
         this._socket.connect(this._host,this._port);
      }
      
      public function disconnect() : void
      {
         this._heartbeatTimer.reset();
         this.resetReconnectionTimer();
         if(this.connected)
         {
            this.log(LogLevel.INFO,"disconnecting socket");
            this.closeSocket();
         }
         if(this.authenticated)
         {
            this.authenticated = false;
            this.onDisconnected();
         }
         this.resetCurrentHaapiToken();
      }
      
      protected function closeSocket() : void
      {
         this._socket.removeEventListener(Event.CONNECT,this.onConnectedToSocket);
         this._socket.removeEventListener(ProgressEvent.SOCKET_DATA,this.onDataReceived);
         this._socket.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._socket.removeEventListener(Event.CLOSE,this.onSocketClosed);
         this._socket.close();
      }
      
      protected function authenticate(authToken:String) : void
      {
         this.log(LogLevel.INFO,"Connected to chat service. Sending auth_token:" + authToken);
         var authMsg:AuthRequest = new AuthRequest(authToken);
         this.send(MessageType.APPLICATION_MESSAGE,authMsg.encodePooled());
      }
      
      private function sendHeartbeat() : void
      {
         this.send(MessageType.HEART_BEAT,"");
      }
      
      protected function send(msgType:int, encodedMsg:String) : void
      {
         if(!this._socket.connected)
         {
            this.log(LogLevel.WARN,"Socket is not connected, cannot send.");
            this.tryReconnect();
            return;
         }
         this.log(LogLevel.INFO,encodedMsg);
         this._toSendBuffer.clear();
         this._toSendBuffer.writeUTFBytes(encodedMsg);
         this._socket.writeUnsignedInt(this._toSendBuffer.length + SPIN_MSG_TYPE_BYTES_SIZE + SPIN_HEADER_BYTES_SIZE);
         this._socket.writeByte(msgType);
         this._socket.writeBytes(this._toSendBuffer);
         this._socket.flush();
      }
      
      protected function sendChatServiceCmd(payload:JsonifiedMessage, callbackOnFailure:Function = null) : void
      {
         var error:String = null;
         ++this.currentCorrelationId;
         var cmdRequest:Frame = new Frame();
         cmdRequest.request = new Request(this.currentCorrelationId,payload);
         this.statusRequestMap[this.currentCorrelationId] = new CorrelatedRequest(cmdRequest,callbackOnFailure);
         var encodedMsg:String = cmdRequest.encodePooled();
         var debugMsg:String = "";
         if(encodedMsg == null)
         {
            debugMsg = " encoded msg is null";
         }
         else if(encodedMsg == "")
         {
            debugMsg = " encoded msg is empty";
         }
         else if(encodedMsg.indexOf("\"request\":{") == -1)
         {
            debugMsg = " encoded msg does not contain request";
         }
         if(debugMsg != "")
         {
            error = "Try to send message type APPLICATION_MESSAGE (" + encodedMsg + ") but " + debugMsg;
            ErrorManager.addError(error,null,false);
            this.log(LogLevel.INFO,error);
            return;
         }
         this.send(MessageType.APPLICATION_MESSAGE,encodedMsg);
      }
      
      private function parseCurrentData(msgType:uint) : void
      {
         var decodedAuthResponse:AuthResponse = null;
         var decodedMsg:Frame = null;
         var code:int = 0;
         if(!this.authenticated && msgType == MessageType.PONG)
         {
            this.log(LogLevel.INFO,"Received pong, ask for authDetails");
            this.requestAuthDetails();
            return;
         }
         if(msgType != MessageType.APPLICATION_MESSAGE)
         {
            this.log(LogLevel.WARN,"Receiving msg type other than APPLICATION_MESSAGE (" + msgType + "), skipping this message...");
            return;
         }
         if(!this.authenticated)
         {
            decodedAuthResponse = AuthResponse.createFromJson(this._currentData.toString());
            if(decodedAuthResponse != null)
            {
               if(decodedAuthResponse.success)
               {
                  this.onAuthenticated();
               }
               else
               {
                  this.processAuthenticationError(decodedAuthResponse);
                  this.send(MessageType.PING,"");
               }
            }
         }
         else
         {
            decodedMsg = Frame.createFromJson(this._currentData.toString());
            if(decodedMsg == null)
            {
               this.log(LogLevel.WARN,"Decoded Message is null...");
               return;
            }
            code = 0;
            if(decodedMsg.event != null)
            {
               code = decodedMsg.event.id;
               this.log(LogLevel.DEBUG,"decoded event (" + code + ") " + PayloadType.getPayloadType(code) + " : " + this._currentData.toString());
            }
            else if(decodedMsg.response != null && decodedMsg.response.payload != null)
            {
               code = decodedMsg.response.payload.id;
               this.log(LogLevel.DEBUG,"decoded response (" + code + ") " + PayloadType.getPayloadType(code) + " : " + this._currentData.toString());
            }
            else if(decodedMsg == null || decodedMsg.event == null && decodedMsg.response == null && decodedMsg.request == null)
            {
               this.log(LogLevel.DEBUG,"Failed to parse decoded message : " + this._currentData.toString());
            }
            this.onMessage(decodedMsg);
            PoolsManager.getInstance().getChatFramePool().checkIn(decodedMsg as PoolableChatFrame);
         }
      }
      
      private function resetReconnectionTimer() : void
      {
         this._reconnectTimer.reset();
         this._reconnectionTryCount = 0;
         this._reconnectTimer.delay = this.getExponentialBackoffDelay();
      }
      
      private function retryReconnectionTimer() : void
      {
         if(this._reconnectionTryCount + 1 < RECONNECT_TRY_DELAY.length)
         {
            ++this._reconnectionTryCount;
         }
         this._reconnectTimer.reset();
         this._reconnectTimer.delay = this.getExponentialBackoffDelay();
         this._reconnectTimer.start();
      }
      
      private function getExponentialBackoffDelay() : Number
      {
         var delay:Number = RECONNECT_TRY_DELAY[this._reconnectionTryCount] * (1 + Math.random());
         this.log(LogLevel.INFO,"Will try to reconnect, timer delay is now set to " + delay + " ms ");
         return delay;
      }
      
      protected function tryReconnect() : void
      {
         this.log(LogLevel.INFO,"try to reconnect ");
         if(this._reconnectTimer.running)
         {
            return;
         }
         this.log(LogLevel.INFO,"reset heartbeat timer ");
         this._heartbeatTimer.reset();
         this.log(LogLevel.INFO,"check socket connected ");
         if(this._socket.connected)
         {
            this.log(LogLevel.INFO,"close socket ");
            this._socket.close();
         }
         this.log(LogLevel.INFO,"check if authenticated ");
         if(this.authenticated)
         {
            this.authenticated = false;
            this.log(LogLevel.INFO,"onDisconnected...");
            this.onDisconnected();
         }
         this.log(LogLevel.INFO,"reset Current Haapi Token ");
         this.resetCurrentHaapiToken();
         this.log(LogLevel.INFO,"retryReconnectionTimer ");
         this.retryReconnectionTimer();
         this.log(LogLevel.INFO,"tryReconnect complete... ");
      }
      
      protected function resetCurrentHaapiToken() : void
      {
         this._currentHaapiToken = "";
      }
      
      private function processAuthenticationError(authResponse:AuthResponse) : void
      {
         this.resetCurrentHaapiToken();
         this.log(LogLevel.ERROR,"Authentication on chat service failed, try reconnecting : " + AuthErrorCode.getError(authResponse.errCode));
      }
      
      private function onSecurityError(event:SecurityErrorEvent) : void
      {
         this.log(LogLevel.ERROR,"Connection security error : " + event.toString());
         this.tryReconnect();
      }
      
      private function onIOError(event:IOErrorEvent) : void
      {
         this.log(LogLevel.ERROR,"Connection IO error : " + event.toString());
         if(this._socket is SecureSocket)
         {
            this.log(LogLevel.ERROR,"Server certification status : " + (this._socket as SecureSocket).serverCertificateStatus);
         }
         this.tryReconnect();
      }
      
      private function onSocketClosed(event:Event) : void
      {
         this.log(LogLevel.WARN,"Connection to socket closed. Try reconnecting... reason is : " + event);
         this.tryReconnect();
      }
      
      private function onConnectedToSocket(event:Event) : void
      {
         this._socket.removeEventListener(Event.CONNECT,this.onConnectedToSocket);
         this._reconnectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onReconnectTimerEnd);
         this._reconnectTimer.stop();
         if(!this.authenticated)
         {
            this.send(MessageType.PING,"");
         }
      }
      
      private function onDataReceived(event:ProgressEvent) : void
      {
         var messageType:uint = 0;
         if(!this._socket.connected)
         {
            this.log(LogLevel.ERROR,"Can\'t read bytes, socket is not connected...");
            return;
         }
         this._socket.readBytes(this._buffer);
         this._buffer.position = 0;
         var length:int = 0;
         while(this._buffer.bytesAvailable > SPIN_HEADER_BYTES_SIZE)
         {
            length = this._buffer.readInt();
            if(length < 0 || length > MAX_MSG_SIZE)
            {
               this.log(LogLevel.FATAL,"Frame too large received: requestedFrame size is " + length + " but maximumMessageSize is " + MAX_MSG_SIZE);
               break;
            }
            if(this._buffer.bytesAvailable < length - SPIN_HEADER_BYTES_SIZE)
            {
               break;
            }
            this._currentData.clear();
            messageType = this._buffer.readByte();
            this._buffer.readBytes(this._currentData,0,length - (SPIN_HEADER_BYTES_SIZE + SPIN_MSG_TYPE_BYTES_SIZE));
            this.parseCurrentData(messageType);
         }
         var newBuffer:ByteArray = new ByteArray();
         if(this._buffer.bytesAvailable - length > 0)
         {
            newBuffer.writeBytes(this._buffer,length,this._buffer.bytesAvailable - length);
            this._buffer = newBuffer;
            this._buffer.position = 0;
         }
         else
         {
            this._buffer.clear();
         }
      }
      
      private function onReconnectTimerEnd(event:TimerEvent) : void
      {
         this.connect();
      }
      
      private function onHeartbeatTimerEnd(event:TimerEvent) : void
      {
         if(this.authenticated)
         {
            this._heartbeatTimer.removeEventListener(TimerEvent.TIMER,this.onHeartbeatTimerEnd);
         }
         this.sendHeartbeat();
      }
   }
}
