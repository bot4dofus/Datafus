package com.ankamagames.dofus.kernel.net
{
   import com.ankamagames.berilia.frames.UiStatsFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.utils.LagometerAck;
   import com.ankamagames.dofus.logic.connection.frames.HandshakeFrame;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
   import com.ankamagames.dofus.network.MessageReceiver;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.jerakine.network.HttpServerConnection;
   import com.ankamagames.jerakine.network.IConnectionProxy;
   import com.ankamagames.jerakine.network.IServerConnection;
   import com.ankamagames.jerakine.network.MultiConnection;
   import com.ankamagames.jerakine.network.ProxyedServerConnection;
   import com.ankamagames.jerakine.network.ServerConnection;
   import com.ankamagames.jerakine.network.SnifferServerConnection;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class ConnectionsHandler
   {
      
      public static const GAME_SERVER:String = "game_server";
      
      public static const KOLI_SERVER:String = "koli_server";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConnectionsHandler));
      
      private static var _useSniffer:Boolean;
      
      private static var _currentConnection:MultiConnection;
      
      private static var _currentConnectionType:String;
      
      private static var _wantedSocketLost:Boolean;
      
      private static var _wantedSocketLostReason:uint;
      
      private static var _hasReceivedMsg:Boolean = false;
      
      private static var _hasReceivedNetworkMsg:Boolean = false;
      
      private static var _connectionTimeout:BenchmarkTimer;
      
      private static var _currentHttpConnection:HttpServerConnection = new HttpServerConnection();
       
      
      public function ConnectionsHandler()
      {
         super();
      }
      
      public static function get useSniffer() : Boolean
      {
         return _useSniffer;
      }
      
      public static function set useSniffer(sniffer:Boolean) : void
      {
         _useSniffer = sniffer;
      }
      
      public static function get connectionType() : String
      {
         return _currentConnectionType;
      }
      
      public static function get hasReceivedMsg() : Boolean
      {
         return _hasReceivedMsg;
      }
      
      public static function set hasReceivedMsg(value:Boolean) : void
      {
         _hasReceivedMsg = value;
      }
      
      public static function get hasReceivedNetworkMsg() : Boolean
      {
         return _hasReceivedNetworkMsg;
      }
      
      public static function set hasReceivedNetworkMsg(value:Boolean) : void
      {
         _hasReceivedNetworkMsg = value;
      }
      
      public static function getConnection() : MultiConnection
      {
         if(!_currentConnection)
         {
            createConnection();
         }
         return _currentConnection;
      }
      
      public static function getHttpConnection() : HttpServerConnection
      {
         if(!_currentHttpConnection.handler)
         {
            _currentHttpConnection.handler = Kernel.getWorker();
            _currentHttpConnection.rawParser = new MessageReceiver();
         }
         return _currentHttpConnection;
      }
      
      public static function connectToLoginServer(host:String, port:uint) : void
      {
         if(_currentConnection != null)
         {
            closeConnection();
         }
         etablishConnection(host,port,ConnectionType.TO_LOGIN_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_LOGIN_SERVER;
      }
      
      public static function connectToGameServer(gameServerHost:String, gameServerPort:uint) : void
      {
         startConnectionTimer();
         if(_currentConnection != null)
         {
            closeConnection();
         }
         etablishConnection(gameServerHost,gameServerPort,ConnectionType.TO_GAME_SERVER,_useSniffer);
         UiStatsFrame.setStat("gameServerPort",gameServerPort);
         _currentConnectionType = ConnectionType.TO_GAME_SERVER;
         PlayerManager.getInstance().gameServerPort = gameServerPort;
      }
      
      public static function connectToKoliServer(gameServerHost:String, gameServerPort:uint) : void
      {
         startConnectionTimer();
         if(_currentConnection != null && _currentConnection.getSubConnection(ConnectionType.TO_KOLI_SERVER))
         {
            _currentConnection.close(ConnectionType.TO_KOLI_SERVER);
         }
         etablishConnection(gameServerHost,gameServerPort,ConnectionType.TO_KOLI_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_KOLI_SERVER;
         PlayerManager.getInstance().kisServerPort = gameServerPort;
      }
      
      public static function confirmGameServerConnection() : void
      {
         stopConnectionTimer();
      }
      
      public static function onConnectionTimeout(e:TimerEvent) : void
      {
         var msg:BasicPingMessage = null;
         if(_currentConnection && _currentConnection.connected)
         {
            msg = new BasicPingMessage();
            msg.initBasicPingMessage(true);
            _log.warn("La connection au serveur de jeu semble longue. On envoit un BasicPingMessage pour essayer de débloquer la situation.");
            _currentConnection.send(msg,_currentConnectionType);
            stopConnectionTimer();
         }
      }
      
      public static function closeConnection() : void
      {
         if(Kernel.getWorker().contains(HandshakeFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(HandshakeFrame));
         }
         if(_currentConnection && _currentConnection.connected)
         {
            _currentConnection.close();
         }
         _currentConnection = null;
         _currentConnectionType = ConnectionType.DISCONNECTED;
      }
      
      public static function handleDisconnection() : DisconnectionReason
      {
         closeConnection();
         var reason:DisconnectionReason = new DisconnectionReason(_wantedSocketLost,_wantedSocketLostReason);
         _wantedSocketLost = false;
         _wantedSocketLostReason = DisconnectionReasonEnum.UNEXPECTED;
         if(!reason.expected)
         {
            ChatServiceManager.destroy();
         }
         return reason;
      }
      
      public static function connectionGonnaBeClosed(expectedReason:uint) : void
      {
         _wantedSocketLostReason = expectedReason;
         _wantedSocketLost = true;
      }
      
      public static function pause() : void
      {
         _log.info("Pause connection");
         _currentConnection.pause();
      }
      
      public static function resume() : void
      {
         _log.info("Resume connection");
         if(_currentConnection)
         {
            _currentConnection.resume();
         }
         Kernel.getWorker().process(new ConnectionResumedMessage());
      }
      
      private static function startConnectionTimer() : void
      {
         if(!_connectionTimeout)
         {
            _connectionTimeout = new BenchmarkTimer(4000,1,"ConnectionsHandler._connectionTimeout (connectToKoliServer)");
            _connectionTimeout.addEventListener(TimerEvent.TIMER,onConnectionTimeout);
         }
         else
         {
            _connectionTimeout.reset();
         }
         _connectionTimeout.start();
      }
      
      private static function stopConnectionTimer() : void
      {
         if(_connectionTimeout)
         {
            _connectionTimeout.stop();
            _connectionTimeout.removeEventListener(TimerEvent.TIMER,onConnectionTimeout);
         }
      }
      
      private static function etablishConnection(host:String, port:int, id:String, useSniffer:Boolean = false, proxy:IConnectionProxy = null) : void
      {
         var conn:IServerConnection = null;
         if(useSniffer)
         {
            if(proxy != null)
            {
               throw new ArgumentError("Can\'t etablish a connection using a proxy and the sniffer.");
            }
            conn = new SnifferServerConnection(null,0,id);
         }
         else if(proxy != null)
         {
            conn = new ProxyedServerConnection(proxy,null,0,id);
         }
         else
         {
            conn = new ServerConnection(null,0,id);
         }
         if(!_currentConnection)
         {
            createConnection();
         }
         conn.lagometer = new LagometerAck();
         conn.handler = Kernel.getWorker();
         conn.rawParser = new MessageReceiver();
         _currentConnection.addConnection(conn,id);
         _currentConnection.mainConnection = conn;
         Kernel.getWorker().addFrame(new HandshakeFrame());
         conn.connect(host,port);
      }
      
      private static function createConnection() : void
      {
         _currentConnection = new MultiConnection();
      }
   }
}
