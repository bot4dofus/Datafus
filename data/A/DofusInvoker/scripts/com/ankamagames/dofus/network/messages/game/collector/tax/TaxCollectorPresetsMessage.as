package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorPreset;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorPresetsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3825;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presets:Vector.<TaxCollectorPreset>;
      
      private var _presetstree:FuncTree;
      
      public function TaxCollectorPresetsMessage()
      {
         this.presets = new Vector.<TaxCollectorPreset>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3825;
      }
      
      public function initTaxCollectorPresetsMessage(presets:Vector.<TaxCollectorPreset> = null) : TaxCollectorPresetsMessage
      {
         this.presets = presets;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presets = new Vector.<TaxCollectorPreset>();
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
         this.serializeAs_TaxCollectorPresetsMessage(output);
      }
      
      public function serializeAs_TaxCollectorPresetsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presets.length);
         for(var _i1:uint = 0; _i1 < this.presets.length; _i1++)
         {
            (this.presets[_i1] as TaxCollectorPreset).serializeAs_TaxCollectorPreset(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorPresetsMessage(input);
      }
      
      public function deserializeAs_TaxCollectorPresetsMessage(input:ICustomDataInput) : void
      {
         var _item1:TaxCollectorPreset = null;
         var _presetsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _presetsLen; _i1++)
         {
            _item1 = new TaxCollectorPreset();
            _item1.deserialize(input);
            this.presets.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorPresetsMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorPresetsMessage(tree:FuncTree) : void
      {
         this._presetstree = tree.addChild(this._presetstreeFunc);
      }
      
      private function _presetstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._presetstree.addChild(this._presetsFunc);
         }
      }
      
      private function _presetsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorPreset = new TaxCollectorPreset();
         _item.deserialize(input);
         this.presets.push(_item);
      }
   }
}
