package com.ankama.zaap
{
   import flash.errors.EOFError;
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import org.apache.thrift.transport.TTransport;
   import org.apache.thrift.transport.TTransportError;
   
   public class TFixedSocket extends TTransport
   {
       
      
      private var socket:Socket = null;
      
      private var host:String;
      
      private var port:int;
      
      private var obuffer:ByteArray;
      
      private var input:IDataInput;
      
      private var output:IDataOutput;
      
      private var ioCallback:Function = null;
      
      private var eventDispatcher:EventDispatcher;
      
      public function TFixedSocket(param1:String, param2:int)
      {
         this.obuffer = new ByteArray();
         this.eventDispatcher = new EventDispatcher();
         super();
         this.host = param1;
         this.port = param2;
      }
      
      override public function close() : void
      {
         this.input = null;
         this.output = null;
         this.socket.close();
      }
      
      override public function peek() : Boolean
      {
         if(this.socket.connected)
         {
            return this.socket.bytesAvailable > 0;
         }
         return false;
      }
      
      override public function read(param1:ByteArray, param2:int, param3:int) : int
      {
         var buf:ByteArray = param1;
         var off:int = param2;
         var len:int = param3;
         try
         {
            this.input.readBytes(buf,off,len);
         }
         catch(e:EOFError)
         {
            throw new TTransportError(TTransportError.END_OF_FILE,"No more data available.");
         }
         catch(e:IOError)
         {
            if(isOpen())
            {
               throw new TTransportError(TTransportError.UNKNOWN,"IO error while reading: " + e);
            }
            throw new TTransportError(TTransportError.NOT_OPEN,"Socket seem not to be opened: " + e);
         }
         catch(e:Error)
         {
            throw new TTransportError(TTransportError.UNKNOWN,"Bad IO error: " + e);
         }
         return len;
      }
      
      override public function write(param1:ByteArray, param2:int, param3:int) : void
      {
         this.obuffer.writeBytes(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      override public function open() : void
      {
         this.socket = new Socket();
         this.socket.addEventListener(Event.CONNECT,this.socketConnected);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.socketError);
         this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.socketSecurityError);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.socketDataHandler);
         this.socket.addEventListener(Event.CLOSE,this.socketClosed);
         this.socket.connect(this.host,this.port);
      }
      
      public function socketConnected(param1:Event) : void
      {
         this.output = this.socket;
         this.input = this.socket;
         this.eventDispatcher.dispatchEvent(param1);
      }
      
      public function socketError(param1:IOErrorEvent) : void
      {
         this.close();
         if(this.ioCallback != null)
         {
            this.ioCallback(new TTransportError(TTransportError.UNKNOWN,"IOError: " + param1.text));
         }
         this.eventDispatcher.dispatchEvent(param1);
      }
      
      public function socketSecurityError(param1:SecurityErrorEvent) : void
      {
         this.close();
         this.eventDispatcher.dispatchEvent(param1);
      }
      
      public function socketClosed(param1:Event) : void
      {
         this.input = null;
         this.output = null;
         this.eventDispatcher.dispatchEvent(param1);
      }
      
      public function socketDataHandler(param1:ProgressEvent) : void
      {
         if(this.ioCallback != null)
         {
            this.ioCallback(null);
         }
         this.eventDispatcher.dispatchEvent(param1);
      }
      
      override public function flush(param1:Function = null) : void
      {
         this.ioCallback = param1;
         this.output.writeBytes(this.obuffer);
         this.socket.flush();
         this.obuffer.clear();
      }
      
      override public function isOpen() : Boolean
      {
         return this.socket == null ? false : Boolean(this.socket.connected);
      }
   }
}
