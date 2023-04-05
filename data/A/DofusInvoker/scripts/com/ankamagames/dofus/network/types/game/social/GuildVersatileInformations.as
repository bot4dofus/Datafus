package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildVersatileInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1609;
       
      
      public var guildId:uint = 0;
      
      public var leaderId:Number = 0;
      
      public var guildLevel:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public function GuildVersatileInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1609;
      }
      
      public function initGuildVersatileInformations(guildId:uint = 0, leaderId:Number = 0, guildLevel:uint = 0, nbMembers:uint = 0) : GuildVersatileInformations
      {
         this.guildId = guildId;
         this.leaderId = leaderId;
         this.guildLevel = guildLevel;
         this.nbMembers = nbMembers;
         return this;
      }
      
      public function reset() : void
      {
         this.guildId = 0;
         this.leaderId = 0;
         this.guildLevel = 0;
         this.nbMembers = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildVersatileInformations(output);
      }
      
      public function serializeAs_GuildVersatileInformations(output:ICustomDataOutput) : void
      {
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         output.writeVarLong(this.leaderId);
         if(this.guildLevel < 1 || this.guildLevel > 200)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         output.writeByte(this.guildLevel);
         if(this.nbMembers < 1 || this.nbMembers > 240)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeByte(this.nbMembers);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildVersatileInformations(input);
      }
      
      public function deserializeAs_GuildVersatileInformations(input:ICustomDataInput) : void
      {
         this._guildIdFunc(input);
         this._leaderIdFunc(input);
         this._guildLevelFunc(input);
         this._nbMembersFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildVersatileInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildVersatileInformations(tree:FuncTree) : void
      {
         tree.addChild(this._guildIdFunc);
         tree.addChild(this._leaderIdFunc);
         tree.addChild(this._guildLevelFunc);
         tree.addChild(this._nbMembersFunc);
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildVersatileInformations.guildId.");
         }
      }
      
      private function _leaderIdFunc(input:ICustomDataInput) : void
      {
         this.leaderId = input.readVarUhLong();
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of GuildVersatileInformations.leaderId.");
         }
      }
      
      private function _guildLevelFunc(input:ICustomDataInput) : void
      {
         this.guildLevel = input.readUnsignedByte();
         if(this.guildLevel < 1 || this.guildLevel > 200)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GuildVersatileInformations.guildLevel.");
         }
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readUnsignedByte();
         if(this.nbMembers < 1 || this.nbMembers > 240)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildVersatileInformations.nbMembers.");
         }
      }
   }
}
