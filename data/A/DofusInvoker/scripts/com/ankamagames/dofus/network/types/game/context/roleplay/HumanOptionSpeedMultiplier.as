package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionSpeedMultiplier extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 4364;
       
      
      public var speedMultiplier:uint = 0;
      
      public function HumanOptionSpeedMultiplier()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4364;
      }
      
      public function initHumanOptionSpeedMultiplier(speedMultiplier:uint = 0) : HumanOptionSpeedMultiplier
      {
         this.speedMultiplier = speedMultiplier;
         return this;
      }
      
      override public function reset() : void
      {
         this.speedMultiplier = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionSpeedMultiplier(output);
      }
      
      public function serializeAs_HumanOptionSpeedMultiplier(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         if(this.speedMultiplier < 0)
         {
            throw new Error("Forbidden value (" + this.speedMultiplier + ") on element speedMultiplier.");
         }
         output.writeVarInt(this.speedMultiplier);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionSpeedMultiplier(input);
      }
      
      public function deserializeAs_HumanOptionSpeedMultiplier(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._speedMultiplierFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionSpeedMultiplier(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionSpeedMultiplier(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._speedMultiplierFunc);
      }
      
      private function _speedMultiplierFunc(input:ICustomDataInput) : void
      {
         this.speedMultiplier = input.readVarUhInt();
         if(this.speedMultiplier < 0)
         {
            throw new Error("Forbidden value (" + this.speedMultiplier + ") on element of HumanOptionSpeedMultiplier.speedMultiplier.");
         }
      }
   }
}
