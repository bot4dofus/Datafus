package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1566;
       
      
      public var typeId:uint = 0;
      
      public var state:uint = 1;
      
      public var nextVulnerabilityDate:uint = 0;
      
      public var placementDate:uint = 0;
      
      public var rewardTokenCount:uint = 0;
      
      public function PrismInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1566;
      }
      
      public function initPrismInformation(typeId:uint = 0, state:uint = 1, nextVulnerabilityDate:uint = 0, placementDate:uint = 0, rewardTokenCount:uint = 0) : PrismInformation
      {
         this.typeId = typeId;
         this.state = state;
         this.nextVulnerabilityDate = nextVulnerabilityDate;
         this.placementDate = placementDate;
         this.rewardTokenCount = rewardTokenCount;
         return this;
      }
      
      public function reset() : void
      {
         this.typeId = 0;
         this.state = 1;
         this.nextVulnerabilityDate = 0;
         this.placementDate = 0;
         this.rewardTokenCount = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismInformation(output);
      }
      
      public function serializeAs_PrismInformation(output:ICustomDataOutput) : void
      {
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element typeId.");
         }
         output.writeByte(this.typeId);
         output.writeByte(this.state);
         if(this.nextVulnerabilityDate < 0)
         {
            throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element nextVulnerabilityDate.");
         }
         output.writeInt(this.nextVulnerabilityDate);
         if(this.placementDate < 0)
         {
            throw new Error("Forbidden value (" + this.placementDate + ") on element placementDate.");
         }
         output.writeInt(this.placementDate);
         if(this.rewardTokenCount < 0)
         {
            throw new Error("Forbidden value (" + this.rewardTokenCount + ") on element rewardTokenCount.");
         }
         output.writeVarInt(this.rewardTokenCount);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismInformation(input);
      }
      
      public function deserializeAs_PrismInformation(input:ICustomDataInput) : void
      {
         this._typeIdFunc(input);
         this._stateFunc(input);
         this._nextVulnerabilityDateFunc(input);
         this._placementDateFunc(input);
         this._rewardTokenCountFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismInformation(tree);
      }
      
      public function deserializeAsyncAs_PrismInformation(tree:FuncTree) : void
      {
         tree.addChild(this._typeIdFunc);
         tree.addChild(this._stateFunc);
         tree.addChild(this._nextVulnerabilityDateFunc);
         tree.addChild(this._placementDateFunc);
         tree.addChild(this._rewardTokenCountFunc);
      }
      
      private function _typeIdFunc(input:ICustomDataInput) : void
      {
         this.typeId = input.readByte();
         if(this.typeId < 0)
         {
            throw new Error("Forbidden value (" + this.typeId + ") on element of PrismInformation.typeId.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of PrismInformation.state.");
         }
      }
      
      private function _nextVulnerabilityDateFunc(input:ICustomDataInput) : void
      {
         this.nextVulnerabilityDate = input.readInt();
         if(this.nextVulnerabilityDate < 0)
         {
            throw new Error("Forbidden value (" + this.nextVulnerabilityDate + ") on element of PrismInformation.nextVulnerabilityDate.");
         }
      }
      
      private function _placementDateFunc(input:ICustomDataInput) : void
      {
         this.placementDate = input.readInt();
         if(this.placementDate < 0)
         {
            throw new Error("Forbidden value (" + this.placementDate + ") on element of PrismInformation.placementDate.");
         }
      }
      
      private function _rewardTokenCountFunc(input:ICustomDataInput) : void
      {
         this.rewardTokenCount = input.readVarUhInt();
         if(this.rewardTokenCount < 0)
         {
            throw new Error("Forbidden value (" + this.rewardTokenCount + ") on element of PrismInformation.rewardTokenCount.");
         }
      }
   }
}
