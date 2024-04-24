package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorPresetSpellUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4921;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:Uuid;
      
      public var taxCollectorSpells:Vector.<TaxCollectorOrderedSpell>;
      
      private var _presetIdtree:FuncTree;
      
      private var _taxCollectorSpellstree:FuncTree;
      
      public function TaxCollectorPresetSpellUpdatedMessage()
      {
         this.presetId = new Uuid();
         this.taxCollectorSpells = new Vector.<TaxCollectorOrderedSpell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4921;
      }
      
      public function initTaxCollectorPresetSpellUpdatedMessage(presetId:Uuid = null, taxCollectorSpells:Vector.<TaxCollectorOrderedSpell> = null) : TaxCollectorPresetSpellUpdatedMessage
      {
         this.presetId = presetId;
         this.taxCollectorSpells = taxCollectorSpells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = new Uuid();
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
         this.serializeAs_TaxCollectorPresetSpellUpdatedMessage(output);
      }
      
      public function serializeAs_TaxCollectorPresetSpellUpdatedMessage(output:ICustomDataOutput) : void
      {
         this.presetId.serializeAs_Uuid(output);
         output.writeShort(this.taxCollectorSpells.length);
         for(var _i2:uint = 0; _i2 < this.taxCollectorSpells.length; _i2++)
         {
            (this.taxCollectorSpells[_i2] as TaxCollectorOrderedSpell).serializeAs_TaxCollectorOrderedSpell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorPresetSpellUpdatedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorPresetSpellUpdatedMessage(input:ICustomDataInput) : void
      {
         var _item2:TaxCollectorOrderedSpell = null;
         this.presetId = new Uuid();
         this.presetId.deserialize(input);
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
         this.deserializeAsyncAs_TaxCollectorPresetSpellUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorPresetSpellUpdatedMessage(tree:FuncTree) : void
      {
         this._presetIdtree = tree.addChild(this._presetIdtreeFunc);
         this._taxCollectorSpellstree = tree.addChild(this._taxCollectorSpellstreeFunc);
      }
      
      private function _presetIdtreeFunc(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserializeAsync(this._presetIdtree);
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
