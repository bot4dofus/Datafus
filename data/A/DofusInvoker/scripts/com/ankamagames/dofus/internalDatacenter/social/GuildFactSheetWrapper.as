package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalSocialPublicInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildFactSheetWrapper extends SocialGroupFactSheetWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildFactSheetWrapper));
       
      
      public var guildLevel:uint = 0;
      
      public var guildRecruitmentInfo:GuildRecruitmentDataWrapper;
      
      public function GuildFactSheetWrapper(guildId:uint, guildName:String, guildUpEmblem:EmblemWrapper, guildBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>, guildRecruitmentInfo:GuildRecruitmentDataWrapper, guildLevel:uint = 0)
      {
         this.guildRecruitmentInfo = new GuildRecruitmentDataWrapper();
         super(guildId,guildName,guildUpEmblem,guildBackEmblem,leaderId,nbMembers,creationDate,members);
         this.guildLevel = guildLevel;
         this.guildRecruitmentInfo = guildRecruitmentInfo;
      }
      
      public function updateWrapper(guildId:uint, guildName:String, guildUpEmblem:EmblemWrapper, guildBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>, guildRecruitmentInfo:GuildRecruitmentDataWrapper, guildLevel:uint = 0) : void
      {
         super.update(guildId,guildName,guildUpEmblem,guildBackEmblem,leaderId,nbMembers,creationDate,members);
         this.guildLevel = guildLevel;
         this.guildRecruitmentInfo = guildRecruitmentInfo;
      }
   }
}
