package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseBuyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3820;
       
      
      private var _isInitialized:Boolean = false;
      
      public var uid:uint = 0;
      
      public var qty:uint = 0;
      
      public var price:Number = 0;
      
      public function ExchangeBidHouseBuyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3820;
      }
      
      public function initExchangeBidHouseBuyMessage(uid:uint = 0, qty:uint = 0, price:Number = 0) : ExchangeBidHouseBuyMessage
      {
         this.uid = uid;
         this.qty = qty;
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.uid = 0;
         this.qty = 0;
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeBidHouseBuyMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseBuyMessage(output:ICustomDataOutput) : void
      {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeVarInt(this.uid);
         if(this.qty < 0)
         {
            throw new Error("Forbidden value (" + this.qty + ") on element qty.");
         }
         output.writeVarInt(this.qty);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseBuyMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseBuyMessage(input:ICustomDataInput) : void
      {
         this._uidFunc(input);
         this._qtyFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseBuyMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseBuyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._uidFunc);
         tree.addChild(this._qtyFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readVarUhInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyMessage.uid.");
         }
      }
      
      private function _qtyFunc(input:ICustomDataInput) : void
      {
         this.qty = input.readVarUhInt();
         if(this.qty < 0)
         {
            throw new Error("Forbidden value (" + this.qty + ") on element of ExchangeBidHouseBuyMessage.qty.");
         }
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of ExchangeBidHouseBuyMessage.price.");
         }
      }
   }
}
