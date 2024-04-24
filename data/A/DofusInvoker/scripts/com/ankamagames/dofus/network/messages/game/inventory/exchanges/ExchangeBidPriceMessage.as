package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidPriceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3774;
       
      
      private var _isInitialized:Boolean = false;
      
      public var genericId:uint = 0;
      
      public var averagePrice:Number = 0;
      
      public function ExchangeBidPriceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3774;
      }
      
      public function initExchangeBidPriceMessage(genericId:uint = 0, averagePrice:Number = 0) : ExchangeBidPriceMessage
      {
         this.genericId = genericId;
         this.averagePrice = averagePrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.genericId = 0;
         this.averagePrice = 0;
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
         this.serializeAs_ExchangeBidPriceMessage(output);
      }
      
      public function serializeAs_ExchangeBidPriceMessage(output:ICustomDataOutput) : void
      {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         output.writeVarInt(this.genericId);
         if(this.averagePrice < -9007199254740992 || this.averagePrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.averagePrice + ") on element averagePrice.");
         }
         output.writeVarLong(this.averagePrice);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidPriceMessage(input);
      }
      
      public function deserializeAs_ExchangeBidPriceMessage(input:ICustomDataInput) : void
      {
         this._genericIdFunc(input);
         this._averagePriceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidPriceMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidPriceMessage(tree:FuncTree) : void
      {
         tree.addChild(this._genericIdFunc);
         tree.addChild(this._averagePriceFunc);
      }
      
      private function _genericIdFunc(input:ICustomDataInput) : void
      {
         this.genericId = input.readVarUhInt();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ExchangeBidPriceMessage.genericId.");
         }
      }
      
      private function _averagePriceFunc(input:ICustomDataInput) : void
      {
         this.averagePrice = input.readVarLong();
         if(this.averagePrice < -9007199254740992 || this.averagePrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.averagePrice + ") on element of ExchangeBidPriceMessage.averagePrice.");
         }
      }
   }
}
