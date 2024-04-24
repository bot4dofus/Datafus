package com.ankamagames.dofus.network.messages.game.presets
{
   import com.ankamagames.dofus.network.types.game.presets.ItemForPreset;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ItemForPresetUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1555;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:int = 0;
      
      public var presetItem:ItemForPreset;
      
      private var _presetItemtree:FuncTree;
      
      public function ItemForPresetUpdateMessage()
      {
         this.presetItem = new ItemForPreset();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1555;
      }
      
      public function initItemForPresetUpdateMessage(presetId:int = 0, presetItem:ItemForPreset = null) : ItemForPresetUpdateMessage
      {
         this.presetId = presetId;
         this.presetItem = presetItem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = 0;
         this.presetItem = new ItemForPreset();
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
         this.serializeAs_ItemForPresetUpdateMessage(output);
      }
      
      public function serializeAs_ItemForPresetUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.presetId);
         this.presetItem.serializeAs_ItemForPreset(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ItemForPresetUpdateMessage(input);
      }
      
      public function deserializeAs_ItemForPresetUpdateMessage(input:ICustomDataInput) : void
      {
         this._presetIdFunc(input);
         this.presetItem = new ItemForPreset();
         this.presetItem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ItemForPresetUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_ItemForPresetUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._presetIdFunc);
         this._presetItemtree = tree.addChild(this._presetItemtreeFunc);
      }
      
      private function _presetIdFunc(input:ICustomDataInput) : void
      {
         this.presetId = input.readShort();
      }
      
      private function _presetItemtreeFunc(input:ICustomDataInput) : void
      {
         this.presetItem = new ItemForPreset();
         this.presetItem.deserializeAsync(this._presetItemtree);
      }
   }
}
