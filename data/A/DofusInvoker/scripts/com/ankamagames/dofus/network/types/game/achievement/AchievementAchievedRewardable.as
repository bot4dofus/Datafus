package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementAchievedRewardable extends AchievementAchieved implements INetworkType
   {
      
      public static const protocolId:uint = 6359;
       
      
      public var finishedLevel:uint = 0;
      
      public function AchievementAchievedRewardable()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6359;
      }
      
      public function initAchievementAchievedRewardable(id:uint = 0, achievedBy:Number = 0, achievedPioneerRank:uint = 0, finishedLevel:uint = 0) : AchievementAchievedRewardable
      {
         super.initAchievementAchieved(id,achievedBy,achievedPioneerRank);
         this.finishedLevel = finishedLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.finishedLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementAchievedRewardable(output);
      }
      
      public function serializeAs_AchievementAchievedRewardable(output:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementAchieved(output);
         if(this.finishedLevel < 0 || this.finishedLevel > 200)
         {
            throw new Error("Forbidden value (" + this.finishedLevel + ") on element finishedLevel.");
         }
         output.writeVarShort(this.finishedLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementAchievedRewardable(input);
      }
      
      public function deserializeAs_AchievementAchievedRewardable(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._finishedLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementAchievedRewardable(tree);
      }
      
      public function deserializeAsyncAs_AchievementAchievedRewardable(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._finishedLevelFunc);
      }
      
      private function _finishedLevelFunc(input:ICustomDataInput) : void
      {
         this.finishedLevel = input.readVarUhShort();
         if(this.finishedLevel < 0 || this.finishedLevel > 200)
         {
            throw new Error("Forbidden value (" + this.finishedLevel + ") on element of AchievementAchievedRewardable.finishedLevel.");
         }
      }
   }
}
