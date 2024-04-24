package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementAchieved implements INetworkType
   {
      
      public static const protocolId:uint = 6128;
       
      
      public var id:uint = 0;
      
      public var achievedBy:Number = 0;
      
      public var achievedPioneerRank:uint = 0;
      
      public function AchievementAchieved()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6128;
      }
      
      public function initAchievementAchieved(id:uint = 0, achievedBy:Number = 0, achievedPioneerRank:uint = 0) : AchievementAchieved
      {
         this.id = id;
         this.achievedBy = achievedBy;
         this.achievedPioneerRank = achievedPioneerRank;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.achievedBy = 0;
         this.achievedPioneerRank = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementAchieved(output);
      }
      
      public function serializeAs_AchievementAchieved(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         if(this.achievedBy < 0 || this.achievedBy > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.achievedBy + ") on element achievedBy.");
         }
         output.writeVarLong(this.achievedBy);
         if(this.achievedPioneerRank < 0)
         {
            throw new Error("Forbidden value (" + this.achievedPioneerRank + ") on element achievedPioneerRank.");
         }
         output.writeVarInt(this.achievedPioneerRank);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementAchieved(input);
      }
      
      public function deserializeAs_AchievementAchieved(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._achievedByFunc(input);
         this._achievedPioneerRankFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementAchieved(tree);
      }
      
      public function deserializeAsyncAs_AchievementAchieved(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._achievedByFunc);
         tree.addChild(this._achievedPioneerRankFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AchievementAchieved.id.");
         }
      }
      
      private function _achievedByFunc(input:ICustomDataInput) : void
      {
         this.achievedBy = input.readVarUhLong();
         if(this.achievedBy < 0 || this.achievedBy > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.achievedBy + ") on element of AchievementAchieved.achievedBy.");
         }
      }
      
      private function _achievedPioneerRankFunc(input:ICustomDataInput) : void
      {
         this.achievedPioneerRank = input.readVarUhInt();
         if(this.achievedPioneerRank < 0)
         {
            throw new Error("Forbidden value (" + this.achievedPioneerRank + ") on element of AchievementAchieved.achievedPioneerRank.");
         }
      }
   }
}
