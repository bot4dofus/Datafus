package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementObjective implements INetworkType
   {
      
      public static const protocolId:uint = 2521;
       
      
      public var id:uint = 0;
      
      public var maxValue:Number = 0;
      
      public function AchievementObjective()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2521;
      }
      
      public function initAchievementObjective(id:uint = 0, maxValue:Number = 0) : AchievementObjective
      {
         this.id = id;
         this.maxValue = maxValue;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.maxValue = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementObjective(output);
      }
      
      public function serializeAs_AchievementObjective(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         if(this.maxValue < 0 || this.maxValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxValue + ") on element maxValue.");
         }
         output.writeVarLong(this.maxValue);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementObjective(input);
      }
      
      public function deserializeAs_AchievementObjective(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._maxValueFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementObjective(tree);
      }
      
      public function deserializeAsyncAs_AchievementObjective(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._maxValueFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AchievementObjective.id.");
         }
      }
      
      private function _maxValueFunc(input:ICustomDataInput) : void
      {
         this.maxValue = input.readVarUhLong();
         if(this.maxValue < 0 || this.maxValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxValue + ") on element of AchievementObjective.maxValue.");
         }
      }
   }
}
