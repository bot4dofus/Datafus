package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ServerConnectionErrorEnum;
   import com.ankamagames.dofus.network.enums.ServerStatusEnum;
   import com.ankamagames.dofus.network.messages.connection.MigratedServerListMessage;
   import com.ankamagames.dofus.network.messages.connection.SelectedServerDataExtendedMessage;
   import com.ankamagames.dofus.network.messages.connection.SelectedServerDataMessage;
   import com.ankamagames.dofus.network.messages.connection.SelectedServerRefusedMessage;
   import com.ankamagames.dofus.network.messages.connection.ServerSelectionMessage;
   import com.ankamagames.dofus.network.messages.connection.ServerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.connection.ServersListMessage;
   import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceSearchErrorMessage;
   import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceSearchMessage;
   import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceServerListMessage;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class ServerSelectionFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSelectionFrame));
       
      
      private var _serversList:Vector.<GameServerInformations>;
      
      private var _serversUsedList:Vector.<GameServerInformations>;
      
      private var _serversTypeAvailableSlots:Array;
      
      private var _selectedServer:SelectedServerDataMessage;
      
      private var _worker:Worker;
      
      private var _alreadyConnectedToServerId:int = 0;
      
      private var _serverSelectionAction:ServerSelectionAction;
      
      private var _connexionPorts:Array;
      
      public function ServerSelectionFrame()
      {
         this._serversTypeAvailableSlots = [];
         super();
      }
      
      private static function serverDateSortFunction(a:GameServerInformations, b:GameServerInformations) : Number
      {
         if(a.date < b.date)
         {
            return 1;
         }
         if(a.date == b.date)
         {
            return 0;
         }
         return -1;
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get usedServers() : Vector.<GameServerInformations>
      {
         return this._serversUsedList;
      }
      
      public function get servers() : Vector.<GameServerInformations>
      {
         return this._serversList;
      }
      
      public function get availableSlotsByServerType() : Array
      {
         return this._serversTypeAvailableSlots;
      }
      
      public function pushed() : Boolean
      {
         this._worker = Kernel.getWorker();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var slmsg:ServersListMessage = null;
         var initFrame:Frame = null;
         var ssumsg:ServerStatusUpdateMessage = null;
         var serverHasBeenUpdated:Boolean = false;
         var ssaction:ServerSelectionAction = null;
         var ssdemsg:SelectedServerDataExtendedMessage = null;
         var ssdmsg:SelectedServerDataMessage = null;
         var escmsg:ExpectedSocketClosureMessage = null;
         var asaction:AcquaintanceSearchAction = null;
         var asmsg:AcquaintanceSearchMessage = null;
         var accountTag:AccountTagInformation = null;
         var asemsg:AcquaintanceSearchErrorMessage = null;
         var reasonSearchError:String = null;
         var aslmsg:AcquaintanceServerListMessage = null;
         var ssrmsg:SelectedServerRefusedMessage = null;
         var error:* = null;
         var mslm:MigratedServerListMessage = null;
         var knownServer:GameServerInformations = null;
         var serverAlreadyInName:String = null;
         var serverSelectedName:String = null;
         var commonMod:Object = null;
         var server:* = undefined;
         var ssmsg:ServerSelectionMessage = null;
         var errorText:* = null;
         var port:uint = 0;
         var scfm:ServerConnectionFailedMessage = null;
         var formerPort:uint = 0;
         var newPort:uint = 0;
         switch(true)
         {
            case msg is ServersListMessage:
               slmsg = msg as ServersListMessage;
               PlayerManager.getInstance().server = null;
               this._serversList = slmsg.servers;
               this._serversList.sort(serverDateSortFunction);
               this._alreadyConnectedToServerId = slmsg.alreadyConnectedToServerId;
               initFrame = Kernel.getWorker().getFrame(InitializationFrame);
               if(initFrame)
               {
                  Kernel.getWorker().removeFrame(initFrame);
               }
               if(!Berilia.getInstance().uiList["CharacterHeader"])
               {
                  KernelEventsManager.getInstance().processCallback(HookList.AuthenticationTicketAccepted);
               }
               this.broadcastServersListUpdate();
               return true;
            case msg is ServerStatusUpdateMessage:
               ssumsg = msg as ServerStatusUpdateMessage;
               serverHasBeenUpdated = false;
               for each(knownServer in this._serversList)
               {
                  if(ssumsg.server.id == knownServer.id)
                  {
                     knownServer.charactersCount = ssumsg.server.charactersCount;
                     knownServer.completion = ssumsg.server.completion;
                     knownServer.isSelectable = ssumsg.server.isSelectable;
                     knownServer.status = ssumsg.server.status;
                     serverHasBeenUpdated = true;
                  }
               }
               if(!serverHasBeenUpdated)
               {
                  this._serversList.push(ssumsg.server);
                  this._serversList.sort(serverDateSortFunction);
               }
               _log.info("Server " + ssumsg.server.id + " status changed to " + ssumsg.server.status + ".");
               this.broadcastServersListUpdate();
               return true;
            case msg is ServerSelectionAction:
               ssaction = msg as ServerSelectionAction;
               if(this._alreadyConnectedToServerId > 0 && ssaction.serverId != this._alreadyConnectedToServerId)
               {
                  this._serverSelectionAction = ssaction;
                  serverAlreadyInName = Server.getServerById(this._alreadyConnectedToServerId).name;
                  serverSelectedName = Server.getServerById(ssaction.serverId).name;
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.server.alreadyInFightOnAnotherServer",[serverAlreadyInName,serverSelectedName]),[I18n.getUiText("ui.common.ok"),I18n.getUiText("ui.common.cancel")],[this.onValidServerSelection,this.onCancelServerSelection],this.onValidServerSelection,this.onCancelServerSelection);
                  return true;
               }
               for each(server in this._serversList)
               {
                  if(server.id == ssaction.serverId)
                  {
                     if(server.status == ServerStatusEnum.ONLINE || server.status == ServerStatusEnum.NOJOIN)
                     {
                        ssmsg = new ServerSelectionMessage();
                        ssmsg.initServerSelectionMessage(ssaction.serverId);
                        ConnectionsHandler.getConnection().send(ssmsg);
                        KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionStarted);
                     }
                     else
                     {
                        errorText = "Status";
                        switch(server.status)
                        {
                           case ServerStatusEnum.OFFLINE:
                              errorText += "Offline";
                              break;
                           case ServerStatusEnum.STARTING:
                              errorText += "Starting";
                              break;
                           case ServerStatusEnum.SAVING:
                              errorText += "Saving";
                              break;
                           case ServerStatusEnum.STOPING:
                              errorText += "Stoping";
                              break;
                           case ServerStatusEnum.FULL:
                              errorText += "Full";
                              break;
                           case ServerStatusEnum.STATUS_UNKNOWN:
                           default:
                              errorText += "Unknown";
                        }
                        KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,server.id,errorText,this.getSelectableServers());
                     }
                  }
               }
               return true;
               break;
            case msg is SelectedServerDataExtendedMessage:
               ssdemsg = msg as SelectedServerDataExtendedMessage;
               this._serversList = ssdemsg.servers;
               this._serversList.sort(serverDateSortFunction);
               this.broadcastServersListUpdate(true);
               break;
            case msg is SelectedServerDataMessage:
               break;
            case msg is ExpectedSocketClosureMessage:
               escmsg = msg as ExpectedSocketClosureMessage;
               if(escmsg.reason != DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER)
               {
                  this._worker.process(new WrongSocketClosureReasonMessage(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER,escmsg.reason));
                  return true;
               }
               this._worker.addFrame(new GameServerApproachFrame());
               ConnectionsHandler.connectToGameServer(this._selectedServer.address,this._selectedServer.ports[0]);
               return true;
               break;
            case msg is AcquaintanceSearchAction:
               asaction = msg as AcquaintanceSearchAction;
               asmsg = new AcquaintanceSearchMessage();
               accountTag = new AccountTagInformation();
               accountTag.nickname = asaction.friendName;
               accountTag.tagNumber = asaction.friendTag;
               asmsg.initAcquaintanceSearchMessage(accountTag);
               ConnectionsHandler.getConnection().send(asmsg);
               return true;
            case msg is AcquaintanceSearchErrorMessage:
               asemsg = msg as AcquaintanceSearchErrorMessage;
               switch(asemsg.reason)
               {
                  case 1:
                     reasonSearchError = "unavailable";
                     break;
                  case 2:
                     reasonSearchError = "no_result";
                     break;
                  case 3:
                     reasonSearchError = "flood";
                     break;
                  case 0:
                  default:
                     reasonSearchError = "unknown";
               }
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceSearchError,reasonSearchError);
               return true;
            case msg is AcquaintanceServerListMessage:
               aslmsg = msg as AcquaintanceServerListMessage;
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceServerList,aslmsg.servers);
               return true;
            case msg is SelectedServerRefusedMessage:
               ssrmsg = msg as SelectedServerRefusedMessage;
               this._serversList.forEach(this.getUpdateServerStatusFunction(ssrmsg.serverId,ssrmsg.serverStatus));
               this.broadcastServersListUpdate();
               switch(ssrmsg.error)
               {
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_DUE_TO_STATUS:
                     error = "Status";
                     switch(ssrmsg.serverStatus)
                     {
                        case ServerStatusEnum.OFFLINE:
                           error += "Offline";
                           break;
                        case ServerStatusEnum.STARTING:
                           error += "Starting";
                           break;
                        case ServerStatusEnum.NOJOIN:
                           error += "Nojoin";
                           break;
                        case ServerStatusEnum.SAVING:
                           error += "Saving";
                           break;
                        case ServerStatusEnum.STOPING:
                           error += "Stoping";
                           break;
                        case ServerStatusEnum.FULL:
                           error += "Full";
                           break;
                        case ServerStatusEnum.STATUS_UNKNOWN:
                        default:
                           error += "Unknown";
                     }
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:
                     error = "AccountRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_COMMUNITY_RESTRICTED:
                     error = "CommunityRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_LOCATION_RESTRICTED:
                     error = "LocationRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:
                     error = "SubscribersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:
                     error = "RegularPlayersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_MONOACCOUNT_CANNOT_VERIFY:
                     error = "MonoaccountCannotVerify";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_MONOACCOUNT_ONLY:
                     error = "MonoaccountOnly";
                     break;
                  case 9:
                     error = "ServerFull";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_NO_REASON:
                  default:
                     error = "NoReason";
               }
               KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,ssrmsg.serverId,error,this.getSelectableServers());
               return true;
            case msg is MigratedServerListMessage:
               mslm = msg as MigratedServerListMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MigratedServerList,mslm.migratedServerIds);
               return true;
            case msg is ServerConnectionFailedMessage:
               scfm = msg as ServerConnectionFailedMessage;
               formerPort = scfm.failedConnection.port;
               _log.debug("Connection failed using port " + formerPort);
               if(this._connexionPorts && this._connexionPorts.length)
               {
                  this._connexionPorts.splice(this._connexionPorts.indexOf(formerPort),1);
                  if(this._connexionPorts.length)
                  {
                     newPort = this._connexionPorts[0];
                     _log.debug("Connection new attempt, port " + this._connexionPorts);
                     scfm.failedConnection.tryConnectingOnAnotherPort(newPort);
                     return true;
                  }
                  return false;
               }
               return false;
               break;
            default:
               return false;
         }
         ssdmsg = msg as SelectedServerDataMessage;
         ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER);
         this._selectedServer = ssdmsg;
         AuthentificationManager.getInstance().gameServerTicket = AuthentificationManager.getInstance().decodeWithAES(ssdmsg.ticket).toString();
         PlayerManager.getInstance().server = Server.getServerById(ssdmsg.serverId);
         PlayerManager.getInstance().kisServerPort = 0;
         this._connexionPorts = [];
         for each(port in ssdmsg.ports)
         {
            this._connexionPorts.push(port);
         }
         _log.debug("Connection to game server using ports : " + this._connexionPorts);
         return true;
      }
      
      public function pulled() : Boolean
      {
         this._serversList = null;
         this._serversUsedList = null;
         this._selectedServer = null;
         this._worker = null;
         return true;
      }
      
      private function getSelectableServers() : Array
      {
         var server:* = undefined;
         var selectableServers:Array = new Array();
         for each(server in this._serversList)
         {
            if(server.status == ServerStatusEnum.ONLINE && server.isSelectable)
            {
               selectableServers.push(server.id);
            }
         }
         return selectableServers;
      }
      
      private function broadcastServersListUpdate(silent:Boolean = false) : void
      {
         var server:Object = null;
         this._serversTypeAvailableSlots = new Array();
         this._serversUsedList = new Vector.<GameServerInformations>();
         PlayerManager.getInstance().serversList = new Vector.<int>();
         for each(server in this._serversList)
         {
            if(!this._serversTypeAvailableSlots[server.type])
            {
               this._serversTypeAvailableSlots[server.type] = 0;
            }
            if(server.charactersCount < server.charactersSlots)
            {
               this._serversTypeAvailableSlots[server.type] = 1;
            }
            if(server.charactersCount > 0)
            {
               this._serversUsedList.push(server);
               PlayerManager.getInstance().serversList.push(server.id);
            }
         }
         if(!silent)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ServersList,this._serversList);
         }
      }
      
      private function getUpdateServerStatusFunction(serverId:uint, newStatus:uint) : Function
      {
         return function(element:*, index:int, arr:Vector.<GameServerInformations>):void
         {
            var gsi:* = element as GameServerInformations;
            if(serverId == gsi.id)
            {
               gsi.status = newStatus;
            }
         };
      }
      
      private function onValidServerSelection() : void
      {
         this._alreadyConnectedToServerId = 0;
         this.process(this._serverSelectionAction);
         this._serverSelectionAction = null;
      }
      
      private function onCancelServerSelection() : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,this._serverSelectionAction.serverId,"",this.getSelectableServers());
         this._serverSelectionAction = null;
      }
   }
}
