package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.dofus.network.types.game.rank.RankMinimalInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildRankActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3270;
       
      
      public var rankActivityType:uint = 0;
      
      public var guildRankMinimalInfos:RankMinimalInformation;
      
      private var _guildRankMinimalInfostree:FuncTree;
      
      public function GuildRankActivity()
      {
         this.guildRankMinimalInfos = new RankMinimalInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3270;
      }
      
      public function initGuildRankActivity(id:uint = 0, date:Number = 0, rankActivityType:uint = 0, guildRankMinimalInfos:RankMinimalInformation = null) : GuildRankActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.rankActivityType = rankActivityType;
         this.guildRankMinimalInfos = guildRankMinimalInfos;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rankActivityType = 0;
         this.guildRankMinimalInfos = new RankMinimalInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildRankActivity(output);
      }
      
      public function serializeAs_GuildRankActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         output.writeByte(this.rankActivityType);
         this.guildRankMinimalInfos.serializeAs_RankMinimalInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildRankActivity(input);
      }
      
      public function deserializeAs_GuildRankActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._rankActivityTypeFunc(input);
         this.guildRankMinimalInfos = new RankMinimalInformation();
         this.guildRankMinimalInfos.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildRankActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildRankActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._rankActivityTypeFunc);
         this._guildRankMinimalInfostree = tree.addChild(this._guildRankMinimalInfostreeFunc);
      }
      
      private function _rankActivityTypeFunc(input:ICustomDataInput) : void
      {
         this.rankActivityType = input.readByte();
         if(this.rankActivityType < 0)
         {
            throw new Error("Forbidden value (" + this.rankActivityType + ") on element of GuildRankActivity.rankActivityType.");
         }
      }
      
      private function _guildRankMinimalInfostreeFunc(input:ICustomDataInput) : void
      {
         this.guildRankMinimalInfos = new RankMinimalInformation();
         this.guildRankMinimalInfos.deserializeAsync(this._guildRankMinimalInfostree);
      }
   }
}
