package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartedWithMultiTabStorageMessage extends ExchangeStartedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4135;
       
      
      private var _isInitialized:Boolean = false;
      
      public var storageMaxSlot:uint = 0;
      
      public var tabNumber:uint = 0;
      
      public function ExchangeStartedWithMultiTabStorageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4135;
      }
      
      public function initExchangeStartedWithMultiTabStorageMessage(exchangeType:int = 0, storageMaxSlot:uint = 0, tabNumber:uint = 0) : ExchangeStartedWithMultiTabStorageMessage
      {
         super.initExchangeStartedMessage(exchangeType);
         this.storageMaxSlot = storageMaxSlot;
         this.tabNumber = tabNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.storageMaxSlot = 0;
         this.tabNumber = 0;
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
         this.serializeAs_ExchangeStartedWithMultiTabStorageMessage(output);
      }
      
      public function serializeAs_ExchangeStartedWithMultiTabStorageMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeStartedMessage(output);
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element storageMaxSlot.");
         }
         output.writeVarInt(this.storageMaxSlot);
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element tabNumber.");
         }
         output.writeVarInt(this.tabNumber);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartedWithMultiTabStorageMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedWithMultiTabStorageMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._storageMaxSlotFunc(input);
         this._tabNumberFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartedWithMultiTabStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartedWithMultiTabStorageMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._storageMaxSlotFunc);
         tree.addChild(this._tabNumberFunc);
      }
      
      private function _storageMaxSlotFunc(input:ICustomDataInput) : void
      {
         this.storageMaxSlot = input.readVarUhInt();
         if(this.storageMaxSlot < 0)
         {
            throw new Error("Forbidden value (" + this.storageMaxSlot + ") on element of ExchangeStartedWithMultiTabStorageMessage.storageMaxSlot.");
         }
      }
      
      private function _tabNumberFunc(input:ICustomDataInput) : void
      {
         this.tabNumber = input.readVarUhInt();
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of ExchangeStartedWithMultiTabStorageMessage.tabNumber.");
         }
      }
   }
}
