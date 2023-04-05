package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.alliance.recruitment.AllianceRecruitmentInformation;
   
   public class AllianceRecruitmentDataWrapper extends SocialRecruitmentDataWrapper
   {
       
      
      public function AllianceRecruitmentDataWrapper(socialGroupId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriteria:Vector.<uint> = null, minLevel:uint = 0, isMinLevelRequired:Boolean = false, isInvalidated:Boolean = false, lastEditorName:String = null, lastEditDate:Number = 0, wasRecruitmentAutoLocked:Boolean = false)
      {
         super(socialGroupId,recruitmentType,recruitmentTitle,recruitmentText,selectedLanguages,selectedCriteria,minLevel,isMinLevelRequired,isInvalidated,lastEditorName,lastEditDate,wasRecruitmentAutoLocked);
      }
      
      public static function wrap(info:AllianceRecruitmentInformation) : AllianceRecruitmentDataWrapper
      {
         return new AllianceRecruitmentDataWrapper(info.socialId,info.recruitmentType,info.recruitmentTitle,info.recruitmentText,info.selectedLanguages,info.selectedCriterion,info.minLevel,!info.minLevelFacultative,info.invalidatedByModeration,info.lastEditPlayerName,info.lastEditDate,info.recruitmentAutoLocked);
      }
      
      public function unwrap() : AllianceRecruitmentInformation
      {
         var message:AllianceRecruitmentInformation = new AllianceRecruitmentInformation();
         message.initAllianceRecruitmentInformation(socialGroupId,recruitmentType,recruitmentTitle !== null ? recruitmentTitle : "",recruitmentText !== null ? recruitmentText : "",selectedLanguages !== null ? selectedLanguages : new Vector.<uint>(),selectedCriteria !== null ? selectedCriteria : new Vector.<uint>(),minLevel,!isMinLevelRequired,isInvalidated,lastEditorName !== null ? lastEditorName : "",lastEditDate,wasRecruitmentAutoLocked);
         return message;
      }
   }
}
