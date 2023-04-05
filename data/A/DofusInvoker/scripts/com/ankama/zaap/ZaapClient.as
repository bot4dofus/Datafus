package com.ankama.zaap
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import org.apache.thrift.protocol.TBinaryProtocol;
   import org.apache.thrift.protocol.TProtocol;
   
   public class ZaapClient extends EventDispatcher
   {
       
      
      public var client:ZaapService;
      
      public var connection:TFixedSocket;
      
      public var session:String;
      
      private var _port:int;
      
      private var _gameName:String;
      
      private var _gameRelease:String;
      
      private var _instanceId:int;
      
      private var _hash:String;
      
      private var _onConnectErrorCallback:Function;
      
      private var _onConnectSuccessCallback:Function;
      
      private var _onConnectClosedCallback:Function;
      
      public function ZaapClient()
      {
         super();
      }
      
      public function connect(param1:int, param2:String, param3:String, param4:int, param5:String, param6:Function, param7:Function, param8:Function) : void
      {
         this._port = param1;
         this._gameName = param2;
         this._gameRelease = param3;
         this._instanceId = param4;
         this._hash = param5;
         this._onConnectErrorCallback = param6;
         this._onConnectSuccessCallback = param7;
         this._onConnectClosedCallback = param8;
         this.connection = new TFixedSocket("localhost",this._port);
         this.connection.addEventListener(Event.CONNECT,this.onSocketConnected);
         this.connection.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketError);
         this.connection.addEventListener(Event.CLOSE,this.onSocketClosed);
         this.connection.open();
      }
      
      public function disconnect() : void
      {
         if(this.connection && this.connection.isOpen())
         {
            this.connection.close();
         }
         this.client = null;
         this.connection = null;
         this.session = null;
         this._port = 0;
         this._gameName = null;
         this._gameRelease = null;
         this._instanceId = 0;
         this._hash = null;
         this._onConnectErrorCallback = null;
         this._onConnectSuccessCallback = null;
         this._onConnectClosedCallback = null;
      }
      
      private function onSocketConnected(param1:Event) : void
      {
         var e:Event = param1;
         this.removeSocketEventListeners();
         var protocol:TProtocol = new TBinaryProtocol(this.connection);
         this.client = new ZaapServiceImpl(protocol);
         this.client.connect(this._gameName,this._gameRelease,this._instanceId,this._hash,this.onConnectError,function(param1:String):void
         {
            session = param1;
            if(_onConnectSuccessCallback != null)
            {
               _onConnectSuccessCallback();
            }
         });
      }
      
      private function onConnectError(param1:Error) : void
      {
         this.onSocketError(new ErrorEvent(param1.name,false,false,param1.message,param1.errorID));
      }
      
      private function onSocketClosed(param1:Event) : void
      {
         this.removeSocketEventListeners();
         if(this._onConnectClosedCallback != null)
         {
            this._onConnectClosedCallback(param1);
         }
         this.disconnect();
      }
      
      private function onSocketError(param1:Event) : void
      {
         this.removeSocketEventListeners();
         if(this._onConnectErrorCallback != null)
         {
            this._onConnectErrorCallback(param1);
         }
         this.disconnect();
      }
      
      private function removeSocketEventListeners() : void
      {
         this.connection.removeEventListener(Event.CONNECT,this.onSocketConnected);
         this.connection.removeEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         this.connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketError);
         this.connection.removeEventListener(Event.CLOSE,this.onSocketError);
      }
   }
}
