package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildInsiderFactSheetInformations extends GuildFactSheetInformations implements INetworkType
   {
      
      public static const protocolId:uint = 574;
       
      
      public var leaderName:String = "";
      
      public var nbConnectedMembers:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var lastActivity:uint = 0;
      
      public function GuildInsiderFactSheetInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 574;
      }
      
      public function initGuildInsiderFactSheetInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:GuildEmblem = null, leaderId:Number = 0, nbMembers:uint = 0, leaderName:String = "", nbConnectedMembers:uint = 0, nbTaxCollectors:uint = 0, lastActivity:uint = 0) : GuildInsiderFactSheetInformations
      {
         super.initGuildFactSheetInformations(guildId,guildName,guildLevel,guildEmblem,leaderId,nbMembers);
         this.leaderName = leaderName;
         this.nbConnectedMembers = nbConnectedMembers;
         this.nbTaxCollectors = nbTaxCollectors;
         this.lastActivity = lastActivity;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.leaderName = "";
         this.nbConnectedMembers = 0;
         this.nbTaxCollectors = 0;
         this.lastActivity = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildInsiderFactSheetInformations(output);
      }
      
      public function serializeAs_GuildInsiderFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildFactSheetInformations(output);
         output.writeUTF(this.leaderName);
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element nbConnectedMembers.");
         }
         output.writeVarShort(this.nbConnectedMembers);
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
         }
         output.writeByte(this.nbTaxCollectors);
         if(this.lastActivity < 0)
         {
            throw new Error("Forbidden value (" + this.lastActivity + ") on element lastActivity.");
         }
         output.writeInt(this.lastActivity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInsiderFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildInsiderFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._leaderNameFunc(input);
         this._nbConnectedMembersFunc(input);
         this._nbTaxCollectorsFunc(input);
         this._lastActivityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInsiderFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildInsiderFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._leaderNameFunc);
         tree.addChild(this._nbConnectedMembersFunc);
         tree.addChild(this._nbTaxCollectorsFunc);
         tree.addChild(this._lastActivityFunc);
      }
      
      private function _leaderNameFunc(input:ICustomDataInput) : void
      {
         this.leaderName = input.readUTF();
      }
      
      private function _nbConnectedMembersFunc(input:ICustomDataInput) : void
      {
         this.nbConnectedMembers = input.readVarUhShort();
         if(this.nbConnectedMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element of GuildInsiderFactSheetInformations.nbConnectedMembers.");
         }
      }
      
      private function _nbTaxCollectorsFunc(input:ICustomDataInput) : void
      {
         this.nbTaxCollectors = input.readByte();
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildInsiderFactSheetInformations.nbTaxCollectors.");
         }
      }
      
      private function _lastActivityFunc(input:ICustomDataInput) : void
      {
         this.lastActivity = input.readInt();
         if(this.lastActivity < 0)
         {
            throw new Error("Forbidden value (" + this.lastActivity + ") on element of GuildInsiderFactSheetInformations.lastActivity.");
         }
      }
   }
}
