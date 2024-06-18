package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AnomalySubareaInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4038;
       
      
      public var subAreaId:uint = 0;
      
      public var rewardRate:int = 0;
      
      public var hasAnomaly:Boolean = false;
      
      public var anomalyClosingTime:Number = 0;
      
      public function AnomalySubareaInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4038;
      }
      
      public function initAnomalySubareaInformation(subAreaId:uint = 0, rewardRate:int = 0, hasAnomaly:Boolean = false, anomalyClosingTime:Number = 0) : AnomalySubareaInformation
      {
         this.subAreaId = subAreaId;
         this.rewardRate = rewardRate;
         this.hasAnomaly = hasAnomaly;
         this.anomalyClosingTime = anomalyClosingTime;
         return this;
      }
      
      public function reset() : void
      {
         this.subAreaId = 0;
         this.rewardRate = 0;
         this.hasAnomaly = false;
         this.anomalyClosingTime = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AnomalySubareaInformation(output);
      }
      
      public function serializeAs_AnomalySubareaInformation(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeVarShort(this.rewardRate);
         output.writeBoolean(this.hasAnomaly);
         if(this.anomalyClosingTime < 0 || this.anomalyClosingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.anomalyClosingTime + ") on element anomalyClosingTime.");
         }
         output.writeVarLong(this.anomalyClosingTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AnomalySubareaInformation(input);
      }
      
      public function deserializeAs_AnomalySubareaInformation(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._rewardRateFunc(input);
         this._hasAnomalyFunc(input);
         this._anomalyClosingTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AnomalySubareaInformation(tree);
      }
      
      public function deserializeAsyncAs_AnomalySubareaInformation(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._rewardRateFunc);
         tree.addChild(this._hasAnomalyFunc);
         tree.addChild(this._anomalyClosingTimeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of AnomalySubareaInformation.subAreaId.");
         }
      }
      
      private function _rewardRateFunc(input:ICustomDataInput) : void
      {
         this.rewardRate = input.readVarShort();
      }
      
      private function _hasAnomalyFunc(input:ICustomDataInput) : void
      {
         this.hasAnomaly = input.readBoolean();
      }
      
      private function _anomalyClosingTimeFunc(input:ICustomDataInput) : void
      {
         this.anomalyClosingTime = input.readVarUhLong();
         if(this.anomalyClosingTime < 0 || this.anomalyClosingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.anomalyClosingTime + ") on element of AnomalySubareaInformation.anomalyClosingTime.");
         }
      }
   }
}
