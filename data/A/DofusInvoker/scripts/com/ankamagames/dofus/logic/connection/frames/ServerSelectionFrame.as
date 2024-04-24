package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.BuildInfos;
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
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
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
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
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
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:ServersListMessage = null;
         var _loc3_:Frame = null;
         var _loc4_:ServerStatusUpdateMessage = null;
         var _loc5_:Boolean = false;
         var _loc6_:ServerSelectionAction = null;
         var _loc7_:SelectedServerDataExtendedMessage = null;
         var _loc8_:SelectedServerDataMessage = null;
         var _loc9_:ExpectedSocketClosureMessage = null;
         var _loc10_:String = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:uint = 0;
         var _loc13_:AcquaintanceSearchAction = null;
         var _loc14_:AcquaintanceSearchMessage = null;
         var _loc15_:AccountTagInformation = null;
         var _loc16_:AcquaintanceSearchErrorMessage = null;
         var _loc17_:String = null;
         var _loc18_:AcquaintanceServerListMessage = null;
         var _loc19_:SelectedServerRefusedMessage = null;
         var _loc20_:* = null;
         var _loc21_:MigratedServerListMessage = null;
         var _loc22_:ServerConnectionFailedMessage = null;
         var _loc23_:uint = 0;
         var _loc24_:GameServerInformations = null;
         var _loc25_:* = undefined;
         var _loc26_:ServerSelectionMessage = null;
         var _loc27_:* = null;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         switch(true)
         {
            case param1 is ServersListMessage:
               _loc2_ = param1 as ServersListMessage;
               PlayerManager.getInstance().server = null;
               this._serversList = _loc2_.servers;
               this._serversList.sort(serverDateSortFunction);
               _loc3_ = Kernel.getWorker().getFrame(InitializationFrame);
               if(_loc3_)
               {
                  Kernel.getWorker().removeFrame(_loc3_);
               }
               if(!Berilia.getInstance().uiList["CharacterHeader"])
               {
                  KernelEventsManager.getInstance().processCallback(HookList.AuthenticationTicketAccepted);
               }
               this.broadcastServersListUpdate();
               return true;
            case param1 is ServerStatusUpdateMessage:
               _loc4_ = param1 as ServerStatusUpdateMessage;
               _loc5_ = false;
               for each(_loc24_ in this._serversList)
               {
                  if(_loc4_.server.id == _loc24_.id)
                  {
                     _loc24_.charactersCount = _loc4_.server.charactersCount;
                     _loc24_.completion = _loc4_.server.completion;
                     _loc24_.isSelectable = _loc4_.server.isSelectable;
                     _loc24_.status = _loc4_.server.status;
                     _loc5_ = true;
                  }
               }
               if(!_loc5_)
               {
                  this._serversList.push(_loc4_.server);
                  this._serversList.sort(serverDateSortFunction);
               }
               _log.info("Server " + _loc4_.server.id + " status changed to " + _loc4_.server.status + ".");
               this.broadcastServersListUpdate();
               return true;
            case param1 is ServerSelectionAction:
               _loc6_ = param1 as ServerSelectionAction;
               for each(_loc25_ in this._serversList)
               {
                  if(_loc25_.id == _loc6_.serverId)
                  {
                     if(_loc25_.status == ServerStatusEnum.ONLINE || _loc25_.status == ServerStatusEnum.NOJOIN)
                     {
                        _loc26_ = new ServerSelectionMessage();
                        _loc26_.initServerSelectionMessage(_loc6_.serverId);
                        ConnectionsHandler.getConnection().send(_loc26_);
                        KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionStarted);
                     }
                     else
                     {
                        _loc27_ = "Status";
                        switch(_loc25_.status)
                        {
                           case ServerStatusEnum.OFFLINE:
                              _loc27_ += "Offline";
                              break;
                           case ServerStatusEnum.STARTING:
                              _loc27_ += "Starting";
                              break;
                           case ServerStatusEnum.SAVING:
                              _loc27_ += "Saving";
                              break;
                           case ServerStatusEnum.STOPING:
                              _loc27_ += "Stoping";
                              break;
                           case ServerStatusEnum.FULL:
                              _loc27_ += "Full";
                              break;
                           case ServerStatusEnum.STATUS_UNKNOWN:
                           default:
                              _loc27_ += "Unknown";
                        }
                        KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,_loc25_.id,_loc27_,this.getSelectableServers());
                     }
                  }
               }
               return true;
            case param1 is SelectedServerDataExtendedMessage:
               _loc7_ = param1 as SelectedServerDataExtendedMessage;
               this._serversList = _loc7_.servers;
               this._serversList.sort(serverDateSortFunction);
               this.broadcastServersListUpdate(true);
               break;
            case param1 is SelectedServerDataMessage:
               break;
            case param1 is ExpectedSocketClosureMessage:
               _loc9_ = param1 as ExpectedSocketClosureMessage;
               if(_loc9_.reason != DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER)
               {
                  this._worker.process(new WrongSocketClosureReasonMessage(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER,_loc9_.reason));
                  return true;
               }
               this._worker.addFrame(new GameServerApproachFrame());
               _loc10_ = BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL ? OptionManager.getOptionManager("dofus").getOption("connectionPort") : "";
               _loc11_ = this._selectedServer.ports;
               _loc12_ = this._selectedServer.ports[0];
               for each(_loc28_ in _loc11_)
               {
                  if(parseInt(_loc10_) == _loc28_)
                  {
                     _loc12_ = _loc28_;
                     break;
                  }
               }
               ConnectionsHandler.connectToGameServer(this._selectedServer.address,_loc12_);
               return true;
               break;
            case param1 is AcquaintanceSearchAction:
               _loc13_ = param1 as AcquaintanceSearchAction;
               _loc14_ = new AcquaintanceSearchMessage();
               _loc15_ = new AccountTagInformation();
               _loc15_.nickname = _loc13_.friendName;
               _loc15_.tagNumber = _loc13_.friendTag;
               _loc14_.initAcquaintanceSearchMessage(_loc15_);
               ConnectionsHandler.getConnection().send(_loc14_);
               return true;
            case param1 is AcquaintanceSearchErrorMessage:
               _loc16_ = param1 as AcquaintanceSearchErrorMessage;
               switch(_loc16_.reason)
               {
                  case 1:
                     _loc17_ = "unavailable";
                     break;
                  case 2:
                     _loc17_ = "no_result";
                     break;
                  case 3:
                     _loc17_ = "flood";
                     break;
                  case 0:
                  default:
                     _loc17_ = "unknown";
               }
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceSearchError,_loc17_);
               return true;
            case param1 is AcquaintanceServerListMessage:
               _loc18_ = param1 as AcquaintanceServerListMessage;
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceServerList,_loc18_.servers);
               return true;
            case param1 is SelectedServerRefusedMessage:
               _loc19_ = param1 as SelectedServerRefusedMessage;
               this._serversList.forEach(this.getUpdateServerStatusFunction(_loc19_.serverId,_loc19_.serverStatus));
               this.broadcastServersListUpdate();
               switch(_loc19_.error)
               {
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_DUE_TO_STATUS:
                     _loc20_ = "Status";
                     switch(_loc19_.serverStatus)
                     {
                        case ServerStatusEnum.OFFLINE:
                           _loc20_ += "Offline";
                           break;
                        case ServerStatusEnum.STARTING:
                           _loc20_ += "Starting";
                           break;
                        case ServerStatusEnum.NOJOIN:
                           _loc20_ += "Nojoin";
                           break;
                        case ServerStatusEnum.SAVING:
                           _loc20_ += "Saving";
                           break;
                        case ServerStatusEnum.STOPING:
                           _loc20_ += "Stoping";
                           break;
                        case ServerStatusEnum.FULL:
                           _loc20_ += "Full";
                           break;
                        case ServerStatusEnum.STATUS_UNKNOWN:
                        default:
                           _loc20_ += "Unknown";
                     }
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:
                     _loc20_ = "SubscribersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:
                     _loc20_ = "RegularPlayersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_MONOACCOUNT_CANNOT_VERIFY:
                     _loc20_ = "MonoaccountCannotVerify";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_MONOACCOUNT_ONLY:
                     _loc20_ = "MonoaccountOnly";
                     break;
                  case 9:
                     _loc20_ = "ServerFull";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_NO_REASON:
                  default:
                     _loc20_ = "NoReason";
               }
               KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,_loc19_.serverId,_loc20_,this.getSelectableServers());
               return true;
            case param1 is MigratedServerListMessage:
               _loc21_ = param1 as MigratedServerListMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MigratedServerList,_loc21_.migratedServerIds);
               return true;
            case param1 is ServerConnectionFailedMessage:
               _loc22_ = param1 as ServerConnectionFailedMessage;
               _loc23_ = _loc22_.failedConnection.port;
               _log.debug("Connection failed using port " + _loc23_);
               if(this._connexionPorts && this._connexionPorts.length)
               {
                  this._connexionPorts.splice(this._connexionPorts.indexOf(_loc23_),1);
                  if(this._connexionPorts.length)
                  {
                     _loc29_ = this._connexionPorts[0];
                     _log.debug("Connection new attempt, port " + this._connexionPorts);
                     _loc22_.failedConnection.tryConnectingOnAnotherPort(_loc29_);
                     return true;
                  }
                  return false;
               }
               return false;
               break;
            default:
               return false;
         }
         _loc8_ = param1 as SelectedServerDataMessage;
         ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER);
         this._selectedServer = _loc8_;
         AuthentificationManager.getInstance().gameServerTicket = AuthentificationManager.getInstance().decodeWithAES(_loc8_.ticket).toString();
         PlayerManager.getInstance().server = Server.getServerById(_loc8_.serverId);
         PlayerManager.getInstance().kisServerPort = 0;
         this._connexionPorts = [];
         for each(_loc28_ in _loc8_.ports)
         {
            this._connexionPorts.push(_loc28_);
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
   }
}
