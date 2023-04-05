package com.demonsters.debugger
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   class MonsterDebuggerConnectionDefault implements IMonsterDebuggerConnection
   {
       
      
      private var _length:uint;
      
      private var _package:ByteArray;
      
      private const MAX_QUEUE_LENGTH:int = 500;
      
      private var _queue:Array;
      
      private var _connecting:Boolean;
      
      private var _socket:Socket;
      
      private var _timeout:Timer;
      
      private var _port:int;
      
      private var _retry:Timer;
      
      private var _bytes:ByteArray;
      
      private var _process:Boolean;
      
      private var _address:String;
      
      function MonsterDebuggerConnectionDefault()
      {
         _queue = [];
         super();
         _socket = new Socket();
         _socket.addEventListener(Event.CONNECT,connectHandler,false,0,false);
         _socket.addEventListener(Event.CLOSE,closeHandler,false,0,false);
         _socket.addEventListener(IOErrorEvent.IO_ERROR,closeHandler,false,0,false);
         _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,closeHandler,false,0,false);
         _socket.addEventListener(ProgressEvent.SOCKET_DATA,dataHandler,false,0,false);
         _connecting = false;
         _process = false;
         _address = "127.0.0.1";
         _port = 5840;
         _timeout = new Timer(2000,1);
         _timeout.addEventListener(TimerEvent.TIMER,closeHandler,false,0,false);
         _retry = new Timer(1000,1);
         _retry.addEventListener(TimerEvent.TIMER,retryHandler,false,0,false);
      }
      
      private function dataHandler(event:ProgressEvent) : void
      {
         _bytes = new ByteArray();
         _socket.readBytes(_bytes,0,_socket.bytesAvailable);
         _bytes.position = 0;
         processPackage();
      }
      
      public function send(id:String, data:Object, direct:Boolean = false) : void
      {
         var bytes:ByteArray = null;
         if(direct && id == MonsterDebuggerCore.ID && _socket.connected)
         {
            bytes = new MonsterDebuggerData(id,data).bytes;
            _socket.writeUnsignedInt(bytes.length);
            _socket.writeBytes(bytes);
            _socket.flush();
            return;
         }
         _queue.push(new MonsterDebuggerData(id,data));
         if(_queue.length > MAX_QUEUE_LENGTH)
         {
            _queue.shift();
         }
         if(_queue.length > 0)
         {
            next();
         }
      }
      
      public function get connected() : Boolean
      {
         if(_socket == null)
         {
            return false;
         }
         return _socket.connected;
      }
      
      private function next() : void
      {
         if(!MonsterDebugger.enabled)
         {
            return;
         }
         if(!_process)
         {
            return;
         }
         if(!_socket.connected)
         {
            connect();
            return;
         }
         var bytes:ByteArray = MonsterDebuggerData(_queue.shift()).bytes;
         _socket.writeUnsignedInt(bytes.length);
         _socket.writeBytes(bytes);
         _socket.flush();
         bytes = null;
         if(_queue.length > 0)
         {
            next();
         }
      }
      
      private function retryHandler(event:TimerEvent) : void
      {
         _retry.stop();
         connect();
      }
      
      private function processPackage() : void
      {
         var l:uint = 0;
         var item:MonsterDebuggerData = null;
         if(_bytes.bytesAvailable == 0)
         {
            return;
         }
         if(_length == 0)
         {
            _length = _bytes.readUnsignedInt();
            _package = new ByteArray();
         }
         if(_package.length < _length && _bytes.bytesAvailable > 0)
         {
            l = _bytes.bytesAvailable;
            if(l > _length - _package.length)
            {
               l = _length - _package.length;
            }
            _bytes.readBytes(_package,_package.length,l);
         }
         if(_length != 0 && _package.length == _length)
         {
            item = MonsterDebuggerData.read(_package);
            if(item.id != null)
            {
               MonsterDebuggerCore.handle(item);
            }
            _length = 0;
            _package = null;
         }
         if(_length == 0 && _bytes.bytesAvailable > 0)
         {
            processPackage();
         }
      }
      
      public function set address(value:String) : void
      {
         _address = value;
      }
      
      private function connectHandler(event:Event) : void
      {
         _timeout.stop();
         _retry.stop();
         _connecting = false;
         _bytes = new ByteArray();
         _package = new ByteArray();
         _length = 0;
         _socket.writeUTFBytes("<hello/>" + "\n");
         _socket.writeByte(0);
         _socket.flush();
      }
      
      public function processQueue() : void
      {
         if(!_process)
         {
            _process = true;
            if(_queue.length > 0)
            {
               next();
            }
         }
      }
      
      private function closeHandler(event:Event = null) : void
      {
         MonsterDebuggerUtils.resume();
         if(!_retry.running)
         {
            _connecting = false;
            _process = false;
            _timeout.stop();
            _retry.reset();
            _retry.start();
         }
      }
      
      public function connect() : void
      {
         if(!_connecting && MonsterDebugger.enabled)
         {
            try
            {
               Security.loadPolicyFile("xmlsocket://" + _address + ":" + _port);
               _connecting = true;
               _socket.connect(_address,_port);
               _retry.stop();
               _timeout.reset();
               _timeout.start();
            }
            catch(e:Error)
            {
               closeHandler();
            }
         }
      }
   }
}
