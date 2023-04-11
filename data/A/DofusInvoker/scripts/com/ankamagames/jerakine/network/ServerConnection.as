package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.ConnectedMessage;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.network.messages.ServerConnectionClosedMessage;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.SecureSocket;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class ServerConnection implements IEventDispatcher, IServerConnection
   {
      
      public static var DEBUG_VERBOSE:Boolean = false;
      
      public static var DEBUG_LOW_LEVEL_VERBOSE:Boolean = false;
      
      private static const LATENCY_AVG_BUFFER_SIZE:uint = 50;
      
      private static const MESSAGE_SIZE_ASYNC_THRESHOLD:uint = 300 * 1024;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerConnection));
       
      
      protected var _socket:Socket;
      
      private var _id:String;
      
      private var _rawParser:RawDataParser;
      
      private var _handler:MessageHandler;
      
      private var _remoteSrvHost:String;
      
      private var _remoteSrvPort:uint;
      
      private var _connecting:Boolean;
      
      private var _outputBuffer:Array;
      
      private var _splittedPacket:Boolean;
      
      private var _staticHeader:int;
      
      private var _splittedPacketId:uint;
      
      private var _splittedPacketLength:uint;
      
      private var _inputBuffer:ByteArray;
      
      private var _pauseBuffer:Array;
      
      private var _pause:Boolean;
      
      private var _latencyBuffer:Array;
      
      private var _latestSent:uint;
      
      private var _timeoutTimer:BenchmarkTimer;
      
      private var _lagometer:ILagometer;
      
      private var _asyncMessages:Vector.<INetworkMessage>;
      
      private var _asyncTrees:Vector.<FuncTree>;
      
      private var _asyncNetworkDataContainerMessage:INetworkDataContainerMessage;
      
      private var _willClose:Boolean;
      
      private var _input:ByteArray;
      
      private var _maxUnpackTime:uint;
      
      private var _firstConnectionTry:Boolean = true;
      
      public function ServerConnection(host:String = null, port:int = 0, id:String = "", secure:Boolean = false)
      {
         this._pauseBuffer = [];
         this._latencyBuffer = [];
         this._asyncMessages = new Vector.<INetworkMessage>();
         this._asyncTrees = new Vector.<FuncTree>();
         this._input = new ByteArray();
         super();
         if(secure && SecureSocket.isSupported)
         {
            this._socket = new SecureSocket();
         }
         else
         {
            this._socket = new Socket(host,port);
         }
         this._remoteSrvHost = host;
         this._remoteSrvPort = port;
         this._id = id;
         this._maxUnpackTime = 1000 / StageShareManager.stage.frameRate * 0.5;
      }
      
      public function close() : void
      {
         if(this._socket.connected)
         {
            _log.debug("[" + this._id + "] Closing socket for connection! " + new Error().getStackTrace());
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this._socket.close();
         }
         else if(!this.checkClosed())
         {
            _log.warn("[" + this._id + "] Tried to close a socket while it had already been disconnected.");
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         }
      }
      
      public function get rawParser() : RawDataParser
      {
         return this._rawParser;
      }
      
      public function set rawParser(value:RawDataParser) : void
      {
         this._rawParser = value;
      }
      
      public function get handler() : MessageHandler
      {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void
      {
         this._handler = value;
      }
      
      public function get pauseBuffer() : Array
      {
         return this._pauseBuffer;
      }
      
      public function get latencyAvg() : uint
      {
         var latency:uint = 0;
         if(this._latencyBuffer.length == 0)
         {
            return 0;
         }
         var total:uint = 0;
         for each(latency in this._latencyBuffer)
         {
            total += latency;
         }
         return total / this._latencyBuffer.length;
      }
      
      public function get latencySamplesCount() : uint
      {
         return this._latencyBuffer.length;
      }
      
      public function get latencySamplesMax() : uint
      {
         return LATENCY_AVG_BUFFER_SIZE;
      }
      
      public function get port() : uint
      {
         return this._remoteSrvPort;
      }
      
      public function set lagometer(l:ILagometer) : void
      {
         this._lagometer = l;
      }
      
      public function get lagometer() : ILagometer
      {
         return this._lagometer;
      }
      
      public function get connected() : Boolean
      {
         return this._socket.connected;
      }
      
      public function get connecting() : Boolean
      {
         return this._connecting;
      }
      
      public function connect(host:String, port:int) : void
      {
         if(this._connecting)
         {
            return;
         }
         this._connecting = true;
         this._firstConnectionTry = true;
         this._remoteSrvHost = host;
         this._remoteSrvPort = port;
         this.addListeners();
         _log.info("[" + this._id + "] Connecting to " + host + ":" + port + "...");
         try
         {
            this._socket.connect(host,port);
         }
         catch(error:Error)
         {
            _log.error("[" + _id + "] Could not establish connection to the serveur!\n" + error.message);
         }
         this._timeoutTimer = new BenchmarkTimer(7000,1,"ServerConnection._timeoutTimer");
         this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSocketTimeOut);
         this._timeoutTimer.start();
      }
      
      private function getType(v:*) : String
      {
         var className:String = getQualifiedClassName(v);
         if(className.indexOf("Vector") != -1)
         {
            className = className.split("__AS3__.vec::Vector.<").join("list{");
            className = className.split(">").join("}");
         }
         else
         {
            className = className.split("::").pop();
         }
         if(v is INetworkMessage)
         {
            className += ", id: " + INetworkMessage(v).getMessageId();
         }
         return className;
      }
      
      private function inspect(target:*, indent:String = "\t", isArray:Boolean = false) : String
      {
         var content:Vector.<String> = null;
         var property:String = null;
         var key:* = null;
         var v:* = undefined;
         var str:String = "";
         if(!isArray)
         {
            str += this.getType(target);
            content = DescribeTypeCache.getVariables(target,true);
         }
         else
         {
            content = new Vector.<String>();
            for(key in target)
            {
               content.push(key);
            }
         }
         for each(property in content)
         {
            if(property == "sourceConnection" || property == "receptionTime" || property == "_unpacked")
            {
               continue;
            }
            v = target[property];
            str += "\r" + indent;
            if(isArray)
            {
               str += "[" + property + "]";
            }
            else
            {
               str += property;
            }
            switch(true)
            {
               case v is Vector.<int>:
               case v is Vector.<uint>:
               case v is Vector.<Boolean>:
               case v is Vector.<String>:
               case v is Vector.<Number>:
                  str += " (" + this.getType(v) + ", len:" + v.length + ") = " + v;
                  break;
               case getQualifiedClassName(v).indexOf("Vector") != -1:
               case v is Array:
                  str += " (" + this.getType(v) + ", len:" + v.length + ") = " + this.inspect(v,indent + "\t",true);
                  break;
               case v is String:
                  str += " = \"" + v + "\"";
                  break;
               case v is uint:
               case v is int:
               case v is Boolean:
               case v is Number:
                  str += " = " + v;
                  break;
               default:
                  str += " " + this.inspect(v,indent + "\t");
                  break;
            }
         }
         return str;
      }
      
      public function send(msg:INetworkMessage, connectionId:String = "") : void
      {
         _log.trace("[" + this._id + "] [SND] > " + (!!DEBUG_VERBOSE ? this.inspect(msg) : msg));
         if(!msg.isInitialized)
         {
            _log.warn("[" + this._id + "] Sending non-initialized packet " + msg + " !");
         }
         if(!this._socket.connected)
         {
            if(this._connecting)
            {
               if(!this._outputBuffer)
               {
                  this._outputBuffer = [];
               }
               this._outputBuffer.push(msg);
            }
            return;
         }
         this.lowSend(msg);
      }
      
      public function toString() : String
      {
         var status:* = "Server connection status:\n";
         status += "  Connected:       " + (!!this._socket.connected ? "Yes" : "No") + "\n";
         if(this._socket.connected)
         {
            status += "  Connected to:    " + this._remoteSrvHost + ":" + this._remoteSrvPort + "\n";
         }
         else
         {
            status += "  Connecting:      " + (!!this._connecting ? "Yes" : "No") + "\n";
         }
         if(this._connecting)
         {
            status += "  Connecting to:   " + this._remoteSrvHost + ":" + this._remoteSrvPort + "\n";
         }
         status += "  Raw parser:      " + this.rawParser + "\n";
         status += "  Message handler: " + this.handler + "\n";
         if(this._outputBuffer)
         {
            status += "  Output buffer:   " + this._outputBuffer.length + " message(s)\n";
         }
         if(this._inputBuffer)
         {
            status += "  Input buffer:    " + this._inputBuffer.length + " byte(s)\n";
         }
         if(this._splittedPacket)
         {
            status += "  Splitted message in the input buffer:\n";
            status += "    Message ID:      " + this._splittedPacketId + "\n";
            status += "    Awaited length:  " + this._splittedPacketLength + "\n";
         }
         return status;
      }
      
      public function pause() : void
      {
         this._pause = true;
      }
      
      public function resume() : void
      {
         var msg:INetworkMessage = null;
         this._pause = false;
         while(this._pauseBuffer.length && !this._pause)
         {
            msg = this._pauseBuffer.shift();
            _log.trace("[" + this._id + "] [RCV] (after Resume) " + (!!DEBUG_VERBOSE ? this.inspect(msg) : msg));
            _log.logDirectly(new NetworkLogEvent(msg,true));
            this._handler.process(msg);
         }
         this._pauseBuffer = [];
      }
      
      public function stopConnectionTimeout() : void
      {
         if(this._timeoutTimer)
         {
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onSocketTimeOut);
            this._timeoutTimer.stop();
            this._timeoutTimer = null;
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this._socket.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this._socket.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this._socket.hasEventListener(type);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this._socket.removeEventListener(type,listener,useCapture);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return this._socket.willTrigger(type);
      }
      
      public function tryConnectingOnAnotherPort(port:int) : void
      {
         this.connect(this._remoteSrvHost,port);
      }
      
      private function addListeners() : void
      {
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData,false,0,true);
         this._socket.addEventListener(Event.CONNECT,this.onConnect,false,0,true);
         this._socket.addEventListener(Event.CLOSE,this.onClose,false,int.MAX_VALUE,true);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError,false,0,true);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.SERVER_CONNECTION);
      }
      
      private function removeListeners() : void
      {
         this._socket.removeEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         this._socket.removeEventListener(Event.CONNECT,this.onConnect);
         this._socket.removeEventListener(Event.CLOSE,this.onClose);
         this._socket.removeEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
      }
      
      private function receive(input:IDataInput, fromEnterFrame:Boolean = false) : void
      {
         var msg:INetworkMessage = null;
         try
         {
            if(input.bytesAvailable > 0)
            {
               if(DEBUG_LOW_LEVEL_VERBOSE)
               {
                  if(fromEnterFrame)
                  {
                     _log.info("[" + this._id + "] Handling data, byte available : " + input.bytesAvailable + "  trigger by a timer");
                  }
                  else
                  {
                     _log.info("[" + this._id + "] Handling data, byte available : " + input.bytesAvailable);
                  }
               }
               msg = this.lowReceive(input);
               while(msg)
               {
                  if(this._lagometer)
                  {
                     this._lagometer.pong(msg);
                  }
                  (msg as NetworkMessage).receptionTime = getTimer();
                  (msg as NetworkMessage).sourceConnection = this._id;
                  this.process(msg);
                  if(this._asyncNetworkDataContainerMessage != null && this._asyncNetworkDataContainerMessage.content.bytesAvailable)
                  {
                     msg = this.lowReceive(this._asyncNetworkDataContainerMessage.content);
                  }
                  else
                  {
                     if(!(!this.checkClosed() && this._socket.connected))
                     {
                        break;
                     }
                     msg = this.lowReceive(input);
                  }
               }
            }
         }
         catch(e:Error)
         {
            if(e.getStackTrace())
            {
               _log.error("[" + _id + "] Error while reading socket. " + e.getStackTrace());
            }
            else
            {
               _log.error("[" + _id + "] Error while reading socket. No stack trace available");
            }
            close();
         }
      }
      
      private function checkClosed() : Boolean
      {
         if(this._willClose)
         {
            if(this._asyncTrees.length == 0)
            {
               this._willClose = false;
               this.dispatchEvent(new Event(Event.CLOSE));
            }
            return true;
         }
         return false;
      }
      
      private function process(msg:INetworkMessage) : void
      {
         if(msg.unpacked)
         {
            if(msg is INetworkDataContainerMessage)
            {
               this._asyncNetworkDataContainerMessage = INetworkDataContainerMessage(msg);
            }
            else if(!this._pause)
            {
               if(msg.getMessageId() != 176 && msg.getMessageId() != 6362)
               {
                  _log.trace("[" + this._id + "] [RCV] " + (!!DEBUG_VERBOSE ? this.inspect(msg) : msg));
               }
               _log.logDirectly(new NetworkLogEvent(msg,true));
               this._handler.process(msg);
            }
            else
            {
               this._pauseBuffer.push(msg);
            }
         }
      }
      
      private function getMessageId(firstOctet:uint) : uint
      {
         return firstOctet >> NetworkMessage.BIT_RIGHT_SHIFT_LEN_PACKET_ID;
      }
      
      private function readMessageLength(staticHeader:uint, src:IDataInput) : uint
      {
         var byteLenDynamicHeader:uint = staticHeader & NetworkMessage.BIT_MASK;
         var messageLength:uint = 0;
         switch(byteLenDynamicHeader)
         {
            case 0:
               break;
            case 1:
               messageLength = src.readUnsignedByte();
               break;
            case 2:
               messageLength = src.readUnsignedShort();
               break;
            case 3:
               messageLength = ((src.readByte() & 255) << 16) + ((src.readByte() & 255) << 8) + (src.readByte() & 255);
         }
         return messageLength;
      }
      
      protected function lowSend(msg:INetworkMessage, autoFlush:Boolean = true) : void
      {
         msg.pack(new CustomDataWrapper(this._socket));
         this._latestSent = getTimer();
         if(this._lagometer)
         {
            this._lagometer.ping(msg);
         }
         if(autoFlush)
         {
            this._socket.flush();
         }
      }
      
      protected function lowReceive(src:IDataInput) : INetworkMessage
      {
         var msg:INetworkMessage = null;
         var staticHeader:uint = 0;
         var messageId:uint = 0;
         var messageLength:uint = 0;
         if(!this._splittedPacket)
         {
            if(src.bytesAvailable < 2)
            {
               if(DEBUG_LOW_LEVEL_VERBOSE)
               {
                  _log.info("[" + this._id + "] Not enough data to read the header, byte available : " + src.bytesAvailable + " (needed : 2)");
               }
               return null;
            }
            staticHeader = src.readUnsignedShort();
            messageId = this.getMessageId(staticHeader);
            if(src.bytesAvailable >= (staticHeader & NetworkMessage.BIT_MASK))
            {
               messageLength = this.readMessageLength(staticHeader,src);
               if(src.bytesAvailable >= messageLength)
               {
                  this.updateLatency();
                  if(this.getUnpackMode(messageId,messageLength) == UnpackMode.ASYNC)
                  {
                     src.readBytes(this._input,this._input.length,messageLength);
                     msg = this._rawParser.parseAsync(new CustomDataWrapper(this._input),messageId,messageLength,this.computeMessage);
                     if(DEBUG_LOW_LEVEL_VERBOSE && msg != null)
                     {
                        _log.info("[" + this._id + "] Async " + this.getType(msg) + " parsing, message length : " + messageLength + ")");
                     }
                  }
                  else
                  {
                     msg = this._rawParser.parse(new CustomDataWrapper(src),messageId,messageLength);
                     if(DEBUG_LOW_LEVEL_VERBOSE)
                     {
                        _log.info("[" + this._id + "] Full parsing done");
                     }
                  }
                  return msg;
               }
               if(DEBUG_LOW_LEVEL_VERBOSE)
               {
                  _log.info("[" + this._id + "] Not enough data to read msg content, byte available : " + src.bytesAvailable + " (needed : " + messageLength + ")");
               }
               this._staticHeader = -1;
               this._splittedPacketLength = messageLength;
               this._splittedPacketId = messageId;
               this._splittedPacket = true;
               src.readBytes(this._inputBuffer,0,src.bytesAvailable);
               return null;
            }
            if(DEBUG_LOW_LEVEL_VERBOSE)
            {
               _log.info("[" + this._id + "] Not enough data to read message ID, byte available : " + src.bytesAvailable + " (needed : " + (staticHeader & NetworkMessage.BIT_MASK) + ")");
            }
            this._staticHeader = staticHeader;
            this._splittedPacketLength = messageLength;
            this._splittedPacketId = messageId;
            this._splittedPacket = true;
            return null;
         }
         if(this._staticHeader != -1)
         {
            this._splittedPacketLength = this.readMessageLength(this._staticHeader,src);
            this._staticHeader = -1;
         }
         if(src.bytesAvailable + this._inputBuffer.length >= this._splittedPacketLength)
         {
            src.readBytes(this._inputBuffer,this._inputBuffer.length,this._splittedPacketLength - this._inputBuffer.length);
            this._inputBuffer.position = 0;
            this.updateLatency();
            if(this.getUnpackMode(this._splittedPacketId,this._splittedPacketLength) == UnpackMode.ASYNC)
            {
               msg = this._rawParser.parseAsync(new CustomDataWrapper(this._inputBuffer),this._splittedPacketId,this._splittedPacketLength,this.computeMessage);
               if(DEBUG_LOW_LEVEL_VERBOSE && msg != null)
               {
                  _log.info("[" + this._id + "] Async splitted " + this.getType(msg) + " parsing, message length : " + this._splittedPacketLength + ")");
               }
            }
            else
            {
               msg = this._rawParser.parse(new CustomDataWrapper(this._inputBuffer),this._splittedPacketId,this._splittedPacketLength);
               if(DEBUG_LOW_LEVEL_VERBOSE)
               {
                  _log.info("[" + this._id + "] Full parsing done");
               }
            }
            this._splittedPacket = false;
            this._inputBuffer = new ByteArray();
            return msg;
         }
         src.readBytes(this._inputBuffer,this._inputBuffer.length,src.bytesAvailable);
         return null;
      }
      
      private function getUnpackMode(messageId:uint, messageLength:uint) : uint
      {
         if(messageLength == 0)
         {
            return UnpackMode.SYNC;
         }
         var result:uint = this._rawParser.getUnpackMode(messageId);
         if(result != UnpackMode.DEFAULT)
         {
            return result;
         }
         if(messageLength > MESSAGE_SIZE_ASYNC_THRESHOLD)
         {
            result = UnpackMode.ASYNC;
            _log.info("Handling too heavy message of id " + messageId + " asynchronously (size : " + messageLength + ")");
         }
         else
         {
            result = UnpackMode.SYNC;
         }
         return result;
      }
      
      private function computeMessage(msg:INetworkMessage, tree:FuncTree) : void
      {
         if(!tree.goDown())
         {
            msg.unpacked = true;
            return;
         }
         this._asyncMessages.push(msg);
         this._asyncTrees.push(tree);
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.SERVER_CONNECTION);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var start:int = getTimer();
         if(this._socket.connected)
         {
            this.receive(this._socket,true);
         }
         if(this._asyncMessages.length && this._asyncTrees.length)
         {
            do
            {
               if(!this._asyncTrees[0].next())
               {
                  if(DEBUG_LOW_LEVEL_VERBOSE)
                  {
                     _log.info("[" + this._id + "] Async " + this.getType(this._asyncMessages[0]) + " parsing complete");
                  }
                  this._asyncTrees.shift();
                  this._asyncMessages[0].unpacked = true;
                  this.process(this._asyncMessages.shift());
                  if(this._asyncTrees.length == 0)
                  {
                     EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                     return;
                  }
               }
            }
            while(getTimer() - start < this._maxUnpackTime);
            
         }
      }
      
      private function updateLatency() : void
      {
         if(this._pause || this._pauseBuffer.length > 0 || this._latestSent == 0)
         {
            return;
         }
         var packetReceived:uint = getTimer();
         var latency:uint = packetReceived - this._latestSent;
         this._latestSent = 0;
         this._latencyBuffer.push(latency);
         if(this._latencyBuffer.length > LATENCY_AVG_BUFFER_SIZE)
         {
            this._latencyBuffer.shift();
         }
      }
      
      protected function onConnect(e:Event) : void
      {
         var msg:INetworkMessage = null;
         this._connecting = false;
         this.stopConnectionTimeout();
         _log.trace("[" + this._id + "] Connection opened.");
         for each(msg in this._outputBuffer)
         {
            this.lowSend(msg,false);
         }
         this._socket.flush();
         this._inputBuffer = new ByteArray();
         this._outputBuffer = [];
         if(this._handler)
         {
            this._handler.process(new ConnectedMessage());
         }
      }
      
      protected function onClose(e:Event) : void
      {
         if(this._asyncMessages.length != 0)
         {
            e.stopImmediatePropagation();
            this._willClose = true;
            return;
         }
         _log.trace("[" + this._id + "] Connection closed.");
         setTimeout(this.removeListeners,30000);
         if(this._lagometer)
         {
            this._lagometer.stop();
         }
         this._handler.process(new ServerConnectionClosedMessage(this));
         this._connecting = false;
         this._outputBuffer = [];
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         this._asyncTrees = new Vector.<FuncTree>();
         this._asyncMessages = new Vector.<INetworkMessage>();
         this._asyncNetworkDataContainerMessage = null;
         this._input = new ByteArray();
         this._splittedPacket = false;
         this._staticHeader = -1;
      }
      
      protected function onSocketData(pe:ProgressEvent) : void
      {
         if(DEBUG_LOW_LEVEL_VERBOSE)
         {
            _log.info("[" + this._id + "] Receive Event, byte available : " + this._socket.bytesAvailable);
         }
         this.receive(this._socket);
      }
      
      protected function onSocketError(e:IOErrorEvent) : void
      {
         if(this._lagometer)
         {
            this._lagometer.stop();
         }
         _log.error("[" + this._id + "] Failure while opening socket.");
         this._connecting = false;
         this._handler.process(new ServerConnectionFailedMessage(this,e.text));
      }
      
      protected function onSocketTimeOut(e:Event) : void
      {
         if(this._lagometer)
         {
            this._lagometer.stop();
         }
         this._connecting = false;
         if(this._firstConnectionTry)
         {
            _log.error("[" + this._id + "] Failure while opening socket, timeout, but WWJD ? Give a second chance !");
            this.connect(this._remoteSrvHost,this._remoteSrvPort);
            this._firstConnectionTry = false;
         }
         else
         {
            _log.error("[" + this._id + "] Failure while opening socket, timeout.");
            this._handler.process(new ServerConnectionFailedMessage(this,"timeout§§§"));
         }
      }
      
      protected function onSecurityError(see:SecurityErrorEvent) : void
      {
         if(this._lagometer)
         {
            this._lagometer.stop();
         }
         if(this._socket.connected)
         {
            _log.error("[" + this._id + "] Security error while connected : " + see.text);
            this._handler.process(new ServerConnectionFailedMessage(this,see.text));
         }
         else
         {
            _log.error("[" + this._id + "] Security error while disconnected : " + see.text);
         }
      }
   }
}
