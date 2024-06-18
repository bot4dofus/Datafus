package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseSellingUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6800;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var realPrice:Number = 0;
      
      public var buyerTag:AccountTagInformation;
      
      private var _buyerTagtree:FuncTree;
      
      public function HouseSellingUpdateMessage()
      {
         this.buyerTag = new AccountTagInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6800;
      }
      
      public function initHouseSellingUpdateMessage(houseId:uint = 0, instanceId:uint = 0, secondHand:Boolean = false, realPrice:Number = 0, buyerTag:AccountTagInformation = null) : HouseSellingUpdateMessage
      {
         this.houseId = houseId;
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.realPrice = realPrice;
         this.buyerTag = buyerTag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.instanceId = 0;
         this.secondHand = false;
         this.realPrice = 0;
         this.buyerTag = new AccountTagInformation();
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
         this.serializeAs_HouseSellingUpdateMessage(output);
      }
      
      public function serializeAs_HouseSellingUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.secondHand);
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
         }
         output.writeVarLong(this.realPrice);
         this.buyerTag.serializeAs_AccountTagInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseSellingUpdateMessage(input);
      }
      
      public function deserializeAs_HouseSellingUpdateMessage(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
         this._secondHandFunc(input);
         this._realPriceFunc(input);
         this.buyerTag = new AccountTagInformation();
         this.buyerTag.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseSellingUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseSellingUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._secondHandFunc);
         tree.addChild(this._realPriceFunc);
         this._buyerTagtree = tree.addChild(this._buyerTagtreeFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseSellingUpdateMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseSellingUpdateMessage.instanceId.");
         }
      }
      
      private function _secondHandFunc(input:ICustomDataInput) : void
      {
         this.secondHand = input.readBoolean();
      }
      
      private function _realPriceFunc(input:ICustomDataInput) : void
      {
         this.realPrice = input.readVarUhLong();
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseSellingUpdateMessage.realPrice.");
         }
      }
      
      private function _buyerTagtreeFunc(input:ICustomDataInput) : void
      {
         this.buyerTag = new AccountTagInformation();
         this.buyerTag.deserializeAsync(this._buyerTagtree);
      }
   }
}
