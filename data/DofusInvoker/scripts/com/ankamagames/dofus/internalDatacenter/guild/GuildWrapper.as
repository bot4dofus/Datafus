package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class GuildWrapper implements IDataCenter
   {
      
      private static var _ref:Dictionary = new Dictionary();
      
      public static const IS_BOSS:String = "isBoss";
      
      public static const MANAGE_GUILD_BOOSTS:String = "manageGuildBoosts";
      
      public static const MANAGE_RIGHTS:String = "manageRights";
      
      public static const MANAGE_LIGHT_RIGHTS:String = "manageLightRights";
      
      public static const INVITE_NEW_MEMBERS:String = "inviteNewMembers";
      
      public static const BAN_MEMBERS:String = "banMembers";
      
      public static const MANAGE_XP_CONTRIBUTION:String = "manageXPContribution";
      
      public static const MANAGE_RANKS:String = "manageRanks";
      
      public static const HIRE_TAX_COLLECTOR:String = "hireTaxCollector";
      
      public static const MANAGE_MY_XP_CONTRIBUTION:String = "manageMyXpContribution";
      
      public static const COLLECT:String = "collect";
      
      public static const USE_FARMS:String = "useFarms";
      
      public static const ORGANIZE_FARMS:String = "organizeFarms";
      
      public static const TAKE_OTHERS_RIDES_IN_FARM:String = "takeOthersRidesInFarm";
      
      public static const PRIORITIZE_DEFENSE:String = "prioritizeMeInDefense";
      
      public static const COLLECT_MY_TAX_COLLECTORS:String = "collectMyTaxCollectors";
      
      public static const SET_ALLIANCE_PRISM:String = "setAlliancePrism";
      
      public static const TALK_IN_ALLIANCE_CHANNEL:String = "talkInAllianceChannel";
      
      public static const guildRights:Array = new Array(IS_BOSS,MANAGE_GUILD_BOOSTS,MANAGE_RIGHTS,MANAGE_LIGHT_RIGHTS,INVITE_NEW_MEMBERS,BAN_MEMBERS,MANAGE_XP_CONTRIBUTION,MANAGE_RANKS,HIRE_TAX_COLLECTOR,MANAGE_MY_XP_CONTRIBUTION,COLLECT,USE_FARMS,ORGANIZE_FARMS,TAKE_OTHERS_RIDES_IN_FARM,PRIORITIZE_DEFENSE,COLLECT_MY_TAX_COLLECTORS,SET_ALLIANCE_PRISM,TALK_IN_ALLIANCE_CHANNEL);
      
      public static var _rightDictionnary:Dictionary = new Dictionary();
       
      
      private var _guildName:String;
      
      public var guildId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var level:uint = 0;
      
      public var creationDate:uint;
      
      public var leaderId:Number;
      
      public var nbMembers:uint;
      
      public var nbConnectedMembers:uint;
      
      public var experience:Number;
      
      public var expLevelFloor:Number;
      
      public var expNextLevelFloor:Number;
      
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
      
      private var _memberRightsNumber:uint;
      
      public function GuildWrapper()
      {
         super();
      }
      
      public static function getGuildById(id:int) : GuildWrapper
      {
         return _ref[id];
      }
      
      public static function clearCache() : void
      {
         _ref = new Dictionary();
      }
      
      public static function getFromNetwork(msg:Object) : GuildWrapper
      {
         var o:GuildWrapper = null;
         var gvi:GuildVersatileInformations = null;
         if(_ref[msg.guildId])
         {
            o = _ref[msg.guildId];
         }
         else
         {
            o = new GuildWrapper();
            _ref[msg.guildId] = o;
         }
         o.guildId = msg.guildId;
         if(msg is GuildVersatileInformations)
         {
            gvi = msg as GuildVersatileInformations;
            o.level = gvi.guildLevel;
            o.leaderId = gvi.leaderId;
            o.nbMembers = gvi.nbMembers;
         }
         else if(msg is BasicGuildInformations)
         {
            o._guildName = BasicGuildInformations(msg).guildName;
            if(msg is GuildInformations)
            {
               o.backEmblem = EmblemWrapper.fromNetwork(GuildInformations(msg).guildEmblem,true);
               o.upEmblem = EmblemWrapper.fromNetwork(GuildInformations(msg).guildEmblem,false);
            }
         }
         return o;
      }
      
      public static function updateRef(pGuildId:uint, pGuildWrapper:GuildWrapper) : void
      {
         _ref[pGuildId] = pGuildWrapper;
      }
      
      public static function create(pGuildId:uint, pGuildName:String, pGuildEmblem:GuildEmblem, pMemberRights:Number) : GuildWrapper
      {
         var item:GuildWrapper = null;
         item = new GuildWrapper();
         item.initDictionary();
         item.guildId = pGuildId;
         item._guildName = pGuildName;
         item._memberRightsNumber = pMemberRights;
         if(pGuildEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
         }
         return item;
      }
      
      public static function getRightsNumber(pRightsIDs:Array) : Number
      {
         var right:String = null;
         var wantToSet:Boolean = false;
         var pRight:String = null;
         var rightNumber:Number = 0;
         for each(right in guildRights)
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
      
      public function get guildName() : String
      {
         if(this._guildName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._guildName;
      }
      
      public function get realGuildName() : String
      {
         return this._guildName;
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
         rights.push(this.manageGuildBoosts);
         rights.push(this.manageRights);
         rights.push(this.manageLightRights);
         rights.push(this.inviteNewMembers);
         rights.push(this.banMembers);
         rights.push(this.manageXPContribution);
         rights.push(this.manageRanks);
         rights.push(this.manageMyXpContribution);
         rights.push(this.hireTaxCollector);
         rights.push(this.collect);
         rights.push(this.useFarms);
         rights.push(this.organizeFarms);
         rights.push(this.takeOthersRidesInFarm);
         rights.push(this.prioritizeMeInDefense);
         rights.push(this.collectMyTaxCollectors);
         rights.push(this.setAlliancePrism);
         rights.push(this.talkInAllianceChannel);
         return rights;
      }
      
      public function get isBoss() : Boolean
      {
         return (1 & this._memberRightsNumber) > 0;
      }
      
      public function get manageGuildBoosts() : Boolean
      {
         return this.isBoss || this.manageRights || (2 & this._memberRightsNumber) > 0;
      }
      
      public function get manageRights() : Boolean
      {
         return this.isBoss || (4 & this._memberRightsNumber) > 0;
      }
      
      public function get inviteNewMembers() : Boolean
      {
         return this.isBoss || this.manageRights || (8 & this._memberRightsNumber) > 0;
      }
      
      public function get banMembers() : Boolean
      {
         return this.isBoss || this.manageRights || (16 & this._memberRightsNumber) > 0;
      }
      
      public function get manageXPContribution() : Boolean
      {
         return this.isBoss || this.manageRights || (32 & this._memberRightsNumber) > 0;
      }
      
      public function get manageRanks() : Boolean
      {
         return this.isBoss || this.manageRights || (64 & this._memberRightsNumber) > 0;
      }
      
      public function get hireTaxCollector() : Boolean
      {
         return this.isBoss || this.manageRights || (128 & this._memberRightsNumber) > 0;
      }
      
      public function get manageMyXpContribution() : Boolean
      {
         return this.isBoss || this.manageRights || (256 & this._memberRightsNumber) > 0;
      }
      
      public function get collect() : Boolean
      {
         return this.isBoss || this.manageRights || (512 & this._memberRightsNumber) > 0;
      }
      
      public function get manageLightRights() : Boolean
      {
         return this.isBoss || this.manageRights || (1024 & this._memberRightsNumber) > 0;
      }
      
      public function get useFarms() : Boolean
      {
         return this.isBoss || this.manageRights || (4096 & this._memberRightsNumber) > 0;
      }
      
      public function get organizeFarms() : Boolean
      {
         return this.isBoss || this.manageRights || (8192 & this._memberRightsNumber) > 0;
      }
      
      public function get takeOthersRidesInFarm() : Boolean
      {
         return this.isBoss || this.manageRights || (16384 & this._memberRightsNumber) > 0;
      }
      
      public function get prioritizeMeInDefense() : Boolean
      {
         return this.isBoss || this.manageRights || (32768 & this._memberRightsNumber) > 0;
      }
      
      public function get collectMyTaxCollectors() : Boolean
      {
         return this.isBoss || this.manageRights || (65536 & this._memberRightsNumber) > 0;
      }
      
      public function get setAlliancePrism() : Boolean
      {
         return this.isBoss || this.manageRights || (131072 & this._memberRightsNumber) > 0;
      }
      
      public function get talkInAllianceChannel() : Boolean
      {
         return this.isBoss || this.manageRights || (262144 & this._memberRightsNumber) > 0;
      }
      
      public function clone() : GuildWrapper
      {
         var wrapper:GuildWrapper = create(this.guildId,this.guildName,null,this.memberRightsNumber);
         wrapper.upEmblem = this.upEmblem;
         wrapper.backEmblem = this.backEmblem;
         return wrapper;
      }
      
      public function update(pGuildId:uint, pGuildName:String, pGuildEmblem:GuildEmblem, pMemberRights:Number) : void
      {
         this.guildId = pGuildId;
         this._guildName = pGuildName;
         this._memberRightsNumber = pMemberRights;
         this.upEmblem.update(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
         this.backEmblem.update(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
      }
      
      public function hasRight(pRightId:String) : Boolean
      {
         var returnValue:Boolean = false;
         switch(pRightId)
         {
            case IS_BOSS:
               returnValue = this.isBoss;
               break;
            case MANAGE_GUILD_BOOSTS:
               returnValue = this.manageGuildBoosts;
               break;
            case MANAGE_RIGHTS:
               returnValue = this.manageRights;
               break;
            case MANAGE_LIGHT_RIGHTS:
               returnValue = this.manageLightRights;
               break;
            case INVITE_NEW_MEMBERS:
               returnValue = this.inviteNewMembers;
               break;
            case BAN_MEMBERS:
               returnValue = this.banMembers;
               break;
            case MANAGE_XP_CONTRIBUTION:
               returnValue = this.manageXPContribution;
               break;
            case MANAGE_RANKS:
               returnValue = this.manageRanks;
               break;
            case MANAGE_MY_XP_CONTRIBUTION:
               returnValue = this.manageMyXpContribution;
               break;
            case HIRE_TAX_COLLECTOR:
               returnValue = this.hireTaxCollector;
               break;
            case COLLECT:
               returnValue = this.collect;
               break;
            case USE_FARMS:
               returnValue = this.useFarms;
               break;
            case ORGANIZE_FARMS:
               returnValue = this.organizeFarms;
               break;
            case TAKE_OTHERS_RIDES_IN_FARM:
               returnValue = this.takeOthersRidesInFarm;
               break;
            case PRIORITIZE_DEFENSE:
               returnValue = this.prioritizeMeInDefense;
               break;
            case COLLECT_MY_TAX_COLLECTORS:
               returnValue = this.collectMyTaxCollectors;
               break;
            case SET_ALLIANCE_PRISM:
               returnValue = this.setAlliancePrism;
               break;
            case TALK_IN_ALLIANCE_CHANNEL:
               returnValue = this.talkInAllianceChannel;
         }
         return returnValue;
      }
      
      private function initDictionary() : void
      {
         _rightDictionnary[IS_BOSS] = 0;
         _rightDictionnary[MANAGE_GUILD_BOOSTS] = 1;
         _rightDictionnary[MANAGE_RIGHTS] = 2;
         _rightDictionnary[INVITE_NEW_MEMBERS] = 3;
         _rightDictionnary[BAN_MEMBERS] = 4;
         _rightDictionnary[MANAGE_XP_CONTRIBUTION] = 5;
         _rightDictionnary[MANAGE_RANKS] = 6;
         _rightDictionnary[HIRE_TAX_COLLECTOR] = 7;
         _rightDictionnary[MANAGE_MY_XP_CONTRIBUTION] = 8;
         _rightDictionnary[COLLECT] = 9;
         _rightDictionnary[MANAGE_LIGHT_RIGHTS] = 10;
         _rightDictionnary[USE_FARMS] = 12;
         _rightDictionnary[ORGANIZE_FARMS] = 13;
         _rightDictionnary[TAKE_OTHERS_RIDES_IN_FARM] = 14;
         _rightDictionnary[PRIORITIZE_DEFENSE] = 15;
         _rightDictionnary[COLLECT_MY_TAX_COLLECTORS] = 16;
         _rightDictionnary[SET_ALLIANCE_PRISM] = 17;
         _rightDictionnary[TALK_IN_ALLIANCE_CHANNEL] = 18;
      }
   }
}
