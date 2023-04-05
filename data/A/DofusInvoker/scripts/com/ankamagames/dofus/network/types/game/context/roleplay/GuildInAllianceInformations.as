package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildInAllianceInformations extends GuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2149;
       
      
      public var nbMembers:uint = 0;
      
      public var joinDate:uint = 0;
      
      public function GuildInAllianceInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2149;
      }
      
      public function initGuildInAllianceInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:GuildEmblem = null, nbMembers:uint = 0, joinDate:uint = 0) : GuildInAllianceInformations
      {
         super.initGuildInformations(guildId,guildName,guildLevel,guildEmblem);
         this.nbMembers = nbMembers;
         this.joinDate = joinDate;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nbMembers = 0;
         this.joinDate = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildInAllianceInformations(output);
      }
      
      public function serializeAs_GuildInAllianceInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildInformations(output);
         if(this.nbMembers < 1 || this.nbMembers > 240)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeByte(this.nbMembers);
         if(this.joinDate < 0)
         {
            throw new Error("Forbidden value (" + this.joinDate + ") on element joinDate.");
         }
         output.writeInt(this.joinDate);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInAllianceInformations(input);
      }
      
      public function deserializeAs_GuildInAllianceInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nbMembersFunc(input);
         this._joinDateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInAllianceInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildInAllianceInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nbMembersFunc);
         tree.addChild(this._joinDateFunc);
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readUnsignedByte();
         if(this.nbMembers < 1 || this.nbMembers > 240)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildInAllianceInformations.nbMembers.");
         }
      }
      
      private function _joinDateFunc(input:ICustomDataInput) : void
      {
         this.joinDate = input.readInt();
         if(this.joinDate < 0)
         {
            throw new Error("Forbidden value (" + this.joinDate + ") on element of GuildInAllianceInformations.joinDate.");
         }
      }
   }
}
