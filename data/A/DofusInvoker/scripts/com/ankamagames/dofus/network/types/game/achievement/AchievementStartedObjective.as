package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AchievementStartedObjective extends AchievementObjective implements INetworkType
   {
      
      public static const protocolId:uint = 5360;
       
      
      public var value:Number = 0;
      
      public function AchievementStartedObjective()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5360;
      }
      
      public function initAchievementStartedObjective(id:uint = 0, maxValue:Number = 0, value:Number = 0) : AchievementStartedObjective
      {
         super.initAchievementObjective(id,maxValue);
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementStartedObjective(output);
      }
      
      public function serializeAs_AchievementStartedObjective(output:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementObjective(output);
         if(this.value < 0 || this.value > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         output.writeVarLong(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementStartedObjective(input);
      }
      
      public function deserializeAs_AchievementStartedObjective(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AchievementStartedObjective(tree);
      }
      
      public function deserializeAsyncAs_AchievementStartedObjective(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readVarUhLong();
         if(this.value < 0 || this.value > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of AchievementStartedObjective.value.");
         }
      }
   }
}
