package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartedWithStorageMessage extends ExchangeStartedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2977;
       
      
      private var _isInitialized:Boolean = false;
      
      public var storageMaxSlot:uint = 0;
      
      public function ExchangeStartedWithStorageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2977;
      }
      
      public function initExchangeStartedWithStorageMessage(exchangeType:int = 0, storageMaxSlot:uint = 0) : ExchangeStartedWithStorageMessage
      {
         super.initExchangeStartedMessage(exchangeType);
         this.storageMaxSlot = storageMaxSlot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.storageMaxSlot = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeStartedWithStorageMessage(output);
      }
      
      public function serializeAs_ExchangeStartedWithStorageMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeStartedMessage(output);
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element storageMaxSlot.");
         }
         output.writeVarInt(this.storageMaxSlot);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartedWithStorageMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedWithStorageMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._storageMaxSlotFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartedWithStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartedWithStorageMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._storageMaxSlotFunc);
      }
      
      private function _storageMaxSlotFunc(input:ICustomDataInput) : void
      {
         this.storageMaxSlot = input.readVarUhInt();
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element of ExchangeStartedWithStorageMessage.storageMaxSlot.");
         }
      }
   }
}
