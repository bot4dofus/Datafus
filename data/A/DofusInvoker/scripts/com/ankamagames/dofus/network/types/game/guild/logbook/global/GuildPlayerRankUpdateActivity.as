package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.dofus.network.types.game.rank.RankMinimalInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildPlayerRankUpdateActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 7813;
       
      
      public var guildRankMinimalInfos:RankMinimalInformation;
      
      public var sourcePlayerId:Number = 0;
      
      public var targetPlayerId:Number = 0;
      
      public var sourcePlayerName:String = "";
      
      public var targetPlayerName:String = "";
      
      private var _guildRankMinimalInfostree:FuncTree;
      
      public function GuildPlayerRankUpdateActivity()
      {
         this.guildRankMinimalInfos = new RankMinimalInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7813;
      }
      
      public function initGuildPlayerRankUpdateActivity(id:uint = 0, date:Number = 0, guildRankMinimalInfos:RankMinimalInformation = null, sourcePlayerId:Number = 0, targetPlayerId:Number = 0, sourcePlayerName:String = "", targetPlayerName:String = "") : GuildPlayerRankUpdateActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.guildRankMinimalInfos = guildRankMinimalInfos;
         this.sourcePlayerId = sourcePlayerId;
         this.targetPlayerId = targetPlayerId;
         this.sourcePlayerName = sourcePlayerName;
         this.targetPlayerName = targetPlayerName;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guildRankMinimalInfos = new RankMinimalInformation();
         this.targetPlayerId = 0;
         this.sourcePlayerName = "";
         this.targetPlayerName = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildPlayerRankUpdateActivity(output);
      }
      
      public function serializeAs_GuildPlayerRankUpdateActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         this.guildRankMinimalInfos.serializeAs_RankMinimalInformation(output);
         if(this.sourcePlayerId < 0 || this.sourcePlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourcePlayerId + ") on element sourcePlayerId.");
         }
         output.writeVarLong(this.sourcePlayerId);
         if(this.targetPlayerId < 0 || this.targetPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetPlayerId + ") on element targetPlayerId.");
         }
         output.writeVarLong(this.targetPlayerId);
         output.writeUTF(this.sourcePlayerName);
         output.writeUTF(this.targetPlayerName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildPlayerRankUpdateActivity(input);
      }
      
      public function deserializeAs_GuildPlayerRankUpdateActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guildRankMinimalInfos = new RankMinimalInformation();
         this.guildRankMinimalInfos.deserialize(input);
         this._sourcePlayerIdFunc(input);
         this._targetPlayerIdFunc(input);
         this._sourcePlayerNameFunc(input);
         this._targetPlayerNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildPlayerRankUpdateActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildPlayerRankUpdateActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildRankMinimalInfostree = tree.addChild(this._guildRankMinimalInfostreeFunc);
         tree.addChild(this._sourcePlayerIdFunc);
         tree.addChild(this._targetPlayerIdFunc);
         tree.addChild(this._sourcePlayerNameFunc);
         tree.addChild(this._targetPlayerNameFunc);
      }
      
      private function _guildRankMinimalInfostreeFunc(input:ICustomDataInput) : void
      {
         this.guildRankMinimalInfos = new RankMinimalInformation();
         this.guildRankMinimalInfos.deserializeAsync(this._guildRankMinimalInfostree);
      }
      
      private function _sourcePlayerIdFunc(input:ICustomDataInput) : void
      {
         this.sourcePlayerId = input.readVarUhLong();
         if(this.sourcePlayerId < 0 || this.sourcePlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourcePlayerId + ") on element of GuildPlayerRankUpdateActivity.sourcePlayerId.");
         }
      }
      
      private function _targetPlayerIdFunc(input:ICustomDataInput) : void
      {
         this.targetPlayerId = input.readVarUhLong();
         if(this.targetPlayerId < 0 || this.targetPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetPlayerId + ") on element of GuildPlayerRankUpdateActivity.targetPlayerId.");
         }
      }
      
      private function _sourcePlayerNameFunc(input:ICustomDataInput) : void
      {
         this.sourcePlayerName = input.readUTF();
      }
      
      private function _targetPlayerNameFunc(input:ICustomDataInput) : void
      {
         this.targetPlayerName = input.readUTF();
      }
   }
}
