package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RemoveTaxCollectorPresetSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5781;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:Uuid;
      
      public var slot:uint = 0;
      
      private var _presetIdtree:FuncTree;
      
      public function RemoveTaxCollectorPresetSpellMessage()
      {
         this.presetId = new Uuid();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5781;
      }
      
      public function initRemoveTaxCollectorPresetSpellMessage(presetId:Uuid = null, slot:uint = 0) : RemoveTaxCollectorPresetSpellMessage
      {
         this.presetId = presetId;
         this.slot = slot;
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
         this.serializeAs_RemoveTaxCollectorPresetSpellMessage(output);
      }
      
      public function serializeAs_RemoveTaxCollectorPresetSpellMessage(output:ICustomDataOutput) : void
      {
         this.presetId.serializeAs_Uuid(output);
         if(this.slot < 0)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         output.writeByte(this.slot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RemoveTaxCollectorPresetSpellMessage(input);
      }
      
      public function deserializeAs_RemoveTaxCollectorPresetSpellMessage(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserialize(input);
         this._slotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RemoveTaxCollectorPresetSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_RemoveTaxCollectorPresetSpellMessage(tree:FuncTree) : void
      {
         this._presetIdtree = tree.addChild(this._presetIdtreeFunc);
         tree.addChild(this._slotFunc);
      }
      
      private function _presetIdtreeFunc(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserializeAsync(this._presetIdtree);
      }
      
      private function _slotFunc(input:ICustomDataInput) : void
      {
         this.slot = input.readByte();
         if(this.slot < 0)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of RemoveTaxCollectorPresetSpellMessage.slot.");
         }
      }
   }
}
