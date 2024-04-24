package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseBuyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3428;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var bought:Boolean = false;
      
      public var realPrice:Number = 0;
      
      public function HouseBuyResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3428;
      }
      
      public function initHouseBuyResultMessage(houseId:uint = 0, instanceId:uint = 0, secondHand:Boolean = false, bought:Boolean = false, realPrice:Number = 0) : HouseBuyResultMessage
      {
         this.houseId = houseId;
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.bought = bought;
         this.realPrice = realPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.instanceId = 0;
         this.secondHand = false;
         this.bought = false;
         this.realPrice = 0;
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
         this.serializeAs_HouseBuyResultMessage(output);
      }
      
      public function serializeAs_HouseBuyResultMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.secondHand);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.bought);
         output.writeByte(_box0);
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
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
         }
         output.writeVarLong(this.realPrice);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseBuyResultMessage(input);
      }
      
      public function deserializeAs_HouseBuyResultMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
         this._realPriceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseBuyResultMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseBuyResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._realPriceFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.secondHand = BooleanByteWrapper.getFlag(_box0,0);
         this.bought = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseBuyResultMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseBuyResultMessage.instanceId.");
         }
      }
      
      private function _realPriceFunc(input:ICustomDataInput) : void
      {
         this.realPrice = input.readVarUhLong();
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element of HouseBuyResultMessage.realPrice.");
         }
      }
   }
}
