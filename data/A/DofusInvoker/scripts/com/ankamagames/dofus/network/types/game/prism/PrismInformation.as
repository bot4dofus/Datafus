package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 65;
       
      
      public var state:uint = 1;
      
      public var placementDate:uint = 0;
      
      public var nuggetsCount:uint = 0;
      
      public var durability:uint = 0;
      
      public var nextEvolutionDate:Number = 0;
      
      public function PrismInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 65;
      }
      
      public function initPrismInformation(state:uint = 1, placementDate:uint = 0, nuggetsCount:uint = 0, durability:uint = 0, nextEvolutionDate:Number = 0) : PrismInformation
      {
         this.state = state;
         this.placementDate = placementDate;
         this.nuggetsCount = nuggetsCount;
         this.durability = durability;
         this.nextEvolutionDate = nextEvolutionDate;
         return this;
      }
      
      public function reset() : void
      {
         this.state = 1;
         this.placementDate = 0;
         this.nuggetsCount = 0;
         this.durability = 0;
         this.nextEvolutionDate = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismInformation(output);
      }
      
      public function serializeAs_PrismInformation(output:ICustomDataOutput) : void
      {
         output.writeByte(this.state);
         if(this.placementDate < 0)
         {
            throw new Error("Forbidden value (" + this.placementDate + ") on element placementDate.");
         }
         output.writeInt(this.placementDate);
         if(this.nuggetsCount < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsCount + ") on element nuggetsCount.");
         }
         output.writeVarInt(this.nuggetsCount);
         if(this.durability < 0)
         {
            throw new Error("Forbidden value (" + this.durability + ") on element durability.");
         }
         output.writeInt(this.durability);
         if(this.nextEvolutionDate < 0 || this.nextEvolutionDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.nextEvolutionDate + ") on element nextEvolutionDate.");
         }
         output.writeDouble(this.nextEvolutionDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismInformation(input);
      }
      
      public function deserializeAs_PrismInformation(input:ICustomDataInput) : void
      {
         this._stateFunc(input);
         this._placementDateFunc(input);
         this._nuggetsCountFunc(input);
         this._durabilityFunc(input);
         this._nextEvolutionDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismInformation(tree);
      }
      
      public function deserializeAsyncAs_PrismInformation(tree:FuncTree) : void
      {
         tree.addChild(this._stateFunc);
         tree.addChild(this._placementDateFunc);
         tree.addChild(this._nuggetsCountFunc);
         tree.addChild(this._durabilityFunc);
         tree.addChild(this._nextEvolutionDateFunc);
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of PrismInformation.state.");
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
      
      private function _nuggetsCountFunc(input:ICustomDataInput) : void
      {
         this.nuggetsCount = input.readVarUhInt();
         if(this.nuggetsCount < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsCount + ") on element of PrismInformation.nuggetsCount.");
         }
      }
      
      private function _durabilityFunc(input:ICustomDataInput) : void
      {
         this.durability = input.readInt();
         if(this.durability < 0)
         {
            throw new Error("Forbidden value (" + this.durability + ") on element of PrismInformation.durability.");
         }
      }
      
      private function _nextEvolutionDateFunc(input:ICustomDataInput) : void
      {
         this.nextEvolutionDate = input.readDouble();
         if(this.nextEvolutionDate < 0 || this.nextEvolutionDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.nextEvolutionDate + ") on element of PrismInformation.nextEvolutionDate.");
         }
      }
   }
}
