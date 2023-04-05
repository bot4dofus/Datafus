package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeShopStockMovementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9464;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectInfo:ObjectItemToSell;
      
      private var _objectInfotree:FuncTree;
      
      public function ExchangeShopStockMovementUpdatedMessage()
      {
         this.objectInfo = new ObjectItemToSell();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9464;
      }
      
      public function initExchangeShopStockMovementUpdatedMessage(objectInfo:ObjectItemToSell = null) : ExchangeShopStockMovementUpdatedMessage
      {
         this.objectInfo = objectInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectInfo = new ObjectItemToSell();
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
         this.serializeAs_ExchangeShopStockMovementUpdatedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockMovementUpdatedMessage(output:ICustomDataOutput) : void
      {
         this.objectInfo.serializeAs_ObjectItemToSell(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockMovementUpdatedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockMovementUpdatedMessage(input:ICustomDataInput) : void
      {
         this.objectInfo = new ObjectItemToSell();
         this.objectInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeShopStockMovementUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeShopStockMovementUpdatedMessage(tree:FuncTree) : void
      {
         this._objectInfotree = tree.addChild(this._objectInfotreeFunc);
      }
      
      private function _objectInfotreeFunc(input:ICustomDataInput) : void
      {
         this.objectInfo = new ObjectItemToSell();
         this.objectInfo.deserializeAsync(this._objectInfotree);
      }
   }
}
