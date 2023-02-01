package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.PanicMessages;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   import flash.utils.getQualifiedClassName;
   
   public class InterClientKeyManager
   {
      
      private static var hex_chars:Array = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
      
      private static const MAX_CLIENTS:uint = 50;
      
      private static const CONNECTION_NAME:String = "_dofusClient_" + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + "#";
      
      private static const KEY_SIZE:uint = 21;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientKeyManager));
      
      private static var _instance:InterClientKeyManager;
       
      
      private var _sendingLc:LocalConnection;
      
      private var _receivingLc:LocalConnection;
      
      private var _key:String;
      
      private var _keyTimestamp:Number;
      
      private var _initKey:Boolean;
      
      private var _connected:Boolean;
      
      private var _connectionName:String;
      
      private var _currentClientId:uint;
      
      private var _clientsIds:Vector.<uint>;
      
      private var _clientsKeys:Array;
      
      private var _numAskedClients:int;
      
      public function InterClientKeyManager()
      {
         super();
         this._connected = false;
         this._sendingLc = new LocalConnection();
         this.initLocalConnection(this._sendingLc);
         this._receivingLc = new LocalConnection();
         this._receivingLc.client = new Object();
         this._receivingLc.client.ping = this.lc_ping;
         this._receivingLc.client.askKey = this.lc_askKey;
         this._receivingLc.client.receiveKey = this.lc_receiveKey;
         this.initLocalConnection(this._receivingLc);
      }
      
      public static function getInstance() : InterClientKeyManager
      {
         if(!_instance)
         {
            _instance = new InterClientKeyManager();
         }
         return _instance;
      }
      
      private static function getRandomFlashKey() : String
      {
         var sSentence:String = "";
         var nLen:Number = KEY_SIZE - (1 + 3);
         for(var i:Number = 0; i < nLen; i++)
         {
            sSentence += getRandomChar();
         }
         return sSentence + checksum(sSentence);
      }
      
      private static function checksum(s:String) : String
      {
         var r:Number = 0;
         for(var i:Number = 0; i < s.length; i++)
         {
            r += s.charCodeAt(i) % 16;
         }
         return hex_chars[r % 16];
      }
      
      private static function getRandomChar() : String
      {
         var n:Number = Math.ceil(Math.random() * 100);
         if(n <= 40)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
         }
         if(n <= 80)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
         }
         return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
      }
      
      public function getKey() : void
      {
         this._initKey = true;
         this._currentClientId = 0;
         this._clientsIds = new Vector.<uint>(0);
         this._clientsKeys = new Array();
         this.pingNext();
      }
      
      private function initLocalConnection(pLocalConnection:LocalConnection) : void
      {
         pLocalConnection.allowDomain("*");
         pLocalConnection.allowInsecureDomain("*");
         LogInFile.getInstance().logLine("interClientKeyManager pLocalConnection.addEventListener onStatusEvent",FileLoggerEnum.EVENTLISTENERS);
         pLocalConnection.addEventListener(StatusEvent.STATUS,this.onStatusEvent);
      }
      
      private function onStatusEvent(pEvent:StatusEvent) : void
      {
         LogInFile.getInstance().logLine("interClientKeyManager onStatusEvent",FileLoggerEnum.EVENTLISTENERS);
         if(this._initKey)
         {
            if(pEvent.level == "status")
            {
               if(this._currentClientId != InterClientManager.getInstance().clientId && this._clientsIds.indexOf(this._currentClientId) == -1)
               {
                  this._clientsIds.push(this._currentClientId);
               }
            }
            else if(pEvent.level == "error")
            {
               if(!this._connected)
               {
                  InterClientManager.getInstance().clientId = this._currentClientId;
                  this._connectionName = CONNECTION_NAME + this._currentClientId.toString();
                  try
                  {
                     this._receivingLc.connect(this._connectionName);
                  }
                  catch(error:Error)
                  {
                     _log.error("receivingLc failed to connect to " + _connectionName + ", msg:\n" + error.message);
                     Kernel.panic(PanicMessages.UNABLE_TO_GET_FLASHKEY);
                  }
                  this._connected = true;
               }
            }
            this.pingNext();
         }
         else
         {
            ++this._numAskedClients;
            if(this._numAskedClients == this._clientsIds.length && pEvent.level == "error" && !InterClientManager.getInstance().flashKey)
            {
               this.generateKey();
            }
         }
      }
      
      private function generateKey() : void
      {
         var flashKey:String = null;
         var so:CustomSharedObject = CustomSharedObject.getLocal("uid");
         var cacheKey:String = so.data["identity"];
         if(!cacheKey || cacheKey.length > KEY_SIZE - 3)
         {
            flashKey = getRandomFlashKey();
            so.data["identity"] = flashKey;
            so.flush();
         }
         else
         {
            flashKey = cacheKey;
         }
         so.close();
         this.saveKey(flashKey);
         this._initKey = false;
      }
      
      private function pingNext() : void
      {
         var connectionName:String = null;
         ++this._currentClientId;
         if(this._currentClientId <= MAX_CLIENTS)
         {
            connectionName = CONNECTION_NAME + this._currentClientId.toString();
            this._sendingLc.send(connectionName,"ping");
         }
         else
         {
            InterClientManager.getInstance().numClients = this._clientsIds.length + 1;
            if(this._clientsIds.length == 0)
            {
               this.generateKey();
            }
            else if(this._connected)
            {
               this._numAskedClients = 0;
               this.askKeyFromClients();
            }
            else
            {
               Kernel.panic(PanicMessages.TOO_MANY_CLIENTS);
            }
         }
      }
      
      private function askKeyFromClients() : void
      {
         var clientId:uint = 0;
         this._initKey = false;
         for each(clientId in this._clientsIds)
         {
            this._sendingLc.send(CONNECTION_NAME + clientId.toString(),"askKey",this._connectionName);
         }
      }
      
      private function saveKey(pKey:String, pNbKey:uint = 1) : void
      {
         var flashKey:String = null;
         var date:Date = new Date();
         this._key = pKey;
         this._keyTimestamp = date.getTime();
         flashKey = pKey + "#" + (pNbKey < 10 ? "0" + pNbKey : pNbKey);
         InterClientManager.getInstance().flashKey = flashKey;
      }
      
      private function lc_ping() : void
      {
      }
      
      private function lc_askKey(pFromConnectionName:String) : void
      {
         this._sendingLc.send(pFromConnectionName,"receiveKey",this._key,this._keyTimestamp);
      }
      
      private function lc_receiveKey(pKey:String, pTimestamp:Number) : void
      {
         var oldestKey:ClientKey = null;
         var distinctKeys:Array = null;
         var cKey:ClientKey = null;
         this._clientsKeys.push(new ClientKey(pKey,pTimestamp));
         if(this._clientsKeys.length == this._clientsIds.length)
         {
            this._clientsKeys.sortOn("timestamp",Array.NUMERIC);
            oldestKey = this._clientsKeys[0];
            distinctKeys = new Array();
            for each(cKey in this._clientsKeys)
            {
               if(distinctKeys.indexOf(cKey.key) == -1)
               {
                  distinctKeys.push(cKey.key);
               }
            }
            this.saveKey(oldestKey.key,distinctKeys.length);
         }
      }
   }
}

class ClientKey
{
    
   
   public var key:String;
   
   public var timestamp:Number;
   
   function ClientKey(pKey:String, pTimestamp:Number)
   {
      super();
      this.key = pKey;
      this.timestamp = pTimestamp;
   }
}
