package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorLootInformations extends TaxCollectorComplementaryInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7791;
       
      
      public var pods:uint = 0;
      
      public var itemsValue:Number = 0;
      
      public function TaxCollectorLootInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7791;
      }
      
      public function initTaxCollectorLootInformations(pods:uint = 0, itemsValue:Number = 0) : TaxCollectorLootInformations
      {
         this.pods = pods;
         this.itemsValue = itemsValue;
         return this;
      }
      
      override public function reset() : void
      {
         this.pods = 0;
         this.itemsValue = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorLootInformations(output);
      }
      
      public function serializeAs_TaxCollectorLootInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_TaxCollectorComplementaryInformations(output);
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element pods.");
         }
         output.writeVarInt(this.pods);
         if(this.itemsValue < 0 || this.itemsValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.itemsValue + ") on element itemsValue.");
         }
         output.writeVarLong(this.itemsValue);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorLootInformations(input);
      }
      
      public function deserializeAs_TaxCollectorLootInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._podsFunc(input);
         this._itemsValueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorLootInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorLootInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._podsFunc);
         tree.addChild(this._itemsValueFunc);
      }
      
      private function _podsFunc(input:ICustomDataInput) : void
      {
         this.pods = input.readVarUhInt();
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element of TaxCollectorLootInformations.pods.");
         }
      }
      
      private function _itemsValueFunc(input:ICustomDataInput) : void
      {
         this.itemsValue = input.readVarUhLong();
         if(this.itemsValue < 0 || this.itemsValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.itemsValue + ") on element of TaxCollectorLootInformations.itemsValue.");
         }
      }
   }
}
