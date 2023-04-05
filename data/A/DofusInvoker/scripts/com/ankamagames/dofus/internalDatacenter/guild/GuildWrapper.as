package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class GuildWrapper implements IDataCenter
   {
      
      private static var _ref:Dictionary = new Dictionary();
       
      
      private var _guildName:String;
      
      public var guildRecruitmentInfo:GuildRecruitmentDataWrapper;
      
      public var lastActivityDay:uint;
      
      public var nbPendingApply:uint;
      
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
            if(msg is GuildFactSheetInformations)
            {
               o.level = (msg as GuildFactSheetInformations).guildLevel;
               o.leaderId = (msg as GuildFactSheetInformations).leaderId;
               o.nbMembers = (msg as GuildFactSheetInformations).nbMembers;
               o.guildRecruitmentInfo = GuildRecruitmentDataWrapper.wrap((msg as GuildFactSheetInformations).recruitment);
               o.lastActivityDay = (msg as GuildFactSheetInformations).lastActivityDay;
               o.nbPendingApply = (msg as GuildFactSheetInformations).nbPendingApply;
            }
         }
         return o;
      }
      
      public static function updateRef(pGuildId:uint, pGuildWrapper:GuildWrapper) : void
      {
         _ref[pGuildId] = pGuildWrapper;
      }
      
      public static function create(pGuildId:uint, pGuildName:String, pGuildEmblem:GuildEmblem) : GuildWrapper
      {
         var item:GuildWrapper = null;
         item = new GuildWrapper();
         item.guildId = pGuildId;
         item._guildName = pGuildName;
         if(pGuildEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
         }
         return item;
      }
      
      public static function fromGuildFactSheetWrapper(guildFactSheetWrapper:GuildFactSheetWrapper) : GuildWrapper
      {
         var o:GuildWrapper = null;
         if(_ref[guildFactSheetWrapper.guildId])
         {
            o = _ref[guildFactSheetWrapper.guildId];
         }
         else
         {
            o = new GuildWrapper();
            _ref[guildFactSheetWrapper.guildId] = o;
         }
         o.guildId = guildFactSheetWrapper.guildId;
         o._guildName = guildFactSheetWrapper.guildName;
         o.upEmblem = guildFactSheetWrapper.upEmblem;
         o.backEmblem = guildFactSheetWrapper.backEmblem;
         o.nbMembers = guildFactSheetWrapper.nbMembers;
         o.guildRecruitmentInfo = guildFactSheetWrapper.guildRecruitmentInfo;
         o.leaderId = guildFactSheetWrapper.leaderId;
         o.level = guildFactSheetWrapper.guildLevel;
         o.creationDate = guildFactSheetWrapper.creationDate;
         o.nbConnectedMembers = guildFactSheetWrapper.nbConnectedMembers;
         return o;
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
      
      public function clone() : GuildWrapper
      {
         var wrapper:GuildWrapper = create(this.guildId,this.guildName,null);
         wrapper.upEmblem = this.upEmblem;
         wrapper.backEmblem = this.backEmblem;
         return wrapper;
      }
      
      public function update(pGuildId:uint, pGuildName:String, pGuildEmblem:GuildEmblem) : void
      {
         this.guildId = pGuildId;
         this._guildName = pGuildName;
         this.upEmblem.update(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
         this.backEmblem.update(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
      }
   }
}
