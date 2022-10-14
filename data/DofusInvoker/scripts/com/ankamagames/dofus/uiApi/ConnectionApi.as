package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.servers.ServerWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.ServerCompletionEnum;
   import com.ankamagames.dofus.network.enums.ServerStatusEnum;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class ConnectionApi implements IApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConnectionApi));
       
      
      public function ConnectionApi()
      {
         super();
      }
      
      private function get serverSelectionFrame() : ServerSelectionFrame
      {
         return Kernel.getWorker().getFrame(ServerSelectionFrame) as ServerSelectionFrame;
      }
      
      public function getUsedServers() : Vector.<GameServerInformations>
      {
         return this.serverSelectionFrame.usedServers;
      }
      
      public function getServers() : Vector.<GameServerInformations>
      {
         return this.serverSelectionFrame.servers;
      }
      
      public function getAvailableSlotsByServerType() : Array
      {
         return this.serverSelectionFrame.availableSlotsByServerType;
      }
      
      public function isCharacterWaitingForChange(id:Number) : Boolean
      {
         var serverApproachFrame:GameServerApproachFrame = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
         if(serverApproachFrame)
         {
            return serverApproachFrame.isCharacterWaitingForChange(id);
         }
         return false;
      }
      
      public function allowAutoConnectCharacter(allow:Boolean) : void
      {
         PlayerManager.getInstance().allowAutoConnectCharacter = allow;
         PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
      }
      
      public function getAutoChosenServer(serverTypeId:int) : GameServerInformations
      {
         var server:Server = null;
         var serverInfo:GameServerInformations = null;
         var availableServers:Array = null;
         var playerCommunityServers:Vector.<ServerWrapper> = new Vector.<ServerWrapper>();
         var fallbackServers:Vector.<ServerWrapper> = new Vector.<ServerWrapper>();
         var isReleaseBuild:* = BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE;
         var playerCommunityId:int = PlayerManager.getInstance().communityId;
         for each(serverInfo in this.serverSelectionFrame.servers)
         {
            server = Server.getServerById(serverInfo.id);
            if(!server)
            {
               _log.warn("Missing Server data for serverId " + serverInfo.id);
            }
            else if(isReleaseBuild && server.name.indexOf("Test") != -1)
            {
               _log.warn("Ignoring server " + server.name + " as it\'s a test server");
            }
            else if(server.gameTypeId == serverTypeId && this.serverIsOnlineAndNotFull(serverInfo))
            {
               if(server.communityId == playerCommunityId || server.communityId == DataEnum.SERVER_COMMUNITY_ENGLISH_SPEAKING && playerCommunityId == DataEnum.SERVER_COMMUNITY_INTERNATIONAL_ALL_EXCEPT_FRENCH)
               {
                  playerCommunityServers.push(ServerWrapper.create(server,serverInfo));
               }
               else if(server.communityId == DataEnum.SERVER_COMMUNITY_INTERNATIONAL_ALL_EXCEPT_FRENCH)
               {
                  fallbackServers.push(ServerWrapper.create(server,serverInfo));
               }
            }
         }
         availableServers = this.getLowestPopulationServers(playerCommunityServers);
         if(availableServers.length == 0)
         {
            availableServers = this.getLowestPopulationServers(fallbackServers);
         }
         if(availableServers.length > 0)
         {
            return availableServers[Math.floor(Math.random() * availableServers.length)];
         }
         return null;
      }
      
      private function getLowestPopulationServers(serversList:Vector.<ServerWrapper>) : Array
      {
         var lowestPopulation:int = 0;
         var serverWrapper:ServerWrapper = null;
         var lowestPopulationServers:Array = new Array();
         if(serversList.length > 0)
         {
            serversList.sort(ServerWrapper.sortByPopulation);
            lowestPopulation = serversList[0].server.population.id;
            for each(serverWrapper in serversList)
            {
               if(serverWrapper.server.population.id != lowestPopulation)
               {
                  break;
               }
               lowestPopulationServers.push(serverWrapper.serverInfo);
            }
         }
         return lowestPopulationServers;
      }
      
      private function serverIsOnlineAndNotFull(serverInfo:GameServerInformations) : Boolean
      {
         return serverInfo.isSelectable && serverInfo.status == ServerStatusEnum.ONLINE && serverInfo.charactersCount < serverInfo.charactersSlots && serverInfo.completion <= ServerCompletionEnum.COMPLETION_HIGH;
      }
   }
}
