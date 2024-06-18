package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.dofus.network.types.game.character.guild.note.PlayerNote;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.social.SocialMember;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildMemberInfo extends SocialMember implements INetworkType
   {
      
      public static const protocolId:uint = 4949;
       
      
      public var givenExperience:Number = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public var alignmentSide:int = 0;
      
      public var moodSmileyId:uint = 0;
      
      public var achievementPoints:int = 0;
      
      public var havenBagShared:Boolean = false;
      
      public var note:PlayerNote;
      
      private var _notetree:FuncTree;
      
      public function GuildMemberInfo()
      {
         this.note = new PlayerNote();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4949;
      }
      
      public function initGuildMemberInfo(id:Number = 0, name:String = "", level:uint = 0, breed:int = 0, sex:Boolean = false, connected:uint = 99, hoursSinceLastConnection:uint = 0, accountId:uint = 0, status:PlayerStatus = null, rankId:int = 0, enrollmentDate:Number = 0, givenExperience:Number = 0, experienceGivenPercent:uint = 0, alignmentSide:int = 0, moodSmileyId:uint = 0, achievementPoints:int = 0, havenBagShared:Boolean = false, note:PlayerNote = null) : GuildMemberInfo
      {
         super.initSocialMember(id,name,level,breed,sex,connected,hoursSinceLastConnection,accountId,status,rankId,enrollmentDate);
         this.givenExperience = givenExperience;
         this.experienceGivenPercent = experienceGivenPercent;
         this.alignmentSide = alignmentSide;
         this.moodSmileyId = moodSmileyId;
         this.achievementPoints = achievementPoints;
         this.havenBagShared = havenBagShared;
         this.note = note;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.givenExperience = 0;
         this.experienceGivenPercent = 0;
         this.alignmentSide = 0;
         this.moodSmileyId = 0;
         this.achievementPoints = 0;
         this.havenBagShared = false;
         this.note = new PlayerNote();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildMemberInfo(output);
      }
      
      public function serializeAs_GuildMemberInfo(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialMember(output);
         if(this.givenExperience < 0 || this.givenExperience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.givenExperience + ") on element givenExperience.");
         }
         output.writeVarLong(this.givenExperience);
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
         }
         output.writeByte(this.experienceGivenPercent);
         output.writeByte(this.alignmentSide);
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element moodSmileyId.");
         }
         output.writeVarShort(this.moodSmileyId);
         output.writeInt(this.achievementPoints);
         output.writeBoolean(this.havenBagShared);
         this.note.serializeAs_PlayerNote(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMemberInfo(input);
      }
      
      public function deserializeAs_GuildMemberInfo(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._givenExperienceFunc(input);
         this._experienceGivenPercentFunc(input);
         this._alignmentSideFunc(input);
         this._moodSmileyIdFunc(input);
         this._achievementPointsFunc(input);
         this._havenBagSharedFunc(input);
         this.note = new PlayerNote();
         this.note.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildMemberInfo(tree);
      }
      
      public function deserializeAsyncAs_GuildMemberInfo(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._givenExperienceFunc);
         tree.addChild(this._experienceGivenPercentFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._moodSmileyIdFunc);
         tree.addChild(this._achievementPointsFunc);
         tree.addChild(this._havenBagSharedFunc);
         this._notetree = tree.addChild(this._notetreeFunc);
      }
      
      private function _givenExperienceFunc(input:ICustomDataInput) : void
      {
         this.givenExperience = input.readVarUhLong();
         if(this.givenExperience < 0 || this.givenExperience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.givenExperience + ") on element of GuildMemberInfo.givenExperience.");
         }
      }
      
      private function _experienceGivenPercentFunc(input:ICustomDataInput) : void
      {
         this.experienceGivenPercent = input.readByte();
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildMemberInfo.experienceGivenPercent.");
         }
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _moodSmileyIdFunc(input:ICustomDataInput) : void
      {
         this.moodSmileyId = input.readVarUhShort();
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element of GuildMemberInfo.moodSmileyId.");
         }
      }
      
      private function _achievementPointsFunc(input:ICustomDataInput) : void
      {
         this.achievementPoints = input.readInt();
      }
      
      private function _havenBagSharedFunc(input:ICustomDataInput) : void
      {
         this.havenBagShared = input.readBoolean();
      }
      
      private function _notetreeFunc(input:ICustomDataInput) : void
      {
         this.note = new PlayerNote();
         this.note.deserializeAsync(this._notetree);
      }
   }
}
