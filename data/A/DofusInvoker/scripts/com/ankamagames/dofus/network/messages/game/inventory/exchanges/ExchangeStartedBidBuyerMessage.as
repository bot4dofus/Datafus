package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.SellerBuyerDescriptor;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartedBidBuyerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4280;
       
      
      private var _isInitialized:Boolean = false;
      
      public var buyerDescriptor:SellerBuyerDescriptor;
      
      private var _buyerDescriptortree:FuncTree;
      
      public function ExchangeStartedBidBuyerMessage()
      {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4280;
      }
      
      public function initExchangeStartedBidBuyerMessage(buyerDescriptor:SellerBuyerDescriptor = null) : ExchangeStartedBidBuyerMessage
      {
         this.buyerDescriptor = buyerDescriptor;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.buyerDescriptor = new SellerBuyerDescriptor();
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
         this.serializeAs_ExchangeStartedBidBuyerMessage(output);
      }
      
      public function serializeAs_ExchangeStartedBidBuyerMessage(output:ICustomDataOutput) : void
      {
         this.buyerDescriptor.serializeAs_SellerBuyerDescriptor(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartedBidBuyerMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedBidBuyerMessage(input:ICustomDataInput) : void
      {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         this.buyerDescriptor.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartedBidBuyerMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartedBidBuyerMessage(tree:FuncTree) : void
      {
         this._buyerDescriptortree = tree.addChild(this._buyerDescriptortreeFunc);
      }
      
      private function _buyerDescriptortreeFunc(input:ICustomDataInput) : void
      {
         this.buyerDescriptor = new SellerBuyerDescriptor();
         this.buyerDescriptor.deserializeAsync(this._buyerDescriptortree);
      }
   }
}
