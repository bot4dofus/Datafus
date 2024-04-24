package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseItemRemoveOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8561;
       
      
      private var _isInitialized:Boolean = false;
      
      public var sellerId:int = 0;
      
      public function ExchangeBidHouseItemRemoveOkMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8561;
      }
      
      public function initExchangeBidHouseItemRemoveOkMessage(sellerId:int = 0) : ExchangeBidHouseItemRemoveOkMessage
      {
         this.sellerId = sellerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sellerId = 0;
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
         this.serializeAs_ExchangeBidHouseItemRemoveOkMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseItemRemoveOkMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.sellerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseItemRemoveOkMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseItemRemoveOkMessage(input:ICustomDataInput) : void
      {
         this._sellerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseItemRemoveOkMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseItemRemoveOkMessage(tree:FuncTree) : void
      {
         tree.addChild(this._sellerIdFunc);
      }
      
      private function _sellerIdFunc(input:ICustomDataInput) : void
      {
         this.sellerId = input.readInt();
      }
   }
}
