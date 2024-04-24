package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RemoveTaxCollectorOrderedSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1063;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public var slot:uint = 0;
      
      public function RemoveTaxCollectorOrderedSpellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1063;
      }
      
      public function initRemoveTaxCollectorOrderedSpellMessage(taxCollectorId:Number = 0, slot:uint = 0) : RemoveTaxCollectorOrderedSpellMessage
      {
         this.taxCollectorId = taxCollectorId;
         this.slot = slot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.slot = 0;
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
         this.serializeAs_RemoveTaxCollectorOrderedSpellMessage(output);
      }
      
      public function serializeAs_RemoveTaxCollectorOrderedSpellMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
         if(this.slot < 0)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         output.writeByte(this.slot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RemoveTaxCollectorOrderedSpellMessage(input);
      }
      
      public function deserializeAs_RemoveTaxCollectorOrderedSpellMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
         this._slotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RemoveTaxCollectorOrderedSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_RemoveTaxCollectorOrderedSpellMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
         tree.addChild(this._slotFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of RemoveTaxCollectorOrderedSpellMessage.taxCollectorId.");
         }
      }
      
      private function _slotFunc(input:ICustomDataInput) : void
      {
         this.slot = input.readByte();
         if(this.slot < 0)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of RemoveTaxCollectorOrderedSpellMessage.slot.");
         }
      }
   }
}
