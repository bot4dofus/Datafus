package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementAchievedRewardable extends AchievementAchieved implements INetworkType
   {
      
      public static const protocolId:uint = 3393;
       
      
      public var finishedlevel:uint = 0;
      
      public function AchievementAchievedRewardable()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3393;
      }
      
      public function initAchievementAchievedRewardable(id:uint = 0, achievedBy:Number = 0, finishedlevel:uint = 0) : AchievementAchievedRewardable
      {
         super.initAchievementAchieved(id,achievedBy);
         this.finishedlevel = finishedlevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.finishedlevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementAchievedRewardable(output);
      }
      
      public function serializeAs_AchievementAchievedRewardable(output:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementAchieved(output);
         if(this.finishedlevel < 0 || this.finishedlevel > 200)
         {
            throw new Error("Forbidden value (" + this.finishedlevel + ") on element finishedlevel.");
         }
         output.writeVarShort(this.finishedlevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementAchievedRewardable(input);
      }
      
      public function deserializeAs_AchievementAchievedRewardable(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._finishedlevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementAchievedRewardable(tree);
      }
      
      public function deserializeAsyncAs_AchievementAchievedRewardable(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._finishedlevelFunc);
      }
      
      private function _finishedlevelFunc(input:ICustomDataInput) : void
      {
         this.finishedlevel = input.readVarUhShort();
         if(this.finishedlevel < 0 || this.finishedlevel > 200)
         {
            throw new Error("Forbidden value (" + this.finishedlevel + ") on element of AchievementAchievedRewardable.finishedlevel.");
         }
      }
   }
}
