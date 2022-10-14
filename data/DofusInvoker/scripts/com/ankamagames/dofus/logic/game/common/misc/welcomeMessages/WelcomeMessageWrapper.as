package com.ankamagames.dofus.logic.game.common.misc.welcomeMessages
{
   import com.ankama.haapi.client.model.CmsFeed;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class WelcomeMessageWrapper
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(WelcomeMessageWrapper));
       
      
      private var _id:Number = NaN;
      
      private var _title:String = null;
      
      private var _text:String = null;
      
      private var _displayTime:Number = NaN;
      
      private var _expirationTime:Number = NaN;
      
      private var _serverIds:Vector.<Number> = null;
      
      public function WelcomeMessageWrapper(id:Number, name:String, message:String, displayTime:Number, expirationTime:Number, serverIds:Vector.<Number>)
      {
         super();
         this._id = id;
         this._title = name;
         this._text = message;
         this._displayTime = displayTime;
         this._expirationTime = expirationTime;
         this._serverIds = serverIds;
      }
      
      public static function wrap(rawMessage:CmsFeed) : WelcomeMessageWrapper
      {
         var rawServerId:String = null;
         var serverId:Number = NaN;
         var serverIds:Vector.<Number> = null;
         if(rawMessage.server_id !== null && rawMessage.server_id.length > 0)
         {
            serverIds = new Vector.<Number>(0);
            for each(rawServerId in rawMessage.server_id)
            {
               if(!rawServerId)
               {
                  _log.warn("Raw server ID appears to be empty: " + rawServerId);
               }
               else
               {
                  serverId = Number(rawServerId);
                  if(isNaN(serverId))
                  {
                     _log.warn("Raw server ID could NOT be parsed: " + rawServerId);
                  }
                  else if(serverIds.indexOf(serverId) !== -1)
                  {
                     _log.warn("Duplicate server ID provided: " + serverId);
                  }
                  else
                  {
                     serverIds.push(serverId);
                  }
               }
            }
         }
         return new WelcomeMessageWrapper(rawMessage.id,rawMessage.name,rawMessage.message,rawMessage.timestamp * 1000,rawMessage.timestamp_end * 1000,serverIds);
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get displayTime() : Number
      {
         return this._displayTime;
      }
      
      public function get expirationTime() : Number
      {
         return this._expirationTime;
      }
      
      public function get serverIds() : Vector.<Number>
      {
         return this._serverIds;
      }
      
      public function get isValid() : Boolean
      {
         return !isNaN(this._id) && this._id >= 0 && this._title !== null && this._text !== null && !isNaN(this._displayTime) && this._displayTime >= 0 && !isNaN(this._expirationTime) && this._expirationTime >= 0 && this._displayTime < this._expirationTime;
      }
      
      public function get isDisplayedOnCurrentServer() : Boolean
      {
         var serverId:Number = NaN;
         if(this._serverIds === null)
         {
            return true;
         }
         var currentServerId:int = PlayerManager.getInstance().server.id;
         for each(serverId in this._serverIds)
         {
            if(serverId === currentServerId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasExpired() : Boolean
      {
         return this._expirationTime <= TimeManager.getInstance().getUtcTimestamp();
      }
      
      public function get canBeDisplayed() : Boolean
      {
         var now:Number = TimeManager.getInstance().getUtcTimestamp();
         return this._displayTime <= now && now < this._expirationTime;
      }
      
      public function toString() : String
      {
         return "WelcomeMessageWrapper[id: " + this._id.toString() + ", name: " + this._title + ", message: " + this._text + ", display time: " + this._displayTime.toString() + ", expiration time: " + this._expirationTime.toString() + ", server IDs: [" + this._serverIds.join(", ") + "]]";
      }
   }
}
