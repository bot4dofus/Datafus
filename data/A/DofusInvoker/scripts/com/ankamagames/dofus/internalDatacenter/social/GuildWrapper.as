package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class GuildWrapper extends SocialGroupWrapper implements IDataCenter
   {
      
      private static var _ref:Dictionary = new Dictionary();
       
      
      public var level:uint = 0;
      
      public var score:uint = 0;
      
      public var experience:Number;
      
      public var expLevelFloor:Number;
      
      public var expNextLevelFloor:Number;
      
      public var guildRecruitmentInfo:GuildRecruitmentDataWrapper;
      
      public function GuildWrapper()
      {
         super();
      }
      
      public static function getGuildById(id:int) : GuildWrapper
      {
         return _ref[id];
      }
      
      public static function create(pGuildId:uint, pGuildName:String, pGuildEmblem:SocialEmblem) : GuildWrapper
      {
         var item:GuildWrapper = null;
         item = new GuildWrapper();
         item.groupId = pGuildId;
         item.groupName = pGuildName;
         if(pGuildEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
         }
         return item;
      }
      
      public static function clearCache() : void
      {
         _ref = new Dictionary();
      }
      
      public static function getFromNetwork(msg:GuildInformations) : GuildWrapper
      {
         var o:GuildWrapper = null;
         if(_ref[msg.guildId])
         {
            o = _ref[msg.guildId];
         }
         else
         {
            o = new GuildWrapper();
            _ref[msg.guildId] = o;
         }
         o.groupId = msg.guildId;
         if(msg is BasicGuildInformations)
         {
            o.groupName = BasicGuildInformations(msg).guildName;
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
      
      public static function getFromGuildFactSheetWrapper(guildFactSheetWrapper:GuildFactSheetWrapper) : GuildWrapper
      {
         var o:GuildWrapper = null;
         if(_ref[guildFactSheetWrapper.groupId])
         {
            o = _ref[guildFactSheetWrapper.groupId];
         }
         else
         {
            o = new GuildWrapper();
            _ref[guildFactSheetWrapper.groupId] = o;
         }
         o.groupId = guildFactSheetWrapper.groupId;
         o.groupName = guildFactSheetWrapper.groupName;
         o.upEmblem = guildFactSheetWrapper.upEmblem;
         o.backEmblem = guildFactSheetWrapper.backEmblem;
         o.nbMembers = guildFactSheetWrapper.nbMembers;
         o.guildRecruitmentInfo = guildFactSheetWrapper.guildRecruitmentInfo;
         o.leaderId = guildFactSheetWrapper.leaderId;
         o.level = guildFactSheetWrapper.guildLevel;
         o.creationDate = guildFactSheetWrapper.creationDate;
         return o;
      }
      
      public function get guildId() : uint
      {
         return groupId;
      }
      
      public function get guildName() : String
      {
         return groupName;
      }
      
      override public function get recruitmentInfo() : SocialRecruitmentDataWrapper
      {
         return this.guildRecruitmentInfo;
      }
      
      public function update(pGuildId:uint, pGuildName:String, pGuildEmblem:SocialEmblem) : void
      {
         this.groupId = pGuildId;
         this.groupName = pGuildName;
         this.upEmblem.update(pGuildEmblem.symbolShape,EmblemWrapper.UP,pGuildEmblem.symbolColor);
         this.backEmblem.update(pGuildEmblem.backgroundShape,EmblemWrapper.BACK,pGuildEmblem.backgroundColor);
      }
      
      public function clone() : GuildWrapper
      {
         var wrapper:GuildWrapper = create(groupId,groupName,null);
         wrapper.upEmblem = upEmblem;
         wrapper.backEmblem = backEmblem;
         return wrapper;
      }
   }
}
