package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorOrderedSpell implements INetworkType
   {
      
      public static const protocolId:uint = 4122;
       
      
      public var spellId:uint = 0;
      
      public var slot:uint = 0;
      
      public function TaxCollectorOrderedSpell()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4122;
      }
      
      public function initTaxCollectorOrderedSpell(spellId:uint = 0, slot:uint = 0) : TaxCollectorOrderedSpell
      {
         this.spellId = spellId;
         this.slot = slot;
         return this;
      }
      
      public function reset() : void
      {
         this.spellId = 0;
         this.slot = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorOrderedSpell(output);
      }
      
      public function serializeAs_TaxCollectorOrderedSpell(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarInt(this.spellId);
         if(this.slot < 0 || this.slot > 5)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         output.writeByte(this.slot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorOrderedSpell(input);
      }
      
      public function deserializeAs_TaxCollectorOrderedSpell(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._slotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorOrderedSpell(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorOrderedSpell(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._slotFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhInt();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of TaxCollectorOrderedSpell.spellId.");
         }
      }
      
      private function _slotFunc(input:ICustomDataInput) : void
      {
         this.slot = input.readByte();
         if(this.slot < 0 || this.slot > 5)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of TaxCollectorOrderedSpell.slot.");
         }
      }
   }
}
