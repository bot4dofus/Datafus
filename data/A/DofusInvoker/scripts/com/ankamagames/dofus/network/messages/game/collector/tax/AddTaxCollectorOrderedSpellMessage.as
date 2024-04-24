package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AddTaxCollectorOrderedSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3303;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public var spell:TaxCollectorOrderedSpell;
      
      private var _spelltree:FuncTree;
      
      public function AddTaxCollectorOrderedSpellMessage()
      {
         this.spell = new TaxCollectorOrderedSpell();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3303;
      }
      
      public function initAddTaxCollectorOrderedSpellMessage(taxCollectorId:Number = 0, spell:TaxCollectorOrderedSpell = null) : AddTaxCollectorOrderedSpellMessage
      {
         this.taxCollectorId = taxCollectorId;
         this.spell = spell;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.spell = new TaxCollectorOrderedSpell();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AddTaxCollectorOrderedSpellMessage(output);
      }
      
      public function serializeAs_AddTaxCollectorOrderedSpellMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
         this.spell.serializeAs_TaxCollectorOrderedSpell(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AddTaxCollectorOrderedSpellMessage(input);
      }
      
      public function deserializeAs_AddTaxCollectorOrderedSpellMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
         this.spell = new TaxCollectorOrderedSpell();
         this.spell.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AddTaxCollectorOrderedSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_AddTaxCollectorOrderedSpellMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
         this._spelltree = tree.addChild(this._spelltreeFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of AddTaxCollectorOrderedSpellMessage.taxCollectorId.");
         }
      }
      
      private function _spelltreeFunc(input:ICustomDataInput) : void
      {
         this.spell = new TaxCollectorOrderedSpell();
         this.spell.deserializeAsync(this._spelltree);
      }
   }
}
