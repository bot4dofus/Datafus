package com.ankamagames.dofus.internalDatacenter.servers
{
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   
   public class ServerWrapper
   {
       
      
      private var _server:Server;
      
      private var _serverInfo:GameServerInformations;
      
      public function ServerWrapper()
      {
         super();
      }
      
      public static function create(server:Server, serverInfo:GameServerInformations) : ServerWrapper
      {
         var w:ServerWrapper = new ServerWrapper();
         w._server = server;
         w._serverInfo = serverInfo;
         return w;
      }
      
      public static function sortByPopulation(serverA:ServerWrapper, serverB:ServerWrapper) : Number
      {
         if(serverA.server.population.id < serverB.server.population.id)
         {
            return -1;
         }
         if(serverA.server.population.id > serverB.server.population.id)
         {
            return 1;
         }
         return 0;
      }
      
      public function get server() : Server
      {
         return this._server;
      }
      
      public function get serverInfo() : GameServerInformations
      {
         return this._serverInfo;
      }
   }
}
