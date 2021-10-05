package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.KoliseumMessageRouter;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketAcceptedMessage;
   import com.ankamagames.dofus.network.messages.game.approach.AuthenticationTicketMessage;
   import com.ankamagames.dofus.network.messages.game.approach.HelloGameMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedForceReadyMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharacterSelectedSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.character.choice.CharactersListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaSwitchToFightServerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaSwitchToGameServerMessage;
   import com.ankamagames.dofus.network.messages.game.initialization.CharacterLoadingCompleteMessage;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class ServerTransferFrame extends RegisteringFrame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerTransferFrame));
       
      
      private var _newServerLoginTicket:String;
      
      private var _originePlayerId:Number;
      
      private var _lastResultMsg:GameFightEndMessage;
      
      private var _connexionPorts:Array;
      
      public function ServerTransferFrame()
      {
         super();
         _priority = Priority.HIGHEST;
      }
      
      override public function pushed() : Boolean
      {
         return true;
      }
      
      override public function pulled() : Boolean
      {
         return true;
      }
      
      override protected function registerMessages() : void
      {
         register(HelloGameMessage,this.onHelloGameMessage);
         register(AuthenticationTicketAcceptedMessage,this.onAuthenticationTicketAcceptedMessage);
         register(CharacterSelectedForceMessage,this.onCharacterSelectedForceMessage);
         register(CharacterSelectedSuccessMessage,this.onCharacterSelectedSuccessMessage);
         register(CharacterLoadingCompleteMessage,this.onCharacterLoadingCompleteMessage);
         register(GameRolePlayArenaSwitchToFightServerMessage,this.onGameRolePlayArenaSwitchToFightServerMessage);
         register(GameRolePlayArenaSwitchToGameServerMessage,this.onGameRolePlayArenaSwitchToGameServerMessage);
         register(GameFightEndMessage,this.onGameFightEndMessage);
         register(ServerConnectionFailedMessage,this.onServerConnectionFailedMessage);
      }
      
      protected function getConnectionType(msg:Message) : String
      {
         return ConnectionsHandler.getConnection().getConnectionId(msg);
      }
      
      private function onCharacterSelectedForceMessage(msg:CharacterSelectedForceMessage) : void
      {
         ConnectionsHandler.getConnection().send(new CharacterSelectedForceReadyMessage());
      }
      
      private function onCharacterSelectedSuccessMessage(msg:CharacterSelectedSuccessMessage) : void
      {
         PlayedCharacterManager.getInstance().infos = msg.infos;
      }
      
      private function onHelloGameMessage(msg:HelloGameMessage) : Boolean
      {
         var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
         var authMsg:AuthenticationTicketMessage = new AuthenticationTicketMessage();
         authMsg.initAuthenticationTicketMessage(lang,this._newServerLoginTicket);
         switch(this.getConnectionType(msg))
         {
            case ConnectionType.TO_KOLI_SERVER:
               ConnectionsHandler.getConnection().messageRouter = new KoliseumMessageRouter();
               break;
            case ConnectionType.TO_GAME_SERVER:
               ConnectionsHandler.getConnection().messageRouter = null;
         }
         ConnectionsHandler.getConnection().send(authMsg);
         return true;
      }
      
      private function onAuthenticationTicketAcceptedMessage(msg:AuthenticationTicketAcceptedMessage) : Boolean
      {
         var clr:CharactersListRequestMessage = null;
         switch(this.getConnectionType(msg))
         {
            case ConnectionType.TO_KOLI_SERVER:
               clr = new CharactersListRequestMessage();
               clr.initCharactersListRequestMessage();
               ConnectionsHandler.getConnection().send(clr);
               return true;
            default:
               return false;
         }
      }
      
      private function onCharacterLoadingCompleteMessage(msg:CharacterLoadingCompleteMessage) : Boolean
      {
         var gccrm:GameContextCreateRequestMessage = null;
         switch(this.getConnectionType(msg))
         {
            case ConnectionType.TO_KOLI_SERVER:
               gccrm = new GameContextCreateRequestMessage();
               gccrm.initGameContextCreateRequestMessage();
               ConnectionsHandler.getConnection().send(gccrm);
               return true;
            default:
               return false;
         }
      }
      
      private function onGameRolePlayArenaSwitchToFightServerMessage(msg:GameRolePlayArenaSwitchToFightServerMessage) : Boolean
      {
         var port:uint = 0;
         this._connexionPorts = new Array();
         for each(port in msg.ports)
         {
            this._connexionPorts.push(port);
         }
         _log.debug("Switch to fight server using ports : " + this._connexionPorts);
         if(!ConnectionsHandler.getConnection().getSubConnection(ConnectionType.TO_KOLI_SERVER))
         {
            this._originePlayerId = PlayedCharacterManager.getInstance().id;
         }
         this._newServerLoginTicket = AuthentificationManager.getInstance().decodeWithAES(msg.ticket).toString();
         ConnectionsHandler.connectToKoliServer(msg.address,msg.ports[0]);
         return true;
      }
      
      private function onGameRolePlayArenaSwitchToGameServerMessage(msg:GameRolePlayArenaSwitchToGameServerMessage) : Boolean
      {
         var synchronisationFrameInstance:SynchronisationFrame = Kernel.getWorker().getFrame(SynchronisationFrame) as SynchronisationFrame;
         synchronisationFrameInstance.resetSynchroStepByServer(ConnectionType.TO_KOLI_SERVER);
         ConnectionsHandler.getConnection().close(ConnectionType.TO_KOLI_SERVER);
         ConnectionsHandler.getConnection().messageRouter = null;
         PlayerManager.getInstance().kisServerPort = 0;
         return true;
      }
      
      private function onGameFightEndMessage(msg:GameFightEndMessage) : void
      {
         this._lastResultMsg = msg;
      }
      
      private function onServerConnectionFailedMessage(msg:ServerConnectionFailedMessage) : Boolean
      {
         var newPort:uint = 0;
         var formerPort:uint = msg.failedConnection.port;
         _log.debug("Connection failed using port " + formerPort);
         if(this._connexionPorts && this._connexionPorts.length)
         {
            this._connexionPorts.splice(this._connexionPorts.indexOf(formerPort),1);
            if(this._connexionPorts.length)
            {
               newPort = this._connexionPorts[0];
               _log.debug("Connection new attempt, port " + this._connexionPorts);
               msg.failedConnection.tryConnectingOnAnotherPort(newPort);
            }
            return true;
         }
         return true;
      }
   }
}
