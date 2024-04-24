package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1987;
       
      
      public var houseId:uint = 0;
      
      public var modelId:uint = 0;
      
      public function HouseInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1987;
      }
      
      public function initHouseInformations(houseId:uint = 0, modelId:uint = 0) : HouseInformations
      {
         this.houseId = houseId;
         this.modelId = modelId;
         return this;
      }
      
      public function reset() : void
      {
         this.houseId = 0;
         this.modelId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformations(output);
      }
      
      public function serializeAs_HouseInformations(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         output.writeVarShort(this.modelId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformations(input);
      }
      
      public function deserializeAs_HouseInformations(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._modelIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseInformations(tree);
      }
      
      public function deserializeAsyncAs_HouseInformations(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._modelIdFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformations.houseId.");
         }
      }
      
      private function _modelIdFunc(input:ICustomDataInput) : void
      {
         this.modelId = input.readVarUhShort();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformations.modelId.");
         }
      }
   }
}
