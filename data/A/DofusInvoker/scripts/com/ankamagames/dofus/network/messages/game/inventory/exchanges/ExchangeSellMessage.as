package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeSellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4616;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectToSellId:uint = 0;
      
      public var quantity:uint = 0;
      
      public function ExchangeSellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4616;
      }
      
      public function initExchangeSellMessage(objectToSellId:uint = 0, quantity:uint = 0) : ExchangeSellMessage
      {
         this.objectToSellId = objectToSellId;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectToSellId = 0;
         this.quantity = 0;
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
         this.serializeAs_ExchangeSellMessage(output);
      }
      
      public function serializeAs_ExchangeSellMessage(output:ICustomDataOutput) : void
      {
         if(this.objectToSellId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToSellId + ") on element objectToSellId.");
         }
         output.writeVarInt(this.objectToSellId);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeSellMessage(input);
      }
      
      public function deserializeAs_ExchangeSellMessage(input:ICustomDataInput) : void
      {
         this._objectToSellIdFunc(input);
         this._quantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeSellMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeSellMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectToSellIdFunc);
         tree.addChild(this._quantityFunc);
      }
      
      private function _objectToSellIdFunc(input:ICustomDataInput) : void
      {
         this.objectToSellId = input.readVarUhInt();
         if(this.objectToSellId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToSellId + ") on element of ExchangeSellMessage.objectToSellId.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeSellMessage.quantity.");
         }
      }
   }
}
