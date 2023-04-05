package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeShopStockMovementRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 882;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectId:uint = 0;
      
      public function ExchangeShopStockMovementRemovedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 882;
      }
      
      public function initExchangeShopStockMovementRemovedMessage(objectId:uint = 0) : ExchangeShopStockMovementRemovedMessage
      {
         this.objectId = objectId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectId = 0;
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
         this.serializeAs_ExchangeShopStockMovementRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockMovementRemovedMessage(output:ICustomDataOutput) : void
      {
         if(this.objectId < 0)
         {
            throw new Error("Forbidden value (" + this.objectId + ") on element objectId.");
         }
         output.writeVarInt(this.objectId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockMovementRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockMovementRemovedMessage(input:ICustomDataInput) : void
      {
         this._objectIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeShopStockMovementRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeShopStockMovementRemovedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectIdFunc);
      }
      
      private function _objectIdFunc(input:ICustomDataInput) : void
      {
         this.objectId = input.readVarUhInt();
         if(this.objectId < 0)
         {
            throw new Error("Forbidden value (" + this.objectId + ") on element of ExchangeShopStockMovementRemovedMessage.objectId.");
         }
      }
   }
}
