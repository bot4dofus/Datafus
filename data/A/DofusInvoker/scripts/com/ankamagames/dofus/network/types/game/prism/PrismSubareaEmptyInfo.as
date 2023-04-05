package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismSubareaEmptyInfo implements INetworkType
   {
      
      public static const protocolId:uint = 2190;
       
      
      public var subAreaId:uint = 0;
      
      public var allianceId:uint = 0;
      
      public function PrismSubareaEmptyInfo()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2190;
      }
      
      public function initPrismSubareaEmptyInfo(subAreaId:uint = 0, allianceId:uint = 0) : PrismSubareaEmptyInfo
      {
         this.subAreaId = subAreaId;
         this.allianceId = allianceId;
         return this;
      }
      
      public function reset() : void
      {
         this.subAreaId = 0;
         this.allianceId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismSubareaEmptyInfo(output);
      }
      
      public function serializeAs_PrismSubareaEmptyInfo(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         output.writeVarInt(this.allianceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismSubareaEmptyInfo(input);
      }
      
      public function deserializeAs_PrismSubareaEmptyInfo(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._allianceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismSubareaEmptyInfo(tree);
      }
      
      public function deserializeAsyncAs_PrismSubareaEmptyInfo(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._allianceIdFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSubareaEmptyInfo.subAreaId.");
         }
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of PrismSubareaEmptyInfo.allianceId.");
         }
      }
   }
}
