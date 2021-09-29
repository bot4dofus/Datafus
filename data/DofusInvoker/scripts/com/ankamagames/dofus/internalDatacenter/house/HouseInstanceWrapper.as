package com.ankamagames.dofus.internalDatacenter.house
{
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseGuildedInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsInside;
   import com.ankamagames.dofus.network.types.game.house.HouseInstanceInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class HouseInstanceWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseInstanceWrapper));
       
      
      public var id:int;
      
      public var ownerName:String;
      
      public var ownerTag:String;
      
      public var hasOwner:Boolean;
      
      public var price:Number = 0;
      
      public var isOnSale:Boolean = false;
      
      public var isSaleLocked:Boolean;
      
      public var isLocked:Boolean;
      
      public var guildIdentity:GuildWrapper;
      
      public var indexOfThisInstanceForTheOwner:int = -1;
      
      private var _label:String;
      
      private var _accountName:String;
      
      private var _accountTag:String;
      
      private var _belongsToMyGuild:Boolean;
      
      public function HouseInstanceWrapper()
      {
         super();
         this._accountName = PlayerManager.getInstance().nickname;
         this._accountTag = PlayerManager.getInstance().tag;
      }
      
      public static function create(instanceInformations:HouseInstanceInformations, indexOfThisInstanceForTheOwner:int = -1) : HouseInstanceWrapper
      {
         var hgi:HouseGuildedInformations = null;
         var houseInstance:HouseInstanceWrapper = new HouseInstanceWrapper();
         houseInstance.id = instanceInformations.instanceId;
         houseInstance.ownerName = instanceInformations.ownerTag.nickname;
         houseInstance.ownerTag = instanceInformations.ownerTag.tagNumber;
         houseInstance.hasOwner = instanceInformations.hasOwner;
         houseInstance.price = instanceInformations.price;
         houseInstance.isOnSale = instanceInformations.price > 0;
         houseInstance.isSaleLocked = instanceInformations.isSaleLocked;
         houseInstance.isLocked = instanceInformations.isLocked;
         houseInstance.indexOfThisInstanceForTheOwner = indexOfThisInstanceForTheOwner;
         if(instanceInformations is HouseGuildedInformations)
         {
            hgi = instanceInformations as HouseGuildedInformations;
            houseInstance.setGuildIdentity(hgi.guildInfo);
         }
         return houseInstance;
      }
      
      public static function createInside(houseInside:HouseInformationsInside) : HouseInstanceWrapper
      {
         var hgi:HouseGuildedInformations = null;
         var houseInstance:HouseInstanceWrapper = new HouseInstanceWrapper();
         houseInstance.id = houseInside.houseInfos.instanceId;
         houseInstance.ownerName = houseInside.houseInfos.ownerTag.nickname;
         houseInstance.ownerTag = houseInside.houseInfos.ownerTag.tagNumber;
         houseInstance.hasOwner = houseInside.houseInfos.hasOwner;
         houseInstance.price = houseInside.houseInfos.price;
         houseInstance.isOnSale = houseInside.houseInfos.price > 0;
         houseInstance.isLocked = houseInside.houseInfos.isLocked;
         if(houseInside.houseInfos is HouseGuildedInformations)
         {
            hgi = houseInside.houseInfos as HouseGuildedInformations;
            houseInstance.setGuildIdentity(hgi.guildInfo);
         }
         return houseInstance;
      }
      
      public static function createOwned(houseOwned:AccountHouseInformations) : HouseInstanceWrapper
      {
         var hgi:HouseGuildedInformations = null;
         var houseInstance:HouseInstanceWrapper = new HouseInstanceWrapper();
         houseInstance.id = houseOwned.houseInfos.instanceId;
         houseInstance.ownerName = houseOwned.houseInfos.ownerTag.nickname;
         houseInstance.ownerTag = houseOwned.houseInfos.ownerTag.tagNumber;
         houseInstance.hasOwner = houseOwned.houseInfos.hasOwner;
         houseInstance.price = houseOwned.houseInfos.price;
         houseInstance.isOnSale = houseOwned.houseInfos.price > 0;
         houseInstance.isLocked = houseOwned.houseInfos.isLocked;
         if(houseOwned.houseInfos is HouseGuildedInformations)
         {
            hgi = houseOwned.houseInfos as HouseGuildedInformations;
            houseInstance.setGuildIdentity(hgi.guildInfo);
         }
         return houseInstance;
      }
      
      public function setGuildIdentity(guild:GuildInformations) : void
      {
         var myGuild:GuildWrapper = null;
         if(!guild)
         {
            this.guildIdentity = null;
            this._belongsToMyGuild = false;
         }
         else
         {
            this.guildIdentity = GuildWrapper.create(guild.guildId,guild.guildName,guild.guildEmblem,0);
            myGuild = SocialFrame.getInstance().guild;
            this._belongsToMyGuild = myGuild && myGuild.guildId == guild.guildId;
         }
      }
      
      public function get label() : String
      {
         if(!this._label)
         {
            if(this.hasOwner)
            {
               if(this.isMine)
               {
                  this._label = I18n.getUiText("ui.common.myHouse");
               }
               else
               {
                  this._label = I18n.getUiText("ui.house.homeOf",[PlayerManager.getInstance().formatTagName(this.ownerName,this.ownerTag)]);
               }
               if(this.indexOfThisInstanceForTheOwner > -1)
               {
                  this._label += " (" + (this.indexOfThisInstanceForTheOwner + 1) + ")";
               }
            }
            else
            {
               this._label = I18n.getUiText("ui.common.houseWithNoOwner");
            }
         }
         return this._label;
      }
      
      public function get isMine() : Boolean
      {
         return this._accountName == this.ownerName && this._accountTag == this.ownerTag;
      }
      
      public function get belongsToMyGuild() : Boolean
      {
         return this._belongsToMyGuild;
      }
   }
}
