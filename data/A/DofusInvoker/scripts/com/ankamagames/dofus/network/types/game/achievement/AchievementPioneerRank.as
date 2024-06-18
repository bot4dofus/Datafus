package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementPioneerRank implements INetworkType
   {
      
      public static const protocolId:uint = 6487;
       
      
      public var achievementId:uint = 0;
      
      public var pioneerRank:uint = 0;
      
      public function AchievementPioneerRank()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6487;
      }
      
      public function initAchievementPioneerRank(achievementId:uint = 0, pioneerRank:uint = 0) : AchievementPioneerRank
      {
         this.achievementId = achievementId;
         this.pioneerRank = pioneerRank;
         return this;
      }
      
      public function reset() : void
      {
         this.achievementId = 0;
         this.pioneerRank = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementPioneerRank(output);
      }
      
      public function serializeAs_AchievementPioneerRank(output:ICustomDataOutput) : void
      {
         if(this.achievementId < 0)
         {
            throw new Error("Forbidden value (" + this.achievementId + ") on element achievementId.");
         }
         output.writeVarInt(this.achievementId);
         if(this.pioneerRank < 0)
         {
            throw new Error("Forbidden value (" + this.pioneerRank + ") on element pioneerRank.");
         }
         output.writeVarInt(this.pioneerRank);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementPioneerRank(input);
      }
      
      public function deserializeAs_AchievementPioneerRank(input:ICustomDataInput) : void
      {
         this._achievementIdFunc(input);
         this._pioneerRankFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementPioneerRank(tree);
      }
      
      public function deserializeAsyncAs_AchievementPioneerRank(tree:FuncTree) : void
      {
         tree.addChild(this._achievementIdFunc);
         tree.addChild(this._pioneerRankFunc);
      }
      
      private function _achievementIdFunc(input:ICustomDataInput) : void
      {
         this.achievementId = input.readVarUhInt();
         if(this.achievementId < 0)
         {
            throw new Error("Forbidden value (" + this.achievementId + ") on element of AchievementPioneerRank.achievementId.");
         }
      }
      
      private function _pioneerRankFunc(input:ICustomDataInput) : void
      {
         this.pioneerRank = input.readVarUhInt();
         if(this.pioneerRank < 0)
         {
            throw new Error("Forbidden value (" + this.pioneerRank + ") on element of AchievementPioneerRank.pioneerRank.");
         }
      }
   }
}
