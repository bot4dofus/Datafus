package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantityPriceDateEffects;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeOfflineSoldItemsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4892;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bidHouseItems:Vector.<ObjectItemQuantityPriceDateEffects>;
      
      public var merchantItems:Vector.<ObjectItemQuantityPriceDateEffects>;
      
      private var _bidHouseItemstree:FuncTree;
      
      private var _merchantItemstree:FuncTree;
      
      public function ExchangeOfflineSoldItemsMessage()
      {
         this.bidHouseItems = new Vector.<ObjectItemQuantityPriceDateEffects>();
         this.merchantItems = new Vector.<ObjectItemQuantityPriceDateEffects>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4892;
      }
      
      public function initExchangeOfflineSoldItemsMessage(bidHouseItems:Vector.<ObjectItemQuantityPriceDateEffects> = null, merchantItems:Vector.<ObjectItemQuantityPriceDateEffects> = null) : ExchangeOfflineSoldItemsMessage
      {
         this.bidHouseItems = bidHouseItems;
         this.merchantItems = merchantItems;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.bidHouseItems = new Vector.<ObjectItemQuantityPriceDateEffects>();
         this.merchantItems = new Vector.<ObjectItemQuantityPriceDateEffects>();
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
         this.serializeAs_ExchangeOfflineSoldItemsMessage(output);
      }
      
      public function serializeAs_ExchangeOfflineSoldItemsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.bidHouseItems.length);
         for(var _i1:uint = 0; _i1 < this.bidHouseItems.length; _i1++)
         {
            (this.bidHouseItems[_i1] as ObjectItemQuantityPriceDateEffects).serializeAs_ObjectItemQuantityPriceDateEffects(output);
         }
         output.writeShort(this.merchantItems.length);
         for(var _i2:uint = 0; _i2 < this.merchantItems.length; _i2++)
         {
            (this.merchantItems[_i2] as ObjectItemQuantityPriceDateEffects).serializeAs_ObjectItemQuantityPriceDateEffects(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeOfflineSoldItemsMessage(input);
      }
      
      public function deserializeAs_ExchangeOfflineSoldItemsMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItemQuantityPriceDateEffects = null;
         var _item2:ObjectItemQuantityPriceDateEffects = null;
         var _bidHouseItemsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _bidHouseItemsLen; _i1++)
         {
            _item1 = new ObjectItemQuantityPriceDateEffects();
            _item1.deserialize(input);
            this.bidHouseItems.push(_item1);
         }
         var _merchantItemsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _merchantItemsLen; _i2++)
         {
            _item2 = new ObjectItemQuantityPriceDateEffects();
            _item2.deserialize(input);
            this.merchantItems.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeOfflineSoldItemsMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeOfflineSoldItemsMessage(tree:FuncTree) : void
      {
         this._bidHouseItemstree = tree.addChild(this._bidHouseItemstreeFunc);
         this._merchantItemstree = tree.addChild(this._merchantItemstreeFunc);
      }
      
      private function _bidHouseItemstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._bidHouseItemstree.addChild(this._bidHouseItemsFunc);
         }
      }
      
      private function _bidHouseItemsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemQuantityPriceDateEffects = new ObjectItemQuantityPriceDateEffects();
         _item.deserialize(input);
         this.bidHouseItems.push(_item);
      }
      
      private function _merchantItemstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._merchantItemstree.addChild(this._merchantItemsFunc);
         }
      }
      
      private function _merchantItemsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemQuantityPriceDateEffects = new ObjectItemQuantityPriceDateEffects();
         _item.deserialize(input);
         this.merchantItems.push(_item);
      }
   }
}
