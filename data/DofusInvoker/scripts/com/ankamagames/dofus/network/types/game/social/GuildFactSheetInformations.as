package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildFactSheetInformations extends GuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3077;
       
      
      public var leaderId:Number = 0;
      
      public var nbMembers:uint = 0;
      
      public function GuildFactSheetInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3077;
      }
      
      public function initGuildFactSheetInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:GuildEmblem = null, leaderId:Number = 0, nbMembers:uint = 0) : GuildFactSheetInformations
      {
         super.initGuildInformations(guildId,guildName,guildLevel,guildEmblem);
         this.leaderId = leaderId;
         this.nbMembers = nbMembers;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.leaderId = 0;
         this.nbMembers = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildFactSheetInformations(output);
      }
      
      public function serializeAs_GuildFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildInformations(output);
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         output.writeVarLong(this.leaderId);
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeVarShort(this.nbMembers);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._leaderIdFunc(input);
         this._nbMembersFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._leaderIdFunc);
         tree.addChild(this._nbMembersFunc);
      }
      
      private function _leaderIdFunc(input:ICustomDataInput) : void
      {
         this.leaderId = input.readVarUhLong();
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of GuildFactSheetInformations.leaderId.");
         }
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readVarUhShort();
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildFactSheetInformations.nbMembers.");
         }
      }
   }
}
