package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkNpcShopMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5405;
       
      
      private var _isInitialized:Boolean = false;
      
      public var npcSellerId:Number = 0;
      
      public var tokenId:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInNpcShop>;
      
      private var _objectsInfostree:FuncTree;
      
      public function ExchangeStartOkNpcShopMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5405;
      }
      
      public function initExchangeStartOkNpcShopMessage(npcSellerId:Number = 0, tokenId:uint = 0, objectsInfos:Vector.<ObjectItemToSellInNpcShop> = null) : ExchangeStartOkNpcShopMessage
      {
         this.npcSellerId = npcSellerId;
         this.tokenId = tokenId;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.npcSellerId = 0;
         this.tokenId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
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
         this.serializeAs_ExchangeStartOkNpcShopMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkNpcShopMessage(output:ICustomDataOutput) : void
      {
         if(this.npcSellerId < -9007199254740992 || this.npcSellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcSellerId + ") on element npcSellerId.");
         }
         output.writeDouble(this.npcSellerId);
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element tokenId.");
         }
         output.writeVarInt(this.tokenId);
         output.writeShort(this.objectsInfos.length);
         for(var _i3:uint = 0; _i3 < this.objectsInfos.length; _i3++)
         {
            (this.objectsInfos[_i3] as ObjectItemToSellInNpcShop).serializeAs_ObjectItemToSellInNpcShop(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkNpcShopMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkNpcShopMessage(input:ICustomDataInput) : void
      {
         var _item3:ObjectItemToSellInNpcShop = null;
         this._npcSellerIdFunc(input);
         this._tokenIdFunc(input);
         var _objectsInfosLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _objectsInfosLen; _i3++)
         {
            _item3 = new ObjectItemToSellInNpcShop();
            _item3.deserialize(input);
            this.objectsInfos.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkNpcShopMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkNpcShopMessage(tree:FuncTree) : void
      {
         tree.addChild(this._npcSellerIdFunc);
         tree.addChild(this._tokenIdFunc);
         this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
      }
      
      private function _npcSellerIdFunc(input:ICustomDataInput) : void
      {
         this.npcSellerId = input.readDouble();
         if(this.npcSellerId < -9007199254740992 || this.npcSellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcSellerId + ") on element of ExchangeStartOkNpcShopMessage.npcSellerId.");
         }
      }
      
      private function _tokenIdFunc(input:ICustomDataInput) : void
      {
         this.tokenId = input.readVarUhInt();
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element of ExchangeStartOkNpcShopMessage.tokenId.");
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
         var _item:ObjectItemToSellInNpcShop = new ObjectItemToSellInNpcShop();
         _item.deserialize(input);
         this.objectsInfos.push(_item);
      }
   }
}
