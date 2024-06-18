package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockSellRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6528;
       
      
      private var _isInitialized:Boolean = false;
      
      public var price:Number = 0;
      
      public var forSale:Boolean = false;
      
      public function PaddockSellRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6528;
      }
      
      public function initPaddockSellRequestMessage(price:Number = 0, forSale:Boolean = false) : PaddockSellRequestMessage
      {
         this.price = price;
         this.forSale = forSale;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.price = 0;
         this.forSale = false;
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
         this.serializeAs_PaddockSellRequestMessage(output);
      }
      
      public function serializeAs_PaddockSellRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
         output.writeBoolean(this.forSale);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockSellRequestMessage(input);
      }
      
      public function deserializeAs_PaddockSellRequestMessage(input:ICustomDataInput) : void
      {
         this._priceFunc(input);
         this._forSaleFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockSellRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockSellRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._priceFunc);
         tree.addChild(this._forSaleFunc);
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellRequestMessage.price.");
         }
      }
      
      private function _forSaleFunc(input:ICustomDataInput) : void
      {
         this.forSale = input.readBoolean();
      }
   }
}
