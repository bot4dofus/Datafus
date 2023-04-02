package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.dofus.network.types.game.uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AddTaxCollectorPresetSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 969;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:uuid;
      
      public var spell:TaxCollectorOrderedSpell;
      
      private var _presetIdtree:FuncTree;
      
      private var _spelltree:FuncTree;
      
      public function AddTaxCollectorPresetSpellMessage()
      {
         this.presetId = new uuid();
         this.spell = new TaxCollectorOrderedSpell();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 969;
      }
      
      public function initAddTaxCollectorPresetSpellMessage(presetId:uuid = null, spell:TaxCollectorOrderedSpell = null) : AddTaxCollectorPresetSpellMessage
      {
         this.presetId = presetId;
         this.spell = spell;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = new uuid();
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
         this.serializeAs_AddTaxCollectorPresetSpellMessage(output);
      }
      
      public function serializeAs_AddTaxCollectorPresetSpellMessage(output:ICustomDataOutput) : void
      {
         this.presetId.serializeAs_uuid(output);
         this.spell.serializeAs_TaxCollectorOrderedSpell(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AddTaxCollectorPresetSpellMessage(input);
      }
      
      public function deserializeAs_AddTaxCollectorPresetSpellMessage(input:ICustomDataInput) : void
      {
         this.presetId = new uuid();
         this.presetId.deserialize(input);
         this.spell = new TaxCollectorOrderedSpell();
         this.spell.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AddTaxCollectorPresetSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_AddTaxCollectorPresetSpellMessage(tree:FuncTree) : void
      {
         this._presetIdtree = tree.addChild(this._presetIdtreeFunc);
         this._spelltree = tree.addChild(this._spelltreeFunc);
      }
      
      private function _presetIdtreeFunc(input:ICustomDataInput) : void
      {
         this.presetId = new uuid();
         this.presetId.deserializeAsync(this._presetIdtree);
      }
      
      private function _spelltreeFunc(input:ICustomDataInput) : void
      {
         this.spell = new TaxCollectorOrderedSpell();
         this.spell.deserializeAsync(this._spelltree);
      }
   }
}
