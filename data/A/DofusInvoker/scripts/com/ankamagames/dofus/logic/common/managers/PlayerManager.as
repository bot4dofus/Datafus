package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.datacenter.houses.HavenbagTheme;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class PlayerManager implements IDestroyable
   {
      
      private static var _self:PlayerManager;
      
      public static const TAG_PREFIX:String = "#";
      
      public static const TAG_ADMINS:String = "OFFI";
       
      
      public var accountId:uint;
      
      public var communityId:uint;
      
      public var hasRights:Boolean;
      
      public var hasForceRight:Boolean;
      
      public var hasReportRight:Boolean;
      
      public var nickname:String;
      
      public var tag:String;
      
      public var subscriptionEndDate:Number;
      
      public var adminStatus:int;
      
      public var passkey:String;
      
      public var accountCreation:Number;
      
      public var isSafe:Boolean = false;
      
      public var canCreateNewCharacter:Boolean = true;
      
      private var _server:Server;
      
      private var _gameServerPort:uint;
      
      private var _kisServerPort:uint;
      
      public var serverCommunityId:int = -1;
      
      public var serverLang:String;
      
      public var serverGameType:int = -1;
      
      public var serverIsMonoAccount:Boolean;
      
      public var serversList:Vector.<int>;
      
      public var charactersList:Vector.<BasicCharacterWrapper>;
      
      public var allowAutoConnectCharacter:Boolean = false;
      
      public var autoConnectOfASpecificCharacterId:Number = -1;
      
      public var wasAlreadyConnected:Boolean = false;
      
      public var havenbagAvailableRooms:Vector.<HavenBagRoomPreviewInformation>;
      
      public var havenbagAvailableThemes:Vector.<int>;
      
      public var arenaLeaveBanTime:int = -1;
      
      public var hasFreeAutopilot:Boolean;
      
      private var _subscriptionDurationElapsed:Number;
      
      private var _subscriptionEndDateUpdateTime:Number;
      
      public function PlayerManager()
      {
         this.havenbagAvailableThemes = new Vector.<int>();
         super();
         if(!this._subscriptionEndDateUpdateTime)
         {
            this.refreshSubscriptionEndDateUpdateTime();
         }
         if(_self != null)
         {
            throw new SingletonError("PlayerManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : PlayerManager
      {
         if(_self == null)
         {
            _self = new PlayerManager();
         }
         return _self;
      }
      
      public function set server(s:Server) : void
      {
         this._server = s;
      }
      
      public function get server() : Server
      {
         if(this._server)
         {
            if(this.serverCommunityId > -1)
            {
               this._server.communityId = this.serverCommunityId;
            }
            if(this.serverGameType > -1)
            {
               this._server.gameTypeId = this.serverGameType;
            }
            this._server.monoAccount = this.serverIsMonoAccount;
            if(this.serverLang != "")
            {
               this._server.language = this.serverLang;
            }
         }
         return this._server;
      }
      
      public function set gameServerPort(value:uint) : void
      {
         this._gameServerPort = value;
      }
      
      public function get gameServerPort() : uint
      {
         return this._gameServerPort;
      }
      
      public function set kisServerPort(value:uint) : void
      {
         this._kisServerPort = value;
      }
      
      public function get kisServerPort() : uint
      {
         return this._kisServerPort;
      }
      
      public function get subscriptionDurationElapsed() : Number
      {
         var now:Number = NaN;
         var subscriptionSinceConnection:Number = NaN;
         if(this.subscriptionEndDate > this._subscriptionEndDateUpdateTime)
         {
            now = new Date().getTime();
            subscriptionSinceConnection = Math.min(this.subscriptionEndDate,now) - this._subscriptionEndDateUpdateTime;
            if(subscriptionSinceConnection > 0)
            {
               return this._subscriptionDurationElapsed + Math.floor(subscriptionSinceConnection / 1000);
            }
         }
         return this._subscriptionDurationElapsed;
      }
      
      public function set subscriptionDurationElapsed(n:Number) : void
      {
         this._subscriptionDurationElapsed = n;
      }
      
      public function refreshSubscriptionEndDateUpdateTime() : void
      {
         this._subscriptionEndDateUpdateTime = new Date().getTime();
      }
      
      public function isBasicAccount() : Boolean
      {
         return this.subscriptionEndDate <= TimeManager.getInstance().getUtcTimestamp() && !this.hasRights;
      }
      
      public function isMapInHavenbag(mapId:int) : Boolean
      {
         return HavenbagTheme.isMapIdInHavenbag(mapId);
      }
      
      public function formatTagName(name:String, tag:String, other:String = null, withStyle:Boolean = true, forceRealTag:Boolean = false) : String
      {
         var displayedTag:String = name.indexOf("[") == 0 && name.indexOf("]") == name.length - 1 && name != this.nickname && !forceRealTag ? TAG_ADMINS : tag;
         if(withStyle)
         {
            return this.addTagStyleToText("nameStyle",name) + (!!tag ? this.addTagStyleToText("tagStyle",TAG_PREFIX + displayedTag) : "") + (!!other ? this.addTagStyleToText("other"," (" + other + ")") : "");
         }
         return name + (!!tag ? TAG_PREFIX + displayedTag : "") + (!!other ? " (" + other + ")" : "");
      }
      
      private function addTagStyleToText(tagStyleName:String, text:String) : String
      {
         return "<span class=\"" + tagStyleName + "\">" + text + "</span>";
      }
      
      public function destroy() : void
      {
         _self = null;
      }
   }
}
