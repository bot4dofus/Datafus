package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.dofus.logic.common.managers.DofusFpsManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class InterClientManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientManager));
      
      private static var _self:InterClientManager;
       
      
      private var _client:InterClientSlave;
      
      private var _master:InterClientMaster;
      
      private var _identity:String;
      
      private var _clientId:uint;
      
      private var _numClients:uint;
      
      public var clientListInfo:Array;
      
      public function InterClientManager()
      {
         this.clientListInfo = new Array("_dofus",0);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : InterClientManager
      {
         if(!_self)
         {
            _self = new InterClientManager();
         }
         return _self;
      }
      
      public static function destroy() : void
      {
         if(_self)
         {
            try
            {
               if(_self._client)
               {
                  _self._client.destroy();
               }
               if(_self._master)
               {
                  _self._master.destroy();
               }
            }
            catch(ae:ArgumentError)
            {
               _log.warn("Closing a disconnected LocalConnection in destroy(). Exception catched.");
            }
         }
      }
      
      public static function isMaster() : Boolean
      {
         return getInstance()._master != null;
      }
      
      public function get flashKey() : String
      {
         return this._identity;
      }
      
      public function set flashKey(key:String) : void
      {
         this._identity = key;
      }
      
      public function get isAlone() : Boolean
      {
         return isMaster() && this._master.isAlone;
      }
      
      public function get clientId() : uint
      {
         return this._clientId;
      }
      
      public function set clientId(pClientId:uint) : void
      {
         this._clientId = pClientId;
      }
      
      public function get numClients() : uint
      {
         return this._numClients;
      }
      
      public function set numClients(pNumClients:uint) : void
      {
         this._numClients = pNumClients;
      }
      
      public function update() : void
      {
         if(!this._identity)
         {
            InterClientKeyManager.getInstance().getKey();
         }
         this._master = InterClientMaster.etreLeCalif();
         RegConnectionManager.getInstance().setAsMain(this._master != null);
         if(!this._master && !this._client)
         {
            this._client = new InterClientSlave();
         }
         if(this._master && this._client)
         {
            try
            {
               this._client.destroy();
               this._client = null;
            }
            catch(ae:ArgumentError)
            {
               _log.warn("Closing a disconnected LocalConnection in update(). Exception catched.");
            }
            this.gainFocus();
         }
      }
      
      public function gainFocus() : void
      {
         var date:Number = new Date().time;
         if(this._client)
         {
            this._client.gainFocus(date);
         }
         else if(this._master)
         {
            this._master.clientGainFocus("_dofus," + new Date().time);
         }
      }
      
      public function resetFocus() : void
      {
         if(this._client)
         {
            this._client.gainFocus(0);
         }
         else if(this._master)
         {
            this._master.clientGainFocus("_dofus,0");
         }
      }
      
      public function updateFocusList() : void
      {
         var clientId:String = !!this._master ? "_dofus" : this._client.connId;
         DofusFpsManager.updateFocusList(this.clientListInfo,clientId);
      }
   }
}
