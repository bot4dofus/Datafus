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
   
   public class ExchangeShopStockStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4914;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectsInfos:Vector.<ObjectItemToSell>;
      
      private var _objectsInfostree:FuncTree;
      
      public function ExchangeShopStockStartedMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemToSell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4914;
      }
      
      public function initExchangeShopStockStartedMessage(objectsInfos:Vector.<ObjectItemToSell> = null) : ExchangeShopStockStartedMessage
      {
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectsInfos = new Vector.<ObjectItemToSell>();
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
         this.serializeAs_ExchangeShopStockStartedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockStartedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectsInfos.length);
         for(var _i1:uint = 0; _i1 < this.objectsInfos.length; _i1++)
         {
            (this.objectsInfos[_i1] as ObjectItemToSell).serializeAs_ObjectItemToSell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockStartedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockStartedMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItemToSell = null;
         var _objectsInfosLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsInfosLen; _i1++)
         {
            _item1 = new ObjectItemToSell();
            _item1.deserialize(input);
            this.objectsInfos.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeShopStockStartedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeShopStockStartedMessage(tree:FuncTree) : void
      {
         this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
      }
      
      private function _objectsInfostreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectsInfostree.addChild(this._objectsInfosFunc);
         }
      }
      
      private function _objectsInfosFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemToSell = new ObjectItemToSell();
         _item.deserialize(input);
         this.objectsInfos.push(_item);
      }
   }
}
