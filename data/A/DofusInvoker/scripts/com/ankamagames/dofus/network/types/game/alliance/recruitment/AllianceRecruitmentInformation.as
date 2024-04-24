package com.ankamagames.dofus.network.types.game.alliance.recruitment
{
   import com.ankamagames.dofus.network.types.game.social.recruitment.SocialRecruitmentInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceRecruitmentInformation extends SocialRecruitmentInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4850;
       
      
      public function AllianceRecruitmentInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4850;
      }
      
      public function initAllianceRecruitmentInformation(socialId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriterion:Vector.<uint> = null, minLevel:uint = 0, minLevelFacultative:Boolean = false, invalidatedByModeration:Boolean = false, lastEditPlayerName:String = "", lastEditDate:Number = 0, recruitmentAutoLocked:Boolean = false) : AllianceRecruitmentInformation
      {
         super.initSocialRecruitmentInformation(socialId,recruitmentType,recruitmentTitle,recruitmentText,selectedLanguages,selectedCriterion,minLevel,minLevelFacultative,invalidatedByModeration,lastEditPlayerName,lastEditDate,recruitmentAutoLocked);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceRecruitmentInformation(output);
      }
      
      public function serializeAs_AllianceRecruitmentInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialRecruitmentInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceRecruitmentInformation(input);
      }
      
      public function deserializeAs_AllianceRecruitmentInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceRecruitmentInformation(tree);
      }
      
      public function deserializeAsyncAs_AllianceRecruitmentInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
