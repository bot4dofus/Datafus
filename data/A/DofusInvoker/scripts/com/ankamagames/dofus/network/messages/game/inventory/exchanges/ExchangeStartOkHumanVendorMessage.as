package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkHumanVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8980;
       
      
      private var _isInitialized:Boolean = false;
      
      public var sellerId:Number = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>;
      
      private var _objectsInfostree:FuncTree;
      
      public function ExchangeStartOkHumanVendorMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8980;
      }
      
      public function initExchangeStartOkHumanVendorMessage(sellerId:Number = 0, objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop> = null) : ExchangeStartOkHumanVendorMessage
      {
         this.sellerId = sellerId;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sellerId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
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
         this.serializeAs_ExchangeStartOkHumanVendorMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkHumanVendorMessage(output:ICustomDataOutput) : void
      {
         if(this.sellerId < -9007199254740992 || this.sellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element sellerId.");
         }
         output.writeDouble(this.sellerId);
         output.writeShort(this.objectsInfos.length);
         for(var _i2:uint = 0; _i2 < this.objectsInfos.length; _i2++)
         {
            (this.objectsInfos[_i2] as ObjectItemToSellInHumanVendorShop).serializeAs_ObjectItemToSellInHumanVendorShop(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkHumanVendorMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkHumanVendorMessage(input:ICustomDataInput) : void
      {
         var _item2:ObjectItemToSellInHumanVendorShop = null;
         this._sellerIdFunc(input);
         var _objectsInfosLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _objectsInfosLen; _i2++)
         {
            _item2 = new ObjectItemToSellInHumanVendorShop();
            _item2.deserialize(input);
            this.objectsInfos.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkHumanVendorMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkHumanVendorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._sellerIdFunc);
         this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
      }
      
      private function _sellerIdFunc(input:ICustomDataInput) : void
      {
         this.sellerId = input.readDouble();
         if(this.sellerId < -9007199254740992 || this.sellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element of ExchangeStartOkHumanVendorMessage.sellerId.");
         }
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
         var _item:ObjectItemToSellInHumanVendorShop = new ObjectItemToSellInHumanVendorShop();
         _item.deserialize(input);
         this.objectsInfos.push(_item);
      }
   }
}
