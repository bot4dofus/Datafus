package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialMember extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9920;
       
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var connected:uint = 99;
      
      public var hoursSinceLastConnection:uint = 0;
      
      public var accountId:uint = 0;
      
      public var status:PlayerStatus;
      
      public var rankId:int = 0;
      
      public var enrollmentDate:Number = 0;
      
      private var _statustree:FuncTree;
      
      public function SocialMember()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9920;
      }
      
      public function initSocialMember(id:Number = 0, name:String = "", level:uint = 0, breed:int = 0, sex:Boolean = false, connected:uint = 99, hoursSinceLastConnection:uint = 0, accountId:uint = 0, status:PlayerStatus = null, rankId:int = 0, enrollmentDate:Number = 0) : SocialMember
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.breed = breed;
         this.sex = sex;
         this.connected = connected;
         this.hoursSinceLastConnection = hoursSinceLastConnection;
         this.accountId = accountId;
         this.status = status;
         this.rankId = rankId;
         this.enrollmentDate = enrollmentDate;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.breed = 0;
         this.sex = false;
         this.connected = 99;
         this.hoursSinceLastConnection = 0;
         this.accountId = 0;
         this.status = new PlayerStatus();
         this.enrollmentDate = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialMember(output);
      }
      
      public function serializeAs_SocialMember(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         output.writeByte(this.connected);
         if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
         {
            throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element hoursSinceLastConnection.");
         }
         output.writeShort(this.hoursSinceLastConnection);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
         output.writeInt(this.rankId);
         if(this.enrollmentDate < -9007199254740992 || this.enrollmentDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.enrollmentDate + ") on element enrollmentDate.");
         }
         output.writeDouble(this.enrollmentDate);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialMember(input);
      }
      
      public function deserializeAs_SocialMember(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._connectedFunc(input);
         this._hoursSinceLastConnectionFunc(input);
         this._accountIdFunc(input);
         var _id6:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id6);
         this.status.deserialize(input);
         this._rankIdFunc(input);
         this._enrollmentDateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialMember(tree);
      }
      
      public function deserializeAsyncAs_SocialMember(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._connectedFunc);
         tree.addChild(this._hoursSinceLastConnectionFunc);
         tree.addChild(this._accountIdFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
         tree.addChild(this._rankIdFunc);
         tree.addChild(this._enrollmentDateFunc);
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _connectedFunc(input:ICustomDataInput) : void
      {
         this.connected = input.readByte();
         if(this.connected < 0)
         {
            throw new Error("Forbidden value (" + this.connected + ") on element of SocialMember.connected.");
         }
      }
      
      private function _hoursSinceLastConnectionFunc(input:ICustomDataInput) : void
      {
         this.hoursSinceLastConnection = input.readUnsignedShort();
         if(this.hoursSinceLastConnection < 0 || this.hoursSinceLastConnection > 65535)
         {
            throw new Error("Forbidden value (" + this.hoursSinceLastConnection + ") on element of SocialMember.hoursSinceLastConnection.");
         }
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of SocialMember.accountId.");
         }
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readInt();
      }
      
      private function _enrollmentDateFunc(input:ICustomDataInput) : void
      {
         this.enrollmentDate = input.readDouble();
         if(this.enrollmentDate < -9007199254740992 || this.enrollmentDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.enrollmentDate + ") on element of SocialMember.enrollmentDate.");
         }
      }
   }
}
