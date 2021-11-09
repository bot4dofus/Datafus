package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildMember extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4858;
       
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var rank:uint = 0;
      
      public var givenExperience:Number = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public var rights:uint = 0;
      
      public var connected:uint = 99;
      
      public var alignmentSide:int = 0;
      
      public var hoursSinceLastConnection:uint = 0;
      
      public var moodSmileyId:uint = 0;
      
      public var accountId:uint = 0;
      
      public var achievementPoints:int = 0;
      
      public var status:PlayerStatus;
      
      public var havenBagShared:Boolean = false;
      
      private var _statustree:FuncTree;
      
      public function GuildMember()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4858;
      }
      
      public function initGuildMember(id:Number = 0, name:String = "", level:uint = 0, breed:int = 0, sex:Boolean = false, rank:uint = 0, givenExperience:Number = 0, experienceGivenPercent:uint = 0, rights:uint = 0, connected:uint = 99, alignmentSide:int = 0, hoursSinceLastConnection:uint = 0, moodSmileyId:uint = 0, accountId:uint = 0, achievementPoints:int = 0, status:PlayerStatus = null, havenBagShared:Boolean = false) : GuildMember
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.breed = breed;
         this.sex = sex;
         this.rank = rank;
         this.givenExperience = givenExperience;
         this.experienceGivenPercent = experienceGivenPercent;
         this.rights = rights;
         this.connected = connected;
         this.alignmentSide = alignmentSide;
         this.hoursSinceLastConnection = hoursSinceLastConnection;
         this.moodSmileyId = moodSmileyId;
         this.accountId = accountId;
         this.achievementPoints = achievementPoints;
         this.status = status;
         this.havenBagShared = havenBagShared;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.breed = 0;
         this.sex = false;
         this.rank = 0;
         this.givenExperience = 0;
         this.experienceGivenPercent = 0;
         this.rights = 0;
         this.connected = 99;
         this.alignmentSide = 0;
         this.hoursSinceLastConnection = 0;
         this.moodSmileyId = 0;
         this.accountId = 0;
         this.achievementPoints = 0;
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildMember(output);
      }
      
      public function serializeAs_GuildMember(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.havenBagShared);
         output.writeByte(_box0);
         output.writeByte(this.breed);
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarShort(this.rank);
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
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         output.writeVarInt(this.rights);
         output.writeByte(this.connected);
         output.writeByte(this.alignmentSide);
         if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
         {
            throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element hoursSinceLastConnection.");
         }
         output.writeShort(this.hoursSinceLastConnection);
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element moodSmileyId.");
         }
         output.writeVarShort(this.moodSmileyId);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         output.writeInt(this.achievementPoints);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMember(input);
      }
      
      public function deserializeAs_GuildMember(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._breedFunc(input);
         this._rankFunc(input);
         this._givenExperienceFunc(input);
         this._experienceGivenPercentFunc(input);
         this._rightsFunc(input);
         this._connectedFunc(input);
         this._alignmentSideFunc(input);
         this._hoursSinceLastConnectionFunc(input);
         this._moodSmileyIdFunc(input);
         this._accountIdFunc(input);
         this._achievementPointsFunc(input);
         var _id13:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id13);
         this.status.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildMember(tree);
      }
      
      public function deserializeAsyncAs_GuildMember(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._breedFunc);
         tree.addChild(this._rankFunc);
         tree.addChild(this._givenExperienceFunc);
         tree.addChild(this._experienceGivenPercentFunc);
         tree.addChild(this._rightsFunc);
         tree.addChild(this._connectedFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._hoursSinceLastConnectionFunc);
         tree.addChild(this._moodSmileyIdFunc);
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._achievementPointsFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.havenBagShared = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhShort();
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of GuildMember.rank.");
         }
      }
      
      private function _givenExperienceFunc(input:ICustomDataInput) : void
      {
         this.givenExperience = input.readVarUhLong();
         if(this.givenExperience < 0 || this.givenExperience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.givenExperience + ") on element of GuildMember.givenExperience.");
         }
      }
      
      private function _experienceGivenPercentFunc(input:ICustomDataInput) : void
      {
         this.experienceGivenPercent = input.readByte();
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildMember.experienceGivenPercent.");
         }
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         this.rights = input.readVarUhInt();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of GuildMember.rights.");
         }
      }
      
      private function _connectedFunc(input:ICustomDataInput) : void
      {
         this.connected = input.readByte();
         if(this.connected < 0)
         {
            throw new Error("Forbidden value (" + this.connected + ") on element of GuildMember.connected.");
         }
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _hoursSinceLastConnectionFunc(input:ICustomDataInput) : void
      {
         this.hoursSinceLastConnection = input.readUnsignedShort();
         if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
         {
            throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element of GuildMember.hoursSinceLastConnection.");
         }
      }
      
      private function _moodSmileyIdFunc(input:ICustomDataInput) : void
      {
         this.moodSmileyId = input.readVarUhShort();
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element of GuildMember.moodSmileyId.");
         }
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of GuildMember.accountId.");
         }
      }
      
      private function _achievementPointsFunc(input:ICustomDataInput) : void
      {
         this.achievementPoints = input.readInt();
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}
