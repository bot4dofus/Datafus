package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristics;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorPreset implements INetworkType
   {
      
      public static const protocolId:uint = 1854;
       
      
      public var presetId:Uuid;
      
      public var spells:Vector.<TaxCollectorOrderedSpell>;
      
      public var characteristics:CharacterCharacteristics;
      
      private var _presetIdtree:FuncTree;
      
      private var _spellstree:FuncTree;
      
      private var _characteristicstree:FuncTree;
      
      public function TaxCollectorPreset()
      {
         this.presetId = new Uuid();
         this.spells = new Vector.<TaxCollectorOrderedSpell>();
         this.characteristics = new CharacterCharacteristics();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1854;
      }
      
      public function initTaxCollectorPreset(presetId:Uuid = null, spells:Vector.<TaxCollectorOrderedSpell> = null, characteristics:CharacterCharacteristics = null) : TaxCollectorPreset
      {
         this.presetId = presetId;
         this.spells = spells;
         this.characteristics = characteristics;
         return this;
      }
      
      public function reset() : void
      {
         this.presetId = new Uuid();
         this.characteristics = new CharacterCharacteristics();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorPreset(output);
      }
      
      public function serializeAs_TaxCollectorPreset(output:ICustomDataOutput) : void
      {
         this.presetId.serializeAs_Uuid(output);
         output.writeShort(this.spells.length);
         for(var _i2:uint = 0; _i2 < this.spells.length; _i2++)
         {
            (this.spells[_i2] as TaxCollectorOrderedSpell).serializeAs_TaxCollectorOrderedSpell(output);
         }
         this.characteristics.serializeAs_CharacterCharacteristics(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorPreset(input);
      }
      
      public function deserializeAs_TaxCollectorPreset(input:ICustomDataInput) : void
      {
         var _item2:TaxCollectorOrderedSpell = null;
         this.presetId = new Uuid();
         this.presetId.deserialize(input);
         var _spellsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _spellsLen; _i2++)
         {
            _item2 = new TaxCollectorOrderedSpell();
            _item2.deserialize(input);
            this.spells.push(_item2);
         }
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorPreset(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorPreset(tree:FuncTree) : void
      {
         this._presetIdtree = tree.addChild(this._presetIdtreeFunc);
         this._spellstree = tree.addChild(this._spellstreeFunc);
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
      }
      
      private function _presetIdtreeFunc(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserializeAsync(this._presetIdtree);
      }
      
      private function _spellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellstree.addChild(this._spellsFunc);
         }
      }
      
      private function _spellsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorOrderedSpell = new TaxCollectorOrderedSpell();
         _item.deserialize(input);
         this.spells.push(_item);
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserializeAsync(this._characteristicstree);
      }
   }
}
