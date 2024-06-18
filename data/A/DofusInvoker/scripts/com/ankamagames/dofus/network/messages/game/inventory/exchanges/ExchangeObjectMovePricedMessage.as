package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3566;
       
      
      private var _isInitialized:Boolean = false;
      
      public var price:Number = 0;
      
      public function ExchangeObjectMovePricedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3566;
      }
      
      public function initExchangeObjectMovePricedMessage(objectUID:uint = 0, quantity:int = 0, price:Number = 0) : ExchangeObjectMovePricedMessage
      {
         super.initExchangeObjectMoveMessage(objectUID,quantity);
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.price = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ExchangeObjectMovePricedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMovePricedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMoveMessage(output);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectMovePricedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMovePricedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._priceFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectMovePricedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectMovePricedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._priceFunc);
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of ExchangeObjectMovePricedMessage.price.");
         }
      }
   }
}
