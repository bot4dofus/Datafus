package com.ankamagames.dofus.internalDatacenter.social
{
   public class SocialRecruitmentDataWrapper
   {
       
      
      public var socialGroupId:uint = 0;
      
      public var recruitmentType:uint = 0;
      
      public var recruitmentTitle:String = null;
      
      public var recruitmentText:String = null;
      
      public var selectedLanguages:Vector.<uint>;
      
      public var selectedCriteria:Vector.<uint>;
      
      public var minLevel:uint = 0;
      
      public var isMinLevelRequired:Boolean = false;
      
      public var isInvalidated:Boolean = false;
      
      public var lastEditorName:String = null;
      
      public var lastEditDate:Number = 0;
      
      public var wasRecruitmentAutoLocked:Boolean = false;
      
      public function SocialRecruitmentDataWrapper(socialGroupId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriteria:Vector.<uint> = null, minLevel:uint = 0, isMinLevelRequired:Boolean = false, isInvalidated:Boolean = false, lastEditorName:String = null, lastEditDate:Number = 0, wasRecruitmentAutoLocked:Boolean = false)
      {
         this.selectedLanguages = new Vector.<uint>();
         this.selectedCriteria = new Vector.<uint>();
         super();
         this.socialGroupId = socialGroupId;
         this.recruitmentType = recruitmentType;
         this.recruitmentTitle = recruitmentTitle;
         this.recruitmentText = recruitmentText;
         this.selectedLanguages = selectedLanguages !== null ? selectedLanguages : new Vector.<uint>();
         this.selectedCriteria = selectedCriteria !== null ? selectedCriteria : new Vector.<uint>();
         this.minLevel = minLevel;
         this.isMinLevelRequired = isMinLevelRequired;
         this.isInvalidated = isInvalidated;
         this.lastEditorName = lastEditorName;
         this.lastEditDate = lastEditDate;
         this.wasRecruitmentAutoLocked = wasRecruitmentAutoLocked;
      }
   }
}
