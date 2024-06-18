package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseItemAddOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1557;
       
      
      private var _isInitialized:Boolean = false;
      
      public var itemInfo:ObjectItemToSellInBid;
      
      private var _itemInfotree:FuncTree;
      
      public function ExchangeBidHouseItemAddOkMessage()
      {
         this.itemInfo = new ObjectItemToSellInBid();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1557;
      }
      
      public function initExchangeBidHouseItemAddOkMessage(itemInfo:ObjectItemToSellInBid = null) : ExchangeBidHouseItemAddOkMessage
      {
         this.itemInfo = itemInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.itemInfo = new ObjectItemToSellInBid();
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
         this.serializeAs_ExchangeBidHouseItemAddOkMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseItemAddOkMessage(output:ICustomDataOutput) : void
      {
         this.itemInfo.serializeAs_ObjectItemToSellInBid(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseItemAddOkMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseItemAddOkMessage(input:ICustomDataInput) : void
      {
         this.itemInfo = new ObjectItemToSellInBid();
         this.itemInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseItemAddOkMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseItemAddOkMessage(tree:FuncTree) : void
      {
         this._itemInfotree = tree.addChild(this._itemInfotreeFunc);
      }
      
      private function _itemInfotreeFunc(input:ICustomDataInput) : void
      {
         this.itemInfo = new ObjectItemToSellInBid();
         this.itemInfo.deserializeAsync(this._itemInfotree);
      }
   }
}
