package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FriendSpouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8260;
       
      
      public var spouseAccountId:uint = 0;
      
      public var spouseId:Number = 0;
      
      public var spouseName:String = "";
      
      public var spouseLevel:uint = 0;
      
      public var breed:int = 0;
      
      public var sex:int = 0;
      
      public var spouseEntityLook:EntityLook;
      
      public var guildInfo:GuildInformations;
      
      public var alignmentSide:int = 0;
      
      private var _spouseEntityLooktree:FuncTree;
      
      private var _guildInfotree:FuncTree;
      
      public function FriendSpouseInformations()
      {
         this.spouseEntityLook = new EntityLook();
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8260;
      }
      
      public function initFriendSpouseInformations(spouseAccountId:uint = 0, spouseId:Number = 0, spouseName:String = "", spouseLevel:uint = 0, breed:int = 0, sex:int = 0, spouseEntityLook:EntityLook = null, guildInfo:GuildInformations = null, alignmentSide:int = 0) : FriendSpouseInformations
      {
         this.spouseAccountId = spouseAccountId;
         this.spouseId = spouseId;
         this.spouseName = spouseName;
         this.spouseLevel = spouseLevel;
         this.breed = breed;
         this.sex = sex;
         this.spouseEntityLook = spouseEntityLook;
         this.guildInfo = guildInfo;
         this.alignmentSide = alignmentSide;
         return this;
      }
      
      public function reset() : void
      {
         this.spouseAccountId = 0;
         this.spouseId = 0;
         this.spouseName = "";
         this.spouseLevel = 0;
         this.breed = 0;
         this.sex = 0;
         this.spouseEntityLook = new EntityLook();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FriendSpouseInformations(output);
      }
      
      public function serializeAs_FriendSpouseInformations(output:ICustomDataOutput) : void
      {
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element spouseAccountId.");
         }
         output.writeInt(this.spouseAccountId);
         if(this.spouseId < 0 || this.spouseId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.spouseId + ") on element spouseId.");
         }
         output.writeVarLong(this.spouseId);
         output.writeUTF(this.spouseName);
         if(this.spouseLevel < 0)
         {
            throw new Error("Forbidden value (" + this.spouseLevel + ") on element spouseLevel.");
         }
         output.writeVarShort(this.spouseLevel);
         output.writeByte(this.breed);
         output.writeByte(this.sex);
         this.spouseEntityLook.serializeAs_EntityLook(output);
         this.guildInfo.serializeAs_GuildInformations(output);
         output.writeByte(this.alignmentSide);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSpouseInformations(input);
      }
      
      public function deserializeAs_FriendSpouseInformations(input:ICustomDataInput) : void
      {
         this._spouseAccountIdFunc(input);
         this._spouseIdFunc(input);
         this._spouseNameFunc(input);
         this._spouseLevelFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this.spouseEntityLook = new EntityLook();
         this.spouseEntityLook.deserialize(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
         this._alignmentSideFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendSpouseInformations(tree);
      }
      
      public function deserializeAsyncAs_FriendSpouseInformations(tree:FuncTree) : void
      {
         tree.addChild(this._spouseAccountIdFunc);
         tree.addChild(this._spouseIdFunc);
         tree.addChild(this._spouseNameFunc);
         tree.addChild(this._spouseLevelFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         this._spouseEntityLooktree = tree.addChild(this._spouseEntityLooktreeFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
         tree.addChild(this._alignmentSideFunc);
      }
      
      private function _spouseAccountIdFunc(input:ICustomDataInput) : void
      {
         this.spouseAccountId = input.readInt();
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element of FriendSpouseInformations.spouseAccountId.");
         }
      }
      
      private function _spouseIdFunc(input:ICustomDataInput) : void
      {
         this.spouseId = input.readVarUhLong();
         if(this.spouseId < 0 || this.spouseId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.spouseId + ") on element of FriendSpouseInformations.spouseId.");
         }
      }
      
      private function _spouseNameFunc(input:ICustomDataInput) : void
      {
         this.spouseName = input.readUTF();
      }
      
      private function _spouseLevelFunc(input:ICustomDataInput) : void
      {
         this.spouseLevel = input.readVarUhShort();
         if(this.spouseLevel < 0)
         {
            throw new Error("Forbidden value (" + this.spouseLevel + ") on element of FriendSpouseInformations.spouseLevel.");
         }
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readByte();
      }
      
      private function _spouseEntityLooktreeFunc(input:ICustomDataInput) : void
      {
         this.spouseEntityLook = new EntityLook();
         this.spouseEntityLook.deserializeAsync(this._spouseEntityLooktree);
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
   }
}
