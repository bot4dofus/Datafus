package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.guild.recruitment.GuildRecruitmentInformation;
   
   public class GuildRecruitmentDataWrapper extends SocialRecruitmentDataWrapper
   {
       
      
      public var minAchievementPoints:uint = 0;
      
      public var areMinAchievementPointsRequired:Boolean = false;
      
      public function GuildRecruitmentDataWrapper(socialGroupId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriteria:Vector.<uint> = null, minLevel:uint = 0, isMinLevelRequired:Boolean = false, isInvalidated:Boolean = false, lastEditorName:String = null, lastEditDate:Number = 0, wasRecruitmentAutoLocked:Boolean = false, minAchievementPoints:uint = 0, areMinAchievementPointsRequired:Boolean = false)
      {
         super(socialGroupId,recruitmentType,recruitmentTitle,recruitmentText,selectedLanguages,selectedCriteria,minLevel,isMinLevelRequired,isInvalidated,lastEditorName,lastEditDate,wasRecruitmentAutoLocked);
         this.minAchievementPoints = minAchievementPoints;
         this.areMinAchievementPointsRequired = areMinAchievementPointsRequired;
      }
      
      public static function wrap(info:GuildRecruitmentInformation) : GuildRecruitmentDataWrapper
      {
         return new GuildRecruitmentDataWrapper(info.socialId,info.recruitmentType,info.recruitmentTitle,info.recruitmentText,info.selectedLanguages,info.selectedCriterion,info.minLevel,!info.minLevelFacultative,info.invalidatedByModeration,info.lastEditPlayerName,info.lastEditDate,info.recruitmentAutoLocked,info.minSuccess,!info.minSuccessFacultative);
      }
      
      public function unwrap() : GuildRecruitmentInformation
      {
         var message:GuildRecruitmentInformation = new GuildRecruitmentInformation();
         message.initGuildRecruitmentInformation(socialGroupId,recruitmentType,recruitmentTitle !== null ? recruitmentTitle : "",recruitmentText !== null ? recruitmentText : "",selectedLanguages !== null ? selectedLanguages : new Vector.<uint>(),selectedCriteria !== null ? selectedCriteria : new Vector.<uint>(),minLevel,!isMinLevelRequired,isInvalidated,lastEditorName !== null ? lastEditorName : "",lastEditDate,wasRecruitmentAutoLocked,this.minAchievementPoints,!this.areMinAchievementPointsRequired);
         return message;
      }
   }
}
