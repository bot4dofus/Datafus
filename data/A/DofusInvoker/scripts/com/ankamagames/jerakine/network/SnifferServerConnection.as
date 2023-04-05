package com.ankamagames.jerakine.network
{
   import flash.events.Event;
   
   public class SnifferServerConnection extends ServerConnection implements IServerConnection
   {
      
      private static var _snifferHost:String;
      
      private static var _snifferPort:int;
       
      
      private var _targetHost:String;
      
      private var _targetPort:int;
      
      public function SnifferServerConnection(host:String = null, port:int = 0, id:String = "")
      {
         super(null,0,id);
         if(host != null && port != 0)
         {
            this.connect(host,port);
         }
      }
      
      public static function get snifferHost() : String
      {
         return _snifferHost;
      }
      
      public static function set snifferHost(host:String) : void
      {
         _snifferHost = host;
      }
      
      public static function get snifferPort() : int
      {
         return _snifferPort;
      }
      
      public static function set snifferPort(port:int) : void
      {
         _snifferPort = port;
      }
      
      override public function connect(host:String, port:int) : void
      {
         if(_snifferHost == null || _snifferPort == 0)
         {
            throw new NetworkError("Can\'t connect using an analyzer-proxy without host and port for this proxy.");
         }
         this._targetHost = host;
         this._targetPort = port;
         super.connect(_snifferHost,_snifferPort);
      }
      
      override protected function onConnect(e:Event) : void
      {
         _socket.writeUTF(this._targetHost);
         _socket.writeUnsignedInt(this._targetPort);
         super.onConnect(e);
      }
   }
}
