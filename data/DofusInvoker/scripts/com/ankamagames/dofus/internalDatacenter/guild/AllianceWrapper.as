package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.enums.AllianceRightsBitEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class AllianceWrapper implements IDataCenter
   {
      
      public static const IS_BOSS:String = "isBoss";
      
      public static const allianceRights:Array = new Array(IS_BOSS);
      
      public static var _rightDictionnary:Dictionary = new Dictionary();
      
      private static var _ref:Dictionary = new Dictionary();
       
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var allianceId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var creationDate:uint;
      
      public var nbGuilds:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubareas:uint = 0;
      
      public var leadingGuildId:uint = 0;
      
      public var leaderCharacterId:Number = 0;
      
      public var leaderCharacterName:String = "";
      
      public var motd:String = "";
      
      public var formattedMotd:String = "";
      
      public var motdWriterId:Number;
      
      public var motdWriterName:String = "";
      
      public var motdTimestamp:Number;
      
      public var bulletin:String = "";
      
      public var formattedBulletin:String = "";
      
      public var bulletinWriterId:Number;
      
      public var bulletinWriterName:String = "";
      
      public var bulletinTimestamp:Number;
      
      public var lastNotifiedTimestamp:Number;
      
      public var guilds:Vector.<GuildFactSheetWrapper>;
      
      public var prismIds:Vector.<uint>;
      
      private var _memberRightsNumber:uint;
      
      public function AllianceWrapper()
      {
         this.guilds = new Vector.<GuildFactSheetWrapper>();
         this.prismIds = new Vector.<uint>();
         super();
      }
      
      public static function getAllianceById(id:int) : AllianceWrapper
      {
         return _ref[id];
      }
      
      public static function clearCache() : void
      {
         _ref = new Dictionary();
         GuildWrapper.clearCache();
      }
      
      public static function getFromNetwork(o:*) : AllianceWrapper
      {
         if(o is BasicAllianceInformations)
         {
            return getFromBasicAllianceInformations(BasicAllianceInformations(o));
         }
         if(o is AllianceVersatileInformations)
         {
            return getFromAllianceVersatileInformations(AllianceVersatileInformations(o));
         }
         if(o is AllianceFactsMessage)
         {
            return getFromAllianceFactsMessage(AllianceFactsMessage(o));
         }
         return null;
      }
      
      public static function updateRef(pAllianceId:uint, pAllianceWrapper:AllianceWrapper) : void
      {
         _ref[pAllianceId] = pAllianceWrapper;
      }
      
      private static function getFromAllianceFactsMessage(o:AllianceFactsMessage) : AllianceWrapper
      {
         var aw:AllianceWrapper = getFromBasicAllianceInformations(o.infos);
         if(o.guilds && o.guilds.length > 0)
         {
            aw.leadingGuildId = o.guilds[0].guildId;
            if(SocialFrame.getInstance().hasGuild && SocialFrame.getInstance().guild.guildId == o.guilds[0].guildId && SocialFrame.getInstance().guild.hasRight("isBoss"))
            {
               aw._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         aw.nbGuilds = o.guilds.length;
         aw.nbMembers = 0;
         aw.guilds.length = 0;
         aw.leaderCharacterId = o.leaderCharacterId;
         aw.leaderCharacterName = o.leaderCharacterName;
         for(var i:uint = 0; i < o.guilds.length; i++)
         {
            aw.nbMembers += o.guilds[i].nbMembers;
         }
         return aw;
      }
      
      private static function getFromAllianceVersatileInformations(o:AllianceVersatileInformations) : AllianceWrapper
      {
         var aw:AllianceWrapper = null;
         if(_ref[o.allianceId])
         {
            aw = _ref[o.allianceId];
         }
         else
         {
            aw = new AllianceWrapper();
            _ref[o.allianceId] = aw;
         }
         aw.allianceId = o.allianceId;
         aw.nbMembers = o.nbMembers;
         aw.nbGuilds = o.nbGuilds;
         aw.nbSubareas = o.nbSubarea;
         return aw;
      }
      
      private static function getFromBasicAllianceInformations(o:BasicAllianceInformations) : AllianceWrapper
      {
         var aw:AllianceWrapper = null;
         var emblem:GuildEmblem = null;
         if(_ref[o.allianceId])
         {
            aw = _ref[o.allianceId];
         }
         else
         {
            aw = new AllianceWrapper();
            _ref[o.allianceId] = aw;
         }
         aw.allianceId = o.allianceId;
         aw._allianceTag = o.allianceTag;
         if(o is BasicNamedAllianceInformations)
         {
            aw._allianceName = BasicNamedAllianceInformations(o).allianceName;
         }
         if(o is AllianceInformations)
         {
            emblem = AllianceInformations(o).allianceEmblem;
            aw.upEmblem = EmblemWrapper.fromNetwork(emblem,false,true);
            aw.backEmblem = EmblemWrapper.fromNetwork(emblem,true,true);
         }
         if(o is AllianceFactSheetInformations)
         {
            aw.creationDate = AllianceFactSheetInformations(o).creationDate;
         }
         return aw;
      }
      
      public static function create(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, leadingGuildId:int = 0, creationDate:Number = 0, nbGuilds:uint = 0, nbMembers:uint = 0, guilds:Vector.<GuildFactSheetWrapper> = null, prismIds:Vector.<uint> = null, pAllianceLeaderId:Number = 0, pAllianceLeaderName:String = "") : AllianceWrapper
      {
         var item:AllianceWrapper = null;
         item = new AllianceWrapper();
         item.allianceId = pAllianceId;
         item._allianceTag = pAllianceTag;
         item._allianceName = pAllianceName;
         item.leadingGuildId = leadingGuildId;
         item.leaderCharacterId = pAllianceLeaderId;
         item.leaderCharacterName = pAllianceLeaderName;
         if(pAllianceEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor,true);
            item.backEmblem = EmblemWrapper.create(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor,true);
         }
         item.creationDate = creationDate;
         item.nbGuilds = nbGuilds;
         item.nbMembers = nbMembers;
         item.guilds = guilds;
         if(guilds && guilds.length > 0)
         {
            item.leadingGuildId = guilds[0].guildId;
            if(SocialFrame.getInstance().hasGuild && SocialFrame.getInstance().guild.guildId == guilds[0].guildId && SocialFrame.getInstance().guild.hasRight("isBoss"))
            {
               item._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(prismIds)
         {
            item.prismIds = prismIds;
         }
         return item;
      }
      
      public static function getRightsNumber(pRightsIDs:Array) : Number
      {
         var right:String = null;
         var wantToSet:Boolean = false;
         var pRight:String = null;
         var rightNumber:Number = 0;
         for each(right in allianceRights)
         {
            wantToSet = false;
            for each(pRight in pRightsIDs)
            {
               if(pRight == right)
               {
                  rightNumber |= 1 << _rightDictionnary[pRight];
               }
            }
         }
         return rightNumber;
      }
      
      public function get allianceTag() : String
      {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get realAllianceTag() : String
      {
         return this._allianceTag;
      }
      
      public function get allianceName() : String
      {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get realAllianceName() : String
      {
         return this._allianceName;
      }
      
      public function set memberRightsNumber(value:uint) : void
      {
         this._memberRightsNumber = value;
      }
      
      public function get memberRightsNumber() : uint
      {
         return this._memberRightsNumber;
      }
      
      public function get memberRights() : Vector.<Boolean>
      {
         var rights:Vector.<Boolean> = new Vector.<Boolean>();
         rights.push(this.isBoss);
         return rights;
      }
      
      public function get isBoss() : Boolean
      {
         return (1 & this._memberRightsNumber) > 0;
      }
      
      public function clone() : AllianceWrapper
      {
         var wrapper:AllianceWrapper = create(this.allianceId,this.allianceTag,this.allianceName,null,this.leadingGuildId,this.creationDate,this.nbGuilds,this.nbMembers,this.guilds,this.prismIds,this.leaderCharacterId,this.leaderCharacterName);
         wrapper.upEmblem = this.upEmblem;
         wrapper.backEmblem = this.backEmblem;
         return wrapper;
      }
      
      public function update(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, leadingGuildId:int = 0, creationDate:Number = 0, nbGuilds:uint = 0, nbMembers:uint = 0, guilds:Vector.<GuildFactSheetWrapper> = null, prismIds:Vector.<uint> = null, pAllianceLeaderId:Number = 0, pAllianceLeaderName:String = "") : void
      {
         this.allianceId = pAllianceId;
         this._allianceTag = pAllianceTag;
         this._allianceName = pAllianceName;
         this.leadingGuildId = leadingGuildId;
         this.leaderCharacterId = pAllianceLeaderId;
         this.leaderCharacterName = pAllianceLeaderName;
         this.upEmblem.update(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
         this.backEmblem.update(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         this.creationDate = creationDate;
         this.nbGuilds = nbGuilds;
         this.nbMembers = nbMembers;
         this.guilds = guilds;
         if(guilds && guilds.length > 0)
         {
            this.leadingGuildId = guilds[0].guildId;
            if(SocialFrame.getInstance().hasGuild && SocialFrame.getInstance().guild.guildId == guilds[0].guildId && SocialFrame.getInstance().guild.hasRight("isBoss"))
            {
               this._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(prismIds)
         {
            this.prismIds = prismIds;
         }
      }
      
      public function hasRight(pRightId:String) : Boolean
      {
         var returnValue:Boolean = false;
         switch(pRightId)
         {
            case IS_BOSS:
               returnValue = this.isBoss;
         }
         return returnValue;
      }
      
      private function initDictionary() : void
      {
         _rightDictionnary[IS_BOSS] = 0;
      }
   }
}
