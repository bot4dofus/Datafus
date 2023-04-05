package com.ankamagames.dofus.logic.game.spin2.chat
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class ChatServiceManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatServiceManager));
      
      private static var _self:ChatServiceManager;
       
      
      private var _chatService:ChatService;
      
      private var _currentAccountId:uint;
      
      public function ChatServiceManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("ChatServiceManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : ChatServiceManager
      {
         if(_self == null)
         {
            _self = new ChatServiceManager();
         }
         return _self;
      }
      
      public static function destroy() : void
      {
         if(_self != null && _self.chatService != null)
         {
            _self.chatService.disconnect();
            _self = null;
         }
      }
      
      public function isServiceInitializedWithAccount(accountId:uint) : Boolean
      {
         return this._currentAccountId == accountId;
      }
      
      public function tryToConnect() : void
      {
         if(this._chatService == null)
         {
            this._chatService = new ChatService();
         }
         var accountId:uint = PlayerManager.getInstance().accountId;
         if(!this.isServiceInitializedWithAccount(accountId))
         {
            this._currentAccountId = accountId;
            this._chatService.connect();
         }
         else
         {
            _log.debug("Account " + this._currentAccountId + " is already connected to chat service.");
         }
      }
      
      public function get chatService() : ChatService
      {
         return this._chatService;
      }
   }
}
