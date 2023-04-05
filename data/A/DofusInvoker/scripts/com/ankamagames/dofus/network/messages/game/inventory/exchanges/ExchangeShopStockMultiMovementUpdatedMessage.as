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
   
   public class ExchangeShopStockMultiMovementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4059;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectInfoList:Vector.<ObjectItemToSell>;
      
      private var _objectInfoListtree:FuncTree;
      
      public function ExchangeShopStockMultiMovementUpdatedMessage()
      {
         this.objectInfoList = new Vector.<ObjectItemToSell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4059;
      }
      
      public function initExchangeShopStockMultiMovementUpdatedMessage(objectInfoList:Vector.<ObjectItemToSell> = null) : ExchangeShopStockMultiMovementUpdatedMessage
      {
         this.objectInfoList = objectInfoList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectInfoList = new Vector.<ObjectItemToSell>();
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
         this.serializeAs_ExchangeShopStockMultiMovementUpdatedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockMultiMovementUpdatedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectInfoList.length);
         for(var _i1:uint = 0; _i1 < this.objectInfoList.length; _i1++)
         {
            (this.objectInfoList[_i1] as ObjectItemToSell).serializeAs_ObjectItemToSell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeShopStockMultiMovementUpdatedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockMultiMovementUpdatedMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItemToSell = null;
         var _objectInfoListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectInfoListLen; _i1++)
         {
            _item1 = new ObjectItemToSell();
            _item1.deserialize(input);
            this.objectInfoList.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeShopStockMultiMovementUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeShopStockMultiMovementUpdatedMessage(tree:FuncTree) : void
      {
         this._objectInfoListtree = tree.addChild(this._objectInfoListtreeFunc);
      }
      
      private function _objectInfoListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectInfoListtree.addChild(this._objectInfoListFunc);
         }
      }
      
      private function _objectInfoListFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemToSell = new ObjectItemToSell();
         _item.deserialize(input);
         this.objectInfoList.push(_item);
      }
   }
}
