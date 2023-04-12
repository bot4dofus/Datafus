package com.ankamagames.dofus.misc.utils.mapeditor
{
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.setTimeout;
   
   public class MapEditorConnector extends EventDispatcher
   {
       
      
      private const RETRY_INTERVAL:uint = 10000;
      
      private const EDITOR_PORT:uint = 9182;
      
      private const EDITOR_HOST:String = "127.0.0.1";
      
      private const HEAD_LENGTH:uint = 8;
      
      private const STEP_HEAD:uint = 0;
      
      private const STEP_BODY:uint = 1;
      
      private var _socket:Socket;
      
      private var _socktetInit:Boolean;
      
      private var _waitingForLength:uint = 8;
      
      private var _waitingForType:int = -1;
      
      private var _parsingState:uint = 0;
      
      private var _currentData:MapEditorMessage;
      
      public function MapEditorConnector()
      {
         super();
         setTimeout(this.init,1);
      }
      
      private function init() : void
      {
         this._socket = new Socket();
         this._socket.endian = Endian.BIG_ENDIAN;
         LogInFile.getInstance().logLine("ProcessInfos _socket.addEventListener onConnect",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("ProcessInfos _socket.addEventListener onClose",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("ProcessInfos _socket.addEventListener onData",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("ProcessInfos _socket.addEventListener onError",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("ProcessInfos _socket.addEventListener onSecurityError",FileLoggerEnum.EVENTLISTENERS);
         this._socket.addEventListener(Event.CONNECT,this.onConnect);
         this._socket.addEventListener(Event.CLOSE,this.onClose);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onData);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this.tryConnect();
      }
      
      private function tryConnect() : void
      {
         if(this._socket.connected)
         {
            return;
         }
         try
         {
            this._socket.connect(this.EDITOR_HOST,this.EDITOR_PORT);
         }
         catch(e:Error)
         {
            setTimeout(tryConnect,RETRY_INTERVAL);
         }
      }
      
      private function checkData() : void
      {
         if(!this._socktetInit)
         {
            this.getCrossDomain();
         }
         if(this._socket.bytesAvailable >= this._waitingForLength)
         {
            if(this._parsingState == this.STEP_HEAD)
            {
               this.parseHead();
            }
            else if(this._parsingState == this.STEP_BODY)
            {
               this.parseBody();
            }
         }
      }
      
      private function getCrossDomain() : void
      {
         if(this._socktetInit)
         {
            return;
         }
         while(this._socket.bytesAvailable && !this._socktetInit)
         {
            this._socktetInit = this._socket.readByte() == 0;
         }
      }
      
      private function parseHead() : void
      {
         this._waitingForLength = this._socket.readInt() - 4;
         this._currentData = new MapEditorMessage(this._socket.readInt());
         this._parsingState = this.STEP_BODY;
         this.checkData();
      }
      
      private function parseBody() : void
      {
         this._currentData.data = new ByteArray();
         this._socket.readBytes(this._currentData.data,0,this._waitingForLength);
         this._waitingForLength = this.HEAD_LENGTH;
         this._parsingState = this.STEP_HEAD;
         dispatchEvent(new MapEditorDataEvent(MapEditorDataEvent.NEW_DATA,this._currentData));
         this.checkData();
      }
      
      private function onSecurityError(e:Event) : void
      {
         LogInFile.getInstance().logLine("ProcessInfos onSecurityError",FileLoggerEnum.EVENTLISTENERS);
      }
      
      private function sayHello() : void
      {
         var helloMsg:MapEditorMessage = new MapEditorMessage(MapEditorMessage.MESSAGE_TYPE_HELLO);
         helloMsg.serialize(this._socket);
         this._socket.flush();
      }
      
      private function onConnect(e:Event) : void
      {
         LogInFile.getInstance().logLine("ProcessInfos onConnect",FileLoggerEnum.EVENTLISTENERS);
         this._socktetInit = false;
         dispatchEvent(new Event(Event.CONNECT));
         this.sayHello();
      }
      
      private function onClose(e:Event) : void
      {
         LogInFile.getInstance().logLine("ProcessInfos onClose",FileLoggerEnum.EVENTLISTENERS);
         dispatchEvent(new Event(Event.CLOSE));
         setTimeout(this.tryConnect,this.RETRY_INTERVAL);
      }
      
      private function onData(e:ProgressEvent) : void
      {
         LogInFile.getInstance().logLine("ProcessInfos onData",FileLoggerEnum.EVENTLISTENERS);
         dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA));
         this.checkData();
      }
      
      private function onError(e:IOErrorEvent) : void
      {
         LogInFile.getInstance().logLine("ProcessInfos onError",FileLoggerEnum.EVENTLISTENERS);
         setTimeout(this.tryConnect,this.RETRY_INTERVAL);
      }
   }
}
