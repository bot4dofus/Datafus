package com.ankamagames.dofus.network.types.game.guild.recruitment
{
   import com.ankamagames.dofus.network.types.game.social.recruitment.SocialRecruitmentInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildRecruitmentInformation extends SocialRecruitmentInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5578;
       
      
      public var minSuccess:uint = 0;
      
      public var minSuccessFacultative:Boolean = false;
      
      public function GuildRecruitmentInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5578;
      }
      
      public function initGuildRecruitmentInformation(socialId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriterion:Vector.<uint> = null, minLevel:uint = 0, minLevelFacultative:Boolean = false, invalidatedByModeration:Boolean = false, lastEditPlayerName:String = "", lastEditDate:Number = 0, recruitmentAutoLocked:Boolean = false, minSuccess:uint = 0, minSuccessFacultative:Boolean = false) : GuildRecruitmentInformation
      {
         super.initSocialRecruitmentInformation(socialId,recruitmentType,recruitmentTitle,recruitmentText,selectedLanguages,selectedCriterion,minLevel,minLevelFacultative,invalidatedByModeration,lastEditPlayerName,lastEditDate,recruitmentAutoLocked);
         this.minSuccess = minSuccess;
         this.minSuccessFacultative = minSuccessFacultative;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.minSuccess = 0;
         this.minSuccessFacultative = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildRecruitmentInformation(output);
      }
      
      public function serializeAs_GuildRecruitmentInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialRecruitmentInformation(output);
         if(this.minSuccess < 0)
         {
            throw new Error("Forbidden value (" + this.minSuccess + ") on element minSuccess.");
         }
         output.writeVarInt(this.minSuccess);
         output.writeBoolean(this.minSuccessFacultative);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildRecruitmentInformation(input);
      }
      
      public function deserializeAs_GuildRecruitmentInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._minSuccessFunc(input);
         this._minSuccessFacultativeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildRecruitmentInformation(tree);
      }
      
      public function deserializeAsyncAs_GuildRecruitmentInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._minSuccessFunc);
         tree.addChild(this._minSuccessFacultativeFunc);
      }
      
      private function _minSuccessFunc(input:ICustomDataInput) : void
      {
         this.minSuccess = input.readVarUhInt();
         if(this.minSuccess < 0)
         {
            throw new Error("Forbidden value (" + this.minSuccess + ") on element of GuildRecruitmentInformation.minSuccess.");
         }
      }
      
      private function _minSuccessFacultativeFunc(input:ICustomDataInput) : void
      {
         this.minSuccessFacultative = input.readBoolean();
      }
   }
}
