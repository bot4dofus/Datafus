package com.demonsters.debugger
{
   class MonsterDebuggerConnection
   {
      
      private static var connector:IMonsterDebuggerConnection;
       
      
      function MonsterDebuggerConnection()
      {
         super();
      }
      
      static function initialize() : void
      {
         connector = new MonsterDebuggerConnectionDefault();
      }
      
      static function processQueue() : void
      {
         connector.processQueue();
      }
      
      static function set address(value:String) : void
      {
         connector.address = value;
      }
      
      static function get connected() : Boolean
      {
         return connector.connected;
      }
      
      static function connect() : void
      {
         connector.connect();
      }
      
      static function send(id:String, data:Object, direct:Boolean = false) : void
      {
         connector.send(id,data,direct);
      }
   }
}
