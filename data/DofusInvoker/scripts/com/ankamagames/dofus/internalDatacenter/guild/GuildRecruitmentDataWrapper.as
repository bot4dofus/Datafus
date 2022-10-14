package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.network.types.game.guild.recruitment.GuildRecruitmentInformation;
   
   public class GuildRecruitmentDataWrapper
   {
       
      
      public var guildId:uint = 0;
      
      public var recruitmentType:uint = 0;
      
      public var recruitmentTitle:String = null;
      
      public var recruitmentText:String = null;
      
      public var selectedLanguages:Vector.<uint>;
      
      public var selectedCriteria:Vector.<uint>;
      
      public var minLevel:uint = 0;
      
      public var isMinLevelRequired:Boolean = false;
      
      public var minAchievementPoints:uint = 0;
      
      public var areMinAchievementPointsRequired:Boolean = false;
      
      public var isInvalidated:Boolean = false;
      
      public var lastEditorName:String = null;
      
      public var lastEditDate:Number = 0;
      
      public var wasRecruitmentAutoLocked:Boolean = false;
      
      public function GuildRecruitmentDataWrapper(guildId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriteria:Vector.<uint> = null, minLevel:uint = 0, isMinLevelRequired:Boolean = false, minAchievementPoints:uint = 0, areMinAchievementPointsRequired:Boolean = false, isInvalidated:Boolean = false, lastEditorName:String = null, lastEditDate:Number = 0, wasRecruitmentAutoLocked:Boolean = false)
      {
         this.selectedLanguages = new Vector.<uint>();
         this.selectedCriteria = new Vector.<uint>();
         super();
         this.guildId = guildId;
         this.recruitmentType = recruitmentType;
         this.recruitmentTitle = recruitmentTitle;
         this.recruitmentText = recruitmentText;
         this.selectedLanguages = selectedLanguages !== null ? selectedLanguages : new Vector.<uint>();
         this.selectedCriteria = selectedCriteria !== null ? selectedCriteria : new Vector.<uint>();
         this.minLevel = minLevel;
         this.isMinLevelRequired = isMinLevelRequired;
         this.minAchievementPoints = minAchievementPoints;
         this.areMinAchievementPointsRequired = areMinAchievementPointsRequired;
         this.isInvalidated = isInvalidated;
         this.lastEditorName = lastEditorName;
         this.lastEditDate = lastEditDate;
         this.wasRecruitmentAutoLocked = wasRecruitmentAutoLocked;
      }
      
      public static function wrap(info:GuildRecruitmentInformation) : GuildRecruitmentDataWrapper
      {
         return new GuildRecruitmentDataWrapper(info.guildId,info.recruitmentType,info.recruitmentTitle,info.recruitmentText,info.selectedLanguages,info.selectedCriterion,info.minLevel,!info.minLevelFacultative,info.minSuccess,!info.minSuccessFacultative,info.invalidatedByModeration,info.lastEditPlayerName,info.lastEditDate,info.recruitmentAutoLocked);
      }
      
      public function unwrap() : GuildRecruitmentInformation
      {
         var message:GuildRecruitmentInformation = new GuildRecruitmentInformation();
         message.initGuildRecruitmentInformation(this.guildId,this.recruitmentType,this.recruitmentTitle !== null ? this.recruitmentTitle : "",this.recruitmentText !== null ? this.recruitmentText : "",this.selectedLanguages !== null ? this.selectedLanguages : new Vector.<uint>(),this.selectedCriteria !== null ? this.selectedCriteria : new Vector.<uint>(),this.minLevel,!this.isMinLevelRequired,this.minAchievementPoints,!this.areMinAchievementPointsRequired,this.isInvalidated,this.lastEditorName !== null ? this.lastEditorName : "",this.lastEditDate,this.wasRecruitmentAutoLocked);
         return message;
      }
   }
}
