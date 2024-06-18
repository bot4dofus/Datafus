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
   
   public class TaxCollectorOrderedSpellUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2428;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public var taxCollectorSpells:Vector.<TaxCollectorOrderedSpell>;
      
      private var _taxCollectorSpellstree:FuncTree;
      
      public function TaxCollectorOrderedSpellUpdatedMessage()
      {
         this.taxCollectorSpells = new Vector.<TaxCollectorOrderedSpell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2428;
      }
      
      public function initTaxCollectorOrderedSpellUpdatedMessage(taxCollectorId:Number = 0, taxCollectorSpells:Vector.<TaxCollectorOrderedSpell> = null) : TaxCollectorOrderedSpellUpdatedMessage
      {
         this.taxCollectorId = taxCollectorId;
         this.taxCollectorSpells = taxCollectorSpells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.taxCollectorSpells = new Vector.<TaxCollectorOrderedSpell>();
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
         this.serializeAs_TaxCollectorOrderedSpellUpdatedMessage(output);
      }
      
      public function serializeAs_TaxCollectorOrderedSpellUpdatedMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
         output.writeShort(this.taxCollectorSpells.length);
         for(var _i2:uint = 0; _i2 < this.taxCollectorSpells.length; _i2++)
         {
            (this.taxCollectorSpells[_i2] as TaxCollectorOrderedSpell).serializeAs_TaxCollectorOrderedSpell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorOrderedSpellUpdatedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorOrderedSpellUpdatedMessage(input:ICustomDataInput) : void
      {
         var _item2:TaxCollectorOrderedSpell = null;
         this._taxCollectorIdFunc(input);
         var _taxCollectorSpellsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _taxCollectorSpellsLen; _i2++)
         {
            _item2 = new TaxCollectorOrderedSpell();
            _item2.deserialize(input);
            this.taxCollectorSpells.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorOrderedSpellUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorOrderedSpellUpdatedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
         this._taxCollectorSpellstree = tree.addChild(this._taxCollectorSpellstreeFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of TaxCollectorOrderedSpellUpdatedMessage.taxCollectorId.");
         }
      }
      
      private function _taxCollectorSpellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._taxCollectorSpellstree.addChild(this._taxCollectorSpellsFunc);
         }
      }
      
      private function _taxCollectorSpellsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorOrderedSpell = new TaxCollectorOrderedSpell();
         _item.deserialize(input);
         this.taxCollectorSpells.push(_item);
      }
   }
}
